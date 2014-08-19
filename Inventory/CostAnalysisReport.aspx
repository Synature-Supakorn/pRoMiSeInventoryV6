<%@ page language="C#" autoeventwireup="true" inherits="Inventory_CostAnalysisReport, App_Web_costanalysisreport.aspx.9758fd70" enableEventValidation="false" %>


<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<html>
<head id="Head1" runat="server">
    <title>Cost Analysis Report.</title>
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
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div style="display: none;">
            <asp:Label ID="lh1" runat="server">Document Date</asp:Label>
            <asp:Label ID="lh2" runat="server">Document Number</asp:Label>
            <asp:Label ID="lh3" runat="server">Item</asp:Label>
            <asp:Label ID="lh4" runat="server">In Qty.</asp:Label>
            <asp:Label ID="lh5" runat="server">Out Qty.</asp:Label>
            <asp:Label ID="lh6" runat="server">Remain</asp:Label>
        </div>
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lb1" runat="server" Text="รายงานสรุปเบิกสินค้าตามแผนก"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb2" runat="server">คลัง</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInv" runat="server" Width="220px">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlInv" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb7" runat="server" Height="23px">วันที่เริ่มต้น</asp:Label>
                            </td>
                            <td>
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
                                <asp:Label ID="lb4" runat="server">แผนก</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDepartment" runat="server" Width="220px">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb8" runat="server">ถึงวันที่</asp:Label>
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
                                <asp:Label ID="lb6" runat="server">รหัสสินค้า</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaterialCode" runat="server" class="TextBox" Width="220px"></asp:TextBox>
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td>
                                <div id="xButton" runat="server">
                                    <asp:Button ID="btnSeach" runat="server" Text="ค้นหา" onclick="btnSeach_Click" />
                                    <asp:Button ID="btnExport" runat="server" Text="Export to Excel" onclick="btnExport_Click" />
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