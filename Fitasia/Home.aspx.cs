using Fitasia.logic;
using Fitasia.security;
using Subgurim.Controles;
using Subgurim.Controles.GoogleChartIconMaker;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace Fitasia
{
    public partial class Home : FormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Header.DataBind();

            if (!IsPostBack)
            {
                ViewState["Activities"] = new List<string>();
                LoadGMap();
                LoadBestOffers();
            }

            User u = (User)Session["LoggedUser"];
            if (u != null)
            {
                TxtName.Text = u.Name;
                TxtEmail.Text = u.Email;
            }
        }

        /* Loads 3 best offers into a listView */
        protected void LoadBestOffers()
        {
            using (FitasiaDataDataContext db = new FitasiaDataDataContext())
            {
                var list = (from t in db.Products
                            orderby t.Price
                            select t).Take(3);
                OfferView.DataSource = list;
                OfferView.DataBind();
            }
        }

        /* Loads GMAP interface*/
        protected void LoadGMap()
        {
            GLatLng mainLocation;
            mainLocation = new GLatLng(56.029394, 14.156678); //Kristianstad

            GMap1.setCenter(mainLocation, 8);
            GMap1.enableDoubleClickZoom = true;

            List<string> tags = ((List<string>)ViewState["Activities"]);
            List<Gym> gyms = searchByCriterion(tags);

            /* WIP - Will be used for benefits
            foreach(Gym gym in gyms)
            {
                GymActivity ga;
            }
            */

            GControl control = new GControl(GControl.preBuilt.LargeMapControl);
            GControl control2 = new GControl(GControl.preBuilt.MenuMapTypeControl, new GControlPosition(GControlPosition.position.Top_Right));

            GMap1.Add(control);
            GMap1.Add(control2);

            GMap1.Add(new GControl(GControl.preBuilt.GOverviewMapControl, new GControlPosition(GControlPosition.position.Bottom_Left)));

            PinIcon p;
            GMarker gm;
            GInfoWindow win;
            foreach (var i in gyms)
            {
                p = new PinIcon(PinIcons.sport, Color.Violet);
                gm = new GMarker(new GLatLng(double.Parse(i.LocLa, CultureInfo.InvariantCulture), double.Parse(i.LocLo, CultureInfo.InvariantCulture)), new GMarkerOptions(new GIcon(p.ToString(), p.Shadow())));
                win = new GInfoWindow(gm, i.Name + "<br/>" + i.Details +
                    "<br/> <a href='" + i.URL + "'>Website</a>", false, GListener.Event.click);
                GMap1.Add(win);
            }
        }

        /* Returns a list of offers based on search criteria */
        protected List<Gym> searchByCriterion(List<string> tags)
        {
            using (FitasiaDataDataContext db = new FitasiaDataDataContext())
            {
                /*
                      //Will match containing at least one tag 
                    return db.ExecuteQuery<Gym>("SELECT g.Id, g.Name, g.LocLa, g.LocLo, g.Details, g.URL, g.AddressID, g.Image
                    + "FROM GYM g"
                    + "JOIN GYMACTIVITY ga ON ga.GymID = g.Id"
                    + "JOIN ACTIVITY a ON a.Id = ga.ActivityID"
                    + "JOIN ADDRESS ad ON ad.Id = g.AddressID"
                    + "WHERE a.Name IN('Bodybuilding', 'Swimming')"
                    + "AND g.Name LIKE '%%'"
                    + "AND(ad.City LIKE '%Kristianstad%' OR ad.Street LIKE '%%'OR ad.PostalCode LIKE '%%')"
                    + "GROUP BY g.Id, g.Name, g.LocLa, g.LocLo, g.Details, g.URL, g.AddressID, g.Image"
                    + "HAVING COUNT(DISTINCT a.Name) = 1");
                 */

                /* Will match containing at least one tag */
                List<Gym> gyms = (from gym in db.Gyms
                                  join ga in db.GymActivities on gym.Id equals ga.GymID
                                  join act in db.Activities on ga.GymID equals act.Id
                                  //search for activities
                                  //where tags.Contains(act.Name)
                                  where gym.Address.City.Contains(TxtArea.Text)
                                  && gym.Name.Contains(TxtSearch.Text)
                                  select gym).Distinct().ToList();
                GymRepeater.DataSource = gyms;
                GymRepeater.DataBind();
                return gyms;
            }
        }

        /* Password has to be hashed with salt in order to maintain security */
        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            using (FitasiaDataDataContext context = new FitasiaDataDataContext())
            {
                if (context.Users.SingleOrDefault(p => p.Email == TxtEmail.Text) == null)
                {
                    User newUser = new Fitasia.User();
                    newUser.Email = TxtEmail.Text;
                    newUser.Name = TxtName.Text;
                    newUser.Surname = TxtSurname.Text;
                    newUser.Role = "user";

                    string salt = MyCrypto.CreateSalt(8);
                    string hashedPass = MyCrypto.GenerateSHA256(TxtPwd.Text, salt);
                    newUser.Password = hashedPass;
                    newUser.Salt = salt;


                    Guid activationCode = Guid.NewGuid();
                    UserActivation newActiv = new UserActivation();
                    newActiv.User = newUser;
                    newActiv.ActivationCode = activationCode;

                    context.Users.InsertOnSubmit(newUser);
                    context.UserActivations.InsertOnSubmit(newActiv);

                    context.SubmitChanges();
                    SendActivationEmail(newUser, activationCode);

                    reg.Controls.Add(new Label() { CssClass = "warning", Text = "User successfully registered, an email with activation link has been sent to your email address." });
                    ClearRegForm();
                }
                else
                {
                    reg.Controls.Add(new Label() { CssClass = "warning", Text = "User with this email already exists" });
                }
            }
        }

        /* Sends an activation email with generated code*/
        private void SendActivationEmail(User user, Guid activationCode)
        {
            using (MailMessage mm = new MailMessage("Practicaltester@gmail.com", user.Email))
            {
                mm.Subject = "Account Activation";
                string body = "Hello " + user.Name.Trim() + ",";
                body += "<br /><br />Please click the following link to activate your account";
                body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Home.aspx", "ActivationPage.aspx?ActivationCode=" + activationCode) + "'>Click here to activate your account.</a>";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("Practicaltester@gmail.com", "826451379");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
        }

        /* Clears the registration form */
        private void ClearRegForm()
        {
            TxtEmail.Text = "";
            TxtName.Text = "";
            TxtSurname.Text = "";
            TxtPwd.Text = "";
            TxtPwda.Text = "";
        }

        /* Redirects to a purchase page */
        protected void BtnPurchase_Click(object sender, CommandEventArgs e)
        {
            Response.Redirect("~/Checkout.aspx?prod=" + e.CommandArgument);
        }

        /* Executes a GMAP update and calls a script to open search results */
        protected void TxtSearch_TextChanged(object sender, EventArgs e)
        {
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "hideSearch", "hideSearch();", true);
            GMap1.reset();
            LoadGMap();
        }

        /* Removes a tag from search */
        protected void BtnRemove_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            List<string> list = ((List<string>)ViewState["Activities"]);
            list.Remove(((ImageButton)sender).CommandArgument);
            GMap1.reset();
            LoadGMap();
            reloadActivityList(list);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "hideSearch", "hideSearch();", true);
        }

        /* Adds a tag into search */
        protected void BtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            List<string> list = ((List<string>)ViewState["Activities"]);
            list.Add(TxtActivity.Text);
            reloadActivityList(list);
            GMap1.reset();
            LoadGMap();
            TxtActivity.Text = String.Empty;
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "hideSearch", "hideSearch();", true);
        }

        /* Reloads activity list with an updated one */
        protected void reloadActivityList(List<string> list)
        {
            ViewState["Activities"] = list;
            ActivityList.DataSource = list;
            ActivityList.DataBind();
        }

        /* Process fields and request email sending */
        protected void BtnSend_Click(object sender, EventArgs e)
        {
            string email = TxtEmailC.Text.Trim();
            string name = TxtNameC.Text.Trim();
            string topic = TxtTopicC.Text;
            string text = TxtInputC.Text;

            SendContactEmail(email, name, topic, text);
            clearFields();
            LblMessageC.Text = "A message was sent, thank you for your response";

            LblMessageC.Visible = true;
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        }

        /* Send contact email */
        protected void SendContactEmail(String email, String name, String topic, String text)
        {
            using (MailMessage mm = new MailMessage("Practicaltester@gmail.com", "Fitasiaserviceteam@gmail.com"))
            {
                mm.Subject = "Account Activation";
                string body = "Message from " + name + ",";
                body += text;
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true; //email: fitasiaserviceteam@gmail.com - 123456789abcdE
                NetworkCredential NetworkCred = new NetworkCredential("Practicaltester@gmail.com", "826451379");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
        }

        /* Clears fields for contact list*/
        protected void clearFields()
        {
            TxtInputC.Text = "";
            TxtTopicC.Text = "";
        }
    }


}