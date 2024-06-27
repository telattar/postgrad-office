<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NonGucianStudentHomePage.aspx.cs" Inherits="GUC.NonGucianStudentHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="signoutbutton" runat="server" Text="Sign Out" OnClick="signout" />
        <br />
        <br />

        <asp:Button ID="Button1" runat="server" Text="View my Profile" OnClick="viewmyprof" />
        <asp:Button ID="Button8" runat="server" Text="Add Phone Number" OnClick="addmobs" />

        <asp:Button ID="Button2" runat="server" Text="List my Theses" OnClick="listmythesis" />
        <asp:Button ID="Button3" runat="server" Text="Add Progress Report" OnClick="addpr" />
        <asp:Button ID="Button4" runat="server" Text="Fill Progress Report" OnClick="fillpr" />
        <asp:Button ID="Button5" runat="server" Text="Add Publication" OnClick="addpub" />
        <asp:Button ID="Button6" runat="server" Text="Link Publication to Thesis" OnClick="linkpub" />
        <asp:Button ID="Button7" runat="server" Text="Show Courses Details" OnClick="showcourse" />

    </form>


        <div>
        </div>
    </form>
</body>
</html>
