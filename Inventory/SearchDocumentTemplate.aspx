<%@ page language="VB" autoeventwireup="false" inherits="Inventory_SearchDocumentTemplate, App_Web_searchdocumenttemplate.aspx.9758fd70" theme="Classic" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Search Document Template</title>
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

   <%-- <script language="javascript">
        window.onload = function() {
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);
        }  
    </script>--%>

    <script type="text/javascript">
        window.addEvent('domready', function() { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div id="content-pane" class="pane-sliders">
            <table style="width: 100%;" id="tbDocType" runat="server">
                <tr>
                    <td width="110px" align="right">
                        <asp:Label ID="LbInv" runat="server" Text="Inventory"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlInv" runat="server" Width="210px">
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                        <asp:Label ID="Lb9" runat="server" Text="FromDate"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="RdoFromDate_DdlDay" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="RdoFromDate_DdlMonth" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="RdoFromDate_DdlYear" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="LbDocumentType" runat="server" Text="Document Type"></asp:Label>
                    </td>
                    <td width="220px">
                        <asp:DropDownList ID="ddlDocumentType" runat="server" Width="210px">
                        </asp:DropDownList>
                    </td>
                    <td width="70px" align="right">
                        <asp:Label ID="Lb10" runat="server" Text="ToDate"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="RdoToDate_DdlDay" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="RdoToDate_DdlMonth" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="RdoToDate_DdlYear" runat="server">
                        </asp:DropDownList>
                        <asp:Button ID="btnsearchdoc" runat="server" Text="Search" Height="25px" />
                    </td>
                </tr>
            </table>
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="msgResponse" runat="server"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="adminlist" cellspacing="1">
                        <thead>
                            <tr>
                                <th nowrap="nowrap" style="width: 5%; height: 25px;">
                                    #
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh1" runat="server" Text="Code"></asp:Label>
                                </th>
                                <th nowrap="nowrap">
                                    <asp:Label ID="lh2" runat="server" Text="Template Name" Style="width: 20%;"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh3" runat="server" Text="Template Status"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh5" runat="server" Text="ApplyToShop"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh6" runat="server" Text="FromDate"></asp:Label>
                                </th>
                                <th nowrap="nowrap" style="width: 15%;">
                                    <asp:Label ID="lh7" runat="server" Text="ToDate"></asp:Label>
                                </th>
                                <th nowrap="nowrap">
                                    <asp:Label ID="lh4" runat="server" Text="Note"></asp:Label>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Label ID="tr1" runat="server" Style="display: none;"></asp:Label>
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
            <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
                <asp:Label ID="msgError" runat="server" Style="font-size: 14px; font-weight: bold;
                    color: Red; font-family: Tahoma;"></asp:Label>
            </div>
    </form>
</body>
</html>
