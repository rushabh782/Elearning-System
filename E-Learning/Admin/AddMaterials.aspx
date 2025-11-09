<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddMaterials.aspx.cs" Inherits="E_Learning.Admin.AddMaterials" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- You can copy the <style> block from AddMasterCourse.aspx here --%>
    <style>
        .glass-card {
            background-color: #343A40; color: #ffffff; border-radius: 12px;
            padding: 30px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            max-width: 800px; margin: auto;
        }
        .form-control { background-color: #ffffff; color: #343A40; border: 1px solid #ced4da; }
        .form-label { color: #ffffff; font-weight: 500; }
        .page-header { text-align: center; margin-bottom: 30px; }
        .page-header h2 { color: #2c2f33; font-weight: bold; }
        .grid-view { width: 100%; color: #343A40; background-color: #ffffff; }
        .grid-view th { background-color: #e9ecef; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="page-header">
            <h2>Add Materials</h2>
            <asp:Label ID="lblTopicTitle" runat="server" CssClass="fs-5" Text="Loading..."></asp:Label>
            <asp:HiddenField ID="hfTopicId" runat="server" />
            <asp:HiddenField ID="hfSubCourseId" runat="server" />
        </div>

        <div class="glass-card mb-4">
            <h4 class="mb-4">New Material Details</h4>

            <div class="mb-3">
                <label class="form-label">Material Title</label>
                <asp:TextBox ID="txtMaterialTitle" runat="server" CssClass="form-control" placeholder="Enter material title" />
            </div>

            <div class="mb-3">
                <label class="form-label">Material Type</label>
                <asp:DropDownList ID="ddlMaterialType" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlMaterialType_SelectedIndexChanged">
                    <asp:ListItem Text="Select Type" Value="" />
                    <asp:ListItem Text="Video" Value="video" />
                    <asp:ListItem Text="PDF" Value="pdf" />
                    <asp:ListItem Text="Quiz" Value="quiz" />
                    <asp:ListItem Text="Link" Value="link" />
                </asp:DropDownList>
            </div>

            <asp:Panel ID="pnlLink" runat="server" Visible="false" class="mb-3">
                <label class="form-label">URL (for Video, Quiz, or Link)</label>
                <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control" placeholder="Enter URL" />
            </asp:Panel>
            
            <asp:Panel ID="pnlPdf" runat="server" Visible="false" class="mb-3">
                <label class="form-label">Upload PDF File</label>
                <asp:FileUpload ID="fuPdf" runat="server" CssClass="form-control" />
            </asp:Panel>
            <asp:Button ID="btnSaveMaterial" runat="server" CssClass="btn btn-light" Text="Save Material" OnClick="btnSaveMaterial_Click" />
            <asp:Label ID="lblStatus" runat="server" EnableViewState="false" CssClass="ms-3"></asp:Label>
        </div>

        <div class="glass-card">
            <h4 class="mb-4">Existing Materials</h4>
            <asp:GridView ID="gvMaterials" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover grid-view"
                DataKeyNames="material_id" OnRowDeleting="gvMaterials_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="title" HeaderText="Material Title" />
                    <asp:BoundField DataField="type" HeaderText="Type" />
                    <asp:BoundField DataField="url" HeaderText="Link/File Path" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                CommandName="Delete" CommandArgument='<%# Eval("material_id") %>' 
                                CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to delete this material?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="mt-4">
                 <asp:Button ID="btnBackToTopics" runat="server" Text="Back to Topics" OnClick="btnBackToTopics_Click" CssClass="btn btn-outline-light" />
            </div>
        </div>
    </div>
</asp:Content>