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
    public partial class evaluatePR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("SuperHomePage.aspx");
        }
        protected void pr(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            if (SerialNo.Text == "" || ProgressReportNo.Text == "" || Evaluation.Text == "")
            {
                Label z = new Label();
                z.Text = "Please enter empty fields";
                form1.Controls.Add(z);
            }
            else { 

            int sid = Int16.Parse(Session["user"].ToString());
            int serialid = Int16.Parse(SerialNo.Text);
            int prno = Int16.Parse(ProgressReportNo.Text);
            int evaluate = Int16.Parse(Evaluation.Text);

            

           

                SqlCommand EvaluateProgressReport = new SqlCommand("EvaluateProgressReport", conn);
                EvaluateProgressReport.CommandType = CommandType.StoredProcedure;

                EvaluateProgressReport.Parameters.Add(new SqlParameter("@supervisorID", sid));
                EvaluateProgressReport.Parameters.Add(new SqlParameter("@thesisSerialNo", serialid));
                EvaluateProgressReport.Parameters.Add(new SqlParameter("@progressReportNo", prno));
                EvaluateProgressReport.Parameters.Add(new SqlParameter("@evaluation", evaluate));
                SqlParameter m = EvaluateProgressReport.Parameters.Add("@Exists", SqlDbType.Bit);
                m.Direction = System.Data.ParameterDirection.Output;

                SqlParameter s = EvaluateProgressReport.Parameters.Add("@Success", SqlDbType.Bit);
                s.Direction = System.Data.ParameterDirection.Output;

                SqlParameter p = EvaluateProgressReport.Parameters.Add("@existspr", SqlDbType.Bit);
                p.Direction = System.Data.ParameterDirection.Output;

                ;

                conn.Open();
                EvaluateProgressReport.ExecuteNonQuery();
                conn.Close();


                if (m.Value.ToString() == "False")
                {
                    Label z = new Label();
                    z.Text = "Thesis is not registered to supervisor cant't edit grade";
                    form1.Controls.Add(z);
                }

                else if (s.Value.ToString() == "False")
                {
                    Label z = new Label();
                    z.Text = "Please enter valid thesis serial number";
                    form1.Controls.Add(z);
                }
                else if (p.Value.ToString() == "False" && s.Value.ToString() == "True" && m.Value.ToString() == "True")
                {
                    Label z = new Label();
                    z.Text = "Progress report doesn't exist, please enter valid progress report number";
                    form1.Controls.Add(z);
                }


                else if (evaluate > 3)
                {
                    String x = "Evaluation must be from 0 to 3";
                    Label z = new Label();
                    z.Text = x;
                    form1.Controls.Add(z);
                }

                else
                {
                    String x = "Evaluation posted successfully!";
                    Label z = new Label();
                    z.Text = x;
                    form1.Controls.Add(z);
                }
            }

        }
    }
}