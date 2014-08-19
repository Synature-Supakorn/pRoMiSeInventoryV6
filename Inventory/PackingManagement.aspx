<%@ page language="VB" autoeventwireup="false" inherits="Inventory_PackingManagement, App_Web_packingmanagement.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<html>
<head runat="server">
    <title>Prepare Batch Request Order.</title>
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
        window.addEvent('domready', function() { new Accordion($$('.panel h1.jpane-toggler'), $$('.panel div.jpane-slider1'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });
        window.addEvent('domready', function() { new Accordion($$('.panel h2.jpane-toggler'), $$('.panel div.jpane-slider2'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function ($) {
            $("button, input:submit, a", "#xButton").button({ icons: { primary: 'icon-action-save' }, text: true })
                  .next().button({ icons: { primary: 'icon-export-xls' } });
            $("button, input:submit, a", "#toolbar-button").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-print' } })
                  .next().button({ icons: { primary: 'icon-action-print' } })
                  .next().button({
                      icons: { primary: 'icon-action-print' }
                  });
            $('.txtMV').click(function() {
                $(this).select();
            });
            $(function() {
                $(".txtMV").keypress(function(evt) {
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
            $('.txtMV').keyup(function(e) {
                if (e.keyCode == 13) {
                    //alert(e.keyCode);
                    var id = $(this).attr('id');
                    var Qty = $(this).val();
                    var LangID = $.getUrlVars()['LangID'];
                    var StaffID = $.getUrlVars()['StaffID'];
                    var StaffRoleID = $.getUrlVars()['StaffRoleID'];
                    var DocumentTypeID = $.getUrlVars()['DocumentTypeID'];
                    var RequestDocumentTypeID = $.getUrlVars()['RequestDocumentTypeID'];
                    var nxtIdx = $('input:text').index(this) + 1;
                    if ($.getUrlVar('DocumentShopID') != undefined && $.getUrlVar('DocumentID') != undefined) {
                        var DocumentShopID = $.getUrlVars()['DocumentShopID'];
                        var DocumentID = $.getUrlVars()['DocumentID'];
                        var url = "&LangID=" + LangID + "&StaffID=" + StaffID + "&StaffRoleID=" + StaffRoleID + "&DocumentTypeID=" + DocumentTypeID + "&RequestDocumentTypeID=" + RequestDocumentTypeID + "&DocumentShopID=" + DocumentShopID + "&DocumentID=" + DocumentID
                        $(":input:text:eq(" + nxtIdx + ")").select();
                        /*$.ajax({
                        url: 'PackingManagement.aspx?action=5' + url,
                        cache: false,
                        type: 'POST',
                        data: ({ id: id, Qty: Qty }),
                        complete: function(xhr, status) {
                        if (status == 'success') {
                        //alert($("#lM1").text());
                        //$(":input:text:eq(" + nxtIdx + ")").select();
                        $('#' + id).css("background-color", "#088A29");
                        //window.location.reload();
                        } else {
                        //alert($("#lM2").text());
                        //$(":input:text:eq(" + nxtIdx + ")").select();
                        alert('!!Save Material Fail.');
                        };
                        }
                        });*/
                    }
                }
            });
            $('#saveallmaterial').one('click', function() {
                //alert('yes');

                $("#loading").ajaxStart(function() {
                    $(this).show();
                });

                var id = '';
                var Qty = '';
                $(".txtMV").each(function() {
                    if ($(this).val() != '') {
                        var _data;
                        _data = $(this).attr('id');
                        var arrData = _data.split('_');
                        var newValue = $(this).val()
                        //alert(parseFloat(arrData[4]) + ':' + parseFloat(newValue));
                        if (parseFloat(arrData[4]) != parseFloat(newValue)) {
                            id += $(this).attr('id') + "|" + $(this).val() + ",";
                            Qty += $(this).val() + ",";
                        }
                    }

                });
                //alert(id);
                var LangID = $.getUrlVars()['LangID'];
                var StaffID = $.getUrlVars()['StaffID'];
                var StaffRoleID = $.getUrlVars()['StaffRoleID'];
                var DocumentTypeID = $.getUrlVars()['DocumentTypeID'];
                var RequestDocumentTypeID = $.getUrlVars()['RequestDocumentTypeID'];
                var InvenID = $.getUrlVars()['InvenID'];
                //var nxtIdx = $('input:text').index(this) + 1;
                if (Qty != '') {
                    if ($.getUrlVar('DocumentShopID') != undefined && $.getUrlVar('DocumentID') != undefined) {
                        var DocumentShopID = $.getUrlVars()['DocumentShopID'];
                        var DocumentID = $.getUrlVars()['DocumentID'];
                        var url = "&LangID=" + LangID + "&StaffID=" + StaffID + "&StaffRoleID=" + StaffRoleID + "&DocumentTypeID=" + DocumentTypeID + "&RequestDocumentTypeID=" + RequestDocumentTypeID + "&DocumentShopID=" + DocumentShopID + "&DocumentID=" + DocumentID + "&InvenID=" + InvenID
                        //alert(url);
                        $.ajax({
                            url: 'PackingManagement.aspx?action=8' + url,
                            cache: false,
                            type: 'POST',
                            data: ({ id: id, Qty: Qty }),
                            complete: function(xhr, status) {
                                if (status == 'success') {
                                    //alert($("#lM1").text());
                                    //$('.txtMV').css("background-color", "#088A29");
                                    alert('Save Material Success.');
                                    window.location.reload();
                                } else {
                                    //alert($("#lM2").text());
                                    $('.txtMV').css("background-color", "#B43104");
                                };
                            }
                        });
                    }
                } else { $('.txtMV').css("background-color", "#FAFAFA"); }

                $('#saveallmaterial').attr('disabled', '');
                $("#loading").ajaxStop(function() {
                    $(this).hide();
                });
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
    <div id="header-box">
        <uc1:MenuBar ID="menu" runat="server" />
    </div>
    <div id="toolbar-button">
        <div class="icon-mod-packingdoc" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
        </div>
        <div class="toolbar-title">
            <asp:Label ID="lt" runat="server" CssClass="texttitle">Batch Request Document</asp:Label></div>
        <button id="btnCreateDocument" type="button" runat="server">
            Create Document
        </button>
        <button id="btnSeachDocument" type="button" runat="server">
            Search Tranfer Document
        </button>
        <button id="btnSearchRequestDocument" type="button" runat="server">
            Search Request Document
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
       
        <button id="btnPreview" type="button" runat="server" style="display:none;">
            Print Document
        </button>
        <button id="btnPrint" type="button" runat="server"  style="display:none;">
            Print
        </button>
        <button id="btnExprotToExcel" type="button" runat="server"  style="display:none;">
            Export To Excel
        </button>
        <div id="divPrint" runat="server" >
            <asp:DropDownList ID="ddlPrint" runat="server" AutoPostBack="true">
            </asp:DropDownList>
        </div>
        <asp:HiddenField ID="hdfDocumentID" runat="server" />
        <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
    </div>
    <div id="content">
        <div id="content-pane1" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page1" class="title jpane-toggler">
                    <asp:Label ID="lbDocumentName" runat="server"></asp:Label>
                    <asp:Label ID="lb1" runat="server" Text="Document Status"></asp:Label>
                    <asp:Label ID="lbDocumentStatus" runat="server"></asp:Label>
                    <asp:Label ID="lb2" runat="server" Text="Document Number"></asp:Label>
                    <asp:Label ID="lbDocumentNumber" runat="server"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key" width="40%">
                                <asp:Label ID="lb3" runat="server" Height="23px">Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDocs_DdlDay" runat="server" Width="70px">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server" Width="120px">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server" Width="70px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb4" runat="server">Delivery Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDues_DdlDay" runat="server" Width="70px">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlMonth" runat="server" Width="120px">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlYear" runat="server" Width="70px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server">Note</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNote" runat="server" Rows="2" TextMode="MultiLine" Width="50%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="content-pane2" class="pane-sliders">
            <div class="panel">
                <h1 id="DocumentRequest" class="title jpane-toggler">
                    <asp:Label ID="lb6" runat="server" Text="Requst Document."></asp:Label></h1>
                <div style="text-align:right;"></div>
                <div class="jpane-slider1">
                    <table class="adminlist" cellspacing="1">
                        <thead>
                            <tr>
                                <th nowrap="nowrap" style="width: 2%; height: 25px;">
                                    #
                                </th>
                                <th style="width: 2%;">
                                    <div id="chk1" runat="server">
                                    </div>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh1" runat="server" Text="Document Number"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh2" runat="server" Text="Date"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh3" runat="server" Text="To Inventory"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh4" runat="server" Text="Dalivery Date"></asp:Label>
                                </th>
                                <th nowrap="nowrap">
                                    <asp:Label ID="lh5" runat="server" Text="Note"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 5%;">
                                    x
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Label ID="TRRequestDocument" runat="server"></asp:Label>
                        </tbody>
                        <tfoot>
                            <tr style="height: 25px;">
                                <td colspan="8">
                                    <div style="float: left;">
                                        <button id="btnDelete" type="button" runat="server">
                                            Delete
                                        </button>
                                    </div>
                                    <div class="pagination">
                                        <asp:Label ID="resultRecord" runat="server"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div> 
                <div id="xButton" style="text-align:right; padding:5px; background:#f3f3f3;">     
                <button id="saveallmaterial" type="button" runat="server">
                    Save All Material</button>
                </div>
            </div>
          
        </div>
       
        <div>
            <div id="loading" style="text-align: center; display: none;">
                <img src="../Images/loading4.gif" />
                Loading...</div>
        </div>
        <div id="content-pane3" class="pane-sliders">
            <div class="panel">
                <h2 id="Matrix" class="title jpane-toggler">
                    <asp:Label ID="lb7" runat="server" Text="Matrix"></asp:Label></h2>
                <div class="jpane-slider2">
                    <div style="display: none;">
                        <asp:Label ID="lh6" runat="server"></asp:Label>
                        <asp:Label ID="lh7" runat="server"></asp:Label>
                        <asp:Label ID="lh8" runat="server"></asp:Label>
                        <asp:Label ID="lh9" runat="server"></asp:Label>
                        <asp:Label ID="lh10" runat="server"></asp:Label>
                        <asp:Label ID="lh11" runat="server"></asp:Label>
                        <asp:Label ID="lM1" runat="server"></asp:Label>
                        <asp:Label ID="lM2" runat="server"></asp:Label>
                    </div>
                    <asp:Label ID="TRMatrixData" runat="server"></asp:Label>
                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" BorderColor="#999999">
                        <asp:Label ID="TRMatrixDataDoro" runat="server" Visible="false"></asp:Label>
                        <asp:Label ID="TRMatrixDataFooterDoro" runat="server" Visible="false"></asp:Label>
                    </asp:Panel>
                </div>
            </div>
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
