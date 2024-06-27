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
    public partial class StudentViewProfile : System.Web.UI.Page
    {
        protected void backtohome(object sender, EventArgs e)
        {
            String theType = (String)Session["usertype"];

            if (theType == "GucianStudent")
                Response.Redirect("GucianStudentHomePage.aspx");
            if (theType == "NonGucianStudent")
                Response.Redirect("NonGucianStudentHomePage.aspx");


        }
        protected void Page_Load(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand viewprof = new SqlCommand("viewMyProfile", conn);
            viewprof.CommandType = CommandType.StoredProcedure;


            int studentid = (int)Session["user"];
            IDLABEL.Text = studentid.ToString();



            //this should be the only input
            viewprof.Parameters.Add(new SqlParameter("@studentId", SqlDbType.VarChar)).Value = studentid;





            conn.Open();
            SqlDataReader rdr = viewprof.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String fname = rdr.GetString(rdr.GetOrdinal("firstName"));
                FNLABEL.Text = fname;

                String lname = rdr.GetString(rdr.GetOrdinal("lastName"));
                LNLABEL.Text = lname;


                String type = "not specified";
                if(!rdr.IsDBNull(rdr.GetOrdinal("type")))
                    type = rdr.GetString(rdr.GetOrdinal("type"));
                TYPELABEL.Text = type;

                String faculty = rdr.GetString(rdr.GetOrdinal("faculty"));
                FACLABEL.Text = faculty;

                String address = rdr.GetString(rdr.GetOrdinal("address"));
                ADDRESSLABEL.Text = address;

                String gpa = "not specified";
                if (!rdr.IsDBNull(rdr.GetOrdinal("gpa")))
                    gpa = rdr.GetDecimal(rdr.GetOrdinal("GPA")).ToString();
                GPALABEL.Text = gpa;

                if (Session["usertype"].Equals("GucianStudent")) {

                    String undergradid = "not specified";
                    if (!rdr.IsDBNull(rdr.GetOrdinal("undergradID")))
                        undergradid = rdr.GetInt32(rdr.GetOrdinal("undergradID")).ToString();
                    UNIDLABEL.Text = undergradid;


            }
                String email = rdr.GetString(rdr.GetOrdinal("email"));
                MAILLABEL.Text = email;
            }
                conn.Close();



        }
    }
    }
