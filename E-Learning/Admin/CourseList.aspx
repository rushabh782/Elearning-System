<%@ Page Title="Course List" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="E_Learning.Admin.CourseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .course-container { margin: 20px; font-family: Arial, sans-serif; }
        .filters { margin-bottom: 20px; }
        .table td, .table th { vertical-align: middle; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="course-container">
        <!-- 🔽 Course Type Dropdown Filter -->
        <div class="filters row">
            <div class="col-md-12">
                <asp:DropDownList ID="ddlCourseFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCourseFilter_SelectedIndexChanged" CssClass="form-select">
                    <asp:ListItem Text="-- Select Course Type --" Value="0" />
                    <asp:ListItem Text="Master Courses" Value="master" />
                    <asp:ListItem Text="Sub Courses" Value="sub" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- 📊 Table UI -->
        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
            <Columns>
                <asp:BoundField DataField="MasterTitle" HeaderText="Master Course" />
                <asp:BoundField DataField="SubTitle" HeaderText="Sub Course / Count" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"
                            CssClass="form-select form-select-sm"
                            SelectedValue='<%# Eval("Status") %>'>
                            <asp:ListItem Text="active" Value="active" />
                            <asp:ListItem Text="archived" Value="archived" />
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdnCourseType" Value='<%# Eval("IsMaster") %>' runat="server" />
                        <asp:HiddenField ID="hdnCourseId" Value='<%# Eval("CourseId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- 🔍 Optional Modal for View More -->
        <div class="modal fade" id="viewMoreModal" tabindex="-1" aria-labelledby="viewMoreLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewMoreLabel">Course Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:Literal ID="litCourseDetails" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS for modal -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
