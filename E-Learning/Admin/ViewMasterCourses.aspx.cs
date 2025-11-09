using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class ViewMasterCourses : System.Web.UI.Page
    {
        private int pageSize = 5;
        private int currentPage;
        private int currentPageSub;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["Page"] = 0;
                ViewState["PageSub"] = 0;

                string selected = ddlCourseType.SelectedValue;

                pnlMasterCourses.Visible = selected == "master";
                pnlSubCourses.Visible = selected == "sub";

                if (selected == "master")
                {
                    LoadCourses();
                }
                else if (selected == "sub")
                {
                    LoadSubCourses();
                }
            }
        }


        protected void ddlCourseType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selected = ddlCourseType.SelectedValue;

            pnlMasterCourses.Visible = selected == "master";
            pnlSubCourses.Visible = selected == "sub";

            if (selected == "master")
            {
                ViewState["Page"] = 0;
                LoadCourses();
            }
            else if (selected == "sub")
            {
                ViewState["PageSub"] = 0;
                LoadSubCourses();
            }
        }

        private void LoadCourses()
        {
            currentPage = ViewState["Page"] != null ? (int)ViewState["Page"] : 0;
            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                bool showArchived = ViewState["ShowArchived"] != null && (bool)ViewState["ShowArchived"];

                string query = @"
                    SELECT mc.*,
                    (SELECT COUNT(*) FROM sub_courses WHERE master_course_id = mc.master_course_id) AS sub_course_count
                    FROM master_courses mc
                    WHERE mc.status " + (showArchived ? "= 'archived'" : "!= 'archived'") + @"
                    ORDER BY mc.master_course_id DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                PagedDataSource pds = new PagedDataSource
                {
                    DataSource = dt.DefaultView,
                    AllowPaging = true,
                    PageSize = pageSize,
                    CurrentPageIndex = currentPage
                };

                btnPrev.Enabled = !pds.IsFirstPage;
                btnNext.Enabled = !pds.IsLastPage;
                lblPage.Text = $"Page {currentPage + 1} of {pds.PageCount}";

                rptCourses.DataSource = pds;
                rptCourses.DataBind();
            }
        }

        private void LoadSubCourses()
        {
            currentPageSub = ViewState["PageSub"] != null ? (int)ViewState["PageSub"] : 0;
            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                bool showArchived = ViewState["ShowArchivedSub"] != null && (bool)ViewState["ShowArchivedSub"];

                string query = @"
                    SELECT sc.sub_course_id, sc.title, sc.description, sc.status,
                           mc.title AS master_course_title
                    FROM sub_courses sc
                    LEFT JOIN master_courses mc ON sc.master_course_id = mc.master_course_id
                    WHERE sc.status " + (showArchived ? "= 'archived'" : "!= 'archived'") + @"
                    ORDER BY sc.sub_course_id DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                PagedDataSource pds = new PagedDataSource
                {
                    DataSource = dt.DefaultView,
                    AllowPaging = true,
                    PageSize = pageSize,
                    CurrentPageIndex = currentPageSub
                };

                btnPrevSub.Enabled = !pds.IsFirstPage;
                btnNextSub.Enabled = !pds.IsLastPage;
                lblPageSub.Text = $"Page {currentPageSub + 1} of {pds.PageCount}";

                rptSubCourses.DataSource = pds;
                rptSubCourses.DataBind();
            }
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (ddlCourseType.SelectedValue == "master")
            {
                ViewState["Page"] = (int)ViewState["Page"] - 1;
                LoadCourses();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (ddlCourseType.SelectedValue == "master")
            {
                ViewState["Page"] = (int)ViewState["Page"] + 1;
                LoadCourses();
            }
        }

        protected void btnPrevSub_Click(object sender, EventArgs e)
        {
            if (ddlCourseType.SelectedValue == "sub")
            {
                ViewState["PageSub"] = (int)ViewState["PageSub"] - 1;
                LoadSubCourses();
            }
        }

        protected void btnNextSub_Click(object sender, EventArgs e)
        {
            if (ddlCourseType.SelectedValue == "sub")
            {
                ViewState["PageSub"] = (int)ViewState["PageSub"] + 1;
                LoadSubCourses();
            }
        }

        protected void btnShowArchived_Click(object sender, EventArgs e)
        {
            ViewState["ShowArchived"] = true;
            LoadCourses();
        }

        protected void btnShowActive_Click(object sender, EventArgs e)
        {
            ViewState["ShowArchived"] = false;
            LoadCourses();
        }

        protected void btnShowArchivedSub_Click(object sender, EventArgs e)
        {
            ViewState["ShowArchivedSub"] = true;
            LoadSubCourses();
        }

        protected void btnShowActiveSub_Click(object sender, EventArgs e)
        {
            ViewState["ShowArchivedSub"] = false;
            LoadSubCourses();
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddMasterCourse.aspx");
        }

        protected void btnAddSubCourse_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddMasterCourse.aspx"); // same page handles both
        }

        protected void btnActivate_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string masterCourseId = btn.CommandArgument;

            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE master_courses SET status = 'active' WHERE master_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", masterCourseId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCourses();
        }

        protected void btnArchive_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string masterCourseId = btn.CommandArgument;

            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE master_courses SET status = 'archived' WHERE master_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", masterCourseId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCourses();
        }

        protected void btnActivateSub_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string subCourseId = btn.CommandArgument;

            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE sub_courses SET status = 'active' WHERE sub_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", subCourseId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadSubCourses();
        }

        protected void btnArchiveSub_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string subCourseId = btn.CommandArgument;

            string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE sub_courses SET status = 'archived' WHERE sub_course_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", subCourseId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadSubCourses();
            }
    }
}