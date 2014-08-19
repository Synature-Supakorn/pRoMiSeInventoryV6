<%@ page language="VB" autoeventwireup="false" inherits="Inventory_SearchRequestDocumentForAddInBatch, App_Web_searchrequestdocumentforaddinbatch.aspx.9758fd70" enableEventValidation="false" %>
<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<html>
<head runat="server">
    <title>Search Document.</title>
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
                                <asp:DropDownList ID="ddlInv" runat="server" Width="210px" AutoPostBack="True">
                                </asp:DropDownList>
                                <button id="btnSearchDocument" type="button" runat="server">
                                    Search Document
                                </button>
                                <button id="btnBack" type="button" runat="server" visible="false">
                                    Click Back
                                </button>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server" Text="Document Status"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDocumentStatus" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMD" runat="server">
                            <td class="paramlist_key">
                                <asp:Label ID="lb3" runat="server">To Inventory</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlToInv" runat="server" Width="210px">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb6" runat="server" Text="Search by"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkDelivery" runat="server" Text="Search by delivery date" />
                                <asp:CheckBox ID="chkIncludeNoDelivery" runat="server" Checked="True" Text="Include no delivery date" />
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb4" runat="server" Height="23px">From Date</asp:Label>
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
                                <asp:Label ID="lb7" runat="server">To Date</asp:Label>
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
        <div style="display: none;">
            <asp:Label ID="lbbuttonAdd" runat="server"></asp:Label>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
        </div>
        <div style="padding: 5px; text-align: center;">
            <button id="DoAddRequestDocumentToBatch" runat="server" type="button">
                Add request document to batch
            </button>
             <button id="DoPrintDocTransfer" runat="server" type="button">
                พิมพ์เอกสารโอนย้ายสินค้า
            </button>
            <button id="DoCloseWindow" runat="server" type="button">
               กลับหน้ารอบเอกสารโอนย้ายสินค้า
            </button>
           
            <asp:HiddenField ID="hddCloseBrowser" runat="server" />
        </div>
        <div style="text-align: center;">
            <h1>
                <asp:Label ID="msgResponse" runat="server"></asp:Label></h1>
        </div>
    </div>
    </form>
</body>
</html>
