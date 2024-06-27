using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUC
{
    public partial class publicationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("viewPublication.aspx");
        }
    }
}