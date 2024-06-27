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
    public partial class AdminHomePage : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        { }
        protected void ongoing(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand emp = new SqlCommand("AdminViewOnGoingTheses", conn);
            emp.CommandType = CommandType.StoredProcedure;

            SqlParameter sucess = emp.Parameters.Add("@thesesCount", SqlDbType.Int);
            sucess.Direction = System.Data.ParameterDirection.Output;
            conn.Open();

            emp.ExecuteNonQuery();
            conn.Close();

            String count = sucess.Value.ToString();
             Label name = new Label();
            name.Text = count;
            form1.Controls.Add(name);



        }


        protected void listthesis(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand emp = new SqlCommand("AdminViewAllTheses", conn);
            emp.CommandType = CommandType.StoredProcedure;

            conn.Open();
            
            SqlDataReader rdr = emp.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String empName;
                if (rdr.GetValue(rdr.GetOrdinal("serialNumber")) is DBNull)
                {
                    empName = "serialNumber:" + " " + "null" + ",  ";
                }
                else
                {
                    empName = "serialNumber:" + " " + rdr.GetInt32(rdr.GetOrdinal("serialNumber")).ToString() + ",  ";
                }

                if (rdr.GetValue(rdr.GetOrdinal("field")) is DBNull)
                {
                    empName += "field:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "field:" + " " + rdr.GetString(rdr.GetOrdinal("field")).ToString() + ",  ";
                }

                if (rdr.GetValue(rdr.GetOrdinal("type")) is DBNull)
                {
                    empName += "type:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "type:" + " " + rdr.GetString(rdr.GetOrdinal("type")).ToString() + ",  ";
                }

                if (rdr.GetValue(rdr.GetOrdinal("title")) is DBNull)
                {
                    empName += "title:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "title:" + " " + rdr.GetString(rdr.GetOrdinal("title")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("startDate")) is DBNull)
                {
                    empName += "startDate:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "startDate:" + " " + rdr.GetDateTime(rdr.GetOrdinal("startDate")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("endDate")) is DBNull)
                {
                    empName += "endDate:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "endDate:" + " " + rdr.GetDateTime(rdr.GetOrdinal("endDate")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("defenseDate")) is DBNull)
                {
                    empName += "defenseDate:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "defenseDate:" + " " + rdr.GetDateTime(rdr.GetOrdinal("defenseDate")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("years")) is DBNull)
                {
                    empName += "years:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "years:" + " " + rdr.GetInt32(rdr.GetOrdinal("years")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("grade")) is DBNull)
                {
                    empName += "grade:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "grade:" + " " + rdr.GetDecimal(rdr.GetOrdinal("grade")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("payment_id")) is DBNull)
                {
                    empName += "payment_id:" + " " + "null" + ",  ";
                }
                else
                {
                    empName += "payment_id:" + " " + rdr.GetInt32(rdr.GetOrdinal("payment_id")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("noOfExtensions")) is DBNull)
                {
                    empName += "noOfExtensions:" + " " + "0" + " ";

                }
                else
                {
                    empName += "noOfExtensions:" + " " + rdr.GetInt32(rdr.GetOrdinal("noOfExtensions")).ToString() + " ";

                }


                //empName += "field"+ rdr.GetString(rdr.GetOrdinal("field")).ToString() + "";
                //empName += "type"+rdr.GetString(rdr.GetOrdinal("type")).ToString() + "";
                //empName += "title"+ rdr.GetString(rdr.GetOrdinal("title")).ToString() + "";
                //empName += "startDate"+rdr.GetDateTime(rdr.GetOrdinal("startDate")).ToString() + "";
                //empName += "endDate"+rdr.GetDateTime(rdr.GetOrdinal("endDate")).ToString() + "";
                // empName += "defenseDate"+rdr.GetDateTime(rdr.GetOrdinal("defenseDate")).ToString() + "";
                //empName += "years"+rdr.GetInt32(rdr.GetOrdinal("years")).ToString() + "";
                // empName += "grade"+rdr.GetDecimal(rdr.GetOrdinal("grade")).ToString() + "";
                //empName += "payment_id"+rdr.GetInt32(rdr.GetOrdinal("payment_id")).ToString() + "";
                //empName += "noOfExtensions"+rdr.GetInt32(rdr.GetOrdinal("noOfExtensions")).ToString() + "\n" ;
                Label name = new Label () ;
                name.Text = empName;
                form1.Controls.Add(name);
                form1.Controls.Add(new Literal() {ID= "row", Text="<hr/>" });
            }
            //Label name = new Label();
            //  var buffer = empName.Split('\n');
           
            conn.Close();

        }

        protected void listsuper(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand emp = new SqlCommand("AdminListSup", conn);
            emp.CommandType = CommandType.StoredProcedure;

            conn.Open();
            
            SqlDataReader rdr = emp.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String empNam ;
                if (rdr.GetValue(rdr.GetOrdinal("id")) is DBNull)
                {
                    empNam = "id:" + " " + "null" + ",  ";
                }
                else
                {
                    empNam = "id:" + " " + rdr.GetInt32(rdr.GetOrdinal("id")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("email")) is DBNull)
                {
                    empNam += "email:" + " " + "null" + ",  ";
                }
                else
                {
                    empNam += "email:" + " " + rdr.GetString(rdr.GetOrdinal("email")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("password")) is DBNull)
                {
                    empNam += "password:" + " " + "null" + ",  ";
                }
                else
                {
                    empNam += "password:" + " " + rdr.GetString(rdr.GetOrdinal("password")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("name")) is DBNull)
                {
                    empNam += "name:" + " " + "null" + ",  ";
                }
                else
                {
                    empNam += "name:" + " " + rdr.GetString(rdr.GetOrdinal("name")).ToString() + ",  ";
                }
                if (rdr.GetValue(rdr.GetOrdinal("faculty")) is DBNull)
                {
                    empNam += "faculty:" + " " + "null" + " ";
                }
                else
                {
                    empNam += "faculty:" + " " + rdr.GetString(rdr.GetOrdinal("faculty")).ToString() + " ";
                }



                // empNam = "id:" + " "+rdr.GetInt32(rdr.GetOrdinal("id")).ToString() + ",  ";
                //empNam += "email:" + " "+rdr.GetString(rdr.GetOrdinal("email")).ToString() + ",  ";
                //empNam += "password:" + " "+rdr.GetString(rdr.GetOrdinal("password")).ToString() + ",  ";
                // empNam += "name:" + " "+rdr.GetString(rdr.GetOrdinal("name")).ToString() + "";
                //empNam += "faculty:" + " "+rdr.GetString(rdr.GetOrdinal("faculty")).ToString()+ "----NEXT----";
                Label name = new Label();
                name.Text = empNam;
                form1.Controls.Add(name);
                form1.Controls.Add(new Literal() { ID = "row", Text = "<hr/>" });
            }
            
            conn.Close();

        }
        protected void issuethesispayment(object sender, EventArgs e)
        { Response.Redirect("issuethesispayment.aspx"); }
        protected void issueinstall(object sender, EventArgs e)
        { Response.Redirect("issueinstall.aspx"); }

        protected void updateextension(object sender, EventArgs e)
        { Response.Redirect("updateextension.aspx"); }
        protected void Backad(object sender, EventArgs e)
        { Response.Redirect("login.aspx"); }

        }
}
