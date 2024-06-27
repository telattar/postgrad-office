<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperHomePage.aspx.cs" Inherits="GUC.SuperHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" onClick="ListStudents" Text="List Students Names" />
            <asp:Button ID="Button2" runat="server" OnClick="ViewPublication" Text="View Publication of a Student" />
            <asp:Button ID="Button3" runat="server" OnClick="AddDefense" Text="Add Defense" />
            <asp:Button ID="Button4" runat="server" onClick="EvaluatePR" Text="Evaluate Progress Report"/>
            <asp:Button ID="Button5" runat="server" onClick="CancelThesis" Text="Cancel Thesis"/>
            <asp:Button ID="Button6" runat="server" OnClick="SignOut" Text="Sign Out" />

        </div>
    </form>
</body>
</html>
