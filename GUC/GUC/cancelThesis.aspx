<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cancelThesis.aspx.cs" Inherits="GUC.cancelThesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Label ID="Label1" runat="server" Text="Cancel Thesis"></asp:Label>
            <br />
             <asp:Label ID="Label2" runat="server" Text="Serial No:"></asp:Label>
            <asp:TextBox ID="SerialNo" runat="server" placeholder="must be an integer"></asp:TextBox>
            <br /? />
            <asp:Button ID="Button2" runat="server" onClick="cancel" Text="Cancel Thesis" />
             <asp:Button ID="Button1" runat="server" onClick="back" Text="Back" />
        </div>
    </form>
</body>
</html>
