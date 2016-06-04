<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Fitasia.Home" %>

<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var searchOpen = false;
        function hideSearch() {
            $("#searchContent").toggle(300);
            if (searchOpen) {
                searchOpen = false;
                $("#toggleButton").text("OFFERS");
            } else {
                searchOpen = true;
                $("#toggleButton").text("HIDE");
            }
        }

        function updateSearchView() {
            if (searchOpen) {
                hideSearch();
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main video, Registration  -->
    <div class="contentVideo" id="cont">
        <div class="fullscreen-bg">
        </div>
        <div class="overlay">
            <div class="info">
                <h2>
                    <asp:Label ID="LblHeaderBig" meta:resourceKey="LblHeaderBig" runat="server"></asp:Label>
                </h2>
                <h3>
                    <asp:Label ID="LblHeaderMedium" meta:resourceKey="LblHeaderMedium" runat="server"></asp:Label></h3>
                <i>
                    <asp:Label ID="LblHeaderSmall" meta:resourceKey="LblHeaderSmall" runat="server"></asp:Label></i>
                <p>
                    <a href="#" id="gotoOffer" onclick="scrollDown()" class="buttonLink">
                        <asp:Label ID="LblGoToOffer" meta:resourceKey="LblGoToOffer" runat="server"></asp:Label>
                    </a>
                </p>
            </div>
            <div class="info">
                <asp:UpdatePanel ID="updatePanelReg" runat="server">
                    <ContentTemplate>
                        <div class="register" runat="server" id="reg">
                            <span>
                                <asp:Label ID="LblHeader" runat="server" meta:resourceKey="LblHeader" />
                            </span>
                            <p></p>
                            <asp:Table ID="TableReg" runat="server">
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:TextBox ID="TxtName" CssClass="input" ValidationGroup="reg" runat="server" meta:resourceKey="TxtName" />
                                        <asp:RequiredFieldValidator ID="ReqValName" meta:resourceKey="ReqValName" runat="server" ValidationGroup="reg" ControlToValidate="TxtName" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegExpName" meta:resourceKey="RegExpName" runat="server" ValidationGroup="reg" ValidationExpression="\D+" Display="None" ControlToValidate="TxtName"></asp:RegularExpressionValidator>
                                    </asp:TableCell><asp:TableCell>
                                        <asp:TextBox ID="TxtSurname" CssClass="input" placeholder="SURNAME" meta:resourceKey="TxtSurname" runat="server" />
                                        <asp:RequiredFieldValidator ID="ReqValSur" meta:resourceKey="ReqValSur" runat="server" ValidationGroup="reg" ControlToValidate="TxtSurname" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegExpSur" meta:resourceKey="RegExpSur" runat="server" ValidationGroup="reg" ValidationExpression="\D+" Display="None" ControlToValidate="TxtSurname"></asp:RegularExpressionValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell ColumnSpan="5" CssClass="inputStretch">
                                        <asp:TextBox ID="TxtEmail" CssClass="inputStretch" meta:resourceKey="TxtEmail" ValidationGroup="reg" runat="server" />
                                        <asp:RequiredFieldValidator ID="RegValEmail" meta:resourceKey="RegValEmail" runat="server" ValidationGroup="reg" ControlToValidate="TxtEmail" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegExpEmail" meta:resourceKey="RegExpEmail" runat="server" ValidationGroup="reg" Display="None" ValidationExpression="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$" ControlToValidate="TxtEmail"></asp:RegularExpressionValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:TextBox ID="TxtPwd" CssClass="input" TextMode="Password" meta:resourceKey="TxtPwd" ValidationGroup="reg" runat="server" />
                                        <asp:RequiredFieldValidator ID="ReqValPass" meta:resourceKey="ReqValPass" ValidationGroup="reg" runat="server" ControlToValidate="TxtPwd" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegExpPass" meta:resourceKey="RegExpPass" ValidationGroup="reg" runat="server" Display="None" ValidationExpression="^(?=.*\d).{4,8}$" ControlToValidate="TxtPwd"></asp:RegularExpressionValidator>
                                    </asp:TableCell><asp:TableCell>
                                        <asp:TextBox ID="TxtPwda" CssClass="input" TextMode="Password" meta:resourceKey="TxtPwda" runat="server" />
                                        <asp:CompareValidator ID="ComparePassword" meta:resourceKey="ComparePassword" ValidationGroup="reg" runat="server" ControlToCompare="TxtPwd" Display="None" ControlToValidate="TxtPwda"></asp:CompareValidator>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <asp:Button ID="BtnSignUp" CssClass="button" meta:resourceKey="BtnSignUp" CausesValidation="true" runat="server" ValidationGroup="reg" ValidateRequestMode="Enabled" OnClick="BtnSignUp_Click" />
                            <asp:Button ID="BtnLoginFb" CssClass="buttonFb" meta:resourceKey="BtnLoginFb" CausesValidation="false" runat="server" />
                            <asp:Button ID="BtnLoginGoogle" CssClass="buttonG" meta:resourceKey="BtnLoginGoogle" runat="server" CausesValidation="false" />
                            <asp:ValidationSummary ID="ValSumReg" CssClass="validator" ValidationGroup="reg" runat="server" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <video muted autoplay loop id="myvideo" class="fullscreen-bg__video">
            <source src="resources/video/gym.mp4" type="audio/mp4" />
        </video>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

    <!-- GYM LOCATOR AND SEARCH ENGINE  -->
    <div class="content">

        <h1>
            <asp:Label ID="LblLocator" meta:resourceKey="LblLocator" runat="server"></asp:Label></h1>
        <p>
            <asp:Label ID="LblLocatorContent" runat="server" meta:resourceKey="LblLocatorContent">
            </asp:Label>
        </p>
    </div>
    <asp:UpdatePanel ID="UpdateMapRegion" runat="server">
        <ContentTemplate>
            <div class="mapcontrols center">
                <asp:TextBox ID="TxtArea" meta:resourceKey="TxtArea" placeholder="Area" runat="server" CssClass="mapcontrol" OnTextChanged="TxtSearch_TextChanged" AutoPostBack="true" />
                <asp:TextBox ID="TxtSearch" meta:resourceKey="TxtSearch" runat="server" CssClass="mapcontrol" OnTextChanged="TxtSearch_TextChanged" AutoPostBack="true" />
                
                <!-- WIP -->
                <asp:TextBox ID="TxtActivity" meta:resourceKey="TxtActivity" runat="server" ValidationGroup="mapcontrol" CssClass="mapcontrol" AutoPostBack="true" /> 
                <asp:RequiredFieldValidator ID="ReqValActivity" runat="server" ControlToValidate="TxtActivity" ValidationGroup="mapcontrol" Display="None" ErrorMessage="You need to choose activity."></asp:RequiredFieldValidator>
                <asp:ImageButton ID="BtnAdd" runat="server" CssClass="addIcon smooth-transform" ValidationGroup="mapcontrol" OnClick="BtnAdd_Click" ImageUrl="http://www.free-icons-download.net/images/plus-sign-icon-1945.png" />
                <asp:ValidationSummary ID="MapControlValidationSummary" CssClass="validator" ValidationGroup="mapcontrol" runat="server" />
            </div>

            <div id="activities">
                <asp:ListView ID="ActivityList" runat="server">
                    <ItemTemplate>
                        <ul class="activityList horizontal">
                            <li>
                                <asp:ImageButton ID="BtnRemove" OnClick="BtnRemove_Click" CommandArgument='<%# Container.DataItem %>' ImageUrl="https://cdn2.iconfinder.com/data/icons/splashyIcons/remove_minus_sign_small.png" runat="server" />
                                <%# Container.DataItem %>
                            </li>
                        </ul>
                    </ItemTemplate>
                </asp:ListView>
            </div>

            <div id="slidecontent">
                <div id="searchContent">
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <h3>Searching...</h3>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <h2>Offers</h2>
                    <asp:Repeater ID="GymRepeater" runat="server">
                        <ItemTemplate>
                            <div class="item smooth-transform">
                                <h3><%# Eval("Name") %></h3>
                                <div class="inside fast-transform">
                                    <img src="resources/images/gym.jpg" id="itemImg" class="itemImage" />
                                    <h4><%#Eval("Address.City") %> </h4>
                                    <h4>300 SEK </h4>
                                    <h4>Save 50% </h4>
                                </div>
                                <ul>
                                    <asp:Repeater ID="BenefitRepeater" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <img src="<%# Eval("Image") %>" alt="<%# Eval("Name") %>" />
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <aside class="hideButton inline" onclick="hideSearch()">
                    <div id="toggleButton" class="smooth-transform">OFFERS</div>
                    <hr />
                </aside>
            </div>
            <cc1:GMap ID="GMap1" CssClass="map" Width="100%" Height="300px" runat="server" />

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TxtSearch" EventName="TextChanged" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <!-- VIDEO  -->
    <div class="content">
        <h1>
            <asp:Label ID="LblVideo" meta:resourceKey="LblVideo" runat="server"></asp:Label></h1>
        <div class="video">
            <iframe width="560" height="315" src="https://www.youtube.com/embed/sZ4NH5phUZs" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
</asp:Content>


<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder5" runat="server">
    <!-- BEST OFFERS  -->
    <div id="offers" class="content">
        <h1>
            <asp:Label ID="LblOffers" meta:resourceKey="LblOffers" runat="server"></asp:Label></h1>
        <div class="offer">
            <asp:ListView ID="OfferView" runat="server">
                <ItemTemplate>
                    <div class="column">
                        <h2><%# Eval("Title") %></h2>
                        <h3><%# Eval("Duration") %></h3>
                        <div>
                            <span><%# Eval("Price") %>
                                <asp:Label ID="LblCurrency" runat="server" Text="SEK"></asp:Label></span>
                        </div>
                        <h3><%# Eval("Description") %></h3>
                        <asp:Button ID="BtnPurchase" meta:resourceKey="BtnPurchase" OnCommand="BtnPurchase_Click" CommandArgument='<%# Eval("Id") %>' CssClass="button" runat="server" />
                    </div>
                    <asp:DataPager ID="DataPager1" runat="server" PageSize="3">
                    </asp:DataPager>
                </ItemTemplate>
            </asp:ListView>
            <p>
                <asp:Label ID="LblOffersFoot" meta:resourceKey="LblOffersFoot" runat="server"></asp:Label>
            </p>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder6" runat="server">
    <!-- ABOUT US CONTENT  -->
    <div class="content bottom">
        <h1>
            <asp:Label ID="LblAbout" meta:resourceKey="LblAbout" runat="server"></asp:Label></h1>
        <p>
            <asp:Label ID="LblAboutContent" meta:resourceKey="LblAboutContent" runat="server"></asp:Label>
        </p>
        <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="Fitasia.FitasiaDataDataContext" EntityTypeName="" Select="new (Name, Profession, Text, Image)" TableName="Persons"></asp:LinqDataSource>
        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="LinqDataSource2">
            <ItemTemplate>
                <div class="column">
                    <asp:Image ID="ImgPerson" runat="server" ImageUrl='<%#Eval("Image", "~/resources/images/profiles/{0}") %>' />
                    <h2><%# Eval("Name") %></h2>
                    <h3><%# Eval("Profession") %></h3>
                    <div><%# Eval("Text") %></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
