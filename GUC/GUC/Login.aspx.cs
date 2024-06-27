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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String email = Userid.Text;
            String pass = Password.Text;

            if (email == "" && pass == "")
            {
                labelz.Text = "please enter your email and password";
            }
            else if (email == "")
                labelz.Text = "please enter your email";
            else if (pass == "")
                labelz.Text = "please enter your password";
            else
            {

                SqlCommand loginProc = new SqlCommand("UserLogin", conn);
                loginProc.CommandType = CommandType.StoredProcedure;

                loginProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = email;
                loginProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;


                SqlParameter sucess = loginProc.Parameters.Add("@success", SqlDbType.Bit);
                sucess.Direction = System.Data.ParameterDirection.Output;

                SqlParameter userid = loginProc.Parameters.Add("@id", SqlDbType.Int);
                userid.Direction = System.Data.ParameterDirection.Output;

                int id = 0;

                conn.Open();
                loginProc.ExecuteNonQuery();
                conn.Close();
                if (sucess.Value.ToString() == "True")
                {
                    id = (int)userid.Value;
                    Session["user"] = id;

                    SqlCommand checkType = new SqlCommand("checkType", conn);
                    checkType.CommandType = CommandType.StoredProcedure;
                    checkType.Parameters.Add(new SqlParameter("@ID", id));

                    SqlParameter typeOut = checkType.Parameters.Add("@usertype", SqlDbType.VarChar, 20);
                    typeOut.Direction = System.Data.ParameterDirection.Output;


                    conn.Open();
                    checkType.ExecuteNonQuery();
                    String theType = typeOut.Value.ToString();
                    conn.Close();

                    //store the user type to use it in other files
                    Session["usertype"] = theType;


                    //according to the type i should be redirected to a specific homepage
                    if (theType == "GucianStudent")
                        Response.Redirect("GucianStudentHomePage.aspx");
                    if (theType == "NonGucianStudent")
                        Response.Redirect("NonGucianStudentHomePage.aspx");

                    if (theType == "Supervisor")
                        Response.Redirect("SuperHomePage.aspx");
                    if (theType == "Admin")
                        Response.Redirect("AdminHomePage.aspx");
                    if (theType == "Examiner")
                        Response.Redirect("ExaminerHomePage.aspx");

                }


                if (sucess.Value.ToString() == "False")
                {
                    labelz.Text = "email or password is incorrect. login with correct email and password";
                   
                }
            }




        }
        protected void register(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAs.aspx");
        }



    }
}