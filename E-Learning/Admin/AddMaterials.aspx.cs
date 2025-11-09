using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Learning.Admin
{
    public partial class AddMaterials : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["topic_id"] != null && Request.QueryString["sub_course_id"] != null)
                {
                    string topicId = Request.QueryString["topic_id"];
                    string subCourseId = Request.QueryString["sub_course_id"];

                    hfTopicId.Value = topicId;
                    hfSubCourseId.Value = subCourseId; // Store this so we can go back

                    LoadTopicDetails(topicId);
                    BindMaterialsGrid(topicId);
                    UpdatePanelVisibility(); // Set initial visibility
                }
                else
                {
                    Response.Redirect("AddMasterCourse.aspx");
                }
            }
        }

        private void LoadTopicDetails(string topicId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT title FROM topics WHERE topic_id = @topicId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@topicId", topicId);
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    lblTopicTitle.Text = $"Adding Materials for Topic: {result.ToString()}";
                }
            }
        }

        private void BindMaterialsGrid(string topicId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT material_id, title, type, url FROM materials WHERE topic_id = @topicId";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@topicId", topicId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMaterials.DataSource = dt;
                gvMaterials.DataBind();
            }
        }

        protected void ddlMaterialType_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdatePanelVisibility();
        }

        private void UpdatePanelVisibility()
        {
            string type = ddlMaterialType.SelectedValue;
            pnlLink.Visible = (type == "video" || type == "quiz" || type == "link");
            pnlPdf.Visible = (type == "pdf");
        }

        protected void btnSaveMaterial_Click(object sender, EventArgs e)
        {
            string title = txtMaterialTitle.Text.Trim();
            string type = ddlMaterialType.SelectedValue;
            string topicId = hfTopicId.Value;
            string url = "";

            if (string.IsNullOrEmpty(type))
            {
                lblStatus.Text = "Please select a material type.";
                lblStatus.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (pnlLink.Visible)
            {
                url = txtUrl.Text.Trim();
            }
            else if (pnlPdf.Visible)
            {
                if (fuPdf.HasFile)
                {
                    try
                    {
                        // Create a unique file name
                        string fileName = $"{Guid.NewGuid()}_{Path.GetFileName(fuPdf.FileName)}";
                        string savePath = Server.MapPath("~/Uploads/Materials/"); // Make sure this folder exists!

                        // Create directory if it doesn't exist
                        if (!Directory.Exists(savePath))
                        {
                            Directory.CreateDirectory(savePath);
                        }

                        fuPdf.SaveAs(Path.Combine(savePath, fileName));
                        url = $"~/Uploads/Materials/{fileName}"; // Store relative path in DB
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = $"File upload failed: {ex.Message}";
                        return;
                    }
                }
                else
                {
                    lblStatus.Text = "Please select a PDF file to upload.";
                    return;
                }
            }

            // Save to database
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO materials (topic_id, title, type, url) VALUES (@topicId, @title, @type, @url)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@topicId", topicId);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@type", type);
                cmd.Parameters.AddWithValue("@url", url);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Reset form
            txtMaterialTitle.Text = "";
            ddlMaterialType.SelectedIndex = 0;
            txtUrl.Text = "";
            UpdatePanelVisibility();
            BindMaterialsGrid(topicId);
            lblStatus.Text = "Material saved successfully!";
        }

        protected void gvMaterials_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string materialId = gvMaterials.DataKeys[e.RowIndex].Value.ToString();

            // (Optional but recommended): Delete the actual file from server if it's a PDF
            // 1. Get the file path (url) from the DB
            // 2. If it's a PDF and the file exists, File.Delete(Server.MapPath(filePath))

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM materials WHERE material_id = @materialId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@materialId", materialId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            BindMaterialsGrid(hfTopicId.Value);
        }

        protected void btnBackToTopics_Click(object sender, EventArgs e)
        {
            // Redirect back to the topics page for the current subcourse
            Response.Redirect($"AddTopics.aspx?sub_course_id={hfSubCourseId.Value}");
        }
    }
}