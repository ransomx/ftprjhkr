using Fitasia.logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fitasia
{
    public partial class AdminPage : FormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (FitasiaDataDataContext context = new FitasiaDataDataContext())
            {
                decimal sum = context.Orders.Sum(p => p.Product.Price);
                decimal count = context.Orders.Select(p => p.Product).Count();
                LblTotalIncome.Text = sum.ToString();
                LblNumOfOrders.Text = count.ToString();


            }
                
        }

        protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
        {
            MultiView1.ActiveViewIndex = Int32.Parse(Menu1.SelectedValue);
        }
    }
}