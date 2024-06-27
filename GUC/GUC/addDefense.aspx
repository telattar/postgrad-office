<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addDefense.aspx.cs" Inherits="GUC.addDefense" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Add Defense"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Serial No:"></asp:Label>
            <asp:TextBox ID="SerialNo" runat="server" placeholder="Enter an integer only"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Defense Date:"></asp:Label>
            <asp:TextBox ID="date" runat="server" placeholder="Date Format mm-dd-yy"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Defense Location:"></asp:Label>
            <asp:TextBox ID="DefenseLocation" runat="server" placeholder="Enter a location"></asp:TextBox>
            <br />
             <asp:Button ID="Button2" runat="server" onclick="add" Text="Add Defense" />
             <asp:Button ID="Button1" runat="server" onClick="back" Text="Back" />
        </div>
    </form>
</body>
</html>
