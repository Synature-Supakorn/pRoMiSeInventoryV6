<%@ page language="VB" autoeventwireup="false" inherits="Inventory_AddReduceMonthlyStockAndCost_New, App_Web_addreducemonthlystockandcost_new.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<html>
<head runat="server">
    <title>Adjust Ending Stock</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="../css/menu.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/modal.js" type="text/javascript"></script>

    <script src="../Scripts/menu.js" type="text/javascript"></script>

    <script src="../Scripts/index.js" type="text/javascript"></script>

    <script type="text/javascript">

        window.addEvent('domready', function() { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function($) {
        $("button, input:submit, a", "#toolbar-button").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print-preview'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });
            $(function() {
                $(".txt-numeric").keypress(function(evt) {
                    /*if ($(this).val() != "") {
                    this.value = this.value.replace(/[^0-9+,.]/g, "");
                    }*/
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    //alert(charCode);
                    if (charCode > 47 && charCode < 58 || charCode == 46)
                        return true;
                    else
                        return false;
                });
            });
            $('#txtAmount').click(function() {
                $(this).select();
            });
            $('#txtPricePerUnit').click(function () {
                $(this).select();
            });
            if ($("#txtAmount").val() > 0) { $("#btnSaveMaterial").attr("disabled", ""); } else { $("#btnSaveMaterial").attr("disabled", "disabled"); };
            $("#txtAmount").keyup(function (e) {

                if ($("#txtAmount").val() > 0) { $("#btnSaveMaterial").attr("disabled", ""); } else { $("#btnSaveMaterial").attr("disabled", "disabled"); };

            });
            $("#txtAmount").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#ddlUnit").focus();
                }
            });
            $("#ddlUnit").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#btnSaveMaterial").focus();
                }
            });


            $('.chks_11').live('change', function() {
                $('.chks_12').attr('checked', $(this).is(':checked') ? 'checked' : '');
            });
            $('.chks_12').live('change', function() {
                $('.chks_12').length == $('.chks_12:checked').length ? $('.chks_11').attr('checked', 'checked').next() : $('.chks_11').attr('checked', '').next();

            });

        });

       
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="xHeader" runat="server">
    <div id="header-box">
        <uc1:MenuBar ID="menu" runat="server" />
    </div>
    </div>
    <div id="toolbar-button">
        <div class="icon-transfer-document" style="float: left; width: 32px; height: 32px;
            margin-right: 4px;">
        </div>
        <div class="toolbar-title">
            <asp:Label ID="lt" runat="server" CssClass="texttitle">AddReduceStockAndCost</asp:Label></div>
        <button id="btnCreateDocument" type="button" runat="server">
            Create Document
        </button>
        <button id="btnCreateDocumentfromTemplate" type="button" runat="server" style="display: none;">
            Template
        </button>
        <button id="btnSearchRequestDocument" type="button" runat="server" style="display: none;">
            Search Request Document
        </button>
        <button id="btnSeachDocument" type="button" runat="server">
            Search Tranfer Document
        </button>
        <button id="btnSave" type="button" runat="server" validationgroup="v">
            Save Document
        </button>
        <button id="btnTemplate" type="button" style="display: none;" runat="server">
            Template
        </button>
        <button id="btnAppove" type="button" runat="server">
            Approve Document
        </button>
        <button id="btnCancelDocment" type="button" runat="server">
            Cancel Document
        </button>
        <button id="btnResetStockInDocument" type="button" runat="server">
            Recalculate Cost
        </button>
        <button id="btnPreview" type="button" style="display: none;" runat="server">
            Preview
        </button>
        <button id="btnPrint" type="button" runat="server" style="display: none;" >
            Print Document
        </button>
        <asp:HiddenField ID="hdfDocumentID" runat="server" />
        <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
        <asp:HiddenField ID="hdfIndexList" runat="server" />
    </div>
    <div id="content">
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lbDocumentName" runat="server"></asp:Label>
                    <asp:Label ID="lb1" runat="server"></asp:Label>
                    <asp:Label ID="lbDocumentStatus" runat="server"></asp:Label>
                    <asp:Label ID="lb2" runat="server"></asp:Label>
                    <asp:Label ID="lbDocumentNumber" runat="server"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key" width="40%">
                                <asp:Label ID="lb3" runat="server">Inventory</asp:Label>
                            </td>
                            <td Width="230px">
                                <asp:DropDownList ID="ddlInv" runat="server" Width="220px" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlInv" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb7" runat="server">Note</asp:Label>
                            </td>
                            <td rowspan="2">
                                <asp:TextBox ID="txtNote" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="txtNote" InitialValue="" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:DropDownList ID="RdoDues_DdlDay" runat="server" Style="display: none;">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlMonth" runat="server" Style="display: none;">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlYear" runat="server" Style="display: none;">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server" Height="23px">Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlToInv" runat="server" Width="220px" Style="display: none;">
                                </asp:DropDownList>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlToInv" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>--%>
                                <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                                </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb8" runat="server" Style="display: none;">Delivery Date</asp:Label>
                            </td>
                        </tr>
                        </table>
                </div>
            </div>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 0px;">
            <div style="width:100%; text-align:center;color:red; background-color:#f0f0f0; height:25px;">
                <asp:Label ID="lbCheckCountingStock" runat="server" Font-Size="Medium"></asp:Label></div>
            <table class="adminlist" cellspacing="1">
                <thead>
                    <tr>
                        <th nowrap="nowrap" style="width: 2%; height: 25px;">
                            #
                        </th>
                        <th style="width: 2%;">
                            <div id="chk" runat="server">
                            </div>
                        </th>
                        <th nowrap="nowrap" style="width: 15%;">
                            <asp:Label ID="lh1" runat="server" Text="Code"></asp:Label>
                        </th>
                        <th nowrap="nowrap">
                            <asp:Label ID="lh2" runat="server" Text="Item"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh99" runat="server" Text="Stock"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh100" runat="server" Text="Cost"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh3" runat="server" Text="Amount"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh101" runat="server" Text="Price/Unit"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh4" runat="server" Text="Unit"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            x
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Label ID="tr1" runat="server"></asp:Label>
                    <tr class="row0" id="trEdit" runat="server">
                        <td colspan="2">
                            <button id="btnDelete" type="button" runat="server" style="width: 100%;">
                                Delete
                            </button>
                            <button id="btnCancelMaterial" type="button" runat="server" style="width: 100%;">
                                cancel</button>
                        </td>
                        <td>
                            <div style="float: left; width: 75%;">
                                <asp:TextBox ID="txtCode" runat="server" Style="width: 100%;" AutoPostBack="True"
                                    OnTextChanged="txtCode_TextChanged"></asp:TextBox>
                            </div>
                            <div style="float: left; width: 20%;">
                                <button id="btnSearchMaterial" type="button" runat="server" style="width: 100%;">
                                    ...</button>
                            </div>
                        </td>
                        <td>
                            <asp:Label ID="lbMaterialName" runat="server"></asp:Label>
                        </td>
                         <td style="text-align:right;">
                            <asp:Label ID="lbMaterialStock" runat="server"></asp:Label>
                        </td>
                         <td style="text-align:right;">
                            <asp:Label ID="lbMaterialCost" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmount" runat="server" Style="width: 50px;" class="txt-numeric">0</asp:TextBox>
                        </td>
                         <td>
                            <asp:TextBox ID="txtPricePerUnit" runat="server" Style="width: 70px;" class="txt-numeric">0.00</asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlUnit" runat="server" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <div style="float: left; width: 100%;">
                                <button id="btnSaveMaterial" type="button" runat="server" style="width: 100%;" disabled="disabled">
                                    Save</button>
                            </div>
                            <asp:HiddenField ID="hdfMaterialID" runat="server" />
                            <asp:HiddenField ID="hdfMaterialUnitID" runat="server" />
                            <asp:HiddenField ID="hdfDocDetailID" runat="server" />                           
                            <asp:HiddenField ID="hdfStockOnHand" runat="server" />
                            <asp:HiddenField ID="hdfCurrentCost" runat="server" />
                        </td>
                    </tr>
                    <asp:Label ID="tr2" runat="server"></asp:Label>
                </tbody>
                <asp:Label ID="ft" runat="server"></asp:Label>
            </table>
        </div>
        <div style="text-align: center;">
            <h1>
                <asp:Label ID="msgResponse" runat="server"></asp:Label></h1>
        </div>
    </div>
    <div id="footer-box">
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
