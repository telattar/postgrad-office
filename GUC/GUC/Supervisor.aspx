<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supervisor.aspx.cs" Inherits="GUC.Supervisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Label ID="FirstS" runat="server" Text="First Name:"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="LastS" runat="server" Text="Last Name:"></asp:Label>
             <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Mail" runat="server" Text="Mail:"></asp:Label>
             <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Password" runat="server" Text="Password:"></asp:Label>
             <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Faculty" runat="server" Text="Faculty:"></asp:Label>
             <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="Button1" runat="server" onClick="Regnow" Text ="Register Now" />
             <br  />
             <br  />
            <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back"  />
        </div>
    </form>
</body>
</html>
