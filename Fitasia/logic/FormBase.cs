using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fitasia.logic
{
    public class FormBase : Page
    {


        protected override void InitializeCulture()
        {
            if (Request.Cookies["selectedLanguage"] != null)
            {
                String selectedLanguage = Request.Cookies["selectedLanguage"].Value;
                UICulture = selectedLanguage;
                Culture = selectedLanguage;

                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);
            }
            base.InitializeCulture();
        }
    }
}