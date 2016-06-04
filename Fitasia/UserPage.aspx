<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserPage.aspx.cs" Inherits="Fitasia.UserPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="resources/styles/userpage.css" type="text/css" />
    <link href="/resources/styles/tables.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            var visible = false;
            $("#<%=BtnAddAddress.ClientID %>").click(function () {
                if (!visible) {
                    $("#insertSection").show(200);
                    visible = true;
                }
                else {
                    $("#insertSection").hide(200);
                    visible = false;
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content bottom">
        <h2>
            <asp:Label ID="LblWelcome" meta:resourceKey="LblWelcome" runat="server" />
        </h2>
        <p>
            This is the user page, here you can add addresses and view your purchase history.
        </p>
        <section class="data">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" EnablePartialRendering="true">
                <ContentTemplate>
                    <h3>


                        <asp:Label ID="LblAddresses" meta:resourceKey="LblAddresses" runat="server"></asp:Label></h3>
                    <asp:LinqDataSource ID="AddressData"
                        EnableDelete="True"
                        EnableUpdate="True"
                        runat="server"
                        ContextTypeName="Fitasia.FitasiaDataDataContext"
                        EntityTypeName=""
                        TableName="Addresses"
                        Where="UserId == @UserId">
                        <WhereParameters>
                            <asp:SessionParameter Name="UserId" SessionField="LoggedId" Type="Int32" />
                        </WhereParameters>

                    </asp:LinqDataSource>
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="AddressData"
                        AutoGenerateColumns="False" CssClass="datagridSelectable" DataKeyNames="Id"
                        PagerStyle-CssClass="pager" PagerSettings-Mode="Numeric" HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                        AllowPaging="True">
                        <Columns>
                            <asp:BoundField DataField="Street" meta:resourceKey="Street" SortExpression="Street" />
                            <asp:BoundField DataField="City" meta:resourceKey="City" SortExpression="City" />
                            <asp:BoundField DataField="PostalCode" meta:resourceKey="PostalCode" SortExpression="PostalCode" />
                            <asp:CommandField InsertText="" meta:resourceKey="Action" NewText="" SelectText="" ShowDeleteButton="True" ShowEditButton="True" />
                        </Columns>
                    </asp:GridView>
                    <asp:Button ID="BtnAddAddress" runat="server" meta:resourceKey="BtnAddAddress" CssClass="button horizontal" OnClientClick="return false;" />
                    <div id="insertSection" class="inputPopup horizontal">
                        <asp:Label ID="LblNewAddress" meta:resourceKey="LblNewAddress" runat="server"></asp:Label>
                        <asp:TextBox ID="TxtStreet" meta:resourceKey="TxtStreet" runat="server"></asp:TextBox>
                        <asp:TextBox ID="TxtCity" meta:resourceKey="TxtCity" runat="server"></asp:TextBox>
                        <asp:TextBox ID="TxtZip" meta:resourceKey="TxtZip" runat="server"></asp:TextBox>
                        <asp:Button ID="BtnSaveAddress" meta:resourceKey="BtnSaveAddress" runat="server" CssClass="button" OnClick="BtnSaveAddress_Click" />
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="GridView1" />
                </Triggers>
            </asp:UpdatePanel>
        </section>

        <section class="data">
            <h3>
                <asp:Label ID="LblPayhistory" meta:resourceKey="LblPayhistory" runat="server"></asp:Label></h3>
            <asp:LinqDataSource ID="OrderData" runat="server" ContextTypeName="Fitasia.FitasiaDataDataContext" EntityTypeName="" OrderBy="Date" TableName="Orders" Where="UserId == @UserId">
                <WhereParameters>
                    <asp:SessionParameter Name="UserId" SessionField="LoggedId" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:GridView ID="GridView2" CssClass="datagrid" runat="server"
                AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="OrderData"
                PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                AllowPaging="True">
                <Columns>
                    <asp:TemplateField meta:resourceKey="Title">
                        <ItemTemplate>
                            <%# Eval("Product.Title") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourceKey="Address">
                        <ItemTemplate>
                            <%# Eval("Address.Street")+", "+Eval("Address.City")+" "+Eval("Address.PostalCode") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourceKey="Date">
                        <ItemTemplate>
                            <%# Eval("Date", "{0:dd/MM/yyyy HH:mm}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourceKey="Status">
                        <ItemTemplate>
                            <%#CalculateDate(Eval("Date", "{0:dd/MM/yyyy HH:mm}")) %>
                        </ItemTemplate>

                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </section>
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
