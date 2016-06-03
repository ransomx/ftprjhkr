<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Fitasia.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/resources/styles/payment.css" type="text/css" />
    <script type="text/javascript" src="/resources/scripts/checkout.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=RadioBListPayment.ClientID%>").change(function () {
                if ($('#<%=RadioBListPayment.ClientID %> input:checked').val() == 'paypal') {
                    $("#paycard").hide(100);
                    $("#paypal").show(100);
                    ValidatorEnable(<%=ReqValPaypalUN.ClientID%>, true);
                    ValidatorEnable(<%=ReqValCardName.ClientID%>, false);
                    ValidatorEnable(<%=ReqValCardNum.ClientID%>, false);
                    ValidatorEnable(<%=ReqValCVC.ClientID%>, false);
                }
                else {
                    $("#paycard").show(100)
                    $("#paypal").hide(100);
                    ValidatorEnable(<%=ReqValPaypalUN.ClientID%>, false);
                    ValidatorEnable(<%=ReqValCardName.ClientID%>, true);
                    ValidatorEnable(<%=ReqValCardNum.ClientID%>, true);
                    ValidatorEnable(<%=ReqValCVC.ClientID%>, true);
                }
            });
        });
        function CheckBoxRequired_ClientValidate(sender, e) {
            e.IsValid = jQuery(".AcceptedAgreement input:checkbox").is(':checked');
        }
        window.scrollTo = function() { }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <h2>
            <asp:Label ID="LblSelected" meta:resourceKey="LblSelected" runat="server"></asp:Label></h2>
        <hr />
        <div class="productInfo">
            <asp:Image ID="ImgPackage" ImageUrl="https://s-media-cache-ak0.pinimg.com/236x/b9/94/e4/b994e4378507f5624aa90ae7778ded86.jpg" runat="server" />
            <asp:Table ID="TableProdInfo" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="LblTitleH" meta:resourceKey="LblTitleH" runat="server" Text="Label"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="LblTitle" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="LblDetailsH" meta:resourceKey="LblDetailsH" runat="server"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="LblDetails" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="LblDurationH" meta:resourceKey="LblDurationH" runat="server"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="LblDuration" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="LblPriceH" meta:resourceKey="LblPriceH" runat="server"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="LblPrice" runat="server"></asp:Label> SEK
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <h3>
            <asp:Label ID="LblShipmentHeader" meta:resourceKey="LblShipmentHeader" runat="server"></asp:Label></h3>
        <hr />
        <div class="payment">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:LinqDataSource ID="AddressData" runat="server" ContextTypeName="Fitasia.FitasiaDataDataContext" EntityTypeName="" TableName="Addresses" Where="UserId == @UserId">
                        <WhereParameters>
                            <asp:SessionParameter Name="UserId" SessionField="LoggedId" Type="Int32" />
                        </WhereParameters>
                    </asp:LinqDataSource>
                    <asp:Table ID="Table1" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label ID="LblSavedAddress" meta:resourceKey="LblSavedAddress" runat="server"></asp:Label></asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="AddressList" AutoPostBack="true" AppendDataBoundItems="true" runat="server" DataSourceID="AddressData" DataValueField="Id" OnSelectedIndexChanged="AddressList_SelectedIndexChanged" DataTextField="Street">
                                    <asp:ListItem Selected="True" meta:resourceKey="ListItemSelect" Value="none"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell> <asp:Label ID="LblName" meta:resourceKey="LblName" runat="server" Text="Label"></asp:Label> </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="TxtName" meta:resourceKey="TxtName" runat="server" CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValName" meta:resourceKey="ReqValName" ValidationGroup="formCheck" Display="None" ControlToValidate="TxtName" runat="server"></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell> <asp:Label ID="LblSurname" meta:resourceKey="LblSurname" runat="server" Text="Label"></asp:Label> </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="TxtSurname" meta:resourceKey="TxtSurname" runat="server" CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValSurname" meta:resourceKey="ReqValSurname" ValidationGroup="formCheck" Display="None" ControlToValidate="TxtSurname" runat="server"></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell> <asp:Label ID="LblStreet" meta:resourceKey="LblStreet" runat="server" Text="Label"></asp:Label> </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="TxtStreet" meta:resourceKey="TxtStreet" runat="server" CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValStreet" meta:resourceKey="ReqValStreet" CssClass="cardForm" ValidationGroup="formCheck" Display="None" ControlToValidate="TxtStreet" runat="server"></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell> <asp:Label ID="LblCity" meta:resourceKey="LblCity" runat="server" Text="Label"></asp:Label> </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="TxtCity" meta:resourceKey="TxtCity" runat="server" CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValCity" meta:resourceKey="ReqValCity" ValidationGroup="formCheck" Display="None" ControlToValidate="TxtCity" runat="server" ErrorMessage=""></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell> <asp:Label ID="LblPostCode" meta:resourceKey="LblPostCode" runat="server" Text="Label"></asp:Label> </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="TxtPostal" meta:resourceKey="TxtPostal" runat="server" CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValZip" meta:resourceKey="ReqValZip" ValidationGroup="formCheck" Display="None" runat="server" ControlToValidate="TxtPostal"></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:CheckBox ID="SaveAddressCheckBox" meta:resourceKey="CheckBoxStore" CssClass="checkbox" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <h3>
            <asp:Label ID="LblPayment" meta:resourceKey="LblPayment" runat="server"></asp:Label></h3>
        <hr />
        <div class="payment">
            <img src="/resources/images/paymentIcons.jpg" />
            <h4>
                <asp:Label ID="LblTypeOfPayment" meta:resourceKey="LblTypeOfPayment" runat="server"></asp:Label></h4>
            <asp:RadioButtonList ID="RadioBListPayment" CssClass="paytype" runat="server" OnSelectedIndexChanged="RadioBListPayment_SelectedIndexChanged">
                <asp:ListItem Text="CARD" meta:resourceKey="CARD" Value="card" Selected="True"></asp:ListItem>
                <asp:ListItem Text="PAYPAL" meta:resourceKey="PAYPAL" Value="paypal"></asp:ListItem>
            </asp:RadioButtonList>

            <div class="payCard" id="paycard">
                <asp:Table ID="Table2" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblToChargeH" meta:resourceKey="LblToChargeH" runat="server"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="LblToCharge" meta:resourceKey="LblToCharge" runat="server"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblCardType" meta:resourceKey="LblCardType" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="CardTypeList" runat="server">
                                <asp:ListItem Text="Visa" meta:resourceKey="Visa"></asp:ListItem>
                                <asp:ListItem Text="MasterCard" meta:resourceKey="MasterCard"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblCardNumber" meta:resourceKey="LblCardNumber" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TxtCardNum" meta:resourceKey="TxtCardNum" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqValCardNum" meta:resourceKey="ReqValCardNum" Display="None" ValidationGroup="formCheck" runat="server" ControlToValidate="TxtCardNum" ErrorMessage="Specify card number"></asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblCardHolderName" meta:resourceKey="LblCardHolderName" runat="server"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TxtCardHolder" meta:resourceKey="TxtCardHolder" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqValCardName" meta:resourceKey="ReqValCardName" Display="None" ValidationGroup="formCheck" runat="server" ControlToValidate="TxtCardHolder"></asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblExpiration" meta:resourceKey="LblExpiration" runat="server"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="ddlMonth" runat="server" onchange="PopulateDays()" />
                            <asp:DropDownList ID="ddlYear" runat="server" onchange="PopulateDays()" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblSecurityCode" meta:resourceKey="LblSecurityCode" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TxtCVC" meta:resourceKey="TxtCVC" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqValCVC" meta:resourceKey="ReqValCVC" runat="server" Display="None" ValidationGroup="formCheck" ControlToValidate="TxtCVC"></asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:RequiredFieldValidator ID="ReqValRB" meta:resourceKey="ReqValRB" ValidationGroup="formCheck" ControlToValidate="RadioBListPayment" runat="server" Display="None"></asp:RequiredFieldValidator>
            </div>
            <div class="payPal" id="paypal">
                <asp:Table ID="Table3" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="LblPaypalHeader" meta:resourceKey="LblPaypalHeader" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TxtPayPalUN" meta:resourceKey="TxtPayPalUN" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqValPaypalUN" meta:resourceKey="ReqValPaypalUN" Display="None" Enabled="false" ValidationGroup="formCheck" runat="server" ControlToValidate="TxtPayPalUN"></asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
        </div>
        <hr />
        <div class="checkBoxes">
            <asp:CheckBox ID="CheckBoxAgree" meta:resourceKey="CheckBoxAgree" CssClass="AcceptedAgreement" runat="server" />
            <asp:CustomValidator runat="server" ID="CheckBoxRequired" meta:resourceKey="CheckBoxRequired"
                EnableClientScript="true"
                ClientValidationFunction="CheckBoxRequired_ClientValidate"
                ValidationGroup="formCheck" Display="None"></asp:CustomValidator>
        </div>
        <!--<asp:Button ID="BtnProceed" meta:resourceKey="BtnProceed" runat="server" CausesValidation="true"
            ValidationGroup="formCheck" CssClass="button"
            ValidateRequestMode="Enabled" OnClick="BtnProceed_Click" />-->
        <div class="validatorComponent">
            <asp:ImageButton ID="Button1" runat="server" ValidationGroup="formCheck"
                ImageUrl="https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif" 
                OnClick="Button1_Click" AlternateText="Checkout with PayPal" ValidateRequestMode="Enabled" CausesValidation="true"/>
            <asp:ValidationSummary ID="ValidationSummary1"  CssClass="validator" ValidationGroup="formCheck" runat="server" />
        </div>
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
