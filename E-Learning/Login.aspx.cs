using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace E_Learning
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string em = Email.Text.Trim();
            string pass = Password.Text.Trim();
            string conStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("UserLoginProc", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@email", em);
                    cmd.Parameters.AddWithValue("@pass", pass);

                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            Session["MyUser"] = rdr["email"].ToString();
                            Session["role"] = rdr["role"].ToString().ToLower();
                            Session["name"] = rdr["name"].ToString();
                            Session["user_id"] = rdr["user_id"].ToString();

                            if (Session["role"].ToString() == "admin")
                                Response.Redirect("/Admin/AdminDashboard.aspx");
                            else
                                Response.Redirect("/User/UserDashboard.aspx");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "customToast", "showCustomToast('Invalid Email or Password', 10000);", true);
                        }
                    }
                }
            }
        }

        protected void SignUpButton_Click(object sender, EventArgs e)
        {
            string user = Name.Text.Trim();
            string em = SignUpEmail.Text.Trim();
            string pass = SignUpPassword.Text.Trim();
            string role = "user";
            string profile = "";

            // ✅ Server-side validation
            if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(em) || string.IsNullOrEmpty(pass))
            {
                Response.Write("<script>alert('All fields are required'); setTimeout(function() { var modal = new bootstrap.Modal(document.getElementById('signupModal')); modal.show(); }, 500);</script>");
                return;
            }

            // ✅ File presence check
            if (!FileUpload1.HasFile)
            {
                Response.Write("<script>alert('Profile image is required'); setTimeout(function() { var modal = new bootstrap.Modal(document.getElementById('signupModal')); modal.show(); }, 500);</script>");
                return;
            }

            string folderPath = Server.MapPath("Profiles/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName = Path.GetFileName(FileUpload1.FileName);
            string ext = Path.GetExtension(fileName).ToLower();

            // ✅ Extension check
            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png")
            {
                Response.Write("<script>alert('Only JPG, JPEG, PNG files are allowed'); setTimeout(function() { var modal = new bootstrap.Modal(document.getElementById('signupModal')); modal.show(); }, 500);</script>");
                return;
            }

            fileName = Path.GetFileNameWithoutExtension(fileName) + "_" + Guid.NewGuid().ToString("N") + ext;
            FileUpload1.SaveAs(Path.Combine(folderPath, fileName));
            profile = "Profiles/" + fileName;

            string conStr = ConfigurationManager.ConnectionStrings["ELearningDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(conStr))
            {
                conn.Open();

                // ✅ Email existence check
                using (SqlCommand checkCmd = new SqlCommand("UserExistProc", conn))
                {
                    checkCmd.CommandType = System.Data.CommandType.StoredProcedure;
                    checkCmd.Parameters.AddWithValue("@email", em);

                    bool emailExists = false;
                    using (SqlDataReader r = checkCmd.ExecuteReader())
                    {
                        emailExists = r.Read();
                    }
                    if (emailExists)
                    {
                        Response.Write("<script>alert('Email ID Already Exists'); setTimeout(function() { var modal = new bootstrap.Modal(document.getElementById('signupModal')); modal.show(); }, 500);</script>");
                        return;
                    }
                }

                // ✅ Insert new user
                using (SqlCommand insertCmd = new SqlCommand("InsertUser", conn))
                {
                    insertCmd.CommandType = System.Data.CommandType.StoredProcedure;
                    insertCmd.Parameters.AddWithValue("@name", user);
                    insertCmd.Parameters.AddWithValue("@email", em);
                    insertCmd.Parameters.AddWithValue("@Passwordd", pass);
                    insertCmd.Parameters.AddWithValue("@role", role);
                    insertCmd.Parameters.AddWithValue("@profile", profile);

                    insertCmd.ExecuteNonQuery();
                    Clear();
                    Response.Write("<script>alert('Registration Successful');</script>");
                }
            }
        }

        protected void Clear()
        {
            Name.Text = "";
            SignUpEmail.Text = "";
            SignUpPassword.Text = "";
        }
    }
}