var documentData;
var hdfSDDocumentID;
var hdfSDShopID;
var rowState = null;
// Already
$(function() {

    var sltNameInv1 = "ddlProductLevel";
    var sltNameInv2 = "ddlSDInv";
    var newDocumentID;
    var newShopID;

    // check esc key
    $("html body").keyup(function(e) {
        if (e.keyCode == 27) {
            //alert(selectedRowID);
            $("#theGrid").restoreRow(selectedRowID);
            if (rowState == 'editing')
                rowState = null;
        }
    });



    LoadInventory(sltNameInv1);
    LoadInventory(sltNameInv2);

    var sltNameV1 = "ddlSDVendorGroup";
    var sltNameV2 = "ddlSVendorGroup";
    LoadVendorGroup(sltNameV1);
    LoadVendorGroup(sltNameV2);

    LoadPoStatus();
    jqGridMeterial()
    //LoadMaterialGroup();
    addEditMaterialJqGrid();

    if ($.getUrlVar('lnd') != undefined && $.getUrlVar('docId') != undefined && $.getUrlVar('shopId') != undefined) {
        newDocumentID = $.getUrlVar('docId');
        newShopID = $.getUrlVar('shopId');
        LoadNewDocumentDataFormDocumentBox(newDocumentID, newShopID);
    } else {
        CheckDocumentOnLoad();
    }

    $('#txtDocumentDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar_blue.png',
        buttonImageOnly: true

    });

    $('#txtFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $('#txtToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });

    $('#txtPOFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $('#txtPOToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });


    $('#btnSearchVendor').button({
        icons: { primary: 'ui-icon-search' }, text: false
    });
    $('#btnLoadDocument').button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $('#btnSearchPODocument').button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $('#btnCancel').button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $('#btnSelectDocument').button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $('#btnCancelVendor').button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $('#btnSelectVendor').button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnSMOk").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnSMCancel").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkSaveDoc").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCSaveDoc").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkAppDoc").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCAppDoc").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkAppDoc2").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCAppDoc2").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });

    $("#btnOkCancelDoc").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCCancelDoc").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkPO").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCancelPO").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });

    var langID = $.getUrlVar('LangID');
    $.datepicker.setDefaults($.datepicker.regional[langID]);
    $("button, input:submit, a", "#btnHeader").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print-preview'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });

    $("#accordion").accordion({
        collapsible: true,
        autoHeight: false,
        navigation: true,
        icons: { 'header': 'ui-icon-circle-arrow-s', 'headerSelected': 'ui-icon-circle-arrow-n' }
    });
    $("#txtSearchVendor").keyup(function(e) {
        if (e.keyCode == 13) {
            var searchAction;
            var searchCode = $("#txtSearchVendor").val();
            if ($('#rdoVenSearchByCode').is(':checked')) {
                //alert(1);
                searchAction = 1;
            } else if ($('#rdoVenSearchByName').is(':checked')) {
                searchAction = 2;
            }
            SearchVendorByCodeAndName(searchCode, searchAction);
        }
    });
    $("#txtMaterialCode").keyup(function(e) {
        if (e.keyCode == 13) {
            var searchAction;
            var materialCode = $("#txtMaterialCode").val();
            if ($('#rdoSmatByCode').is(':checked')) {
                searchAction = 1;
            } else if ($('#rdoSmatByName').is(':checked')) {
                searchAction = 2;
            }
            SearchMaterialByCodeAndName(materialCode, searchAction);
        }
    });


});
//======================================================== CheckSession  ========================================//
function CheckSessionTimeOut() {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=CheckSession',
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                if (data.status == 0) {
                    parent.location.href = "../logout.aspx"
                }
            } else {
                parent.location.href = "../logout.aspx"
            }
        }
    });

}
//=================================== Loading ===========================================//
$(function() {
    $("#loading").ajaxStart(function() {
        $(this).dialog({
            dialogClass: 'noTitleStuff',
            width: 300,
            height: 70,
            modal: true,
            resizable: false
        });
    }).ajaxStop(function() {
        $(this).dialog('close');
    });
});
//======================================================== OnLoad Docment ========================================//
function CheckDocumentOnLoad() {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=chekDoc',
        cache: false,
        context: document.body,
        success: function(data) {
            ary_data = data.split(";");
            //alert(ary_data[0]);
            //alert(ary_data[1]);
            $("#" + ary_data[0]).val(ary_data[1]);
            SetStatusButton(ary_data[1])
        }
    });



}

//======================================================== ส่วนแสดงหัวเอกสาร ========================================//

function DocmentHeader() {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadDocHeader',
        cache: false,
        context: document.body,
        success: function(data) {
            //alert(data);
            ary_data = data.split(",");
            for (i = 0; i < ary_data.length; i++) {
                if (ary_data[i] != '') {
                    ary_data2 = ary_data[i].split(";");
                    if (ary_data2[0] == 'lbStaffCreateName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbStaffEditName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbStaffApproveName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbStaffCancelName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtStatus') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtDocumentType') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtDocumentNo') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtVendorName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtVendorAddress') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtPhoneFax') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtVendorCode') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtReferenceNo') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                    }
                }
            }

        }
    });
}
//======================================================== ส่วนแสดงผลรวมของเอกสาร ========================================//
function LoadSummaryDocument() {

    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadDocSum',
        cache: false,
        context: document.body,
        success: function(data) {
            $('#DocSummary').html(data);
        }
    });
}


//======================================================== กำหนดสถานะปุ่มจักการเอกสาร ========================================//
function CheckDocumentStatus() {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=chekDocStatus',
        cache: false,
        context: document.body,
        success: function(data) {
            ary_data = data.split(";");
            //alert(ary_data[1]);
            $("#" + ary_data[0]).val(ary_data[1]);
            SetStatusButton(ary_data[1])
        }
    });

}

function SetStatusButton(statusDoc) {

    $('#txtDocumentDate').datepicker().datepicker('disable');

    $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
    $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
    //$('#txtDueDate').attr("disabled", true).addClass("ui-state-disabled");
    $('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtInvName').attr("disabled", true).addClass("ui-state-disabled");

    if (statusDoc == 0) {
        //DOCUMENTSTATUS_TEMP
        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSave').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#creditDay').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('enable');
        DocmentHeader();
        LoadSummaryDocument();
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");
    } else if (statusDoc == 1) {
        //DOCUMENTSTATUS_WORKING
        //$("#theGrid").attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#creditDay').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = null;
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");
    } else if (statusDoc == 2) {
        //DOCUMENTSTATUS_APPROVE
        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        openDialogSearchDocumentPO('dialogSearchDocumentPO');
    } else if (statusDoc == 99 || statusDoc == 3 || statusDoc == 4) {
        //DOCUMENTSTATUS_CANCEL ,DOCUMENTSTATUS_REFERED ,DOCUMENTSTATUS_FINISH
        // $("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        openDialogSearchDocumentPO('dialogSearchDocumentPO');
    } else {

        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        openDialogSearchDocumentPO('dialogSearchDocumentPO');

    }
}
//======================================================== สถานะเอกสารสั่งซื้อ ============================================//

function LoadPoStatus(selectorName) {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadPOStatus',
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName }),
        success: function(data) {
            //alert(data);
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);

        }
    });
}

//======================================================== ค้นหาคลังสินค้า ============================================//

// คลังสินค้า
function LoadInventory(selectorName) {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadInv',
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName }),
        success: function(data) {
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);

        }
    });
}

//======================================================== กลุ่มสินค้า หมวดสินค้า ============================================//

function LoadMaterialGroup() {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadMatGroup',
        cache: false,
        context: document.body,
        success: function(data) {
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);
            LoadMaterialDept($('#ddlMatByGrp').val());
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
function LoadMaterialDept(materialGroupID) {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadMatDept',
        cache: false,
        context: document.body,
        data: ({ materialGroupID: materialGroupID }),
        success: function(data) {
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);
            SearchMaterailsByDept($('#ddlMatByDept').val());
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}

function SearchMaterialDeptbyGroup() {
    LoadMaterialDept($('#ddlMatByGrp').val());
}
function SearchMaterailsByDept(materialDeptID) {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=searchMatByGroupAndCode',
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ materialDeptID: materialDeptID }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var mgrid = $("#msearch")[0];
            mgrid.addXmlData(xhr.responseXML);

        }
    });

}

//======================================================== สร้างเอกสารรับจากสั่งซื้อ ============================================//

// สร้างเอกสารการรับจากสั่งซื้อ
function CreateNewDocument() {
    CheckSessionTimeOut();
    var gridRow = $("#jGPODocument").getGridParam('selrow');
    var data = $("#jGPODocument").getRowData(gridRow);
    var refDocumentId = data.DocumentID;
    var refDocumentShopId = data.DocumentShopID;
    var refDocumentStatus = data.DocumentStatus;
    var refInventoryId = data.DocumentShopID;
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=newDoc',
        cache: false,
        data: ({ refDocumentId: refDocumentId, refDocumentShopId: refDocumentShopId, refDocumentStatus: refDocumentStatus, refInventoryId: refInventoryId }),
        success: function(data) {
            CheckDocumentStatus();
            DocmentHeader();
            LoadSummaryDocument();
            $("#theGrid").jqGrid().trigger("reloadGrid");

        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}


//======================================================== บันทึกเอกสารรับจากสั่งซื้อ ============================================//

function SaveDocument() {
    CheckSessionTimeOut();
    var docDate = $('#txtDocumentDate').val();
    var note = $('#txtNote').val();
    var invoiceNo = $('#txtInvoiceNo').val();

    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=saveDoc',
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ docDate: docDate, note: note, invoiceNo: invoiceNo }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    $('#dialogConfirmSaveDoc').dialog('close');
                    //alert(data.strResultText);
                    DocmentHeader();
                    LoadSummaryDocument();
                    CheckDocumentStatus();
                    LoadMaterialGroup();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmSaveDoc').dialog('close');
                    alert(data.strResultText);
                    DocmentHeader();
                    LoadSummaryDocument();
                    CheckDocumentStatus();
                    LoadMaterialGroup();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }
    });

}
//======================================================== ยกเลิกเอกสารรับจากสั่งซื้อ ============================================//

function CancelDocument() {
    CheckSessionTimeOut();
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=cancelDoc',
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            DocmentHeader();
            LoadSummaryDocument();
            CheckDocumentStatus();
            $("#theGrid").jqGrid().trigger("reloadGrid");
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    $('#dialogConfirmCancelDoc').dialog('close');
                    CheckDocumentStatus();
                    DocmentHeader();
                    LoadSummaryDocument();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmCancelDoc').dialog('close');
                    alert(data.strResultText);
                    CheckDocumentStatus();
                    DocmentHeader();
                    LoadSummaryDocument();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });
}
//======================================================== อนุมัติเอกสารรับจากสั่งซื้อ ============================================//


function CheckApproveDocument() {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=CheckApprove',
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            // alert(status);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 0) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    alert(data.strResultText);
                } else if (data.status == 1) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    $('#hdfDocumentDateApprove').val(data.newDocumentDate);
                    //alert($('#hdfDocumentDateApprove').val());
                    ApproveDocument()
                } else if (data.status == 2) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    $('#P1').html(data.strResultText);
                    $('#hdfDocumentDateApprove').val(data.newDocumentDate);
                    opendialogConfirmDoc('dialogConfirmApproveDocAgain', 0);
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });
}
function ApproveDocument() {
    CheckSessionTimeOut();
    var newDocumentDate = $('#hdfDocumentDateApprove').val()
    ary_data = newDocumentDate.split("/");
    //alert(newDocumentDate);
    //alert(ary_data[0]);
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=ApproveDoc',
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ day: ary_data[0], month: ary_data[1], year: ary_data[2] }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    // alert(data.strResultText);
                    DocmentHeader();
                    LoadSummaryDocument();
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#P1').html(data.strResultText);
                    opendialogConfirmDoc('dialogConfirmApproveDocAgain', 0);
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });
}
//======================================================== ลบรายการสินค้าออกจากเอกสาร ============================================//

function deleteMaterial(caption, msg, bOk, bCancel, url) {
    var dialog = '<div id="delDialog" style="display:none; overflow:hidden;" title="' + caption + '">';
    dialog += '<div id="msg" style="padding:8px 4px; border-bottom:#ccc 1px solid">' + msg + '</div>';
    dialog += '<div style="margin:4px 0; text-align:right">';
    dialog += '<button id="bOkDel">' + bOk + '</button>';
    dialog += '<button id="bCancelDel">' + bCancel + '</button>';
    dialog += '</div>';
    dialog += '</div>';

    if ($("#delDialog").html() == null) {
        $("body").append(dialog);
    }
    /*if ($("#msg").html() != msg) {
    $("#msg").html(msg).removeClass('ui-state-error');
    }*/
    $("#delDialog").dialog({ width: 250, height: 100, modal: true, resizable: false });
    $("#bOkDel").button({
        icons: {
            primary: 'icon-btn-ok'
        }
    }).click(function() {
        $.ajax({
            url: url,
            type: 'GET',
            success: function(data, status, xhr) {
                //doFuctionAfterDel
                LoadSummaryDocument();
                $("#theGrid").trigger('reloadGrid');
                $("#delDialog").dialog('close');
            },
            error: function(xhr, status) {
                //$("#msg").html(status + ': ไม่สามารถลบข้อมูลได้').addClass('ui-state-error');
                alert(status);
            }
        })
    });
    $("#bCancelDel").button({
        icons: {
            primary: 'icon-btn-cancel'
        }
    }).click(function() {
        $("#delDialog").dialog('close');
    });
}
//======================================================== Dialog ยืนยันการปรับแก้ไขเอกสาร ============================================//

function opendialogConfirmDoc(id, statusEven) {
    if (statusEven == 1) {
        if ($('#hdfStatus').val() == 0) {
            $('#' + id).dialog({ width: 500, autoOpen: false, bgiframe: true, modal: true });
            $('#' + id).dialog('open');
            $('#' + id).parent().appendTo($("form:first"));
        } else {
            SaveDocument()

        }
    } else if (statusEven == 2) {
        $('#' + id).dialog({ width: 500, autoOpen: false, bgiframe: true, modal: true });
        $('#' + id).dialog('open');
        $('#' + id).parent().appendTo($("form:first"));

    } else if (statusEven == 99) {
        $('#' + id).dialog({ width: 500, autoOpen: false, bgiframe: true, modal: true });
        $('#' + id).dialog('open');
        $('#' + id).parent().appendTo($("form:first"));

    } else if (statusEven == 0) {
        $('#' + id).dialog({ width: 500, autoOpen: false, bgiframe: true, modal: true });
        $('#' + id).dialog('open');
        $('#' + id).parent().appendTo($("form:first"));
    }
}
function closedialogConfirmDoc(id) {
    $('#' + id).dialog('close');
}

function MessageError(msgError) {
    $('#dialogMessage').dialog({ width: 700, autoOpen: false, bgiframe: true, modal: true });
    $('#dialogMessage').dialog('open');
    $('#msg').append("<div>Error : " + msgError + "</div>");
}

//======================================================== ค้นหาเอกสารรับจากสั่งซื้อ ============================================//
// เปิด Dialoa ค้นหาเอกสาร เพื่อให้เลือกเงื่อนไขในการค้นหาได้
function openDialogSearchDocument(id) {
    $('#' + id).dialog({ width: 900, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));

    // GridView แสดงข้อมูลเอสารตามที่ค้นหา
    $("#jGDocument").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'เลขที่เอกสารอ้างอิง', 'วันที่เอกสาร', 'สถานะเอกสาร', 'คลัง', 'ผู้จัดจำหน่าย', 'Adjust', 'หมายเหตุ', 'DocumentShopID', 'DocumentID'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
                    { name: 'DocumentRefNumber', index: 'DocumentRefNumber', width: 150 },
   		            { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                    { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100 },
                    { name: 'VendorName', index: 'VendorName', width: 100 },
                    { name: 'AdjustDocument', index: 'AdjustDocument', width: 100, hidden: true },
                    { name: 'DocumentNote', index: 'DocumentNote', width: 150 },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                     	],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pageDocument'),
        viewrecords: false,
        ondblClickRow: function(rowID, iRow, iCol, e) {
            $('#' + id).dialog('close');
            LoadNewDocumentData();
            DocmentHeader();
            LoadSummaryDocument();
            CheckDocumentStatus();
            $("#theGrid").jqGrid().trigger("reloadGrid");
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });

    SearchDocumentData();
}
//======================================================== ค้นหาเอกสารสั่งซื้อ (PO) ============================================//
// เปิด Dialoa ค้นหาเอกสาร เพื่อให้เลือกเงื่อนไขในการค้นหาได้
function openDialogSearchDocumentPO(id) {
    $('#' + id).dialog({ width: 700, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));

    // GridView แสดงข้อมูลเอสารตามที่ค้นหา
    $("#jGPODocument").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร', 'ผู้จัดจำหน่าย', 'สถานะ', 'คลัง', 'Adjust', 'DocumentShopID', 'DocumentID', 'DocumentStatus', 'DocumentRefShopID', 'DocumentRefID', 'DocumentRefStatus', 'DocumentInventoryID'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
   		            { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                    { name: 'VendorName', index: 'VendorName', width: 100 },
                    { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100, hidden: true },
                    { name: 'AdjustDocument', index: 'AdjustDocument', width: 100, hidden: true },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                    { name: 'DocumentStatus', index: 'DocumentID', width: 100, hidden: true },
                    { name: 'DocumentRefShopID', index: 'DocumentRefShopID', width: 100, hidden: true },
                    { name: 'DocumentRefID', index: 'DocumentRefID', width: 100, hidden: true },
                    { name: 'DocumentRefStatus', index: 'DocumentRefStatus', width: 100, hidden: true },
                    { name: 'DocumentInventoryID', index: 'DocumentInventoryID', width: 100, hidden: true },

                     	],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pagePOdocument'),
        viewrecords: false,
        ondblClickRow: function(rowID, iRow, iCol, e) {
            CreateNewDocument();
            $('#' + id).dialog('close');
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
    SearchPODocumentData();

}
// ค้นหาเอกสารสั่งซื้อ 
function SearchPODocumentData() {
    var fromDate = $('#txtPOFromDate').val();
    var toDate = $('#txtPOToDate').val();
    var dStatus = $('#ddlPOStatus').val();
    var dInv = $('#ddlProductLevel').val();
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=searchPOdoc',
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ poFromDate: fromDate, poToDate: toDate, poStatus: dStatus, poInv: dInv }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jGPODocument")[0];
            gridDoc.addXmlData(xhr.responseXML);
            $('#btnOkPO').click(function() {
                CreateNewDocument();
                $('#dialogSearchDocumentPO').dialog('close');
            });
        }
    });

}

// ค้นหาเอกสารรับจากสั่งซื้อ 
function SearchDocumentData() {
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();
    var dStatus = $('#ddlSDStatus').val();
    var dInv = $('#ddlSDInv').val();
    var dVendorGroup = $('#ddlSDVendorGroup').val();
    var dVendor = $('#ddlSDVendor').val();
    //alert(dInv);
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=searchdoc',
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ txtFromDate: fromDate, txtToDate: toDate, dStatus: dStatus, dInv: dInv, dVendorGroup: dVendorGroup, dVendor: dVendor }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jGDocument")[0];
            gridDoc.addXmlData(xhr.responseXML);
            $('#btnSelectDocument').click(function() {
                LoadNewDocumentData();
                LoadSummaryDocument();
                CheckDocumentStatus();
                $('#dialogSearchDocument').dialog('close');
            });
        }
    });

}
// ค้นหาเอกสารใบใหม่เพื่อมาทำรายการ
function LoadNewDocumentData() {
    var gridRow = $("#jGDocument").getGridParam('selrow');
    var data = $("#jGDocument").getRowData(gridRow);
    var newDocID = data.DocumentID;
    var newShopID = data.DocumentShopID;
    //alert(newDocID);
    //alert(newShopID);
    if (newDocID != '' && newShopID != '' || newDocID != 0 && newShopID != 0) {
        $.ajax({
            url: 'DataXML/ReceiptFormPOXML.aspx?action=loadNewDocment',
            cache: false,
            datatype: 'json',
            type: 'GET',
            data: ({ newDocID: newDocID, newShopID: newShopID }),
            complete: function(xhr, status) {
                // alert(xhr.responseText);
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);
                    if (data.status == 1) {
                        DocmentHeader();
                        LoadSummaryDocument();
                        CheckDocumentStatus();
                        LoadMaterialGroup();
                        $("#theGrid").jqGrid().trigger("reloadGrid");

                    } else {
                        alert(data.ResultText);
                        CheckDocumentOnLoad();
                        LoadMaterialGroup();
                    }
                } else {
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                    CheckDocumentOnLoad();
                }
            }
        });

    }

}
function LoadNewDocumentDataFormDocumentBox(newDocID, newShopID) {

    if (newDocID != '' && newShopID != '' || newDocID != 0 && newShopID != 0) {
        $.ajax({
            url: 'DataXML/ReceiptFormPOXML.aspx?action=loadNewDocment',
            cache: false,
            datatype: 'json',
            type: 'GET',
            data: ({ newDocID: newDocID, newShopID: newShopID }),
            complete: function(xhr, status) {
                // alert(xhr.responseText);
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);
                    if (data.status == 1) {
                        DocmentHeader();
                        LoadSummaryDocument();
                        CheckDocumentStatus();
                        LoadMaterialGroup();
                        $("#theGrid").jqGrid().trigger("reloadGrid");

                    } else {
                        alert(data.ResultText);
                        CheckDocumentOnLoad();
                        LoadMaterialGroup();
                    }
                } else {
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                    CheckDocumentOnLoad();
                }
            }
        });

    }

}
// ปิดหน้าต่าง Dialog การค้นหาเอกสารรับจากสั่งซื้อ
function closeDialogSearchDocument(id) {
    $('#' + id).dialog('close');
}



//======================================================== ค้นหาผู้จัดจำหน่ายสินค้า ============================================//

//เปิด Dialog ค้นหาผู้จัดจำหน่าย
function openDialogSearchVendor(id) {
    var vendorData;

    $('#' + id).dialog({ width: 700, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    // $('#' + id).parent().appendTo($("form:first"));

    //แสดงข้อมูลผู้จัดจำหน่าย
    $("#jGVendor").jqGrid({
        //url: 'No',
        colNames: ['รหัสผู้จัดจำหน่าย', 'ชื่อผู้จัดจำหน่าย', 'VendorID', 'VendorGroupID', 'VendorShopID', 'VendorAddress', 'PhoneFax', 'TermOfPayment', 'CreditDay'],
        colModel: [
               		            { name: 'VendorCode', index: 'VendorCode', width: 70 },
               		            { name: 'VendorName', index: 'VendorName', width: 200 },
                                { name: 'VendorID', index: 'VendorID', width: 100, hidden: true },
                                { name: 'VendorGroupID', index: 'VendorGroupID', width: 100, hidden: true },
                                { name: 'VendorShopID', index: 'VendorShopID', width: 100, hidden: true },
                                { name: 'VendorAddress', index: 'VendorAddress', width: 100, hidden: true },
                                { name: 'PhoneFax', index: 'PhoneFax', width: 100, hidden: true },
                                { name: 'TermOfPayment', index: 'TermOfPayment', width: 100, hidden: true },
                                { name: 'CreditDay', index: 'CreditDay', width: 100 }

                                 	],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pageVendor'),
        viewrecords: false,
        ondblClickRow: function(rowID, iRow, iCol, e) {
            LoadNewVendorData();
            $('#' + id).dialog('close');
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });


}
function SearchVendorByCodeAndName(searchCode, searchAction) {
    //alert(searchAction);
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=searchVen',
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ searchCode: searchCode, searchAction: searchAction }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridVen = $("#jGVendor")[0];
            gridVen.addXmlData(xhr.responseXML);
            $("#txtSearchVendor").select();
            $('#btnSelectVendor').click(function() {
                LoadNewVendorData()
                $('#' + id).dialog('close');
            });

        }
    });

}
function DisabledRdoVendor() {
    if ($('#ardoSearchByText').is(':checked')) {
        $('#txtSearchVendor').attr("disabled", false);
        $('#ddlSVendorGroup').attr("disabled", true);
    } else {
        $('#txtSearchVendor').attr("disabled", true);
        $('#ddlSVendorGroup').attr("disabled", false);
    }
}
// ค้นหากลุ่มผู้จัดจำหน่าย และ ผู้จัดจำหน่าย
function LoadVendorGroup(selectorName) {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadVendorGroup',
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName }),
        success: function(data) {
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);
            LoadVendor(-1, 1);
        }
    });
}

function LoadVendor(vendorGroupID, searchVedorBy) {

    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadVen',
        cache: false,
        context: document.body,
        data: ({ vendorGroupID: vendorGroupID, actionBy: searchVedorBy }),
        success: function(data) {
            ary_data2 = data.split(";");
            //                        alert(ary_data2[0]);
            //                        alert(ary_data2[1]);
            $("#" + ary_data2[0]).html(ary_data2[1]);
        }
    });
}

function LoadVendorForGridView(vendorGroupID, searchVedorBy) {
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadVen',
        cache: false,
        datatype: 'xml',
        data: ({ vendorGroupID: vendorGroupID, actionBy: searchVedorBy }),
        complete: function(xhr, status) {
            //alert(status);
            var gridVen = $("#jGVendor")[0];
            gridVen.addXmlData(xhr.responseXML);
        }
    });

}

function LoadNewVendorData() {
    var gridRow = $("#jGVendor").getGridParam('selrow');
    var data = $("#jGVendor").getRowData(gridRow);
    //alert(data.VendorAddress);
    $('#hdfVendorID').val(data.VendorID);
    $('#hdfVendorGroupID').val(data.VendorGroupID);
    $('#hdfVendorShopID').val(data.VendorShopID);
    $('#txtVendorCode').html(data.VendorCode);
    $('#txtVendorName').html(data.VendorName);
    $('#txtVendorAddress').html(data.VendorAddress);
    $('#txtPhoneFax').html(data.PhoneFax);
    $('#ddlTermOfPayment').val(data.TermOfPayment);
    //alert(data.CreditDay);
    $('#creditDay').val(data.CreditDay);
}

// ปิดหน้าต่าง Dialog ค้นหาผู้จัดจำหน่าย
function closeDialogSearchVendor(id) {
    $('#' + id).dialog('close');
}
//======================================================== ส่วนของการจัดการเอกสาร เพิ่ม ลบ สินค้า ============================================//

var selectedRowID = 0;      //selected rowid for edit
function addEditMaterialJqGrid() {
    jQuery("#theGrid").jqGrid({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=loadDocDetail',
        datatype: 'xml',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวน', 'ราคา/หน่วย', 'หน่วย', 'ส่วนลด', 'VAT', 'ราคารวม', 'editDocDetailID', 'materialvatype', 'materialid', 'unitid', 'discountamount', 'discountpercent'],
        colModel: [
   		{ name: 'id', index: 'id', width: 10, editable: false, hidden: false, align: 'center' },
        { name: 'mcode', index: 'mcode', width: 60, editable: true, edittype: 'custom', editrules: { custom: true, caption: 'ข้อความ',
            custom_func: function(value, colname) {
                if (value == '')
                    return [false, "กรุณาใส่รหัสสินค้า"];
                else
                    return [true, ""];
            }
        },
            editoptions: {
                custom_element: function(value, options) {
                    var elemStr = '<input id="' + options.id + '" value="' + value + '" type="text" style="float:left;width:94%;margin-right:-28px;" />';
                    elemStr += '<div><button id="' + options.id + '_bs" type="button" title="Search" onclick="searchMaterial();" style="height:19px; padding:0 4px; width:30px;" class="ui-button ui-state-default" ><span class="ui-icon ui-icon-search"></span></button></div>';
                    return elemStr;
                },
                custom_value: function(elem) {
                    return elem.val();
                }
            }
        },
   		{ name: 'mname', index: 'mname', width: 100, editable: false },
   		{ name: 'mamount', index: 'mamount', width: 40, editable: true, align: 'right', editrules: { custom: true, top: 10,
   		    custom_func: function(value, colname) {
   		        if (value <= 0)
   		            return [false, "กรุณาระบุจำนวนสินค้า"];
   		        else
   		            return [true, ""];
   		    }
   		},
   		    edittype: 'custom', editoptions: {
   		        custom_element: function(value, options) {
   		            var elemStr = '<input id="' + options.id + '" value="' + value + '" type="text" style="text-align:right; width:40%" />';
   		            return elemStr;
   		        },
   		        custom_value: function(elem) {
   		            return elem.val();
   		        }
   		    }
   		},
   		{ name: 'mpriceperunit', index: 'mpriceperunit', width: 40, align: 'right', editable: true, edittype: 'custom',
   		    editrules: { custom: true,
   		        custom_func: function(value, colname) {
   		            if (value == '' || value < 0)
   		                return [false, "กรุณาใส่ราคา"];
   		            else
   		                return [true, ""];
   		        }
   		    },
   		    editoptions: {
   		        custom_element: function(value, options) {
   		            var elemStr = '<input id="' + options.id + '" value="' + value + '" type="text" style="text-align:right; width:90%" />';
   		            return elemStr;
   		        },
   		        custom_value: function(elem) {
   		            return elem.val();
   		        }
   		    }
   		},
   		{ name: 'munit', index: 'munit', width: 30, editable: true, align: 'left', edittype: 'custom',
   		    editoptions: {
   		        custom_element: function(value, options) {
   		            var elemStr = '<select id="' + options.id + '" style="width:100%; padding:1px 0;" >';
   		            elemStr += '</select>';

   		            //alert(options.id);
   		            return elemStr;
   		        },
   		        custom_value: function(elem) {
   		            return elem.val();
   		        }
   		    }
   		},
   		{ name: 'mdiscount', index: 'mdiscount', width: 40, align: 'right', editable: true, edittype: 'custom',
   		    editoptions: {
   		        custom_element: function(value, options) {
   		            var elemStr = '<input id="' + options.id + '" value="' + value + '" type="text" role="textbox" style="text-align:right; width:40%; margin:2px 2px 0 0; float:left;" />';
   		            elemStr += '<div><select id="' + options.id + '_sl" style="width:49px; padding:1px 0;">';
   		            elemStr += '<option value="0">%</option>';
   		            elemStr += '<option value="1">บาท</option>';
   		            elemStr += '</select></div>';
   		            return elemStr;
   		        },
   		        custom_value: function(elem) {
   		            return elem.val();
   		        }
   		    }
   		},
   		{ name: 'mvat', index: 'mvat', width: 40, editable: true, align: 'right', edittype: 'select', editoptions: { value: "1:Exclude;2:Include;0:No VAT" }
   		},
   		{ name: 'mtotalprice', index: 'totalprice', width: 40, editable: false, align: 'right' },
        { name: 'editdocdetailid', index: 'editdocdetailid', hidden: true },
        { name: 'materialvattype', index: 'materialvattype', hidden: true },
        { name: 'mid', index: 'mid', width: 10, hidden: true },
        { name: 'unitid', index: 'unitid', width: 10, hidden: true },
        { name: 'discountamount', index: 'discountamount', width: 10, hidden: true },
        { name: 'discountpercent', index: 'discountpercent', width: 10, hidden: true }
   	],
        pager: '#pager',
        autowidth: true,
        height: 300,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: true,
        multiboxonly: true,
        /*ondblClickRow: function(rowid, iRow, iCol, e) {
        if (rowState != 'editing') {
        selectedRowID = rowid;
        $(this).editRow(rowid, false, oneditfunc);
        rowState = 'editing';

            }
        },*/
        onSelectRow: function(rowid) {
            /* if (rowid != selectedRowID) {
            var materialData = $(this).jqGrid('getRowData', selectedRowID);
            var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
            jQuery("#theGrid").saveRow(selectedRowID, succesfunc, 'DataXML/ReceiptFormPOXML.aspx?action=addMaterialInDocDetial', { mid: materialData.mid, indexlist: selectedRowID, editdocdetailid: materialData.editdocdetailid, IsDiscount: mslDiscount }, aftersavefunc, errorfunc, afterrestorefunc);

            }*/
            if (rowState != 'editing') {
                selectedRowID = rowid;
                $(this).editRow(rowid, false, oneditfunc);
                rowState = 'editing';

            }
        },
        /*gridComplete:function(){
        $(this).setGridParam(({multiselect:false}));.attr('disabled', true).addClass('ui-state-disabled'); .hideCol('cb');
        },*/
        viewrecords: true,
        caption: 'รายการสินค้า'
    });
    //-- จัดการ page
    $("#theGrid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false }).navButtonAdd('#pager', {
        id: 'theGrid-del-btn', // Add id ให้ปุ่ม Delete
        caption: "ลบรายการ",
        buttonicon: "ui-icon-trash",
        onClickButton: function() {
            var rowCheckedDel = $("#theGrid").jqGrid('getGridParam', 'selarrrow');
            var delParam = '';
            for (var i = 0; i <= rowCheckedDel.length; i++) {
                var rowData = $(this).jqGrid('getRowData', rowCheckedDel[i]);
                if (rowData.editdocdetailid != null && rowData.editdocdetailid != '') {
                    if (delParam == '') {
                        delParam = rowData.editdocdetailid;
                    } else {
                        delParam += "," + rowData.editdocdetailid;
                    }
                }
            }
            if (rowCheckedDel != '') {
                deleteMaterial('ลบข้อมูล', 'ต้องการลบข้อมูล ใช่หรือไม่', 'ตกลง', 'ยกเลิก', 'DataXML/ReceiptFormPOXML.aspx?action=delMaterialInDocDetial&docdetailid=' + delParam);
            } else {
                alert("กรุณาเลือกแถวที่ท่านต้องการลบก่อน!");
                $(this).setGridParam(({ multiselect: true })); /*.showCol('cb');*/
            }
        },
        position: "first"
    }).navButtonAdd('#pager', {
        caption: "เพิ่มแถว",
        buttonicon: "icon-addrow-after",
        onClickButton: function() {
            addRow();
        },
        position: "first"
    });
}



//-- resize grid when resize browser
$(window).bind('resize', function() {
    $("#theGrid").setGridWidth($(window).width() - 8);
}).trigger('resize');

//-- search material dialog
function searchMaterial() {
    var materialData = null;       //data from search material
    var materialCode = "";
    $("#boxSearchProduct").dialog({
        resizable: false,
        height: 600,
        width: 550,
        title: 'ค้นหาวัตถุดิบ',
        modal: true
    });

    $("#btnSMCancel").click(function() {
        $("#boxSearchProduct").dialog('close');
    });

}
function SearchMaterialByCodeAndName(materialCode, searchAction) {
    //alert(materialCode);
    //alert(searchAction);
    $.ajax({
        url: 'DataXML/ReceiptFormPOXML.aspx?action=searchMatByCodeAndName',
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ searchCode: materialCode, searchBy: searchAction }),
        complete: function(xhr, status) {
            // alert(xhr.responseText);
            var mgrid = jQuery("#msearch")[0];
            mgrid.addXmlData(xhr.responseXML);
            $("#txtMaterialCode").select();
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}

function addRow() {
    $("#boxAddRow").dialog({
        resizable: false,
        height: 60,
        width: 170,
        title: 'เพิ่มแถว',
        modal: false
    });
    $("#btnAddRow").click(function() {
        $.post('DataXML/ReceiptFormPOXML.aspx?action=addrow',
             { custom_row: $("#txtAddRow").val() },
             function(data, textStatus, XMLHttpRequest) {
                 //alert(textStatus);
                 $("#theGrid").jqGrid().trigger("reloadGrid");
             });
        $("#boxAddRow").dialog('close');
    });
}
function jqGridMeterial() {
    var materialData = null;       //data from search material
    var materialCode = "";
    $("#msearch").jqGrid({
        colNames: ['MaterialID', 'รหัสสินค้า', 'ชื่อสินค้า', 'MaterialTypeID'],
        colModel: [
        { name: 'mid', index: 'mid', width: 40, hidden: true },
   		{ name: 'mcode', index: 'mcode', width: 100 },
   		{ name: 'mname', index: 'mname', width: 400 },
        { name: 'vattype', index: 'vattype', hidden: true }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 290,
        widht: 500,
        pager: $('#mpager'),
        viewrecords: false,
        ondblClickRow: function(rowidx, iRow, iCol, e) {
            materialData = $(this).jqGrid('getRowData', rowidx);
            setDataToTheGrid(materialData);
            $("#boxSearchProduct").dialog('close');
        },
        onSelectRow: function(rowidx) {
            materialData = $(this).jqGrid('getRowData', rowidx);
            $("#btnSMOk").click(function() {
                setDataToTheGrid(materialData);
                $("#boxSearchProduct").dialog('close');
            });
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
}
function setFocus(theGrid, elm_name) {
    //-- set focus to element
    $(elm_name).focus();
}

//-- get price จาก unit dropdown
function getPriceFromDropDownUnit(editdocdetailid, materialId, unitId, amount, discount, vat, msldiscount, mPricePerUnit, actionby) {
    var docDetailID;
    var mdiscount;
    var mpriceper;
    if (editdocdetailid != '') {
        docDetailID = editdocdetailid
    } else {
        docDetailID = -1
    }
    if (discount != '') {
        mdiscount = discount
    } else {
        mdiscount = 0
    }
    if (mPricePerUnit != '') {
        mpriceper = mPricePerUnit
    } else {
        mpriceper = 0
    }
    $.getJSON('DataXML/ReceiptFormPOXML.aspx?action=getPricePerUnit', { editdocdetailid: docDetailID, materialId: materialId, unitId: unitId, materialAmount: amount, materailDiscount: mdiscount, materialVat: vat, isDicount: msldiscount, mPricePerUnit: mpriceper, actionby: actionby }, function(data, status) {
        //alert(data.mTotalPrice);
        //{"priceperunit":"100"}
        if (data != null) {
            //-- update ราคา

            $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mTotalPrice });
            $("#" + selectedRowID + "_mpriceperunit").val(data.priceperunit);

        }
    });
}
function getPricePerUnitForEnterAmount(editdocdetailid, materialId, unitId, amount, discount, vat, msldiscount, mPricePerUnit, actionby) {
    var docDetailID;
    var mdiscount;
    var mpriceper;
    if (editdocdetailid != '') {
        docDetailID = editdocdetailid
    } else {
        docDetailID = -1
    }
    if (discount != '') {
        mdiscount = discount
    } else {
        mdiscount = 0
    }
    if (mPricePerUnit != '') {
        mpriceper = mPricePerUnit
    } else {
        mpriceper = 0
    }
    $.getJSON('DataXML/ReceiptFormPOXML.aspx?action=getPricePerUnit', { editdocdetailid: docDetailID, materialId: materialId, unitId: unitId, materialAmount: amount, materailDiscount: mdiscount, materialVat: vat, isDicount: msldiscount, mPricePerUnit: mpriceper, actionby: actionby }, function(data, status) {
        //alert(data.mTotalPrice);
        //{"priceperunit":"100"}
        if (data != null) {
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mTotalPrice });
            $("#" + selectedRowID + "_mpriceperunit").val(data.priceperunit);
            $("#" + selectedRowID + "_mpriceperunit").select();

        }
    });
}

//-- จากการ search แบบ dialog
function setDataToTheGrid(materialData) {
    $.getJSON('DataXML/ReceiptFormPOXML.aspx?action=getMaterialDataJSON', { editDetailId: -1, materialId: materialData.mid, materialCode: materialData.mcode, materialName: materialData.mname, materialAmount: 0, Price: 0, selectUnit: -1, Discouent: 0, IsDiscount: 0, materialVatType: materialData.vattype, actionby: 1 }, function(data, status) {
        //alert(data.d);
        if (data != null) {
            //alert(data.mtotalprice);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mid: data.mid });
            $("#" + selectedRowID + "_mcode").val(data.mcode);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mname: data.mname });
            $("#" + selectedRowID + "_mamount").val(data.mamount);
            $("#" + selectedRowID + "_mpriceperunit").val(data.mpriceperunit);

            var select = $("#" + selectedRowID + "_munit");
            var option = '';
            $.each(data.unit[0], function(index, item) {
                if (index == data.unitid) {
                    option += '<option value="' + index + '" selected>' + item + '</option>';
                }
                else {
                    option += '<option value="' + index + '">' + item + '</option>';
                }
            });
            //alert(option);
            select.html(option);

            $("#" + selectedRowID + "_mdiscount").val(data.mdiscount);
            $("#" + selectedRowID + "_mvat").val(data.mvat);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
            $("#" + selectedRowID + "_unitid").val(data.unitid);

            $("#" + selectedRowID + "_mamount").focus();
            $("#" + selectedRowID + "_mamount").select();

        }
    });
}

//-- จากการ search แบบ enter
function setDataWhenEnterSearchJSON(materialCode) {
    //alert(materialCode);
    //alert(selectedRowID);
    var theGridData = $("#theGrid").jqGrid('getRowData', 'selrow');
    var editDocDetailId = theGridData.editdocdetailid;
    $.getJSON('DataXML/ReceiptFormPOXML.?action=getMaterialDataJSONByCode', { materialCode: materialCode, editDocDetailId: editDocDetailId }, function(data, status) {
        //alert(data.d);
        if (data != null) {
            //alert(data.mtotalprice);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mid: data.mid });
            $("#" + selectedRowID + "_mcode").val(data.mcode);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mname: data.mname });
            $("#" + selectedRowID + "_mamount").val(data.mamount);
            $("#" + selectedRowID + "_mpriceperunit").val(data.mpriceperunit);

            var select = $("#" + selectedRowID + "_munit");
            var option = '';
            $.each(data.unit[0], function(index, item) {
                if (index == data.unitid) {
                    option += '<option value="' + index + '" selected>' + item + '</option>';
                }
                else {
                    option += '<option value="' + index + '">' + item + '</option>';
                }
            });
            //alert(option);
            select.html(option);

            $("#" + selectedRowID + "_mdiscount").val(data.mdiscount);
            $("#" + selectedRowID + "_mvat").val(data.mvat);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
            $("#" + selectedRowID + "_unitid").val(data.unitid);

            $("#" + selectedRowID + "_mamount").focus();
            $("#" + selectedRowID + "_mamount").select();
        } else {
            alert('ไม่พบรหัสสินค้า ' + materialCode + ' กรุณาตรวจสอบรหัสสินค้าใหม่อีกครั้ง');
            $("#" + selectedRowID + "_mcode").focus();
            $("#" + selectedRowID + "_mcode").select();
        }

    });
}

// ตรวจการเปลี่ยนแปลงข้อมูลภายในแต่ละ Row
function CheckOneditRow() {
    var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
    if (materialData.mid > 0) {
        //alert(materialData.discountpercent);
        var mCode = $("#" + selectedRowID + "_mcode").val();
        var mAmount = $("#" + selectedRowID + "_mamount").val();
        var mPricePerUnit = $("#" + selectedRowID + "_mpriceperunit").val();
        var mDiscount = $("#" + selectedRowID + "_mdiscount").val();
        var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
        var munit = $("#" + selectedRowID + "_munit").val();
        var slIsDiscount;
        if (materialData.discountamount == 0 && materialData.discountpercent == 0) {
            slIsDiscount = 0
        } else if (materialData.discountpercent != 0) {
            slIsDiscount = 0
        } else if (materialData.discountamount != 0) {
            slIsDiscount = 1
        } else {
            slIsDiscount = 0
        }
        $.getJSON('DataXML/ReceiptFormPOXML.aspx?action=getMaterialDataJSON', { editDetailId: materialData.editdocdetailid, materialId: materialData.mid, materialCode: mCode, materialName: materialData.mname, materialAmount: mAmount, Price: mPricePerUnit, selectUnit: materialData.unitid, IsDiscount: slIsDiscount, materialVatType: materialData.materialvattype, mDiscountAmount: materialData.discountamount, mDiscountPercent: materialData.discountpercent, actionby: 2 }, function(data, status) {

            if (data != null) {
                //alert(data.mtotalprice);
                $("#theGrid").jqGrid('setRowData', selectedRowID, { mid: data.mid });
                $("#" + selectedRowID + "_mcode").val(data.mcode);
                $("#theGrid").jqGrid('setRowData', selectedRowID, { mname: data.mname });
                $("#" + selectedRowID + "_mamount").val(data.mamount);
                $("#" + selectedRowID + "_mpriceperunit").val(data.mpriceperunit);

                var select = $("#" + selectedRowID + "_munit");
                var option = '';
                $.each(data.unit[0], function(index, item) {
                    if (index == data.unitid) {
                        option += '<option value="' + index + '" selected>' + item + '</option>';
                    }
                    else {
                        option += '<option value="' + index + '">' + item + '</option>';
                    }
                });
                //alert(option);
                select.html(option);

                //                var slmDiscount = $("#" + selectedRowID + "_mdiscount_sl");
                //                var optionDis = '';
                //                if (data.isdiscount == 0) {
                //                    optionDis += '<option value="0" selected>%</option>';
                //                    optionDis += '<option value="1">บาท</option>';
                //                }
                //                else {
                //                    optionDis += '<option value="0">%</option>';
                //                    optionDis += '<option value="1"  selected>บาท</option>';
                //                }
                //                slmDiscount.html(optionDis);

                $("#" + selectedRowID + "_mdiscount").val(data.mdiscount);
                $("#" + selectedRowID + "_mdiscount_sl").val(data.isdiscount);
                $("#" + selectedRowID + "_mvat").val(data.mvat);
                $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
                $("#" + selectedRowID + "_unitid").val(data.unitid);

            }
        });
    }


}

// เปิด Row เพื่อแก้ไขข้อมูลสินค้า
function oneditfunc() {
    CheckOneditRow();
    $("#" + selectedRowID + "_code_bs").button({
        icons: {
            primary: ' ui-icon-search',
            text: false
        }
    });

    // ตรวจสอบรหัสสินค้า
    $("#" + selectedRowID + "_mcode").focus();
    $("#" + selectedRowID + "_mcode").keyup(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        }
        else if (e.keyCode == 13) {
            if ($(this).val() != "") {
                setDataWhenEnterSearchJSON($("#" + selectedRowID + "_mcode").val());
            }
        }
    });

    // เปลี่ยนจำนวน คำนวณ ผลรวมใหม่
    $("#" + selectedRowID + "_mamount").keyup(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        } else {
            if (e.keyCode == 13) {
                if ($(this).val() != '' && parseFloat($(this).val()) > 0) {
                    var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
                    var mAmount = $("#" + selectedRowID + "_mamount").val();
                    var mPricePerUnit = $("#" + selectedRowID + "_mpriceperunit").val();
                    var mDiscount = $("#" + selectedRowID + "_mdiscount").val();
                    var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
                    var munit = $("#" + selectedRowID + "_munit").val();
                    var mvat = $("#" + selectedRowID + "_mvat").val();
                    getPricePerUnitForEnterAmount(materialData.editdocdetailid, materialData.mid, munit, mAmount, mDiscount, mvat, mslDiscount, mPricePerUnit, 2);

                } else {
                    alert('จำนวนสินค้าต้องมากกว่า 0 ');
                }
            }
        }

    });

    // เปลี่ยนราคาต่อหน่วย คำนวณ ผลรวมใหม่
    $("#" + selectedRowID + "_mpriceperunit").keyup(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        }
        if (e.keyCode == 13) {
            if (parseFloat($(this).val()) >= 0) {
                var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
                var mAmount = $("#" + selectedRowID + "_mamount").val();
                var mPricePerUnit = $("#" + selectedRowID + "_mpriceperunit").val();
                var mDiscount = $("#" + selectedRowID + "_mdiscount").val();
                var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
                var munit = $("#" + selectedRowID + "_munit").val();
                var mvat = $("#" + selectedRowID + "_mvat").val();
                getPriceFromDropDownUnit(materialData.editdocdetailid, materialData.mid, munit, mAmount, mDiscount, mvat, mslDiscount, mPricePerUnit, 2);
                $("#" + selectedRowID + "_munit").focus();
                $("#" + selectedRowID + "_munit").select();
            } else {
                alert('ราคาต่อหน่วยต้องเป็น 0 หรือมากกว่าเท่านั้น');
            }

        }

    });
    // เปลี่ยนหน่วย คำนวณ ผลรวมใหม่
    $("#" + selectedRowID + "_munit").change(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        }


        var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
        var mAmount = $("#" + selectedRowID + "_mamount").val();
        var mPricePerUnit = $("#" + selectedRowID + "_mpriceperunit").val();
        var mDiscount = $("#" + selectedRowID + "_mdiscount").val();
        var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
        var mvat = $("#" + selectedRowID + "_mvat").val();
        //alert(mslDiscount + ' ' + mDiscount);
        getPriceFromDropDownUnit(materialData.editdocdetailid, materialData.mid, $(this).val(), mAmount, mDiscount, mvat, mslDiscount, mPricePerUnit, 1);
        $("#" + selectedRowID + "_mdiscount").select();
    });
    $("#" + selectedRowID + "_munit").keyup(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        }
        if (e.keyCode == 13) {
            $("#" + selectedRowID + "_mdiscount").select();
        }


    });

    // เปลี่ยนส่วนลด คำนวณ ผลรวมใหม่
    $("#" + selectedRowID + "_mdiscount").keyup(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        }
        if (e.keyCode == 13) {
            var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
            var mAmount = $("#" + selectedRowID + "_mamount").val();
            var mPricePerUnit = $("#" + selectedRowID + "_mpriceperunit").val();
            var mDiscount = $("#" + selectedRowID + "_mdiscount").val();
            var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
            var munit = $("#" + selectedRowID + "_munit").val();
            var mvat = $("#" + selectedRowID + "_mvat").val();
            //alert(mslDiscount + ' ' + mDiscount);
            getPriceFromDropDownUnit(materialData.editdocdetailid, materialData.mid, munit, mAmount, mDiscount, mvat, mslDiscount, mPricePerUnit, 2);
            $("#" + selectedRowID + "_mdiscount_sl").focus();

        }
    });
    // เปลี่ยนประเภทส่วนลด คำนวน ผลรวมใหม่
    $("#" + selectedRowID + "_mdiscount_sl").change(function(e) {
        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        }
        var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
        var mAmount = $("#" + selectedRowID + "_mamount").val();
        var mPricePerUnit = $("#" + selectedRowID + "_mpriceperunit").val();
        var mDiscount = $("#" + selectedRowID + "_mdiscount").val();
        var munit = $("#" + selectedRowID + "_munit").val();
        var mvat = $("#" + selectedRowID + "_mvat").val();
        //alert(mslDiscount + ' ' + mDiscount);
        getPriceFromDropDownUnit(materialData.editdocdetailid, materialData.mid, munit, mAmount, mDiscount, mvat, $(this).val(), mPricePerUnit, 2);
        if (e.keyCode == 13) {
            $("#" + selectedRowID + "_mvat").focus();
        }

    });
    $("#" + selectedRowID + "_mdiscount_sl").keyup(function(e) {
        if (e.keyCode == 13) {
            $("#" + selectedRowID + "_mvat").focus();

        }
    });
    $("#" + selectedRowID + "_mvat").keyup(function(e) {
        if (e.keyCode == 13) {
            var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
            var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
            jQuery("#theGrid").saveRow(selectedRowID, succesfunc, 'DataXML/ReceiptFormPOXML.aspx?action=addMaterialInDocDetial', { mid: materialData.mid, indexlist: selectedRowID, editdocdetailid: materialData.editdocdetailid, IsDiscount: mslDiscount }, aftersavefunc, errorfunc, afterrestorefunc);

        }
    });

}
function succesfunc() {
    rowState = null;
    $("#theGrid").jqGrid().trigger("reloadGrid");
    LoadSummaryDocument();
}
function aftersavefunc() {
    //alert('affter save');
    rowState = null;
    $("#theGrid").jqGrid().trigger("reloadGrid");
    LoadSummaryDocument();
}
function errorfunc() {
    //alert('error');
    rowState = null;
}
function afterrestorefunc() {
    //alert('after restore');
    rowState = null;
}
          
