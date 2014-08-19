<%@ page language="VB" autoeventwireup="false" inherits="Inventory_MaterialInSockForTransfer, App_Web_materialinsockfortransfer.aspx.9758fd70" theme="Classic" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Materials</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="../css/menu.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div style="text-align: center;">
            <h1>
                <asp:Label ID="msgResponse" runat="server"></asp:Label></h1>
        </div>
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
                        <asp:Label ID="lh2" runat="server" Text="Item"></asp:Label>
                    </th>
                    <th nowrap="nowrap" style="width: 20%;">
                        <asp:Label ID="lh3" runat="server" Text="Tranfer"></asp:Label>
                    </th>
                    <th nowrap="nowrap" style="width: 20%;">
                        <asp:Label ID="lh4" runat="server" Text="Stock"></asp:Label>
                    </th>
                </tr>
            </thead>
            <tbody>
                <asp:Label ID="tr1" runat="server" Style="display: none;"></asp:Label>
            </tbody>
            <tfoot>
                <tr style="height: 25px;">
                    <td colspan="5">
                        <div class="pagination">
                            <asp:Label ID="resultRecord" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
    </form>
</body>
</html>
