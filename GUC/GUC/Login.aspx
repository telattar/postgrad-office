<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GUC.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Email:"></asp:Label>
        <asp:TextBox ID="Userid" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Password:"></asp:Label>
        <asp:TextBox ID="Password" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="LoginButton" runat="server" OnClick="login" Text="Login" />
           <br />
        <asp:Button ID="RegisterButton" runat="server" OnClick="register" Text="Register" />
        <br />
        <asp:Label ID="labelz" runat="server" Text=" "></asp:Label>
        
    </form>
    
</body>
</html>
