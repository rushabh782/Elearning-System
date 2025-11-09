<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddMasterCourse.aspx.cs" Inherits="E_Learning.Admin.AddMasterCourse" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f8f9fa; /* light background */
            font-family: 'Segoe UI', sans-serif;
            color: #212529;
        }

        .glass-card {
            background-color: #343A40; /* dark grey */
            color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            max-width: 650px;
            margin: auto;
        }

        .form-control {
            background-color: #ffffff;
            color: #343A40;
            border: 1px solid #ced4da;
        }

        .form-label {
            color: #ffffff;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #343A40;
            border: none;
        }

        .btn-outline-dark {
            border: 1px solid #ffffff;
            color: #ffffff;
        }

        .btn-outline-dark:hover {
            background-color: #ffffff;
            color: #2c2f33;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-header h2 {
            color: #2c2f33;
            font-weight: bold;
        }

        .page-header p {
            color: #6c757d;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="page-header">
            <h2>Add Course</h2>
            <p>Select course type below to add a Master Course or Subcourse.</p>
        </div>

        <!-- Dropdown to select course type -->
        <div class="glass-card mb-4">
            <label class="form-label">Select Course Type</label>
            <asp:DropDownList ID="ddlCourseType" runat="server" AutoPostBack="true" CssClass="form-select"
                OnSelectedIndexChanged="ddlCourseType_SelectedIndexChanged">
                <asp:ListItem Text="Select Type" Value="" />
                <asp:ListItem Text="Master Course" Value="master" />
                <asp:ListItem Text="Subcourse" Value="sub" />
            </asp:DropDownList>
        </div>

        <!-- Master Course Form -->
        <asp:Panel ID="pnlMasterCourse" runat="server" Visible="false">
            <div class="glass-card">
                <h4 class="mb-4">Master Course Details</h4>

                <div class="mb-3">
                    <label class="form-label">Course Title</label>
                    <asp:TextBox ID="TextBoxTitle" runat="server" CssClass="form-control" placeholder="Enter course title" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="TextBoxDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter description" />
                </div>

                <div class="d-flex gap-3 mt-4">
                    <asp:Button ID="ButtonAdd" runat="server" CssClass="btn btn-light" Text="Save Master Course" OnClick="ButtonAdd_Click" />
                    <asp:Button ID="ButtonViewAll" runat="server" CssClass="btn btn-outline-dark" Text="View All Courses" OnClick="ButtonViewAll_Click" />
                </div>
            </div>
        </asp:Panel>

        <!-- Subcourse Form -->
        <asp:Panel ID="pnlSubCourse" runat="server" Visible="false">
            <div class="glass-card">
                <h4 class="mb-4">Subcourse Details</h4>

                <div class="mb-3">
                    <label class="form-label">Subcourse Title</label>
                    <asp:TextBox ID="TextBoxSubTitle" runat="server" CssClass="form-control" placeholder="Enter subcourse title" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="TextBoxSubDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter description" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Select Master Course</label>
                    <asp:DropDownList ID="ddlMasterCourseList" runat="server" CssClass="form-select" />
                </div>

                <div class="d-flex gap-3 mt-4">
                    <asp:Button ID="ButtonAddSub" runat="server" CssClass="btn btn-light" Text="Save Subcourse" OnClick="ButtonAddSub_Click" />
                    <asp:Button ID="ButtonViewAllSub" runat="server" CssClass="btn btn-outline-dark" Text="View All Courses" OnClick="ButtonViewAll_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
