using System;
using System.Linq;


namespace Fitasia
{
  public partial class CheckoutComplete : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        // Verify user has completed the checkout process.
        if ((string)Session["userCheckoutCompleted"] != "true")
        {
          Session["userCheckoutCompleted"] = string.Empty;
          Response.Redirect("CheckoutError.aspx?" + "Desc=Unvalidated%20Checkout.");
        }

        NVPAPICaller payPalCaller = new NVPAPICaller();

        string retMsg = "";
        string token = "";
        string finalPaymentAmount = "";
        string PayerID = "";
        NVPCodec decoder = new NVPCodec();

        token = Session["token"].ToString();
        PayerID = Session["payerId"].ToString();
        finalPaymentAmount = Session["payment_amt"].ToString();

        bool ret = payPalCaller.DoCheckoutPayment(finalPaymentAmount, token, PayerID, ref decoder, ref retMsg);
        if (ret)
        {
          // Retrieve PayPal confirmation value.
          string PaymentConfirmation = decoder["PAYMENTINFO_0_TRANSACTIONID"].ToString();
          TransactionId.Text = PaymentConfirmation;

          // Clear order id.
          Session["currentOrderId"] = string.Empty;
        }
        else
        {
          Response.Redirect("CheckoutError.aspx?" + retMsg);
        }
      }
    }

    protected void Continue_Click(object sender, EventArgs e)
    {
      Response.Redirect("~/Home.aspx");
    }
  }
}