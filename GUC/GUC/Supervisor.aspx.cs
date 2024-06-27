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
    public partial class Supervisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Regnow(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String FirstName = TextBox2.Text;
            String LastName = TextBox3.Text;
            String mail = TextBox4.Text;
            String Password = TextBox5.Text;
            String Faculty = TextBox6.Text;

            if (FirstName == "" || LastName == "" ||
             mail == "" || Password == "" || Faculty == "")
            {

                Label ee = new Label();
                ee.Text = "records shouldnt be empty. Fill the textboxes ";
                form1.Controls.Add(ee);

            }
            else
            {

                SqlCommand studentregproc = new SqlCommand("supervisorRegister", conn);
                studentregproc.CommandType = CommandType.StoredProcedure;

                studentregproc.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = FirstName;
                studentregproc.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = LastName;
                studentregproc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = Password;
                studentregproc.Parameters.Add(new SqlParameter("@faculty", SqlDbType.VarChar)).Value = Faculty;
                studentregproc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;

                SqlCommand isuniqueemail = new SqlCommand("emailExists", conn);
                isuniqueemail.CommandType = CommandType.StoredProcedure;
                isuniqueemail.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;

                SqlParameter existmail = isuniqueemail.Parameters.Add("@success", SqlDbType.Bit);
                existmail.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                isuniqueemail.ExecuteNonQuery();
                String sbit = existmail.Value.ToString();
                conn.Close();



                if (sbit == "True")
                {
                    Label s = new Label();
                    s.Text = "email already exists. register with another email";
                    form1.Controls.Add(s);
                }
                else
                {
                    conn.Open();
                    studentregproc.ExecuteNonQuery();
                    conn.Close();
                    Response.Redirect("Login.aspx");

                }


            }
        }
        protected void Backad(object sender, EventArgs e)
        { Response.Redirect("RegisterAs.aspx"); }
    }
}