using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUC
{
    public partial class RegisterAs : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e) { 
            

        }
        protected void Next(object sender, EventArgs e)

        {
            int x = Int16.Parse(DropDownList1.SelectedValue);
            if (x == 1) {
                Response.Redirect("RegisterStudent.aspx");
            }
            else if(x==2)
            {
                Response.Redirect("Supervisor.aspx");
            }
            else if (x==3)
            {
                Response.Redirect("ExaminerRegister.aspx");
            }


        }

        protected void Backad(object sender, EventArgs e)
        { Response.Redirect("login.aspx"); }

    


}
}