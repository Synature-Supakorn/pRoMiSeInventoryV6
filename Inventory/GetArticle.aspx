<%@ page language="C#" autoeventwireup="true" inherits="GetArticle, App_Web_getarticle.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../App_Themes/start/jquery-ui-1.8.4.custom.css" rel="Stylesheet" />
    <style type="text/css">
        body
        {
            font-family: Tahoma;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="feedContainer" class="ui-widget" style="border:none;">
        <div id="feedHeader" class="ui-widget ui-widget-content" style="padding-left: 1%; border:none; border-bottom: #F0F0F0 1px solid;">
            <div style="float: left;">
                <h3 id="feedTitle" runat="server" style="margin-bottom: 2px !important">
                </h3>
            </div>
            <div style="float: right; padding:35px 10px 0 0;">
                <a href="javascript:window.print()" title="พิมพ์">
                    <img src="../Images/print.png" alt="pRoMiSe print icon" /></a>
            </div>
            <div style="clear: both; height: 1px;">
                &nbsp;</div>
        </div>
        <div style="background:#FCFCFC">
        <div style="font-size:12px; margin-left:1%;">
            <span>สร้างเมื่อวันที่ :</span><asp:Label ID="lblCreateDate" runat="server"></asp:Label>
            <span>สร้างโดย : </span><asp:Label ID="lblCreateBy" runat="server"></asp:Label>
        </div>
        <div id="feedDetail" runat="server" style="width: 90%; height: inherit; margin: 0 3%;" class="font-medium">
        </div></div>
    </div>
    </form>
</body>
</html>
