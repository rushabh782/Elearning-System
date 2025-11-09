<%@ Page Title="Delete Account" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="DeleteAccount.aspx.cs" Inherits="E_Learning.User.DeleteAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-center flex-wrap gap-4 mt-5">
        <asp:DataList ID="btnConfirmDelete" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" OnItemCommand="btnConfirmDelete_ItemCommand">
             <ItemTemplate>
      <div class="card shadow-sm border-danger" style="width: 18rem;">
          <img src='<%# Eval("profile") %>' class="card-img-top rounded-circle mx-auto mt-3" style="height: 100px; width: 100px;" />
          <div class="card-body text-center">
              <h5 class="card-title"><%# Eval("name") %></h5>
              <ul class="list-group list-group-flush mb-3">
                  <li class="list-group-item"><b>Email ID:</b> <%# Eval("email") %></li>
                  <li class="list-group-item"><b>Role:</b> <%# Eval("role") %></li>
              </ul>
              <asp:Button ID="btnDelete" runat="server" Text="Delete Account"
                  CommandName="Delete"
                  CommandArgument='<%# Eval("user_id") %>'
                  CssClass="btn btn-danger w-100" />
          </div>
      </div>
  </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
