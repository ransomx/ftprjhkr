using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Fitasia.logic;

namespace Fitasia
{
    public partial class ActivationPage : FormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Guid activationCode = !string.IsNullOrEmpty(Request.QueryString["ActivationCode"]) ? Guid.Parse(Request.QueryString["ActivationCode"]) : Guid.Empty;
                using (FitasiaDataDataContext context = new FitasiaDataDataContext())
                {
                    UserActivation ac = context.UserActivations.SingleOrDefault(p => p.ActivationCode == activationCode);

                    if (ac == null)
                    {
                        ltMessage.Text = "This account is already active, you may login.";
                    }
                    else {
                        ltMessage.Text = "Activation successful, you may login.";
                        context.UserActivations.DeleteOnSubmit(ac);
                        context.SubmitChanges();
                    }
                        
                }
            }
        }
    }
}