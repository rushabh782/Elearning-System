<%@ Page Title="Delete Subscription" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DeleteSubscription.aspx.cs" Inherits="E_Learning.Admin.DeleteSubscription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 & FontAwesome CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" 
        integrity="sha512-vdD8rW5l9lKqXcXb1q36Yj6HfV9u6wY3R1lqY8+38U9E3zF5pFgfIhIh9XcK1rOZ6l8G1U4P7bLq3dP+nLh0JQ==" 
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <style>
        .container { padding-top: 60px; color:white; }
        .glass-card {
            background: rgba(52, 58, 64, 0.9);
            backdrop-filter: blur(8px);
            border-radius: 12px;
            padding: 30px;
            color: white;
            max-width: 600px;
            margin: auto;
            text-align: center;
        }
        .btn-danger:hover { background: linear-gradient(45deg, #dc3545, #e66773); color:white; }
        .btn-secondary:hover { background: #6c757d; color:white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="glass-card">
            <h3 class="mb-4"><i class="fas fa-exclamation-triangle text-warning"></i> Delete Subscription</h3>
            <asp:Label ID="lblSubTitle" runat="server" Text="" CssClass="h5 mb-3 d-block"></asp:Label>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            <div class="mt-4">
                <asp:Button ID="btnDelete" runat="server" Text="Yes, Delete" CssClass="btn btn-danger me-2" OnClick="btnDelete_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" PostBackUrl="ViewSubscriptions.aspx" />
            </div>
        </div>
    </div>
</asp:Content>
