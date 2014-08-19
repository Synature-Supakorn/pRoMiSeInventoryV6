<%@ page language="VB" autoeventwireup="false" inherits="Inventory_DocumentTemplate_EditMultiMaterials, App_Web_documenttemplate_editmultimaterials.aspx.9758fd70" enableEventValidation="false" %>

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
<script language="javascript">
        window.onload = function() {
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);
        }  
    </script>
    <script type="text/javascript">

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
                    var nxtIdx = $('input:text').index(this) + 1;
                    $(":input:text:eq(" + nxtIdx + ")").focus();
                }
            });

        });
 
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div>
            <span id="responseText" runat="server"></span>
        </div>
        <div style="display: none;">
            <asp:Label ID="lh1" runat="server">Material Code</asp:Label>
            <asp:Label ID="lh2" runat="server">Material Name</asp:Label>
            <asp:Label ID="lh3" runat="server">Qty.</asp:Label>
            <asp:Label ID="lh4" runat="server">Price/Unit</asp:Label>
            <asp:Label ID="lh5" runat="server">Unit Name</asp:Label>
            <asp:Label ID="lh6" runat="server">VAT</asp:Label>
            <asp:Label ID="lh7" runat="server">Material Supplier</asp:Label>
            <asp:Label ID="lM1" runat="server">Succussfuly.</asp:Label>
            <asp:Label ID="lM2" runat="server">Error</asp:Label>
        </div>
        <div id="condition" runat="server">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tr>
                    <td align="center">
                        <button id="btnDoload" type="button" runat="server" style="width: 70px;">
                            OK
                        </button>
                        <button id="btnCancel" type="button" runat="server" style="width: 70px;">
                            Cancel
                        </button>
                         <button id="btnClose" type="button" runat="server" style="width: 70px;" onclick="javascript:window.close();">
                             Close
                        </button>
                        <asp:HiddenField ID="hdfDocumentID" runat="server" />
                        <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
                        <asp:HiddenField ID="hdfTemplateDocumentID" runat="server" />
                        <asp:HiddenField ID="hdfTemplateDocumentShopID" runat="server" />
                        <asp:HiddenField ID="hdfIndexList" runat="server" />
                        <asp:HiddenField ID="hdfTotalrecord" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 20px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
    </div>
    </form>
</body>
</html>
