using Fitasia.logic;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Fitasia
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {

        }

        void Session_Start(object sender, EventArgs e)
        {
            Session["Culture"] = "en-US";
            Session["ItemDetails"] = 9999;
        }

        void Application_BeginRequest(Object sender, EventArgs e)
        {

        }
    }
}
