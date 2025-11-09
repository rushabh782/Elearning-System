<%@ Page Title="Reports Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ReportsLanding.aspx.cs" Inherits="E_Learning.ReportsLanding" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #3b82f6;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            --hover-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
            --border-radius: 16px;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', sans-serif;
        }

        .reports-container { padding: 30px 25px; }
        .page-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px; border-radius: var(--border-radius); color: white; margin-bottom: 30px; box-shadow: var(--card-shadow); }
        .page-header h1 { font-size: 2.5rem; font-weight: 700; margin-bottom: 10px; }
        .report-category { margin-bottom: 40px; }
        .category-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; margin-bottom: 20px; display: flex; align-items: center; gap: 12px; }
        .category-title i { color: var(--primary-color); }
        .report-card { background: white; border-radius: var(--border-radius); padding: 30px; box-shadow: var(--card-shadow); transition: all 0.3s ease; height: 100%; cursor: pointer; border: 2px solid transparent; }
        .report-card:hover { transform: translateY(-8px); box-shadow: var(--hover-shadow); border-color: var(--primary-color); }
        .report-icon { width: 70px; height: 70px; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin-bottom: 20px; color: white; }
        .report-card h4 { font-size: 1.2rem; font-weight: 700; color: #1e293b; margin-bottom: 12px; }
        .report-card p { color: #64748b; font-size: 0.95rem; margin-bottom: 20px; }
        .report-filters { display: flex; gap: 10px; flex-wrap: wrap; }
        .filter-badge { display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; background: rgba(79, 70, 229, 0.1); color: var(--primary-color); }
        .view-report-btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; background: linear-gradient(135deg, var(--primary-color) 0%, #6366f1 100%); color: white; text-decoration: none; border-radius: 10px; font-weight: 600; margin-top: 15px; transition: all 0.3s ease; }
        .view-report-btn:hover { transform: translateX(5px); color: white; box-shadow: 0 5px 20px rgba(79, 70, 229, 0.3); }
        .quick-stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .stat-card { background: white; border-radius: 12px; padding: 20px; box-shadow: var(--card-shadow); text-align: center; }
        .stat-value { font-size: 2rem; font-weight: 800; color: var(--primary-color); margin-bottom: 5px; }
        .stat-label { font-size: 0.9rem; color: #64748b; font-weight: 600; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="reports-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-chart-bar"></i> Reports Dashboard</h1>
            <p class="mb-0">Comprehensive analytics and insights for your e-learning platform</p>
        </div>

        <!-- Quick Stats -->
        <div class="quick-stats">
            <div class="stat-card">
                <div class="stat-value">
                    <asp:Label ID="lblTotalReports" runat="server" Text="12"></asp:Label>
                </div>
                <div class="stat-label">Available Reports</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">
                    <asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Active Courses</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">₹<asp:Label ID="lblMonthlyRevenue" runat="server" Text="0"></asp:Label></div>
                <div class="stat-label">Monthly Revenue</div>
            </div>
        </div>

        <!-- Reports Sections -->
        <div class="report-category">
            <h2 class="category-title"><i class="fas fa-graduation-cap"></i> Course Performance</h2>
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>📈 Course Completion Rate Deep Dive</h4>
                        <p>Analyze completion rates across all courses with detailed progress metrics</p>
                        <div class="report-filters">
                            <span class="filter-badge">Date Range</span>
                            <span class="filter-badge">Master Course ID</span>
                            <span class="filter-badge">Completion Status</span>
                        </div>
                        <asp:LinkButton ID="btnViewCompletionReport" runat="server" CssClass="view-report-btn" OnClick="btnViewCompletionReport_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);">
                            <i class="fas fa-balance-scale"></i>
                        </div>
                        <h4>💰 Most Enrolled vs Highest Revenue</h4>
                        <p>Compare enrollment numbers with revenue generation for strategic insights</p>
                        <div class="report-filters">
                            <span class="filter-badge">Last 6 Months</span>
                            <span class="filter-badge">Course Status</span>
                        </div>
                        <asp:LinkButton ID="btnViewEnrollmentRevenue" runat="server" CssClass="view-report-btn" OnClick="btnViewEnrollmentRevenue_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <!-- User Activity Reports -->
        <div class="report-category">
            <h2 class="category-title"><i class="fas fa-users"></i> User Activity</h2>
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);">
                            <i class="fas fa-fire"></i>
                        </div>
                        <h4>🔥 User Engagement Heatmap</h4>
                        <p>Identify dormant users and track engagement patterns</p>
                        <div class="report-filters">
                            <span class="filter-badge">Last Login Date</span>
                            <span class="filter-badge">Enrollment Status</span>
                        </div>
                        <asp:LinkButton ID="btnViewEngagement" runat="server" CssClass="view-report-btn" OnClick="btnViewEngagement_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #a855f7 0%, #9333ea 100%);">
                            <i class="fas fa-user-clock"></i>
                        </div>
                        <h4>😴 Dormant Users Analysis</h4>
                        <p>Users inactive for more than 90 days with re-engagement strategies</p>
                        <div class="report-filters">
                            <span class="filter-badge">90+ Days Inactive</span>
                        </div>
                        <asp:LinkButton ID="btnViewDormantUsers" runat="server" CssClass="view-report-btn" OnClick="btnViewDormantUsers_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <!-- Financial Reports -->
        <div class="report-category">
            <h2 class="category-title"><i class="fas fa-dollar-sign"></i> Financial / Sales</h2>
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <h4>💳 Transaction Breakdown by Type</h4>
                        <p>Detailed analysis of payment methods, success rates, and transaction patterns</p>
                        <div class="report-filters">
                            <span class="filter-badge">Date Range</span>
                            <span class="filter-badge">Payment Method</span>
                            <span class="filter-badge">Status</span>
                        </div>
                        <asp:LinkButton ID="btnViewTransactions" runat="server" CssClass="view-report-btn" OnClick="btnViewTransactions_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <h4>📊 Revenue by Course Category</h4>
                        <p>Track revenue distribution across different course categories</p>
                        <div class="report-filters">
                            <span class="filter-badge">Month/Year</span>
                            <span class="filter-badge">Course Type</span>
                        </div>
                        <asp:LinkButton ID="btnViewRevenueByCourse" runat="server" CssClass="view-report-btn" OnClick="btnViewRevenueByCourse_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <!-- Content Health Reports -->
        <div class="report-category">
            <h2 class="category-title"><i class="fas fa-puzzle-piece"></i> Content Health</h2>
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #ec4899 0%, #db2777 100%);">
                            <i class="fas fa-layer-group"></i>
                        </div>
                        <h4>🧩 Content Gaps (Material Type Distribution)</h4>
                        <p>Identify content gaps and material type distribution across courses</p>
                        <div class="report-filters">
                            <span class="filter-badge">Topic/Sub-Course ID</span>
                            <span class="filter-badge">Upload Date</span>
                        </div>
                        <asp:LinkButton ID="btnViewContentGaps" runat="server" CssClass="view-report-btn" OnClick="btnViewContentGaps_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="report-card">
                        <div class="report-icon" style="background: linear-gradient(135deg, #14b8a6 0%, #0d9488 100%);">
                            <i class="fas fa-clipboard-check"></i>
                        </div>
                        <h4>✅ Course Quality Metrics</h4>
                        <p>Evaluate course quality based on completion rates and user feedback</p>
                        <div class="report-filters">
                            <span class="filter-badge">Quality Score</span>
                            <span class="filter-badge">Completion Rate</span>
                        </div>
                        <asp:LinkButton ID="btnViewQualityMetrics" runat="server" CssClass="view-report-btn" OnClick="btnViewQualityMetrics_Click">
                            <i class="fas fa-eye"></i> View Report
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <!-- Data Visualization Panel -->
        <div class="report-category">
            <h2 class="category-title"><i class="fas fa-chart-area"></i> Data Visualization</h2>
            <div class="row g-4">
                <div class="col-12">
                    <div class="report-card">
                        <asp:Panel ID="pnlReportData" runat="server" Visible="false">
                            <h4 class="mb-4"><asp:Label ID="lblReportTitle" runat="server"></asp:Label></h4>
                            <asp:GridView ID="gvReportData" runat="server" CssClass="table table-striped table-hover" AutoGenerateColumns="true"></asp:GridView>
                            <asp:Button ID="btnExportCSV" runat="server" Text="Export to CSV" CssClass="btn btn-success mt-3" OnClick="btnExportCSV_Click" />
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
