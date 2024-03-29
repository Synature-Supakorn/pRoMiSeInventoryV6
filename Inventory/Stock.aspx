﻿<%@ page language="VB" autoeventwireup="false" inherits="Inventory_Stock, App_Web_stock.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<html>
<head runat="server">
    <title>Stock Card.</title>
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

    <script type="text/javascript">

        window.addEvent('domready', function() { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function($) {
        $("button, input:submit, a", "#xButton").button({ icons: { primary: 'icon-action-search' }, text: true })
                  .next().button({ icons: { primary: 'icon-export-xls'} });
            $(function() {
                $(".txt-numeric").keypress(function(evt) {
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
            $("#txtAmount").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#ddlUnit").focus();
                }
            });

            $("#ddlUnit").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#btnSaveMaterial").focus();
                }
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
    <div id="content">
        <div style="display: none;">
            <asp:Label ID="lh1" runat="server">Code</asp:Label>
            <asp:Label ID="lh2" runat="server">Item</asp:Label>
            <asp:Label ID="lh3" runat="server">UnitName</asp:Label>
        </div>
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lb1" runat="server" Text="Movement stock."></asp:Label>
                </h3>
                <div class="jpane-slider" >
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb2" runat="server">Inventory</asp:Label>
                            </td>
                            <td rowspan="4" valign="top" nowrap="nowrap" width="220px">
                                <asp:Panel ID="Panel1" runat="server" Height="120px" ScrollBars="Auto" BorderColor="#999999"
                                    BorderStyle="Solid" BorderWidth="1px">
                                    <div id="chkInv" runat="server">
                                    </div>
                                </asp:Panel>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb3" runat="server">Search by</asp:Label>
                            </td>
                            <td nowrap="nowrap" width="220px">
                                <asp:DropDownList ID="ddlSelectGroup" runat="server" AutoPostBack="true" Width="100%">
                                    <asp:ListItem Value="0">Normal Group</asp:ListItem>
                                    <asp:ListItem Value="1">Special Group</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb7" runat="server" Height="23px">Date</asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlDay" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlMonth" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlYear" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                                <asp:Label ID="lb4" runat="server">Material Group</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMaterialGroup" runat="server" AutoPostBack="true" Width="100%">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb8" runat="server">To Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDues_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlYear" runat="server">
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlDay" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDues_DdlMonth" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDues_DdlYear" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                                <asp:Label ID="lb5" runat="server">Material Dept.</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMaterialDept" runat="server" Width="100%">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="cbMaterialHasMovement" runat="server" Checked="true" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lb9" runat="server">View stock has movement only.</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb6" runat="server">Material Code</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaterialCode" runat="server" class="TextBox" Width="100%"></asp:TextBox>
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td>
                                <div id="xButton" runat="server">
                                    <button id="btnSearch" type="button" runat="server" ValidationGroup="v">
                                        Search
                                    </button>
                                    <button id="btnExportExcel" type="button" runat="server" ValidationGroup="v">
                                        Export to excel
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
        </div>
        <div style="text-align: center;">
            <h1>
                <asp:Label ID="msgResponse" runat="server"></asp:Label></h1>
        </div>
    </div>
    </form>
</body>
</html>
