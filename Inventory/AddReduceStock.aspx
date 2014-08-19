<%@ page language="C#" autoeventwireup="true" inherits="Inventory_AddReduceStock, App_Web_addreducestock.aspx.9758fd70" enableEventValidation="false" %>

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

    <script type="text/javascript" src="../scripts/regexNonNumeric.js"></script>
    <script type="text/javascript" src="../scripts/stockcount-util.js"></script>

    <script type="text/javascript">
        var unit_detail;
        var docStatus = 1;
        var documentId = 0;
        $(function () {
            ajaxWorking();
            loadDataJson();
            adjStockGrid();
            searchMaterialGrid();
        });

        function getUnitRatio(unitLargeId) {
            console.log(unitLargeId);
            var unitRatio = null;
            var unitList = unit_detail.unitList;
            for (var i = 0; i < unitList.length; i++) {
                if (unitLargeId == unitList[i].unitLargeId) {
                    unitRatio = {
                        unitLargeRatio: unitList[i].unitLargeRatio,
                        unitSmallRatio: unitList[i].unitSmallRatio
                    };
                    break;
                }
            }

            return unitRatio;
        }

        function getCurrStock() {
            var unitRatio = getUnitRatio($('#slUnit :selected').val());
            var unitName = $('#slUnit :selected').text();
            $('#txtCurrStock').val('');
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=getCurrStock' +
                    '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                    '&staffId=' + require_var.staffId +
                    '&staffRole=' + require_var.staffRole +
                    '&langId=' + require_var.langId +
                    '&materialId=' + $("#hidMaterialId").val() + 
                    '&unitLargeRatio=' + unitRatio.unitLargeRatio +
                    '&unitSmallRatio=' + unitRatio.unitSmallRatio,
                dataType: 'json',
                global: false,
                cache:false,
                success: function (data) {
                    console.log(JSON.stringify(data));
                    $("#currStockHide").val(data.currStock);
                    $('#txtCurrStock').val(data.currStock + unitName);
                },
                error: function (xhr, status) {
                    console.log(xhr.responseText);
                }
            });
        }

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
                        console.log(JSON.stringify(data));
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
                
                success: function(data) {

                    var slSearchAddReduceDocType = $("#slSearchAddReduceDocType");
                    var optAdjDocType = '';
                    $.each(data.adjDocType[0], function(index, item) {
                        optAdjDocType += '<option value="' + index + '">' + item + '</option>';
                    });
                    slSearchAddReduceDocType.html(optAdjDocType);

                    $("#slSearchAddReduceDocType").attr('disabled', false).removeClass('ui-state-disabled');
                }, error: function(xhr, s) {
                    alert(xhr.responseText);
                }
            });
        }

        function adjStockGrid() {
           
        }

        function searchAdjHistory() {
            $("#searchAdjHistoryDialog").dialog({
                dialogClass: 'dialogWithDropShadow',
                width: 'inherit',
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
            // clear search result

            $("#searchResult").html('').removeClass('ui-state-error');
            $("#searchMaterialDialog").dialog({
                dialogClass: 'dialogWithDropShadow',
                width: 'inherit',
                height: 540,
                modal: false,
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
                rowNum: 100000,
                pgbuttons: false,
                pgtext: null,
                height: 300,
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
                global: false,
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(), materialCode: materialCode }),
                complete: function(xhr, status) {
                    var data = eval('(' + xhr.responseText + ')');
                    if (data.notFound == 1) {
                        alert('<%=lbl_3_23.Text %>');
                    }
                    else {
                        if (data.unitList.length >= 1) {

                            unit_detail = data;
                            console.log(JSON.stringify(unit_detail));

                            $("#txtAmount").select();
                            $("#txtMaterialCode").val(data.materialCode);
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

                            getCurrStock();
                            $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                        } else {
                            $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
                            alert('<%=lbl_3_17.Text %>');
                        }
                    }
                },
                success: function(data) {
                    //alert(data.notFound);

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
                    var data = eval('(' + xhr.responseText + ')');
                    if (data.notFound == 1) {
                        alert('<%=lbl_3_23.Text %>');
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
                            getCurrStock();
                            //alert(slUnit);
                        } else {
                            //alert('วัตถุดิบนี้ไม่มีหน่วย');
                            //var gridData = adjGrid.jqGrid('getRowData', selectedRowID);
                            var docDetailId = gridData.docdetailid;
                            var materialId = gridData.mid;
                            getUnitWhenEditCell(selectedRowID, docDetailId, materialId);
                        }
                    }
                },
                success: function(data) {

                }, error: function(xhr, status) {
                    alert('Error ' + xhr.responseText);
                }
            });
        }

        function searchMaterialFromDialog() {
            var materialCode = $("#txtSearchMaterialCode").val() != "" ? $("#txtSearchMaterialCode").val(): "";
            var materialName = materialCode;  //$("#txtSearchMaterialName").val() != "" ? $("#txtSearchMaterialName").val() : "";
            var materialGroupId = $("#slMaterialGroup :selected").val() != 0 ? $("#slMaterialGroup :selected").val() : 0;
            var materialDeptId = $("#slMaterialDept :selected").val() != 0 ? $("#slMaterialDept :selected").val() : 0;
            //console.log($('input[name=searchFor]:radio:checked').val());
            if ($('input[name=searchFor]:radio:checked').val() == "bycode")
                materialName = "";
            else if ($('input[name=searchFor]:radio:checked').val() == "byname")
                materialCode = "";
            
            if (materialCode != "") {
                materialDeptId = 0;
                materialGroupId = 0;
            }
            $.ajax({
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=searchMaterialFromDialog&documentId=' + documentId +
                      '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole +
                '&langId=' + require_var.langId,
                dataType: 'xml',
                type: 'POST',
                //global: false,
                data: ({ inv: $('#<%=ddlInv.ClientID %> :selected').val(), materialCode: materialCode,
                    materialName: materialName, materialGroupId: materialGroupId, materialDeptId: materialDeptId
                }),
                complete: function(xhr, status) {
                    var searchMaterialGrid = $("#searchMaterialGrid")[0];
                    searchMaterialGrid.addXmlData(xhr.responseXML);

                    if ($("#searchMaterialGrid").jqGrid('getGridParam', 'records') == 0)
                        $("#searchResult").html('<span style="float:left" class="ui-icon ui-icon-alert"></span>' + ' <%=lbl_3_23.Text %>').addClass('ui-state-error');
                    else
                        $("#searchResult").html('').removeClass('ui-state-error');

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
                //global: false,
                complete: function(xhr, status) {
                    var grid = $("#adjGrid")[0];
                    grid.addXmlData(xhr.responseXML);
                    //scrollToRow("#adjGrid", $("#adjGrid").jqGrid('getGridParam', 'records'));
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
                    complete: function (xhr, status) {
                        try {
                            var data = eval('(' + xhr.responseText + ')');
                            if (data.approve != null) {
                                if (data.approve == '1') {
                                    alert('<%=lbl_3_9.Text %>');

                                    window.location = 'AddReduceStock.aspx?StaffID=' + require_var.staffId +
                                        '&StaffRoleID=' + require_var.staffRole +
                                        '&LangID=' + require_var.langId;
                                }
                                else {
                                    alert('<%=lbl_3_11.Text %>');
                                }
                            } else {
                                // stock not enough
                                $("#alert_msg").text('<%=lbl_3_26.Text %>');
                                alertDialog();

                                var adjGrid = $("#adjGrid");
                                var records = adjGrid.jqGrid('getGridParam', 'records');

                                // show column stock
                                //adjGrid.jqGrid('setGridParam', {currstock:hidde});
                                if (records > 0) {
                                    for (var i = 1; i <= records; i++) {
                                        var rowData = adjGrid.jqGrid('getRowData', i);
                                        var materialId = rowData.mid;
                                        console.log(data.length);
                                        if (data.length > 0) {
                                            for (var j = 0; j < data.length; j++) {
                                                if (materialId == data[j].MaterialID) {
                                                    console.log('found');
                                                    adjGrid.jqGrid('setRowData', i,
                                                        { currstock: data[j].CurrentStockSmallAmount });
                                                    
                                                    adjGrid.jqGrid('setCell', i, 0, '', { 'background': '#F53333', 'color': '#FFFFFF' });
                                                    adjGrid.jqGrid('setCell', i, 3, '', { 'background': '#F53333', 'color': '#FFFFFF' });
                                                }
                                            }
                                        }
                                    }
                                }
                                //console.log(JSON.stringify(data));
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
        function updateAdjDocDetail(successFunc) {
            //alert(idx + ' ' + docDetailId + ' ' + materialId + ' ' + unitLargeId + ' ' + amount);
            if (parseFloat($("#txtAmountEdit").val()) > 0) {
                var theGrid = $("#adjGrid");
                var selRow = theGrid.jqGrid('getGridParam', 'selrow');
                var rowData = theGrid.jqGrid('getRowData', selRow);

                $.ajax({
                    url: 'DataXML/AdjustDocumentDataXML.aspx?action=updateAdjustDocdetail&documentId=' + documentId +
                      '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                    dataType: 'json',
                    type: 'POST',
                    data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                        '&materialId=' + rowData.mid + '&materialAmount=' + $("#txtAmountEdit").val() +
                        '&unitLargeId=' + rowData.unitLargeId + '&currStock=' + $("#txtCurrStock").val() + 
                        '&indexInList=' + rowData.docDetailIdx,
                    complete: function(xhr, status) {
                        var data = eval("(" + xhr.responseText + ")");
                        if (data.updateAdjDocDetail == 1) {
                            loadAdjDocDetail();

                            // callback
                            successFunc();
                        }
                    }
                });
            } else {

                alert('<%=lbl_3_16.Text %>');
            }
        }

        // Remove docDetail before edit
        function removeAddReduceDocDetailBeforeEdit() {
            var addReduceGrid = $("#adjGrid");

            var rowCheckedDel = addReduceGrid.jqGrid('getGridParam', 'selrow');
            console.log(rowCheckDel);

            if (rowCheckedDel > 0) {
                var adjGridData = addReduceGrid.jqGrid('getRowData', rowCheckedDel);

                var url = 'DataXML/AdjustDocumentDataXML.aspx?action=removeAddReduceMaterial&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                 '&documentId=' + documentId + '&docDetailId=' + adjGridData.docdetailid +
                 '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole +
                '&langId=' + require_var.langId;

                $.ajax({
                    url: url,
                    type: 'GET',
                    dataType: 'xml',
                    cache: false,
                    complete: function (xhr, status) {

                    }
                });
            }
        }

        // Remove docDetail
        function removeAddReduceDocDetail() {
            var addReduceGrid   = $("#adjGrid");
            var rowCheckedDel   = addReduceGrid.jqGrid('getGridParam', 'selrow');

            var adjGridData = addReduceGrid.jqGrid('getRowData', rowCheckedDel);

            var url = 'DataXML/AdjustDocumentDataXML.aspx?action=removeAddReduceMaterial&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
             '&documentId=' + documentId + '&docDetailId=' + adjGridData.docdetailid +
             '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId;

            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'xml',
                cache: false,
                //global:false,
                complete: function (xhr, status) {
                    
                    clearInputMaterial();

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
            // remove if check for edit
            //removeAddReduceDocDetailBeforeEdit();

            // change btntext to add
           //$("#btnAddMaterial").text('<%=lbl_2_8.Text %>');

            if ($("#txtMaterialCode").val() != "") {
                if (parseFloat($("#txtAmount").val()) > 0) {
                    // unit ratio
                    var unitRatio = getUnitRatio($('#slUnit :selected').val());
                    console.log(JSON.stringify(unitRatio));

                    $.ajax({
                        url: 'DataXML/AdjustDocumentDataXML.aspx?action=addAdjustDocDetail' +
                        '&documentId=' + documentId +
                         '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                        dataType: 'json',
                        type: 'POST',
                        //global: false,
                        data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&materialId=' + $("#hidMaterialId").val() + '&materialAmount=' + $("#txtAmount").val() +
                            '&unitLargeId=' + $("#slUnit :selected").val() + '&unitLargeRatio=' + unitRatio.unitLargeRatio + 
                            '&unitSmallRatio=' + unitRatio.unitSmallRatio + '&currStock=' + $("#txtCurrStock").val() +
                            '&stock=' + $("#currStockHide").val(),
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
                                    $("#txtCurrStock").val('');
                                    // add data to grid
                                    loadAdjDocDetail();
                                } else if(data.addAdjDocDetail == -1){
                                    $("#alert_msg").text('<%=lbl_3_26.Text %>');
                                    alertDialog();
                                }else {
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
                complete: function (xhr, status) {
                    try {
                        var data = eval("(" + xhr.responseText + ")");
                        if (data.cancelAdjDoc == 1) {
                            window.location = 'AddReduceStock.aspx?StaffID=' + require_var.staffId +
                                    '&StaffRoleID=' + require_var.staffRole +
                                    '&LangID=' + require_var.langId;
                        } else if (data.notAllowCancel) {
                            $("#alert_msg").text(data.msg);
                            alertDialog();
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

                            $('#btnAdjustStock').css('display', 'none');

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
                    console.log(JSON.stringify(data));
                    var slMunit = $("#" + rowid + "_munit");
                    var optUnit = "";
                    if (data.unitList.length >= 1) {
                        for (var i = 0; i <= data.unitList.length - 1; i++) {
                            optUnit += '<option value="' + data.unitList[i].unitLargeId + '">' + data.unitList[i].unitName + '</option>';
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
                //global: false,
                cache: false,
                data: '&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                    '&docDetailId=' + '-1' + '&materialId=' + materialId,
                complete: function(xhr, status) {
                    try {
                        var data = eval('(' + xhr.responseText + ')');

                        unit_detail = data;
                        console.log(JSON.stringify(unit_detail));

                        var slAddUnit = $("#slUnit");
                        var optUnit = "";
                        if (data.unitList.length >= 1) {
                            for (var i = 0; i <= data.unitList.length - 1; i++) {
                                optUnit += '<option value="' + data.unitList[i].unitLargeId + '">' + data.unitList[i].unitName + '</option>';
                            }
                            slAddUnit.html(optUnit);
                            getCurrStock();

                            $("#btnAddMaterial").attr('disabled', false).removeClass('ui-state-disabled');
                        } else {
                            alert('<%=lbl_3_17.Text %>');
                            $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
                        }
                    }
                    catch (e) {
                        alert('<%=lbl_3_17.Text %>');
                            $("#btnAddMaterial").attr('disabled', true).addClass('ui-state-disabled');
                        //alert(xhr.responseText);
                    }
                }
            });
        }

        function addMaterialToSearchTextBoxEditMode(materialId, materialCode, materialName, stock, amount, unitId, unitName) {
            // change btntext to edit
            $("#btnAddMaterial").css('display', 'none');
            $("#btnEditMaterial").css('display', '');
            $("#btnCancelEdit").css('display', '');
            $("#txtMaterialCode").css('display', 'none');
            $("#txtAmount").css('display', 'none');
            $("#btnSearchMaterial").css('display', 'none');

            $("#txtMaterialCodeEdit").css('display', '').val(materialCode);
            $("#hidMaterialId").val(materialId);
            $("#txtAmountEdit").css('display', '').val(amount).select();
            $("#txtCurrStock").val(stock);

            var opt = '<option value="' + unitId + '">' + unitName + '</option>';
            $("#slUnit").html(opt);
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
                url: 'DataXML/AdjustDocumentDataXML.aspx?action=loadAddReduceDocumentDataJSON&inv=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&documentId=' + documentId +
                 '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                //global: false,
                cache: false,
                complete: function (xhr, status) {
                    try {
                        var data = eval('(' + xhr.responseText + ')');
                        //console.log(JSON.stringify(data));

                        $("#documentType").html(data.documentType);
                        $("#documentNumber").html(data.documentNumber);
                        $("#txtAdjDate").html(data.documentDate);

                        $("#remark").val(data.remark);

                        $("#slAdjDocType").val(data.documentTypeId);
                        $("#ddlDay").val(data.documentDay);
                        $("#ddlMonth").val(data.documentMonth);
                        $("#ddlYear").val(data.documentYear);

                        if (data.documentStatusId == 0 || data.documentStatusId == 1 || data.documentStatusId == 2 || data.documentStatusId == 99) {

                            if (data.documentStatusId == 1) {
                                $("#documentStatus").html('<%=lbl_3_12.Text %>');

                                $('#<%=lbl_3_19.ClientID %>').css('display', '');
                                $('#<%=lbl_3_20.ClientID %>').css('display', '');
                                $("#insertStaff").html(" " + data.insertStaff);
                                $("#updateStaff").html(" " + data.updateStaff);

                                $("#btnCancel").attr('disabled', false).removeClass('ui-state-disabled');


                                $("#ddlDay").attr('disabled', true);
                                $("#ddlMonth").attr('disabled', true);
                                $("#ddlYear").attr('disabled', true);
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

                                $("#ddlDay").attr('disabled', true);
                                $("#ddlMonth").attr('disabled', true);
                                $("#ddlYear").attr('disabled', true);
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
            $("#historyLoadStatus").css('display', '');
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

        function clearInputMaterial() {
            $("#btnDelAddReduceMaterial").css('display', 'none');

            // change btntext to edit
            $("#btnAddMaterial").css('display', '');
            $("#btnEditMaterial").css('display', 'none');
            $("#btnCancelEdit").css('display', 'none');
            $("#txtMaterialCode").css('display', '').val('');
            $("#txtAmount").css('display', '').val('');
            $("#btnSearchMaterial").css('display', '');

            $("#txtMaterialCodeEdit").css('display', 'none').val('');
            $("#txtAmountEdit").css('display', 'none').val('');
            $("#txtCurrStock").val('');

            $("#slUnit").html('');
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="require_var" style="display:none;" runat="server">
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
                        <asp:Label ID="lbl_1_1" runat="server" Text="ปรับลด-เพิ่ม"></asp:Label></div>
                </div>
            </div>
            <div style="float: right;">
                <button id="btnAdjustStock" type="button" style="margin: 0 2px 0 10px;" class="btn">
                    <asp:Label ID="lbl_2_1" Text="สร้างเอกสาร" runat="server" CssClass="btn"></asp:Label></button>
                <button id="btnSearchAddReduceDocument" type="button" style="margin: 0 2px 0 10px;"
                    class="btn">
                    <asp:Label ID="lbl_2_2" Text="ค้นหาเอกสาร" runat="server" ></asp:Label></button>
                <button id="btnSaveDocument" type="button" style="margin: 0 2px 0 10px;" class="btn">
                    <asp:Label ID="lbl_2_3" Text="บันทึกเอกสาร" runat="server"  CssClass="btn"></asp:Label></button>
                <button id="btnApproveDocument" type="button" style="margin: 0 2px 0 10px;" class="btn">
                    <asp:Label ID="lbl_2_4" Text="อนุมัติเอกสาร" runat="server"  CssClass="btn"></asp:Label></button>
                <button id="btnCancel" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_5" Text="ยกเลิกเอกสาร" runat="server"  CssClass="btn"></asp:Label></button>
                <button id="btnExportExcel" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_6" Text="Export Excel" runat="server" CssClass="btn"></asp:Label></button>
                <button id="btnPrintReport" type="button" style="margin-right: 2px;" class="btn">
                    <asp:Label ID="lbl_2_7" Text="พิมพ์" runat="server" CssClass="btn"></asp:Label></button>

                <script type="text/javascript">
                    //-- btn search document
                    $("#btnSearchAddReduceDocument").button({
                        icons: {
                            primary: 'icon-btn-search'
                        }
                    }).click(function () {
                        searchAddReduceGrid();
                        $("#searchAddReduceDocumentDialog").dialog({
                            dialogClass: 'dialogWithDropShadow',
                            width: 'inherit',
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
                        if (docStatus == 2 || docStatus==99) {
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
                        window.open('Report/CrAddReduceStock.aspx?ReportName=Add Reduce Stock&langId=' + require_var.langId, '', 'location=1,status=1,scrollbars=1');
                    }).attr('disabled', true).addClass('ui-state-disabled');
                    $("#btnCancel").button({
                        icons: {
                            primary: 'icon-action-cancel'
                        }
                    }).click(function() {
                        // cancel document func
                        $("#confirmCancelDocumentDialog").dialog({
                            title: '<%=lbl_2_5.Text %>',
                            dialogClass: 'dialogWithDropShadow noTitleStuff',
                            width: 'inherit',
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
                            dialogClass: 'dialogWithDropShadow noTitleStuff',
                            width: 'inherit',
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
                                    <asp:Label ID="lbl_1_7" runat="server" Text="ประเภทการปรับ"></asp:Label>
                                </td>
                                <td>
                                    <select id="slAdjType" style="width: 150px; margin-left: 4px;">
                                        <option value="add">
                                            <%=lbl_1_19.Text %></option>
                                        <option value="reduce">
                                            <%=lbl_1_20.Text %></option>
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
                                    <input type="text" id="txtMaterialCodeEdit" readonly="readonly" style="width: 180px; display:none;" class="txt"/>

                                    <script type="text/javascript">
                                        $("#txtMaterialCode").autocomplete({
                                            delay: 0,
                                            source: function(request, response) {
                                                $.ajax({
                                                    url: 'DataXML/MaterialListDataXML.aspx?action=smat&invId=' + 
                                                    $('#<%=ddlInv.ClientID %> :selected').val() + '&matCode=' + $("#txtMaterialCode").val() +
                                                      '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                                                    dataType: 'json',
                                                    global: false,
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
                                    <input type="hidden" id="currStockHide" />
                                    <input type="text" id="txtCurrStock" style="color:blue; width:100px;" readonly="readonly" class="txt txt-numeric" />
                                    <input type="text" id="txtAmount" style="width: 70px; text-align: right;" class="txt txt-numeric" />
                                    <input type="text" id="txtAmountEdit" style="display:none; width: 70px; text-align: right;" class="txt txt-numeric" />
                                    <select id="slUnit" style="width: 100px; padding: 2px 1px; height: 25px;" class="select"
                                        name="D1">
                                    </select>
                                    &nbsp;
                                    <button id="btnAddMaterial" type="button" style="width: 100px;">
                                        <asp:Label ID="lbl_2_8" runat="server" Text="เพิ่ม"></asp:Label>
                                    </button>
                                    <button id="btnEditMaterial" type="button" style="width: 100px; display:none;">
                                        <%=lbl_2_18.Text %>
                                    </button>
                                     <button id="btnCancelEdit" type="button" style="width: 100px; display:none;">
                                        <%=lbl_2_19.Text %>
                                    </button>
                                    <button id="btnDelAddReduceMaterial" type="button" style="width: 100px; display:none;">
                                        <asp:Label ID="lbl_2_9" runat="server" Text="ลบ"></asp:Label>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <script type="text/javascript">
                        $("#txtAmountEdit").click(function () {
                            $(this).select();
                        });

                        $("#slUnit").change(function () {
                            getCurrStock();
                        });

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
                            //searchMaterialFromTextBox($("#txtMaterialCode").val());
                        });
                        $("#slUnit").attr('disabled', true).addClass('ui-state-disabled').keyup(function(e) {
                            if (e.keyCode == 13) {
                                $("#txtMaterialCode").focus();
                                addAdjDocDetail();
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
                                primary: 'ui-icon-trash'
                            }
                        }).click(function() {
                            var adjGrid = $("#adjGrid");
                            //alert(adjGrid.jqGrid('getGridParam', 'selrow'));
                            if (adjGrid.jqGrid('getGridParam', 'selrow') == '' ||
                        adjGrid.jqGrid('getGridParam', 'selrow') == null) {
                                alert($('#<%=lbl_3_4.ClientID %>').text());
                            } else {
                            $("#cfmDelMaterialDialog").dialog({
                                    dialogClass: 'dialogWithDropShadow noTitleStuff',
                                    width: 'inherit',
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
                            $('#slSearchAddReduceDocument').val($('#slAdjType :selected').val());
                        });

                        $('#<%=ddlInv.ClientID %>').change(function() {
                            //$("#slAdjType").val('0');
                            $("#slAdjDocType").val('0');
                        }).val(require_var.dbShopId);

                        $("#btnSearchMaterial").button({
                            icons: {
                                primary: 'ui-icon-search'
                            }, text: false
                        }).attr('disabled', true).addClass('ui-state-disabled').click(function() {
                            // Search Dialog
                            searchMaterialDialog();
                        });

                        $("#btnEditMaterial").button({
                            icons: {
                                primary: 'ui-icon-wrench'
                            }
                        }).click(function () {
                            updateAdjDocDetail(function () {
                                clearInputMaterial();
                            });
                            
                        });

                        $("#btnCancelEdit").button({
                            icons: {
                                primary: 'ui-icon-arrowreturnthick-1-w'
                            }
                        }).click(function () {
                            clearInputMaterial();
                        });

                        $("#btnAddMaterial").button({
                            icons: {
                                primary: 'ui-icon-plus'
                            }
                        }).attr('disabled', true).addClass('ui-state-disabled').click(function() {
                            // add material
                            addAdjDocDetail();
                        });
                    
                    </script>

                </div>
            </div>
            <div style="margin: 4px 4px;" id="grid-content">
                <table id="adjGrid">
                </table>
                <div id="adjPager">
                </div>
            </div>
            <script type="text/javascript">
                var grid = $("#adjGrid");
                $("#adjGrid").jqGrid({
                    url: 'DataXML/AdjustDocumentDataXML.aspx?action=load&documentId=' + documentId +
                 '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
                    datatype: 'xml',
                    colNames: ['<%=lbl_4_1.Text%>', '<%=lbl_4_2.Text%>', '<%=lbl_4_3.Text%>', '<%=lbl_4_13.Text %>', '<%=lbl_4_5.Text%>', '<%=lbl_4_4.Text%>', '', 'MaterialID', 'docDetailId', 'unitLargeId', 'docDetailIdx'],
                    colModel: [
                { "name": "id", "index": "id", "align": "center", "sortable":false, "width":10 },
                { "name": "mcode", "index": "mcode", "width": 100 },
                { "name": "mname", "index": "mname", "width": 150 },
                { "name": "currstock", "index": "currstock", "width": 40, "align": "right" },
                { "name": "madjamount", "index": "madjamount", "width": 40, "align": "right" },
                { "name": "munit", "index": "munit", "width": 20 },
                { "name": "space", "index": "space", "width": 10},
                { "name": "mid", "index": "mid", "hidden": true, "width": 1 },
                { "name": "docdetailid", "index": "docdetailid", "hidden": true, "width": 1 },
                { "name": "unitLargeId", "index": "unitLargeId", "hidden": true, "width": 1 },
                { "name": "docDetailIdx", "index": "docDetailIdx", "hidden": true, "width": 1 }
                ],
                    pager: '#adjPager',
                    rowNum: -1,
                    loadui: 'disable',
                    scrollrows: true,
                    pgbuttons: false,
                    pgtext: null,
                    //multiselect: true,
                    //multiboxonly: true,
                    height: 300,
                    autowidth: false,
                    viewrecords: true,
                    caption: '<%=lbl_4_6.Text %>',
                    /*afterEditCell: function (rowid, colName, value, iRow, iCol) {
            
                },*/
                    //                beforeSelectRow: function(rowid, e) {
                    //                    if (e.srcElement.type == "checkbox") {
                    //                        return true;
                    //                    }
                    //                    return false;
                    //                },
                    //                beforeSelectRow: function(rowid, e) {
                    //                    var cbsdis = $("tr#" + rowid + ".jqgrow > td > input.cbox:disabled", grid[0]);
                    //                    if (cbsdis.length === 0) {
                    //                        return true;    // allow select the row
                    //                    } else {
                    //                        return false;   // not allow select the row
                    //                    }
                    //                },
                    //                onSelectAll: function(aRowids, status) {
                    //                    if (status) {
                    //                        // uncheck "protected" rows
                    //                        var cbs = $("tr.jqgrow > td > input.cbox:disabled", grid[0]);
                    //                        cbs.removeAttr("checked");

                    //                        //modify the selarrrow parameter
                    //                        grid[0].p.selarrrow = grid.find("tr.jqgrow:has(td > input.cbox:checked)")
                    //                .map(function() { return this.id; }) // convert to set of ids
                    //                .get(); // convert to instance of Array
                    //                    }
                    //                }, /*
                    //                ondblClickRow: function(rowid, iRow, iCol, e) {
                    //                    if (editing !== "edit") {
                    //                        editing = "edit";
                    //                        selectedRowID = rowid;
                    //                        $(this).editRow(rowid, false, onEditFunc);
                    //                    }
                    //                },*/
                    onSelectRow: function (rowid) {
                        $("#btnDelAddReduceMaterial").css('display', '');

                        var selRow = $(this).jqGrid('getGridParam', 'selrow');
                        var rowData = $(this).jqGrid('getRowData', selRow);
                        var materialId = rowData.mid;
                        var materialCode = rowData.mcode;
                        var materialName = rowData.mname;
                        var amount = rowData.madjamount;
                        var stock = rowData.currstock;
                        var unitId = rowData.unitLargeId;
                        var unitName = rowData.munit;

                        addMaterialToSearchTextBoxEditMode(materialId, materialCode, materialName, stock, amount, unitId, unitName);
                    },
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
                    $("#adjGrid").setGridWidth($("#grid-content").width());
                }).trigger('resize');
            </script>
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
    <div style="display:none;" id="searchMaterialDialog" title="<%=lbl_4_14.Text %>">
        <div style="height: auto; margin-bottom: 10px;" class="ui-widget-content">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tbody>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_21" runat="server" Text="ค้นหาตาม"></asp:Label>
                        </td>
                        <td>
                            <input type="radio" id="rdo_by_Code" name="searchFor" checked="checked" value="bycode" />
                            <asp:Label ID="lbl_1_23" runat="server"></asp:Label>
                            <input type="radio" id="rdo_by_name" name="searchFor" value="byname" />
                            <asp:Label ID="lbl_1_24" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_11" runat="server" Text="คีย์ค้นหา"></asp:Label>
                        </td>
                        <td>
                            <input type="text" class="txt" id="txtSearchMaterialCode" onkeyup="keyupSearchMatCode(event)" style="float:left;"/>
                          
                            <button type="button" style="padding-top:-6px; float:left;" id="btnSearchMat" onclick="clickSearchMatCode();"><%=lbl_2_17.Text %></button>
                    
                            <span id="searchResult" style="font-size:1.2em;" class="ui-state-error-text"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="paramlist_key">
                            <asp:Label ID="lbl_1_12" runat="server" Text="กลุ่มวัตถุดิบ"></asp:Label>
                        </td>
                        <td>
                            <select id="slMaterialGroup" style="min-width: 170px;"></select>
                        </td>
                        
                    </tr>
                    <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_22" runat="server" Text="หมวดวัตถุดิบ"></asp:Label>
                            </td>
                            <td>
                                <select id="slMaterialDept" style="min-width: 170px;"></select>
                            </td>
                    </tr>
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
    <script type="text/javascript">
        function keyupSearchMatCode(e) {
            if (e.keyCode == 13) {
                if ($('#txtSearchMaterialCode').val() != "") {
                    searchMaterialFromDialog();
                }
            }
        }

        function clickSearchMatCode() {
            if ($('#txtSearchMaterialCode').val() != "") {
                searchMaterialFromDialog();
            }
        }

        function loadMaterialDept() {
            $.ajax({
                url: 'DataXML/MaterialListDataXML.aspx?action=ListMaterialDeptJson' +
                                     '&materialGroupId=' + $("#slMaterialGroup :selected").val() +
                                '&staffId=' + require_var.staffId + '&staffRole=' + require_var.staffRole +
                                '&langId=' + require_var.langId,
                type: 'GET',
                dataType: 'json',
                complete: function(xhr, status) {
                    var materialObj = eval('(' + xhr.responseText + ')');

                    //alert(JSON.stringify(materialObj));
                    var matDeptOpt = "";
                    for (var i = 0; i < materialObj.materialDeptList.length; i++) {
                        var materialDeptList = materialObj.materialDeptList[i];
                        matDeptOpt += '<option value="' + materialDeptList.materialDeptId + '">' + materialDeptList.materialDeptName + '</option>';
                    }
                    $("#slMaterialDept").html(matDeptOpt).change(function() {
                        $("#txtSearchMaterialCode").val(''); searchMaterialFromDialog();
                    });
                    searchMaterialFromDialog();
                }
            });
        }

        $.ajax({
            url: 'DataXML/MaterialListDataXML.aspx?action=ListMaterialGroupJson' +
                                '&staffId=' + require_var.staffId + '&staffRole=' + require_var.staffRole +
                                '&langId=' + require_var.langId,
            type: 'GET',
            dataType: 'json',
            complete: function(xhr, status) {
                var materialObj = eval('(' + xhr.responseText + ')');

                //alert(JSON.stringify(materialObj));
                var matGroupOpt = "";
                for (var i = 0; i < materialObj.materialGroupList.length; i++) {
                    var materialGroupList = materialObj.materialGroupList[i];
                    matGroupOpt += '<option value="' + materialGroupList.materialGroupId + '">' + materialGroupList.materialGroupName + '</option>';
                }
                $("#slMaterialGroup").html(matGroupOpt).change(function() {
                    $("#txtSearchMaterialCode").val(''); loadMaterialDept()
                });

                loadMaterialDept();
            }
        });
                        </script>
    <div style="display: none; overflow: hidden;" id="approveDocumentDialog">
        <p>
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_1" runat="server" Text="คุณกำลังจะอนุมัติเอกสารนี้ แน่ใจหรือไม่ ?"></asp:Label>
            </span>
        </p>
        <p style="text-align:right; border-top:#ccc 1px solid; padding:4px 0 0 0; margin:0;">
            
                <button id="btnConfirmApproveDocument">
                    <asp:Label ID="lbl_2_10" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelApproveDocument">
                    <asp:Label ID="lbl_2_11" runat="server" Text="ยกเลิก"></asp:Label></button>
           
        </p>
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
        <p>
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_2" runat="server" Text="คุณกำลังจะ ยกเลิกเอกสารนี้ แน่ใจหรือไม่ ?"></asp:Label>
            </span>
        </p>
        <p style="text-align:right; border-top:#ccc 1px solid; padding:4px 0 0 0; margin:0;">
            
                <button id="btnOkConfirmCancelDocumentDialog">
                    <asp:Label ID="lbl_2_12" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelConfirmCancelDocumentDialog">
                    <asp:Label ID="lbl_2_13" runat="server" Text="ยกเลิก"></asp:Label></button>
            
        </p>
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
        <p>
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_3" runat="server" Text="คุณกำลังจะลบวัตถุดิบนี้ แน่ใจหรือไม่ ?"></asp:Label>
            </span>
        </p>
        <p style="text-align:right; border-top:#ccc 1px solid; padding:4px 0 0 0; margin:0;">
                <button id="btnOkDel">
                    <asp:Label ID="lbl_2_14" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelDel">
                    <asp:Label ID="lbl_2_15" runat="server" Text="ยกเลิก"></asp:Label></button>
            
        </p>
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
        <p>
            <span style="font-size: 1.2em; font-weight: bold;" id="mesgText"></span>
        </p>
        <p style="text-align:right; border-top:#ccc 1px solid; padding:4px 0 0 0; margin:0;">
            
                <button id="btnCloseMesgDialog" style="width: 70px;">
                    <asp:Label ID="lbl_2_16" runat="server" Text="ปิด"></asp:Label></button>
            
        </p>
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

    <div id="loading" style="display: none; overflow: hidden;">
        <div style="margin-left: 8px;" class="ui-widget">
            <img src="../Images/loadingSmall.gif" alt="" style="margin-right:2px;" /><asp:Label ID="lbl_3_25" runat="server" Text="รอสักครู่..." Style="font-size: 14px;
                color: #333; font-family: Segoe UI, Tahoma, Arial;"></asp:Label>
        </div>
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
                            <asp:Label ID="lbl_1_17" runat="server" Text="ประเภทการปรับ"></asp:Label>
                        </td>
                        <td>
                            <select id="slSearchAddReduceDocument" style="width: 150px;">
                                <option value="add">
                                    <asp:Label ID="lbl_1_19" runat="server" Text="ใบปรับเพิ่มสต๊อก"></asp:Label></option>
                                <option value="reduce">
                                    <asp:Label ID="lbl_1_20" runat="server" Text="ใบปรับลดสต๊อก"></asp:Label></option>
                            </select>
                        </td>
                        <td class="paramlist_key">
                        </td>
                        <td>
                            <button type="button" id="btnDialogSearch" style="width: 100px;">
                                <asp:Label ID="lbl_2_17" runat="server" Text="ค้นหา"></asp:Label>
                            </button>
                            <img src="../Images/loadingSmall.gif" alt="" id="historyLoadStatus" style="display:none;" />
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
        $('#<%=ddlSearchAddReduceInv.ClientID %>').val(require_var.dbShopId);
        $("#slSearchAddReduceDocument").change(function () {
            $("#slSearchAddReduceDocType").attr('disabled', true).addClass('ui-state-disabled');
            loadSearchDataJson();
            $("#slAdjType").val($("#slSearchAddReduceDocument :selected").val());
            $("#slAdjType").change();
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
    <!-- alert dialog -->
    <div style="display:none; width:auto; overflow:hidden;" id="dialog_alert">
        <p>
            <span id="dialog_alert_icon" class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
            <span id="alert_msg" style="font-size:1.1em;"></span>
        </p>
    </div>
        
    <asp:Label ID="lbl_2_18" runat="server" Text="แก้ไข" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_2_19" runat="server" Text="ยกเลิก" Style="display: none;"></asp:Label>
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
    <asp:Label ID="lbl_3_26" runat="server" Text="จำนวนคงเหลือในสต๊อกไม่พอ" Style="display: none;"></asp:Label>

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
        
    <asp:Label ID="lbl_4_13" runat="server" Text="จำนวนปัจจุบัน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_14" runat="server" Text="ค้นหาวัตถุดิบ" Style="display: none;"></asp:Label>

    <script type="text/javascript">
        function alertDialog() {
            $("#dialog_alert_icon").removeClass('ui-icon-check').addClass('ui-icon-alert');
            $("#dialog_alert").dialog({
                dialogClass: 'dialogWithDropShadow noTitleStuff ',
                modal: true,
                width: 'inherit',
                height: 90,
                buttons: {
                    'Close': function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

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
         '&yearTo=' + $('#<%=ddlYearTo.ClientID %> :selected').val() +
          '&staffId=' + require_var.staffId +
            '&staffRole=' + require_var.staffRole +
            '&langId=' + require_var.langId,
            datatype: 'json',
            colNames: [$('#<%=lbl_4_7.ClientID %>').text(), $('#<%=lbl_4_8.ClientID %>').text(), $('#<%=lbl_4_9.ClientID %>').text(), $('#<%=lbl_4_10.ClientID %>').text(), $('#<%=lbl_4_11.ClientID %>').text(), "documentId", "status", "invId"],
            colModel: [{ "name": "id", "index": "id", "jsonmap": "id", "width": "20", "align": "right", "sortable": false }, { "name": "documentNumber", "index": "documentNumber", "jsonmap": "documentNumber", "width": "140", "sortable": false }, { "name": "documentDate", "index": "documentDate", "jsonmap": "documentDate", "width": "120", "sortable": false }, { "name": "documentStatus", "index": "documentStatus", "jsonmap": "documentStatus", "sortable": false }, { "name": "remark", "index": "remark", "jsonmap": "remark", "sortable": false }, { "name": "documentId", "index": "documentId", "jsonmap": "documentId", "sortable": false, "hidden": true }, { "name": "status", "index": "status", "jsonmap": "status", "sortable": false, "hidden": true }, { "name": "invId", "index": "invId", "jsonmap": "invId", "sortable": false, "hidden": true}],
            pager: '#searchAddReducePager',
            width: 765,
            loadui: 'disable',
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
            loadComplete: function(){
                $("#historyLoadStatus").css('display', 'none');
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
