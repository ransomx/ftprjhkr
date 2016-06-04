<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CheckoutError.aspx.cs" Inherits="Fitasia.CheckoutError" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <h1>Checkout Error</h1>
        <p></p>
        <table id="ErrorTable">
            <tr>
                <td class="field"></td>
                <td><%=Request.QueryString.Get("ErrorCode")%></td>
            </tr>
            <tr>
                <td class="field"></td>
                <td><%=Request.QueryString.Get("Desc")%></td>
            </tr>
            <tr>
                <td class="field"></td>
                <td><%=Request.QueryString.Get("Desc2")%></td>
            </tr>
        </table>
        <p></p>
        <a href="Home.aspx">Return to home page</a>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder5" runat="server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder6" runat="server">
</asp:Content>
