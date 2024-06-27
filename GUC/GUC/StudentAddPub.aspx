<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentAddPub.aspx.cs" Inherits="GUC.StudentAddPub" %>

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

            <asp:Label ID="Label6" runat="server" Text="Add Publication "></asp:Label>
            <br />
            <br />

            <asp:Label ID="Label1" runat="server" Text="Title "></asp:Label>
            <asp:TextBox ID="title" runat="server" placeholder="doesn't exceed 100 characters" Width="315px"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Date "></asp:Label>
            <br />
            <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Host "></asp:Label>
            <asp:TextBox ID="host" runat="server" placeholder="doesn't exceed 100 characters" Width="248px"></asp:TextBox>
            <br />

            <asp:Label ID="Label4" runat="server" Text="Place "></asp:Label>
            <asp:TextBox ID="place" runat="server" placeholder="doesn't exceed 100 characters" Width="240px"></asp:TextBox>
            <br />

            <asp:Label ID="Label5" runat="server" Text="Accepted "></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="1">Yes</asp:ListItem>
                <asp:ListItem Value="0">No</asp:ListItem>
            </asp:DropDownList>
            <br />


            <asp:Button ID="addpub" runat="server" Text="Done" OnClick="addpubbutton" />


            <br />
            <asp:Label ID="successlabel" runat="server" Text=" "></asp:Label>



        </div>
    </form>
</body>
</html>
