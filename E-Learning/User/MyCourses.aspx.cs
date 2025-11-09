using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.User
{
    public partial class MyCourses : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MyUser"] == null || Session["role"] == null || Session["role"].ToString().ToLower() != "user")
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadEnrolledCourses();
            }
        }

        protected string GetProgressWidth(object progressValue)
        {
            if (progressValue != DBNull.Value)
            {
                decimal progress = (decimal)progressValue;
                return Math.Round(progress, 0) + "%";  // Round to whole number for clean CSS
            }
            return "0%";
        }

        private void LoadEnrolledCourses()
        {
            int userId = int.TryParse(Session["user_id"]?.ToString() ?? "0", out var id) ? id : 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("GetUserEnrolledCourses", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptEnrolledCourses.DataSource = dt;
                        rptEnrolledCourses.DataBind();
                        pnlNoCourses.Visible = false;
                    }
                    else
                    {
                        pnlNoCourses.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                // Log or handle error (e.g., show a message)
                pnlNoCourses.Visible = true;
            }
        }

        // Fetch enrolled sub-courses for a master (direct DB query, no RowFilter)
        protected DataTable GetSubCoursesForMaster(int masterId)
        {
            int userId = int.TryParse(Session["user_id"]?.ToString() ?? "0", out var id) ? id : 0;
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT sc.sub_course_id AS course_id, sc.title, CAST(sc.description AS NVARCHAR(MAX)) AS description, uce.progress
                    FROM sub_courses sc
                    INNER JOIN user_course_enrollments uce ON sc.sub_course_id = uce.sub_course_id AND uce.user_id = @UserId
                    WHERE sc.master_course_id = @MasterId", conn);
                cmd.Parameters.AddWithValue("@MasterId", masterId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        // Bind nested Repeater for masters
        protected void rptEnrolledCourses_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = (DataRowView)e.Item.DataItem;
                string courseType = drv["course_type"].ToString();
                if (courseType == "master")
                {
                    int masterId = (int)drv["course_id"];
                    Repeater rptSubCourses = (Repeater)e.Item.FindControl("rptSubCourses");
                    if (rptSubCourses != null)
                    {
                        rptSubCourses.DataSource = GetSubCoursesForMaster(masterId);
                        rptSubCourses.DataBind();
                    }
                }
            }
        }
    }
}