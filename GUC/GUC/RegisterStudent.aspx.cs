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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void RegisterNow(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String FirstName = TextBox2.Text;
            String LastName = TextBox3.Text;
            String mail = TextBox4.Text;
            String Password = TextBox5.Text;
            String Faculty = TextBox6.Text;
            String address = TextBox7.Text;
            int isGucian = Int16.Parse(DropDownList1.SelectedValue);

            if (FirstName == "" || LastName == "" ||
                mail == "" || Password == "" || Faculty == "" || address == "")
            {

                Label ee = new Label();
                ee.Text = "records shouldnt be empty. Fill the textboxes";
                form1.Controls.Add(ee);

            }

            else
            {
                SqlCommand studentregproc = new SqlCommand("studentRegister", conn);
                studentregproc.CommandType = CommandType.StoredProcedure;

                studentregproc.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = FirstName;
                studentregproc.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = LastName;
                studentregproc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = Password;
                studentregproc.Parameters.Add(new SqlParameter("@faculty", SqlDbType.VarChar)).Value = Faculty;
                studentregproc.Parameters.Add(new SqlParameter("@Gucian", SqlDbType.Bit)).Value = isGucian;
                studentregproc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
                studentregproc.Parameters.Add(new SqlParameter("@address", SqlDbType.VarChar)).Value = address;

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
                    s.Text = "email already exists. Register with another email";
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