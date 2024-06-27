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
    public partial class addDefense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void add(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (SerialNo.Text == "" || date.Text == "" || DefenseLocation.Text == "")
            {
                Label z = new Label();
                z.Text = "Please enter empty fields";
                form1.Controls.Add(z);
            }
            else
            {

                int id = Int16.Parse(SerialNo.Text);
                String ddate = date.Text;
                String location = DefenseLocation.Text;

                SqlCommand thesistypee = new SqlCommand("thesistypee", conn);
                thesistypee.CommandType = CommandType.StoredProcedure;

                thesistypee.Parameters.Add(new SqlParameter("@ThesisSerialNo", id));
                SqlParameter success = thesistypee.Parameters.Add("@Success", SqlDbType.Bit);
                success.Direction = System.Data.ParameterDirection.Output;
                conn.Open();
                thesistypee.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "True")
                {
                    SqlCommand AddDefenseGucian = new SqlCommand("AddDefenseGucian", conn);
                    AddDefenseGucian.CommandType = CommandType.StoredProcedure;

                    AddDefenseGucian.Parameters.Add(new SqlParameter("@ThesisSerialNo", id));
                    AddDefenseGucian.Parameters.Add(new SqlParameter("@DefenseDate", ddate));
                    AddDefenseGucian.Parameters.Add(new SqlParameter("@DefenseLocation", location));


                    SqlParameter s = AddDefenseGucian.Parameters.Add("@Success", SqlDbType.Bit);
                    s.Direction = System.Data.ParameterDirection.Output;
                    SqlParameter exists = AddDefenseGucian.Parameters.Add("@exists", SqlDbType.Bit);
                    exists.Direction = System.Data.ParameterDirection.Output;

                    conn.Open();
                    AddDefenseGucian.ExecuteNonQuery();
                    conn.Close();

                    if (exists.Value.ToString() == "True")
                    {
                        Label ex = new Label();
                        ex.Text = "Cannot add an already existing defense";
                        form1.Controls.Add(ex);
                    }

                    if (s.Value.ToString() == "True")
                    {
                        Label ee = new Label();
                        ee.Text = "Defense added successfully";
                        form1.Controls.Add(ee);
                    }
                    else if (s.Value.ToString() == "False")
                    {
                        Label c = new Label();
                        c.Text = "Thesis doesn't exist. ";
                        form1.Controls.Add(c);


                    }



                }

                else if (success.Value.ToString() == "False")
                {
                    SqlCommand AddDefenseNonGucian = new SqlCommand("AddDefenseNonGucian", conn);
                    AddDefenseNonGucian.CommandType = CommandType.StoredProcedure;

                    AddDefenseNonGucian.Parameters.Add(new SqlParameter("@ThesisSerialNo", id));
                    AddDefenseNonGucian.Parameters.Add(new SqlParameter("@DefenseDate", ddate));
                    AddDefenseNonGucian.Parameters.Add(new SqlParameter("@DefenseLocation", location));
                    SqlParameter s = AddDefenseNonGucian.Parameters.Add("@Success", SqlDbType.Bit);
                    s.Direction = System.Data.ParameterDirection.Output;
                    SqlParameter exists = AddDefenseNonGucian.Parameters.Add("@exists", SqlDbType.Bit);
                    exists.Direction = System.Data.ParameterDirection.Output;
                    SqlParameter grade = AddDefenseNonGucian.Parameters.Add("@grade", SqlDbType.Bit);
                    grade.Direction = System.Data.ParameterDirection.Output;

                    conn.Open();
                    AddDefenseNonGucian.ExecuteNonQuery();
                    conn.Close();
                    if (exists.Value.ToString() == "True")
                    {
                        Label ex = new Label();
                        ex.Text = "Cannot add an already existing defense";
                        form1.Controls.Add(ex);
                    }

                    else if (s.Value.ToString() == "True" && grade.Value.ToString() == "True")
                    {
                        Label ee = new Label();
                        ee.Text = "Defense added successfully";
                        form1.Controls.Add(ee);
                    }
                    else if (s.Value.ToString() == "False")
                    {
                        Label c = new Label();
                        c.Text = "Thesis doesn't exist. ";
                        form1.Controls.Add(c);


                    }
                    else if (grade.Value.ToString() == "False")
                    {
                        Label c = new Label();
                        c.Text = "Cannot add defense grade is lower than 50";
                        form1.Controls.Add(c);
                    }
                }
                conn.Close();
            }

        }
        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("SuperHomePage.aspx");
        }
    }
}