<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHomePage.aspx.cs" Inherits="GUC.AdminHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Button ID="listsuperA" runat="server" OnClick="listsuper" Text="List all supervisors" Width="465px" />
            <br  />
            <asp:Button ID="listthesisA" runat="server" OnClick="listthesis" Text="List all thesis" Width="465px" />
            <br  />
            <asp:Button ID="ongoingA" runat="server" OnClick="ongoing" Text="On going thesis" Width="465px" />
            <br  />
            <asp:Button ID="issuethesispaymentA" runat="server" OnClick="issuethesispayment" Text="Issue a payment for a thesis" Width="465px" />
            <br  />
            
            <asp:Button ID="issueinstallA" runat="server" OnClick="issueinstall" Text="Issue installments" Width="465px" />
            <br  />
            <asp:Button ID="updateextensionA" runat="server" OnClick="updateextension" Text="Add extention" Width="464px" />
             <br  />
             <br  />
            <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back" Width="464px" />


        </div>
    </form>
</body>
</html>
