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
    public partial class StudentFillPR : System.Web.UI.Page
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

        protected void FillProgress(object sender, EventArgs e)
        {
            int studentid = (int)Session["user"];

            int value;
            int value2;
            int value3;

            Boolean num = int.TryParse(tsn.Text, out value);
            Boolean num2 = int.TryParse(prno.Text, out value2);
            Boolean num3 = int.TryParse(statetext.Text, out value3);


            if (tsn.Text == "" || prno.Text == "" || statetext.Text == "" || descrip.Text == "")
            {
                succeslb.Text = "missing data. please fill out all of the text boxes.";

            }

            //description is varchar 200
            else if (descrip.Text.Length > 200)
                succeslb.Text = "Cannot apply changes. The description shouldn't exceed 200 characters.";

            //serialno, prno, state are all int

            else if (num == false || num2 == false || num3 == false)
                succeslb.Text = "Thesis serial number, progress report number, and state should all be integers." +
                    "please do not include any symbols, alphabets or spaces.";

            else
            {

                String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand fillpr = new SqlCommand("FillProgressReport", conn);
                fillpr.CommandType = CommandType.StoredProcedure;

                fillpr.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = studentid;
                fillpr.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = tsn.Text;
                fillpr.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = prno.Text;
                fillpr.Parameters.Add(new SqlParameter("@state", SqlDbType.Int)).Value = statetext.Text;
                fillpr.Parameters.Add(new SqlParameter("@description", SqlDbType.VarChar)).Value = descrip.Text;

                SqlParameter su = fillpr.Parameters.Add("@success", SqlDbType.Int);
                su.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                fillpr.ExecuteNonQuery();
                conn.Close();

                if (su.Value.ToString() == "1")
                    succeslb.Text = "done";

                else if (su.Value.ToString() == "0")
                    succeslb.Text = "please fill a progress report that is yours, and for the thesis you are registered in.";
                else if (su.Value.ToString() == "2")
                    succeslb.Text = "progress report number and/or thesis serial number doesnt exist" +
                        ". please enter the correct thesis serial number and/or progress report number.";

                else if (su.Value.ToString() == "4")
                    succeslb.Text = "this thesis has ended. please enter a serial number for a thesis that is ongoing.";
                else if (su.Value.ToString() == "5")
                    succeslb.Text = "this thesis did not start yet. please enter a serial number for a thesis that is ongoing.";

            }
        }
    }
}