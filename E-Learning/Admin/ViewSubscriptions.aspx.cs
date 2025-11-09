using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class ViewSubscriptions : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

        // Pagination variables
        private int PageSize = 10; // 10 records per page

        private int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSubscriptions();
            }
        }

        private void LoadSubscriptions()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = @"
                        SELECT * FROM (
                            SELECT s.subscription_id, s.title, s.description, s.price, s.duration_days, s.subscription_type,
                                STUFF(
                                    (SELECT ', ' + sc.title
                                     FROM subscription_courses scs
                                     INNER JOIN sub_courses sc ON scs.sub_course_id = sc.sub_course_id
                                     WHERE scs.subscription_id = s.subscription_id
                                     FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS SubCourses,
                                ROW_NUMBER() OVER (ORDER BY s.subscription_id DESC) AS RowNum
                            FROM subscriptions s
                        ) AS T
                        WHERE RowNum BETWEEN @Start AND @End
                    ";

                    int start = ((CurrentPage - 1) * PageSize) + 1;
                    int end = CurrentPage * PageSize;

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Start", start);
                        cmd.Parameters.AddWithValue("@End", end);

                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        rptSubscriptions.DataSource = dt;
                        rptSubscriptions.DataBind();
                    }

                    lblPage.Text = "Page " + CurrentPage;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "❌ Error: " + ex.Message;
            }
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
                LoadSubscriptions();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            // Optional: You can check total rows and disable next button if last page
            CurrentPage++;
            LoadSubscriptions();
        }
    }
}