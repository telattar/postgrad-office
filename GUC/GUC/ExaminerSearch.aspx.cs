using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
//using System.Globalization;
//using System.Threading;
namespace GUC
{
    public partial class ExaminerSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Searching(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand SearchByKeywod = new SqlCommand("Search1", conn);
            SearchByKeywod.CommandType = CommandType.StoredProcedure;

            String k = keyword.Text;
            SearchByKeywod.Parameters.Add(new SqlParameter("@key", k));
            SearchByKeywod.Parameters.Add(new SqlParameter("@examinerId", Session["user"]));



            conn.Open();
            SqlDataReader rdr = SearchByKeywod.ExecuteReader(CommandBehavior.CloseConnection);
            int flag = 0;
            while (rdr.Read())
            {
                //for each value we will have if else statement to check for nulls
                Label thesisDetails = new Label();

                String no = rdr.GetValue(rdr.GetOrdinal("serialNumber")).ToString();
                String field = rdr.GetString(rdr.GetOrdinal("field"));
                String type = rdr.GetString(rdr.GetOrdinal("type"));
                String title = rdr.GetString(rdr.GetOrdinal("title"));
                String sdate = rdr.GetDateTime(rdr.GetOrdinal("startDate")).ToString();
                String edate = rdr.GetDateTime(rdr.GetOrdinal("endDate")).ToString();
                String years = rdr.GetValue(rdr.GetOrdinal("years")).ToString();

                String info = "serial_no: " + no + "\n" +
                              "  field: " + field + "\n" +
                              "  type: " + type + "\n" +
                              "  title: " + title + "\n" +
                              "  start Date: " + sdate + "\n" +
                              "  end Date: " + edate + "\n" +
                              "  years: " + years + "\n";
                flag = 1;

                if (rdr.GetValue(rdr.GetOrdinal("defenseDate")) is DBNull)
                {
                    String ddate1 = "Not Specified ";
                    info = info + " Defense Date: " + ddate1 + "\n";
                }
                else
                {
                    String ddate = rdr.GetDateTime(rdr.GetOrdinal("defenseDate")).ToString();
                    info = info + " Defense Date: " + ddate + "\n" ;
                }

                if (rdr.GetValue(rdr.GetOrdinal("grade")) is DBNull)
                {
                    String grade1 = "-";
                    info = info + " grade: " + grade1 + "\n";
                }
                else
                {
                    String grade = rdr.GetDecimal(rdr.GetOrdinal("grade")).ToString();
                    info = info + " grade: " + grade + "\n";
                }

                if (rdr.GetValue(rdr.GetOrdinal("payment_id")) is DBNull)
                {
                    String pid1 = "-";
                    info = info + " payment_id: " + pid1 + "\n" ;
                }
                else
                {
                    String pid = rdr.GetValue(rdr.GetOrdinal("payment_id")).ToString();
                    info = info + " payment_id: " + pid + "\n";
                }

                if (rdr.GetValue(rdr.GetOrdinal("noOfExtensions")) is DBNull)
                {
                    String noex1 = "-";
                    info = info + " number of extensions: " + noex1 + "\n";
                }
                else
                {
                    String noex = rdr.GetValue(rdr.GetOrdinal("noOfExtensions")).ToString();
                    info = info + " number of extensions: " + noex + "\n";

                }

                Label rec = new Label();
                rec.Text = info;
                this.Controls.Add(rec);
                this.Controls.Add(new Literal() { ID = "row", Text = "<hr/>" });

               // info = info + "_________Next_________";
                //thesisDetails.Text = info;
                
                //this.Controls.Add(thesisDetails);
                
            }
            if (flag == 0) {
                Label thesisDetails = new Label();
                thesisDetails.Text = "None of your assigned Thesis contains this word in their title";
                this.Controls.Add(thesisDetails);


            }

        }
        protected void gobackk(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHomePage.aspx");
        }
    }
}