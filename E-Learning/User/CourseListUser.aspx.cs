using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace E_Learning.User
{
    public partial class CourseListUser : System.Web.UI.Page
    {
        SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Connection Setup
            string cnf = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            con = new SqlConnection(cnf);
            con.Open();

            if (!IsPostBack)
            {
                if (Session["user_id"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }

                BindUserCourses();
            }
        }

        private void BindUserCourses()
        {
            int userId = Convert.ToInt32(Session["user_id"]);

            SqlCommand cmd = new SqlCommand("GetUserCourses", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                gvUserCourses.DataSource = dt;
                gvUserCourses.DataBind();
            }
            else
            {
                gvUserCourses.DataSource = null;
                gvUserCourses.DataBind();

                Response.Write("<script>alert('No Courses Found!');</script>");
            }
        }
    }
}
