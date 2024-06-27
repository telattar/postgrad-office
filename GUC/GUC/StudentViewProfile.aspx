<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentViewProfile.aspx.cs" Inherits="GUC.StudentViewProfile" %>

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

            <asp:Label ID="Label7" runat="server" Text="Student Details"></asp:Label>
            <br />

            <asp:Label ID="Label2" runat="server" Text="ID: "></asp:Label>
            <asp:Label ID="IDLABEL" runat="server" Text="Label"></asp:Label>

            <br />
            <asp:Label ID="Label1" runat="server" Text="First Name: "></asp:Label>
            <asp:Label ID="FNLABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Last Name: "></asp:Label>
            <asp:Label ID="LNLABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Type: "></asp:Label>
            <asp:Label ID="TYPELABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label8" runat="server" Text="Faculty: "></asp:Label>
            <asp:Label ID="FACLABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label10" runat="server" Text="Address: "></asp:Label>
            <asp:Label ID="ADDRESSLABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label12" runat="server" Text="GPA: "></asp:Label>
            <asp:Label ID="GPALABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label14" runat="server" Text="UndergradID (GUCIANS ONLY): "></asp:Label>
            <asp:Label ID="UNIDLABEL" runat="server" Text="none"></asp:Label>
            <br />
            <asp:Label ID="Label16" runat="server" Text="Email: "></asp:Label>
            <asp:Label ID="MAILLABEL" runat="server" Text="Label"></asp:Label>

        </div>
    </form>
</body>
</html>
