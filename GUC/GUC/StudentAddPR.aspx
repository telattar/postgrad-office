<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentAddPR.aspx.cs" Inherits="GUC.StudentAddPR" %>

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

            <asp:Label ID="Label5" runat="server" Text="ADD PROGRESS REPORT"></asp:Label>
            <br />
            <br />

            
            <asp:Label ID="Label1" runat="server" Text="Thesis Serial Number "></asp:Label>
            <asp:TextBox ID="tsn" runat="server" placeholder="must be an integer"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Progress Report No "></asp:Label>
            <asp:TextBox ID="prno" runat="server"  placeholder="must be an integer"></asp:TextBox>
            <br />

            <asp:Label ID="Label3" runat="server" Text="Progress Report Date "></asp:Label>
            <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
            <br />

            <br />
            <asp:Button ID="Button1" runat="server" onClick="ADDPROGREP" Text="ADD" />
            <br />
            <br />

            <asp:Label ID="successLabel" runat="server" Text=" "></asp:Label>


        </div>
    </form>
</body>
</html>
