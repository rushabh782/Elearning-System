using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using Razorpay.Api; // Ensure Razorpay NuGet package is installed

namespace E_Learning.User
{
    public partial class Payment : System.Web.UI.Page
    {
        private string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString; // Adjust to your config key

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string type = Request.QueryString["type"];
                string subscriptionId = Request.QueryString["subscription_id"];
                string masterCourseId = Request.QueryString["master_course_id"];
                string subCourseId = Request.QueryString["sub_course_id"];
                string amountStr = Request.QueryString["amount"];
                string itemName = Request.QueryString["item"] ?? "Unknown Item";
                string itemDesc = Request.QueryString["desc"] ?? "No description";

                decimal amount = 0;

                // If amount is not in query string, fetch from DB
                if (string.IsNullOrEmpty(amountStr))
                {
                    try
                    {
                        if (type == "subscription" && !string.IsNullOrEmpty(subscriptionId))
                        {
                            var details = GetSubscriptionDetails(int.Parse(subscriptionId));
                            if (details != null)
                            {
                                amount = details.Price;
                                itemName = details.Title;
                                itemDesc = details.Description;
                            }
                        }
                        else if (type == "master" && !string.IsNullOrEmpty(masterCourseId))
                        {
                            var details = GetMasterCourseDetails(int.Parse(masterCourseId));
                            if (details != null)
                            {
                                amount = details.Price;
                                itemName = details.Title;
                                itemDesc = details.Description;
                            }
                        }
                        else if (type == "sub" && !string.IsNullOrEmpty(subCourseId))
                        {
                            var details = GetSubCourseDetails(int.Parse(subCourseId));
                            if (details != null)
                            {
                                amount = details.Price;
                                itemName = details.Title;
                                itemDesc = details.Description;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("DB Error in Page_Load: " + ex.Message);
                        pnlError.Visible = true;
                        btnPayNow.Enabled = false;
                        return;
                    }
                }
                else
                {
                    decimal.TryParse(amountStr, out amount);
                }

                // If still no amount, show error
                if (amount <= 0)
                {
                    pnlError.Visible = true;
                    btnPayNow.Enabled = false;
                    return;
                }

                // Set labels
                lblAmount.Text = "₹" + amount.ToString("F2");
                lblItemName.Text = itemName;
                lblItemDescription.Text = itemDesc;

                // Prefill user details (ensure Session is set during login)
                txtName.Text = Session["UserName"]?.ToString() ?? "";
                txtEmail.Text = Session["UserEmail"]?.ToString() ?? "";
                txtContact.Text = Session["UserContact"]?.ToString() ?? "";
            }
        }

        protected void btnPayNow_Click(object sender, EventArgs e)
        {
            // Validate inputs
            if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtContact.Text))
            {
                pnlError.Visible = true;
                return;
            }

            // Get amount from label
            string amountStr = lblAmount.Text.Replace("₹", "");
            if (!decimal.TryParse(amountStr, out decimal amount))
            {
                pnlError.Visible = true;
                return;
            }

            // Razorpay integration
            string keyId = "rzp_test_Kl7588Yie2yJTV"; // Use live keys in production
            string keySecret = "6dN9Nqs7M6HPFMlL45AhaTgp";

            RazorpayClient razorpayClient = new RazorpayClient(keyId, keySecret);

            // Create an order
            Dictionary<string, object> options = new Dictionary<string, object>();
            options.Add("amount", amount * 100); // Amount in paisa
            options.Add("currency", "INR");
            options.Add("receipt", "order_" + Guid.NewGuid().ToString().Substring(0, 32)); // Shortened to <=40 chars
            options.Add("payment_capture", 1);

            Razorpay.Api.Order order = razorpayClient.Order.Create(options);
            string orderId = order["id"].ToString();

            // Generate Razorpay script with dynamic user details
            string razorpayScript = $@"
            var options = {{
                'key': '{keyId}',
                'amount': {amount * 100},
                'currency': 'INR',
                'name': 'Masstech Business Solutions Pvt.Ltd',
                'description': 'Checkout Payment for {lblItemName.Text}',
                'order_id': '{orderId}',
                'handler': function(response) {{
                    // Handle success - redirect or show message
                    document.getElementById('loadingSpinner').style.display = 'block';
                    window.location.href = 'UserDashboard.aspx?payment=success&payment_id=' + response.razorpay_payment_id;
                }},
                'prefill': {{
                    'name': '{txtName.Text}',
                    'email': '{txtEmail.Text}',
                    'contact': '{txtContact.Text}'
                }},
                'theme': {{
                    'color': '#4f46e5'
                }}
            }};
            var rzp1 = new Razorpay(options);
            rzp1.open();";

            // Register script
            ClientScript.RegisterStartupScript(this.GetType(), "razorpayScript", razorpayScript, true);

            // Show loading
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showSpinner", "document.getElementById('loadingSpinner').style.display = 'block';", true);
        }

        // Helper methods (complete implementations)
        private ItemDetails GetSubscriptionDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT subscription_title, description, price FROM Subscriptions WHERE subscription_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new ItemDetails
                    {
                        Title = reader["subscription_title"].ToString(),
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
                string query = "SELECT title, description, price FROM MasterCourses WHERE master_course_id = @id";
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
                string query = "SELECT title, description, price FROM SubCourses WHERE sub_course_id = @id";
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