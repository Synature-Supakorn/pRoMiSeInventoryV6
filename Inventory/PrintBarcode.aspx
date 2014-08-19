<%@ page language="VB" autoeventwireup="false" inherits="PrintBarcode, App_Web_printbarcode.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<html>
<head id="Head1" runat="server">
    <title>Print Barcode.</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />

    <script src="../scripts/jquery-1.4.2.min.js"></script>
    <script src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>
    <script src="../Scripts/jquery.js" type="text/javascript"></script>   
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">
        window.addEvent('domready', function () { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function (toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function (toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function ($) {

            $('.txtMV').click(function () {
                $(this).select();                
            });

            $(function () {
                $(".txtMV").keypress(function (evt) {
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
            $('.txtMV').keyup(function (e) {
                if (e.keyCode == 13) {
                    var nxtIdx = $('input:text').index(this) + 1;                    
                    $(":input:text:eq(" + nxtIdx + ")").focus();
                    var cnxtIdx = nxtIdx - 1;
                    var txtValue = $(":input:text:eq(" + cnxtIdx + ")").val();
                    if (txtValue > 0) {
                        $(".chks_12:eq(" + (nxtIdx - 2) + ")").attr('checked', 'checked');
                    }
                    
                }
            });

            $('.chks_11').live('change', function () {
                $('.chks_12').attr('checked', $(this).is(':checked') ? 'checked' : '');
            });
            $('.chks_12').live('change', function () {
                $('.chks_12').length == $('.chks_12:checked').length ? $('.chks_11').attr('checked', 'checked').next() : $('.chks_11').attr('checked', '').next();

            });

        });       

         
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content" style="margin:20px;">
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
                                    <asp:Label ID="lb2" runat="server">Search by</asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="RdoSearch" runat="server" RepeatDirection="Horizontal" CssClass="blank"
                                        RepeatLayout="Flow">
                                        <asp:ListItem Value="1">Code</asp:ListItem>
                                        <asp:ListItem Value="2" Selected="True">Name</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb3" runat="server" Height="23px">Search</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMaterialCode" runat="server" Width="250px"></asp:TextBox>
                                     <button id="btnSearch" type="button" runat="server">
                                        Search
                                    </button>
                                    <button id="btnSearchDocument" type="button" runat="server">
                                        ค้นหาวัตถุดิบจากเอกสาร
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb4" runat="server" Text="Label">Material Group</asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMaterialGroup" runat="server" AutoPostBack="True" Width="250px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb5" runat="server">Material Dept</asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMaterialDept" runat="server" Width="250px" AutoPostBack="True">
                                    </asp:DropDownList>
                                     <button id="btnPrintBarcode" type="button" runat="server">
                                        พิมพ์บาร์โค้ดสินค้า
                                    </button>
                                    <button id="btnPrintBarcodeMaterial" type="button" runat="server">
                                        พิมพ์บาร์โค้ดวัตถุดิบ
                                    </button>
                                    <button id="btnExportToExcel" type="button" runat="server">
                                        Export To Excel
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div id="documentNumberText" runat="server"></div>
            <div id="responseText" runat="server" style="padding: 1px; margin-top: 0px;">
            </div>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 20px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
    </div>
    </form>
</body>
</html>
