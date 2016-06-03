<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="Fitasia.AdminPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/resources/styles/tables.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <h2><asp:Label ID="LblAdminPage" runat="server"></asp:Label></h2>
        <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" StaticEnableDefaultPopOutImage="false" OnMenuItemClick="Menu1_MenuItemClick">
            <Items>
                <asp:MenuItem Text="Users" Value="0"></asp:MenuItem>
                <asp:MenuItem Text="Orders" Value="1"></asp:MenuItem>
                <asp:MenuItem Text="Income" Value="2"></asp:MenuItem>
            </Items>
        </asp:Menu>

        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="TabUsers" runat="server">
                <h3><asp:Label ID="LblUsers" runat="server"></asp:Label></h3>
                <asp:LinqDataSource ID="LinqData" runat="server" ContextTypeName="Fitasia.FitasiaDataDataContext" EntityTypeName="" TableName="Users"></asp:LinqDataSource>
                <asp:GridView ID="UserData" runat="server" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AutoGenerateColumns="False" DataKeyNames="Email" DataSourceID="LinqData">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" SortExpression="Id" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
                        <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                        <asp:BoundField DataField="Salt" HeaderText="Salt" SortExpression="Salt" />
                    </Columns>
                </asp:GridView>
            </asp:View>
            <asp:View ID="TabOrders" runat="server">
                <h3><asp:Label ID="LblOrders" runat="server" Text="Label"></asp:Label></h3>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="Fitasia.FitasiaDataDataContext" EntityTypeName="" TableName="Orders"></asp:LinqDataSource>
                <asp:GridView ID="OrderData" runat="server" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="LinqDataSource1">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="ProductId" HeaderText="ProductId" SortExpression="ProductId" />
                        <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="AddressId" HeaderText="AddressId" SortExpression="AddressId" />
                    </Columns>
                </asp:GridView>
            </asp:View>
            <asp:View ID="TabIncome" runat="server">
                <h4>Total income:
                    <asp:Label ID="LblTotalIncome" runat="server" Text="Label"></asp:Label></h4>
                <h4>Number of orders
                    <asp:Label ID="LblNumOfOrders" runat="server" Text="Label"></asp:Label></h4>
                
            </asp:View>
        </asp:MultiView>
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
