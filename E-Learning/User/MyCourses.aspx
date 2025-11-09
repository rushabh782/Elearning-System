<%@ Page Title="My Enrolled Courses" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeBehind="MyCourses.aspx.cs" Inherits="E_Learning.User.MyCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts for Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }

        .hero-section h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .hero-section p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Course Cards */
        .course-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            height: auto;
            display: flex;
            flex-direction: column;
            border: 1px solid #e5e7eb;
            margin-bottom: 20px;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .course-image {
            width: 100%;
            height: 150px;
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9ca3af;
            font-size: 2rem;
        }

        .course-body {
            padding: 20px;
            flex-grow: 1;
        }

        .course-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 8px;
        }

        .course-description {
            color: #6b7280;
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: #6b7280;
            margin-bottom: 15px;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: #4f46e5;
            transition: width 0.3s ease;
        }

        .expired-badge {
            background: #fef2f2;
            color: #dc2626;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e5e7eb;
        }

        .empty-state i {
            font-size: 4rem;
            color: #d1d5db;
            margin-bottom: 20px;
        }

        .empty-state h4 {
            color: #374151;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #6b7280;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2rem;
            }

            .course-card {
                margin-bottom: 15px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1>My Enrolled Courses</h1>
            <p>Track your progress and continue learning with your enrolled courses</p>
        </div>
    </div>

    <!-- Enrolled Courses Section -->
<div class="container" style="margin-top: -40px;">
    <div class="row">
        <asp:Repeater ID="rptEnrolledCourses" runat="server" OnItemDataBound="rptEnrolledCourses_ItemDataBound">
            <ItemTemplate>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="course-card">
                        <div class="course-image">
                            <i class="<%# Eval("course_type").ToString() == "master" ? "fas fa-book" : "fas fa-book-open" %>"></i>
                        </div>
                        <div class="course-body">
                            <h4 class="course-title"><%# Eval("title") %></h4>
                            <p class="course-description"><%# Eval("description") %></p>
                            
                            <!-- Enrollment Dates (for both masters and subs) -->
                            <div class="course-meta">
                                <span><i class="fas fa-calendar me-1"></i>Enrolled: <%# Eval("enrolled_on") != DBNull.Value ? Convert.ToDateTime(Eval("enrolled_on")).ToString("MMM dd, yyyy") : "N/A" %></span>
                                <span><i class="fas fa-clock me-1"></i>Valid Until: <%# Eval("valid_until") != DBNull.Value ? Convert.ToDateTime(Eval("valid_until")).ToString("MMM dd, yyyy") : "N/A" %></span>
                            </div>
                            
                            <!-- Progress Bar (for both) -->
                            <div class="progress-bar">
                                <div class="progress-fill" style='width: <%# Eval("progress") != DBNull.Value ? Math.Round((decimal)Eval("progress"), 0) + "%" : "0%" %>'></div>
                            </div>
                            <small class="text-muted mt-1 d-block">Progress: <%# Eval("progress") != DBNull.Value ? string.Format("{0:F2}", Eval("progress")) : "0.00" %>%</small>
                            
                            <!-- Expiry Badge (for both) -->
                            <%# Eval("valid_until") != DBNull.Value && Convert.ToDateTime(Eval("valid_until")) < DateTime.Now ? "<span class='expired-badge'>Expired</span>" : "" %>
                            
                            <!-- For Masters: Expandable Sub-Course Section -->
                            <%# Eval("course_type").ToString() == "master" ? 
                                "<div class='mt-2'><button class='btn btn-outline-primary btn-sm' type='button' data-bs-toggle='collapse' data-bs-target='#subs-" + Eval("course_id") + "' aria-expanded='false'>Sub-courses: " + Eval("sub_course_count") + " <i class='fas fa-chevron-down'></i></button></div>" +
                                "<div class='collapse mt-2' id='subs-" + Eval("course_id") + "'>" : 
                                "" %>
                            
                            <!-- Nested Repeater for Sub-Courses (only bound for masters) -->
                            <asp:Repeater ID="rptSubCourses" runat="server">
                                <ItemTemplate>
                                    <div class="sub-course-item p-2 border rounded mb-2" style="background: #f9f9f9;">
                                        <h6><%# Eval("title") %></h6>
                                        <p class="small"><%# Eval("description") %></p>
                                        <small>Progress: <%# Eval("progress") != DBNull.Value ? string.Format("{0:F2}", Eval("progress")) : "0.00" %>%</small>
                                        <a href="CourseTopics.aspx?subCourseId=<%# Eval("course_id") %>" class="btn btn-sm btn-primary ms-2">Continue Learning</a>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            
                            <!-- Close the collapse div for masters -->
                            <%# Eval("course_type").ToString() == "master" ? "</div>" : "" %>
                            
                            <!-- Continue Learning Button (for subs or masters) -->
                            <div class="mt-3">
                                <a href="<%# Eval("course_type").ToString() == "master" ? "MasterDetails.aspx?masterId=" + Eval("course_id") : "CourseTopics.aspx?subCourseId=" + Eval("course_id") %>" class="btn btn-primary">Continue Learning</a>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
        <div class="empty-state">
            <i class="fas fa-graduation-cap"></i>
            <h4>No Enrolled Courses</h4>
            <p>You haven't enrolled in any courses yet. Browse available courses to get started!</p>
            <a href="UserDashboard.aspx" class="btn btn-primary">Browse Courses</a>
        </div>
    </asp:Panel>
</div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>