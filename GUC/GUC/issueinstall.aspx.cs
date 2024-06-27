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
    public partial class issueinstall : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ISsueinstall(object sender, EventArgs e)
        {
            if (TextBox1.Text == "" && Calendar1.SelectedDate == DateTime.MinValue)
            {
                String z = "textbox is empty and date not choosen. Fill the textbox and choose a date";
                Label x = new Label();
                x.Text = z;
                form1.Controls.Add(x);
            }
               else if (TextBox1.Text == "" )
            {
                String z = "textbox is empty. Fill the textbox";
                Label x = new Label();
                x.Text = z;
                form1.Controls.Add(x); }
            else if (Calendar1.SelectedDate == DateTime.MinValue) {
                String z = "Date is not choosen. choose date";
                Label x = new Label();
                x.Text = z;
                form1.Controls.Add(x);
            }

            else {
                if (int.TryParse(TextBox1.Text, out int value))
                {
                    //string passy = (TextBox2.Text).ToString();
                    //string passm = (TextBox3.Text).ToString();
                    //string passd = (TextBox4.Text).ToString();
                    //string pass = passy + "-" + passm + "-" + passd;
                    DateTime datec = Calendar1.SelectedDate;
                    int id = Int16.Parse(TextBox1.Text);

                    // if (DateTime.TryParse(pass, out DateTime vall))
                    //  {
                    String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);



                    SqlCommand loginProc = new SqlCommand("AdminIssueInstallPayment", conn);
                    loginProc.CommandType = CommandType.StoredProcedure;

                    loginProc.Parameters.Add(new SqlParameter("@paymentID", SqlDbType.VarChar)).Value = id;
                    loginProc.Parameters.Add(new SqlParameter("@InstallStartDate", SqlDbType.Date)).Value = datec.ToString("yyyy-MM-dd");

                    SqlParameter sucess = loginProc.Parameters.Add("@sucess", SqlDbType.Int);
                    sucess.Direction = System.Data.ParameterDirection.Output;



                    conn.Open();
                    loginProc.ExecuteNonQuery();
                    conn.Close();
                    if (sucess.Value.ToString() == "1")
                    {
                        String z = "paymentID not found. Enter the correct paymentID ";
                        Label x = new Label();
                        x.Text = z;
                        form1.Controls.Add(x);
                    }
                    else if (sucess.Value.ToString() == "0")
                    {
                        String z = "Done";
                        Label x = new Label();
                        x.Text = z;
                        form1.Controls.Add(x);
                    }
                    else if (sucess.Value.ToString() == "2")
                    {
                        String z = "There is already installments issued. You can not issue for this paymentID";
                        Label x = new Label();
                        x.Text = z;
                        form1.Controls.Add(x);
                    }
                    //}
                    //else
                    //{
                    //    String z = "Date is invalid. Year should be an integer, Day should be an integer btween 1 and (28,29,30,31)(accourding to month) and month should be an integer btween 1 and 12 ";
                    //    Label x = new Label();
                    //    x.Text = z;
                    //    form1.Controls.Add(x);

                    //}
                }
                else
                {
                    String z = "Wrong input type. enter paymentID as integer number .";
                    Label x = new Label();
                    x.Text = z;
                    form1.Controls.Add(x);
                }
            }
           
        }
        protected void Backad(object sender, EventArgs e)
        { Response.Redirect("AdminHomePage.aspx"); }

    }
}