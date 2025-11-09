using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class AddMasterCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCourseType.SelectedIndex = 0;
                pnlMasterCourse.Visible = false;
                pnlSubCourse.Visible = false;
                LoadMasterCourseDropdown();
            }
        }

        protected void ddlCourseType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selected = ddlCourseType.SelectedValue;

            pnlMasterCourse.Visible = selected == "master";
            pnlSubCourse.Visible = selected == "sub";
        }

        private void LoadMasterCourseDropdown()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT master_course_id, title FROM master_courses WHERE status = 'active'";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlMasterCourseList.DataSource = dt;
                ddlMasterCourseList.DataTextField = "title";
                ddlMasterCourseList.DataValueField = "master_course_id";
                ddlMasterCourseList.DataBind();

                ddlMasterCourseList.Items.Insert(0, new ListItem("Select Master Course", ""));
            }
        }

        protected void ButtonAdd_Click(object sender, EventArgs e)
        {
            string title = TextBoxTitle.Text.Trim();
            string description = TextBoxDescription.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO master_courses (title, description) VALUES (@title, @description)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@description", description);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            Response.Redirect("ViewMasterCourses.aspx");
        }

        protected void ButtonAddSub_Click(object sender, EventArgs e)
        {
            string title = TextBoxSubTitle.Text.Trim();
            string description = TextBoxSubDescription.Text.Trim();
            string masterId = ddlMasterCourseList.SelectedValue;

            if (string.IsNullOrEmpty(masterId))
            {
                // Optionally show an error message
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            int newSubCourseId = 0; // To store the ID of the new subcourse

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Modified query to insert and return the new ID using SCOPE_IDENTITY()
                string query = "INSERT INTO sub_courses (title, description, master_course_id) VALUES (@title, @description, @masterId); SELECT SCOPE_IDENTITY();";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@masterId", masterId);

                conn.Open();

                // Use ExecuteScalar() to get the new ID returned by SELECT SCOPE_IDENTITY()
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    newSubCourseId = Convert.ToInt32(result);
                }

                conn.Close();
            }

            if (newSubCourseId > 0)
            {
                // Redirect to the new AddTopics page, passing the new sub_course_id in the query string
                Response.Redirect($"AddTopics.aspx?sub_course_id={newSubCourseId}");
            }
            else
                {
                // Handle error - maybe redirect back to the view page
                Response.Redirect("ViewMasterCourses.aspx");
            }
        }

        protected void ButtonViewAll_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewMasterCourses.aspx");
        }
    }
}
