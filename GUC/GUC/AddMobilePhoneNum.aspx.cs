using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUC
{
    public partial class AddMobilePhoneNum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void backtohome(object sender, EventArgs e)
        {
            String theType = (String)Session["usertype"];

            if (theType == "GucianStudent")
                Response.Redirect("GucianStudentHomePage.aspx");
            if (theType == "NonGucianStudent")
                Response.Redirect("NonGucianStudentHomePage.aspx");


        }

        protected void addmobilenow(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int id = (int) Session["user"];
            int value;


            Boolean num = int.TryParse(mob.Text, out value);

            if (mob.Text == "")
                dolabel.Text = "no number inserted";

            else if (num == false)
                dolabel.Text = "phone number should not contain any letters or symbols. Only Numbers.";

            else
            {
                SqlCommand addm = new SqlCommand("addMobile", conn);
                addm.CommandType = CommandType.StoredProcedure;
                addm.Parameters.Add(new SqlParameter("@ID", SqlDbType.VarChar)).Value = id;

                addm.Parameters.Add(new SqlParameter("@mobile_number", SqlDbType.VarChar)).Value = mob.Text;


                SqlParameter su = addm.Parameters.Add("@success", SqlDbType.Bit);
                su.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                addm.ExecuteNonQuery();
                conn.Close();

                if (su.Value.ToString() == "True")
                    dolabel.Text = "done";
                else if (su.Value.ToString() == "False")
                    dolabel.Text = "Mobile Phone Already Exists.";


            }
        }
    }
}