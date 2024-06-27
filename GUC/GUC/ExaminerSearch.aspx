<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerSearch.aspx.cs" Inherits="GUC.ExaminerSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Enter Thesis Keyword: "></asp:Label>
            <asp:TextBox ID="keyword" runat="server"></asp:TextBox>
            <asp:Button ID="kbutton" runat="server" OnClick="Searching" Text="Search" />
            <asp:Button ID="bbutton" OnClick="gobackk" runat="server" Text="Back" />
        </div>
    </form>
</body>
</html>
