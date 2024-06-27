using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace GUC
{
    public partial class ExaminerHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand viewMyDetailsProc = new SqlCommand("ViewAllMyDetails", conn);
            viewMyDetailsProc.CommandType = CommandType.StoredProcedure;

            viewMyDetailsProc.Parameters.Add(new SqlParameter("@examinerID", Session["user"]));


            conn.Open();
            SqlDataReader rdr = viewMyDetailsProc.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                Label ExaminerDetails = new Label();

                String eId2 = Session["user"].ToString();
                String eName = rdr.GetString(rdr.GetOrdinal("name"));
                String eField = rdr.GetString(rdr.GetOrdinal("fieldOfWork"));
                String eMail = rdr.GetString(rdr.GetOrdinal("email"));
                String ePassword = rdr.GetString(rdr.GetOrdinal("password")).ToString();

                String info = "ID: " + eId2 + " Examiner Name: " + eName + " Field: " +
                    eField + " email: " + eMail + " password: " + ePassword;

                ExaminerDetails.Text = info;
                this.Controls.Add(ExaminerDetails);
            }
        }


        protected void changeInfo(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerEdit.aspx");
        }
        protected void ViewList(object sender, EventArgs e)
        {
            Response.Redirect("DefenseDetailsList.aspx");
        }
        protected void SearchByKey(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerSearch.aspx");
        }
        protected bool IsAllAlphabetic(String x)
        {
            foreach (char c in x)
            {
                if (!char.IsLetter(c))
                {
                    return false;
                }
            }
            return true;
        }
        protected void addComment(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand AddCommentsGrade = new SqlCommand("AddCommentsGrade66", conn);
            AddCommentsGrade.CommandType = CommandType.StoredProcedure;
            String msg = important.Text;

            if (!(int.TryParse(TextBox1.Text, out int value)) || !(IsAllAlphabetic(TextBox3.Text)))
            {
                important.Text = "please check serial number or comment are entered correctly";
            }
            else
            {

                String serial = TextBox1.Text;
                String defdate = TextBox2.Text;
                String comment = TextBox3.Text;

                int flag = 0;

                string[] dateFormats = new[] { "yyyy/MM/dd", "MM/dd/yyyy", "MM/dd/yyyyHH:mm:ss" };
                CultureInfo provider = new CultureInfo("en-US");
                DateTime DefenseeDatee;
                try
                {
                    //Parse()
                    //defdate = DateTime.Parse("08/08/2020");
                    //Console.WriteLine("\nParse() method: " + date);
                    //ParseExact()
                    DefenseeDatee = DateTime.ParseExact(defdate, dateFormats, provider,
                    DateTimeStyles.AdjustToUniversal);
                    //Console.WriteLine("\nParseExact() method: " + date);
                }
                catch (Exception ex)
                {
                    flag = 1;
                    String not = "Please enter date in any of these formats: yyyy / MM / dd, MM / dd / yyyy, MM / dd / yyyy";
                    important.Text = not;

                }
                if (flag != 1)
                {
                    DefenseeDatee = DateTime.ParseExact(defdate, dateFormats, provider,
                    DateTimeStyles.AdjustToUniversal);

                    AddCommentsGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", serial));
                    AddCommentsGrade.Parameters.Add(new SqlParameter("@DefenseDate", DefenseeDatee));
                    AddCommentsGrade.Parameters.Add(new SqlParameter("@comments", comment));
                    AddCommentsGrade.Parameters.Add(new SqlParameter("@examinerId", Session["user"]));

                    SqlParameter success = AddCommentsGrade.Parameters.Add("@success", SqlDbType.Int);
                    success.Direction = ParameterDirection.Output;

                    conn.Open();
                    AddCommentsGrade.ExecuteNonQuery();
                    conn.Close();

                    if (success.Value.ToString() == "1")
                    {
                        important.Text = "Comment is added Successfully";
                    }
                    else
                    {
                        important.Text = "Error! occured you are trying to update comment for a defense you are not assigned to or defense date incorrect. Please enter correct defense date and serial number";



                    }
                }

            }
        }
        protected void addGrade(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand AddDefenseGrade = new SqlCommand("AddDefenseGrade66", conn);
            AddDefenseGrade.CommandType = CommandType.StoredProcedure;

            if (int.TryParse(TextBox1.Text, out int value) == false || decimal.TryParse(TextBox4.Text, out decimal value2) == false)
            {
                important2.Text = "please enter grade correctly";
            }
            else
            {

                String serial = TextBox1.Text;
                String defdate = TextBox2.Text;
                String grade = TextBox4.Text;
                String msg2 = important2.Text;
                int flag = 0;

                string[] dateFormats = new[] { "yyyy/MM/dd", "MM/dd/yyyy", "MM/dd/yyyyHH:mm:ss" };
                CultureInfo provider = new CultureInfo("en-US");
                DateTime DefenseeDatee;
                try
                {
                    //Parse()
                    //defdate = DateTime.Parse("08/08/2020");
                    //Console.WriteLine("\nParse() method: " + date);
                    //ParseExact()
                    DefenseeDatee = DateTime.ParseExact(defdate, dateFormats, provider,
                    DateTimeStyles.AdjustToUniversal);
                    //Console.WriteLine("\nParseExact() method: " + date);
                }
                catch (Exception ex)
                {
                    flag = 1;
                    String not = "Please enter date in any of these formats: yyyy / MM / dd, MM / dd / yyyy, MM / dd / yyyy";
                    important.Text = not;

                }


                if (flag != 1)
                {

                    DefenseeDatee = DateTime.ParseExact(defdate, dateFormats, provider,
                    DateTimeStyles.AdjustToUniversal);

                    AddDefenseGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", serial));
                    AddDefenseGrade.Parameters.Add(new SqlParameter("@DefenseDate", DefenseeDatee));
                    AddDefenseGrade.Parameters.Add(new SqlParameter("@grade", grade));
                    AddDefenseGrade.Parameters.Add(new SqlParameter("@examinerId", Session["user"]));

                    SqlParameter success = AddDefenseGrade.Parameters.Add("@success", SqlDbType.Int);
                    success.Direction = ParameterDirection.Output;

                    conn.Open();
                    AddDefenseGrade.ExecuteNonQuery();
                    conn.Close();

                    if (success.Value.ToString() == "1")
                    {
                        important2.Text = "Grade Updated Successfully";
                    }
                    else
                    {
                        important2.Text = "Error! you are trying to update grade for a defense that is not assigned to you or defense date incorrect. Please enter correct defense serial number and date";


                    }
                }
                //success bit to be added
            }
        }
        protected void gobackk(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

    }
}