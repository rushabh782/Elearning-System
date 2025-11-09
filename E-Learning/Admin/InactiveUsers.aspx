<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="InactiveUsers.aspx.cs" Inherits="E_Learning.Admin.InactiveUsers" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-dark mb-0">Inactive Users</h3>
            <asp:HyperLink ID="lnkViewAllUsers" runat="server" NavigateUrl="~/Admin/Users.aspx" CssClass="btn btn-outline-primary">
                <i class="fas fa-users"></i> View All Users
            </asp:HyperLink>
        </div>

        <div class="glass-card">
            <!-- If MasterPage already has a ScriptManager remove this one -->
            <asp:ScriptManager ID="ScriptManager1" runat="server" />

            <!-- UpdatePanel so changes refresh without full postback -->
            <asp:UpdatePanel ID="upInactiveUsers" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="alert alert-info text-center">
                        <i class="fas fa-info-circle"></i> No inactive users found.
                    </asp:Panel>

                    <asp:Repeater ID="rptInactiveUsers" runat="server" OnItemCommand="rptInactiveUsers_ItemCommand">
                        <HeaderTemplate>
                            <table class="table table-bordered table-hover table-dark align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Status</th>
                                        <th>Profile</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>

                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("user_id") %></td>
                                <td><%# Eval("name") %></td>
                                <td><%# Eval("email") %></td>
                                <td>
                                    <div class="custom-checkbox-wrapper">
                                        <div class="custom-checkbox"></div>
                                        <span class="status-label"><%# Eval("status") %></span>
                                    </div>
                                </td>
                                <td><%# Eval("profile") %></td>
                                <td>
                                    <asp:LinkButton ID="btnChangeStatus" runat="server" Text="Change Status"
                                        CssClass="btn btn-sm btn-primary"
                                        CommandName="ChangeStatus"
                                        CommandArgument='<%# Eval("user_id") + "|" + Eval("status") %>'
                                        CausesValidation="false" />
                                </td>
                            </tr>
                        </ItemTemplate>

                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- Place the modal inside the UpdatePanel so server controls participate in async postbacks -->
                    <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content bg-dark text-white">
                          <div class="modal-header">
                            <h5 class="modal-title">Change User Status</h5>
                            <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <asp:HiddenField ID="hfUserId" runat="server" />
                            <div class="form-check">
                                <asp:RadioButton ID="rbActive" runat="server" GroupName="statusGroup"  CssClass="form-check-input" />
                                <label for="<%= rbActive.ClientID %>" class="form-check-label">Active</label>
                            </div>
                            <div class="form-check mt-2">
                                <asp:RadioButton ID="rbInactive" runat="server" GroupName="statusGroup"  CssClass="form-check-input" />
                                <label for="<%= rbInactive.ClientID %>" class="form-check-label">Inactive</label>
                            </div>
                          </div>
                          <div class="modal-footer">
                            <asp:Button ID="btnConfirm" runat="server" CssClass="btn btn-success" Text="Confirm" OnClick="btnConfirm_Click" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                          </div>
                        </div>
                      </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>