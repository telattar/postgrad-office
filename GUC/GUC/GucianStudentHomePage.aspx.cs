using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUC
{
    public partial class GucianStudentHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void backtologin(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        protected void ViewProf(object sender, EventArgs e)
        {
            Response.Redirect("StudentViewProfile.aspx");
        }

        protected void ListThesis(object sender, EventArgs e)
        {
            Response.Redirect("StudentListThesis.aspx");
        }

        protected void addPR(object sender, EventArgs e)
        {
            Response.Redirect("StudentAddPR.aspx");
        }

        protected void fillPR(object sender, EventArgs e)
        {
            Response.Redirect("StudentFillPR.aspx");
        }

        protected void addPub(object sender, EventArgs e)
        {
            Response.Redirect("StudentAddPub.aspx");
        }

        protected void linkPub(object sender, EventArgs e)
        {
            Response.Redirect("StudentLinkPubThesis.aspx");
        }

        protected void ADDMOB(object sender, EventArgs e)
        {
            Response.Redirect("AddMobilePhoneNum.aspx");
        }

    }
}