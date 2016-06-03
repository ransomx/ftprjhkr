using Fitasia.logic;
using System;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web.UI.WebControls;

namespace Fitasia
{
    public partial class Checkout : FormBase
    {
        private Product selectedProduct;
        private User currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            currentUser = (User)Session["LoggedUser"];
            int id = Convert.ToInt32(Request.QueryString["prod"]);
            selectedProduct = new FitasiaDataDataContext().Products.SingleOrDefault(i => i.Id == id);
            LblTitle.Text = selectedProduct.Title;
            LblDuration.Text = selectedProduct.Duration.ToString() + " Days";
            LblDetails.Text = selectedProduct.Description;
            LblPrice.Text = selectedProduct.Price.ToString();

            if (!IsPostBack)
            {
                if (this.SelectedDate == DateTime.MinValue)
                {
                    this.PopulateYear();
                    this.PopulateMonth();
                }
            }
            if (currentUser == null)
            {
                AddressList.Visible = false;
                LblSavedAddress.Visible = false;
            }
        }

        protected void CheckBoxList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void RadioBListPayment_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void AddressList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (AddressList.SelectedItem.Value != "none")
            {
                FitasiaDataDataContext context = new FitasiaDataDataContext();
                Address a = context.Addresses.SingleOrDefault(
                    i => i.Id == Convert.ToInt32(AddressList.SelectedItem.Value));
                TxtCity.Text = a.City;
                TxtPostal.Text = a.PostalCode;
                TxtStreet.Text = a.Street;
                TxtName.Text = a.User.Name;
                TxtSurname.Text = a.User.Surname;
            }
            else
            {
                TxtCity.Text = "";
                TxtPostal.Text = "";
                TxtStreet.Text = "";
                TxtName.Text = "";
                TxtSurname.Text = "";
            }
        }

        /* Order creation - REPLACED */
        protected void BtnProceed_Click(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] == null) { }
            else
            {
                using (FitasiaDataDataContext context = new FitasiaDataDataContext())
                {
                    Order order = new Order();

                    Address toSend = null;
                    if (AddressList.SelectedIndex == 0)
                    {
                        toSend = new Address();
                        toSend.City = TxtCity.Text;
                        toSend.Street = TxtStreet.Text;
                        toSend.PostalCode = TxtPostal.Text;
                        toSend.UserId = currentUser.Id;
                        context.Addresses.InsertOnSubmit(toSend);
                        context.SubmitChanges();
                    }
                    else
                        toSend = context.Addresses.SingleOrDefault(
                        i => i.Id == Convert.ToInt32(AddressList.SelectedItem.Value));

                    order.AddressId = toSend.Id;
                    order.ProductId = selectedProduct.Id;
                    order.UserId = currentUser.Id;
                    order.Date = DateTime.Now;
                    //order.Payment;

                    context.Orders.InsertOnSubmit(order);
                    context.SubmitChanges();

                    Response.Redirect("~/PaymentConfirmation.aspx?order=" + order.Id);
                }
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = CheckBoxAgree.Checked;
        }

        private int Month
        {
            get
            {
                return int.Parse(ddlMonth.SelectedItem.Value);
            }
            set
            {
                this.PopulateMonth();
                ddlMonth.ClearSelection();
                ddlMonth.Items.FindByValue(value.ToString()).Selected = true;
            }
        }
        private int Year
        {
            get
            {
                return int.Parse(ddlYear.SelectedItem.Value);
            }
            set
            {
                this.PopulateYear();
                ddlYear.ClearSelection();
                ddlYear.Items.FindByValue(value.ToString()).Selected = true;
            }
        }

        public DateTime SelectedDate
        {
            get
            {
                try
                {
                    return DateTime.Parse(this.Month + "/" + "/" + this.Year);
                }
                catch
                {
                    return DateTime.MinValue;
                }
            }
            set
            {
                if (!value.Equals(DateTime.MinValue))
                {
                    this.Year = value.Year;
                    this.Month = value.Month;
                }
            }
        }

        private void PopulateMonth()
        {
            ddlMonth.Items.Clear();
            ListItem lt = new ListItem();
            lt.Text = "MM";
            lt.Value = "0";
            ddlMonth.Items.Add(lt);
            for (int i = 1; i <= 12; i++)
            {
                lt = new ListItem();
                lt.Text = Convert.ToDateTime(i.ToString() + "/1/1900").ToString("MMMM");
                lt.Value = i.ToString();
                ddlMonth.Items.Add(lt);
            }
            ddlMonth.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
        }

        private void PopulateYear()
        {
            ddlYear.Items.Clear();
            ListItem lt = new ListItem();
            lt.Text = "YYYY";
            lt.Value = "0";
            ddlYear.Items.Add(lt);
            for (int i = DateTime.Now.Year + 8; i >= DateTime.Now.Year; i--)
            {
                lt = new ListItem();
                lt.Text = i.ToString();
                lt.Value = i.ToString();
                ddlYear.Items.Add(lt);
            }
            ddlYear.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["payment_amt"] = LblPrice.Text;
            Session["product_id"] = selectedProduct.Id;
            Session["store_address"] = SaveAddressCheckBox.Checked ? true : false;
            Response.Redirect("/CheckoutStart.aspx");
        }

        protected void SendPurchaseConfirmation(Order o)
        {
            using (MailMessage mm = new MailMessage("Practicaltester@gmail.com", o.User.Email))
            {
                mm.Subject = "Account Activation";
                string body = "Hello " + o.User.Name.Trim() + ",";
                body += "<br /><h3>Your purchase of "+o.Product.Title+" has been successfuly made!</h3>";
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
    }
}