<%@ page language="VB" autoeventwireup="false" inherits="Inventory_ProductSetting, App_Web_productsetting.aspx.9758fd70" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Product Setting</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/modal.js" type="text/javascript"></script>

    <script type="text/javascript">
        window.addEvent('domready', function () { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function (toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function (toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function ($) {
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
    <div id="content">
        <div id="condition" runat="server">
            <div id="content-pane" class="pane-sliders">
                <div class="panel">
                    <h3 id="detail-page" class="title jpane-toggler">
                        <asp:Label ID="lb1" runat="server">ตั้งค่าสินค้าเข้าร่วม</asp:Label>
                    </h3>
                    <div class="jpane-slider">
                        <table class="paramlist admintable" cellspacing="1" width="100%">
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb4" runat="server" Text="Label">กลุ่มสินค้า</asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlProductGroup" runat="server" AutoPostBack="True" Width="250px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb5" runat="server">หมวดสินค้า</asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlProductDept" runat="server" Width="250px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Button ID="btnSaveProduct" runat="server" Text="บันทึกข้อมูล" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
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
