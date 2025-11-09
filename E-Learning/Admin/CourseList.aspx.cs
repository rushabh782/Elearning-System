using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class CourseList : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourseTypeDropdown();
                LoadCourseList();
            }
        }

        // 🔽 Load Dropdown with Master/Sub Course Options
        private void LoadCourseTypeDropdown()
        {
            ddlCourseFilter.Items.Clear();
            ddlCourseFilter.Items.Add(new ListItem("-- Select Course Type --", "0"));
            ddlCourseFilter.Items.Add(new ListItem("Master Courses", "master"));
            ddlCourseFilter.Items.Add(new ListItem("Sub Courses", "sub"));
        }

        // 📊 Load Course List Based on Selection
        protected void LoadCourseList()
        {
            string selected = ddlCourseFilter.SelectedValue;
            var data = new List<dynamic>();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString))
            {
                conn.Open();
                SqlCommand cmd;

                if (selected == "master")
                {
                    cmd = new SqlCommand(@"
                        SELECT m.master_course_id, m.title, m.status,
                               COUNT(s.sub_course_id) AS SubCourseCount
                        FROM master_courses m
                        LEFT JOIN sub_courses s ON m.master_course_id = s.master_course_id AND s.status='active'
                        GROUP BY m.master_course_id, m.title, m.status", conn);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        data.Add(new
                        {
                            MasterTitle = reader["title"].ToString(),
                            SubTitle = reader["SubCourseCount"].ToString() + " sub course(s)",
                            Status = reader["status"].ToString(),
                            CourseId = reader["master_course_id"].ToString(),
                            IsMaster = "true"
                        });
                    }
                    reader.Close();
                }
                else if (selected == "sub")
                {
                    cmd = new SqlCommand(@"
                        SELECT s.sub_course_id, s.title AS SubTitle, s.status, m.title AS MasterTitle
                        FROM sub_courses s
                        JOIN master_courses m ON m.master_course_id = s.master_course_id", conn);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        data.Add(new
                        {
                            MasterTitle = reader["MasterTitle"].ToString(),
                            SubTitle = reader["SubTitle"].ToString(),
                            Status = reader["status"].ToString(),
                            CourseId = reader["sub_course_id"].ToString(),
                            IsMaster = "false"
                        });
                    }
                    reader.Close();
                }
                else
                {
                    gvCourses.DataSource = null;
                    gvCourses.DataBind();
                    return;
                }
            }

            gvCourses.DataSource = data;
            gvCourses.DataBind();
        }

        // 🔄 Dropdown Selection Changed
        protected void ddlCourseFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourseList();
        }

        // 🔁 Status Dropdown Changed in GridView
        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;

            string newStatus = ddl.SelectedValue;
            string isMaster = ((HiddenField)row.FindControl("hdnCourseType")).Value;
            string courseId = ((HiddenField)row.FindControl("hdnCourseId")).Value;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString))
            {
                conn.Open();

                if (isMaster == "true")
                {
                    SqlCommand cmdMaster = new SqlCommand("UPDATE master_courses SET status=@status WHERE master_course_id=@id", conn);
                    cmdMaster.Parameters.AddWithValue("@status", newStatus);
                    cmdMaster.Parameters.AddWithValue("@id", courseId);
                    cmdMaster.ExecuteNonQuery();

                    SqlCommand cmdSubs = new SqlCommand("UPDATE sub_courses SET status=@status WHERE master_course_id=@id", conn);
                    cmdSubs.Parameters.AddWithValue("@status", newStatus);
                    cmdSubs.Parameters.AddWithValue("@id", courseId);
                    cmdSubs.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand cmdSub = new SqlCommand("UPDATE sub_courses SET status=@status WHERE sub_course_id=@id", conn);
                    cmdSub.Parameters.AddWithValue("@status", newStatus);
                    cmdSub.Parameters.AddWithValue("@id", courseId);
                    cmdSub.ExecuteNonQuery();
                }
            }

            LoadCourseList(); // Refresh table
        }

        // 🕓 Access Control Placeholder
        private bool IsCourseAccessible(int subCourseId, int userId)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) FROM sub_courses s
                    LEFT JOIN user_courses uc ON uc.sub_course_id = s.sub_course_id AND uc.user_id = @userId
                    WHERE s.sub_course_id = @subId AND (s.status = 'active' OR uc.valid_until >= GETDATE())", conn);
                cmd.Parameters.AddWithValue("@subId", subCourseId);
                cmd.Parameters.AddWithValue("@userId", userId);
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }
}