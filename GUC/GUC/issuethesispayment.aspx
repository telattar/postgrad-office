<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="issuethesispayment.aspx.cs" Inherits="GUC.issuethesispayment" %>

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
            <asp:Label ID="Label2" runat="server" Text="amount"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="Label3" runat="server" Text="noOfInstallments"></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="Label4" runat="server" Text="fundPercentage"></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="ISssuepayment" Text="Issue Payment" />
             <br />
            <br />
             <asp:Button ID="Back" runat="server" OnClick="Backad" Text="Back"  />

        </div>
    </form>
</body>
</html>
