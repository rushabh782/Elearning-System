using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace E_Learning.User
{
    public partial class DeleteAccount : System.Web.UI.Page
    {
        private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MyUser"] == null)
            {
                Response.Write("<script>alert('You need to log in again'); window.location='Login.aspx';</script>");
            }
            else if (!IsPostBack)
            {
                con.Open(); // ✅ Open once, sir-style
                FetchProfile();
            }
        }

        private void FetchProfile()
        {
            SqlCommand cmd = new SqlCommand("FindProfileByID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@email_id", Session["MyUser"].ToString());

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            btnConfirmDelete.DataSource = ds;
            btnConfirmDelete.DataBind();
        }

        protected void btnConfirmDelete_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open(); // ✅ open manually if closed
                }

                SqlCommand cmd = new SqlCommand("DeleteUserByID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(e.CommandArgument));
                cmd.ExecuteNonQuery();

                Session.Clear();
                Session.Abandon();
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();

            }
        }
    }
}