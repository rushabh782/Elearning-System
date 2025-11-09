using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class AddTopics : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["sub_course_id"] != null)
                {
                    string subCourseId = Request.QueryString["sub_course_id"];
                    hfSubCourseId.Value = subCourseId;
                    LoadSubCourseDetails(subCourseId);
                    BindTopicsGrid(subCourseId);
                }
                else
                {
                    Response.Redirect("AddMasterCourse.aspx");
                }
            }
        }

        private void LoadSubCourseDetails(string subCourseId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT title FROM sub_courses WHERE sub_course_id = @subCourseId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@subCourseId", subCourseId);
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    lblSubCourseTitle.Text = $"Adding Topics for: {result.ToString()}";
                }
                else
                {
                    lblSubCourseTitle.Text = "Subcourse not found.";
                }
            }
        }

        private void BindTopicsGrid(string subCourseId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT topic_id, title, sequence_number FROM topics WHERE sub_course_id = @subCourseId ORDER BY sequence_number";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@subCourseId", subCourseId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvTopics.DataSource = dt;
                gvTopics.DataBind();
            }
        }

        protected void btnSaveTopic_Click(object sender, EventArgs e)
        {
            string title = txtTopicTitle.Text.Trim();
            string sequence = txtSequence.Text.Trim();
            string subCourseId = hfSubCourseId.Value;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO topics (title, sub_course_id, sequence_number) VALUES (@title, @subCourseId, @sequence)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@subCourseId", subCourseId);
                cmd.Parameters.AddWithValue("@sequence", sequence);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Clear form and refresh grid
            txtTopicTitle.Text = "";
            txtSequence.Text = "";
            BindTopicsGrid(subCourseId);
            lblStatus.Text = "Topic saved successfully!";
        }

        protected void gvTopics_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddMaterials")
            {
                string topicId = e.CommandArgument.ToString();
                // Pass both topic_id and sub_course_id so we can get back to this page
                string subCourseId = hfSubCourseId.Value;
                Response.Redirect($"AddMaterials.aspx?topic_id={topicId}&sub_course_id={subCourseId}");
            }
        }

        protected void gvTopics_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string topicId = gvTopics.DataKeys[e.RowIndex].Value.ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM topics WHERE topic_id = @topicId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@topicId", topicId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            BindTopicsGrid(hfSubCourseId.Value);
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewMasterCourses.aspx");
        }
    }
}