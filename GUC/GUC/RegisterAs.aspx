<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterAs.aspx.cs" Inherits="GUC.RegisterAs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="What type of user are you?"></asp:Label>
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="1">Student</asp:ListItem>
                <asp:ListItem Value="2">Supervisor</asp:ListItem>
                <asp:ListItem Value="3">Examiner</asp:ListItem>
            </asp:DropDownList>
            <br />
                 <asp:Button runat="server" onClick="Next" Text="Next" />
             <br  />
             <br  />
            <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back"  />
        </div>
    </form>
</body>
</html>
