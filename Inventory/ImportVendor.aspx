<%@ page language="VB" autoeventwireup="false" inherits="Inventory_ImportVendor, App_Web_importvendor.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:Button ID="btnUpload" runat="server" Text="Import Vendor" />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
        <div runat="server" id="myTable"></div>
    </div>
    </form>
</body>
</html>
