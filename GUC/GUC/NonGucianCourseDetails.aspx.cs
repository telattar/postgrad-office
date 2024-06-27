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
    public partial class NonGucianCourseDetails : System.Web.UI.Page
    {


        protected void backtohome(object sender, EventArgs e)
        {
            Response.Redirect("NonGucianStudentHomePage.aspx");

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            int studentid = (int)Session["user"];

            SqlCommand vco = new SqlCommand("showAllCourseDetails", conn);
            vco.CommandType = CommandType.StoredProcedure;
            vco.Parameters.Add(new SqlParameter("@studentid", SqlDbType.Int)).Value = studentid;


            conn.Open();
            SqlDataReader rdr = vco.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //everything but the id can be null..
                String fees = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("fees")))
                    fees = rdr.GetInt32(rdr.GetOrdinal("fees")).ToString();

                String credith = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("creditHours")))
                    credith = rdr.GetInt32(rdr.GetOrdinal("creditHours")).ToString();

                String code = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("code")))
                    code = rdr.GetString(rdr.GetOrdinal("code")).ToString();

                String grade = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("grade")))
                    grade = rdr.GetDecimal(rdr.GetOrdinal("grade")).ToString();



                String empNam = "Course ID: " + rdr.GetInt32(rdr.GetOrdinal("id")).ToString() + ", " +
                   "Fees: " + fees + ", " +
                   "Credit Hours: " + credith + ", " +
                   "Code: " + code + ", " +
                   "Grade: " + grade;

                form1.Controls.Add(new Literal() { ID = "row", Text = "<hr/>" });
                Label rec = new Label();
                rec.Text = empNam;
                form1.Controls.Add(rec);
            }
            conn.Close();

        }
    }
}