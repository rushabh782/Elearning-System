using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace E_Learning
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private SqlConnection con;
        // Add these private fields
        private string userStatusData = string.Empty;
        private string courseEnrollmentData = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "admin")
            {
                Response.Redirect("~/Login.aspx");
            }
            string cn = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            con = new SqlConnection(cn);
            con.Open();

            if (!IsPostBack)
            {
                LoadDashboardCounts();
                LoadUserStatusDistribution();      // NEW
                LoadCourseEnrollmentStats();       // NEW
                LoadMoMUserGrowth();  // ✨ ADD THIS LINE
            }
        }

        // NEW METHOD: Load User Status Distribution
        private void LoadUserStatusDistribution()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetUserStatusDistribution", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    var data = new
                    {
                        activeCount = Convert.ToInt32(reader["active_count"]),
                        inactiveCount = Convert.ToInt32(reader["inactive_count"]),
                        totalUsers = Convert.ToInt32(reader["total_users"])
                    };

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    userStatusData = js.Serialize(data);
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                // Log error
                userStatusData = "{\"activeCount\":0,\"inactiveCount\":0,\"totalUsers\":0}";
            }
        }

        // NEW METHOD: Load Course Enrollment Stats
        private void LoadCourseEnrollmentStats()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetCourseEnrollmentStats", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    var data = new
                    {
                        enrolledCount = Convert.ToInt32(reader["enrolled_courses_count"]),
                        archivedCount = Convert.ToInt32(reader["archived_courses_count"]),
                        activeCount = Convert.ToInt32(reader["active_courses_count"])
                    };

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    courseEnrollmentData = js.Serialize(data);
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                // Log error
                courseEnrollmentData = "{\"enrolledCount\":0,\"archivedCount\":0,\"activeCount\":0}";
            }
        }

        // NEW METHOD: Expose data to JavaScript (add this public property)
        public string UserStatusChartData
        {
            get { return userStatusData; }
        }

        public string CourseEnrollmentChartData
        {
            get { return courseEnrollmentData; }
        }

        private void LoadDashboardCounts()
        {
            GetActiveSubCourses();
            GetRegisteredUsers();
            GetTotalRevenue();
            GetPendingSubscriptions();
            LoadInactiveUsersCount();
            LoadInactiveCoursesCount();
        }

        private void GetActiveSubCourses()
        {
            SqlCommand cmd = new SqlCommand("CountActiveSubCourses", con);
            cmd.CommandType = CommandType.StoredProcedure;

            int activeCourses = Convert.ToInt32(cmd.ExecuteScalar());
            lblActiveCourses.Text = activeCourses.ToString();
        }

        private void GetRegisteredUsers()
        {
            SqlCommand cmd = new SqlCommand("CountEnrolledUsers", con);
            cmd.CommandType = CommandType.StoredProcedure;

            int totalUsers = Convert.ToInt32(cmd.ExecuteScalar());
            lblRegisteredUsers.Text = totalUsers.ToString();
        }

        private void GetTotalRevenue()
        {
            SqlCommand cmd = new SqlCommand("GetTotalRevenue", con);
            cmd.CommandType = CommandType.StoredProcedure;

            decimal revenue = Convert.ToDecimal(cmd.ExecuteScalar());
            lblTotalRevenue.Text = revenue.ToString("0.00");
        }

        private void GetPendingSubscriptions()
        {
            SqlCommand cmd = new SqlCommand("CountPendingSubscriptions", con);
            cmd.CommandType = CommandType.StoredProcedure;

            int pending = Convert.ToInt32(cmd.ExecuteScalar());
            lblPendingSubscriptions.Text = pending.ToString();
        }

        private void LoadInactiveUsersCount()
        {
            SqlCommand cmd = new SqlCommand("GetInactiveUsersCount", con);
            cmd.CommandType = CommandType.StoredProcedure;
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            lblInactiveUsers.Text = count.ToString();
        }

        private void LoadInactiveCoursesCount()
        {
            SqlCommand cmd = new SqlCommand("GetInactiveCoursesCount", con);
            cmd.CommandType = CommandType.StoredProcedure;
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            lblInactiveCourses.Text = count.ToString();
        }

        // NEW PROPERTY: Month-over-Month Growth Chart Data
        protected string MoMGrowthChartData { get; set; }

        // NEW METHOD: Load Month-over-Month User Growth
        private void LoadMoMUserGrowth()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetMonthlyUserRegistrations", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataReader reader = cmd.ExecuteReader();

                StringBuilder labels = new StringBuilder();
                StringBuilder data = new StringBuilder();

                bool first = true;
                while (reader.Read())
                {
                    if (!first)
                    {
                        labels.Append(",");
                        data.Append(",");
                    }

                    labels.Append("'").Append(reader["month_label"].ToString()).Append("'");
                    data.Append(reader["registration_count"].ToString());

                    first = false;
                }
                reader.Close();

                // Create JSON-like structure for Chart.js
                var chartData = new
                {
                    labels = labels.ToString(),
                    data = data.ToString()
                };

                JavaScriptSerializer js = new JavaScriptSerializer();
                MoMGrowthChartData = js.Serialize(chartData);
            }
            catch (Exception ex)
            {
                // Log error and provide fallback data
                MoMGrowthChartData = "{\"labels\":\"\",\"data\":\"\"}";
            }
        }

    }
}