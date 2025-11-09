<%@ Page Title="Payment Gateway" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="E_Learning.User.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts for Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Razorpay Checkout Script -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        /* Hero Section - Payment Focused */
        .payment-hero {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
            padding: 60px 0;
            text-align: center;
        }

        .payment-hero h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .payment-hero p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Payment Container */
        .payment-container {
            max-width: 800px;
            margin: -40px auto 60px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .payment-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        .payment-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 5px;
        }

        .payment-header p {
            color: #6b7280;
            font-size: 0.95rem;
        }

        .payment-body {
            padding: 30px;
        }

        /* Payment Summary */
        .payment-summary {
            background: #f9fafb;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 1px solid #e5e7eb;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.95rem;
        }

        .summary-item.total {
            font-weight: 700;
            font-size: 1.1rem;
            border-top: 1px solid #d1d5db;
            padding-top: 10px;
            color: #1f2937;
        }

        .summary-item .label {
            color: #6b7280;
        }

        .summary-item .value {
            color: #1f2937;
        }

        /* User Details Form */
        .user-details {
            margin-bottom: 30px;
        }

        .user-details h4 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: #374151;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
        }

        .form-group input:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        /* Pay Now Button */
        .pay-btn {
            background: #4f46e5;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .pay-btn:hover {
            background: #3730a3;
            transform: translateY(-2px);
        }

        .pay-btn:disabled {
            background: #d1d5db;
            cursor: not-allowed;
        }

        /* Loading Spinner */
        .loading {
            display: none;
            text-align: center;
            margin-top: 20px;
        }

        .spinner {
            border: 4px solid #f3f4f6;
            border-top: 4px solid #4f46e5;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Success/Error Messages */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .alert-error {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .payment-hero h1 {
                font-size: 2rem;
            }

            .payment-body {
                padding: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero Section -->
    <div class="payment-hero">
        <div class="container">
            <h1>Secure Payment</h1>
            <p>Complete your enrollment with a quick and secure transaction</p>
        </div>
    </div>

    <!-- Payment Container -->
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h3>Payment Details</h3>
                <p>Review your order and proceed to payment</p>
            </div>
            <div class="payment-body">
                <!-- Success/Error Messages -->
                <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i> Payment successful! You will be redirected shortly.
                </asp:Panel>
                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-error">
                    <i class="fas fa-exclamation-triangle me-2"></i> Payment failed. Please try again.
                </asp:Panel>

                <!-- Payment Summary -->
                <div class="payment-summary">
                    <div class="summary-item">
                        <span class="label">Item:</span>
                        <span class="value"><asp:Label ID="lblItemName" runat="server" Text="Course/Subscription Name" /></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Description:</span>
                        <span class="value"><asp:Label ID="lblItemDescription" runat="server" Text="Brief description" /></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Quantity:</span>
                        <span class="value">1</span>
                    </div>
                    <div class="summary-item total">
                        <span class="label">Total Amount:</span>
                        <span class="value"><asp:Label ID="lblAmount" runat="server" Text="₹0.00" /></span>
                    </div>
                </div>

                <!-- User Details Form -->
                <div class="user-details">
                    <h4>Billing Information</h4>
                    <div class="form-group">
                        <label for="txtName">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Enter your full name" />
                    </div>
                    <div class="form-group">
                        <label for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Placeholder="Enter your email" />
                    </div>
                    <div class="form-group">
                        <label for="txtContact">Phone Number</label>
                        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" Placeholder="Enter your phone number" />
                    </div>
                </div>

                <!-- Pay Now Button -->
                <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="pay-btn" OnClick="btnPayNow_Click" />

                <!-- Loading Spinner -->
                <div class="loading" id="loadingSpinner">
                    <div class="spinner"></div>
                    <p>Processing payment...</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content> 