<%@ page language="VB" autoeventwireup="false" inherits="Inventory_CountStockAndRequestOrder, App_Web_countstockandrequestorder.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<html>
<head runat="server">
    <title>Count Stock And Request Order.</title>
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
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-reload'} });

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
            $('.txtMV1').click(function() {
                $(this).select();
            });
            $('.txtMV2').click(function() {
                $(this).select();
            });
            $(function() {
                $(".txtMV1").keypress(function(evt) {
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
            $(function() {
                $(".txtMV2").keypress(function(evt) {
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
            $('.txtMV1').keyup(function(e) {
                if (e.keyCode == 13) {
                    var nxtIdx = $('.txtMV1').index(this) + 1;
                    $(".txtMV1:eq(" + nxtIdx + ")").select();
                }
            });
            $('.txtMV2').keyup(function(e) {
                if (e.keyCode == 13) {
                    var nxtIdx = $('.txtMV2').index(this) + 1;
                    $(".txtMV2:eq(" + nxtIdx + ")").select();
                }
            });
            //            $('#menu').attr("disabled", true).addClass("ui-state-disabled");
            //            $('#home').attr("href", "#");
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
    <div id="xButton" runat="server">
        <div id="toolbar-button">
            <div class="icon-receipt-document" style="float: left; width: 32px; height: 32px;
                margin-right: 4px;">
            </div>
            <div class="toolbar-title">
                <asp:Label ID="lt" runat="server" CssClass="texttitle">Request Document</asp:Label></div>
            <button id="btnCreateDocument" type="button" runat="server">
                Create Document
            </button>
            <button id="btnCreateDocumentfromTemplate" type="button" runat="server" style="display: none;">
                Template
            </button>
            <button id="btnSeachDocument" type="button" runat="server">
                Search Document
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
            <button id="btnPreview" type="button" style="display: none;" runat="server">
                Preview
            </button>
            <button id="btnPrint" type="button" runat="server">
                Print Document
            </button>
            <button id="btnReload" type="button" runat="server" onclick="javascript:window.location.reload();"
                style="display: none;">
                click Reload
            </button>
            <asp:HiddenField ID="hdfDocumentID" runat="server" />
            <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
            <asp:HiddenField ID="hdfStockCountDocId" runat="server" />
            <asp:HiddenField ID="hdfStockCountShopId" runat="server" />
            <asp:HiddenField ID="hdfIndexList" runat="server" />
        </div>
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
                            <td>
                                <asp:DropDownList ID="ddlInv" runat="server" Width="220px" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlInv" Display="Dynamic" InitialValue="1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb6" runat="server">Invoice Ref.</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoice" runat="server" Width="220px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb4" runat="server" Text="To Inventory"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlToInv" runat="server" Width="220px">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlToInv" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb8" runat="server">Delivery Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDues_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlYear" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server" Height="23px">Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb7" runat="server">Note</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNote" runat="server" Rows="2" TextMode="MultiLine" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                Stock Count
                            </td>
                            <td>
                                <asp:FileUpload ID="flStockCount" runat="server" Height="22px" />
                                <button id="btnLoadStockCount" runat="server" type="button">
                                    Upload file
                                </button>
                                <a href="#notmaterials">
                                <asp:Label ID="msErrorStockCount" runat="server" Style="color: Red" Visible="false">The raw materials are not available in the system.</asp:Label>
                                </a>
                            </td>
                            <td class="paramlist_key">
                                Reqest Order
                            </td>
                            <td>
                                <asp:FileUpload ID="flRequestOrder" runat="server" />
                                &nbsp;
                                <button id="btnLoadRequestOrder" runat="server" type="button">
                                    Upload file
                                </button>
                                <a href="#notmaterials">
                                <asp:Label ID="msErrorRequestOrder" runat="server" Style="color: Red" Visible="false">The raw materials are not available in the system.</asp:Label>
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
            <table class="adminlist" cellspacing="1">
                <thead>
                    <tr>
                        <th nowrap="nowrap" style="width: 5%; height: 25px;">
                            #
                        </th>
                        <th nowrap="nowrap" style="width: 15%;">
                            <asp:Label ID="lh1" runat="server" Text="Code"></asp:Label>
                        </th>
                        <th nowrap="nowrap">
                            <asp:Label ID="lh2" runat="server" Text="Item"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh3" runat="server" Text="MinStock"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh4" runat="server" Text="MaxStock"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh5" runat="server" Text="Count"></asp:Label>
                            &nbsp;
                            <asp:ImageButton ID="btnSaveStockCount" runat="server" ImageUrl="~/images/icon/Save.png"
                                Width="16px" Height="16px" />
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh6" runat="server" Text="Request"></asp:Label>&nbsp;
                            <asp:ImageButton ID="btnSaveRequestOrder" runat="server" ImageUrl="~/images/icon/Save.png"
                                Width="16px" Height="16px" />
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh7" runat="server" Text="Unit"></asp:Label>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Label ID="tr1" runat="server"></asp:Label>
                    <asp:Label ID="tr2" runat="server"></asp:Label>
                </tbody>
                <asp:Label ID="ft" runat="server"></asp:Label>
            </table>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 14px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px; width: 550px;">
            <a id="notmaterials"></a>
            <div id="NotFoundMaterialList" runat="server">
            </div>
        </div>
    </div>
    <div id="footer-box">
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
