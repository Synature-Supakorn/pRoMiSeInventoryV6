<%@ page language="VB" autoeventwireup="false" inherits="Inventory_TranferAndPrepareOrderDocument, App_Web_tranferandprepareorderdocument.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<html>
<head runat="server">
    <title>Select a document to transfer or create prepare transfer documents.</title>
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
            $("button, input:submit, a", "#toolbar-button").button({ icons: { primary: 'icon-action-new' }, text: true });
        });
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="header-box" style="display: none;">
        <uc1:MenuBar ID="menu" runat="server" />
    </div>
    <div id="toolbar-button" style="text-align: left;">
        <fieldset> <legend>Create Transfer Document.</legend>
            <button id="btnTranferDocument" type="button" runat="server">
                Create Tranfer Document
            </button>
             <button id="btnTranferDocumentWithCost" type="button" runat="server">
                Create Tranfer Document With Cost
            </button>
        </fieldset>
    </div>
    <div id="content">
        <fieldset><legend>Create Batch Document.</legend>
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lb1" runat="server">Search the document..</asp:Label>
                </h3>
                <div style="display: none;">
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
                                <asp:Label ID="lb4" runat="server">To Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDues_DdlDay" runat="server" Width="70px">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlMonth" runat="server" Width="120px">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlYear" runat="server" Width="70px">
                                </asp:DropDownList>
                                <button id="btnSearchBatch" type="button" runat="server">
                                    Search Document
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="jpane-slider">
                    <table class="adminlist" cellspacing="1">
                        <thead>
                            <tr>
                                <th nowrap="nowrap" style="width: 5%; height: 25px;">
                                    #
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh1" runat="server" Text="Document Number"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh2" runat="server" Text="Date"></asp:Label>
                                </th>
                                <th nowrap="nowrap">
                                    <asp:Label ID="lh4" runat="server" Text="Note"></asp:Label>
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
                                    <div class="pagination">
                                        <asp:Label ID="resultRecord" runat="server"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
        </fieldset>
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
