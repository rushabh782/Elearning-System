<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseListUser.aspx.cs" Inherits="E_Learning.User.CourseListUser" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .table td,
        .table th {
            vertical-align: middle;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <h3 class="mb-4">📚 My Courses</h3>
            
            <asp:GridView 
                ID="gvUserCourses" 
                runat="server" 
                AutoGenerateColumns="False" 
                CssClass="table table-bordered table-hover">
                
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Subcourse Title" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="MasterTitle" HeaderText="Master Course" />
                </Columns>
            </asp:GridView>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
