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
    public partial class cancelThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void cancel(object sender, EventArgs e)

        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            
            if (SerialNo.Text == "")
            {
                Label n = new Label();
                n.Text = "Please enter empty fields";
                form1.Controls.Add(n);
            }
            else
            {

                int serialid = Int16.Parse(SerialNo.Text);

                SqlCommand CancelThesis = new SqlCommand("CancelThesis", conn);
                CancelThesis.CommandType = CommandType.StoredProcedure;

                CancelThesis.Parameters.Add(new SqlParameter("@ThesisSerialNo", serialid));
                SqlParameter s = CancelThesis.Parameters.Add("@Success", SqlDbType.Bit);
                s.Direction = System.Data.ParameterDirection.Output;
                SqlParameter exists = CancelThesis.Parameters.Add("@Exists", SqlDbType.Bit);
                exists.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                CancelThesis.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString() == "False")
                {
                    Label n = new Label();
                    n.Text = "Thesis doesn't exist, enter a valid thesis serial number";
                    form1.Controls.Add(n);
                }

                else if (s.Value.ToString() == "False" && exists.Value.ToString() == "True")
                {
                    Label ex = new Label();
                    ex.Text = "Cannot cancel thesis, last progress report evaluation is not a zero";
                    form1.Controls.Add(ex);
                }
                else if (s.Value.ToString() == "True" && exists.Value.ToString() == "True")
                {
                    Label canc = new Label();
                    canc.Text = "Thesis cancelled successfully";
                    form1.Controls.Add(canc);
                }
            }
         


           
           



        }

        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("SuperHomePage.aspx");
        }
    }
}