<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditMasterCourse.aspx.cs" Inherits="E_Learning.Admin.EditMasterCourse" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
            color: #212529;
        }

        .glass-card {
            background-color: #343A40;
            color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            max-width: 650px;
            margin: auto;
        }

        .form-control {
            background-color: #ffffff;
            color: #212529;
            border: 1px solid #ced4da;
        }

        .form-label {
            color: #ffffff;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-outline-light {
            border: 1px solid #ffffff;
            color: #ffffff;
        }

        .btn-outline-light:hover {
            background-color: #ffffff;
            color: #343A40;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-header h2 {
            color: #343A40;
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
            <h2>Edit Master Course</h2>
            <p>Update the course details below and save your changes.</p>
        </div>

        <div class="glass-card">
            <h4 class="mb-4">Course Details</h4>

            <div class="mb-3">
                <label class="form-label">Course Title</label>
                <asp:TextBox ID="TextBoxTitle" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <asp:TextBox ID="TextBoxDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
            </div>

            <div class="d-flex, gap-5 mt-4">
                <asp:Button ID="ButtonUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="ButtonUpdate_Click" />
                <asp:Button ID="ButtonViewAll" runat="server" CssClass="btn btn-outline-light" Text="View All Courses" OnClick="ButtonViewAll_Click" />
            </div>
        </div>
    </div>
</asp:Content>
