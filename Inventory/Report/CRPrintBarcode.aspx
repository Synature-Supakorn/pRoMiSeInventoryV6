<%@ page language="VB" autoeventwireup="false" inherits="Inventory_Report_CRPrintBarcode, App_Web_crprintbarcode.aspx.db764860" enableEventValidation="false" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="resultText" runat="server">
         <CR:CrystalReportViewer ID="CrReport" runat="server" AutoDataBind="true" HasCrystalLogo="False"
                HasDrillUpButton="False" HasSearchButton="False" 
                HasToggleGroupTreeButton="false" HasViewList="False" 
                HasZoomFactorList="False" PrintMode="ActiveX"/>
       
    </div>
        <asp:Label ID="resultHTML" runat="server"></asp:Label>
    </form>
</body>
</html>
