<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="evaluatePR.aspx.cs" Inherits="GUC.evaluatePR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <asp:Label ID="Label5" runat="server" Text="Evaluate Progress Report"></asp:Label>
            <br />
                 <asp:Label ID="Label1" runat="server" Text="Thesis Serial No:"></asp:Label>
                 <asp:TextBox ID="SerialNo" runat="server"></asp:TextBox>
            <br />
                 <asp:Label ID="Label3" runat="server" Text="Progress Report No:"></asp:Label>
                <asp:TextBox ID="ProgressReportNo" runat="server"></asp:TextBox>
            <br />
                 <asp:Label ID="Label4" runat="server" Text="Evaluation:"></asp:Label>
                <asp:TextBox ID="Evaluation" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="pr" Text="Post Evaluation" />
             <asp:Button ID="Button1" runat="server" onClick="back" Text="Back" />
        </div>
    </form>
</body>
</html>
