using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUC
{
    public partial class NonGucianStudentHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signout(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        protected void addmobs(object sender, EventArgs e)
        {
            Response.Redirect("AddMobilePhoneNum.aspx");
        }

        protected void listmythesis(object sender, EventArgs e)
        {
            Response.Redirect("StudentListThesis.aspx");
        }

        protected void addpr(object sender, EventArgs e)
        {
            Response.Redirect("StudentAddPR.aspx");
        }

        protected void fillpr(object sender, EventArgs e)
        {
            Response.Redirect("StudentFillPR.aspx");
        }
        protected void addpub(object sender, EventArgs e)
        {
            Response.Redirect("StudentAddPub.aspx");
        }
        protected void linkpub(object sender, EventArgs e)
        {
            Response.Redirect("StudentLinkPubThesis.aspx");
        }
        protected void showcourse(object sender, EventArgs e)
        {
            Response.Redirect("NonGucianCourseDetails.aspx");
        }
        protected void viewmyprof(object sender, EventArgs e)
        {
            Response.Redirect("StudentViewProfile.aspx");
        }
    }
}