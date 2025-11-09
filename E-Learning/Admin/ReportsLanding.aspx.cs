using E_Learning.User;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace E_Learning
{
    public partial class ReportsLanding : System.Web.UI.Page
    {
        private SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check admin authorization
            if (Session["role"] == null || Session["role"].ToString() != "admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            string cn = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            con = new SqlConnection(cn);
            con.Open();

            if (!IsPostBack)
            {
                LoadQuickStats();
            }
        }

        private void LoadQuickStats()
        {
            try
            {
                // Total Active Courses
                SqlCommand cmdCourses = new SqlCommand("CountActiveSubCourses", con);
                cmdCourses.CommandType = CommandType.StoredProcedure;
                // Handle error gracefully
                lblTotalCourses.Text = "0";
                lblTotalUsers.Text = "0";
                lblMonthlyRevenue.Text = "0.00";
            }
            catch (Exception ex)
            {
                ShowError("Error loading active subcourses report: " + ex.Message);
            }

        }

        // Course Completion Rate Report
        protected void btnViewCompletionReport_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetSubCourseCompletionRates", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "📈 Course Completion Rate Deep Dive";
                pnlReportData.Visible = true;

                // Store data for export
                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "Course_Completion_Rates";
            }
            catch (Exception ex)
            {
                ShowError("Error loading completion report: " + ex.Message);
            }
        }

        // Enrollment vs Revenue Report
        protected void btnViewEnrollmentRevenue_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetCourseEnrollmentVsRevenue", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StartDate", DateTime.Now.AddMonths(-6));
                cmd.Parameters.AddWithValue("@EndDate", DateTime.Now);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "💰 Most Enrolled vs Highest Revenue (Last 6 Months)";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "Enrollment_Revenue_Report";
            }
            catch (Exception ex)
            {
                ShowError("Error loading enrollment/revenue report: " + ex.Message);
            }
        }

        // User Engagement Report
        protected void btnViewEngagement_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetUserEngagementMetrics", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@InactiveDays", 90);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "🔥 User Engagement Heatmap";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "User_Engagement_Report";
            }
            catch (Exception ex)
            {
                ShowError("Error loading engagement report: " + ex.Message);
            }
        }

        // Dormant Users Report
        protected void btnViewDormantUsers_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetDormantUsers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DormantDays", 90);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "😴 Dormant Users Analysis (90+ Days Inactive)";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "Dormant_Users_Report";
            }
            catch (Exception ex)
            {
                ShowError("Error loading dormant users report: " + ex.Message);
            }
        }

        // Transaction Breakdown Report
        protected void btnViewTransactions_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetTransactionBreakdown", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StartDate", new DateTime(DateTime.Now.Year, 1, 1));
                cmd.Parameters.AddWithValue("@EndDate", DateTime.Now);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "💳 Transaction Breakdown by Type (Current Year)";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "Transaction_Breakdown_Report";
            }
            catch (Exception ex)
            {
                ShowError("Error loading transaction report: " + ex.Message);
            }
        }

        // Revenue by Course Report
        protected void btnViewRevenueByCourse_Click(object sender, EventArgs e)
        {
            try
            {
                // Use same stored procedure as enrollment/revenue
                SqlCommand cmd = new SqlCommand("GetCourseEnrollmentVsRevenue", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StartDate", DateTime.Now.AddMonths(-6));
                cmd.Parameters.AddWithValue("@EndDate", DateTime.Now);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Create a view sorted by revenue
                DataView dv = dt.DefaultView;
                dv.Sort = "total_revenue DESC";
                DataTable sortedDt = dv.ToTable();

                gvReportData.DataSource = sortedDt;
                gvReportData.DataBind();

                lblReportTitle.Text = "📊 Revenue by Course Category";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = sortedDt;
                ViewState["CurrentReportName"] = "Revenue_By_Course_Report";
            }
            catch (Exception ex)
            {
                ShowError("Error loading revenue by course report: " + ex.Message);
            }
        }

        // Content Gaps Report
        protected void btnViewContentGaps_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("GetContentDistribution", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "🧩 Content Gaps - Material Type Distribution";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "Content_Distribution_Report";
            }
            catch (Exception ex)
            {
                ShowError("Error loading content gaps report: " + ex.Message);
            }
        }

        // Quality Metrics Report
        protected void btnViewQualityMetrics_Click(object sender, EventArgs e)
        {
            try
            {
                // Reuse completion rates for quality metrics
                SqlCommand cmd = new SqlCommand("GetSubCourseCompletionRates", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Add quality score column
                dt.Columns.Add("quality_score", typeof(string));
                foreach (DataRow row in dt.Rows)
                {
                    decimal completionRate = Convert.ToDecimal(row["CompletionRatePercentage"]);
                    if (completionRate >= 80)
                        row["quality_score"] = "Excellent";
                    else if (completionRate >= 60)
                        row["quality_score"] = "Good";
                    else if (completionRate >= 40)
                        row["quality_score"] = "Average";
                    else
                        row["quality_score"] = "Needs Improvement";
                }

                gvReportData.DataSource = dt;
                gvReportData.DataBind();

                lblReportTitle.Text = "✅ Course Quality Metrics";
                pnlReportData.Visible = true;

                ViewState["CurrentReportData"] = dt;
                ViewState["CurrentReportName"] = "Course_Quality_Metrics";
            }
            catch (Exception ex)
            {
                ShowError("Error loading quality metrics report: " + ex.Message);
            }
        }

        // Export to CSV
        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = (DataTable)ViewState["CurrentReportData"];
                string reportName = ViewState["CurrentReportName"]?.ToString() ?? "Report";

                if (dt != null && dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();

                    // Add column headers
                    for (int i = 0; i < dt.Columns.Count; i++)
                    {
                        sb.Append(dt.Columns[i].ColumnName);
                        if (i < dt.Columns.Count - 1)
                            sb.Append(",");
                    }
                    sb.AppendLine();

                    // Add rows
                    foreach (DataRow row in dt.Rows)
                    {
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            sb.Append(row[i].ToString().Replace(",", ";"));
                            if (i < dt.Columns.Count - 1)
                                sb.Append(",");
                        }
                        sb.AppendLine();
                    }

                    // Send file to browser
                    Response.Clear();
                    Response.ContentType = "text/csv";
                    Response.AddHeader("Content-Disposition", $"attachment;filename={reportName}_{DateTime.Now:yyyyMMdd}.csv");
                    Response.Write(sb.ToString());
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                ShowError("Error exporting to CSV: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            // You can implement a proper error display mechanism
            lblReportTitle.Text = "Error: " + message;
            lblReportTitle.ForeColor = System.Drawing.Color.Red;
            pnlReportData.Visible = true;
        }

        protected override void OnUnload(EventArgs e)
        {
            if (con != null && con.State == ConnectionState.Open)
            {
                con.Close();
            }
            base.OnUnload(e);
        }
    }
}
