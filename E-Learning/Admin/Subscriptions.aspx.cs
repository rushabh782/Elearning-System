using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class Subscriptions : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMasterCourses();
            }
        }

        private void LoadMasterCourses()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("GetActiveMasterCourses", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlMasterCourse.DataSource = reader;
                    ddlMasterCourse.DataTextField = "title";
                    ddlMasterCourse.DataValueField = "master_course_id";
                    ddlMasterCourse.DataBind();

                    ddlMasterCourse.Items.Insert(0, new ListItem("-- Select Master Course --", ""));
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading master courses: " + ex.Message);
            }
        }

        protected void ddlMasterCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            chkSubCourses.Items.Clear();

            if (int.TryParse(ddlMasterCourse.SelectedValue, out int masterCourseId))
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    using (SqlCommand cmd = new SqlCommand("GetSubCoursesByMasterId", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@MasterCourseId", masterCourseId);

                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        chkSubCourses.DataSource = reader;
                        chkSubCourses.DataTextField = "title";
                        chkSubCourses.DataValueField = "sub_course_id";
                        chkSubCourses.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Error loading subcourses: " + ex.Message);
                }
            }
        }

        protected void btnAddSubscription_Click(object sender, EventArgs e)
        {
            string subscriptionType = ddlSubscriptionType.SelectedValue;
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            decimal.TryParse(txtPrice.Text.Trim(), out decimal price);
            int duration = 30;
            string imageUrl = txtImageUrl.Text.Trim();

            // Validation
            if (string.IsNullOrEmpty(subscriptionType) || string.IsNullOrEmpty(title) || price <= 0)
            {
                ShowMessage("⚠️ Please fill all required fields (Type, Title, Price).");
                return;
            }

            if (ddlMasterCourse.SelectedValue == "" || chkSubCourses.Items.Count == 0)
            {
                ShowMessage("⚠️ Please select a Master Course and its Sub Courses.");
                return;
            }

            bool anySelected = false;
            foreach (ListItem item in chkSubCourses.Items)
            {
                if (item.Selected)
                {
                    anySelected = true;
                    break;
                }
            }

            if (!anySelected)
            {
                ShowMessage("⚠️ Please select at least one Sub Course for this Subscription.");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    //  Insert Subscription via SP with OUTPUT parameter
                    using (SqlCommand cmd = new SqlCommand("AddSubscription", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Duration", duration);
                        cmd.Parameters.AddWithValue("@Type", subscriptionType);
                        cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);

                        //  Declare OUTPUT parameter
                        SqlParameter outputIdParam = new SqlParameter("@SubscriptionId", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputIdParam);

                        // Execute SP
                        cmd.ExecuteNonQuery();

                        // Get the generated subscription ID
                        int subscriptionId = Convert.ToInt32(outputIdParam.Value);

                        //  Insert selected SubCourses
                        foreach (ListItem item in chkSubCourses.Items)
                        {
                            if (item.Selected)
                            {
                                using (SqlCommand subCmd = new SqlCommand("AddSubscriptionCourse", conn))
                                {
                                    subCmd.CommandType = CommandType.StoredProcedure;
                                    subCmd.Parameters.AddWithValue("@SubscriptionId", subscriptionId);
                                    subCmd.Parameters.AddWithValue("@SubCourseId", item.Value);
                                    subCmd.ExecuteNonQuery();
                                }
                            }
                        }
                    }
                }

                ShowMessage("✅ Subscription added successfully!");
                ClearForm();
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, true);
            }
        }

        protected void btnViewSubscriptions_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ViewSubscriptions.aspx");
        }

        protected void ClearForm()
        {
            ddlSubscriptionType.SelectedIndex = 0;
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtImageUrl.Text = "";
            ddlMasterCourse.SelectedIndex = 0;
            chkSubCourses.Items.Clear();
        }

        private void ShowMessage(string message, bool isError = false)
        {
            lblMessage.Visible = true;
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            lblMessage.Text = message;
        }
    }
}