<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CheckoutComplete.aspx.cs" Inherits="Fitasia.CheckoutComplete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Checkout Complete</h1>
    <p></p>
    <h3>Payment Transaction ID:</h3>
    <asp:Label ID="TransactionId" runat="server"></asp:Label>
    <p></p>
    <h3>Thank You!</h3>
    <p></p>
    <hr />
    <asp:Button ID="Continue" runat="server" Text="Continue Shopping" OnClick="Continue_Click" />
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
