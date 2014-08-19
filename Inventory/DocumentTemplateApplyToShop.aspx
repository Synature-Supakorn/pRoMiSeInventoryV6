<%@ page language="VB" autoeventwireup="false" inherits="Inventory_DocumentTemplateApplyToShop, App_Web_documenttemplateapplytoshop.aspx.9758fd70" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>DocumentTemplate Apply To Shop</title>
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
        <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/modal.js" type="text/javascript"></script>

    <script src="../Scripts/menu.js" type="text/javascript"></script>

    <script src="../Scripts/index.js" type="text/javascript"></script>

    <script type="text/javascript">

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
    <div id="ShowShop" runat="server">
    
    </div>
    <div id="sec_update" style="margin-top:10px; text-align:center; padding:4px;">
        <asp:Button ID="btnupdate" runat="server" Text="บันทึก" Height="25" Width="70" />
        <asp:Button ID="btnclose" runat="server" Text="ปิดหน้าต่าง" Height="25" Width="70" OnClientClick="javascript:window.close();" />
    <br />
    <p>
       <h1><asp:Label ID="msgError" runat="server"></asp:Label></h1> 
    </p>
    </div>
    </form>
</body>
</html>
