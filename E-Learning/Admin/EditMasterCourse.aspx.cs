using System;
using System.Data.SqlClient;

namespace E_Learning.Admin
{
    public partial class EditMasterCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                string courseId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(courseId))
                {
                    LoadCourse(courseId);
                }
                else
                {
                    Response.Redirect("ViewMasterCourses.aspx");
                }
            }
        }

        private void LoadCourse(string id)
        {
            string connStr = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ELearningDB;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open(); // ✅ You must open the connection before executing the query
                string query = "SELECT title, description FROM master_courses WHERE master_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    TextBoxTitle.Text = reader["title"].ToString();
                    TextBoxDescription.Text = reader["description"].ToString();
                }
                else
                {
                    Response.Redirect("ViewMasterCourses.aspx");
                }

                reader.Close();
            }
        }

        protected void ButtonUpdate_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["id"];
            string title = TextBoxTitle.Text.Trim();
            string description = TextBoxDescription.Text.Trim();

            string connStr = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ELearningDB;Integrated Security=True;MultipleActiveResultSets=True";
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE master_courses SET title = @title, description = @description WHERE master_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@id", courseId);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ViewMasterCourses.aspx");
        }

        protected void ButtonViewAll_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewMasterCourses.aspx");
        }
    }
}