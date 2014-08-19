<%@ page language="VB" autoeventwireup="false" inherits="Inventory_SearchDocumentForPrintBarcode, App_Web_searchdocumentforprintbarcode.aspx.9758fd70" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Search Document.</title>
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
                    <asp:Label ID="lb1" runat="server" Text="Search Document"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key" width="40%">
                                <asp:Label ID="lb2" runat="server">Inventory</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInv" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlDocumentType" runat="server">
                                    <asp:ListItem Value="2">เอกสารรับจากสั่งซื้อ</asp:ListItem>
                                    <asp:ListItem Value="12">เอกสารแปรรูป</asp:ListItem>
                                </asp:DropDownList>
                                <button id="btnSearchDocument" type="button" runat="server">
                                    Search Document
                                </button>
                                <button id="btnBack" type="button" runat="server" visible="false">
                                    Click Back
                                </button>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server">Document Status</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDocumentStatus" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb3" runat="server" Height="23px">From Date</asp:Label>
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
                                <asp:Label ID="lb4" runat="server">To Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDoce_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDoce_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDoce_DdlYear" runat="server">
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
    </form>
</body>
</html>
