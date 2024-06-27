<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewPublication.aspx.cs" Inherits="GUC.viewPublication" %>

            
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="View Student Publication"></asp:Label>  
            <br />
             <asp:Label ID="Label2" runat="server" Text="Student ID:"></asp:Label>     
            <asp:TextBox ID="StudentId" runat="server"></asp:TextBox>
            <br />
             <asp:Button ID="Button2" runat="server" onClick="view" Text="View" />
             <asp:Button ID="Button1" runat="server" onClick="back" Text="Back" />
        </div>
    </form>
</body>
</html>
