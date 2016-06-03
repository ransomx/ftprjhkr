using Fitasia.logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fitasia
{
    public partial class PaymentConfirmation : FormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NVPAPICaller payPalCaller = new NVPAPICaller();

                string retMsg = "";
                string token = "";
                string PayerID = "";
                NVPCodec decoder = new NVPCodec();
                token = Session["token"].ToString();
                var myOrder = new Order();
                Address toSend = new Address();
                bool ret = payPalCaller.GetCheckoutDetails(token, ref PayerID, ref decoder, ref retMsg);
                if (ret)
                {
                    Session["payerId"] = PayerID;

                    using (FitasiaDataDataContext db = new FitasiaDataDataContext())
                    {
                        myOrder.Date = Convert.ToDateTime(decoder["TIMESTAMP"].ToString());
                        myOrder.UserId = Int32.Parse(Session["LoggedId"].ToString());
                        myOrder.ProductId = Int32.Parse(Session["product_id"].ToString());

                        //test existing address
                        toSend = (from ad in db.Addresses
                                where ad.City == decoder["SHIPTOCITY"].ToString()
                                && ad.Street == decoder["SHIPTOSTREET"].ToString()
                                && ad.PostalCode == decoder["SHIPTOZIP"].ToString()
                                && ad.UserId == myOrder.UserId
                                select ad).FirstOrDefault();
                        if(toSend == null)
                        {
                            using (FitasiaDataDataContext dc = new FitasiaDataDataContext())
                            {
                                toSend.Street = decoder["SHIPTOSTREET"].ToString();
                                toSend.City = decoder["SHIPTOCITY"].ToString();
                                toSend.PostalCode = decoder["SHIPTOZIP"].ToString();
                                toSend.UserId = myOrder.UserId;
                                dc.Addresses.InsertOnSubmit(toSend);
                                dc.SubmitChanges();
                            }
                        }
                        myOrder.AddressId = toSend.Id;

                        db.Orders.InsertOnSubmit(myOrder);
                        db.SubmitChanges();
                    }
                }

                Session["currentOrderId"] = myOrder.Id;

                // Display Order information.
                City.Text = toSend.City;
                Address.Text = toSend.Street;
                PostalCode.Text = toSend.PostalCode;
                Total.Text = Session["payment_amt"].ToString();
            }
        }

        protected void CheckoutConfirm_Click(object sender, EventArgs e)
        {
            Session["userCheckoutCompleted"] = "true";
            Response.Redirect("~/CheckoutComplete.aspx");
        }
    }
}