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
    public partial class StudentListThesis : System.Web.UI.Page
    {
        protected void backtohome(object sender, EventArgs e)
        {
            String theType = (String)Session["usertype"];

            if (theType == "GucianStudent")
                Response.Redirect("GucianStudentHomePage.aspx");
            if (theType == "NonGucianStudent")
                Response.Redirect("NonGucianStudentHomePage.aspx");


        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand sthes = new SqlCommand("studentThesis", conn);
            sthes.CommandType = CommandType.StoredProcedure;

            int studentid = (int)Session["user"];

            sthes.Parameters.Add(new SqlParameter("@ID", SqlDbType.VarChar)).Value = studentid;

            //serialnumber field type title startdate enddate defensedate years grade paymentid noofextensions
            conn.Open();
            SqlDataReader rdr = sthes.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //field , defensedate, years, grade, paymentid, noextensions can be null
                //assume that it is null and if its not, add its value

                String field = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("field")))
                    field = rdr.GetString(rdr.GetOrdinal("field"));

                String defensedate= "not specified";     
                if (!rdr.IsDBNull(rdr.GetOrdinal("defenseDate")))
                    defensedate = rdr.GetDateTime(rdr.GetOrdinal("defenseDate")).ToString();


                String years = years = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("years")))
                    years = rdr.GetInt32(rdr.GetOrdinal("years")).ToString();


                String grade = "not specified";
                if(!rdr.IsDBNull(rdr.GetOrdinal("grade")))
                    grade = rdr.GetDecimal(rdr.GetOrdinal("grade")).ToString();


                String paymentid = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("payment_id")))
                    paymentid = rdr.GetInt32(rdr.GetOrdinal("payment_id")).ToString();


                String noExt = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("noOfExtensions")))
                    noExt = rdr.GetInt32(rdr.GetOrdinal("noOfExtensions")).ToString();


                String empNam = "Serial number: " + rdr.GetInt32(rdr.GetOrdinal("serialNumber")).ToString() + ", " +
                   "Field: " + field + ", " +
                   "Type: " + rdr.GetString(rdr.GetOrdinal("type")) + ", " +
                   "Title: " + rdr.GetString(rdr.GetOrdinal("title")) + ", " +
                   "Start Date: " + rdr.GetDateTime(rdr.GetOrdinal("startDate")).ToString() + ", " +
                   "End Date: " + rdr.GetDateTime(rdr.GetOrdinal("endDate")).ToString() + ", " +
                   "Defense Date: " + defensedate + ", " +
                   "Years: " + years + ", " +
                   "Grade: " + grade + ", " +
                   "Payment ID: " + paymentid + ", " +
                    "Number of extensions: " + noExt;

                form1.Controls.Add(new Literal() { ID = "row", Text = "<hr/>" });
                Label rec = new Label();
                rec.Text = empNam;
                form1.Controls.Add(rec);



            }
            conn.Close();



        }

        //i will make a proc called studentThesis


    }
}