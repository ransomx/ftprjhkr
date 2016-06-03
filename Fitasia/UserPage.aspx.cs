using Fitasia.logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fitasia
{
    public partial class UserPage : FormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] != null)
                LblWelcome.Text = LblWelcome.Text.Replace("@user", ((User)Session["LoggedUser"]).Name);

        }

        protected void BtnSaveAddress_Click(object sender, EventArgs e)
        {
            using (FitasiaDataDataContext context = new FitasiaDataDataContext())
            {
                Address newAddress = new Address();
                newAddress.City = TxtCity.Text;
                newAddress.PostalCode = TxtZip.Text;
                newAddress.Street = TxtStreet.Text;
                newAddress.UserId = ((User)Session["LoggedUser"]).Id;
                context.Addresses.InsertOnSubmit(newAddress);
                context.SubmitChanges();
                GridView1.DataBind();
            }
        }
        /*
        protected void AddressData_Updating(object sender, LinqDataSourceUpdateEventArgs e)
        {
                Address a = (Address)e.NewObject;
        }

        protected void AddressData_Deleting(object sender, LinqDataSourceDeleteEventArgs e)
        {
            using (FitasiaDataDataContext context = new FitasiaDataDataContext())
            {
                Address a = (Address)e.OriginalObject;
                context.Addresses.DeleteOnSubmit(a);
                context.SubmitChanges();
            }

        }*/

        protected String CalculateDate(String date)
        {
            DateTime dt = DateTime.ParseExact(date, "dd/MM/yyyy hh:mm", null);
            DateTime tn = DateTime.Now;
            TimeSpan timeDiff = tn - dt;
            if (timeDiff.Days+365 > 0)
                return "Active";
            else return "Inactive";
        }
    }
}