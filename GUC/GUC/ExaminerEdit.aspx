<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerEdit.aspx.cs" Inherits="GUC.ExaminerEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
        <div>
            
            <asp:Label ID="Label2" runat="server" Text="Examiner Name: "></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Field Of Work: "></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="mail: "></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="password: "></asp:Label>
            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="ubutton" runat="server" onClick="UpdateInfo" Text="update" />
            <asp:Label ID="msg" runat="server"></asp:Label>

            <br />
            <br />
            <asp:Button ID="bbutton" runat="server" onClick="gobackk" Text="Back" />

        </div>
    </form>
</body>
</html>
