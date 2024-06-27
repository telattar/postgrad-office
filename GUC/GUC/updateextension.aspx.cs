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
    public partial class updateextension : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void extension(object sender, EventArgs e)
        {
            if (TextBox1.Text != "")
            {
                if (int.TryParse(TextBox1.Text, out int value))
                {

                    String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);

                    int id = Int16.Parse(TextBox1.Text);


                    SqlCommand loginProc = new SqlCommand("AdminUpdateExtension", conn);
                    loginProc.CommandType = CommandType.StoredProcedure;

                    loginProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = id;

                    //conn.Open();
                    //loginProc.ExecuteNonQuery();
                    //conn.Close();
                    //conn.Close();
                    //String z = "Done";
                    //Label x = new Label();
                    //x.Text = z;
                    //form1.Controls.Add(x);
                    SqlParameter sucess = loginProc.Parameters.Add("@sucess", SqlDbType.Bit);
                    sucess.Direction = System.Data.ParameterDirection.Output;



                    conn.Open();
                    loginProc.ExecuteNonQuery();
                    conn.Close();
                    if (sucess.Value.ToString() == "False")
                    {
                        String z = "ThesisSerialNo not found. Enter the correct ThesisSerialNo";
                        Label x = new Label();
                        x.Text = z;
                        form1.Controls.Add(x);
                    }
                    else
                    {
                        String z = "Done";
                        Label x = new Label();
                        x.Text = z;
                        form1.Controls.Add(x);
                    }
                }
                else
                {
                    String z = "Data is invalid.ThesisSerialNo should be integer ";
                    Label x = new Label();
                    x.Text = z;
                    form1.Controls.Add(x);

                }
            }
            else
            {
                String z = " textbox is empty.Fill the textbox";
                Label x = new Label();
                x.Text = z;
                form1.Controls.Add(x);

            }
        }
        protected void Backad(object sender, EventArgs e)
        { Response.Redirect("AdminHomePage.aspx"); }
    }
}