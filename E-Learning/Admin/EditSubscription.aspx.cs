using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace E_Learning.Admin
{
    public partial class EditSubscription : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["ElearningDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int subId = Convert.ToInt32(Request.QueryString["id"]);
                LoadSubscription(subId);
            }
        }

        private void LoadSubscription(int id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ElearningDB"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
            SELECT s.title, s.description, s.price, s.duration_days, s.subscription_type,
                   STUFF((SELECT ', ' + sc.title
                          FROM subscription_courses scs
                          INNER JOIN sub_courses sc ON scs.sub_course_id = sc.sub_course_id
                          WHERE scs.subscription_id = s.subscription_id
                          FOR XML PATH('')), 1, 2, '') AS SubCoursesList
            FROM subscriptions s
            WHERE s.subscription_id = @id", con);
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtTitle.Text = reader["title"].ToString();
                    txtDescription.Text = reader["description"].ToString();
                    txtPrice.Text = reader["price"].ToString();
                    txtDuration.Text = reader["duration_days"].ToString();
                    ddlType.SelectedValue = reader["subscription_type"].ToString();
                    txtSubCourses.Text = reader["SubCoursesList"].ToString();
                }
                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int subId = Convert.ToInt32(Request.QueryString["id"]);
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ElearningDB"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
            UPDATE subscriptions
            SET title=@title, description=@desc, price=@price, duration_days=@duration, subscription_type=@type
            WHERE subscription_id=@id", con);
                cmd.Parameters.AddWithValue("@title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@desc", txtDescription.Text);
                cmd.Parameters.AddWithValue("@price", txtPrice.Text);
                cmd.Parameters.AddWithValue("@duration", txtDuration.Text);
                cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
                cmd.Parameters.AddWithValue("@id", subId);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ViewSubscriptions.aspx");
        }
    }
}