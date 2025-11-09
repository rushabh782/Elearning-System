<%@ Page Title="Edit Subscription" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditSubscription.aspx.cs" Inherits="E_Learning.Admin.EditSubscription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .container { padding-top:40px; padding-bottom:40px; color:white; }
        .glass-card { background:rgba(52,58,64,0.9); backdrop-filter:blur(8px); border-radius:12px; padding:20px; color:white; }
        .form-control { background-color:#3e444a; border:1px solid #6c757d; color:#f8f9fa; }
        .form-control::placeholder { color:#ced4da; }

        /* Readonly TextBox styling */
        .form-control[readonly] {
            background-color: #3e444a;
            color: #f8f9fa;
            opacity: 1;
        }

        .btn { min-width:100px; }
        .btn + .btn { margin-left: 10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container">
    <h3 class="text-light mb-4">Edit Subscription</h3>
    <div class="glass-card">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>

        <div class="mb-3">
            <asp:Label runat="server" Text="Title" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label runat="server" Text="Description" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label runat="server" Text="Price" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label runat="server" Text="Duration (days)" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label runat="server" Text="Type" CssClass="form-label"></asp:Label>
            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
                <asp:ListItem Text="Free" Value="Free"></asp:ListItem>
                <asp:ListItem Text="Premium" Value="Premium"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <asp:Label runat="server" Text="SubCourses" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtSubCourses" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ms-2" PostBackUrl="ViewSubscriptions.aspx" />
        </div>
    </div>
</div>
</asp:Content>