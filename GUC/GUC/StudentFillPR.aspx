<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentFillPR.aspx.cs" Inherits="GUC.StudentFillPR" %>

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

            <asp:Label ID="Label1" runat="server" Text="Fill Progress Report"></asp:Label>
            <br />
            <br />



            <asp:Label ID="Label2" runat="server" Text="Thesis Serial Number "></asp:Label>
            <asp:TextBox ID="tsn" runat="server" placeholder="must be an integer"></asp:TextBox>
            <br />

            <asp:Label ID="Label3" runat="server" Text="Progress Report No "></asp:Label>
            <asp:TextBox ID="prno" runat="server" placeholder="must be an integer"></asp:TextBox>
            <br />

            <asp:Label ID="Label4" runat="server" Text="State "></asp:Label>
            <asp:TextBox ID="statetext" runat="server" placeholder="must be an integer" ></asp:TextBox>
            <br />

            <asp:Label ID="Label5" runat="server" Text="Description " ></asp:Label>
            <asp:TextBox ID="descrip" runat="server" placeholder="doesn't exceed 200 characters" Width="881px"></asp:TextBox>
            <br />
            <br />


            <asp:Button ID="Button1" runat="server" Text="Done" OnClick="FillProgress" />
            <br />

            <asp:Label ID="succeslb" runat="server" Text=""></asp:Label>

        </div>
        
    </form>
</body>
</html>
