using System;
using System.Data.SqlClient;
using System.Configuration;

namespace E_Learning.Admin
{
    public partial class DeleteSubscription : System.Web.UI.Page
    {
        private int subscriptionId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    subscriptionId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadSubscription(subscriptionId);
                }
                else
                {
                    Response.Redirect("ViewSubscriptions.aspx");
                }
            }
        }

        private void LoadSubscription(int id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ElearningDB"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT title FROM subscriptions WHERE subscription_id=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    lblSubTitle.Text = $"Are you sure you want to delete subscription: <b>{result.ToString()}</b>?";
                }
                else
                {
                    lblMessage.Text = "Subscription not found!";
                    btnDelete.Enabled = false;
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            subscriptionId = Convert.ToInt32(Request.QueryString["id"]);
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ElearningDB"].ConnectionString))
            {
                con.Open();
                // Optional: delete related subcourses first
                SqlCommand cmd1 = new SqlCommand("DELETE FROM subscription_courses WHERE subscription_id=@id", con);
                cmd1.Parameters.AddWithValue("@id", subscriptionId);
                cmd1.ExecuteNonQuery();

                SqlCommand cmd = new SqlCommand("DELETE FROM subscriptions WHERE subscription_id=@id", con);
                cmd.Parameters.AddWithValue("@id", subscriptionId);
                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    Response.Redirect("ViewSubscriptions.aspx");
                }
                else
                {
                    lblMessage.Text = "Error deleting subscription!";
                }
            }
        }
    }
}