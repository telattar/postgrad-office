<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentLinkPubThesis.aspx.cs" Inherits="GUC.StudentLinkPubThesis" %>

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

            <asp:Label ID="Label3" runat="server" Text="Link Publication to Thesis"></asp:Label>
            <br />
            <br />

            <asp:Label ID="Label1" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="tsn" runat="server" placeholder="must be an integer"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Publication Number"></asp:Label>
            <asp:TextBox ID="prno" runat="server" placeholder="must be an integer"></asp:TextBox>
                        <br />

            <asp:Button ID="Button1" runat="server" Text="Done" onClick ="linkpubthesis" />
            <br />
            <br />
            <asp:Label ID="successl" runat="server" Text=""></asp:Label>
            

        </div>
    </form>
</body>
</html>
