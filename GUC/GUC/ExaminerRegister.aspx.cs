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
    public partial class ExaminerRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterNow(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String Name = TextBox2.Text;
            String mail = TextBox4.Text;
            String Password = TextBox5.Text;
            String Field = TextBox3.Text;
            int isNational = Int16.Parse(DropDownList1.SelectedValue);

            if (Name == "" || Password == "" ||
                mail == "" || Field == "")
            {

                Label ee = new Label();
                ee.Text = "records shouldnt be empty. Fill the textboxes";
                form1.Controls.Add(ee);

            }


            else
            {
                SqlCommand isuniqueemail = new SqlCommand("emailExists", conn);
                isuniqueemail.CommandType = CommandType.StoredProcedure;
                isuniqueemail.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;

                SqlParameter existmail = isuniqueemail.Parameters.Add("@success", SqlDbType.Bit);
                existmail.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                isuniqueemail.ExecuteNonQuery();
                String sbit = existmail.Value.ToString();
                conn.Close();



                SqlCommand studentregproc = new SqlCommand("examinerResister", conn);
                studentregproc.CommandType = CommandType.StoredProcedure;

                studentregproc.Parameters.Add(new SqlParameter("@fullname", SqlDbType.VarChar)).Value = Name;
                studentregproc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = Password;
                studentregproc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
                studentregproc.Parameters.Add(new SqlParameter("@fieldofwork", SqlDbType.VarChar)).Value = Field;
                studentregproc.Parameters.Add(new SqlParameter("@isnational", SqlDbType.Bit)).Value = isNational;


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