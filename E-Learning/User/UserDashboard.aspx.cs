using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.User
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

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
                lblName.Text = Session["name"] != null ? Session["name"].ToString() : "User";
                LoadDashboardStats();
                LoadSubscriptions();
                LoadMasterCourses();
                LoadSubCourses();
            }
        }

        private void LoadDashboardStats()
        {
            try
            {
                int userId = 0;
                int.TryParse(Session["user_id"]?.ToString() ?? "0", out userId);

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("GetUserDashboardStats", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read()) lblEnrolledCount.Text = reader["EnrolledCount"].ToString();
                        if (reader.NextResult() && reader.Read()) lblSubscriptionCount.Text = reader["SubscriptionCount"].ToString();
                        if (reader.NextResult() && reader.Read()) lblAllCourses.Text = reader["AllCourses"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading statistics: " + ex.Message);
            }
        }

        private void LoadSubscriptions()
        {
            try
            {
                int userId = 0;
                int.TryParse(Session["user_id"]?.ToString() ?? "0", out userId);

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("GetAllSubscriptions", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptSubscriptions.DataSource = dt;
                        rptSubscriptions.DataBind();
                        pnlSubscriptions.Visible = true;
                        pnlNoSubscriptions.Visible = false;
                    }
                    else
                    {
                        pnlSubscriptions.Visible = false;
                        pnlNoSubscriptions.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading subscriptions: " + ex.Message);
                pnlSubscriptions.Visible = false;
                pnlNoSubscriptions.Visible = true;
            }
        }

        private void LoadMasterCourses()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("GetAllMasterCourses", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptMasterCourses.DataSource = dt;
                        rptMasterCourses.DataBind();
                        pnlMasterCourses.Visible = true;
                        pnlNoMasterCourses.Visible = false;
                    }
                    else
                    {
                        pnlMasterCourses.Visible = false;
                        pnlNoMasterCourses.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading master courses: " + ex.Message);
                pnlMasterCourses.Visible = false;
                pnlNoMasterCourses.Visible = true;
            }
        }

        private void LoadSubCourses()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("GetAllSubCourses", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptSubCourses.DataSource = dt;
                        rptSubCourses.DataBind();
                        pnlSubCourses.Visible = true;
                        pnlNoSubCourses.Visible = false;
                    }
                    else
                    {
                        pnlSubCourses.Visible = false;
                        pnlNoSubCourses.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading sub courses: " + ex.Message);
                pnlSubCourses.Visible = false;
                pnlNoSubCourses.Visible = true;
            }
        }

        // Fixed handler for subscription repeater
        protected void RptSubscriptions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EnrollSubscription")
            {
                if (!int.TryParse(e.CommandArgument?.ToString(), out int subscriptionId))
                {
                    ShowMessage("Invalid Subscription ID.");
                    return;
                }

                int userId = 0;
                int.TryParse(Session["user_id"]?.ToString() ?? "0", out userId);

                try
                {
                    // Check if already subscribed
                    using (SqlConnection conn = new SqlConnection(connStr))
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM user_subscriptions WHERE user_id=@UserId AND subscription_id=@SubscriptionId", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@SubscriptionId", subscriptionId);
                        conn.Open();
                        int count = Convert.ToInt32(cmd.ExecuteScalar() ?? 0);
                        if (count > 0)
                        {
                            ShowMessage("You are already subscribed to this plan!");
                            return;
                        }
                    }

                    // Fetch subscription details for payment
                    var details = GetSubscriptionDetails(subscriptionId);
                    if (details == null || details.Price < 0)
                    {
                        ShowMessage("Unable to load subscription details. Please try again.");
                        return;
                    }

                    // Redirect to payment page with full params
                    Response.Redirect($"~/User/Payment.aspx?type=subscription&subscription_id={subscriptionId}&amount={details.Price}&item={Uri.EscapeDataString(details.Title)}&desc={Uri.EscapeDataString(details.Description)}", false);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message);
                }
            }
            else if (e.CommandName == "ViewSubscriptionDetails")
            {
                if (!int.TryParse(e.CommandArgument?.ToString(), out int subscriptionId))
                {
                    ShowMessage("Invalid Subscription ID.");
                    return;
                }
                // Handle view details if needed (existing logic)
            }
        }

        // Updated handler for master course repeater
        protected void rptMasterCourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EnrollMaster")
            {
                if (!int.TryParse(e.CommandArgument?.ToString(), out int masterCourseId))
                {
                    ShowMessage("Invalid Master Course ID.");
                    return;
                }

                int userId = 0;
                int.TryParse(Session["user_id"]?.ToString() ?? "0", out userId);

                try
                {
                    // Fetch master course details for payment
                    var details = GetMasterCourseDetails(masterCourseId);
                    if (details == null || details.Price < 0)
                    {
                        ShowMessage("Unable to load master course details. Please try again.");
                        return;
                    }

                    // Redirect to payment page with full params
                    Response.Redirect($"~/User/Payment.aspx?type=master&master_course_id={masterCourseId}&amount={details.Price}&item={Uri.EscapeDataString(details.Title)}&desc={Uri.EscapeDataString(details.Description)}", false);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message);
                }
            }
        }

        // Updated handler for sub-course repeater
        protected void rptSubCourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EnrollSub")
            {
                if (!int.TryParse(e.CommandArgument?.ToString(), out int subCourseId))
                {
                    ShowMessage("Invalid Sub Course ID.");
                    return;
                }

                int userId = 0;
                int.TryParse(Session["user_id"]?.ToString() ?? "0", out userId);

                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    using (SqlCommand cmd = new SqlCommand("CheckUserEnrollment", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@SubCourseId", subCourseId);
                        conn.Open();
                        int count = Convert.ToInt32(cmd.ExecuteScalar() ?? 0);
                        if (count > 0)
                        {
                            ShowMessage("You are already enrolled in this course!");
                            return;
                        }
                    }

                    // Fetch sub-course details for payment
                    var details = GetSubCourseDetails(subCourseId);
                    if (details == null || details.Price < 0)
                    {
                        ShowMessage("Unable to load sub-course details. Please try again.");
                        return;
                    }

                    // Redirect to payment page with full params
                    Response.Redirect($"~/User/Payment.aspx?type=sub&sub_course_id={subCourseId}&amount={details.Price}&item={Uri.EscapeDataString(details.Title)}&desc={Uri.EscapeDataString(details.Description)}", false);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message);
                }
            }
        }

        private void ShowMessage(string message)
        {
            string script = "alert('" + message.Replace("'", "\\'") + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
        }

        // Updated method to handle ItemDataBound for rptSubscriptions
        protected void rptSubscriptions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Find the details panel
                var detailsDiv = (System.Web.UI.WebControls.Panel)e.Item.FindControl("detailsDiv");
                if (detailsDiv != null)
                {
                    // Get the subscription_id
                    int subscriptionId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "subscription_id"));

                    // Set the data attribute for JavaScript
                    detailsDiv.Attributes.Add("data-subscription-id", subscriptionId.ToString());

                    // Load and populate details
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(connStr))
                        using (SqlCommand cmd = new SqlCommand("GetSubscriptionDetails", conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@SubscriptionId", subscriptionId);
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                string courses = "";
                                while (reader.Read())
                                {
                                    courses += reader["title"].ToString() + ", ";
                                }

                                if (string.IsNullOrEmpty(courses))
                                {
                                    courses = "<em>No courses included yet.</em>";
                                }
                                else
                                {
                                    courses = courses.TrimEnd(',', ' ');  // Remove trailing comma
                                }

                                // Add a Literal control to the Panel with the HTML content
                                var literal = new Literal();
                                literal.Text = $"<p><strong>Included Courses:</strong> {courses}</p>";
                                detailsDiv.Controls.Add(literal);
                            }
                        }
                    }
                    catch
                    {
                        // Add error message
                        var literal = new Literal();
                        literal.Text = "<p><em>Error loading details.</em></p>";
                        detailsDiv.Controls.Add(literal);
                    }
                }
            }
        }

        // Helper methods for fetching details
        private ItemDetails GetSubscriptionDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT title, description, price FROM Subscriptions WHERE subscription_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new ItemDetails
                    {
                        Title = reader["title"].ToString(),
                        Description = reader["description"].ToString(),
                        Price = Convert.ToDecimal(reader["price"])
                    };
                }
            }
            return null;
        }

        private ItemDetails GetMasterCourseDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT title, description, price FROM master_courses WHERE master_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new ItemDetails
                    {
                        Title = reader["title"].ToString(),
                        Description = reader["description"].ToString(),
                        Price = Convert.ToDecimal(reader["price"])
                    };
                }
            }
            return null;
        }

        private ItemDetails GetSubCourseDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT title, description, price FROM sub_courses WHERE sub_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new ItemDetails
                    {
                        Title = reader["title"].ToString(),
                        Description = reader["description"].ToString(),
                        Price = Convert.ToDecimal(reader["price"])
                    };
                }
            }
            return null;
        }

        // Helper class for item details
        public class ItemDetails
        {
            public string Title { get; set; }
            public string Description { get; set; }
            public decimal Price { get; set; }
        }
    }
}
