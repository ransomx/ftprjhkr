<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CheckoutReview.aspx.cs" Inherits="Fitasia.PaymentConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <h1>Order Review</h1>
        <p></p>
        <h3 style="padding-left: 33px">Products:</h3>
        <asp:GridView ID="OrderItemList" runat="server" AutoGenerateColumns="False" GridLines="Both" CellPadding="10" Width="500" BorderColor="#efeeef" BorderWidth="33">
            <Columns>
                <asp:BoundField DataField="Order.ProductName" HeaderText=" Product Name" />
                <asp:BoundField DataField="Order.UnitPrice" HeaderText=" Price" DataFormatString="{0:c}" />
                <asp:BoundField DataField="Order.Description" HeaderText=" Description" DataFormatString="{0:c}" />
            </Columns>
        </asp:GridView>
        <h3>Shipping Address:</h3>
        <br />
        <asp:Label ID="Address" runat="server"></asp:Label>
        <br />
        <asp:Label ID="City" runat="server"></asp:Label>
        <asp:Label ID="PostalCode" runat="server"></asp:Label>
        <p></p>
        <h3>Order Total:</h3>
        <br />
        <asp:Label ID="Total" runat="server"></asp:Label>
        <p></p>
        <hr />
        <asp:Button ID="CheckoutConfirm" runat="server" Text="Complete Order" OnClick="CheckoutConfirm_Click" />
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
