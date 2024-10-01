using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jayrajsinh_BookStore
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // creating a session
            string firstName = txtFirstName.Text;
            Session["FirstName"] = firstName;

            // redirecting tio product page
            Response.Redirect("~/Products.aspx");
        }
    }
}