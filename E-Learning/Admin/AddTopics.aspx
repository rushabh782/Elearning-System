<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddTopics.aspx.cs" Inherits="E_Learning.Admin.AddTopics" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- You can copy the <style> block from AddMasterCourse.aspx here if you want --%>
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
            <h2>Add Topics</h2>
            <asp:Label ID="lblSubCourseTitle" runat="server" CssClass="fs-5" Text="Loading..."></asp:Label>
            <asp:HiddenField ID="hfSubCourseId" runat="server" />
        </div>

        <div class="glass-card mb-4">
            <h4 class="mb-4">New Topic Details</h4>
            
            <div class="mb-3">
                <label class="form-label">Topic Title</label>
                <asp:TextBox ID="txtTopicTitle" runat="server" CssClass="form-control" placeholder="Enter topic title" />
            </div>
            
            <div class="mb-3">
                <label class="form-label">Sequence Number</label>
                <asp:TextBox ID="txtSequence" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g., 1" />
            </div>
            
            <asp:Button ID="btnSaveTopic" runat="server" CssClass="btn btn-light" Text="Save Topic" OnClick="btnSaveTopic_Click" />
            <asp:Label ID="lblStatus" runat="server" EnableViewState="false" CssClass="ms-3"></asp:Label>
        </div>

        <div class="glass-card">
            <h4 class="mb-4">Existing Topics</h4>
            <asp:GridView ID="gvTopics" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover grid-view"
                DataKeyNames="topic_id" OnRowCommand="gvTopics_RowCommand" OnRowDeleting="gvTopics_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="title" HeaderText="Topic Title" />
                    <asp:BoundField DataField="sequence_number" HeaderText="Sequence" />
                    
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnAddMaterials" runat="server" Text="Add Materials" 
                                CommandName="AddMaterials" CommandArgument='<%# Eval("topic_id") %>' 
                                CssClass="btn btn-sm btn-primary" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                CommandName="Delete" CommandArgument='<%# Eval("topic_id") %>' 
                                CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to delete this topic?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="mt-4">
                 <asp:Button ID="btnDone" runat="server" Text="Done (Back to Courses)" OnClick="btnDone_Click" CssClass="btn btn-outline-light" />
            </div>
        </div>
    </div>
</asp:Content>