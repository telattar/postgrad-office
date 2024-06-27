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
    public partial class ExaminerEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void UpdateInfo(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand EditMyPersonalInfo = new SqlCommand("EditMyPersonalInfo1", conn);
            EditMyPersonalInfo.CommandType = CommandType.StoredProcedure;
            String name = TextBox2.Text;
            String field = TextBox3.Text;
            String mail = TextBox4.Text;
            String pass = TextBox5.Text;

            if (name == "" || field == "" || mail == "" || pass == "")
            {
                String se = "Please fill in Empty Boxes";
               // Response.Redirect("ExaminerEdit.aspx");
                Label err = new Label();
                err.Text = se;
                this.Controls.Add(err);
            }
            else
            {

                EditMyPersonalInfo.Parameters.Add(new SqlParameter("@id", Session["user"]));
                EditMyPersonalInfo.Parameters.Add(new SqlParameter("@name", name));
                EditMyPersonalInfo.Parameters.Add(new SqlParameter("@fieldOfWork", field));
                EditMyPersonalInfo.Parameters.Add(new SqlParameter("@mail", mail));
                EditMyPersonalInfo.Parameters.Add(new SqlParameter("@password", pass));

                SqlParameter success = EditMyPersonalInfo.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;


                conn.Open();
                EditMyPersonalInfo.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {
                    msg.Text = "Update Done Successfully";
                }
                else
                {
                    msg.Text = "Error! you may have entered wrong ID. Please Try Again";


                }

                
            }
        }
        protected void gobackk(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHomePage.aspx");
        }


    }
}