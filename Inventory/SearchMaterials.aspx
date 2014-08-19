<%@ page language="VB" autoeventwireup="false" inherits="Inventory_SearchMaterials, App_Web_searchmaterials.aspx.9758fd70" enableEventValidation="false" %>

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
                                     <button id="btnSearch" type="button" runat="server">
                                        Search
                                    </button>
                                    <button id="btnAddMultiMaterials" type="button" runat="server" visible="false">
                                        Add multi materials
                                    </button>
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
