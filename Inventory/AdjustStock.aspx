<%@ page language="C#" autoeventwireup="true" inherits="Inventory_AdjustStock, App_Web_adjuststock.aspx.9758fd70" enableEventValidation="false" %>

<%@ Register Src="../UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Adjust Stock</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/Default.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .txt
        {
            padding: 0px;
            height: 20px;
            font-family: Tahoma, Arial;
            font-size: 1.2em !important;
        }
        .select
        {
            font-family: Tahoma, Arial;
            font-size: 1.2em !important;
        }
        .noTitleStuff .ui-dialog-titlebar
        {
            display: none;
        }
        .style1
        {
            height: 28px;
        }
    </style>
    <link href="../scripts/jquery.jqGrid-3.8/css/ui.jqgrid.css" rel="stylesheet" />

    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>

    <script src="../scripts/jquery.jqGrid-4.3.0/js/i18n/grid.locale-en.js" type="text/javascript"></script>

    <script src="../scripts/jquery.jqGrid-4.3.0/js/jquery.jqGrid.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../scripts/regexNonNumeric.js"></script>

    <script type="text/javascript">
        var docStatus = 1;
        var documentId = 0;
        $(function() {
            loadDataJson();
            adjStockGrid();
            searchMaterialGrid();
        });

        function loadWorkingDocument() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadWorkingDocument&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
            '&adjDocTypeId=' + $("#slAdjDocType :selected").val() + '&documentId=' + documentId +
            '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'xml',
                type: 'GET',
                complete: function(xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");
                    if (data.working == 1) {
                        //disable button
                        $('#<%=ddlInv.ClientID %>').attr('disabled', true).addClass('ui-state-disabled');
                        $('#slAdjType').attr('disabled', true).addClass('ui-state-disabled');
                        $('#slAdjDocType').attr('disabled', true).addClass('ui-state-disabled');
                        $("#txtAdjDate").attr('disabled', true).addClass('ui-state-disabled').datepicker('disable');

                        //$("#btnAdjustStock").attr('disabled', true).addClass('ui-state-disabled');
                        $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#btnSearchMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#txtMaterialCode").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#txtAmount").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#slUnit").attr('disabled', false).removeClass('ui-state-disabled');
                        loadAdjDocDetail();
                        loadAddReduceDocumentData();
                    } else {
                        $("#btnAdjustStock").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#adjGrid").jqGrid('clearGridData');
                    }
                }
            });
        }

        function loadDataJson() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadDataJson&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
            '&adjType=' + $("#slAdjType :selected").val() + '&documentId=' + documentId +
             '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                complete: function(xhr, status) {
                    try {
                        var data = eval('(' + xhr.responseText + ')');

                        var txtAdjDate = $("#txtAdjDate");
                        var slAdjDocType = $("#slAdjDocType");
                        var slSearchAddReduceDocType = $("#slSearchAddReduceDocType");
                        var slSearchAddReduceDocument = $("#slSearchAddReduceDocument");
                        var optAdjDocType = '';
                        $.each(data.adjDocType[0], function(index, item) {
                            optAdjDocType += '<option value="' + index + '">' + item + '</option>';
                        });
                        slAdjDocType.html(optAdjDocType);
                        slSearchAddReduceDocType.html(optAdjDocType);
                        txtAdjDate.val(data.adjDate);
                        $("#txtAddReduceStartDate").val(data.addReduceStartDate);
                        $("#txtAddReduceEndDate").val(data.addReduceEndDate);
                    } catch (e) {
                        alert(xhr.responseText);
                    }
                }
            });
        }

        function loadSearchDataJson() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadDataJson&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
            '&adjType=' + $("#slSearchAddReduceDocument :selected").val() + '&documentId=' + documentId +
            '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                success: function(data) {

                    var slSearchAddReduceDocType = $("#slSearchAddReduceDocType");
                    var optAdjDocType = '';
                    $.each(data.adjDocType[0], function(index, item) {
                        optAdjDocType += '<option value="' + index + '">' + item + '</option>';
                    });
                    slSearchAddReduceDocType.html(optAdjDocType);
                }, error: function(xhr, s) {
                    alert(xhr.readyState + ' ' + xhr.status + ' ' + s.msg);
                }
            });
        }

        function adjStockGrid() {
            var grid = $("#adjGrid");
            $("#adjGrid").jqGrid({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=load&documentId=' + documentId +
               '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                datatype: 'xml',
                colNames: [$('#<%=lbl_4_1.ClientID %>').text(), $('#<%=lbl_4_2.ClientID %>').text(), $('#<%=lbl_4_3.ClientID %>').text(), $('#<%=lbl_4_4.ClientID %>').text(), $('#<%=lbl_4_5.ClientID %>').text(), 'MaterialID', 'docDetailId', 'unitLargeId', 'docDetailIdx'],
                colModel: [
                { name: 'id', index: 'id', width: 20, align: 'center' },
                { name: 'mcode', index: 'mcode', width: 150, editable: false, sortable: false, edittype: 'custom',
                    editoptions: {
                        custom_element: function(value, options) {
                            var elemStr = '<input id="' + options.id + '" value="' + value + '" type="text" style="float:left; width:94%;margin-right:-28px;" />';
                            elemStr += '<div><button id="' + options.id + '_bs" type="button" title="Search" ' +
                            ' onclick="searchMaterialDialog();" style="height:19px; padding:0 4px; width:30px;" class="ui-button ui-state-default" ><span class="ui-icon ui-icon-search"></span></button></div>';
                            return elemStr;
                        },
                        custom_value: function(elem) {
                            return elem.val();
                        }
                    }
                },
                { name: 'mname', index: 'mname', width: 200, sortable: false },
                { name: 'munit', index: 'munit', width: 80, align: 'center', editable: false, edittype: 'custom',
                    editoptions: {
                        custom_element: function(value, options) {
                            var elemStr = '<select id="' + options.id + '" style="padding:1px 0;" >';
                            elemStr += '</select>';

                            //alert(options.id);
                            return elemStr;
                        },
                        custom_value: function(elem) {
                            var rowid = $(this).jqGrid('getGridParam', 'selrow');
                            $(this).jqGrid('setRowData', rowid, { unitLargeId: elem.val() });
                            return $("#" + rowid + "_munit :selected").text();
                        }
                    }, sortable: false
                },
                { name: 'madjamount', index: 'madjamount', width: 40, editable: false, align: 'right', sortable: false },
                { name: 'mid', index: 'mid', hidden: true, sortable: false },
                { name: 'docdetailid', index: 'docdetailid', hidden: true, sortable: false },
                { name: 'unitLargeId', index: 'unitLargeId', hidden: true, sortable: false },
                { name: 'docDetailIdx', index: 'docDetailIdx', hidden: true, sortable: false }
                ],
                pager: '#adjPager',
                rowNum: -1,
                pgbuttons: false,
                pgtext: null,
                multiselect: true,
                multiboxonly: true,
                height: 300,
                autowidth: true,
                viewrecords: true,
                caption: $('#<%=lbl_4_6.ClientID %>').text(),
                /*afterEditCell: function (rowid, colName, value, iRow, iCol) {
            
                },*/
                beforeSelectRow: function(rowid, e) {
                    if (e.srcElement.type == "checkbox") {
                        return true;
                    }
                    return false;
                },
                beforeSelectRow: function(rowid, e) {
                    var cbsdis = $("tr#" + rowid + ".jqgrow > td > input.cbox:disabled", grid[0]);
                    if (cbsdis.length === 0) {
                        return true;    // allow select the row
                    } else {
                        return false;   // not allow select the row
                    }
                },
                onSelectAll: function(aRowids, status) {
                    if (status) {
                        // uncheck "protected" rows
                        var cbs = $("tr.jqgrow > td > input.cbox:disabled", grid[0]);
                        cbs.removeAttr("checked");

                        //modify the selarrrow parameter
                        grid[0].p.selarrrow = grid.find("tr.jqgrow:has(td > input.cbox:checked)")
                .map(function() { return this.id; }) // convert to set of ids
                .get(); // convert to instance of Array
                    }
                }, /*
                ondblClickRow: function(rowid, iRow, iCol, e) {
                    if (editing !== "edit") {
                        editing = "edit";
                        selectedRowID = rowid;
                        $(this).editRow(rowid, false, onEditFunc);
                    }
                },*/
                //                onSelectRow: function (rowid) {
                //                    /*if (rowid != selectedRowID) {
                //                    jQuery("#adjGrid").saveRow(selectedRowID, succesfunc, 'clientArray', {},
                //                    aftersavefunc, errorfunc, afterrestorefunc);
                //                    selectedRowID = rowid;
                //                    }*/
                //                    if (editing !== "edit") {
                //                        editing = "edit";
                //                        selectedRowID = rowid;
                //                        $(this).editRow(rowid, false, onEditFunc);
                //                    }
                //                },
                gridComplete: function() {
                    var records = $(this).jqGrid('getGridParam', 'records');
                    if (records > 0) {
                        if (docStatus == 1) {
                            $("#btnSaveDocument").attr('disabled', false).removeClass('ui-state-disabled');
                        }
                        $("#btnPrintReport").attr('disabled', false).removeClass('ui-state-disabled');
                        $("#btnExportExcel").attr('disabled', false).removeClass('ui-state-disabled');
                    }
                    //                if (selectedRowID) {
                    //                    $("#adjGrid").jqGrid('setSelection', parseInt(selectedRowID) + 1, true);
                    //                }
                    scrollToRow("#adjGrid", records);
                }
            }).jqGrid('navGrid', '#adjPager', { edit: false, add: false, del: false, search: false, refresh: false });
            //-- resize grid when resize browser
            $(window).bind('resize', function() {
                $("#adjGrid").setGridWidth($(window).width() - 12);
            }).trigger('resize');
        }

        function searchAdjHistory() {
            $("#searchAdjHistoryDialog").dialog({
                width: 690,
                height: 530,
                modal: true,
                resizable: false
            });
        }

        function searchMaterialDialog() {
            //alert(url);DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromDialog&inv=' + $('#<%=ddlInv.ClientID %> :selected').val()
            if ($("#searchMaterialGrid").jqGrid('getGridParam', 'records') <= 0) {
                $("#searchMaterialGrid").jqGrid('clearGridData');
                $("#searchMaterialGrid").jqGrid('setGridParam',
                { url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromDialog&inv=' +
                $('#<%=ddlInv.ClientID %> :selected').val() + '&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId
                }).trigger('reloadGrid');
            }
            $("#searchMaterialDialog").dialog({
                width: 690,
                height: 530,
                modal: true,
                resizable: false
            });
            $("#txtSearchMaterialCode").select();
        }

        function searchMaterialGrid() {
            $("#searchMaterialGrid").jqGrid({
                url: 'noData.xml',
                datatype: 'xml',
                colNames: ['<%=lbl_4_1.Text %>', '<%=lbl_4_2.Text %>', '<%=lbl_4_3.Text %>', 'matId', 'matCode2'],
                colModel: [
                { name: 'id', index: 'id', width: 40, align: 'center' },
                { name: 'matCode', index: 'matCode', width: 150, sortable: false },
                { name: 'matName', index: 'matName', width: 480, sortable: false },
                { name: 'matId', index: 'matId', hidden: true },
                { name: 'matCode2', index: 'matCode2', hidden: true }
                ],
                pager: '#searchMaterialPager',
                rowNum: 50,
                pgbuttons: false,
                pgtext: null,
                height: 370,
                autowidth: true,
                viewrecords: true,
                ondblClickRow: function(rowid, iRow, iCol, e) {
                    var gridData = $(this).jqGrid('getRowData', rowid);
                    addMaterialToSearchTextBox(gridData.matId, gridData.matCode2, gridData.matName);
                },
                caption: ''
            }).jqGrid('navGrid', '#searchMaterialPager', { edit: false, add: false, del: false, search: false, refresh: false });

        }

        function getMaterialDataJson(materialCode) {
            var data = null;
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromTextBox&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'json',
                type: 'POST',
                cache: false,
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(), materialCode: materialCode }),
                complete: function(xhr, status) {
                    //data = eval("(" + xhr.responseText + ")");
                    //return data;
                }, success: function(result) {
                    return result;
                }
            });
        }

        function searchMaterialFromTextBox(materialCode) {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromTextBox&documentId=' + documentId +
                 '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'json',
                type: 'POST',
                cache: false,
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(), materialCode: materialCode }),
                complete: function(xhr, status) {
                    //alert(xhr.responseText);
                },
                success: function(data) {
                    //alert(data.notFound);
                    if (data.notFound == 1) {
                        alert('<%=lbl_3_23.Text %>');
                    }
                    else {
                        if (data.unitList.length >= 1) {
                            $("#txtAmount").select();
                            $("#txtMaterialCode").val(data.materialCode)
                            $("#hidMaterialId").val(data.materialId);
                            $("#txtAmount").focus();

                            var slUnit = $("#slUnit");
                            var unitOpt = "";
                            /*$.each(data.unitList[0], function (index, item) {
                            unitOpt += '<option value="' + index + '">' + item + '</option>';
                            });*/
                            for (var i = 0; i <= data.unitList.length - 1; i++) {
                                unitOpt += '<option value="' + data.unitList[i].unitLargeId + '">' + data.unitList[i].unitName + '</option>';
                            }
                            slUnit.html(unitOpt);
                            $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                        } else {
                            $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
                            alert('<%=lbl_3_17.Text %>');
                        }
                    }
                }, error: function(xhr, status) {
                    alert('Error ' + xhr.responseText);
                }
            });
        }

        function searchMaterialFromTextBoxInGrid(rowid, materialCode) {
            var adjGrid = $("#adjGrid");
            var gridData = adjGrid.jqGrid('getRowData', rowid);
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromTextBox&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'json',
                type: 'POST',
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(), materialCode: materialCode }),
                complete: function(xhr, status) {
                    //                    var data = eval("(" + xhr.responseText + ")");
                    //                    $("#adjGrid").jqGrid('setRowData', rowid, { mid: data.materialId, mname: data.materialName });

                    //                    var slUnit = $("#" + rowid + "_munit");
                    //                    var unitOpt = "";
                    //                    $.each(data.unitList[0], function (index, item) {
                    //                        unitOpt += '<option value="' + index + '">' + item + '</option>';
                    //                    });
                    //                    slUnit.html(unitOpt);

                    //                    var grid = $("#adjGrid").jqGrid('getRowData', selectedRowID);
                    //                    var docDetailId = grid.docdetailid;
                    //                    var materialId = grid.mid;
                    //                    getUnitWhenEditCell(selectedRowID, docDetailId, materialId);
                    //alert(xhr.responseText);
                },
                success: function(data) {
                    if (data.notFound == 1) {
                        alert(data.msg);
                        adjGrid.jqGrid('restoreRow', selectedRowID)
                    } else {
                        if (data.unitList.length >= 1) {
                            adjGrid.jqGrid('setRowData', rowid, { mid: data.materialId, mname: data.materialName });

                            var slUnit = $("#" + rowid + "_munit");
                            var unitOpt = "";
                            for (var i = 0; i <= data.unitList.length - 1; i++) {
                                unitOpt += '<option value="' + data.unitList[i].unitLargeId + '">' + data.unitList[i].unitName + '</option>';
                            }
                            slUnit.html(unitOpt);
                            //alert(slUnit);
                        } else {
                            //alert('วัตถุดิบนี้ไม่มีหน่วย');
                            //var gridData = adjGrid.jqGrid('getRowData', selectedRowID);
                            var docDetailId = gridData.docdetailid;
                            var materialId = gridData.mid;
                            getUnitWhenEditCell(selectedRowID, docDetailId, materialId);
                        }
                    }
                }, error: function(xhr, status) {
                    alert('Error ' + xhr.responseText);
                }
            });
        }

        function searchMaterialFromDialog() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromDialog&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'xml',
                type: 'POST',
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(), materialCode: $("#txtSearchMaterialCode").val(),
                    materialName: $("#txtSearchMaterialName").val()
                }),
                complete: function(xhr, status) {
                    var searchMaterialGrid = $("#searchMaterialGrid")[0];
                    searchMaterialGrid.addXmlData(xhr.responseXML);
                }
            });
        }

        // load adjDocDetail
        function loadAdjDocDetail() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadCurrentAdjustDocDetail&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                '&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'xml',
                type: 'GET',
                complete: function(xhr, status) {
                    var grid = $("#adjGrid")[0];
                    grid.addXmlData(xhr.responseXML);
                    scrollToRow("#adjGrid", $("#adjGrid").jqGrid('getGridParam', 'records'));
                    loadAddReduceDocumentData();
                }
            });
        }

        function saveDocument() {
            if ($("#remark").val() !== "") {

                $(".require_val").css('display', 'none');

                $.ajax({
                    url: 'DataXML/AdjustDocumentDataXML.aspx?action=saveDocument&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                '&remark=' + $("#remark").val() + '&day=' + $('#<%=ddlDay.ClientID %> :selected').val() +
                '&month=' + $('#<%=ddlMonth.ClientID %> :selected').val() + '&year=' + $('#<%=ddlYear.ClientID %> :selected').val() +
                '&documentId=' + documentId +
                 '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                    dataType: 'json',
                    type: 'GET',
                    complete: function(xhr, status) {
                        try {
                            var data = eval('(' + xhr.responseText + ')');
                            if (data.save == '1') {
                                if (parseInt($("#adjGrid").jqGrid('getGridParam', 'records')) > 0)
                                    $("#btnApproveDocument").attr('disabled', false).removeClass('ui-state-disabled');


                                $("#btnSaveDocument").attr('disabled', false).removeClass('ui-state-disabled');
                                $('#<%=ddlInv.ClientID %>').attr('disabled', true).addClass('ui-state-disabled');
                                $('#slAdjType').attr('disabled', true).addClass('ui-state-disabled');
                                $('#slAdjDocType').attr('disabled', true).addClass('ui-state-disabled');
                                $("#txtAdjDate").attr('disabled', true).addClass('ui-state-disabled').datepicker('disable');

                                $("#btnAdjustStock").attr('disabled', true).addClass('ui-state-disabled');
                                $("#txtMaterialCode").attr('disabled', false).removeClass('ui-state-disabled');
                                $("#txtAmount").attr('disabled', false).removeClass('ui-state-disabled');
                                $("#slUnit").attr('disabled', false).removeClass('ui-state-disabled');
                                $("#btnSearchMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                                $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                                $("#btnCancel").attr('disabled', false).removeClass('ui-state-disabled');
                                $("#txtMaterialCode").focus();

                                loadAddReduceDocumentData();

                                $("#btnCancel").attr('disabled', false).removeClass('ui-state-disabled');
                                //$("#slAdjDocType").val('0');
                                //$("#mesgText").html($('#<%=lbl_3_6.ClientID %>').text());


                                //alert('<%=lbl_3_6.Text %>');


                                //                            $("#mesgDialog").dialog({
                                //                                title: $('#<%=lbl_3_7.ClientID %>').text(),
                                //                                width: 380,
                                //                                height: 100,
                                //                                modal: true,
                                //                                resizable: false
                                //                            });
                            }
                            else {

                                alert(xhr.responseText);
                                //alert('<%=lbl_3_8.Text %>');
                                //                            $("#mesgText").html($('#<%=lbl_3_8.ClientID %>').text());
                                //                            $("#mesgDialog").dialog({
                                //                                title: $('#<%=lbl_3_7.ClientID %>').text(),
                                //                                width: 380,
                                //                                height: 100,
                                //                                modal: true,
                                //                                resizable: false
                                //                            });
                            }
                        } catch (e) {
                            alert(x.responseText);
                        }
                    }
                });
            } else {
                $("#remark").focus();
                //alert('<%=lbl_3_18.Text %>');
                $(".require_val").css('display', '');
            }
        }

        function approveDocument() {
            if ($("#remark").val() !== "") {

                $(".require_val").css('display', 'none');

                $.ajax({
                    url: 'DataXML/AdjustDocumentDataXML.aspx?action=approveDocument&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                '&remark=' + $("#remark").val() + '&documentDate=' + $("#txtAdjDate").val() +
                '&day=' + $('#<%=ddlDay.ClientID %> :selected').val() + '&month=' + $('#<%=ddlMonth.ClientID %> :selected').val() +
                '&year=' + $('#<%=ddlYear.ClientID %> :selected').val() + '&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                    dataType: 'json',
                    type: 'GET',
                    complete: function(xhr, status) {
                        try {
                            var data = eval('(' + xhr.responseText + ')');
                            if (data.approve == '1') {
                                alert('<%=lbl_3_9.Text %>');

                                window.location = 'AdjustStock.aspx?StaffID=' + require_var.staffId +
                                    '&StaffRoleID=' + require_var.staffRole +
                                    '&LangID=' + require_var.langId;
                                //                            //$("#adjGrid").jqGrid('setGridParam', { cellEdit: false }).trigger('reloadGrid');

                                //                            docStatus = 2;
                                //                            $("#btnAdjustStock").attr('disabled', false).removeClass('ui-state-disabled');
                                //                            $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#btnSearchMaterial").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#btnSaveDocument").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#btnApproveDocument").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#btnCancel").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#btnDelAddReduceMaterial").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#txtMaterialCode").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#txtAmount").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#slUnit").attr('disabled', true).addClass('ui-state-disabled');
                                //                            $("#remark").val("");



                                //                            //$("#slAdjType").val('0');
                                //                            $("#slAdjDocType").val('0');
                                //                            alert('<%=lbl_3_9.Text %>');
                                //                            //                            $("#mesgText").html($('#<%=lbl_3_9.ClientID %>').text());
                                //                            //                            $("#mesgDialog").dialog({
                                //                            //                                title: $('#<%=lbl_3_10.ClientID %>').text(),
                                //                            //                                width: 380,
                                //                            //                                height: 100,
                                //                            //                                modal: true,
                                //                            //                                resizable: false
                                //                            //                            });
                                //                            loadAddReduceDocumentData();
                            }
                            else {
                                alert('<%=lbl_3_11.Text %>');
                                //                            $("#mesgText").html($('#<%=lbl_3_11.ClientID %>').text());
                                //                            $("#mesgDialog").dialog({
                                //                                title: $('#<%=lbl_3_10.ClientID %>').text(),
                                //                                width: 380,
                                //                                height: 100,
                                //                                modal: true,
                                //                                resizable: false
                                //                            });
                            }
                        } catch (e) {
                            alert(xhr.responseText);
                        }
                    }
                });
            } else {
                $("#remark").focus();
                //alert('<%=lbl_3_18.Text %>');

                $(".require_val").css('display', '');
            }
        }

        // update adjDocdetail
        function updateAdjDocDetail(idx, docDetailId, materialId, unitLargeId, amount) {
            //alert(idx + ' ' + docDetailId + ' ' + materialId + ' ' + unitLargeId + ' ' + amount);
            if (parseFloat(amount) > 0) {
                $.ajax({
                    url: 'DataXML/AdjustDocumentDataXML.aspx?action=updateAdjustDocdetail&documentId=' + documentId +
                    '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                    dataType: 'json',
                    type: 'POST',
                    data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&materialId=' + materialId + '&materialAmount=' + amount +
                        '&unitLargeId=' + unitLargeId + '&indexInList=' + idx,
                    complete: function(xhr, status) {
                        var data = eval("(" + xhr.responseText + ")");
                        if (data.updateAdjDocDetail == 1) {
                            loadAdjDocDetail();
                        }
                    }
                });
            } else {

                alert('<%=lbl_3_16.Text %>');
            }
        }

        // Remove docDetail
        function removeAddReduceDocDetail() {
            var docDetail = new Array();
            var addReduceGrid = $("#adjGrid");
            var rowCheckedDel = addReduceGrid.jqGrid('getGridParam', 'selarrrow');

            for (var i = 0; i <= rowCheckedDel.length - 1; i++) {
                if (rowCheckedDel[i] !== ',') {
                    var rowData = addReduceGrid.jqGrid('getRowData', rowCheckedDel[i]);
                    //alert(rowData.docdetailid);
                    if (rowData.docdetailid != '' || rowData.docdetailid != null) {
                        docDetail.push(rowData.docdetailid);
                    }
                }
            }

            var url = 'DataXML/AdjustDocumentDataXML.aspx?action=removeAddReduceMaterial&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
             '&documentId=' + documentId + '&reqDocDetailId[]=' + docDetail +
             '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId;

            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'xml',
                cache: false,
                complete: function(xhr, status) {
                    //alert(xhr.responseXML);
                    var adjGrid = $("#adjGrid")[0];
                    adjGrid.addXmlData(xhr.responseXML);
                } /*,
                error: function(xhr, status) {
                    alert('Error state: ' + xhr.readyState + ' Status: ' + xhr.status + ' Error msg: ' + status.msg);
                }*/
            });
            //addReduceGrid.jqGrid('setGridParam', { url: url }).trigger('reloadGrid');
        }

        // add adjDocDetail
        function addAdjDocDetail() {
            if ($("#txtMaterialCode").val() != "") {
                if (parseFloat($("#txtAmount").val()) > 0) {
                    $.ajax({
                        url: 'DataXML/AdjustDocumentDataXML.aspx?action=addAdjustDocDetail' +
                        '&documentId=' + documentId +
                       '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                        dataType: 'json',
                        type: 'POST',
                        data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&materialId=' + $("#hidMaterialId").val() + '&materialAmount=' + $("#txtAmount").val() +
                            '&unitLargeId=' + $("#slUnit :selected").val(),
                        complete: function(xhr, status) {
                            try {
                                var data = eval("(" + xhr.responseText + ")");
                                if (data.addAdjDocDetail == 1) {
                                    $("#txtMaterialCode").val("");
                                    $("#txtAmount").val("0");
                                    $("#btnSearchMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                                    $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                                    $("#btnDelAddReduceMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                                    $("#txtMaterialCode").focus();
                                    $("#slUnit").html("");
                                    // add data to grid
                                    loadAdjDocDetail();
                                } else {
                                    //alert(result.msg);
                                }
                            } catch (e) {
                                alert(xhr.responseText);
                            }
                        }
                    });
                } else {
                    $("#txtAmount").focus();
                    alert('<%=lbl_3_16.Text %>');
                }
            }
            else {
                $("#txtMaterialCode").focus();
                alert('<%=lbl_3_15.Text %>');
            }

        }

        // cancel adjDoc
        function cancelAdjDocument() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=cancelAdjDocument&inv=' +
                $('#<%=ddlInv.ClientID %> :selected').val() + '&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                dataType: 'json',
                type: 'GET',
                complete: function(xhr, status) {
                    try {
                        var data = eval("(" + xhr.responseText + ")");
                        if (data.cancelAdjDoc == 1) {
                            window.location = 'AdjustStock.aspx?StaffID=' + require_var.staffId +
                                    '&StaffRoleID=' + require_var.staffRole +
                                    '&LangID=' + require_var.langId;
                        }
                    } catch (e) {
                        alert(xhr.responseText);
                    }
                }
            });
        }

        // create new adjDoc
        function createNewAdjDocument() {
            $("#adjGrid").jqGrid('clearGridData');

            $("#btnSaveDocument").attr('disabled', true).addClass('ui-state-disabled');
            $("#btnApproveDocument").attr('disabled', true).addClass('ui-state-disabled');
            $("#btnDelAddReduceMaterial").attr('disabled', true).addClass('ui-state-disabled');
            $("#btnCancel").attr('disabled', true).addClass('ui-state-disabled');
            $("#btnExportExcel").attr('disabled', true).addClass('ui-state-disabled');

            $("#btnAdjustStock").attr('disabled', false).removeClass('ui-state-disabled');
            $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
            $("#btnSearchMaterial").attr('disabled', true).addClass('ui-state-disabled');
            //$("#btnSaveDocument").attr('disabled', true).addClass('ui-state-disabled');
            $("#txtMaterialCode").attr('disabled', true).addClass('ui-state-disabled');
            $("#txtAmount").attr('disabled', true).addClass('ui-state-disabled');
            $("#slUnit").attr('disabled', true).addClass('ui-state-disabled');

            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=newAdjDocument',
                dataType: 'json',
                type: 'POST',
                data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&adjDocTypeId=' + $("#slAdjDocType :selected").val() +
                 '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                complete: function(xhr, status) {
                    try {
                        var data = eval('(' + xhr.responseText + ')');
                        if (data.newAdjDoc == 1) {

                            //Assing documentId
                            documentId = data.documentId;

                            $("#btnSaveDocument").attr('disabled', false).removeClass('ui-state-disabled');

                            loadAddReduceDocumentData();

                            $('#<%=ddlInv.ClientID %>').attr('disabled', false).removeClass('ui-state-disabled');
                            $('#slAdjType').attr('disabled', false).removeClass('ui-state-disabled');
                            $('#slAdjDocType').attr('disabled', false).removeClass('ui-state-disabled');
                            $("#txtAdjDate").attr('disabled', false).removeClass('ui-state-disabled').datepicker('enable');

                        } else if (data.newAdjDoc == 99) {
                            alert('<%=lbl_3_24.Text %>');
                        }
                        else {
                            alert('Error !');
                        }
                    } catch (e) {
                        alert('Error : ' + e + xhr.responseText);
                    }
                }
            });
        }

        function getUnitWhenEditCell(rowid, docDetailId, materialId) {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=getUnitJson' +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                type: 'POST',
                dataType: 'json',
                cache: false,
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(),
                    docDetailId: docDetailId, materialId: materialId
                }),
                complete: function(xhr, status) {
                    //alert(xhr.responseText);
                },
                success: function(data) {
                    //alert(data.d);
                    var slMunit = $("#" + rowid + "_munit");
                    var optUnit = "";
                    if (data.materialUnit.length >= 1) {
                        for (var i = 0; i <= data.materialUnit.length - 1; i++) {
                            optUnit += '<option value="' + data.materialUnit[i].unitLargeId + '">' + data.materialUnit[i].unitName + '</option>';
                        }
                        slMunit.html(optUnit);
                    } else {
                        $("#adjGrid").jqGrid('restoreRow', rowid);

                        alert('วัตถุดิบนี้ถูกใส่เข้าไปในรายการแล้ว');
                    }
                }, error: function(xhr, status) {
                    alert('Error ' + xhr.responseText);
                }
            });
        }

        function getUnitWhenSearchTextBox(materialId) {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=getUnitJson&documentId=' + documentId +
               '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                type: 'POST',
                dataType: 'json',
                cache: false,
                data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                    '&docDetailId=' + '-1' + '&materialId=' + materialId,
                complete: function(xhr, status) {
                    try {
                        var data = eval('(' + xhr.responseText + ')');
                        var slAddUnit = $("#slUnit");
                        var optUnit = "";
                        if (data.materialUnit.length >= 1) {
                            for (var i = 0; i <= data.materialUnit.length - 1; i++) {
                                optUnit += '<option value="' + data.materialUnit[i].unitLargeId + '">' + data.materialUnit[i].unitName + '</option>';
                            }
                            slAddUnit.html(optUnit);
                        } else {
                            alert('<%=lbl_3_17.Text %>');
                        }
                    }
                    catch (e) {
                        alert(xhr.responseText);
                    }
                }
            });
        }

        function addMaterialToSearchTextBox(materialId, materialCode, materialName) {
            $("#searchMaterialDialog").dialog('close');
            $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');

            $("#txtMaterialCode").val(materialCode);

            $("#hidMaterialId").val(materialId);
            $("#txtAmount").val('0').select();
            getUnitWhenSearchTextBox(materialId);

        }

        function onEditFunc() {
            $("#" + selectedRowID + "_mcode").keyup(function(e) {
                if (e.keyCode == 13) {
                    if ($(this).val() !== "") {
                        //get material data
                        searchMaterialFromTextBoxInGrid(selectedRowID, $(this).val());
                        //focus next element
                        $("#" + selectedRowID + "_munit").focus();
                    }
                }
            });

            $("#" + selectedRowID + "_munit").keyup(function(e) {
                if (e.keyCode == 13) {
                    //focus next element
                    $("#" + selectedRowID + "_madjamount").focus();
                }
            });

            $("#" + selectedRowID + "_madjamount").keyup(function(e) {
                if (e.keyCode == 13) {
                    jQuery("#adjGrid").saveRow(selectedRowID, succesfunc, 'clientArray', {},
                        aftersavefunc, errorfunc, afterrestorefunc);
                }
            });
        }

        function aftersavefunc() {
            var grid = $(this).jqGrid('getRowData', selectedRowID);
            var docDetailId = grid.docdetailid;
            var materialId = grid.mid;
            var unitLargeId = grid.unitLargeId;
            var materialAmount = grid.madjamount;
            var docDetailIdx = grid.docDetailIdx;
            updateAdjDocDetail(docDetailIdx, docDetailId, materialId, unitLargeId, materialAmount);
        }

        function succesfunc() {
            //select next row
            //        $("#adjGrid").jqGrid('resetSelection', selectedRowID);
            //        if (editing !== "edit") {
            //            $("#adjGrid").jqGrid('setSelection', parseInt(selectedRowID) + 1, true);
            //        }
        }

        function errorfunc() {
        }

        function afterrestorefunc() {
        }

        function loadAddReduceDocumentData() {
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadAddReduceDocumentDataJSON&inv=' +
                $('#<%=ddlInv.ClientID %> :selected').val() + '&documentId=' + documentId +
                '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                cache: false,
                complete: function(xhr, status) {
                    try {
                        var data = eval('(' + xhr.responseText + ')');
                        $("#documentType").html(data.documentType);
                        $("#documentNumber").html(data.documentNumber);
                        $("#txtAdjDate").html(data.documentDate);

                        $("#remark").val(data.remark);

                        $("#slAdjDocType").val(data.documentTypeId);

                        if (data.documentStatusId == 0 || data.documentStatusId == 1 || data.documentStatusId == 2 || data.documentStatusId == 99) {

                            if (data.documentStatusId == 1) {
                                $("#documentStatus").html('<%=lbl_3_12.Text %>');

                                $('#<%=lbl_3_19.ClientID %>').css('display', '');
                                $('#<%=lbl_3_20.ClientID %>').css('display', '');
                                $("#insertStaff").html(" " + data.insertStaff);
                                $("#updateStaff").html(" " + data.updateStaff);

                                $("#btnCancel").attr('disabled', false).removeClass('ui-state-disabled');
                            }
                            else if (data.documentStatusId == 2) {
                                $("#documentStatus").html('<%=lbl_3_13.Text %>');

                                $('#<%=lbl_3_19.ClientID %>').css('display', '');
                                $('#<%=lbl_3_20.ClientID %>').css('display', '');
                                $('#<%=lbl_3_21.ClientID %>').css('display', '');
                                $("#insertStaff").html(" " + data.insertStaff);
                                $("#updateStaff").html(" " + data.updateStaff);
                                $("#approveStaff").html(" " + data.approveStaff);

                                $("#btnCancel").attr('disabled', false).removeClass('ui-state-disabled');
                            }
                            else if (data.documentStatusId == 99) {
                                $("#documentStatus").html('<%=lbl_3_14.Text %>');

                                $('#<%=lbl_3_19.ClientID %>').css('display', '');
                                $('#<%=lbl_3_20.ClientID %>').css('display', '');
                                $('#<%=lbl_3_21.ClientID %>').css('display', '');
                                $('#<%=lbl_3_22.ClientID %>').css('display', '');
                                $("#insertStaff").html(" " + data.insertStaff);
                                $("#updateStaff").html(" " + data.updateStaff);
                                $("#approveStaff").html(" " + data.approveStaff);
                                $("#cancelStaff").html(" " + data.cancelStaff);

                                $("#btnCancel").attr('disabled', true).addClass('ui-state-disabled');
                            }
                            else {
                                $("#documentStatus").html('<%=lbl_3_12.Text %>');
                                $("#insertStaff").html(" ");
                                $("#updateStaff").html(" ");
                                $("#approveStaff").html(" ");
                                $("#cancelStaff").html(" ");
                            }

                            $('#<%=ddlInv.ClientID %>').attr('disabled', true).addClass('ui-state-disabled');
                            $('#slAdjType').attr('disabled', true).addClass('ui-state-disabled');
                            $('#slAdjDocType').attr('disabled', true).addClass('ui-state-disabled');
                            $("#txtAdjDate").attr('disabled', true).addClass('ui-state-disabled').datepicker('disable');

                        }
                    } catch (e) {
                        alert(xhr.responseText);
                    }
                }
            });
        }

        function searchAddReduceGrid() {
            var url = 'DataXML/AdjustDocumentDataXML.aspx?action=searchAddReductDocument&inv=' + $('#<%=ddlSearchAddReduceInv.ClientID %> :selected').val() +
        '&adjType=' + $("#slSearchAddReduceDocType :selected").val() + '&searchDocStatus=' + $("#slSearchAddReduceDocStatus :selected").val() +
         '&dateFrom=' + $('#<%=ddlDateFrom.ClientID %> :selected').val() +
         '&monthFrom=' + $('#<%=ddlMonthFrom.ClientID %> :selected').val() +
         '&yearFrom=' + $('#<%=ddlYearFrom.ClientID %> :selected').val() +
         '&dateTo=' + $('#<%=ddlDateTo.ClientID %> :selected').val() +
         '&monthTo=' + $('#<%=ddlMonthTo.ClientID %> :selected').val() +
         '&yearTo=' + $('#<%=ddlYearTo.ClientID %> :selected').val() + '&documentId=' + documentId +
         '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId;

            $("#searchAddReduceGrid").jqGrid('setGridParam', { url: url }).trigger('reloadGrid');

        }

        function loadAddReduceDocument(rowId) {
            $("#searchAddReduceDocumentDialog").dialog('close');
            var gridData = $("#searchAddReduceGrid").jqGrid('getRowData', rowId);

            docStatus = gridData.status;
            documentId = gridData.documentId;

            if (gridData.status == "1") {

                $("#btnSaveDocument").attr('disabled', false).removeClass('ui-state-disabled');
                $("#btnApproveDocument").attr('disabled', false).removeClass('ui-state-disabled');
                $("#btnDelAddReduceMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                $("#btnSearchMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                $("#btnCancel").attr('disabled', false).removeClass('ui-state-disabled');

                $("#txtMaterialCode").attr('disabled', false).removeClass('ui-state-disabled');
                $("#txtAmount").attr('disabled', false).removeClass('ui-state-disabled');
                $("#slUnit").attr('disabled', false).removeClass('ui-state-disabled');
                $("#remark").val("");

                //alert(gridData.invId);
                $('#<%=ddlInv.ClientID %>').val(gridData.invId).attr('disabled', false).removeClass('ui-state-disabled');
                $('#slAdjType').attr('disabled', false).removeClass('ui-state-disabled');
                $('#slAdjDocType').attr('disabled', false).removeClass('ui-state-disabled');
                $("#txtAdjDate").attr('disabled', false).removeClass('ui-state-disabled');
            }
            else {
                $("#btnSaveDocument").attr('disabled', true).addClass('ui-state-disabled');
                $("#btnApproveDocument").attr('disabled', true).addClass('ui-state-disabled');
                $("#btnDelAddReduceMaterial").attr('disabled', true).addClass('ui-state-disabled');
                $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
                $("#btnSearchMaterial").attr('disabled', true).addClass('ui-state-disabled');
                $("#btnCancel").attr('disabled', true).addClass('ui-state-disabled');

                $("#txtMaterialCode").attr('disabled', true).addClass('ui-state-disabled');
                $("#txtAmount").attr('disabled', true).addClass('ui-state-disabled');
                $("#slUnit").attr('disabled', true).addClass('ui-state-disabled');
                $("#remark").val("");

                //alert(gridData.invId);
                $('#<%=ddlInv.ClientID %>').val(gridData.invId).attr('disabled', true).addClass('ui-state-disabled');
                $('#slAdjType').attr('disabled', true).addClass('ui-state-disabled');
                $('#slAdjDocType').attr('disabled', true).addClass('ui-state-disabled');
                $("#txtAdjDate").attr('disabled', true).addClass('ui-state-disabled').datepicker('disable');
            }

            $("#adjGrid").jqGrid('setGridParam', { url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadAddReduceDocument&inv=' +
            $('#<%=ddlSearchAddReduceInv.ClientID %> :selected').val() + '&documentId=' + gridData.documentId +
            '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId
            }).trigger('reloadGrid');
            loadAddReduceDocumentData();
        }

        function clearDocumentData() {
            $("#documentStatus").html('');
            $("#documentNumber").html('');
            $("#documentType").html('');
        }

        function scrollToRow(targetGrid, id) {
            //alert(id);
            var rowHeight = 23; //getGridRowHeight(targetGrid) || 23; // Default height
            var index = jQuery(targetGrid).getInd(id);
            jQuery(targetGrid).closest(".ui-jqgrid-bdiv").scrollTop(rowHeight * index);
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="require_var" style="display: none;" runat="server">
    </div>
    <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
    <asp:Button ID="BtnExportExcel1" runat="server" OnClick="ExportStockExcel_Click"
        Visible="false" />
    <div class="ui-widget-content">
        <div class="ui-widget ui-widget-header" style="height: 30px; padding: 4px 10px;">
            <div style="float: left; font-size: 14px;">
                <div class="icon-adjust-stock" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
                </div>
                <div style="float: left;">
                    <div style="height: 4px; margin-top: 4px;">
                        &nbsp;</div>
                    <div style="margin: 2px;">
                        <!-- ปรับเพิ่ม-ลดสต๊อก -->
                        <asp:Label ID="lbl_1_1" runat="server" Text="เอกสารเบิก"></asp:Label></div>
                </div>
            </div>
            <div style="float: right;">
                <button id="btnAdjustStock" type="button" style="margin: 0 2px 0 10px;" class="btn">
                    <asp:Label ID="lbl_2_1" Text="สร้างเอกสาร" runat="server" class="btn"></asp:Label></button>
                <button id="btnSearchAddReduceDocument" type="button" style="margin: 0 2px 0 10px;"
                    class="btn">
                    <asp:Label ID="lbl_2_2" Text="ค้นหาเอกสาร" runat="server" class="btn"></asp:Label></button>
                <button id="btnSaveDocument" type="button" style="margin: 0 2px 0 10px;" class="btn">
                    <asp:Label ID="lbl_2_3" Text="บันทึกเอกสาร" runat="server" class="btn"></asp:Label></button>
                <button id="btnApproveDocument" type="button" style="margin: 0 2px 0 10px;" class="btn">
                    <asp:Label ID="lbl_2_4" Text="อนุมัติเอกสาร" runat="server" class="btn"></asp:Label></button>
                <button id="btnCancel" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_5" Text="ยกเลิกเอกสาร" runat="server" class="btn"></asp:Label></button>
                <button id="btnExportExcel" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_6" Text="Export Excel" runat="server" class="btn"></asp:Label></button>
                <button id="btnPrintReport" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_7" Text="พิมพ์" runat="server" class="btn"></asp:Label></button>

                <script type="text/javascript">
                    //-- btn search document
                    $("#btnSearchAddReduceDocument").button({
                        icons: {
                            primary: 'icon-btn-search'
                        }
                    }).click(function() {
                        searchAddReduceGrid();
                        $("#searchAddReduceDocumentDialog").dialog({
                            width: 790,
                            height: 500,
                            resizable: false,
                            modal: true
                        });
                    });

                    $("#btnAdjustStock").button({
                        icons: {
                            primary: 'icon-action-newdoc'
                        }
                    }).click(function() {

                        $('#<%=ddlInv.ClientID %>').attr('disabled', false).removeClass('ui-state-disabled');
                        $('#slAdjType').attr('disabled', false).removeClass('ui-state-disabled');
                        $('#slAdjDocType').attr('disabled', false).removeClass('ui-state-disabled');
                        $("#txtAdjDate").attr('disabled', false).removeClass('ui-state-disabled').datepicker('enable');

                        // reset adjDocTYpe
                        if (docStatus == 2) {
                            $("#slAdjDocType").val('0');
                            docStatus = 1;
                        }

                        // Create adjDocument
                        if ($("#slAdjDocType :selected").val() == '0') {
                            alert($('#<%=lbl_3_5.ClientID %>').text());
                        } else {
                            createNewAdjDocument();
                        }
                    });

                    $('#btnExportExcel').button({
                        icons: {
                            primary: 'icon-export-xls'
                        }
                    }).click(function() {
                        document.getElementById('<%=form1.ClientID %>').__EVENTTARGET.value = '<%=BtnExportExcel1.ClientID %>';
                        document.getElementById('<%=form1.ClientID %>').submit();
                    }).attr('disabled', true).addClass('ui-state-disabled');

                    $("#btnPrintReport").button({
                        icons: {
                            primary: 'icon-action-print'
                        }
                    }).click(function() {
                        window.open('Report/CrAddReduceStock.aspx?ReportName=Adjust Stock&langId=' + require_var.langId, '', 'location=1,status=1,scrollbars=1');
                    }).attr('disabled', true).addClass('ui-state-disabled');
                    $("#btnCancel").button({
                        icons: {
                            primary: 'icon-action-cancel'
                        }
                    }).click(function() {
                        // cancel document func
                        $("#confirmCancelDocumentDialog").dialog({
                            title: '<%=lbl_2_5.Text %>',
                            width: 380,
                            height: 100,
                            modal: true,
                            resizable: false
                        });
                    }).attr('disabled', true).addClass('ui-state-disabled');
                    $("#btnSaveDocument").button({
                        icons: {
                            primary: 'icon-action-save'
                        }
                    }).attr('disabled', true).addClass('ui-state-disabled').click(function() {
                        saveDocument();
                    });

                    $("#btnApproveDocument").button({
                        icons: {
                            primary: 'icon-action-approve'
                        }
                    }).attr('disabled', true).addClass('ui-state-disabled').click(function() {

                        $("#approveDocumentDialog").dialog({
                            title: '<%=lbl_2_4.Text %>',
                            width: 380,
                            height: 100,
                            modal: true,
                            resizable: false
                        });
                    });
                </script>

            </div>
            <div style="clear: both; height: 1px;">
                &nbsp;</div>
        </div>
        <div id="content">
            <div class="panel">
                <h3 class="title">
                    <ul class="doc-status-descript">
                        <li>
                            <asp:Label ID="lbl_1_2" runat="server" Text=""></asp:Label><span id="documentStatus"
                                style="font-weight: lighter;">-</span></li>
                        <li>
                            <asp:Label ID="lbl_1_3" runat="server"></asp:Label><span id="documentType" style="font-weight: lighter;">-</span></li>
                        <li>
                            <asp:Label ID="lbl_1_4" runat="server"></asp:Label><span id="documentNumber" style="font-weight: lighter;">-</span></li>
                    </ul>
                </h3>
                <div class="ui-widget-content">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tbody>
                            <tr>
                                <td class="paramlist_key" width="40%">
                                    <asp:Label ID="lbl_1_5" runat="server" Text="คลัง"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlInv" runat="server" Style="margin-left: 4px; padding: 1px 0;
                                        width: 150px;">
                                    </asp:DropDownList>
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_6" runat="server" Text="วันที่เอกสาร"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDay" runat="server">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlMonth" runat="server">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlYear" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    เอกสาร
                                    <asp:Label ID="lbl_1_7" runat="server" Text="เอกสาร" Style="display: none;"></asp:Label>
                                </td>
                                <td>
                                    <select id="slAdjType" style="width: 150px; margin-left: 4px;">
                                        <option value="reduce">
                                            <%-- <%=lbl_1_20.Text %> --%>
                                            ใบเบิกสินค้า</option>
                                        <option value="add" style="display: none;">
                                            <%=lbl_1_19.Text %></option>
                                    </select>
                                </td>
                                <td class="paramlist_key" rowspan="2">
                                    <asp:Label ID="lbl_1_8" runat="server" Text="หมายเหตุ"></asp:Label>
                                    <span style="color: Red; display: none;" class="require_val">*</span>
                                </td>
                                <td rowspan="2">
                                    <textarea id="remark" cols="30" rows="4" style="margin-left: 2px;"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_9" runat="server" Text="ชนิดเอกสาร"></asp:Label>
                                </td>
                                <td>
                                    <select id="slAdjDocType" style="width: 150px; margin-left: 4px;">
                                        <option value="0">--Please select--</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_10" runat="server" Text="ใส่วัตถุดิบ"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <input type="hidden" id="hidMaterialId" />
                                    <input type="text" id="txtMaterialCode" style="width: 180px;" class="txt" />

                                    <script type="text/javascript">
                                        $("#txtMaterialCode").autocomplete({
                                            delay: 0,
                                            source: function(request, response) {
                                                $.ajax({
                                                    url: 'DataXML/MaterialListDataXML.aspx?action=smat&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&matCode=' + $("#txtMaterialCode").val() +
                                                    '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                                                    dataType: 'json',
                                                    cache: false,
                                                    complete: function(xhr, status) {
                                                        try {
                                                            var data = eval('(' + xhr.responseText + ')');
                                                            //alert(xhr.responseText);
                                                            response($.map(data.matList, function(item) {
                                                                return {
                                                                    label: item.materialCode + ' ( ' + item.materialName + ' ) ',
                                                                    value: item.materialCode
                                                                }
                                                            }));
                                                        } catch (e) {
                                                            alert(xhr.responseText);
                                                        }
                                                    }
                                                });
                                            },
                                            minLength: 0,
                                            open: function() {
                                                $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                                            },
                                            close: function() {
                                                $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                                            }
                                        });
                                    </script>

                                    <button type="button" id="btnSearchMaterial" style="width: 40px;">
                                        <span>Search</span>
                                    </button>
                                    &nbsp;
                                    <input type="text" id="txtAmount" style="width: 70px; text-align: right;" class="txt txt-numeric" />
                                    <select id="slUnit" style="width: 100px; padding: 2px 1px; height: 25px;" class="select"
                                        name="D1">
                                    </select>
                                    &nbsp;
                                    <button id="btnAddMaterial" type="button" style="width: 100px;">
                                        <asp:Label ID="lbl_2_8" runat="server" Text="เพิ่ม"></asp:Label>
                                    </button>
                                    <button id="btnDelAddReduceMaterial" type="button" style="width: 100px;">
                                        <asp:Label ID="lbl_2_9" runat="server" Text="ลบ"></asp:Label>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <script type="text/javascript">
                        $("#txtMaterialCode").attr('disabled', true).addClass('ui-state-disabled').keyup(function(e) {
                            if (e.keyCode == 13) {
                                if ($(this).val() != "") {
                                    searchMaterialFromTextBox($(this).val());
                                }
                                else {
                                    alert('<%=lbl_3_15.Text %>');
                                }
                            }
                        });
                        $("#txtAmount").attr('disabled', true).addClass('ui-state-disabled').addClass('ui-state-disabled').keyup(function(e) {
                            if (e.keyCode == 13) {
                                if ($(this).val() != "" && parseFloat($(this).val()) > 0)
                                    $("#slUnit").focus();
                                else
                                    alert('<%=lbl_3_16.Text %>');
                            }
                        }).click(function(){
                            $(this).select();
                            searchMaterialFromTextBox($("#txtMaterialCode").val());
                        });
                        $("#slUnit").attr('disabled', true).addClass('ui-state-disabled').keyup(function(e) {
                            if (e.keyCode == 13) {
                                $("#txtMaterialCode").focus();
                                addAdjDocDetail();
                            }
                        });

                        $("#txtSearchMaterialCode").keyup(function(e) {
                            if (e.keyCode == 13) {
                                if ($(this).val() != "") {
                                    searchMaterialFromDialog();
                                }
                            }
                        });
                        $("#txtSearchMaterialName").keyup(function(e) {
                            if (e.keyCode == 13) {
                                if ($(this).val() != "") {
                                    searchMaterialFromDialog();
                                }
                            }
                        });

                        $("#btnDelAddReduceMaterial").button({
                            icons: {
                                primary: 'icon-btn-cancel'
                            }
                        }).click(function() {
                            var adjGrid = $("#adjGrid");
                            //alert(adjGrid.jqGrid('getGridParam', 'selrow'));
                            if (adjGrid.jqGrid('getGridParam', 'selrow') == '' ||
                adjGrid.jqGrid('getGridParam', 'selrow') == null) {
                                alert($('#<%=lbl_3_4.ClientID %>').text());
                            } else {
                                $("#cfmDelMaterialDialog").dialog({
                                    width: 'auto',
                                    height: 100,
                                    modal: true,
                                    resizable: false
                                });
                            }
                        }).attr('disabled', true).addClass('ui-state-disabled');


                        $("#slAdjDocType").change(function() {
                            if ($("#slAdjDocType :selected").val() != "0") {
                                //loadWorkingDocument();
                            }
                        });

                        $("#slAdjType").change(function() {
                            loadDataJson();
                        });

                        $('#<%=ddlInv.ClientID %>').change(function() {
                            //$("#slAdjType").val('0');
                            $("#slAdjDocType").val('0');
                        });

                        $("#btnSearchMaterial").button({
                            icons: {
                                primary: 'icon-btn-search'
                            }, text: false
                        }).attr('disabled', true).addClass('ui-state-disabled').click(function() {
                            // Search Dialog
                            searchMaterialDialog();
                        });

                        $("#btnAddMaterial").button({
                            icons: {
                                primary: 'icon-btn-add'
                            }
                        }).attr('disabled', true).addClass('ui-state-disabled').click(function() {
                            // add material
                            addAdjDocDetail();
                        });
                    
                    </script>

                </div>
            </div>
            <div style="margin: 4px 0;">
                <table id="adjGrid" class="scroll">
                </table>
                <div id="adjPager" class="scroll">
                </div>
            </div>
            <div style="padding: 4px 8px; font-size: 1.1em; text-align: center;">
                <ul class="staff-create">
                    <li>
                        <asp:Label ID="lbl_3_19" runat="server" Text="" Style="font-weight: bold;"></asp:Label><span
                            id="insertStaff"></span></li>
                    <li>
                        <asp:Label ID="lbl_3_20" runat="server" Text="" Style="font-weight: bold;"></asp:Label><span
                            id="updateStaff"></span></li>
                    <li>
                        <asp:Label ID="lbl_3_22" runat="server" Text="" Style="font-weight: bold;"></asp:Label><span
                            id="cancelStaff"></span></li>
                    <li>
                        <asp:Label ID="lbl_3_21" runat="server" Text="" Style="font-weight: bold;"></asp:Label><span
                            id="approveStaff"></span></li>
                </ul>

                <script type="text/javascript">
                    $('#<%=lbl_3_19.ClientID %>').css('display', 'none');
                    $('#<%=lbl_3_20.ClientID %>').css('display', 'none');
                    $('#<%=lbl_3_21.ClientID %>').css('display', 'none');
                    $('#<%=lbl_3_22.ClientID %>').css('display', 'none');
                </script>

            </div>
        </div>
    </div>
    <div style="display: none;" id="searchMaterialDialog" title="Search Material">
        <div style="height: 30px; margin-bottom: 10px;" class="ui-widget-content">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tbody>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_11" runat="server" Text="รหัสวิตถุดิบ"></asp:Label>
                        </td>
                        <td>
                            <input type="text" class="txt" id="txtSearchMaterialCode" />
                        </td>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_12" runat="server" Text="ชื่อวัตถุดิบ"></asp:Label>
                        </td>
                        <td style="white-space: nowrap;">
                            <input type="text" class="txt" id="txtSearchMaterialName" />
                            <button type="button" id="btnSearchMaterialDialog" style="width: 70px;">
                                <span>Search</span>
                            </button>
                        </td>
                </tbody>
            </table>

            <script type="text/javascript">
                $("#btnSearchMaterialDialog").button({
                    icons: {
                        primary: 'icon-btn-search'
                    }
                }).click(function() {
                    // search Material from dialog
                    searchMaterialFromDialog();
                });
            </script>

        </div>
        <div style="width: 100%">
            <table id="searchMaterialGrid">
            </table>
            <div id="searchMaterialPager">
            </div>
        </div>
    </div>
    <div style="display: none; overflow: hidden;" id="approveDocumentDialog">
        <div style="padding: 4px 0">
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_1" runat="server" Text="คุณกำลังจะอนุมัติเอกสารนี้ แน่ใจหรือไม่ ?"></asp:Label>
            </span>
        </div>
        <div style="padding: 4px 0;">
            <div style="text-align: right;">
                <button id="btnConfirmApproveDocument">
                    <asp:Label ID="lbl_2_10" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelApproveDocument">
                    <asp:Label ID="lbl_2_11" runat="server" Text="ยกเลิก"></asp:Label></button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $("#btnConfirmApproveDocument").button({
            icons: {
                primary: 'icon-btn-ok'
            }
        }).click(function() {
            $("#approveDocumentDialog").dialog('close');
            approveDocument();
        });

        $("#btnCancelApproveDocument").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        }).click(function() {
            $("#approveDocumentDialog").dialog('close');
        });
    </script>

    <div style="display: none; overflow: hidden;" id="confirmCancelDocumentDialog">
        <div style="padding: 4px 0">
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_2" runat="server" Text="คุณกำลังจะ ยกเลิกเอกสารนี้ แน่ใจหรือไม่ ?"></asp:Label>
            </span>
        </div>
        <div style="padding: 4px 0;">
            <div style="text-align: right;">
                <button id="btnOkConfirmCancelDocumentDialog">
                    <asp:Label ID="lbl_2_12" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelConfirmCancelDocumentDialog">
                    <asp:Label ID="lbl_2_13" runat="server" Text="ยกเลิก"></asp:Label></button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $("#btnOkConfirmCancelDocumentDialog").button({
            icons: {
                primary: 'icon-btn-ok'
            }
        }).click(function() {
            $("#confirmCancelDocumentDialog").dialog('close');
            cancelAdjDocument();
        });

        $("#btnCancelConfirmCancelDocumentDialog").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        }).click(function() {
            $("#confirmCancelDocumentDialog").dialog('close');
        });
    </script>

    <div style="display: none; overflow: hidden;" id="cfmDelMaterialDialog">
        <div style="padding: 4px 0">
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_3" runat="server" Text="คุณกำลังจะลบวัตถุดิบนี้ แน่ใจหรือไม่ ?"></asp:Label>
            </span>
        </div>
        <div style="padding: 4px 0;">
            <div style="text-align: right;">
                <button id="btnOkDel">
                    <asp:Label ID="lbl_2_14" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelDel">
                    <asp:Label ID="lbl_2_15" runat="server" Text="ยกเลิก"></asp:Label></button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $("#btnOkDel").button({
            icons: { primary: 'icon-btn-ok' }
        }).click(function() {
            $("#cfmDelMaterialDialog").dialog('close');
            removeAddReduceDocDetail();
        });

        $("#btnCancelDel").button({
            icons: { primary: 'icon-btn-cancel' }
        }).click(function() {
            $("#cfmDelMaterialDialog").dialog('close');
        });

    </script>

    <div style="display: none; overflow: hidden;" id="mesgDialog">
        <div style="padding: 4px 0; margin-top: 4px;">
            <span style="font-size: 1.2em; font-weight: bold;" id="mesgText"></span>
        </div>
        <div style="padding: 4px 0;">
            <div style="text-align: right;">
                <button id="btnCloseMesgDialog" style="width: 70px;">
                    <asp:Label ID="lbl_2_16" runat="server" Text="ปิด"></asp:Label></button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $("#btnCloseMesgDialog").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        }).click(function() {
            $("#mesgDialog").dialog('close');
        });
    </script>

    <div id="loading" style="display: none; text-align: center">
        <div style="margin-left: 8px;">
            <span style="font-size: 14px; color: #333; font-family: Segoe UI, Tahoma, Arial;">กำลังทำงาน...</span>
        </div>
        <img src="../Images/loading7.gif" alt="loadding" />
    </div>
    <div id="searchAddReduceDocumentDialog" style="display: none; overflow: hidden;"
        title='<%=lbl_2_2.Text %>'>
        <div style="margin-bottom: 4px; padding: 4px;" class="ui-widget-content">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tbody>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_15" runat="server" Text="สถานะเอกสาร"></asp:Label>
                        </td>
                        <td>
                            <select id="slSearchAddReduceDocStatus" style="width: 150px;">
                                <option value="-1">--All--</option>
                                <option value="1">
                                    <asp:Label ID="lbl_3_12" runat="server"></asp:Label></option>
                                <option value="2">
                                    <asp:Label ID="lbl_3_13" runat="server"></asp:Label></option>
                                <option value="99">
                                    <asp:Label ID="lbl_3_14" runat="server"></asp:Label></option>
                            </select>
                        </td>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_13" runat="server" Text="จากวันที่"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDateFrom" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlMonthFrom" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlYearFrom" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_16" runat="server" Text="คลัง"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSearchAddReduceInv" runat="server" Style="width: 150px;">
                            </asp:DropDownList>
                        </td>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_14" runat="server" Text="ถึงวันที่"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDateTo" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlMonthTo" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlYearTo" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="paramlist_key">
                            เอกสาร
                            <asp:Label ID="lbl_1_17" runat="server" Text="" Style="display: none;"></asp:Label>
                        </td>
                        <td>
                            <select id="slSearchAddReduceDocument" style="width: 150px;">
                                <option value="add" style="display: none;">
                                    <asp:Label ID="lbl_1_19" runat="server" Text="ใบปรับเพิ่มสต๊อก"></asp:Label></option>
                                <option value="reduce">ใบเบิกสินค้า </option>
                            </select>
                            <asp:Label ID="lbl_1_20" runat="server" Text="ใบปรับลดสต๊อก" Style="display: none;"></asp:Label>
                        </td>
                        <td class="paramlist_key">
                        </td>
                        <td>
                            <button type="button" id="btnDialogSearch" style="width: 100px;">
                                <asp:Label ID="lbl_2_17" runat="server" Text="ค้นหา"></asp:Label>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_18" runat="server" Text="ชนิดเอกสาร"></asp:Label>
                        </td>
                        <td>
                            <select id="slSearchAddReduceDocType" style="width: 150px;">
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="clear: both; height: 1px;">
                &nbsp;</div>
        </div>
        <div style="margin-bottom: 4px;" id="searchAddReduceGridContent">
            <table id="searchAddReduceGrid">
            </table>
            <div id="searchAddReducePager">
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $("#slSearchAddReduceDocument").change(function() {
            loadSearchDataJson();
        });

        $("#btnDialogSearch").button({
            icons: {
                primary: 'icon-btn-search'
            }
        }).click(function() {
            //if ($("#slSearchAddReduceDocType :selected").val() != "0") {
            searchAddReduceGrid();
            //} else {
            //    alert('กรุณาเลือกชนิดเอกสารปรับ...');
            //}
        });
    </script>

    <!-- for alert in javascript -->
    <asp:Label ID="lbl_3_4" runat="server" Text="กรุณาเลือกวัตถุดิบที่คุณต้องการลบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_5" runat="server" Text="กรุณาเลือกชนิดเอกสาร" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_6" runat="server" Text="บันทึกข้อมูลเรียบร้อย." Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_7" runat="server" Text="บันทึกเอกสาร" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_8" runat="server" Text="ผิดพลาด ไม่สามารถบันทึกเอกสารได้" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_9" runat="server" Text="อนุมัติเอกสารเรียบร้อย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_10" runat="server" Text="อนุมัติเอกสาร" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_11" runat="server" Text="ผิดพลาด ไม่สามารถอนุมัติเอกสารได้"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_15" runat="server" Text="กรุณาใส่รหัสวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_16" runat="server" Text="กรุณใส่จำนวนวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_17" runat="server" Text="วัตถุดิบนี้ถูกใส่เข้าในรายการแล้ว"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_18" runat="server" Text="กรุณาระบุหมายเหตุ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_23" runat="server" Text="ไม่พบวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_24" runat="server" Text="คุณไม่สามารถสร้างเอกสารปรับสต๊อกได้ เนื่องจากมีการนับสต๊อกอยู่" Style="display: none;"></asp:Label>
    <!-- for colmodel -->
    <asp:Label ID="lbl_4_1" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_2" runat="server" Text="รหัสวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_3" runat="server" Text="ชื่อวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_4" runat="server" Text="หน่วย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_5" runat="server" Text="จำนวน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_6" runat="server" Text="รายการวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_7" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_8" runat="server" Text="เลขที่เอกสาร" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_9" runat="server" Text="วันที่เอกสาร" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_10" runat="server" Text="สถานะเอกสาร" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_11" runat="server" Text="หมายเหตุ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_12" runat="server" Text="ผลการค้นหา" Style="display: none;"></asp:Label>

    <script type="text/javascript">
        $("#searchAddReduceGrid").jqGrid({
            jsonReader: {
                repeatitems: false,
                root: "rows",
                page: "page",
                records: "records",
                total: "total",
                userData: "userData",
                cell: "",
                id: "0"
            },
            url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchAddReductDocument' +
            '&adjType=' + $("#slSearchAddReduceDocType :selected").val() +
         '&dateFrom=' + $('#<%=ddlDateFrom.ClientID %> :selected').val() +
         '&monthFrom=' + $('#<%=ddlMonthFrom.ClientID %> :selected').val() +
         '&yearFrom=' + $('#<%=ddlYearFrom.ClientID %> :selected').val() +
         '&dateTo=' + $('#<%=ddlDateTo.ClientID %> :selected').val() +
         '&monthTo=' + $('#<%=ddlMonthTo.ClientID %> :selected').val() +
         '&yearTo=' + $('#<%=ddlYearTo.ClientID %> :selected').val(),
            datatype: 'json',
            colNames: [$('#<%=lbl_4_7.ClientID %>').text(), $('#<%=lbl_4_8.ClientID %>').text(), $('#<%=lbl_4_9.ClientID %>').text(), $('#<%=lbl_4_10.ClientID %>').text(), $('#<%=lbl_4_11.ClientID %>').text(), "documentId", "status", "invId"],
            colModel: [{ "name": "id", "index": "id", "jsonmap": "id", "width": "20", "align": "right", "sortable": false }, { "name": "documentNumber", "index": "documentNumber", "jsonmap": "documentNumber", "width": "140", "sortable": false }, { "name": "documentDate", "index": "documentDate", "jsonmap": "documentDate", "width": "120", "sortable": false }, { "name": "documentStatus", "index": "documentStatus", "jsonmap": "documentStatus", "sortable": false }, { "name": "remark", "index": "remark", "jsonmap": "remark", "sortable": false }, { "name": "documentId", "index": "documentId", "jsonmap": "documentId", "sortable": false, "hidden": true }, { "name": "status", "index": "status", "jsonmap": "status", "sortable": false, "hidden": true }, { "name": "invId", "index": "invId", "jsonmap": "invId", "sortable": false, "hidden": true}],
            pager: '#searchAddReducePager',
            width: 770,
            height: 240, rowNum: -1,
            viewrecords: true, pgbuttons: false,
            pgtext: null,
            ondblClickRow: function(rowid, iRow, iCol, e) {
                loadAddReduceDocument(rowid);
            },
            gridComplete: function() {
                var ids = $(this).jqGrid('getDataIDs');
                if (ids.length > 0) {
                    for (var i = 0; i < ids.length; i++) {
                        var d = $(this).jqGrid('getRowData', ids[i]);
                        if (d.status == 1)
                            $(this).jqGrid('setRowData', ids[i], { documentStatus: '<%=lbl_3_12.Text %>' });
                        else if (d.status == 2)
                            $(this).jqGrid('setRowData', ids[i], { documentStatus: '<%=lbl_3_13.Text %>' });
                        else if (d.status == 99)
                            $(this).jqGrid('setRowData', ids[i], { documentStatus: '<%=lbl_3_14.Text %>' });
                    }
                }
            },
            caption: $('#<%=lbl_4_12.ClientID %>').text()
        });
        $("#searchAddReduceGrid").jqGrid('navGrid', '#searchAddReducePager', { edit: false, add: false, del: false, refresh: false, search: false });
    </script>

    <div style="text-align: center">
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
