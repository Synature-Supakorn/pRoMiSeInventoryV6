<%@ page language="VB" autoeventwireup="false" inherits="Inventory_SummaryPrefinishDocument, App_Web_summaryprefinishdocument.aspx.9758fd70" theme="Classic" enableEventValidation="false" %>

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
            
                <asp:Label ID="lbHeader" runat="server" Font-Size="20">วัตถุดิบที่ใช้ในการแปรรูปสินค้า</asp:Label>
            <asp:HiddenField ID="hdfDocumentID" runat="server" />
            <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
        </div>
        <table class="adminlist" cellspacing="1">
            <thead>
                <tr>
                    <th nowrap="nowrap" style="width: 5%; height: 25px;">
                        #
                    </th>
                    <th nowrap="nowrap" style="width: 15%;">
                        <asp:Label ID="lh5" runat="server" Text="Code"></asp:Label>
                    </th>
                    <th nowrap="nowrap">
                        <asp:Label ID="lh6" runat="server" Text="Item"></asp:Label>
                    </th>
                    <th nowrap="nowrap" style="width: 20%;">
                        <asp:Label ID="lh7" runat="server" Text="Standard Qty."></asp:Label>
                    </th>
                    <th nowrap="nowrap" style="width: 20%;">
                        <asp:Label ID="lh9" runat="server" Text="Unit"></asp:Label>
                    </th>
                </tr>
            </thead>
            <tbody>
                <asp:Label ID="tr2" runat="server" Style="display: none;"></asp:Label>
            </tbody>
            <tfoot>
                <tr style="height: 25px;">
                    <td colspan="6">
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
    </form>
</body>
</html>
