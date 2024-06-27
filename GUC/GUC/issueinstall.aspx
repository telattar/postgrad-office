<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="issueinstall.aspx.cs" Inherits="GUC.issueinstall" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="paymentID"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
             <br />
             <br />
            <asp:Label ID="Label5" runat="server" Text="Installments start date"></asp:Label>
            <br />
            <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="ISsueinstall" Text="Issue installments" />
             <br />
            <br />
             <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back"  />

        </div>
    </form>
</body>
</html>
