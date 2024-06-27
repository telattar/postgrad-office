<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterStudent.aspx.cs" Inherits="GUC.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="FirstN" runat="server" Text="First Name:"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="LastN" runat="server" Text="Last Name:"></asp:Label>
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
            <asp:Label ID="Address" runat="server" Text="Address:"></asp:Label>
             <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="GUCian" runat="server" Text="Are you GUCian?"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Button ID="RegisterNowButton" runat="server" OnClick="RegisterNow" Text="Register Now" />
             <br  />
             <br  />
            <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back"  />
        </div>
    </form>
</body>
</html>

