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
    public partial class SuperHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ListStudents(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int supervisorId = Int16.Parse(Session["user"].ToString());
            SqlCommand ViewSupStudentsYears = new SqlCommand("ViewSupStudentsYears", conn);
            ViewSupStudentsYears.CommandType = CommandType.StoredProcedure;

            ViewSupStudentsYears.Parameters.Add(new SqlParameter("@supervisorID", supervisorId));
            SqlParameter s = ViewSupStudentsYears.Parameters.Add("@Success", SqlDbType.Bit);
            s.Direction = System.Data.ParameterDirection.Output;

            conn.Open();
            ViewSupStudentsYears.ExecuteNonQuery();
            conn.Close();

            if (s.Value.ToString() == "False")
            {
                Label r = new Label();
                r.Text = "There is no students regiestered to a thesis";
                form1.Controls.Add(r);
            }

            else { 
            conn.Open();
            SqlDataReader rdr = ViewSupStudentsYears.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String empNam = "\r\n" + "First Name:" + rdr.GetString(rdr.GetOrdinal("firstName")) + "  " +
                    "Last Name:" + rdr.GetString(rdr.GetOrdinal("lastName")) + " " +
                    "Years spent in thesis:" + rdr.GetInt32(rdr.GetOrdinal("years"));

                Label rec = new Label();
                rec.Text = empNam;
                form1.Controls.Add(rec);
                form1.Controls.Add(new Literal() { ID = "row", Text = "<hr/>" });
            }
            conn.Close();
        }
        }
        protected void ViewPublication(object sender, EventArgs e)
        {
            Response.Redirect("viewPublication.aspx");
        }
        protected void AddDefense(object sender, EventArgs e)
        {
            Response.Redirect("addDefense.aspx");
        }
        protected void EvaluatePR(object sender, EventArgs e)
        {
            Response.Redirect("evaluatePR.aspx");
        }
        protected void CancelThesis(object sender, EventArgs e)
        {
            Response.Redirect("cancelThesis.aspx");
        }
        protected void SignOut(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}