<%@ Page Title="View Subscriptions" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ViewSubscriptions.aspx.cs" Inherits="E_Learning.Admin.ViewSubscriptions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-vdD8rW5l9lKqXcXb1q36Yj6HfV9u6wY3R1lqY8+38U9E3zF5pFgfIhIh9XcK1rOZ6l8G1U4P7bLq3dP+nLh0JQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <style>
        .container {
            padding-top: 40px;
            padding-bottom: 40px;
            color: white;
        }

        .glass-card {
            background: rgba(52, 58, 64, 0.9); /* dark grey transparent */
            backdrop-filter: blur(8px);
            border-radius: 12px;
            padding: 20px;
            color: white;
        }

        table.table {
            width: 100%;
            border-collapse: collapse;
        }

            table.table th, table.table td {
                border: 1px solid #6c757d;
                padding: 10px;
                text-align: center; /* center align */
                vertical-align: middle; /* vertical center */
            }

            table.table th {
                background-color: #495057;
                color: #f8f9fa;
                font-weight: 600;
                padding: 12px;
            }


            table.table tr:nth-child(even) {
                background-color: #343a40;
            }

            table.table tr:nth-child(odd) {
                background-color: #3e444a;
            }

            table.table td {
                color: #f8f9fa;
                word-wrap: break-word;
                max-width: 200px;
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
            border: 1px solid #f8f9fa;
            color: #f8f9fa;
            background-color: transparent;
        }

            .btn-outline-light:hover {
                background-color: #f8f9fa;
                color: #343a40;
            }

        .btn-action {
            min-width: 70px; /* dono buttons ka same width */
            text-align: center;
            font-weight: 500;
            transition: all 0.3s ease;
        }

            .btn-action i {
                margin-right: 5px;
                font-weight: bold;
            }

            .btn-action:hover {
                transform: scale(1.05);
            }

        /* Button gradient hover effect */
        .btn-warning.btn-action:hover {
            background: linear-gradient(45deg, #ffc107, #ffdb4d);
            color: black;
            transform: scale(1.05);
        }

        .btn-danger.btn-action:hover {
            background: linear-gradient(45deg, #dc3545, #e66773);
            color: white;
            transform: scale(1.05);
        }


        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 10px;
        }

            .pagination-container .btn {
                min-width: 80px;
            }

        .lblPage {
            color: white;
            font-weight: bold;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h3 class="text-light mb-4">Subscriptions</h3>
        <asp:Label ID="lblMessage" runat="server" Visible="false" ForeColor="Red"></asp:Label>

        <div class="glass-card">
            <asp:Repeater ID="rptSubscriptions" runat="server">
                <HeaderTemplate>
                    <table class="table table-bordered table-hover table-dark align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Price (₹)</th>
                                <th>Duration</th>
                                <th>Type</th>
                                <th>SubCourses</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <td><%# Eval("title") %></td>
                        <td><%# Eval("description") %></td>
                        <td><%# Eval("price") %></td>
                        <td><%# Eval("duration_days") %> days</td>
                        <td><%# Eval("subscription_type") %></td>
                        <td><%# Eval("SubCourses") %></td>
                        <td>
                            <div class="d-flex justify-content-center gap-2">
                                <asp:HyperLink ID="lnkEdit" runat="server" CssClass="btn btn-warning btn-sm btn-action"
                                    NavigateUrl='<%# "EditSubscription.aspx?id=" + Eval("subscription_id") %>'>
        <i class="fas fa-pen"></i> Edit
                                </asp:HyperLink>

                                <asp:HyperLink ID="lnkDelete" runat="server" CssClass="btn btn-danger btn-sm btn-action"
                                    NavigateUrl='<%# "DeleteSubscription.aspx?id=" + Eval("subscription_id") %>'>
        <i class="fas fa-trash"></i> Delete
                                </asp:HyperLink>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <div class="pagination-container">
                <asp:Button ID="btnPrev" runat="server" CssClass="btn btn-outline-light btn-sm" Text="Previous" OnClick="btnPrev_Click" />
                <asp:Label ID="lblPage" runat="server" CssClass="lblPage" />
                <asp:Button ID="btnNext" runat="server" CssClass="btn btn-outline-light btn-sm" Text="Next" OnClick="btnNext_Click" />
            </div>

        </div>
    </div>
</asp:Content>
