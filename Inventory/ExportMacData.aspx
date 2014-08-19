<%@ page language="C#" autoeventwireup="true" inherits="Inventory_ExportMacData, App_Web_exportmacdata.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/Default.css" rel="Stylesheet"/>
    <link href="../css/icon.css" rel="stylesheet" />
    <link href="../scripts/jquery.jqGrid-3.8/css/ui.jqgrid.css" rel="stylesheet" />
    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
            font-family: Arial, Tahoma;
            font-size:12px;
        }
         .noTitleStuff .ui-dialog-titlebar
        {
            display: none;
        }
        .dialogWithDropShadow
         {
             -webkit-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5);  
             -moz-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5); 
         }
        .bigButton
        {
            width: 150px;
            height: 70px;
        }
    </style>

    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="../scripts/stockcount-util.js"></script>

    <script type="text/javascript" src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>

    <script type="text/javascript" src="../scripts/jquery.jqGrid-3.8/grid.locale-en.js"></script>

    <script type="text/javascript" src="../scripts/jquery.jqGrid-3.8/jquery.jqGrid.min.js"></script>

    <script type="text/javascript">
        function ajaxSearchBatch(action) {
            ajaxWorking();
                $("#theGrid").jqGrid('setGridParam', {
                    url: 'DataXML/ImportExportMacData.aspx?action=' + action + '&StaffID=' + require_var.staffId +
                    '&LangID=' + require_var.langId + 
                    '&d='+ $('#ddlDay :selected').val() +
                    '&m='+ $('#ddlMonth :selected').val() +
                    '&y=' + $('#ddlYear :selected').val() +
                    '&dt='+ $('#ddlDayTo :selected').val() +
                    '&mt='+ $('#ddlMonthTo :selected').val() +
                    '&yt=' + $('#ddlYearTo :selected').val()
                }).trigger('reloadGrid');
        }

        $(function () {
            $("#btnExportFran").click(function () {
                var action = $("input[name='exportFranchise']:checked").val();
                ajaxSearchBatch(action);
            });
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" name ="__EVENTTARGET" value =""/>
        <input type="hidden" name ="__EVENTARGUMENT" value="" />
        <asp:Literal ID="Require_var" runat="server"></asp:Literal>
       <div id="loading" style="display: none; overflow: hidden;">
        <div style="margin-left: 8px;">
             <img src="../Images/loadingSmall.gif" alt="" style="margin-right:2px;" />
            <asp:Label runat="server" Text="กำลังทำงาน..." Style="font-size: 14px;
                color: #333; font-family: Segoe UI, Tahoma, Arial;"></asp:Label>
        </div>
    </div>
        <div>
            <div class="ui-widget ui-widget-header" style="height: 30px; padding: 4px 10px;">
                <div style="float: left;">
                    <div class="icon-mod-importexport" style="float: left; width: 32px; height: 32px;
                        margin-right: 4px;">
                    </div>
                    <div style="float: left;">
                        <div style="margin: 2px 0 0 2px;">
                            <asp:Label ID="lblModExportMac" runat="server" Text="Export Data" Style="font-size: 16px;"></asp:Label></div>
                        <div style="height: 4px; font-size: 11px; font-weight: lighter;">
                            <asp:Label ID="lblModExportMacDescript" runat="server" Text=""></asp:Label></div>
                    </div>
                </div>
                <div style="float: right;">
                </div>
                <div style="clear: both; height: 1px;">
                    &nbsp;</div>
            </div>
            <div style="margin: 8px 5%;">
                <fieldset class="ui-widget ui-widget-content dialogWithDropShadow" style="border-radius:4px;">
                    <legend class="font-bold" style="background-color:#cbcbcb; padding:4px; border-radius:2px;">เลือกช่วงเวลา</legend><span>วันเริ่มต้น : </span>
                    <asp:DropDownList ID="ddlDay" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlMonth" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlYear" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp; <span>วันสิ้นสุด : </span>
                    <asp:DropDownList ID="ddlDayTo" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlMonthTo" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlYearTo" runat="server">
                    </asp:DropDownList>
                </fieldset>
            </div>
            <div style="margin: 2% 5%;">
                <div>
                    <fieldset class="ui-widget ui-widget-content dialogWithDropShadow" style="border-radius:4px;" >
                        <legend class="font-bold" style="background-color:#cbcbcb; padding:4px; border-radius:2px;">เลือกประเภทการ Export</legend>
                        <div style="margin:8px;">
                            <button type="button" onclick="ajaxSearchBatch('ExportTransfer');" class="bigButton">ใบเบิก</button>
                            <asp:Button ID="btnExportTransfer" runat="server" style="display:none" OnClick="ExportTransfer" />
                            <asp:Button ID="btnExportSale" runat="server" Text="ใบยอดขาย" class="bigButton" OnClick="ExportSale" />
                            <asp:Button ID="btnExportROBranch" runat="server" Text="ใบรับตรงของสาขา" class="bigButton"
                                OnClick="ExportROBranch" />
                        </div>
                        <div style="margin:8px;">
                        <fieldset class="ui-widget ui-widget-content" style="border-radius:4px;">
                            <legend class="font-bold" style="background-color:#cbcbcb; padding:4px; border-radius:2px;">Export เฟรนไชน์</legend>
                            <div style="margin:0 auto; text-align:center;">
                              <div style="float:left; margin:8px 4px 0 8px; text-align:left;">
                                  <div style="margin-bottom:8px;">
                                  <asp:RadioButton ID="rdoFranchiseTranfer" runat="server" GroupName="exportFranchise"
                                        Text="ดึงข้อมูลจากใบเบิก" Checked="true" />
                                    </div>
                                  <div>
                                    <asp:RadioButton ID="rdoFranchiseRequest" runat="server" GroupName="exportFranchise"
                                        Text="ดึงข้อมูลจากใบขอ" />
                                      </div>
                                  <div style="clear:both;">&nbsp;</div>
                              </div>
                                <div style="float:left;">
                                    <asp:Button ID="btnExportFranchise" runat="server" Text="ใบขอสินค้า(เฟรนไชน์)" class="bigButton"
                                        OnClick="ExportFranchise" style="display:none;" />
                                    <button id="btnExportFran" type="button" class="bigButton">ใบขอสินค้า(เฟรนไชน์)</button>
                                    
                                </div>
                                <div style="clear:both;">&nbsp;</div>
                            </div>
                        </fieldset>
                    </div>
                    </fieldset>
                </div>
                
            <div style="clear: both; height: 1px;">
                &nbsp;</div>
        </div>
    </div>
    <div id="batchDialog" style="display:none" title="รอบเอกสาร">
        <table id="theGrid"></table>
            <div id="pager"></div>
        <input type="checkbox" id="chkIncludeNotBatch"/>
        <label for="chkIncludeNotBatch" class="font-bold">รวมเอกสารที่ไม่อยู่ในรอบ</label>
         <script type="text/javascript">
             var grid = $("#theGrid");
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
                 url: 'nodata.json',
                 datatype: 'json',
                 colNames: ["#", "เลขที่เอกสาร", "วันที่เอกสาร", "หมายเหตุ", "DocBatchID", "DocBatchShopID"],
                 colModel: [{ name: "id", jsonmap: "id", width: 10, align: "center", sortable: false, hidden: true },
                           { name: "batchNumber", jsonmap: "BatchNumber", width: 50, sortable: false },
                           { name: "batchDate", jsonmap: "BatchDate", width: 30, sortable: false },
                           { name: "batchNote", jsonmap: "BatchNote", sortable: false },
                           { name: "docBatchId", jsonmap: "DocumentBatchID", hidden: true },
                           { name: "docBatchShopId", jsonmap: "DocumentShopID", hidden: true }],
                 pager: '#pager',
                 width: 650,
                 height: 400, rowNum: -1,
                 multiselect: true,
                 beforeSelectRow: function (rowid, e) {
                     if (e.srcElement.type == "checkbox") {
                         return true;
                     }
                     return false;
                 },
                 /* loadComplete: function() {
                 // we make all even rows "protected", so that will be not selectable
                 var cbs = $("tr.jqgrow > td > input.cbox:even", grid[0]);
                 cbs.attr("disabled", true);
                 },*/
                 beforeSelectRow: function (rowid, e) {
                     var cbsdis = $("tr#" + rowid + ".jqgrow > td > input.cbox:disabled", grid[0]);
                     if (cbsdis.length === 0) {
                         return true;    // allow select the row
                     } else {
                         return false;   // not allow select the row
                     }
                 },
                 onSelectAll: function (aRowids, status) {
                     if (status) {
                         // uncheck "protected" rows
                         var cbs = $("tr.jqgrow > td > input.cbox:disabled", grid[0]);
                         cbs.removeAttr("checked");

                         //modify the selarrrow parameter
                         grid[0].p.selarrrow = grid.find("tr.jqgrow:has(td > input.cbox:checked)")
                 .map(function () { return this.id; }) // convert to set of ids
                .get(); // convert to instance of Array
                     }
                 },
                 viewrecords: true, pgbuttons: false,
                 pgtext: null,
                 //gridComplete: function () {

                 //},
                 loadError: function (xhr, status) {
                     /*
                     $("#errDialog").find('p').html(xhr.responseText);
                     $("#errDialog").dialog({
                         dialogClass: 'dialogWithDropShadow',
                         modal: true,
                         width: 'inherit',
                         buttons: {
                             'Close': function () {
                                 $(this).dialog('close');
                             }
                         }
                     });
                     */
                 },
                 loadComplete: function (data) {
                     if (data != null) {
                         //alert(data.action);
                         if (data.rows.length > 0) {
                             // chear checkbox
                             $('#chkIncludeNotBatch').removeAttr('checked');

                             $("#batchDialog").dialog({
                                 dialogClass: 'dialogWithDropShadow',
                                 modal: true,
                                 width: 'inherit',
                                 buttons: {
                                     'ตกลง': function () {
                                         var rowChecked = $("#theGrid").jqGrid('getGridParam', 'selarrrow');
                                         var numRow = 0;
                                         var saveParam = '{"batchList" : [';
                                         for (var i = 0; i < rowChecked.length; i++) {
                                             var rowData = $("#theGrid").jqGrid('getRowData', rowChecked[i]);
                                             if (rowData.docBatchId != undefined)
                                                 saveParam += '{"docBatchId":' + rowData.docBatchId + ', "docBatchShopId":' + rowData.docBatchShopId + '}';

                                             if (i < rowChecked.length - 1)
                                                 saveParam += ',';
                                         }
                                         saveParam += '], includeNotBatch:' + $('#chkIncludeNotBatch').is(':checked');
                                         saveParam += '}';

                                         document.getElementById('form1').__EVENTTARGET.value = data.action;
                                         document.getElementById('form1').__EVENTARGUMENT.value = saveParam;
                                         document.getElementById('form1').submit();

                                         $(this).dialog("close");
                                     },
                                     'ยกเลิก': function () {
                                         $(this).dialog('close');
                                     }
                                 }
                             });
                         } else {
                             document.getElementById('form1').__EVENTTARGET.value = data.action;
                             document.getElementById('form1').submit();
                         }
                     }
                 }
             }).jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, refresh: false, search: false });

            </script>
    </div>
       
        <div style="display:none;" id="errDialog" title="Error">
            <p></p>
        </div>
    </form>
</body>
</html>
