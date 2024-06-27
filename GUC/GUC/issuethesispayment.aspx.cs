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
    public partial class issuethesispayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ISssuepayment(object sender, EventArgs e)
        {
            if (TextBox1.Text != "" && TextBox2.Text != "" && TextBox3.Text != "" && TextBox4.Text != "")
            {
                if (int.TryParse(TextBox1.Text, out int value) && Decimal.TryParse(TextBox2.Text, out Decimal v) && int.TryParse(TextBox3.Text, out int va) && Decimal.TryParse(TextBox4.Text, out Decimal val))
                {
                    String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    int thesis = Int16.Parse(TextBox1.Text);
                    Decimal ammount = Decimal.Parse(TextBox2.Text);
                    int noinst = Int16.Parse(TextBox3.Text);
                    Decimal fundper = Decimal.Parse(TextBox4.Text);



                    SqlCommand loginProc = new SqlCommand("AdminIssueThesisPayment", conn);
                    loginProc.CommandType = CommandType.StoredProcedure;

                    loginProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesis;
                    loginProc.Parameters.Add(new SqlParameter("@amount", SqlDbType.Decimal)).Value = ammount;
                    loginProc.Parameters.Add(new SqlParameter("@noOfInstallments", SqlDbType.Int)).Value = noinst;
                    loginProc.Parameters.Add(new SqlParameter("@fundPercentage", SqlDbType.Decimal)).Value = fundper;

                    SqlParameter sucess = loginProc.Parameters.Add("@sucess", SqlDbType.Bit);
                    sucess.Direction = System.Data.ParameterDirection.Output;


                    //SqlParameter sucess = loginProc.Parameters.Add("@success", SqlDbType.Bit);
                    //sucess.Direction = System.Data.ParameterDirection.Output;

                    conn.Open();
                    loginProc.ExecuteNonQuery();
                    conn.Close();
                    if (sucess.Value.ToString() == "False")
                    {
                        String z = "Thesis not found. Enter the correct ThesisSerialNo ";
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
                    String z = "wrong input type. ThesisSerialNo and noOfInstallments should be integer. amount and fundPercentage can be integer or decimal ";
                    Label x = new Label();
                    x.Text = z;
                    form1.Controls.Add(x);
                }
            }
            else
            {
                String z = "Some textboxes are empty.Fill the textboxes";
                Label x = new Label();
                x.Text = z;
                form1.Controls.Add(x);

            }
        }
        protected void Backad(object sender, EventArgs e)
        { Response.Redirect("AdminHomePage.aspx"); }
    }
}