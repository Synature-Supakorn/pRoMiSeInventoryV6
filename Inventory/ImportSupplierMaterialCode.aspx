<%@ page language="VB" autoeventwireup="false" inherits="Inventory_ImportSupplierMaterialCode, App_Web_importsuppliermaterialcode.aspx.9758fd70" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Search Materials.</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />

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
     <div style="height: 30px; padding: 4px 10px; background-color:#eee;">
                <div style="float: left; font-size: 14px;">
                    <div class="icon-mod-importexport" style="float: left; width: 32px; height: 32px;
                        margin-right: 4px;">
                    </div>
                    <div style="float: left;">
                        <div style="margin: 2px 0 0 2px;">
                           <b><asp:Label ID="lblModImportExportMac" runat="server" Text="Import Supplier Material Code"></asp:Label> <br />
                           
                           <asp:Label ID="lblModImportExportMacDescript" runat="server" Text="นำข้อมูลรหัสผู้จัดจำหน่ายจากไฟล์เข้าระบบ"></asp:Label>  </b></div>
                       
                    </div>
                </div>
                <div style="float: right;">
                </div>
                <div style="clear: both; height: 1px;">
                    &nbsp;</div>
            </div>
        <div id="condition" runat="server">
            <div id="content-pane" class="pane-sliders">
                <div class="panel">
                    <h3 id="detail-page" class="title jpane-toggler">
                        <asp:Label ID="lb1" runat="server">Import Supplier MaterialCode</asp:Label>
                    </h3>
                    <div class="jpane-slider">
                        <table class="paramlist admintable" cellspacing="1" width="100%">
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lb2" runat="server">Path File</asp:Label>
                                </td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:Button ID="btnUpload" runat="server" Text="Upload File" Width="120px" Height="35px" />
                                    <asp:Button ID="btnImport" runat="server" Text="Import File" Width="120px" Height="35px" Enabled="true"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <%--<asp:GridView ID="GridView1" runat="server" CssClass="adminlist">
            </asp:GridView>--%>
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
