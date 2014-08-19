<%@ page language="VB" autoeventwireup="false" inherits="Inventory_DocumentTemplate, App_Web_documenttemplate.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<html>
<head runat="server">
    <title>Template Document.</title>
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
                  .next().button({ icons: { primary: 'icon-action-new'} })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
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
            $.extend({
                getUrlVars: function() {
                    var vars = [], hash;
                    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    for (var i = 0; i < hashes.length; i++) {
                        hash = hashes[i].split('=');
                        vars.push(hash[0]);
                        vars[hash[0]] = hash[1];
                    }
                    return vars;
                },
                getUrlVar: function(name) {
                    return $.getUrlVars()[name];
                }
            });
            if ($('#UsePriceSetting').val() != undefined) {
                var usePriceVal = $('#UsePriceSetting').val();
                if (usePriceVal == 1) {
                    $('#txtAmount').click(function() {
                        $(this).select();
                    });
                    $("#txtAmount").keyup(function(e) {
                        if (e.keyCode == 13) {
                            $("#txtPricePerUnit").select();
                        }
                    });
                    $('#txtPricePerUnit').click(function() {
                        $(this).select();
                    });
                    $("#txtPricePerUnit").keyup(function(e) {
                        if (e.keyCode == 13) {
                            $("#ddlUnit").focus();
                        }
                    });
                    $("#ddlUnit").keyup(function(e) {
                        if (e.keyCode == 13) {
                            $("#ddlorder").focus();
                        }
                    });



                } else {
                    $('#txtAmount').click(function() {
                        $(this).select();
                    });
                    $("#txtAmount").keyup(function(e) {
                        if (e.keyCode == 13) {
                            $("#ddlUnit").focus();
                        }
                    });

                    $("#ddlUnit").keyup(function(e) {
                        if (e.keyCode == 13) {
                            $("#ddlorder").focus();
                        }
                    });

                }
            }

            $("#ddlorder").keyup(function(e) {
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
    <div id="xButton" runat="server">
        <div id="toolbar-button">
            <div class="icon-mod-preparedoc" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
            </div>
            <div class="toolbar-title">
                <asp:Label ID="lt" runat="server" CssClass="texttitle">Template Document</asp:Label></div>
            <button id="btnCreateDocument" type="button" runat="server" validationgroup="g1">
                Create Document
            </button>
            <button id="btnBackToDocument" type="button" runat="server" style="display: none;">
                Create New Document Template
            </button>
            <button id="btnSeachDocument" type="button" runat="server">
                Search Document
            </button>
            <button id="btnSave" type="button" runat="server">
                Save Document
            </button>
            <button id="btnTemplate" type="button" style="display: none;" runat="server">
                Template
            </button>
            <button id="btnAppove" type="button" runat="server" style="display: none;">
                Approve Document
            </button>
            <button id="btnCancelDocment" type="button" runat="server">
                Cancel Document
            </button>
            <button id="btnPreview" type="button" style="display: none;" runat="server">
                Preview
            </button>
            <button id="btnPrint" type="button" style="display: none;" runat="server">
                Print Document
            </button>
            <button id="btnApplyToShop" type="button" runat="server">
                ApplyToShop
            </button>
            <button id="btnReload" type="button" runat="server" onclick="javascript:window.location.reload();">
                click Reload
            </button>
            <asp:HiddenField ID="hdfDocumentID" runat="server" />
            <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
            <asp:HiddenField ID="hdfIndexList" runat="server" />
        </div>
    </div>
    <div id="content">
        <div id="content-pane" class="pane-sliders">
            <div style="display: none;">
                <asp:Label ID="lb2" runat="server"></asp:Label>
                <asp:Label ID="lbDocumentStatus" runat="server"></asp:Label>
                <asp:Label ID="lbDocumentNumber" runat="server"></asp:Label>
            </div>
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lb1" runat="server"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key" width="40%">
                                <asp:Label ID="LbDocumentType" runat="server" Text="Document Type"></asp:Label>
                            </td>
                            <td width="300px">
                                <asp:DropDownList ID="ddlDocumentType" runat="server" Width="220px">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlDocumentType" Display="Dynamic" InitialValue="0" SetFocusOnError="True"
                                    ValidationGroup="g1">
                                </asp:RequiredFieldValidator>
                                <asp:HiddenField ID="UsePriceSetting" runat="server" />
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb7" runat="server" Text="Label">VendorGroup</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVendorGroup" runat="server" AutoPostBack="True" Width="250px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key" width="40%">
                                <asp:Label ID="lb3" runat="server">Template Code</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTemplateCode" runat="server" Width="220px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="txtTemplateCode" ValidationGroup="g1"></asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb8" runat="server">Vendor</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVendor" runat="server"   Width="250px" AutoPostBack="true">
                                </asp:DropDownList>&nbsp; <b></b><label>VAT :</label></b>
                                <asp:DropDownList ID="ddlvendorvattype" runat="server">
                                
                                 <asp:ListItem Value="2">Include</asp:ListItem>
                                <asp:ListItem Value="1">Exclude</asp:ListItem>
                                <asp:ListItem Value="0">No VAT</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb4" runat="server">Template Name</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTemplateName" runat="server" Width="220px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="txtTemplateName" ValidationGroup="g1"></asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                
                                <asp:Label ID="Lb9" runat="server" Text="FromDate"></asp:Label>
                                
                            </td>
                            <td valign="top">
                               <asp:DropDownList ID="RdoFromDate_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoFromDate_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoFromDate_DdlYear" runat="server">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server" Height="23px">Template Note</asp:Label></td>
                            <td>
                               
                                <asp:TextBox ID="txtNote" runat="server" Rows="2" TextMode="MultiLine" Width="90%"></asp:TextBox>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="Lb10" runat="server" Text="ToDate"></asp:Label>
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="RdoToDate_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoToDate_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoToDate_DdlYear" runat="server">
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
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
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh3" runat="server" Text="Amount"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;" id="thPricePerUnit" runat="server">
                            <asp:Label ID="lh4" runat="server" Text="Price/Unit"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;" id="thUnit" runat="server">
                            <asp:Label ID="lh5" runat="server" Text="Unit"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;" id="thDiscount" runat="server">
                            <asp:Label ID="lh6" runat="server" Text="Discount"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;" id="thVAT" runat="server">
                            <asp:Label ID="lh7" runat="server" Text="VAT"></asp:Label>
                        </th>
                       
                        <th nowrap="nowrap" style="width: 10%;" id="thTotal" runat="server">
                            <asp:Label ID="lh8" runat="server" Text="Total"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh9" runat="server" Text="Order"></asp:Label>
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
                            <div id="bts" runat="server" style="float: left; width: 20%;">
                            </div>
                        </td>
                        <td>
                            <asp:Label ID="lbMaterialName" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmount" runat="server" Style="width: 50px;" class="txt-numeric">0</asp:TextBox>
                        </td>
                        <td id="tdPricePerUnit" runat="server">
                            <asp:TextBox ID="txtPricePerUnit" runat="server" Style="width: 70px;" class="txt-numeric">0.00</asp:TextBox>
                        </td>
                        <td id="tdddlUnit" runat="server">
                            <asp:DropDownList ID="ddlUnit" runat="server" AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                        <td id="tdtxtDiscount" runat="server">
                            <div style="float: left; width: 45%;">
                                <asp:TextBox ID="txtDiscount" runat="server" Style="width: 100%;" class="txt-numeric">0</asp:TextBox>
                            </div>
                            <div style="float: left; width: 50%;">
                                <asp:DropDownList ID="ddlDiscount" runat="server">
                                    <asp:ListItem Value="2">%</asp:ListItem>
                                    <asp:ListItem Value="1">Baht</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </td>
                        <td id="tdddlVAT" runat="server">
                            <asp:DropDownList ID="ddlVAT" runat="server">
                                <asp:ListItem Value="2">Include</asp:ListItem>
                                <asp:ListItem Value="1">Exclude</asp:ListItem>
                                <asp:ListItem Value="0">No VAT</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                       
                        <td id="tdTotal" runat="server" style="text-align: right">
                            <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:TextBox ID="txtOrder" runat="server" Style="width: 30px;" class="txt-numeric" Visible="false">0</asp:TextBox>
                            <asp:DropDownList ID="ddlorder" runat="server">
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
                        </td>
                    </tr>
                    <asp:Label ID="tr2" runat="server"></asp:Label>
                    <tr class="row0" style="text-align: right" id="trSubTotal" runat="server">
                        <td colspan="9">
                            <asp:Label ID="lf1" runat="server" Text="SubTotal"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbSubTotal" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right" id="trDiscount" runat="server">
                        <td colspan="9">
                            <asp:Label ID="lf2" runat="server" Text="Discount"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDiscount" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right" id="trNetPrice" runat="server">
                        <td colspan="9">
                            <asp:Label ID="lf3" runat="server" Text="NetPrice"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbNetPrice" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right" id="trTotalVAT" runat="server">
                        <td colspan="9">
                            <asp:Label ID="lf4" runat="server" Text="TotalVAT"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbTotalVAT" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right" id="trGrandTotal" runat="server">
                        <td colspan="9">
                            <asp:Label ID="lf5" runat="server" Text="GrandTotal"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbGrandTotal" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                </tbody>
                <asp:Label ID="ft" runat="server"></asp:Label>
            </table>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 14px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
    </div>
    <div id="footer-box">
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
