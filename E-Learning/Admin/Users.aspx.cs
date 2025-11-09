using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT user_id, name, email, role, status, profile
                    FROM users
                    WHERE role = 'user'
                    ORDER BY user_id DESC";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }

            rptUsers.DataSource = dt;
            rptUsers.DataBind();

            // ensure UpdatePanel refreshes (if available)
            if (upUsers != null)
            {
                upUsers.Update();
            }
        }

        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ChangeStatus")
            {
                // expected format: "userId|status"
                string arg = e.CommandArgument == null ? "" : e.CommandArgument.ToString();
                string[] parts = arg.Split('|');
                string userId = parts.Length > 0 ? parts[0] : "";
                string currentStatus = parts.Length > 1 ? parts[1] : "inactive";

                // store id for confirm button usage
                hfUserId.Value = userId;

                // preselect radio buttons
                bool isActive = string.Equals(currentStatus, "active", StringComparison.OrdinalIgnoreCase);
                rbActive.Checked = isActive;
                rbInactive.Checked = !isActive;

                // show modal (use ScriptManager so it works with partial postbacks)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowStatusModal", "$('#statusModal').modal('show');", true);
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string newStatus = rbActive.Checked ? "active" : "inactive";

            if (!string.IsNullOrEmpty(hfUserId.Value))
            {
                string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "UPDATE users SET status=@status WHERE user_id=@id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@status", newStatus);
                        cmd.Parameters.AddWithValue("@id", hfUserId.Value);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            LoadUsers(); // refresh repeater

            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideStatusModal", @"
        $('#statusModal').modal('hide');
        $('body').removeClass('modal-open');
        $('.modal-backdrop').remove();
    ", true);
        }

    }
}
