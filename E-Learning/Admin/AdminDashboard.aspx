<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="E_Learning.AdminDashboard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../Styles/AdminDashboard.css" rel="stylesheet">

    <style>
        /* ============================================
   Admin Dashboard - Modern Professional Theme
   ============================================ */

:root {
    --primary-color: #4f46e5;
    --secondary-color: #10b981;
    --warning-color: #f59e0b;
    --danger-color: #ef4444;
    --info-color: #3b82f6;
    --purple-color: #a855f7;
    --teal-color: #14b8a6;
    --indigo-color: #6366f1;
    --pink-color: #ec4899;
    --dark-bg: #1e293b;
    --light-bg: #f8fafc;
    --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    --hover-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
    --border-radius: 16px;
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Global Styles */
body {
    font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    color: #1e293b;
    line-height: 1.6;
}

.dashboard-content {
    padding: 30px 25px;
    margin-top: 20px;
}

/* Welcome Hero Section */
.welcome-hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 40px 25px;
    border-radius: var(--border-radius);
    margin: 20px 25px;
    color: white;
    box-shadow: var(--card-shadow);
    position: relative;
    overflow: hidden;
}

.welcome-hero::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 400px;
    height: 400px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    animation: float 6s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-20px); }
}

.hero-title {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 10px;
    animation: fadeInDown 0.8s ease;
}

.hero-subtitle {
    font-size: 1.1rem;
    opacity: 0.9;
    margin: 0;
    animation: fadeInUp 0.8s ease;
}

.date-badge {
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    padding: 15px 25px;
    border-radius: 50px;
    display: inline-block;
    font-weight: 600;
    animation: fadeInRight 0.8s ease;
}

.date-badge i {
    margin-right: 10px;
}

/* Section Headers */
.section-header {
    margin-bottom: 25px;
}

.section-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #1e293b;
    display: flex;
    align-items: center;
    gap: 12px;
}

.section-title i {
    color: var(--primary-color);
    font-size: 1.5rem;
}

/* Metric Cards - Primary */
.metric-card {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    position: relative;
    overflow: hidden;
    box-shadow: var(--card-shadow);
    transition: var(--transition);
    border: 1px solid rgba(0, 0, 0, 0.05);
    height: 100%;
}

.metric-card::before {
    content: '';
    position: absolute;
    top: 0;
    right: 0;
    width: 150px;
    height: 150px;
    border-radius: 50%;
    opacity: 0.1;
    transition: var(--transition);
}

.metric-card:hover {
    transform: translateY(-8px);
    box-shadow: var(--hover-shadow);
}

.metric-card:hover::before {
    transform: scale(1.2);
}

.card-blue::before { background: var(--info-color); }
.card-green::before { background: var(--secondary-color); }
.card-purple::before { background: var(--purple-color); }
.card-orange::before { background: var(--warning-color); }

.metric-icon {
    width: 70px;
    height: 70px;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    margin-bottom: 20px;
    position: relative;
    z-index: 1;
}

.card-blue .metric-icon {
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
    color: white;
    box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
}

.card-green .metric-icon {
    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    color: white;
    box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
}

.card-purple .metric-icon {
    background: linear-gradient(135deg, #a855f7 0%, #9333ea 100%);
    color: white;
    box-shadow: 0 8px 20px rgba(168, 85, 247, 0.3);
}

.card-orange .metric-icon {
    background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
    color: white;
    box-shadow: 0 8px 20px rgba(245, 158, 11, 0.3);
}

.metric-content {
    margin-bottom: 20px;
}

.metric-value {
    font-size: 2.5rem;
    font-weight: 800;
    color: #1e293b;
    margin-bottom: 5px;
    line-height: 1;
}

.metric-label {
    font-size: 1rem;
    color: #64748b;
    font-weight: 500;
    margin-bottom: 12px;
}

.metric-badge {
    display: inline-block;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    background: rgba(59, 130, 246, 0.1);
    color: var(--info-color);
}

.card-green .metric-badge {
    background: rgba(16, 185, 129, 0.1);
    color: var(--secondary-color);
}

.card-purple .metric-badge {
    background: rgba(168, 85, 247, 0.1);
    color: var(--purple-color);
}

.badge-warning {
    background: rgba(245, 158, 11, 0.1);
    color: var(--warning-color);
}

.metric-badge i {
    margin-right: 4px;
}

.metric-link {
    display: block;
    color: var(--primary-color);
    text-decoration: none;
    font-weight: 600;
    font-size: 0.95rem;
    margin-top: 15px;
    transition: var(--transition);
    position: relative;
    z-index: 1;
}

.metric-link:hover {
    color: var(--primary-color);
    transform: translateX(5px);
}

.metric-link i {
    margin-left: 5px;
    transition: var(--transition);
}

.metric-link:hover i {
    transform: translateX(3px);
}

.card-decoration {
    position: absolute;
    bottom: -20px;
    right: -20px;
    width: 100px;
    height: 100px;
    border-radius: 50%;
    opacity: 0.05;
    background: currentColor;
}

/* Insights Carousel */
.carousel {
    background: white;
    border-radius: var(--border-radius);
    padding: 40px;
    box-shadow: var(--card-shadow);
}

.carousel-indicators button {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background-color: var(--primary-color);
    opacity: 0.3;
}

.carousel-indicators .active {
    opacity: 1;
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: var(--primary-color);
    border-radius: 50%;
    padding: 20px;
}

.insight-card {
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    border-radius: var(--border-radius);
    padding: 30px;
    text-align: center;
    transition: var(--transition);
    border: 2px solid transparent;
    height: 100%;
}

.insight-card:hover {
    transform: translateY(-5px);
    border-color: var(--primary-color);
    box-shadow: var(--hover-shadow);
}

.insight-icon {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    color: white;
    margin-bottom: 20px;
}

.insight-card h4 {
    font-size: 1.2rem;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 15px;
}

.insight-value {
    font-size: 2rem;
    font-weight: 800;
    color: var(--primary-color);
    margin-bottom: 10px;
}

.insight-desc {
    color: #64748b;
    font-size: 0.95rem;
    margin: 0;
}

/* Secondary Cards */
.secondary-card {
    background: white;
    border-radius: var(--border-radius);
    padding: 25px;
    box-shadow: var(--card-shadow);
    transition: var(--transition);
    height: 100%;
}

.secondary-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--hover-shadow);
}

.secondary-header {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 25px;
}

.secondary-icon {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    color: white;
}

.secondary-title {
    font-size: 1.3rem;
    font-weight: 700;
    color: #1e293b;
    margin: 0;
}

.secondary-subtitle {
    font-size: 0.9rem;
    color: #64748b;
    margin: 0;
}

.secondary-body {
    margin-bottom: 20px;
}

.secondary-value {
    font-size: 3rem;
    font-weight: 800;
    color: #1e293b;
    margin-bottom: 20px;
}

.secondary-progress {
    margin-top: 15px;
}

.secondary-progress .progress {
    height: 10px;
    border-radius: 10px;
    background: #e2e8f0;
    margin-bottom: 8px;
}

.secondary-progress .progress-bar {
    border-radius: 10px;
}

.progress-text {
    font-size: 0.85rem;
    color: #64748b;
}

.secondary-footer {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid #e2e8f0;
}

.btn-secondary-action {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    padding: 12px 24px;
    background: linear-gradient(135deg, var(--primary-color) 0%, #6366f1 100%);
    color: white;
    text-decoration: none;
    border-radius: 10px;
    font-weight: 600;
    transition: var(--transition);
}

.btn-secondary-action:hover {
    transform: translateX(5px);
    box-shadow: 0 5px 20px rgba(79, 70, 229, 0.3);
    color: white;
}

/* Chart Cards */
.chart-card {
    background: white;
    border-radius: var(--border-radius);
    padding: 25px;
    box-shadow: var(--card-shadow);
    height: 100%;
}

.chart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f1f5f9;
}

.chart-header h4 {
    font-size: 1.2rem;
    font-weight: 700;
    color: #1e293b;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 10px;
}

.chart-legend {
    display: flex;
    gap: 20px;
}

.legend-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.85rem;
    color: #64748b;
    font-weight: 500;
}

.legend-color {
    width: 16px;
    height: 16px;
    border-radius: 4px;
}

.chart-body {
    padding: 20px 10px;
}

/* Activity Timeline */
.activity-container {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    box-shadow: var(--card-shadow);
}

.activity-timeline {
    position: relative;
}

.activity-timeline::before {
    content: '';
    position: absolute;
    left: 30px;
    top: 20px;
    bottom: 20px;
    width: 2px;
    background: linear-gradient(to bottom, #e2e8f0 0%, #cbd5e1 100%);
}

.activity-item {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
    position: relative;
    animation: fadeInLeft 0.5s ease;
}

.activity-item:last-child {
    margin-bottom: 0;
}

.activity-icon {
    width: 60px;
    height: 60px;
    min-width: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.3rem;
    color: white;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    position: relative;
    z-index: 1;
}

.activity-content {
    flex: 1;
    background: #f8fafc;
    padding: 20px;
    border-radius: 12px;
    border-left: 3px solid var(--primary-color);
    transition: var(--transition);
}

.activity-content:hover {
    background: #f1f5f9;
    transform: translateX(5px);
}

.activity-content h5 {
    font-size: 1.1rem;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 8px;
}

.activity-content p {
    color: #64748b;
    margin-bottom: 10px;
    font-size: 0.95rem;
}

.activity-time {
    font-size: 0.85rem;
    color: #94a3b8;
    font-weight: 500;
}

.activity-time i {
    margin-right: 5px;
}

/* Quick Actions */
.quick-action-btn {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 15px;
    padding: 35px 20px;
    background: white;
    border-radius: var(--border-radius);
    text-decoration: none;
    color: #1e293b;
    font-weight: 600;
    font-size: 1rem;
    box-shadow: var(--card-shadow);
    transition: var(--transition);
    border: 2px solid transparent;
}

.quick-action-btn:hover {
    transform: translateY(-8px);
    box-shadow: var(--hover-shadow);
    border-color: var(--primary-color);
    color: var(--primary-color);
}

.quick-action-btn i {
    font-size: 2.5rem;
    color: var(--primary-color);
    transition: var(--transition);
}

.quick-action-btn:hover i {
    transform: scale(1.2);
}

/* Footer */
.dashboard-footer {
    background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
    color: white;
    padding: 30px 25px;
    margin-top: 50px;
    border-radius: var(--border-radius) var(--border-radius) 0 0;
}

.dashboard-footer p {
    margin: 0;
    font-size: 0.95rem;
}

.dashboard-footer a {
    color: white;
    text-decoration: none;
    margin: 0 10px;
    transition: var(--transition);
}

.dashboard-footer a:hover {
    color: var(--primary-color);
}

/* Background Colors */
.bg-primary { background-color: var(--primary-color) !important; }
.bg-success { background-color: var(--secondary-color) !important; }
.bg-warning { background-color: var(--warning-color) !important; }
.bg-danger { background-color: var(--danger-color) !important; }
.bg-info { background-color: var(--info-color) !important; }
.bg-purple { background-color: var(--purple-color) !important; }
.bg-teal { background-color: var(--teal-color) !important; }
.bg-indigo { background-color: var(--indigo-color) !important; }
.bg-pink { background-color: var(--pink-color) !important; }

/* Animations */
@keyframes fadeInDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInLeft {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes fadeInRight {
    from {
        opacity: 0;
        transform: translateX(20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* Responsive Design */
@media (max-width: 1200px) {
    .hero-title {
        font-size: 2rem;
    }
    
    .metric-value {
        font-size: 2rem;
    }
}

@media (max-width: 768px) {
    .dashboard-content {
        padding: 20px 15px;
    }
    
    .welcome-hero {
        margin: 15px;
        padding: 30px 20px;
    }
    
    .hero-title {
        font-size: 1.75rem;
    }
    
    .hero-subtitle {
        font-size: 1rem;
    }
    
    .date-badge {
        padding: 10px 20px;
        font-size: 0.9rem;
    }
    
    .metric-card {
        padding: 25px;
    }
    
    .metric-value {
        font-size: 1.8rem;
    }
    
    .secondary-value {
        font-size: 2.5rem;
    }
    
    .carousel {
        padding: 25px;
    }
    
    .chart-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
    }
    
    .activity-timeline::before {
        left: 20px;
    }
    
    .activity-icon {
        width: 50px;
        height: 50px;
        min-width: 50px;
        font-size: 1.1rem;
    }
    
    .dashboard-footer {
        text-align: center;
    }
    
    .dashboard-footer .text-end {
        text-align: center !important;
        margin-top: 15px;
    }
}

@media (max-width: 576px) {
    .section-title {
        font-size: 1.4rem;
    }
    
    .metric-icon {
        width: 60px;
        height: 60px;
        font-size: 1.5rem;
    }
    
    .insight-card {
        padding: 20px;
    }
    
    .insight-value {
        font-size: 1.5rem;
    }
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Welcome Hero Section -->
    <div class="welcome-hero">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="hero-title">
                        <i class="fas fa-crown text-warning"></i> Welcome back, Admin!
                    </h1>
                    <p class="hero-subtitle">Here's what's happening with your platform today</p>
                </div>
                <div class="col-lg-4 text-end">
                    <div class="date-badge">
                        <i class="far fa-calendar-alt"></i>
                        <span id="currentDate"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Dashboard Content -->
    <div class="container-fluid dashboard-content">
        
        <!-- Key Metrics Cards -->
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-chart-line"></i> Key Metrics Overview
            </h2>
        </div>

        <div class="row g-4 mb-5">
            <!-- Active Courses Card -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="metric-card card-blue">
                    <div class="metric-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <div class="metric-content">
                        <h3 class="metric-value">
                            <asp:Label ID="lblActiveCourses" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="metric-label">Active Courses</p>
                        <div class="metric-badge">
                            <i class="fas fa-arrow-up"></i> Live Now
                        </div>
                    </div>
                    <a href="CourseList.aspx" class="metric-link">
                        View All Courses <i class="fas fa-arrow-right"></i>
                    </a>
                    <div class="card-decoration"></div>
                </div>
            </div>

            <!-- Enrolled Users Card -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="metric-card card-green">
                    <div class="metric-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <div class="metric-content">
                        <h3 class="metric-value">
                            <asp:Label ID="lblRegisteredUsers" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="metric-label">Enrolled Students</p>
                        <div class="metric-badge">
                            <i class="fas fa-check-circle"></i> Active
                        </div>
                    </div>
                    <a href="Users.aspx" class="metric-link">
                        Manage Users <i class="fas fa-arrow-right"></i>
                    </a>
                    <div class="card-decoration"></div>
                </div>
            </div>

            <!-- Total Revenue Card -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="metric-card card-purple">
                    <div class="metric-icon">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <div class="metric-content">
                        <h3 class="metric-value">
                            ₹<asp:Label ID="lblTotalRevenue" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="metric-label">Total Revenue</p>
                        <div class="metric-badge">
                            <i class="fas fa-chart-line"></i> Earnings
                        </div>
                    </div>
                    <a href="ReportsLanding.aspx" class="metric-link">
                        View Transactions <i class="fas fa-arrow-right"></i>
                    </a>
                    <div class="card-decoration"></div>
                </div>
            </div>

            <!-- Pending Subscriptions Card -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="metric-card card-orange">
                    <div class="metric-icon">
                        <i class="fas fa-hourglass-half"></i>
                    </div>
                    <div class="metric-content">
                        <h3 class="metric-value">
                            <asp:Label ID="lblPendingSubscriptions" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="metric-label">Pending Subscriptions</p>
                        <div class="metric-badge badge-warning">
                            <i class="fas fa-exclamation-circle"></i> Action Required
                        </div>
                    </div>
                    <a href="Subscriptions.aspx" class="metric-link">
                        Manage Now <i class="fas fa-arrow-right"></i>
                    </a>
                    <div class="card-decoration"></div>
                </div>
            </div>
        </div>

        <!-- Analytics Insights Carousel -->
        <div class="section-header mb-4">
            <h2 class="section-title">
                <i class="fas fa-lightbulb"></i> Platform Insights
            </h2>
        </div>

        <div id="insightsCarousel" class="carousel slide mb-5" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#insightsCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#insightsCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#insightsCarousel" data-bs-slide-to="2"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-primary">
                                    <i class="fas fa-graduation-cap"></i>
                                </div>
                                <h4>Student Engagement</h4>
                                <p class="insight-value">87% Active Rate</p>
                                <p class="insight-desc">Students are actively participating in courses this month</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-success">
                                    <i class="fas fa-star"></i>
                                </div>
                                <h4>Course Ratings</h4>
                                <p class="insight-value">4.8/5.0 Average</p>
                                <p class="insight-desc">Excellent feedback from enrolled students</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-info">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h4>Learning Hours</h4>
                                <p class="insight-value">12,450 Hours</p>
                                <p class="insight-desc">Total learning time this month</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-warning">
                                    <i class="fas fa-trophy"></i>
                                </div>
                                <h4>Completion Rate</h4>
                                <p class="insight-value">73% Completed</p>
                                <p class="insight-desc">High course completion rate this quarter</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-danger">
                                    <i class="fas fa-certificate"></i>
                                </div>
                                <h4>Certificates Issued</h4>
                                <p class="insight-value">1,234 Certs</p>
                                <p class="insight-desc">Certificates awarded this month</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-purple">
                                    <i class="fas fa-comments"></i>
                                </div>
                                <h4>Discussion Activity</h4>
                                <p class="insight-value">3,456 Posts</p>
                                <p class="insight-desc">Active community engagement</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-teal">
                                    <i class="fas fa-globe"></i>
                                </div>
                                <h4>Global Reach</h4>
                                <p class="insight-value">45 Countries</p>
                                <p class="insight-desc">Students from around the world</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-indigo">
                                    <i class="fas fa-mobile-alt"></i>
                                </div>
                                <h4>Mobile Usage</h4>
                                <p class="insight-value">62% Mobile</p>
                                <p class="insight-desc">Students prefer mobile learning</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="insight-card">
                                <div class="insight-icon bg-pink">
                                    <i class="fas fa-chart-bar"></i>
                                </div>
                                <h4>Growth Rate</h4>
                                <p class="insight-value">+28% MoM</p>
                                <p class="insight-desc">Steady platform growth</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#insightsCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#insightsCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Secondary Metrics Row -->
        <div class="row g-4 mb-5">
            <!-- Inactive Users Card -->
            <div class="col-xl-6 col-lg-6">
                <div class="secondary-card">
                    <div class="secondary-header">
                        <div class="secondary-icon bg-warning">
                            <i class="fas fa-user-slash"></i>
                        </div>
                        <div>
                            <h4 class="secondary-title">Inactive Users</h4>
                            <p class="secondary-subtitle">Users who haven't logged in recently</p>
                        </div>
                    </div>
                    <div class="secondary-body">
                        <h2 class="secondary-value">
                            <asp:Label ID="lblInactiveUsers" runat="server" Text="0"></asp:Label>
                        </h2>
                        <div class="secondary-progress">
                            <div class="progress">
                                <div class="progress-bar bg-warning" role="progressbar" style="width: 35%"></div>
                            </div>
                            <span class="progress-text">35% of total users</span>
                        </div>
                    </div>
                    <div class="secondary-footer">
                        <a href="InactiveUsers.aspx" class="btn-secondary-action">
                            <i class="fas fa-eye"></i> View Inactive Users
                        </a>
                    </div>
                </div>
            </div>

            <!-- Archived Courses Card -->
            <div class="col-xl-6 col-lg-6">
                <div class="secondary-card">
                    <div class="secondary-header">
                        <div class="secondary-icon bg-danger">
                            <i class="fas fa-archive"></i>
                        </div>
                        <div>
                            <h4 class="secondary-title">Archived Courses</h4>
                            <p class="secondary-subtitle">Courses removed from active catalog</p>
                        </div>
                    </div>
                    <div class="secondary-body">
                        <h2 class="secondary-value">
                            <asp:Label ID="lblInactiveCourses" runat="server" Text="0"></asp:Label>
                        </h2>
                        <div class="secondary-progress">
                            <div class="progress">
                                <div class="progress-bar bg-danger" role="progressbar" style="width: 22%"></div>
                            </div>
                            <span class="progress-text">22% of total courses</span>
                        </div>
                    </div>
                    <div class="secondary-footer">
                        <a href="ArchivedCourse.aspx" class="btn-secondary-action">
                            <i class="fas fa-folder-open"></i> View Archived Courses
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts & Analytics Section -->
        <div class="section-header mb-4">
            <h2 class="section-title">
                <i class="fas fa-chart-pie"></i> Performance Analytics
            </h2>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-lg-8">
                <div class="chart-card">
                    <div class="chart-header">
                        <h4><i class="fas fa-trending-up"></i> Revenue & Enrollment Trends</h4>
                        <div class="chart-legend">
                            <span class="legend-item"><span class="legend-color bg-primary"></span> Revenue</span>
                            <span class="legend-item"><span class="legend-color bg-success"></span> Enrollments</span>
                        </div>
                    </div>
                    <div class="chart-body">
                        <canvas id="revenueChart" style="height: 300px;"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="chart-card">
                    <div class="chart-header">
                        <h4><i class="fas fa-percentage"></i> Course Distribution</h4>
                    </div>
                    <div class="chart-body text-center">
                        <canvas id="distributionChart" style="height: 280px;"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- NEW: Enhanced Analytics Section -->
<div class="section-header mb-4 mt-5">
    <h2 class="section-title">
        <i class="fas fa-analytics"></i> Extended Analytics
    </h2>
</div>

<div class="row g-4 mb-5">
    <!-- User Status Distribution Chart -->
    <div class="col-lg-6">
        <div class="chart-card">
            <div class="chart-header">
                <h4><i class="fas fa-users-cog"></i> User Status Distribution</h4>
                <div class="chart-legend">
                    <span class="legend-item"><span class="legend-color bg-success"></span> Active</span>
                    <span class="legend-item"><span class="legend-color bg-warning"></span> Inactive</span>
                </div>
            </div>
            <div class="chart-body text-center">
                <canvas id="userStatusChart" style="height: 280px;"></canvas>
            </div>
        </div>
    </div>

    <!-- Course Enrollment Bar Chart -->
    <div class="col-lg-6">
        <div class="chart-card">
            <div class="chart-header">
                <h4><i class="fas fa-chart-bar"></i> Course Enrollment Overview</h4>
                <div class="chart-legend">
                    <span class="legend-item"><span class="legend-color bg-info"></span> Enrolled</span>
                    <span class="legend-item"><span class="legend-color bg-danger"></span> Archived</span>
                    <span class="legend-item"><span class="legend-color bg-primary"></span> Active</span>
                </div>
            </div>
            <div class="chart-body">
                <canvas id="courseEnrollmentChart" style="height: 280px;"></canvas>
            </div>
        </div>
    </div>
</div>

        <!-- NEW: Month-over-Month User Growth Section -->
<div class="section-header mb-4 mt-5">
    <h2 class="section-title">
        <i class="fas fa-chart-line"></i> Growth Analytics
    </h2>
</div>

<div class="row g-4 mb-5">
    <!-- Month-over-Month Growth Chart -->
    <div class="col-lg-12">
        <div class="chart-card">
            <div class="chart-header">
                <h4><i class="fas fa-arrow-trend-up"></i> Month-over-Month User Registration Growth</h4>
                <div class="chart-legend">
                    <span class="legend-item"><span class="legend-color bg-primary"></span> New Registrations</span>
                </div>
            </div>
            <div class="chart-body">
                <canvas id="moMUserGrowthChart" style="height: 300px;"></canvas>
            </div>
        </div>
    </div>
</div>

        <!-- Recent Activity Section -->
        <div class="section-header mb-4">
            <h2 class="section-title">
                <i class="fas fa-history"></i> Recent Platform Activity
            </h2>
        </div>

        <div class="activity-container mb-5">
            <div class="activity-timeline">
                <div class="activity-item">
                    <div class="activity-icon bg-success">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="activity-content">
                        <h5>New User Registration</h5>
                        <p>John Doe enrolled in "Advanced Web Development"</p>
                        <span class="activity-time"><i class="far fa-clock"></i> 5 minutes ago</span>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon bg-primary">
                        <i class="fas fa-upload"></i>
                    </div>
                    <div class="activity-content">
                        <h5>Course Content Updated</h5>
                        <p>New video lecture added to "Python Mastery"</p>
                        <span class="activity-time"><i class="far fa-clock"></i> 1 hour ago</span>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon bg-warning">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <div class="activity-content">
                        <h5>New Transaction</h5>
                        <p>Payment received for "Data Science Bootcamp"</p>
                        <span class="activity-time"><i class="far fa-clock"></i> 2 hours ago</span>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon bg-info">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="activity-content">
                        <h5>Course Review Submitted</h5>
                        <p>5-star rating received for "UI/UX Design Fundamentals"</p>
                        <span class="activity-time"><i class="far fa-clock"></i> 3 hours ago</span>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon bg-purple">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <div class="activity-content">
                        <h5>Certificate Issued</h5>
                        <p>Sarah Smith completed "Digital Marketing Essentials"</p>
                        <span class="activity-time"><i class="far fa-clock"></i> 5 hours ago</span>
                    </div>
                </div>
            </div>
        </div>

       <!-- Quick Actions Panel -->
<div class="section-header mb-4">
    <h2 class="section-title">
        <i class="fas fa-bolt"></i> Quick Actions
    </h2>
</div>

<div class="row g-3 mb-5">
    <div class="col-lg-3 col-md-6">
        <a href="AddMasterCourse.aspx" class="quick-action-btn">
            <i class="fas fa-plus-circle"></i>
            <span>Add New Course</span>
        </a>
    </div>
    <div class="col-lg-3 col-md-6">
        <a href="Users.aspx" class="quick-action-btn">
            <i class="fas fa-user-cog"></i>
            <span>Manage Users</span>
        </a>
    </div>
    <div class="col-lg-3 col-md-6">
        <!-- ✨ UPDATED: Changed from Transactions.aspx to ReportsLanding.aspx -->
        <a href="ReportsLanding.aspx" class="quick-action-btn">
            <i class="fas fa-file-invoice-dollar"></i>
            <span>View Reports</span>
        </a>
    </div>
    <div class="col-lg-3 col-md-6">
        <a href="Subscriptions.aspx" class="quick-action-btn">
            <i class="fas fa-bell"></i>
            <span>Notifications</span>
        </a>
    </div>
</div>

    <!-- Footer -->
  

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="../Scripts/AdminDashboard.js"></script>

    <script>
        // Admin Dashboard JavaScript - Interactive Features & Charts
        // ============================================================

        document.addEventListener('DOMContentLoaded', function () {
            // Initialize all features
            initializeDateDisplay();
            initializeCharts();
            initializeAnimations();
            initializeCarousel();
        });

        // Display Current Date
        function initializeDateDisplay() {
            const dateElement = document.getElementById('currentDate');
            if (dateElement) {
                const options = {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                };
                const today = new Date();
                dateElement.textContent = today.toLocaleDateString('en-US', options);
            }
        }

        // Initialize Chart.js Charts
        function initializeCharts() {
            // Revenue Chart (Line Chart)
            const revenueCtx = document.getElementById('revenueChart');
            if (revenueCtx) {
                new Chart(revenueCtx, {
                    type: 'line',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                        datasets: [
                            {
                                label: 'Revenue (₹)',
                                data: [45000, 52000, 48000, 61000, 58000, 67000, 72000, 69000, 78000, 84000, 89000, 95000],
                                borderColor: '#3b82f6',
                                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                tension: 0.4,
                                fill: true,
                                pointRadius: 5,
                                pointHoverRadius: 7,
                                pointBackgroundColor: '#3b82f6',
                                pointBorderColor: '#fff',
                                pointBorderWidth: 2,
                                pointHoverBackgroundColor: '#fff',
                                pointHoverBorderColor: '#3b82f6',
                                pointHoverBorderWidth: 2
                            },
                            {
                                label: 'Enrollments',
                                data: [120, 145, 135, 180, 170, 195, 210, 200, 225, 245, 260, 280],
                                borderColor: '#10b981',
                                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                                tension: 0.4,
                                fill: true,
                                pointRadius: 5,
                                pointHoverRadius: 7,
                                pointBackgroundColor: '#10b981',
                                pointBorderColor: '#fff',
                                pointBorderWidth: 2,
                                pointHoverBackgroundColor: '#fff',
                                pointHoverBorderColor: '#10b981',
                                pointHoverBorderWidth: 2
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                backgroundColor: 'rgba(30, 41, 59, 0.95)',
                                padding: 12,
                                titleColor: '#fff',
                                bodyColor: '#fff',
                                borderColor: 'rgba(255, 255, 255, 0.1)',
                                borderWidth: 1,
                                displayColors: true,
                                callbacks: {
                                    label: function (context) {
                                        let label = context.dataset.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        if (context.parsed.y !== null) {
                                            if (context.datasetIndex === 0) {
                                                label += '₹' + context.parsed.y.toLocaleString();
                                            } else {
                                                label += context.parsed.y.toLocaleString();
                                            }
                                        }
                                        return label;
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    color: '#64748b',
                                    font: {
                                        size: 12,
                                        weight: 600
                                    }
                                }
                            },
                            y: {
                                grid: {
                                    color: 'rgba(226, 232, 240, 0.5)',
                                    drawBorder: false
                                },
                                ticks: {
                                    color: '#64748b',
                                    font: {
                                        size: 12,
                                        weight: 600
                                    },
                                    callback: function (value) {
                                        return value.toLocaleString();
                                    }
                                }
                            }
                        },
                        interaction: {
                            intersect: false,
                            mode: 'index'
                        }
                    }
                });
            }

            // Distribution Chart (Doughnut Chart)
            const distributionCtx = document.getElementById('distributionChart');
            if (distributionCtx) {
                new Chart(distributionCtx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Web Development', 'Data Science', 'Design', 'Marketing', 'Business'],
                        datasets: [{
                            data: [35, 25, 20, 12, 8],
                            backgroundColor: [
                                '#3b82f6',
                                '#10b981',
                                '#a855f7',
                                '#f59e0b',
                                '#ef4444'
                            ],
                            borderWidth: 4,
                            borderColor: '#fff',
                            hoverOffset: 15,
                            hoverBorderWidth: 3,
                            hoverBorderColor: '#fff'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    padding: 15,
                                    font: {
                                        size: 12,
                                        weight: 600
                                    },
                                    color: '#64748b',
                                    usePointStyle: true,
                                    pointStyle: 'circle'
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(30, 41, 59, 0.95)',
                                padding: 12,
                                titleColor: '#fff',
                                bodyColor: '#fff',
                                borderColor: 'rgba(255, 255, 255, 0.1)',
                                borderWidth: 1,
                                callbacks: {
                                    label: function (context) {
                                        let label = context.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        const value = context.parsed;
                                        const total = context.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                                        const percentage = ((value / total) * 100).toFixed(1);
                                        label += percentage + '%';
                                        return label;
                                    }
                                }
                            }
                        },
                        cutout: '65%',
                        animation: {
                            animateRotate: true,
                            animateScale: true
                        }
                    }
                });
            }

            // Add to the end of initializeCharts() function

            // User Status Pie Chart (Dynamic Data)
            const userStatusCtx = document.getElementById('userStatusChart');
            if (userStatusCtx) {
                // Get data from backend
                const userStatusData = <%= UserStatusChartData %>;
    
    new Chart(userStatusCtx, {
        type: 'doughnut',
        data: {
            labels: ['Active Users', 'Inactive Users'],
            datasets: [{
                data: [
                    userStatusData.activeCount, 
                    userStatusData.inactiveCount
                ],
                backgroundColor: [
                    '#10b981', // Green for active
                    '#f59e0b'  // Orange for inactive
                ],
                borderWidth: 4,
                borderColor: '#fff',
                hoverOffset: 15,
                hoverBorderWidth: 3,
                hoverBorderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 15,
                        font: {
                            size: 12,
                            weight: 600
                        },
                        color: '#64748b',
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(30, 41, 59, 0.95)',
                    padding: 12,
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 1,
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            const value = context.parsed;
                            const total = userStatusData.totalUsers;
                            const percentage = ((value / total) * 100).toFixed(1);
                            return label + ': ' + value + ' (' + percentage + '%)';
                        }
                    }
                }
            },
            cutout: '65%',
            animation: {
                animateRotate: true,
                animateScale: true
            }
        }
    });
}

// Course Enrollment Bar Chart (Dynamic Data)
const courseEnrollmentCtx = document.getElementById('courseEnrollmentChart');
if (courseEnrollmentCtx) {
    // Get data from backend
    const courseData = <%= CourseEnrollmentChartData %>;

    new Chart(courseEnrollmentCtx, {
        type: 'bar',
        data: {
            labels: ['Enrolled Courses', 'Archived Courses', 'Active Courses'],
            datasets: [{
                label: 'Course Count',
                data: [
                    courseData.enrolledCount,
                    courseData.archivedCount,
                    courseData.activeCount
                ],
                backgroundColor: [
                    '#3b82f6', // Blue for enrolled
                    '#ef4444', // Red for archived
                    '#10b981'  // Green for active
                ],
                borderColor: [
                    '#2563eb',
                    '#dc2626',
                    '#059669'
                ],
                borderWidth: 2,
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(30, 41, 59, 0.95)',
                    padding: 12,
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 1,
                    callbacks: {
                        label: function (context) {
                            return context.label + ': ' + context.parsed.y + ' courses';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#64748b',
                        font: {
                            size: 11,
                            weight: 600
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(226, 232, 240, 0.5)',
                        drawBorder: false
                    },
                    ticks: {
                        color: '#64748b',
                        font: {
                            size: 12,
                            weight: 600
                        },
                        stepSize: 1
                    }
                }
            },
            animation: {
                duration: 1000,
                easing: 'easeOutQuart'
            }
        }
    });
            }


            // Month-over-Month User Growth Line Chart (Dynamic Data)   
            const moMGrowthCtx = document.getElementById('moMUserGrowthChart');
            if (moMGrowthCtx) {
                // Get data from backend
                const momData = <%= MoMGrowthChartData %>;

    // Parse the data
    let labels = [];
    let dataValues = [];

    if (momData && momData.labels && momData.data) {
        labels = momData.labels.split(',').map(l => l.replace(/'/g, ''));
        dataValues = momData.data.split(',').map(d => parseInt(d));
    }

    new Chart(moMGrowthCtx, {
        type: 'line',
        data: {
            labels: labels.length > 0 ? labels : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'New User Registrations',
                data: dataValues.length > 0 ? dataValues : [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                borderColor: '#4f46e5',
                backgroundColor: 'rgba(79, 70, 229, 0.1)',
                tension: 0.4,
                fill: true,
                pointRadius: 6,
                pointHoverRadius: 8,
                pointBackgroundColor: '#4f46e5',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: '#4f46e5',
                pointHoverBorderWidth: 3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(30, 41, 59, 0.95)',
                    padding: 12,
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 1,
                    displayColors: true,
                    callbacks: {
                        label: function (context) {
                            return 'New Users: ' + context.parsed.y;
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#64748b',
                        font: {
                            size: 12,
                            weight: 600
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(226, 232, 240, 0.5)',
                        drawBorder: false
                    },
                    ticks: {
                        color: '#64748b',
                        font: {
                            size: 12,
                            weight: 600
                        },
                        stepSize: 1,
                        callback: function (value) {
                            return Math.floor(value);
                        }
                    }
                }
            },
            interaction: {
                intersect: false,
                mode: 'index'
            }
        }
    });
}
        }



        // Initialize Scroll Animations
        function initializeAnimations() {
            // Intersection Observer for fade-in animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function (entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            // Observe metric cards
            document.querySelectorAll('.metric-card').forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = `all 0.6s ease ${index * 0.1}s`;
                observer.observe(card);
            });

            // Observe secondary cards
            document.querySelectorAll('.secondary-card').forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = `all 0.6s ease ${index * 0.1}s`;
                observer.observe(card);
            });

            // Observe chart cards
            document.querySelectorAll('.chart-card').forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = `all 0.6s ease ${index * 0.1}s`;
                observer.observe(card);
            });

            // Add hover effects to metric cards
            document.querySelectorAll('.metric-card').forEach(card => {
                card.addEventListener('mouseenter', function () {
                    this.style.transition = 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
                });
            });
        }

        // Initialize Carousel Auto-play
        function initializeCarousel() {
            const carousel = document.getElementById('insightsCarousel');
            if (carousel) {
                const bsCarousel = new bootstrap.Carousel(carousel, {
                    interval: 5000,
                    wrap: true,
                    touch: true
                });
            }
        }

        // Counter Animation for Numbers
        function animateCounter(element, target, duration = 2000) {
            let start = 0;
            const increment = target / (duration / 16);
            const timer = setInterval(() => {
                start += increment;
                if (start >= target) {
                    element.textContent = Math.floor(target);
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(start);
                }
            }, 16);
        }

        // Animate counters when page loads
        window.addEventListener('load', function () {
            // Get all metric values and animate them
            document.querySelectorAll('.metric-value').forEach(element => {
                const targetValue = parseInt(element.textContent.replace(/,/g, ''));
                if (!isNaN(targetValue)) {
                    element.textContent = '0';
                    setTimeout(() => {
                        animateCounter(element, targetValue);
                    }, 500);
                }
            });
        });

        // Add smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Tooltip initialization (if using Bootstrap tooltips)
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Add loading state for cards
        function showLoadingState() {
            document.querySelectorAll('.metric-card, .secondary-card').forEach(card => {
                card.style.opacity = '0.6';
                card.style.pointerEvents = 'none';
            });
        }

        function hideLoadingState() {
            document.querySelectorAll('.metric-card, .secondary-card').forEach(card => {
                card.style.opacity = '1';
                card.style.pointerEvents = 'auto';
            });
        }

        // Refresh dashboard data (can be called after postback)
        function refreshDashboard() {
            showLoadingState();
            // Simulate data refresh
            setTimeout(() => {
                hideLoadingState();
                // Re-initialize animations
                initializeAnimations();
            }, 500);
        }

        // Export functions for use in ASP.NET
        window.dashboardFunctions = {
            refreshDashboard: refreshDashboard,
            showLoadingState: showLoadingState,
            hideLoadingState: hideLoadingState
        };
    </script>
</asp:Content>
