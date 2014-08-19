<%@ page language="VB" autoeventwireup="false" inherits="login, App_Web_login.aspx.cdcab7d2" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Login Form</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <style type="text/css">
        body, input
        {
            font-family: Tahoma,Arial,sans-serif;
            font-size: 10pt;
        }
        .normalText
        {
            font-family: Tahoma,Arial,sans-serif;
            font-size: 10pt;
        }
    </style>
</head>
<body bgcolor="#C8D3DC" background="images/loginbg.gif" text="#666666" link="#003399"
    vlink="#997799" alink="#339900" style="margin: 0 0 0 0;">
    <form id="Form1" target="_top" runat="server">
    <br />
    <table border="0" cellpadding="1" cellspacing="0" align="center" width="540" bgcolor="003366">
        <tr>
            <td>
                <table border="1" cellpadding="0" cellspacing="0" align="center" width="540">
                    <tr bgcolor="White">
                        <td height="325">
                            <img src="images/logo_admin.gif" width="540" height="200" border="0" alt="" vspace="0" />
                            <table border="0" cellspacing="0" cellpadding="0" width="450">
                                <tr valign="top">
                                    <td width="120" nowrap height="110">
                                        &nbsp;
                                    </td>
                                    <td nowrap>
                                        <div id="showLogin" runat="server">
                                            <table border="0" cellpadding="2" cellspacing="0">
                                                <tr>
                                                    <td height="10" colspan="2">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="normalText" align="right">
                                                        Inventory:
                                                    </td>
                                                    <td>
                                                        <input type="hidden" id="shopid" runat="server" />
                                                        <input id="txtShop" type="text" value="" runat="server" readonly="readonly" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="normalText" align="right">
                                                        StaffCode:
                                                    </td>
                                                    <td>
                                                        <input id="txtUsr" type="text" value="" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="normalText" align="right">
                                                        Password:
                                                    </td>
                                                    <td>
                                                        <input id="txtPwd" type="password" value="" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="normalText" align="right">
                                                        Language:
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLanguage" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="Tr1" visible="true" runat="server" style="display: none;">
                                                    <td align="right">
                                                        <asp:CheckBox ID="chkPersist" runat="server" />
                                                    </td>
                                                    <td class="normalText">
                                                        Remember my credentials
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnLogIn" runat="server" Text="Login" Width="100px" Height="30px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:HyperLink ID="HyperLink1" Visible="false" runat="server" class="normalText" NavigateUrl="~/SettingWebConfig.aspx"
                                                            Font-Underline="False">
                                                             Setting Web.config</asp:HyperLink>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <div class="normalText" id="outMessage" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="RegisterText" class="text" runat="server">
                                            <table>
                                                <tr>
                                                    <td height="20">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="normalText">
                                                        Please register product before using pRoMiSe System
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <br>
                        </td>
                    </tr>
                    <tr bgcolor="003366">
                        <td align="center" height="20">
                            <font size="-2" face="arial, geneva, helvetica" color="white">pRoMiSe System by Synature
                                Group. Tel: 0-2530-3835-6 </font>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>

    <script language="JavaScript">
        document.forms[0].txtUsr.focus()
    </script>

</body>
</html>
