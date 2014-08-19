<%@ page language="C#" autoeventwireup="true" inherits="Inventory_Report_CrDocRequestAndTransfer, App_Web_crdocrequestandtransfer.aspx.db764860" enableEventValidation="false" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" HasCrystalLogo="False"
            HasDrillUpButton="False" HasSearchButton="False" HasToggleGroupTreeButton="True"
            HasViewList="False" HasZoomFactorList="False" PrintMode="ActiveX"/>
    </div>
    </form>
</body>
</html>
