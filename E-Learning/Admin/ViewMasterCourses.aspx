<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ViewMasterCourses.aspx.cs" Inherits="E_Learning.Admin.ViewMasterCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: linear-gradient(to bottom right, #4b545c, #343a40);
            color: white;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }

        .custom-checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .custom-checkbox {
            width: 20px;
            height: 20px;
            border: 2px solid #ccc;
            border-radius: 4px;
            background-color: transparent;
            position: relative;
        }

        .custom-checkbox.checked {
            border-color: #28a745;
            background-color: #28a745;
        }

        .custom-checkbox.checked::after {
            content: "";
            position: absolute;
            top: 2px;
            left: 6px;
            width: 5px;
            height: 10px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
        }

        .status-label {
            color: white;
            font-weight: 500;
        }

        .container {
            padding-top: 40px;
            padding-bottom: 40px;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(12px);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            color: white;
        }

        .table thead th {
            background-color: #e0e0e0;
            color: #343a40;
        }

        .form-check-label {
            color: white;
        }

        .btn-sm {
            font-size: 0.8rem;
            padding: 6px 12px;
            border-radius: 6px;
        }

        .btn-warning {
            background-color: #ffc107;
            border: none;
            color: black;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
            color: white;
        }

        .btn-outline-light {
            border-color: white;
            color: white;
        }

        .btn-outline-light:hover {
            background-color: white;
            color: #343a40;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Dropdown to select course type -->
        <div class="mb-4">
            <asp:DropDownList ID="ddlCourseType" runat="server" AutoPostBack="true" CssClass="form-select w-auto"
                OnSelectedIndexChanged="ddlCourseType_SelectedIndexChanged">

                <asp:ListItem Text="Master Courses" Value="master" Selected="True" />
                <asp:ListItem Text="Subcourses" Value="sub" />

            </asp:DropDownList>
        </div>

        <!-- Panel for Master Courses -->
        <asp:Panel ID="pnlMasterCourses" runat="server" Visible="false">
            <h3 class="text-dark mb-4">Master Courses</h3>

            <div class="mb-3 d-flex gap-3">
                <asp:Button ID="btnAddCourse" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Add New Course" OnClick="btnAddCourse_Click" />
                <asp:Button ID="btnShowArchived" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Show Archived Courses" OnClick="btnShowArchived_Click" />
                <asp:Button ID="btnShowActive" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Show Active Courses" OnClick="btnShowActive_Click" />
            </div>

            <div class="glass-card">
                <asp:Repeater ID="rptCourses" runat="server">
                    <HeaderTemplate>
                        <table class="table table-bordered table-hover table-dark align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Sub-Courses</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("title") %></td>
                            <td><%# Eval("description") %></td>
                            <td>
                                <div class="custom-checkbox-wrapper">
                                    <div class='<%# Eval("status").ToString() == "active" ? "custom-checkbox checked" : "custom-checkbox" %>'></div>
                                    <span class="status-label"><%# Eval("status") %></span>
                                </div>
                            </td>
                            <td><%# Eval("sub_course_count") %></td>
                            <td>
                                <asp:HyperLink ID="lnkEdit" runat="server" CssClass="btn btn-sm btn-warning me-2"
                                    NavigateUrl='<%# "EditMasterCourse.aspx?id=" + Eval("master_course_id") %>' Text="Edit" />
                                <asp:LinkButton ID="btnArchive" runat="server" CssClass="btn btn-sm btn-danger me-2"
                                    CommandArgument='<%# Eval("master_course_id") %>'
                                    OnClick="btnArchive_Click"
                                    Text="Archive"
                                    Visible='<%# Eval("status").ToString() == "active" %>' />
                                <asp:LinkButton ID="btnActivate" runat="server" CssClass="btn btn-sm btn-success"
                                    CommandArgument='<%# Eval("master_course_id") %>'
                                    OnClick="btnActivate_Click"
                                    Text="Activate"
                                    Visible='<%# Eval("status").ToString() == "archived" %>' />
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="d-flex justify-content-between align-items-center mt-3">
                    <asp:Button ID="btnPrev" runat="server" CssClass="btn btn-outline-light btn-sm" Text="Previous" OnClick="btnPrev_Click" />
                    <asp:Label ID="lblPage" runat="server" CssClass="text-light fw-bold" />
                    <asp:Button ID="btnNext" runat="server" CssClass="btn btn-outline-light btn-sm" Text="Next" OnClick="btnNext_Click" />
                </div>
            </div>
        </asp:Panel>

        <!-- Panel for Subcourses -->
        <asp:Panel ID="pnlSubCourses" runat="server" Visible="false">
            <h3 class="text-dark mb-4">Subcourses</h3>

            <div class="mb-3 d-flex gap-3">
                <asp:Button ID="btnAddSubCourse" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Add New Subcourse" OnClick="btnAddSubCourse_Click" />
                <asp:Button ID="btnShowArchivedSub" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Show Archived Subcourses" OnClick="btnShowArchivedSub_Click" />
                <asp:Button ID="btnShowActiveSub" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Show Active Subcourses" OnClick="btnShowActiveSub_Click" />
            </div>

            <div class="glass-card">
                <asp:Repeater ID="rptSubCourses" runat="server">
                    <HeaderTemplate>
                        <table class="table table-bordered table-hover table-dark align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Master Course</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("title") %></td>
                            <td><%# Eval("description") %></td>
                            <td><%# Eval("master_course_title") %></td>
                            <td>
                                <div class="custom-checkbox-wrapper">
                                    <div class='<%# Eval("status").ToString() == "active" ? "custom-checkbox checked" : "custom-checkbox" %>'></div>
                                    <span class="status-label"><%# Eval("status") %></span>
                                </div>
                            </td>
                            <td>
                                <asp:HyperLink ID="lnkEditSub" runat="server" CssClass="btn btn-sm btn-warning me-2"
                                    NavigateUrl='<%# "EditSubCourse.aspx?id=" + Eval("sub_course_id") %>' Text="Edit" />
                                <asp:LinkButton ID="btnArchiveSub" runat="server" CssClass="btn btn-sm btn-danger me-2"
                                    CommandArgument='<%# Eval("sub_course_id") %>'
                                    OnClick="btnArchiveSub_Click"
                                    Text="Archive"
                                    Visible='<%# Eval("status").ToString() == "active" %>' />
                                <asp:LinkButton ID="btnActivateSub" runat="server" CssClass="btn btn-sm btn-success"
                                    CommandArgument='<%# Eval("sub_course_id") %>'
                                    OnClick="btnActivateSub_Click"
                                    Text="Activate"
                                    Visible='<%# Eval("status").ToString() == "archived" %>' />
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="d-flex justify-content-between align-items-center mt-3">
                    <asp:Button ID="btnPrevSub" runat="server" CssClass="btn btn-outline-light btn-sm" Text="Previous" OnClick="btnPrevSub_Click" />
                    <asp:Label ID="lblPageSub" runat="server" CssClass="text-light fw-bold" />
                    <asp:Button ID="btnNextSub" runat="server" CssClass="btn btn-outline-light btn-sm" Text="Next" OnClick="btnNextSub_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

