<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Fitasia.Contacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="resources/styles/tables.css" type="text/css" />
    <link rel="stylesheet" href="resources/styles/contact.css" type="text/css" />
    <script type="text/javascript">
        function HideLabel() {
            var seconds = 5;
            setTimeout(function () {
                $("#<%=LblMessage.ClientID%>").fadeOut(500);
            }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <h2>
            <asp:Label ID="LblConnect" meta:resourceKey="LblConnect" runat="server" Text="Label"></asp:Label></h2>
        <p>
            <asp:Label ID="LblHeaderContent" meta:resourceKey="LblHeaderContent" runat="server" Text="Label"></asp:Label>
        </p>

        <section class="contact">
            <h4>
                <asp:Label ID="LblSendMessage" meta:resourceKey="LblSendMessage" runat="server" Text="Label"></asp:Label></h4>
            <asp:Table ID="Table1" runat="server" Width="400">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="1">
                        <asp:TextBox ID="TxtName" CssClass="input" meta:resourceKey="TxtName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator meta:resourceKey="ReqValName" ID="ReqValName" ValidationGroup="contact" ControlToValidate="TxtName" Display="None" runat="server"></asp:RequiredFieldValidator>
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="1">
                        <asp:TextBox ID="TxtEmail" meta:resourceKey="TxtEmail" CssClass="input" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator meta:resourceKey="ReqValEmail" ID="ReqValEmail" ValidationGroup="contact" ControlToValidate="TxtEmail" Display="None" runat="server"></asp:RequiredFieldValidator>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <asp:TextBox ID="TxtTopic" meta:resourceKey="TxtTopic" CssClass="inputStretch" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <asp:TextBox ID="TxtInput" meta:resourceKey="TxtInput" Rows="8" TextMode="MultiLine" Wrap="true" CssClass="inputField" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator meta:resourceKey="ReqValText" ID="ReqValText" runat="server" ValidationGroup="contact" Display="None" ControlToValidate="TxtInput"></asp:RequiredFieldValidator>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="BtnSend" meta:resourceKey="BtnSend" runat="server" ValidationGroup="contact" CssClass="button" Text="" OnClick="BtnSend_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:ValidationSummary ID="ValidationSummary1" CssClass="validator" ValidationGroup="contact" runat="server" />
        </section>
        <section class="sideSocials">
            <h4><asp:Label ID="LblSoc1" meta:resourceKey="LblSoc1" runat="server"></asp:Label></h4>
            <p><asp:Label ID="LblFb" meta:resourceKey="LblFb" runat="server"></asp:Label> </p>
            <p><asp:Label ID="LblTwitter" meta:resourceKey="LblTwitter" runat="server"></asp:Label></p>
            <p><asp:Label ID="LblGoogle" meta:resourceKey="LblGoogle" runat="server"></asp:Label></p>
        </section>
        <asp:Label ID="LblMessage" meta:resourceKey="LblMessage" CssClass="timeoutMessage" runat="server" Visible="false"></asp:Label>

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
