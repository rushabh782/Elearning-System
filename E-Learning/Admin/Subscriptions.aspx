<%@ Page Title="Add Subscription" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Subscriptions.aspx.cs" Inherits="E_Learning.Admin.Subscriptions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        .container-box {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        .btn-primary {
            width: 100%;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-box">
        <h2>Add Subscription</h2>

        <!-- Subscription Type -->
        <div class="form-group">
            <label>Subscription Type:</label><br />
            <asp:DropDownList ID="ddlSubscriptionType" runat="server" CssClass="form-control">
                <asp:ListItem Text="--Select Type--" Value="" />
                <asp:ListItem Text="Gold" Value="Gold" />
                <asp:ListItem Text="Silver" Value="Silver" />
                <asp:ListItem Text="Platinum" Value="Platinum" />
            </asp:DropDownList>
        </div>

        <!-- Title -->
        <div class="form-group">
            <label>Title:</label><br />
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter subscription title" />
        </div>

        <!-- Description -->
        <div class="form-group">
            <label>Description:</label><br />
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter description" />
        </div>

        <!-- Price -->
        <div class="form-group">
            <label>Price (₹):</label><br />
            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Enter price" />
        </div>

        <!-- Image URL -->
        <div class="form-group">
            <label>Subscription Image URL:</label><br />
            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" placeholder="Enter image URL" />
        </div>

        <!-- Master Course Dropdown -->
        <div class="form-group">
            <label>Select Master Course:</label><br />
            <asp:DropDownList ID="ddlMasterCourse" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddlMasterCourse_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <br />

        <!-- Sub Courses CheckBox List -->
        <div class="form-group">
            <label>Select Sub Courses:</label><br />
            <asp:CheckBoxList ID="chkSubCourses" runat="server" RepeatDirection="Vertical" CssClass="form-check" />
        </div>

        <!-- Add Button -->
        <asp:Button ID="btnAddSubscription" runat="server" Text="Add Subscription"
            CssClass="btn btn-primary" OnClick="btnAddSubscription_Click" />
    </div>

    <br /><br />
<asp:Button ID="btnViewSubscriptions" runat="server" Text="View All Subscriptions" 
    CssClass="btn btn-info" OnClick="btnViewSubscriptions_Click" />

   
    <!-- Message Label -->
<div style="text-align:center; margin-top:15px;">
    <asp:Label ID="lblMessage" runat="server" 
        CssClass="fw-bold"
        ForeColor="Green"
        Visible="false"
        Font-Size="Medium">
    </asp:Label>
</div>

</asp:Content>
