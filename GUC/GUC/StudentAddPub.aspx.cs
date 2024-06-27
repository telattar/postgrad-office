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
    public partial class StudentAddPub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void backtohome(object sender, EventArgs e)
        {
            String theType = (String)Session["usertype"];

            if (theType == "GucianStudent")
                Response.Redirect("GucianStudentHomePage.aspx");
            if (theType == "NonGucianStudent")
                Response.Redirect("NonGucianStudentHomePage.aspx");


        }

        protected void addpubbutton(object sender, EventArgs e)
        {


            if (title.Text == "" || Calendar1.SelectedDate == DateTime.MinValue || host.Text == "" || place.Text == "")
            {
                successlabel.Text = "missing data. please fill out all the text boxes, as well as the calendar entry";
            }

            else if (title.Text.Length > 100)
                successlabel.Text = "Cannot apply changes. Title length must be less than 100";

            else if (host.Text.Length > 100)
                successlabel.Text = "Cannot apply changes. 'Host' length must be less than 100";

            else if (place.Text.Length > 100)
                successlabel.Text = "Cannot apply changes. 'Place' length must be less than 100";


            else
            {
                //@title varchar(50), @pubDate datetime, @host varchar(50), @place varchar(50), @accepted bit

                String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand addpub = new SqlCommand("addPublication", conn);
                addpub.CommandType = CommandType.StoredProcedure;

                int accept = Int16.Parse(DropDownList1.SelectedValue);

                DateTime cal = Calendar1.SelectedDate;

                addpub.Parameters.Add(new SqlParameter("@title", SqlDbType.VarChar)).Value = title.Text;
                addpub.Parameters.Add(new SqlParameter("@pubDate", SqlDbType.VarChar)).Value = cal.ToString("yyyy-MM-dd");
                addpub.Parameters.Add(new SqlParameter("@host", SqlDbType.VarChar)).Value = host.Text;
                addpub.Parameters.Add(new SqlParameter("@place", SqlDbType.VarChar)).Value = place.Text;
                addpub.Parameters.Add(new SqlParameter("@accepted", SqlDbType.Bit)).Value = accept;


                SqlParameter pid = addpub.Parameters.Add("@publid", SqlDbType.Int);
                pid.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                addpub.ExecuteNonQuery();
                successlabel.Text = "done, publication number = " + pid.Value.ToString();

                conn.Close();
            }

        }
    }
}