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
    public partial class viewPublication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("SuperHomePage.aspx");
        }
        protected void view(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (StudentId.Text == "")
            {
                Label f = new Label();
                f.Text = "Cannot enter empty field";

                form1.Controls.Add(f);
            }
           

           
            else
            {
                int id = Int16.Parse(StudentId.Text);


                SqlCommand ViewAStudentPublications = new SqlCommand("ViewAStudentPublications", conn);
                ViewAStudentPublications.CommandType = CommandType.StoredProcedure;

                ViewAStudentPublications.Parameters.Add(new SqlParameter("@StudentID", id));
                SqlParameter s = ViewAStudentPublications.Parameters.Add("@Exists", SqlDbType.Bit);
                s.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                ViewAStudentPublications.ExecuteNonQuery();
                conn.Close();



                if (s.Value.ToString() == "False")
                {
                    Label r = new Label();
                    r.Text = "There is no records";

                    form1.Controls.Add(r);
                }
                else
                {
                    conn.Open();
                    SqlDataReader rdr = ViewAStudentPublications.ExecuteReader(CommandBehavior.CloseConnection);



                    while (rdr.Read())
                    {
                        String publication = "";
                        if (rdr.GetValue(rdr.GetOrdinal("title")) is DBNull)
                        {
                            String np = "There is no records";
                            publication += "No records" + np;
                            break;
                        }
                        else
                        {

                            publication += "ID:" + rdr.GetInt32(rdr.GetOrdinal("id")) + System.Environment.NewLine +
                                "Title:" + rdr.GetString(rdr.GetOrdinal("title")) + " " +
                                "Date of Publication:" + rdr.GetDateTime(rdr.GetOrdinal("dateOfPublication")) + " " +
                                 "Place:" + rdr.GetString(rdr.GetOrdinal("place")) + " " +
                                  "Accepted:" + rdr.GetBoolean(rdr.GetOrdinal("accepted")) + " " +
                                   "Host:" + rdr.GetString(rdr.GetOrdinal("host"));
                        }

                        Label rec = new Label();
                        rec.Text = publication;

                        form1.Controls.Add(rec);

                    }
                }


                conn.Close();
            }



            
        }
    }
}