<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updateextension.aspx.cs" Inherits="GUC.updateextension" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="ThesisSerialNo"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="extension" Text="add an extension" />
             <br />
            <br />
             <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back"  />

        </div>
    </form>
</body>
</html>
