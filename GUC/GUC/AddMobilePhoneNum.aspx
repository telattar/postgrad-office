<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMobilePhoneNum.aspx.cs" Inherits="GUC.AddMobilePhoneNum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                       <asp:Button ID="backbutton" runat="server" onClick="backtohome" Text="Back" />


            <br />
            <br />

            <asp:Label ID="Label2" runat="server" Text="Add A Mobile Phone Number"></asp:Label>
                        <br />            <br />
            <asp:Label ID="Label1" runat="server" Text="Phone Number"></asp:Label>
            <asp:TextBox ID="mob" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Add" OnClick="addmobilenow" />
            <br />
            <asp:Label ID="dolabel" runat="server" Text=""></asp:Label>

        </div>
    </form>
</body>
</html>
