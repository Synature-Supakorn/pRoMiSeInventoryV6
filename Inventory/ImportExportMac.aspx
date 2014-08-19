<%@ page language="C#" autoeventwireup="true" inherits="Inventory_ImportExportMac, App_Web_importexportmac.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Import And Export Mac</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/Default.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .noTitleStuff .ui-dialog-titlebar
        {
            display: none;
        }
    </style>
    <link href="../scripts/jquery.jqGrid-3.8/css/ui.jqgrid.css" rel="stylesheet" />

    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="../scripts/jquery.MultiFile.js"></script>

    <script type="text/javascript" src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>

    <script src="../scripts/jquery.jqGrid-4.3.0/js/i18n/grid.locale-en.js" type="text/javascript"></script>

    <script src="../scripts/jquery.jqGrid-4.3.0/js/jquery.jqGrid.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../scripts/selectmenu/jquery.ui.selectmenu.js"></script>

    <script type="text/javascript" src="../scripts/invJqueryPlugins.js"></script>

    <script type="text/javascript">
        function importMac() {
            $("#btnImport").attr('disabled', true);
            $.ajax({
                url: 'DataXML/ImportExportMacData.aspx?action=import&StaffID=' + require_var.staffId + '&LangID=' + require_var.langId,
                dataType: 'json',
                complete: function (xhr, status) {
                    try{
                    var data = eval('(' + xhr.responseText + ')');
                    if (data) {
                        var msg = '';
                        if (data.import == 1)
                            msg = 'Import เรียบร้อยแล้ว';
                        else
                            msg = 'Import ไม่ได้ ' + result.msg;

                        $("#customDialog").customDialog({ title: 'Import Data', height:100, mesg: msg, showButton: false });
                        
                    }
                    $("#btnImport").attr('disabled', false).addClass('ui-state-disabled');
                    }catch(e){
                    alert(xhr.responseText);
                    }
                }
            });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:Literal ID="Require_var" runat="server"></asp:Literal>
    <div>
        <div class="ui-widget-content">
            <div class="ui-widget ui-widget-header" style="height: 30px; padding: 4px 10px;">
                <div style="float: left; font-size: 14px;">
                    <div class="icon-mod-importexport" style="float: left; width: 32px; height: 32px;
                        margin-right: 4px;">
                    </div>
                    <div style="float: left;">
                        <div style="margin: 2px 0 0 2px;">
                            <asp:Label ID="lblModImportExportMac" runat="server" Text="Import / Export pRoMiSeData"></asp:Label></div>
                        <div style="height: 4px; font-size: 11px; font-weight: lighter;">
                            <asp:Label ID="lblModImportExportMacDescript" runat="server" Text=""></asp:Label></div>
                    </div>
                </div>
                <div style="float: right;">
                </div>
                <div style="clear: both; height: 1px;">
                    &nbsp;</div>
            </div>
            <div style="margin: 8px 4px;">
                <table class="paramlist admintable" cellspacing="1" width="100%">
                    <tbody>
                        <tr>
                            <td class="paramlist_key" style="white-space:nowrap;">
                                <label for="FileUpload1" style="font-weight: bold;">
                                    เลือกตำแหน่งของไฟล์</label>
                            </td>
                            <td style="white-space:nowrap;">
                                <asp:FileUpload ID="FileUpload1" runat="server" class="" Style="width: 280px;" />
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"
                                    Style="width: 80px;" />
                            </td>
                            <td style="white-space:nowrap; text-align:right;">
                <button type="button" id="btnImport" onclick="importMac();" style="width: 80px;">
                    Import</button>
                <button type="button" id="btnExport" style="width: 80px;">
                    Export</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <script type="text/javascript">
                    if ($("#FileUpload1").val() == '')
                        $("#btnUpload").attr('disabled', true).addClass('ui-state-disabled');

                    $("#FileUpload1").change(function() {
                        if ($(this).val() == '')
                            $("#btnUpload").attr('disabled', true).addClass('ui-state-disabled');
                        else
                            $("#btnUpload").attr('disabled', false).removeClass('ui-state-disabled');
                    });
                </script>

                <script type="text/javascript">
                    $("#btnExport").click(function() {
                        window.open('ExportMacData.aspx?LangID=' + require_var.langId + '&StaffID=' + require_var.staffId, 'exportWindow', 'location=1,status=1,scrollbars=1');
                    });
                </script>

            </div>
        </div>
        <div style="margin-top:4px;">
            <table id="theGrid">
            </table>
            <div id="pager">
            </div>

            <script type="text/javascript">
                $("#theGrid").jqGrid({
                    jsonReader: {
                        repeatitems: false,
                        root: "rows",
                        total: "total",
                        page: "page",
                        records: "records",
                        cell: "",
                        id: "0"
                    },
                    url: 'DataXML/ImportExportMacData.aspx?action=macv&StaffID=' + require_var.staffId + '&LangID=' + require_var.langId,
                    datatype: 'json',
                    colNames: ["No", "InvoiceNo", "VendorCode", "DocDate", "ShopID", "MaterialCode", "Qty", "PricePerUnit", "ItemDiscount", "VatType"],
                    colModel: [{ "name": "id", "index": "id", "jsonmap": "id", "width": 10, "align": "center", "sortable": false },
                                        { "name": "invoiceno", "index": "invoiceno", "jsonmap": "invoiceno", "width": 30 },
                                        { "name": "vendorcode", "index": "vendorcode", "jsonmap": "vendorcode", "width": 70 },
                                        { "name": "docdate", "index": "docdate", "jsonmap": "docdate", "width": 30 },
                                        { "name": "shopid", "index": "shopid", "jsonmap": "shopid", "width": 30, "align": "center" },
                                        { "name": "materialcode", "index": "materialcode", "jsonmap": "materialcode", "width": 50 },
                                        { "name": "qty", "index": "qty", "jsonmap": "qty", "width": 20, "align": "right" },
                                        { "name": "priceperunit", "index": "priceperunit", "jsonmap": "priceperunit", "width": 30, "align": "right" },
                                        { "name": "itemdiscount", "index": "itemdiscount", "jsonmap": "itemdiscount", "width": 30, "align": "right" },
                                        { "name": "vattype", "index": "vattype", "jsonmap": "vattype", "width": 30, "align": "right"}],
                    pager: '#pager',
                    autowidth: true,
                    height: 400, rowNum: -1,
                    viewrecords: true, pgbuttons: false,
                    pgtext: null,
                    caption: 'รายการวัตถุดิบ',
                    gridComplete: function() {
                        var records = $(this).jqGrid('getGridParam', 'records');
                        $(this).jqGrid('setCaption', 'แสดงข้อมูลที่อยู่ใน TextFile มีจำนวนทั้งหมด ' + records + ' แถว');
                        if (records > 0) {
                            $("#btnImport").attr('disabled', false).removeClass('ui-state-disabled');
                        } else {
                            $("#btnImport").attr('disabled', true).addClass('ui-state-disabled');
                        }
                    }
                }).jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, refresh: false, search: false });
                $(window).bind('resize', function() {
                    $("#theGrid").setGridWidth($(window).width() - 2);
                }).trigger('resize');
            </script>

            <div style="clear: both; height: 1px">
                &nbsp;</div>
        </div>
    </div>
    <div id="customDialog" style="display: none;">
    </div>
    <div id="loading" style="display: none; text-align: center;">
        <div style="margin-left: 8px;" class="ui-state-highlight">
            <strong>กำลัง Import File...</strong>
        </div>
    </div>
    </form>
</body>
</html>
