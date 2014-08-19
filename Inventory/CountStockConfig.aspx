<%@ page language="C#" autoeventwireup="true" inherits="Inventory_CountStockConfig, App_Web_countstockconfig.aspx.9758fd70" enableEventValidation="false" %>

<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stock count config.</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/Default.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .ddl
        {
            width: 120px;
            margin-right: 4px;
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
    </style>
    <link href="../scripts/jquery.jqGrid-3.8/css/ui.jqgrid.css" rel="stylesheet" />
    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>
    <script src="../scripts/jquery.jqGrid-3.8/grid.locale-en.js" type="text/javascript"></script>
    <script src="../scripts/jquery.jqGrid-3.8/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../scripts/stockcount-util.js"></script>
    <script type="text/javascript">
        var materialData;
        var isSetting = false;
        $(function() {

        ajaxWorkingCallback(
            function(){
                    $("#btnDisplayMaterial").attr('disabled', true).addClass('ui-state-disabled');
                    $("#btnSave").attr('disabled', true).addClass('ui-state-disabled');
                },
                function() {
                    $("#btnDisplayMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                    $("#btnSave").attr('disabled', false).removeClass('ui-state-disabled');
            });


            //-- init button
            $("#btnCloaseSaveStatusDialog").button({
                icons: {
                    primary: 'icon-btn-cancel'
                }
            });

            $("#btnDisplayMaterial").button({
                icons: {
                    primary: ' icon-action-table-display'
                }
            }).click(function() {
                bindGrid();
            });
            $("#btnSave").button({
                icons: {
                    primary: ' icon-action-save'
                }
            }).attr('disabled', true).addClass('ui-state-disabled');
            $("#btnCancel").button({
                icons: {
                    primary: ' icon-action-cancel'
                }
            });

            $("#btnSave").click(function() {
                prepareDataToSaveConfig();
            });
            $("#slInv").change(function() {
                //loadCountingType();
                bindGrid();
            });
            $("#slCoutingType").change(function() {
                //loadMaterialGroup();
                bindGrid();
            });
            $("#slMaterialGroup").change(function() {
                loadMaterialDept();
            });
            $("#slMaterialDept").change(function() {
                bindGrid();
            });

            loadInv(function() {
                loadCountingType(function() {
                    loadMaterialGroup();
                }, function() {

                });
            }, function() {

            });

            //initGrid();
        });

        function loadInv(successFunc, errorFunc) {
            $.ajax({
                url: 'DataXML/CountStockConfigXML.aspx?action=loadInv&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                complete: function(xhr, status) {
                    //alert(xhr.responseText);
                },
                success: function(result) {
                    if (result.sess_timeout && result.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    var slInv = $("#slInv");
                    var optSlInv = "";
                    for (var i = 0; i < result.invList.length; i++) {
                        var invList = result.invList[i];
                        $.each(invList, function(index, item) {
                            optSlInv += '<option value="' + index + '">' + item + '</option>';
                        });
                    }
                    slInv.html(optSlInv).val(require_var.dbShopId);
                    successFunc();
                },
                error: function(xhr, status) {
                alert('error' + xhr.responseText);
                    
                }
            });
        }

        function loadCountingType(successFunc, errorFunc) {
            $.ajax({
                url: 'DataXML/CountStockConfigXML.aspx?action=loadCountingType&inv=' + $('#slInv :selected').val() +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                /*complete: function(xhr, status) {
                alert(xhr.responseText);
                },*/
                success: function(result) {
                    if (result.sess_timeout && result.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    var slCountType = $("#slCoutingType");
                    var optSlCountType = "";
                    for (var i = 0; i < result.countingTypeList.length; i++) {
                        var countingTypeList = result.countingTypeList[i];
                        $.each(countingTypeList, function(index, item) {
                            optSlCountType += '<option value="' + index + '">' + item + '</option>';
                        });
                    }
                    slCountType.html(optSlCountType);
                    successFunc();
                },
                error: function(xhr, status) {
                    alert('error' + xhr.responseText);
                }
            });
        }

        function loadMaterialGroup() {
            $.ajax({
                url: 'DataXML/CountStockConfigXML.aspx?action=loadMaterialGroup&inv=' + $('#slInv :selected').val() +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                complete: function(xhr, status) {
                    //alert(xhr.responseText);
                },
                success: function(result) {
                    //console.log(JSON.stringify(result));
                    if (result.sess_timeout && result.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    var slMaterialGroup = $("#slMaterialGroup");
                    var optSlMaterialGroup = "";
                    var count = 0;
                    for (var i = 0; i < result.materialGroupList.length; i++) {
                        var materialGroupList = result.materialGroupList[i];
                        $.each(materialGroupList, function(index, item) {
                            var opt = '<option value="' + index + '">' + item + '</option>';
                            //if (count == 1)
                            //    opt = '<option value="' + index + '" selected="selected">' + item + '</option>';
                            optSlMaterialGroup += opt;
                            count++;
                            //console.log(count);
                        });
                    }
                    //console.log(optSlMaterialGroup);
                    slMaterialGroup.html(optSlMaterialGroup);

                    //slMaterialGroup.val('1');
                    loadMaterialDept();
                },
                error: function(xhr, status) {
                    alert('error' + xhr.responseText);
                }
            });
        }

        function loadMaterialDept() {
            $.ajax({
                url: 'DataXML/CountStockConfigXML.aspx?action=loadMaterialDept&matGroupId=' +
                $("#slMaterialGroup :selected").val() + '&inv=' + $('#slInv :selected').val() +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                /*complete: function(xhr, status) {
                alert(xhr.responseText);
                },*/
                success: function (result) {
                    if (result.sess_timeout && result.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    var slMaterialDept = $("#slMaterialDept");
                    var optSlMaterialDept = "";

                    for (var i = 0; i < result.materialDeptList.length; i++) {
                        var materialDeptList = result.materialDeptList[i];
                        $.each(materialDeptList, function (index, item) {
                            optSlMaterialDept += '<option value="' + index + '">' + item + '</option>';
                        });
                    }
                    slMaterialDept.html(optSlMaterialDept);
                    // slMaterialDept.val('1');

                    bindGrid();
                },
                error: function (xhr, status) {
                    alert('error' + xhr.responseText);
                }
            });
        }

        function initGrid() {
          
        }

        function bindGrid() {
            //console.log('invid ' + $('#slInv :selected').val());
            var url = 'DataXML/CountStockConfigXML.aspx?action=listMaterial&inv=' + $('#slInv :selected').val() +
                '&matGroupId=' + $("#slMaterialGroup :selected").val() + '&matDeptId=' + $("#slMaterialDept :selected").val() +
                '&countingType=' + $("#slCoutingType :selected").val() +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId;
            $("#theGrid").jqGrid('setGridParam', { url: url }).trigger('reloadGrid');
            //            $.ajax({
            //                url: 'DataXML/CountStockConfigXML.aspx?action=listMaterial&inv=' + $('#slInv :selected').val() +
            //                '&matGroupId=' + $("#slMaterialGroup :selected").val() + '&matDeptId=' + $("#slMaterialDept :selected").val() +
            //                '&countingType=' + $("#slCoutingType :selected").val(),
            //                //type: 'GET',
            //                complete: function(xhr, status) {

            //                    var theGrid = $("#theGrid")[0];
            //                    theGrid.addXmlData(xhr.responseXML);

            //                    var records = $("#theGrid").jqGrid('getGridParam', 'records');
            //                    for (var i = 1; i <= records; i++) {
            //                        var rowData = $("#theGrid").jqGrid('getRowData', i);
            //                        alert(rowData.MaterialConfig);
            //                        if (rowData.MaterialConfig > 0) {
            //                            $("#theGrid").jqGrid('setSelection', i);
            //                        }
            //                    }
            //                },
            //                error: function(xhr, status) {
            //                    //alert('error');
            //                }
            //            });
        }

        function prepareDataToSaveConfig() {
            var rowChecked = $("#theGrid").jqGrid('getGridParam', 'selarrrow');
            var numRow = 0;
            var saveParam = '{"StockCountData" : [';
            for (var i = 0; i < rowChecked.length; i++) {
                var rowData = $("#theGrid").jqGrid('getRowData', rowChecked[i]);
                if (rowData.MaterialID != undefined)
                    saveParam += '{"MaterialId":"' + rowData.MaterialID + '"}';

                if (i < rowChecked.length - 1)
                    saveParam += ',';
            }
            saveParam += ']}';

            saveCountConfig(saveParam);
        }

        function saveCountConfig(saveParam) {
            $.ajax({
                url: 'DataXML/CountStockConfigXML.aspx?action=save&inv=' + $('#slInv :selected').val() +
                '&matGroupId=' + $("#slMaterialGroup :selected").val() + '&matDeptId=' + $("#slMaterialDept :selected").val() +
                '&countingType=' + $("#slCoutingType :selected").val() +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId,
                datatype: 'xml',
                type: 'POST',
                data: "saveParam=" + escape(saveParam),
                cache: false,
                complete: function(xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");

                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    if (data.status == '1') {
                        $('#btnDisplayMaterial').attr('disabled', false).removeClass('ui-state-disabled');

                        $("#alert_msg").text('<%=lbl_3_2.Text %>');
                        alertDialog();
                    } else {
                        $("#alert_msg").text('<%=lbl_3_3.Text %>');
                        alertDialog();
                    }
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="require_var" runat="server" style="display: none;">
    </div>
   
    <div id="loading" style="display: none; overflow: hidden;">
        <div style="margin-left: 8px;" class="ui-widget">
            <img src="../Images/loadingSmall.gif" alt="" style="margin-right:2px;" /><asp:Label ID="lbl_3_4" runat="server" Text="รอสักครู่..." Style="font-size: 14px;
                color: #333; font-family: Segoe UI, Tahoma, Arial;"></asp:Label>
        </div>
    </div>
    <div style="display: none;" id="saveStatusDialog" title="บันทึกการตั้งค่านับสต๊อก">
        <div style="margin: 4px;">
            <span id="saveStatusText" style="color: #333; font-size: 1.2em; font-weight: bold;">
                บันทึกการตั้งค่านับสต๊อกสำเร็จ.</span>
        </div>
        <div style="margin: 4px; text-align: right;">
            <button type="button" id="btnCloaseSaveStatusDialog" onclick="javascript:$('#saveStatusDialog').dialog('close');"
                style="width: 70px;">
                Close</button>
        </div>
    </div>
    <div class="ui-widget-header" style="height: 30px; padding: 4px 10px;">
        <div style="font-size: 14px;">
            <div class="icon-config-counting-stock" style="float: left; width: 32px; height: 32px;
                margin-right: 4px;">
            </div>
            <div style="float: left;">
                <div style="margin: 2px 0 0 2px;">
                    <asp:Label ID="lbl_1_1" runat="server" Text="ตั้งค่าการนับสต๊อก"></asp:Label></div>
                <div style="height: 4px; font-size: 11px; font-weight: lighter;">
                    <asp:Label ID="lbl_1_2" runat="server" Text="ตั้งค่าสินค้าที่ต้องการนับสต๊อก สำหรับการนับสต๊อกรายวัน รายสัปดาห์ รายเดือน"></asp:Label>
                </div>
            </div>
            <div style="float: right;">
                <div style="float: left;">
                    <button id="btnSave" type="button" style="margin-right: 2px; width: 100px;" class="btn">
                        <asp:Label ID="lbl_2_2" Text="บันทึก" runat="server" class="btn"></asp:Label></button>
                </div>
            </div>
        </div>
    </div>
    <div style="margin: 8px 4px;">
        <div class="ui-widget-content" style="margin: 4px 0;">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tbody>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_3" runat="server" Text="คลัง" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td>
                            <select id="slInv" class="sl-minwidth">
                            </select>
                        </td>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_5" Text="เลือกกลุ่มวัตถุดิบ" runat="server" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td>
                            <select id="slMaterialGroup" class="sl-minwidth">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_4" runat="server" Text="รูปแบบการนับ" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td>
                            <select id="slCoutingType" class="sl-minwidth">
                            </select>
                        </td>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_6" Text="เลือกหมวดวัตถุดิบ" runat="server" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td style="white-space: nowrap;">
                            <select id="slMaterialDept" class="sl-minwidth">
                            </select>
                            <button id="btnDisplayMaterial" type="button" style="margin-right: 2px;" class="btn">
                                <asp:Label ID="lbl_2_1" Text="แสดงข้อมูล" runat="server" class="btn"></asp:Label></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div style="clear: both; height: 1px;">
            &nbsp;</div>
        <div>
            <table id="theGrid">
            </table>
            <div id="pager">
            </div>
            <script type="text/javascript">
                var url = 'DataXML/CountStockConfigXML.aspx?action=listMaterial&inv=' + $('#slInv :selected').val() +
                '&matGroupId=' + $("#slMaterialGroup :selected").val() + '&matDeptId=' + $("#slMaterialDept :selected").val() +
                '&countingType=' + $("#slCoutingType :selected").val() +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole + '&langId=' + require_var.langId;
                
                var grid = $("#theGrid");
                $("#theGrid").jqGrid({
                    datatype: 'xml',
                    url: url,
                    colNames: ['<%=lbl_4_1.Text %>', 'MaterialID', '<%=lbl_4_2.Text %>', '<%=lbl_4_3.Text %>', '<%=lbl_4_4.Text %>', '<%=lbl_4_5.Text %>', 'materialConfig'],
                    colModel: [
                { name: 'id', index: 'id', hidden: true },
                { name: 'MaterialID', index: 'MaterialID', width: 10, hidden: true },
   		        { name: 'MaterialCode', index: 'MaterialCode', width: 20, sortable:false },
   		        { name: 'MaterialList', index: 'MaterialList', width: 40, sortable: false },
                { name: 'MaterialGroupName', index: 'MaterialGroupName', width: 10, sortable: false },
                { name: 'MaterialDeptName', index: 'MaterialDeptName', width: 10, sortable: false },
                { name: 'MaterialConfig', index: 'MaterialConfig', hidden: true }
   	            ],
                    rowNum: 100000,
                    autowidth: true,
                    height: 400,
                    pager: '#pager',
                    pgbuttons: false,
                    pgtext: null,
                    loadui: 'disable',
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
                    viewrecords: true,
                    caption: '<%=lbl_4_6.Text %>',
                    gridComplete: function() {
                        var records = $("#theGrid").jqGrid('getGridParam', 'records');
                        //if (records > 900)
                        //    $("#slMaterialGroup").val(1);

                        for (var i = 1; i <= records; i++) {
                            var gridData = $("#theGrid").jqGrid('getRowData', i);
                            if (gridData.MaterialConfig > 0) {
                                //alert(gridData.MaterialConfig);
                                $("#theGrid").jqGrid('setSelection', i);
                            }
                        }

                        // enable save button if row data > 0
                        if (records > 0) {
                            $("#btnSave").attr("disabled", false).removeClass('ui-state-disabled');
                        }
                    }
                });
                jQuery("#theGrid").jqGrid('navGrid', "#pager", { edit: false, add: false, del: false, search: false });
                $(window).bind('resize', function() {
                    $("#theGrid").setGridWidth($(window).width() - 10);
                }).trigger('resize');

                function alertDialog() {
                    $("#dialog_alert").dialog({
                        dialogClass: 'dialogWithDropShadow noTitleStuff ',
                        modal: true,
                        width: 'inherit',
                        height: 110,
                        buttons: {
                            'Close': function() {
                                $(this).dialog("close");
                            }
                        }
                    });
                }
            </script>
        </div>
    </div>
    <div style="display:none; width:auto; overflow:hidden;" id="dialog_alert">
        <p>
            <span id="dialog_alert_icon" class="ui-icon ui-icon-check" style="float: left; margin: 0 7px 20px 0;"></span>
            <span id="alert_msg" style="font-size:1.1em;"></span>
        </p>
    </div>
    <asp:Label ID="lbl_3_1" runat="server" Text="บันทึกการตั้งค่า" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_2" runat="server" Text="บันทึกการตั้งค่าสำเร็จ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_3" runat="server" Text="บันทึกการตั้งค่าล้มเหลว" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_1" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_2" runat="server" Text="รหัสวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_3" runat="server" Text="ชื่อวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_4" runat="server" Text="กลุ่มวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_5" runat="server" Text="หมวดวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_6" runat="server" Text="รายการวัตถุดิบ" Style="display: none;"></asp:Label>
    <div style="text-align: center;">
        <uc1:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
