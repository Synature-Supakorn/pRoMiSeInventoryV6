<%@ page language="VB" autoeventwireup="false" inherits="Inventory_AddMultiMaterials, App_Web_addmultimaterials.aspx.9758fd70" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Search Materials.</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/modal.js" type="text/javascript"></script>

    <script type="text/javascript">
        window.addEvent('domready', function() { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });
        jQuery(document).ready(function($) {

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
                    var id = $(this).attr('id');
                    var Qty = $(this).val();
                    var LangID = $.getUrlVars()['LangID'];
                    var StaffID = $.getUrlVars()['StaffID'];
                    var StaffRoleID = $.getUrlVars()['StaffRoleID'];
                    var DocumentTypeID = $.getUrlVars()['DocumentTypeID'];
                    var RequestDocumentTypeID = $.getUrlVars()['RequestDocumentTypeID'];
                    var headHQOrBranch = $.getUrlVars()['headHQOrBranch'];
                    var requestFormID = $.getUrlVars()['requestFormID'];
                    var InvenID = $.getUrlVars()['InvenID'];
                    var MaterialDept = $("#ddlMaterialDept").val();
                    var MaterialGroup = $("#ddlMaterialGroup").val();
                    var nxtIdx = $('input:text').index(this) + 1;

                    if ($.getUrlVar('DocumentShopID') != undefined && $.getUrlVar('DocumentID') != undefined) {

                        var DocumentShopID = $.getUrlVars()['DocumentShopID'];
                        var DocumentID = $.getUrlVars()['DocumentID'];
                        var url = "&LangID=" + LangID + "&StaffID=" + StaffID + "&StaffRoleID=" + StaffRoleID + "&DocumentTypeID=" + DocumentTypeID + "&RequestDocumentTypeID=" + RequestDocumentTypeID + "&DocumentShopID=" + DocumentShopID + "&DocumentID=" + DocumentID + "&headHQOrBranch=" + headHQOrBranch + "&requestFormID=" + requestFormID + "&InvenID=" + InvenID
                        $(":input:text:eq(" + nxtIdx + ")").select();
//                        $.ajax({
//                            url: 'AddMultiMaterials.aspx?action=1' + url,
//                            cache: false,
//                            type: 'POST',
//                            data: ({ id: id, Qty: Qty, mDept: MaterialDept, mGroup: MaterialGroup }),
//                            complete: function(xhr, status) {
//                                //alert(xhr.responseText);
//                                if (status == 'success') {
//                                    //var data = eval("(" + xhr.responseText + ")");
//                                    //alert(data.status);
//                                    //alert($("#lM1").text());                                    
//                                    //$(":input:text:eq(" + nxtIdx + ")").select();
//                                } else {
//                                    //alert($("#lM2").text());
//                                };
//                            }
//                        });
                    }
                }
            });

        });
 
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div id="condition" runat="server">
            <div id="content-pane" class="pane-sliders">
                <div class="panel">
                    <h3 id="detail-page" class="title jpane-toggler">
                        <asp:Label ID="lb1" runat="server">Search Materials</asp:Label>
                    </h3>
                    <div class="jpane-slider">
                        <table class="paramlist admintable" cellspacing="1" width="100%">
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb4" runat="server" Text="Label">Material Group</asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMaterialGroup" runat="server" AutoPostBack="True" Width="220px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlMaterialDept" runat="server" Width="220px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:HiddenField ID="hdfDocumentID" runat="server" />
                                    <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
                                    <asp:HiddenField ID="hdfIndexList" runat="server" />
                                    <asp:HiddenField ID="hdfTotalrecord" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px; overflow: auto; max-height:400px;">
            </div>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <button id="btnClosewindow" type="button" runat="server">
                Close window
            </button>
            <button id="btnDoload" type="button" runat="server">
                Save Materails
            </button>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 20px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
        <div style="display: none;">
            <asp:Label ID="lh1" runat="server">Material Code</asp:Label>
            <asp:Label ID="lh2" runat="server">Material Name</asp:Label>
            <asp:Label ID="lh3" runat="server">Qty.</asp:Label>
            <asp:Label ID="lh4" runat="server">Unit Name</asp:Label>
             <asp:Label ID="lh5" runat="server">Stock</asp:Label>
            <asp:Label ID="lM1" runat="server">Succussfuly.</asp:Label>
            <asp:Label ID="lM2" runat="server">Error</asp:Label>
        </div>
    </div>
    </form>
</body>
</html>
