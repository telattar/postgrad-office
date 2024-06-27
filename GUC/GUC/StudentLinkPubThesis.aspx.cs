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
    public partial class StudentLinkPubThesis : System.Web.UI.Page
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

        protected void linkpubthesis(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            int studentid =(int) Session["user"];
            int value;
            int value2;

            Boolean num = int.TryParse(tsn.Text, out value);
            Boolean num2 = int.TryParse(prno.Text, out value2);


            if (tsn.Text == "" || prno.Text == "")
            {
                successl.Text = "missing data. please fill out all text boxes";
            }

            else if (num == false || num2 == false)
                successl.Text = "Thesis serial number and progress report number should both be integers." +
                    " Please do not add any symbols or alphabets or spaces";

            else
            {

                SqlCommand linkpt = new SqlCommand("linkPubThesis", conn);
                linkpt.CommandType = CommandType.StoredProcedure;

                linkpt.Parameters.Add(new SqlParameter("@studentid", SqlDbType.Int)).Value = studentid;

                linkpt.Parameters.Add(new SqlParameter("@PubID", SqlDbType.Int)).Value = prno.Text;
                linkpt.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = tsn.Text;
                SqlParameter su = linkpt.Parameters.Add("@success", SqlDbType.Int);
                su.Direction = System.Data.ParameterDirection.Output;


                conn.Open();
                linkpt.ExecuteNonQuery();
                conn.Close();

                if (su.Value.ToString() == "1")
                    successl.Text = "done";

                else if (su.Value.ToString() == "2")
                    successl.Text = "thesis serial number OR publication number does not exist. please enter a valid thesis/publication number. ";

                else if (su.Value.ToString() == "0")
                    successl.Text = "Changes can not be applied; you can only add a publication to a thesis that you're registered in." +
                        "Please enter the correct thesis serial number, and also make sure that the publication number belongs to a publication that is yours.";

                else if (su.Value.ToString() == "3")
                    successl.Text = "this publication is already link to the thesis that you specified.";
                else if (su.Value.ToString() == "4")
                    successl.Text = "this thesis has ended. please enter a serial number for a thesis that is ongoing.";
                else if (su.Value.ToString() == "5")
                    successl.Text = "this thesis did not start yet. please enter a serial number for a thesis that is ongoing.";

            }
        }
    }
}