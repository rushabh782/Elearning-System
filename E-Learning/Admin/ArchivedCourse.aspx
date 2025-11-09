<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArchivedCourse.aspx.cs" Inherits="E_Learning.Admin.ArchivedCourse" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Archived Courses</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
    <style>
        .modal-custom { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; 
                 overflow: auto; background-color: rgba(0,0,0,0.5); }
        .modal-content-custom { background-color: #fff; margin: 10% auto; padding: 20px; border-radius: 10px; width: 40%; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2>Archived Courses</h2>
            <asp:GridView ID="gvMasterCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                OnRowCommand="gvMasterCourses_RowCommand">
                <Columns>
                    <asp:BoundField DataField="title" HeaderText="Master Course" />
                    <asp:BoundField DataField="status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Sub Courses">
                        <ItemTemplate>
                            <asp:Label ID="lblSubCount" runat="server" Text='<%# Eval("SubCourseCount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnArchive" runat="server" Text="Archive" CssClass="btn btn-danger"
                                CommandName="Archive" CommandArgument='<%# Eval("master_course_id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
           <asp:Button ID="btnBackDashboard" runat="server" Text="Back to Dashboard" CssClass="btn btn-primary mb-3" OnClick="btnBackDashboard_Click" />

        </div>

        <!-- Modal -->
        <asp:Panel ID="pnlArchiveModal" runat="server" CssClass="modal-custom">
            <div class="modal-content-custom">
                <h4>Archive Subcourses for <asp:Label ID="lblMasterCourseTitle" runat="server" Text=""></asp:Label></h4>
                <asp:CheckBoxList ID="chkSubCourses" runat="server" RepeatLayout="Flow"></asp:CheckBoxList><br /><br />
                <asp:Button ID="btnConfirmArchive" runat="server" Text="Archive Selected" OnClick="btnConfirmArchive_Click" CssClass="btn btn-success" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="hideModal(); return false;" CssClass="btn btn-secondary" />
            </div>
        </asp:Panel>

        <script>
            function showModal() {
                document.getElementById('<%= pnlArchiveModal.ClientID %>').style.display = 'block';
            }
            function hideModal() {
                document.getElementById('<%= pnlArchiveModal.ClientID %>').style.display = 'none';
            }
        </script>
    </form>
</body>
</html>

