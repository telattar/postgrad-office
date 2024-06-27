<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GucianStudentHomePage.aspx.cs" Inherits="GUC.GucianStudentHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<body>


    <form id="form1" runat="server">
        <asp:Button ID="backbutton" runat="server" Text="Sign Out" OnClick="backtologin" />
        <br />
        <br />

        <asp:Button ID="Button1" runat="server" Text="View my Profile" OnClick="ViewProf" />
        <asp:Button ID="Button2" runat="server" Text="List my Theses" OnClick="ListThesis" />
        <asp:Button ID="Button3" runat="server" Text="Add Progress Report" OnClick="addPR" />
        <asp:Button ID="Button4" runat="server" Text="Fill Progress Report" OnClick="fillPR" />
        <asp:Button ID="Button5" runat="server" Text="Add Publication" OnClick="addPub" />
        <asp:Button ID="Button6" runat="server" Text="Link Publication to Thesis" OnClick="linkPub" />
        <asp:Button ID="Button7" runat="server" Text="Add Mobile Number" OnClick="ADDMOB" />

    </form>


</body>
</html>
