using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace E_Learning.Admin
{
    public partial class ArchivedCourse : System.Web.UI.Page
    {
        string connString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ELearningDB;Integrated Security=True;MultipleActiveResultSets=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMasterCourses();
            }
        }

        private void BindMasterCourses()
        {
            string query = @"
                SELECT m.master_course_id, m.title, m.status,
                       COUNT(s.sub_course_id) AS SubCourseCount
                FROM master_courses m
                LEFT JOIN sub_courses s ON m.master_course_id = s.master_course_id AND s.status='active'
                GROUP BY m.master_course_id, m.title, m.status";

            DataTable dt = GetData(query);
            gvMasterCourses.DataSource = dt;
            gvMasterCourses.DataBind();
        }

        protected void gvMasterCourses_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Archive")
            {
                int masterCourseId = Convert.ToInt32(e.CommandArgument);
                LoadSubCourses(masterCourseId);
                showModal();
            }
        }

        private void LoadSubCourses(int masterCourseId)
        {
            string query = "SELECT sub_course_id, title FROM sub_courses WHERE master_course_id=@masterCourseId AND status='active'";
            SqlCommand cmd = new SqlCommand(query);
            cmd.Parameters.AddWithValue("@masterCourseId", masterCourseId);

            DataTable dt = GetData(cmd);
            chkSubCourses.DataSource = dt;
            chkSubCourses.DataTextField = "title";
            chkSubCourses.DataValueField = "sub_course_id";
            chkSubCourses.DataBind();

            if (dt.Rows.Count > 0)
                lblMasterCourseTitle.Text = dt.Rows[0]["title"].ToString(); // optional: show master course title

            ViewState["MasterCourseID"] = masterCourseId;
        }

        protected void btnConfirmArchive_Click(object sender, EventArgs e)
        {
            int masterCourseId = Convert.ToInt32(ViewState["MasterCourseID"]);
            List<int> selectedSubCourses = new List<int>();

            foreach (System.Web.UI.WebControls.ListItem item in chkSubCourses.Items)
            {
                if (item.Selected)
                    selectedSubCourses.Add(Convert.ToInt32(item.Value));
            }

            if (selectedSubCourses.Count > 0)
            {
                // Archive selected subcourses
                string updateQuery = "UPDATE sub_courses SET status='archived' WHERE sub_course_id IN (" +
                                     string.Join(",", selectedSubCourses) + ")";
                ExecuteQuery(updateQuery);

                // Check if all subcourses are archived
                string checkQuery = "SELECT COUNT(*) FROM sub_courses WHERE master_course_id=@masterCourseId AND status='active'";
                SqlCommand cmd = new SqlCommand(checkQuery);
                cmd.Parameters.AddWithValue("@masterCourseId", masterCourseId);
                int remaining = Convert.ToInt32(ExecuteScalar(cmd));

                // Archive master course if no active subcourses left
                if (remaining == 0)
                {
                    string masterUpdate = "UPDATE master_courses SET status='archived' WHERE master_course_id=@masterCourseId";
                    cmd = new SqlCommand(masterUpdate);
                    cmd.Parameters.AddWithValue("@masterCourseId", masterCourseId);
                    ExecuteQuery(cmd);
                }
            }

            hideModal();
            BindMasterCourses();
        }

        protected void btnBackDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }

        // Helper Methods
        private DataTable GetData(string query)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        private DataTable GetData(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                cmd.Connection = con;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        private int ExecuteScalar(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                cmd.Connection = con;
                con.Open();
                int val = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
                return val;
            }
        }

        private void ExecuteQuery(string query)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private void ExecuteQuery(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private void showModal() { ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showModal();", true); }
        private void hideModal() { ScriptManager.RegisterStartupScript(this, GetType(), "hideModal", "hideModal();", true); }
    }
}
