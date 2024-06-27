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
    public partial class StudentAddPR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void backtohome(object sender, EventArgs e)
        {
            String theType =(String) Session["usertype"];

            if (theType == "GucianStudent")
                Response.Redirect("GucianStudentHomePage.aspx");
            if (theType == "NonGucianStudent")
                Response.Redirect("NonGucianStudentHomePage.aspx");


        }



        protected void ADDPROGREP(object sender, EventArgs e)
        {
            int studentid = (int)Session["user"];

            //both serial number and pr number must be POSITIVE INTEGERS.

            int value;
            int value2;

            Boolean num = int.TryParse(tsn.Text, out value);
            Boolean num2 = int.TryParse(prno.Text, out value2);

            if (tsn.Text == "" || Calendar1.SelectedDate == DateTime.MinValue || prno.Text == "")
            {
                successLabel.Text = "data is missing. Please fill all the text boxes.";
            }


            else if (num == false || num2 == false)
            {
             successLabel.Text = "Thesis serial number/progress report number should be an integer. Please do not add any symbols or alphabets or spaces.";

            }




            else
            {

                String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand addpr = new SqlCommand("AddProgressReport", conn);
                addpr.CommandType = CommandType.StoredProcedure;

                DateTime cal = Calendar1.SelectedDate;

                addpr.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = studentid;
                addpr.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = tsn.Text;
                addpr.Parameters.Add(new SqlParameter("@progressReportDate", SqlDbType.Date)).Value = cal.ToString("yyyy-MM-dd");
                addpr.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = prno.Text;

                SqlParameter su = addpr.Parameters.Add("@success", SqlDbType.Int);
                su.Direction = System.Data.ParameterDirection.Output;


                conn.Open();
                addpr.ExecuteNonQuery();
                conn.Close();

                if (su.Value.ToString() == "1")
                    successLabel.Text = "done";

                else if (su.Value.ToString() == "2")
                    successLabel.Text = "progress report number already exists in the database. please insert a different number as it has to be a unique value.";

                else if (su.Value.ToString() == "0")
                    successLabel.Text = "you can only add a publication to a thesis that you're registered in. please make sure that the thesis serial number is correct.";
                else if (su.Value.ToString() == "4")
                    successLabel.Text = "this thesis has ended. please enter a serial number for a thesis that is ongoing.";
                else if (su.Value.ToString() == "5")
                    successLabel.Text = "this thesis did not start yet. please enter a serial number for a thesis that is ongoing.";


            }

        }


    }
}