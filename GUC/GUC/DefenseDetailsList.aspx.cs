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
    public partial class DefenseDetailsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ListDefense = new SqlCommand("ListDefense123", conn);
            ListDefense.CommandType = CommandType.StoredProcedure;

            ListDefense.Parameters.Add(new SqlParameter("@examinerID", Session["user"]));


            conn.Open();
            SqlDataReader rdr = ListDefense.ExecuteReader(CommandBehavior.CloseConnection);
            String flag = "empty";
            while (rdr.Read())
            {

                Label listedDetails = new Label();
                String title = rdr.GetString(rdr.GetOrdinal("ThesisTitle"));
                String sup = rdr.GetString(rdr.GetOrdinal("SupervisorName"));
                String student = rdr.GetString(rdr.GetOrdinal("StudentName"));
                //String eMail = rdr.GetString(rdr.GetOrdinal("fieldOfWork"));
                //String ePassword = rdr.GetString(rdr.GetOrdinal("fieldOfWork"));

                String info = "Thesis Title: " + title 
                            + " Supervisor Name: " + sup 
                            + " Student Name: " +  student ;

                Label rec = new Label();
                rec.Text = info;
                this.Controls.Add(rec);
                this.Controls.Add(new Literal() { ID = "row", Text = "<hr/>"});

               // listedDetails.Text = info;
                // this.Controls.Add(listedDetails);
                flag = "full";
            }
            if (flag == "empty")
            {
                String msg = "No attended Defenses yet";
                Label note = new Label();
                note.Text = msg;
                this.Controls.Add(note);
            }
           
        }
        protected void gobackk(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHomePage.aspx");
        }


    }
}