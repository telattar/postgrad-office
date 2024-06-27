<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerHomePage.aspx.cs" Inherits="GUC.ExaminerHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
        <div>
           
            <asp:Button ID="editbutton" runat="server" OnClick="changeInfo" Text="Edit My Personal Details" />
            <br />
            <br />
            <asp:Label ID="LabelD" runat="server" Text="Attended Defenses"></asp:Label>
            <br />
            <asp:Button ID="listbutton" runat="server" OnClick="ViewList" Text="View Details" />
            <br />
            <br />
            
            <asp:Button ID="keySearch" runat="server" onClick="SearchByKey" Text="Search for Thesis by keyword" />
            <br />
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Add Comment or Grade"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Thesis Serial_no: "></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Defense Date: "></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Comments: "></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <asp:Button ID="commentbutton" runat="server" onClick="addComment" Text="Add Comment" />
            <asp:Label ID="important" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="Label5" runat="server" Text="grade: "></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            <asp:Button ID="gradebutton" runat="server" onClick="addGrade" Text="Add Grade" />
            <asp:Label ID="important2" runat="server" Text=""></asp:Label>
            <br />
            <br />
             <asp:Button ID="bButton1" runat="server" onClick="gobackk" Text="Back" />


        </div>
    </form>
</body>
</html>
