using Fitasia.security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace Fitasia
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                
            }
            else if (Request.Cookies["selectedLanguage"] != null)
            {
                LanguageChooser.SelectedValue = Request.Cookies["selectedLanguage"].Value;
                
            }
            if (!IsPostBack)
            {
                ChangeMenubar();
            }
        }

        protected void ChangeMenubar()
        {
            List<MenuItem> menuItems = new List<MenuItem>();
            if (Session["LoggedUser"] != null)
            {
                MenuItem LoggedAs = new MenuItem();
                LoggedAs.ImageUrl = "https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_settings_48px-128.png";
                LoggedAs.Text = ((User)Session["LoggedUser"]).Name;
                if (((User)Session["LoggedUser"]).Role == "admin")
                {
                    LoggedAs.NavigateUrl = "~/AdminPage.aspx";
                }
                else
                {
                    LoggedAs.NavigateUrl = "~/UserPage.aspx";
                }

                MenuItem Logout = new MenuItem()
                {
                    Value = "Logout"
                };
                Logout.Text = GetLocalResourceObject("Logout.Text").ToString();
                menuItems.Add(LoggedAs);
                menuItems.Add(Logout);
            }
            else
            {
                MenuItem Login = new MenuItem() { Value = "Login", NavigateUrl = "#" };
                MenuItem Register = new MenuItem()
                {
                    NavigateUrl = "~/Home.aspx",
                    Value = "Home"
                };
                Register.Text = GetLocalResourceObject("Register.Text").ToString();
                Login.Text = GetLocalResourceObject("Login.Text").ToString();
                menuItems.Add(Login);
                menuItems.Add(Register);
            }
            foreach (MenuItem i in menuItems) Menubar.Items.Add(i);
        }

        protected void Menubar_MenuItemClick(object sender, MenuEventArgs e)
        {
            switch (e.Item.Value)
            {
                case "Logout":
                    Session.Abandon();
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/LogoutPage.aspx");
                    break;
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (FitasiaDataDataContext context = new FitasiaDataDataContext())
                {
                    User logged = context.Users.SingleOrDefault(p => p.Email == TxtLoginMain.Text);
                    Session["LoggedUser"] = logged;
                    Session["LoggedId"] = logged.Id;
                    Menubar.Items.RemoveAt(Menubar.Items.Count - 1);
                    Menubar.Items.RemoveAt(Menubar.Items.Count - 1);
                    ChangeMenubar();
                    System.Web.UI.ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'> CloseDiv();</script>", false);
                }
            }
        }

        protected void BtnClose_Click(object sender, EventArgs e)
        {
            PnlLogin.Visible = false;
        }

        protected void LanguageChooser_SelectedIndexChanged(object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("selectedLanguage");
            cookie.Value = LanguageChooser.SelectedItem.Value;
            Response.SetCookie(cookie);
            Response.Redirect(Request.RawUrl);
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            using (FitasiaDataDataContext context = new FitasiaDataDataContext())
            {
                User logged = context.Users.SingleOrDefault(p => p.Email == TxtLoginMain.Text);
                if (logged != null)
                {
                    UserActivation ac = context.UserActivations.SingleOrDefault(p => p.UserId == logged.Id);
                    if (ac == null)
                    {
                        string salt = logged.Salt;
                        string hashedPass = MyCrypto.GenerateSHA256(TxtLoginPass.Text, salt);
                        if (logged.Password == hashedPass)
                        {
                            args.IsValid = true;
                            return;
                        }
                    }
                }
            }
            args.IsValid = false;
        }
    }
}