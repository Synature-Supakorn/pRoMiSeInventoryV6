<%@ page language="VB" autoeventwireup="false" inherits="Inventory_EDI, App_Web_edi.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE>
<html>
<head runat="server">
    <title>Electronic data interchange</title>
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 20px;">
        <table class="adminlist" cellspacing="1">
            <tr>
                <th style="width: 100px; text-align: right;">
                    <label>
                        วันที่ :</label>
                </th>
                <td>
                   <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th style="text-align: right;">
                    <label>
                        สถานะ :</label>
                </th>
                <td>
                    <asp:DropDownList ID="ddl_status" runat="server" Style="width: 200px;" >
                        <asp:ListItem Value="-1">-- แสดงทั้งหมด --</asp:ListItem>
                        <asp:ListItem Value="0">ยังไม่ถูกส่ง</asp:ListItem>
                        <asp:ListItem Value="1">ส่งเรียบร้อยแล้ว</asp:ListItem>
                        <asp:ListItem Value="99">ส่งไม่ผ่าน</asp:ListItem>
                    </asp:DropDownList> &nbsp;
                    <asp:Button ID="btn_search" runat="server" Text="ค้นหาเอกสาร" style="height:25px;width:100px;" />
                </td>
            </tr>
        </table>
        <table class="adminlist" cellspacing="1" style="margin-top: 4px;">
            <thead>
                <tr>
                    <th style="height: 30px; width: 3%;">
                        #
                    </th>
                    <th style="height: 30px; width: 5%;">
                        STATUS
                    </th>
                    <th style="height: 30px; width: 20%;">
                        <label>
                            DOCUMENT NUMBER</label>
                    </th>
                    <th>
                        <label>
                            FILE NAME</label>
                    </th>
                    <th style="height: 30px; width: 7%;">
                        <label>
                            SEND</label>
                    </th>
                </tr>
            </thead>
            <tbody>
                <asp:Label ID="results" runat="server"></asp:Label>
            </tbody>
        </table>
    </div>
    </form>
</body>
</html>
