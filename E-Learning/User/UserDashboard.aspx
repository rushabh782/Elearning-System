<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="E_Learning.User.UserDashboard" %>

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

        /* Hero Section - Professional and Clean */
        .hero-section {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
            padding: 80px 0;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=2071&q=80') no-repeat center center;
            background-size: cover;
            opacity: 0.1;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            text-align: center;
        }
          
        .hero-content h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .hero-content p {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 30px;
        }

        .hero-search {
            max-width: 600px;
            margin: 0 auto;
        }

        .hero-search .input-group {
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border-radius: 50px;
            overflow: hidden;
        }

        .hero-search input {
            border: none;
            padding: 15px 25px;
            font-size: 1rem;
        }

        .hero-search button {
            background: #1f2937;
            border: none;
            padding: 15px 30px;
            color: white;
            font-weight: 600;
        }

        /* Stats Section */
        .stats-section {
            margin: -50px auto 60px;
            max-width: 1200px;
        }

        .stats-card {
            background: white;
            padding: 30px 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            text-align: center;
            transition: transform 0.2s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-icon {
            font-size: 2.5rem;
            color: #4f46e5;
            margin-bottom: 15px;
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 5px;
        }

        .stats-label {
            color: #6b7280;
            font-size: 1rem;
            font-weight: 500;
        }

        /* Section Headers */
        .section-header {
            margin: 60px 0 40px 0;
        }

        .section-header h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 10px;
        }

        .section-header p {
            color: #6b7280;
            font-size: 1.1rem;
        }

        /* Course Cards - Udemy/Scaler Style */
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
        }

        .subscriptions-row {
    align-items: flex-start; /* prevents Bootstrap from stretching columns to the tallest */
}

        .course-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .course-image {
            width: 100%;
            height: 180px;
            overflow: hidden;
            object-fit: cover;
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9ca3af;
            font-size: 3rem;
        }


        .course-image img.subImage {
            width: 100%;
            height: 100%;
            object-fit: cover; /* ensures full width & no stretching */
            display: block;
        }

        .course-body {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .course-badges {
            display: flex;
            gap: 8px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }

        .course-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-master {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .badge-sub {
            background: #f3e8ff;
            color: #7c3aed;
        }

        .badge-active {
            background: #dcfce7;
            color: #166534;
        }

        .badge-archived {
            background: #fef2f2;
            color: #dc2626;
        }

        .badge-gold {
            background: linear-gradient(45deg, #ffd700, #ffbf00);
            color: #000;
        }

        .badge-silver {
            background: linear-gradient(45deg, #c0c0c0, #e0e0e0);
            color: #000;
        }

        .badge-platinum {
            background: linear-gradient(45deg, #e5e4e2, #b0b0b0);
            color: #000;
        }

   /* Simple View Details Label */
.view-details-label {
    background: #f3f4f6;
    color: #4f46e5;
    border: 1px solid #d1d5db;
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 600;
    cursor: pointer;
    display: inline-block;
    transition: background 0.2s ease;
}

.view-details-label:hover {
    background: #e5e7eb;
    color: #3730a3;
}

        .course-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 8px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .course-description {
            color: #6b7280;
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            font-size: 0.85rem;
            color: #6b7280;
        }

        .course-meta-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .course-meta i {
            color: #4f46e5;
        }

        .course-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
        }

        .course-price.free {
            color: #059669;
        }

        .enroll-btn {
            background: #4f46e5;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.2s ease;
            width: 100%;
            margin-top: auto;
        }

        .enroll-btn:hover {
            background: #3730a3;
            transform: translateY(-2px);
        }

        .view-btn {
            background: #f3f4f6;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .view-btn:hover {
            background: #e5e7eb;
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
            .hero-content h1 {
                font-size: 2.25rem;
            }

            .hero-content p {
                font-size: 1.1rem;
            }

            .stats-section {
                margin: -30px auto 40px;
            }

            .course-card {
                margin-bottom: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container hero-content">
            <h1>Welcome back,
                <asp:Label ID="lblName" runat="server" />!</h1>
            <p>Continue your learning journey and unlock new skills with our expert-led courses</p>
            <div class="hero-search">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="What do you want to learn today?" aria-label="Search courses">
                    <button class="btn" type="button"><i class="fas fa-search me-2"></i>Search</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="container stats-section">
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="stats-card">
                    <div class="stats-icon"><i class="fas fa-book-open"></i></div>
                    <div class="stats-number">
                        <asp:Label ID="lblEnrolledCount" runat="server" Text="0" />
                    </div>
                    <div class="stats-label">Enrolled Courses</div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="stats-card">
                    <div class="stats-icon"><i class="fas fa-crown"></i></div>
                    <div class="stats-number">
                        <asp:Label ID="lblSubscriptionCount" runat="server" Text="0" />
                    </div>
                    <div class="stats-label">Active Subscriptions</div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="stats-card">
                    <div class="stats-icon"><i class="fas fa-graduation-cap"></i></div>
                    <div class="stats-number">
                        <asp:Label ID="lblAllCourses" runat="server" Text="0" />
                    </div>
                    <div class="stats-label">All Courses</div>
                </div>
            </div>
        </div>
    </div>


    <!-- Subscription Section -->
    <div class="container">
        <div class="section-header">
            <h2>Subscription Plans</h2>
            <p>Choose your plan and unlock access to premium learning content</p>
        </div>
        <!-- Change pnlSubscriptions to add a custom class so we can target alignment -->

        <asp:Panel ID="pnlSubscriptions" runat="server" CssClass="subscriptions-row row">
            <asp:Repeater ID="rptSubscriptions" runat="server" OnItemCommand="RptSubscriptions_ItemCommand" OnItemDataBound="rptSubscriptions_ItemDataBound">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="course-card">
                            <div class="course-image">
                                <img src='<%# string.IsNullOrEmpty(Eval("image_url").ToString()) ? "/assets/img/default-sub.jpg" : Eval("image_url").ToString() %>'
                                    alt="Subscription Image" class="subImage" />
                            </div>
                            <div class="course-body">
                                <div class="course-badges">
                                    <span class="course-badge badge-master">Subscription</span>
                                    <span class="course-badge 
                                    <%# Eval("subscription_type").ToString().ToLower() == "gold" ? "badge-gold" : 
                                        Eval("subscription_type").ToString().ToLower() == "silver" ? "badge-silver" : 
                                        "badge-platinum" %>">
                                        <%# Eval("subscription_type") %>
                                    </span>
                                    <!-- View Details Link (client-side toggle) -->
                                    <!-- Pass id as string and prevent default -->
                                    <a href="#" class="view-details-label" onclick="toggleDetails('<%# Eval("subscription_id") %>'); return false;">View Details
  </a>
                                </div>

                                <!-- Add data-subscription-id attribute so JS can locate the exact panel -->
                                <asp:Panel ID="detailsDiv" runat="server" CssClass="subscription-details"
                                    data-subscription-id='<%# Eval("subscription_id") %>'
                                    Style="display: none; background: #f9fafb; padding: 10px; border-radius: 6px; margin-bottom: 15px;">
                                    <!-- Details pre-loaded here -->
                                </asp:Panel>

                                <h4 class="course-title"><%# Eval("subscription_title") %></h4>
                                <p class="course-description">
                                    Duration: <%# Eval("duration_days") %> Days<br />
                                    Courses Included: <%# Eval("course_count") %>
                                </p>

                                <div class="course-meta">
                                    <div class="course-meta-left">
                                        <!-- Add any meta info if needed -->
                                    </div>
                                    <div class="course-price <%# Convert.ToDecimal(Eval("price")) == 0 ? "free" : "" %>">
                                        <%# Convert.ToDecimal(Eval("price")) == 0 ? "Free" : "₹" + Eval("price") %>
                                    </div>
                                </div>

                                <asp:Button
                                    ID="btnEnroll"
                                    runat="server"
                                    Text='<%# Convert.ToInt32(Eval("isSubscribed")) == 1 ? "Subscribed" : "Enroll Now" %>'
                                    CommandName="EnrollSubscription"
                                    CommandArgument='<%# Eval("subscription_id") %>'
                                    Enabled='<%# Convert.ToInt32(Eval("isSubscribed")) == 0 %>'
                                    CssClass='<%# Convert.ToInt32(Eval("isSubscribed")) == 1 ? "btn btn-light disabled enroll-btn" : "btn btn-success enroll-btn" %>' />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <asp:Panel ID="pnlNoSubscriptions" runat="server" Visible="false">
            <div class="empty-state">
                <i class="fas fa-book-open"></i>
                <h4>No Subscription Plans Available</h4>
                <p>Stay tuned for upcoming premium packages</p>
            </div>
        </asp:Panel>
    </div>

    <!-- Add this script before the Bootstrap JS -->
    <script>
    function toggleDetails(subscriptionId) {
        var detailsDiv = document.querySelector('.subscription-details[data-subscription-id="' + subscriptionId + '"]');
        if (!detailsDiv) {
            alert('Details div not found for ID: ' + subscriptionId);
            return;
        }

        // Close other open details
        var allDetails = document.querySelectorAll('.subscription-details');
        allDetails.forEach(function (div) {
            if (div !== detailsDiv && div.style.display !== 'none') {
                div.style.display = 'none';
            }
        });

        // Toggle this one
        if (detailsDiv.style.display === 'none' || detailsDiv.style.display === '') {
            detailsDiv.style.display = 'block';
        } else {
            detailsDiv.style.display = 'none';
        }
    }
    </script>

    <!-- Master Courses Section -->
    <div class="container">
        <div class="section-header">
            <h2>Master-Course Collections</h2>
            <p>Comprehensive learning paths designed by industry experts</p>
        </div>

        <asp:Panel ID="pnlMasterCourses" runat="server" CssClass="row">
            <asp:Repeater ID="rptMasterCourses" runat="server" OnItemCommand="rptMasterCourses_ItemCommand">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="course-card">
                            <div class="course-image"><i class="fas fa-layer-group"></i></div>
                            <div class="course-body">
                                <div class="course-badges">
                                    <span class="course-badge badge-master">Master Course</span>
                                    <span class="course-badge <%# Eval("status").ToString().ToLower() == "active" ? "badge-active" : "badge-archived" %>">
                                        <%# Eval("status") %>
                                    </span>
                                </div>
                                <h4 class="course-title"><%# Eval("title") %></h4>
                                <p class="course-description"><%# Eval("description") %></p>
                                <div class="course-meta">
                                    <div class="course-meta-left">
                                        <span><i class="fas fa-user-tie me-1"></i><%# Eval("admin_name") %></span>
                                    </div>
                                    <div class="course-price <%# Convert.ToDecimal(Eval("price")) == 0 ? "free" : "" %>">
                                        <%# Convert.ToDecimal(Eval("price")) == 0 ? "Free" : "₹" + Eval("price") %>
                                    </div>
                                </div>
                                <asp:Button
                                    ID="btnEnrollMaster"
                                    runat="server"
                                    Text="Enroll Now"
                                    CssClass="enroll-btn"
                                    CommandName="EnrollMaster"
                                    CommandArgument='<%# Eval("master_course_id") %>'
                                    Visible='<%# Eval("status").ToString().ToLower() == "active" %>' />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <asp:Panel ID="pnlNoMasterCourses" runat="server" Visible="false">
            <div class="empty-state">
                <i class="fas fa-book-open"></i>
                <h4>No Master Courses Available</h4>
                <p>Check back later for new master course collections</p>
            </div>
        </asp:Panel>
    </div>

    <!-- Sub Courses Section -->
    <div class="container">
        <div class="section-header">
            <h2>Sub-Courses Collection</h2>
            <p>Individual courses to enhance your skills</p>
        </div>

        <asp:Panel ID="pnlSubCourses" runat="server" CssClass="row">
            <asp:Repeater ID="rptSubCourses" runat="server" OnItemCommand="rptSubCourses_ItemCommand">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="course-card">
                            <div class="course-image"><i class="fas fa-book"></i></div>
                            <div class="course-body">
                                <div class="course-badges">
                                    <span class="course-badge badge-sub">Course</span>
                                    <span class="course-badge <%# Eval("status").ToString().ToLower() == "active" ? "badge-active" : "badge-archived" %>">
                                        <%# Eval("status") %>
                                    </span>
                                </div>
                                <h4 class="course-title"><%# Eval("title") %></h4>
                                <p class="course-description"><%# Eval("description") %></p>
                                <div class="course-meta">
                                    <div class="course-meta-left">
                                        <span><i class="fas fa-folder me-1"></i><%# Eval("master_title") %></span>
                                    </div>
                                    <div class="course-price <%# Convert.ToDecimal(Eval("price")) == 0 ? "free" : "" %>">
                                        <%# Convert.ToDecimal(Eval("price")) == 0 ? "Free" : "₹" + Eval("price") %>
                                    </div>
                                </div>
                                <asp:Button
                                    ID="btnEnrollSub"
                                    runat="server"
                                    Text="Enroll Now"
                                    CssClass="enroll-btn"
                                    CommandName="EnrollSub"
                                    CommandArgument='<%# Eval("sub_course_id") %>'
                                    Visible='<%# Eval("status").ToString().ToLower() == "active" %>' />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <asp:Panel ID="pnlNoSubCourses" runat="server" Visible="false">
            <div class="empty-state">
                <i class="fas fa-graduation-cap"></i>
                <h4>No Courses Available Right Now</h4>
                <p>New courses are being added regularly. Stay tuned!</p>
            </div>
        </asp:Panel>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
