using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace Jayrajsinh_BookStore
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        private void ShowAlert(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "Alert", script, true);
        }
        protected void Checkout_Click(object sender, EventArgs e)
        {
            ShowAlert("Your order has been placed successfully!");
        }
        

        protected void CancleOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("Products.aspx");
        }

    }
}