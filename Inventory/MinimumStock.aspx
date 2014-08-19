<%@ page language="C#" autoeventwireup="true" inherits="Inventory_MinimumStock, App_Web_minimumstock.aspx.9758fd70" enableEventValidation="false" %>

<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Minimum Stock</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/Default.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="../css/menu.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            min-width: 1024px;
        }
        .noTitleStuff .ui-dialog-titlebar
        {
            display: none;
        }
    </style>
    <link href="../scripts/jquery.jqGrid-3.8/css/ui.jqgrid.css" rel="stylesheet" />
    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>
    <script src="../scripts/modal.js" type="text/javascript"></script>
    <script src="../scripts/menu.js" type="text/javascript"></script>
   <script src="../scripts/jquery.jqGrid-3.8/grid.locale-en.js" type="text/javascript"></script>

    <script src="../scripts/jquery.jqGrid-3.8/jquery.jqGrid.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../scripts/regexNonNumeric.js"></script>
    <script type="text/javascript">
        $(function () {
            // button
            $("#btnPrintForm").button({
                icons: {
                    primary: ' icon-action-print'
                }
            }).click(function () {
                print_dialy =
                window.open('Report/CrMinimumStock.aspx?invName=' + $('#<%=ddlInv.ClientID %> :selected').text() + '&LangID=' + require_var.langId + '', '', 'location=1,status=1,scrollbars=1');
            }); //.attr('disabled', true).addClass('ui-state-disabled');

            $('#btnExcel').button({
                icons: {
                    primary: ' icon-export-xls'
                }
            }).attr('disabled', true).addClass('ui-state-disabled');

            $("#btnDisplayMinStock").button({
                icons: {
                    primary: ' icon-action-table-display'
                }
            }).click(function () {
                loadData();
            });

            initGrid();
        });

        function loadData() {
            /*$("#theGrid").jqGrid('setGridParam', { url: 'DataXML/MinimumStockDataXML.aspx?action=load&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() });
            $("#theGrid").jqGrid().trigger('reloadGrid');*/
            $.ajax({
                url: 'DataXML/MinimumStockDataXML.aspx?action=load&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'xml',
                type: 'GET',
                complete: function (xhr, status) {
                    var theGrid = $("#theGrid")[0];
                    theGrid.addXmlData(xhr.responseXML);
                }
            });
        }

        function initGrid() {
            $("#theGrid").jqGrid({
                url: 'DataXML/MinimumStockDataXML.aspx?action=load&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                datatype: 'xml',
                colNames: ['<%=lbl_4_1.Text %>', '<%=lbl_4_2.Text %>', '<%=lbl_4_3.Text %>', '<%=lbl_4_4.Text %>', '<%=lbl_4_5.Text %>', '<%=lbl_4_6.Text %>'],
                colModel: [{ name: 'id', index: 'idx', width: 10, hidden: false, sortable: false, align: 'right' },
                { name: 'mcode', index: 'code', width: 50, sortable: false },
                { name: 'mname', index: 'name', width: 100, sortable: false },
                { name: 'mamount', index: 'amount', width: 30, align: 'right', sortable: false },
                { name: 'mcurrentamount', index: 'currentamount', width: 30, align: 'right', sortable: false },
                { name: 'munit', index: 'unit', width: 30, sortable: false, align: 'center' }
                ],
                pager: '#pager',
                rowNum: -1,
                pgbuttons: false,
                pgtext: null,
                autowidth: true,
                viewrecords: true,
                height: 400,
                caption: '',
                gridComplete: function() {
                    var record = $(this).jqGrid('getGridParam', 'records');
                    $(this).jqGrid('setCaption', '<%=lbl_4_7.Text %> ' + $('#<%=ddlInv.ClientID %> :selected').text());
                }, loadComplete: function(data) {
                    if ($(this).jqGrid('getDataIDs') == 0) {
                        //alert('<%=lbl_3_2.Text %>');
                    } else {
                        $("#btnExcel").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#btnPrintForm").attr('disabled', false).removeClass('ui-state-disabled');
                    }
                }
            });
            $("#theGrid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false, refresh: false });

            //-- resize grid when resize browser
            $(window).bind('resize', function () {
                $("#theGrid").setGridWidth($(window).width() - 12);
            }).trigger('resize');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="display:none;" id="require_var" runat="server"></div>
    <div>
        <div class="ui-widget ui-widget-header" style="height: 30px; padding: 4px 10px;">
            <div style="float: left; font-size: 14px;">
                <div class="icon-minimum-stock" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
                </div>
                <div style="float: left;">
                    <div style="margin: 2px 0 0 2px;">
                        <asp:Label ID="lbl_1_1" runat="server" Text="ค่าต่ำสุดสต๊อก"></asp:Label></div>
                    <div style="height: 4px; font-size: 11px; font-weight: lighter;">
                        <asp:Label ID="lbl_1_2" runat="server" Text="แสดงรายการวัตถุดิบที่มีจำนวนน้อยกว่าค่าต่ำสุดที่ได้ตั้งไว้"></asp:Label></div>
                </div>
            </div>
            <div style="float: right;">
                <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
                <button id="btnPrintForm" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_1" Text="พิมพ์ฟอร์ม" runat="server" class="btn"></asp:Label></button>
                <asp:Button ID="btnExportExcel" runat="server" Text="Export Excel" OnClick="ExportExcelClick" style="display:none;" />
                <button id="btnExcel" type="button" onclick="document.getElementById('form1').__EVENTTARGET.value = 'BtnExportExcel';
                    document.getElementById('form1').submit();">Export Excel</button>
            </div>
            <div style="clear: both; height: 1px;">
                &nbsp;</div>
        </div>
        <div style="margin: 8px 4px;">
            <div class="ui-widget-content">
                <table class="paramlist admintable" cellspacing="1" width="100%">
                    <tbody>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_3" runat="server" Text="คลัง"></asp:Label>
                            </td>
                            <td style="width: 205px;">
                                <asp:DropDownList ID="ddlInv" runat="server" Style="width: 200px;">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <button id="btnDisplayMinStock" type="button" style="margin-right: 2px; width: 110px;"
                                    class="btn">
                                    <asp:Label ID="lbl_2_2" Text="แสดงข้อมูล" runat="server" class="btn"></asp:Label></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <script type="text/javascript">
                $('#<%=ddlInv.ClientID %>').val(require_var.dbShopId);
            </script>
            <div style="margin: 4px 0;">
                <table id="theGrid">
                </table>
                <div id="pager">
                </div>
                <div style="text-align: center;">
                    <uc1:Footer ID="Footer1" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <div id="loading" style="display: none; text-align: center">
        <div style="margin-left: 8px;" class="ui-state-error">
            <span style="font-size: 14px; color: #333; font-family: Segoe UI, Tahoma, Arial;">
                <asp:Label ID="lbl_3_1" runat="server" Text="รอสักครู่..."></asp:Label></span>
        </div>
    </div>
    <asp:Label ID="lbl_3_2" runat="server" Text="No data found." Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_1" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_2" runat="server" Text="Code" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_3" runat="server" Text="Name" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_4" runat="server" Text="Minimum Qty" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_5" runat="server" Text="Current Qty" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_6" runat="server" Text="Unit" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_7" runat="server" Text="Product list" Style="display: none;"></asp:Label>
    </form>
</body>
</html>
