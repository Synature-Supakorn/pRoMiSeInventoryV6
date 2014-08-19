<%@ page language="VB" autoeventwireup="false" inherits="Inventory_StockCardDetail, App_Web_stockcarddetail.aspx.9758fd70" enableEventValidation="false" %>

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
       
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lb1" runat="server">Stock card detail.</asp:Label>
                    <asp:Label ID="lb0" runat="server"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb2" runat="server">Document Type</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDocumentType" runat="server" Width="250px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
        </div>
    </div>
    <div style="display: none;">
        <asp:Label ID="lh1" runat="server"></asp:Label>
        <asp:Label ID="lh2" runat="server"></asp:Label>
        <asp:Label ID="lh3" runat="server"></asp:Label>
        <asp:Label ID="lh4" runat="server"></asp:Label>
        <asp:Label ID="lh5" runat="server"></asp:Label>
        <asp:Label ID="lb3" runat="server"></asp:Label>
        <asp:Label ID="lb4" runat="server"></asp:Label>
        <asp:Label ID="lb5" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
