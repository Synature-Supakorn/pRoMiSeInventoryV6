var documentData;
var hdfSDDocumentID;
var hdfSDShopID;
var rowState = null;
var docTransferTypeId;
var docRequestTypeId;
var docReceiveTransfer;
var getUrlDocTypID;
var postUrlDocTypeID;
var langID;
var newDocumentBatchID;
var newDocumentShopID;
var addFPParamDocId = '';
var addFPParamShopId = '';
// Already
$(function() {

    //กำหนด DocumentType ให้กับเอกสาร
    DocPackingTypeId = $.getUrlVar('DocPackingTypeId');
    //alert(DocPackingTypeId);
    getUrlDocTypID = "&DocPackingTypeId=" + DocPackingTypeId;
    postUrlDocTypeID = "DocPackingTypeId:" + DocPackingTypeId;

    //alert(getUrlDocTypID);
    var sltNameInv = "ddlSDFromInv";
    var sltNameInv2 = "ddlTFInv";
    LoadInventory(sltNameInv);
    LoadInventory(sltNameInv2);

    LoadRQStatus();
    CheckDocumentOnLoad();
    addEditMaterialJqGrid();
    jqGridMeterialInStock();

    langID = $.getUrlVar('LangID');

    // ปุ่มเพิ่มเอกสารการขอ
    $('#btnOkTFR').click(function() {
        AddDocumentToBatch();
    }).attr('disabled', true).addClass('ui-state-disabled');

    $('#btnSelectDocument').click(function() {
        LoadNewDocumentData();
        CheckDocumentStatus();
        $('#dialogSearchDocument').dialog('close');
    }).attr('disabled', true).addClass('ui-state-disabled');
    $('#btnSelectDocument2').click(function() {
        SelectDocumentForPrintTransfer();
        $('#dialogSearchDocument2').dialog('close');
    }).attr('disabled', true).addClass('ui-state-disabled');

    $('#txtDocumentDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar_blue.png',
        buttonImageOnly: true

    });

    $('#txtDeliveryDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar_blue.png',
        buttonImageOnly: true

    });

    $('#txtFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $.datepicker.setDefaults($.datepicker.regional[langID]);
    $('#txtToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $('#txtFromDate2').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $.datepicker.setDefaults($.datepicker.regional[langID]);
    $('#txtToDate2').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $.datepicker.setDefaults($.datepicker.regional[langID]);
    $('#txtCTFFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $.datepicker.setDefaults($.datepicker.regional[langID]);
    $('#txtCTFToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $.datepicker.setDefaults($.datepicker.regional[langID]);

    $('#btnSearchVendor').button({
        icons: { primary: 'ui-icon-search' }, text: false
    });
    $('#btnLoadDocument').button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $('#btnLoadDocument2').button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $('#btnSearchTFDocument').button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $('#btnCancel').button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $('#btnCancel2').button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $('#btnSelectDocument').button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $('#btnSelectDocument2').button({
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
    $("#btnOkTFR").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCancelTFR").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkCTF").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCancelCTF").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#MTBtnClose").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnListInvNotInRequest").button({
        icons: { primary: 'icon-action-search' }, text: true
    });


    $("button, input:submit, a", "#btnHeader").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-new'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-new'} })
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });

    $("#accordion").accordion({
        collapsible: true,
        autoHeight: false,
        navigation: true,
        icons: { 'header': 'ui-icon-circle-arrow-s', 'headerSelected': 'ui-icon-circle-arrow-n' }
    });
    $("select#slReport").selectmenu({ style: 'dropdown' }).change(function() {
        if ($(this + ":selected").val() != "0") {
            if ($(this + ":selected").val() == "1") {
                ViewSummaryReport();
            } else if ($(this + ":selected").val() == "2") {
                openDialogSearchDocumentForPrint('dialogSearchDocumentForPrint');

            } else if ($(this + ":selected").val() == "3") {
                window.open('../Inventory/Report/crReportPrepareDocument.aspx', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
                $(this).val("0");
            }
        }
    });
});
//======================================================== CheckSession  ========================================//
function CheckSessionTimeOut() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=CheckSession' + getUrlDocTypID,
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
//======================================================== Add Tab PrepareBatch  ========================================//
function AddTabPrepareBatch() {
    CheckSessionTimeOut();
    var documentShopId;
    var documentBatchId;
    var displayGroupName;
    var urlPrepare;
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=getPerpareBatch' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                if (xhr.responseText != '') {
                    var data = eval("(" + xhr.responseText + ")");
                    documentShopId = data.documentShopId
                    documentBatchId = data.documentBatchId
                    displayGroupName = data.displayGroupName
                    urlPrepare = 'Inventory/PrepareBatch.aspx?LangID=' + langID + "&documentShopId=" + documentShopId + "&documentBatchId=" + documentBatchId + "&docTransferTypeId=" + data.docTransferTypeId + "&docRequestTypeId=" + data.docRequestTypeId + "&docPackingTypeId=" + data.docPackingTypeId;
                    //alert(urlPrepare);
                    parent.addTab('#15069', 'เตรียม ' + displayGroupName, urlPrepare);
                    //parent.RemoveTab();
                } else {
                    parent.location.href = "../logout.aspx"
                }
            } else {
                parent.location.href = "../logout.aspx"
            }
        }
    });

}
//======================================================== สถานะเอกสารการขอสินค้า ============================================//

function LoadRQStatus() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=loadRQStatus' + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            //alert(data);
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);

        }
    });
}

//======================================================== OnLoad Docment ========================================//
function CheckDocumentOnLoad() {
    var statusDoc;
    var docRefId;
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=chekDoc' + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            ary_data = data.split(",");
            //alert(ary_data);
            for (i = 0; i < ary_data.length; i++) {
                if (ary_data[i] != '') {
                    ary_data2 = ary_data[i].split(";");
                    if (ary_data2[0] == 'hdfDocumentRefID') {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                        docRefId = ary_data2[1];
                    } else if (ary_data2[0] == 'hdfStatus') {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                        statusDoc = ary_data2[1]
                    }
                }
            }
            SetStatusButton(statusDoc, docRefId);

        }
    });
}

//======================================================== ส่วนแสดงหัวเอกสาร ========================================//

function DocmentHeader() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=loadDocHeader' + getUrlDocTypID,
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
                    } else {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                    }
                }
            }

        }
    });
}

//======================================================== กำหนดสถานะปุ่มจักการเอกสาร ========================================//
function CheckDocumentStatus() {
    var statusDoc;
    var docRefId;
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=chekDocStatus' + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            //alert(data);
            ary_data = data.split(",");
            for (i = 0; i < ary_data.length; i++) {
                if (ary_data[i] != '') {
                    ary_data2 = ary_data[i].split(";");
                    if (ary_data2[0] == 'hdfDocumentRefID') {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                        docRefId = ary_data2[1];
                    } else if (ary_data2[0] == 'hdfStatus') {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                        statusDoc = ary_data2[1]
                    }
                }
            }
            SetStatusButton(statusDoc, docRefId)
        }
    });

}

function SetStatusButton(statusDoc, documentRefId) {
    //alert(documentRefId);
    if (statusDoc == 0) {
        //DOCUMENTSTATUS_TEMP               
        $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSave').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocumentRequest').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTransferDoc').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('enable');
        $('#txtDeliveryDate').datepicker().datepicker('enable');
        $('#txtPackingName').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnListInvNotInRequest').attr("disabled", false).removeClass("ui-state-disabled");
        rowState = 'editing';
        DocmentHeader();
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");

    } else if (statusDoc == 1) {
        //DOCUMENTSTATUS_WORKING
        //$("#theGrid").attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocumentRequest').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTransferDoc').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtDeliveryDate').datepicker().datepicker('enable');
        $('#txtPackingName').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnListInvNotInRequest').attr("disabled", false).removeClass("ui-state-disabled");
        rowState = null;
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");

    } else if (statusDoc == 2) {
        //DOCUMENTSTATUS_APPROVE
        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocumentRequest').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTransferDoc').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnListInvNotInRequest').attr("disabled", false).removeClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");

    } else if (statusDoc == 99 || statusDoc == 3 || statusDoc == 4) {
        //DOCUMENTSTATUS_CANCEL ,DOCUMENTSTATUS_REFERED ,DOCUMENTSTATUS_FINISH
        // $("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocumentRequest').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTransferDoc').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnListInvNotInRequest').attr("disabled", false).removeClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");

    } else {

        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocumentRequest').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTransferDoc').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnListInvNotInRequest').attr("disabled", true).addClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");

        MatrixtGridviewOnLoad();
    }
}

//======================================================== ค้นหาคลังสินค้า ============================================//

// คลังสินค้า
function LoadInventory(selectorName) {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=loadInv' + getUrlDocTypID,
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
function LoadInventoryViewForSelect(selectorName, selInvId) {
    ///alert(selInvId);
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=loadInvView' + getUrlDocTypID,
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName, selInvId: selInvId }),
        success: function(data) {
            //alert(data);
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);

        }
    });
}

function SearchFromInv(id) {
    if (id == 'ddlTFInv') {
        LoadInventoryViewForSelect('ddlTFFromInv', $('#ddlTFInv').val());
    } else if (id == 'ddlTP1Inv') {
        LoadInventoryViewForSelect('ddlTP1FromInv', $('#ddlTP1Inv').val());
    } else if (id == 'ddlSDFromInv') {
        LoadInventoryViewForSelect('ddlSDToInv', $('#ddlSDFromInv').val());
    }
}

//======================================================== สร้างรอบเอกสารการโอน ============================================//         
function CreateNewDocumentBatch() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=newDoc' + getUrlDocTypID,
        cache: false,
        success: function(data) {
            CheckDocumentStatus();
            DocmentHeader();
            MatrixtGridviewOnLoad();
            $("#theGrid").jqGrid().trigger("reloadGrid");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}


//======================================================== ตรวจสอบการเลือกสร้างเอกสารการโอน ============================================//
function CheckCreateTransferdocument() {
    if ($('#rdoCTF1').is(':checked')) {
        $('#btnOkTFR').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelTFR').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnOkCTF').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCancelCTF').attr("disabled", false).removeClass("ui-state-disabled");
        $('#fsbox').attr("disabled", true).addClass("ui-state-disabled");
    } else {
        $('#btnOkTFR').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCancelTFR').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnOkCTF').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelCTF').attr("disabled", true).addClass("ui-state-disabled");
        $('#fsbox').attr("disabled", false).removeClass("ui-state-disabled");
    }
}


//======================================================== บันทึกเอกสารการโอน ============================================//

function SaveDocument() {
    CheckSessionTimeOut();
    var batchDate = $('#txtDocumentDate').val();
    var batchNote = $('#txtNote').val();
    var batchName = $('#txtPackingName').val();
    var batchDeliveryDate = $('#txtDeliveryDate').val();
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=saveDoc' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ batchDate: batchDate, batchNote: batchNote, batchName: batchName, batchDeliveryDate: batchDeliveryDate }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    $('#dialogConfirmSaveDoc').dialog('close');
                    //alert(data.strResultText);
                    DocmentHeader();
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmSaveDoc').dialog('close');
                    alert(data.strResultText);
                    DocmentHeader();
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }
    });

}
//======================================================== ยกเลิกรอบเอกสาร ============================================//

function CancelDocument() {
    CheckSessionTimeOut();
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=cancelDoc' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    $('#dialogConfirmCancelDoc').dialog('close');
                    //alert(data.strResultText);
                    DocmentHeader();
                    CheckDocumentStatus();
                    CreateGridview();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmCancelDoc').dialog('close');
                    alert(data.strResultText);
                    DocmentHeader();
                    CheckDocumentStatus();
                    CreateGridview();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });
}
//======================================================== อนุมัติรอบเอกสาร ============================================//
function CheckStockForTransferDocument() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=CheckStock' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(status);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 0) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    ApproveDocument();
                } else if (data.status == 1) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    alert(data.strResultText);
                    OpenDialog('DialogMaterialInStock');
                    ShowMaterialInStockEnoughForTransfer()
                } else {
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                }
            }
        }
    });
}
function ShowMaterialInStockEnoughForTransfer() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=LoadStockEnoughForTransfer' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        complete: function(xhr, status) {
            // alert(xhr.responseText);
            var mgrid = jQuery("#MTStock")[0];
            mgrid.addXmlData(xhr.responseXML);
        }
    });

}
function jqGridMeterialInStock() {
    var materialData = null;       //data from search material
    var materialCode = "";
    $("#MTStock").jqGrid({
        colNames: ['MaterialID', 'รหัสสินค้า', 'ชื่อสินค้า', 'TransferSmallAmount', 'จำนวนที่โอน', 'CurrentStockSmallAmount', 'คงเหลือ', 'UnitSmallID'],
        colModel: [
        { name: 'MaterialID', index: 'MaterialID', width: 40, hidden: true },
   		{ name: 'MaterialCode', index: 'MaterialCode', width: 80 },
   		{ name: 'MaterialName', index: 'MaterialName', width: 100 },
        { name: 'TransferSmallAmount', index: 'TransferSmallAmount', width: 100, hidden: true },
        { name: 'TransferDisplayText', index: 'TransferDisplayText', width: 200 },
        { name: 'CurrentStockSmallAmount', index: 'CurrentStockSmallAmount', width: 100, hidden: true },
        { name: 'CurrentStockDisplayText', index: 'CurrentStockDisplayText', width: 200 },
        { name: 'UnitSmallID', index: 'UnitSmallID', hidden: true }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 290,
        widht: 600,
        pager: $('#MTStockPage'),
        viewrecords: false,
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
}
function CheckApproveDocument() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=CheckApprove' + getUrlDocTypID,
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
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=ApproveDoc' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    closedialogConfirmDoc('dialogConfirmApproveDoc');
                    //alert(data.strResultText);
                    DocmentHeader();
                    CheckDocumentStatus();
                    CreateGridview();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {

                    closedialogConfirmDoc('dialogConfirmApproveDoc');
                    alert(data.strResultText);

                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });
}


//======================================================== เพิ่มเอกสารออกจากรอบการโอน ============================================//
function AddDocumentToBatch() {
    CheckSessionTimeOut();
    var addParamDocId = '';
    var addParamShopId = '';
    var rowCheckedDel = $("#jgdocsearch").jqGrid('getGridParam', 'selarrrow');
    if (rowCheckedDel != '') {

        for (var i = 0; i <= rowCheckedDel.length; i++) {
            var rowData = $('#jgdocsearch').jqGrid('getRowData', rowCheckedDel[i]);
            if (rowData.DocumentID != null && rowData.DocumentID != '') {
                if (addParamDocId == '') {
                    addParamDocId = rowData.DocumentID;
                } else {
                    addParamDocId += "," + rowData.DocumentID;
                }
            }
            if (rowData.DocumentShopID != null && rowData.DocumentShopID != '') {
                if (addParamShopId == '') {
                    addParamShopId = rowData.DocumentShopID;
                } else {
                    addParamShopId += "," + rowData.DocumentShopID;
                }
            }
        }

    } else {
        alert("กรุณาเลือกเอกสารที่ต้อง!");
        $('#jgdocsearch').setGridParam(({ multiselect: true })); /*.showCol('cb');*/
    }
    if (addParamDocId != '' && addParamShopId != '') {

        $.ajax({
            url: 'DataXML/PackingDocumentXML.aspx?action=AddDocToBatch&newDocID=' + addParamDocId + '&newShopID=' + addParamShopId + getUrlDocTypID,
            cache: false,
            datatype: 'json',
            type: 'GET',
            //data: ({ newDocID: addParamDocId, newShopID: addParamShopId }),
            complete: function(xhr, status) {
                //alert(xhr.responseText);
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);
                    if (data.status == 1) {
                        $('#dialogSearchTransferDocument').dialog('close');
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                        SearchDocumentRequest();
                        addParamDocId = '';
                        addParamShopId = '';
                        CreateGridview();
                    } else {
                        $('#dialogSearchTransferDocument').dialog('close');
                        var data = eval("(" + xhr.responseText + ")");
                        MessageError(data.strResultText);
                        addParamDocId = '';
                        addParamShopId = '';
                        CreateGridview();
                    }
                } else {
                    $('#dialogSearchTransferDocument').dialog('close');
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                    addParamDocId = '';
                    addParamShopId = '';
                    CreateGridview();
                }
            }

        });


    }


}

//======================================================== ลบเอกสารออกจากรอบการโอน ============================================//

function deleteDocumentInBatch(caption, msg, bOk, bCancel, url) {
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
            cache: false,
            datatype: 'json',
            type: 'GET',
            complete: function(xhr, status) {
                $("#delDialog").dialog('close');
                LoadNewDocumentData();
                CreateGridview();
            },
            error: function(xhr, status) {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
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

        if ($('#ddlTP1FromInv').val() != '-1') {
            if ($('#hdfStatus').val() == 0) {
                $('#' + id).dialog({ width: 500, autoOpen: false, bgiframe: true, modal: true });
                $('#' + id).dialog('open');
                $('#' + id).parent().appendTo($("form:first"));

            } else {
                SaveDocument()

            }
        } else {
            alert('ตรวจสอบการเลือกคลังสินค้าปลายทางที่ต้องการโอน');
        }
    } else if (statusEven == 2) {
        $('#' + id).dialog({ width: 500, autoOpen: false, bgiframe: true, modal: true });
        $('#' + id).dialog('open');
        $('#' + id).parent().appendTo($("form:first"));

    } else if (statusEven == 99) {
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

//======================================================== ค้นหาเอกสารรอบการโอน ============================================//

function openDialogSearchDocument(id) {
    $('#' + id).dialog({ width: 800, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));
    $("#jGDocument").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร', 'วันที่จัดส่งสินค้า', 'สถานะ', 'ชื่อรอบเอกสาร', 'หมายเหตุ', 'BatchAlreadyProcess', 'BatchType',
                'DocumentBatchID', 'DocumentShopID', 'DocumentBatchRefID', 'DocumentRefShopID', 'BatchRefStatus', 'BatchRefNumber', 'BatchInventoryID', 'BatchInvetoryName'],
        colModel: [
   		            { name: 'BatchNumber', index: 'BatchNumber', width: 150 },
                    { name: 'BatchDate', index: 'BatchDate', width: 150 },
                     { name: 'BatchDeliveryDate', index: 'BatchDeliveryDate', width: 150 },
   		            { name: 'BatchStatus', index: 'BatchStatus', width: 100 },
                    { name: 'BatchName', index: 'BatchName', width: 100, hidden: true },
                    { name: 'BatchNote', index: 'BatchNote', width: 100 },
                    { name: 'BatchAlreadyProcess', index: 'BatchAlreadyProcess', width: 100, hidden: true },
                    { name: 'BatchType', index: 'BatchType', width: 100, hidden: true },
                    { name: 'DocumentBatchID', index: 'DocumentBatchID', width: 100, hidden: true },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentBatchRefID', index: 'DocumentBatchRefID', width: 100, hidden: true },
                    { name: 'DocumentRefShopID', index: 'DocumentRefShopID', width: 100, hidden: true },
                    { name: 'BatchRefStatus', index: 'BatchRefStatus', width: 100, hidden: true },
                    { name: 'BatchRefNumber', index: 'BatchRefNumber', width: 100, hidden: true },
                    { name: 'BatchInventoryID', index: 'BatchInventoryID', width: 100, hidden: true },
                    { name: 'BatchInvetoryName', index: 'BatchInvetoryName', width: 100, hidden: true }
                     	],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pageDocument'),
        viewrecords: false,
        ondblClickRow: function(rowID, iRow, iCol, e) {
            LoadNewDocumentData();
            CheckDocumentStatus();
            $('#' + id).dialog('close');
            $("#theGrid").jqGrid().trigger("reloadGrid");
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
    SearchDocumentData();

}
//======================================= ค้นหารอบเอกสารสำหรับพิมพ์ใบโอนย้าย =========================================
function openDialogSearchDocumentForPrint(id) {
    $('#' + id).dialog({ width: 800, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));
    $("#jGDocument2").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร', 'วันที่จัดส่งสินค้า', 'สถานะ', 'ชื่อรอบเอกสาร', 'หมายเหตุ', 'BatchAlreadyProcess', 'BatchType',
                'DocumentBatchID', 'DocumentShopID', 'DocumentBatchRefID', 'DocumentRefShopID', 'BatchRefStatus', 'BatchRefNumber', 'BatchInventoryID', 'BatchInvetoryName'],
        colModel: [
   		            { name: 'BatchNumber', index: 'BatchNumber', width: 150 },
                    { name: 'BatchDate', index: 'BatchDate', width: 150 },
                    { name: 'BatchDeliveryDate', index: 'BatchDeliveryDate', width: 150 },
   		            { name: 'BatchStatus', index: 'BatchStatus', width: 100 },
                    { name: 'BatchName', index: 'BatchName', width: 100, hidden: true },
                    { name: 'BatchNote', index: 'BatchNote', width: 100 },
                    { name: 'BatchAlreadyProcess', index: 'BatchAlreadyProcess', width: 100, hidden: true },
                    { name: 'BatchType', index: 'BatchType', width: 100, hidden: true },
                    { name: 'DocumentBatchID', index: 'DocumentBatchID', width: 100, hidden: true },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentBatchRefID', index: 'DocumentBatchRefID', width: 100, hidden: true },
                    { name: 'DocumentRefShopID', index: 'DocumentRefShopID', width: 100, hidden: true },
                    { name: 'BatchRefStatus', index: 'BatchRefStatus', width: 100, hidden: true },
                    { name: 'BatchRefNumber', index: 'BatchRefNumber', width: 100, hidden: true },
                    { name: 'BatchInventoryID', index: 'BatchInventoryID', width: 100, hidden: true },
                    { name: 'BatchInvetoryName', index: 'BatchInvetoryName', width: 100, hidden: true }
                     	],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pageDocument2'),
        viewrecords: false,
        multiselect: true,
        multiboxonly: true,
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
    SearchDocumentDataForPrint();
}
// ค้นหาเอกสารรอบการโอนสินค้า
function SearchDocumentData() {
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();
    var dStatus = $('#ddlSDStatus').val();
    var dInvId = $('#ddlSDFromInv').val();
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=searchdoc' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ txtFromDate: fromDate, txtToDate: toDate, dStatus: dStatus, dInv: dInvId }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jGDocument")[0];
            gridDoc.addXmlData(xhr.responseXML);
            if ($("#jGDocument").jqGrid('getGridParam', 'records') > 0)
                $('#btnSelectDocument').attr('disabled', false).removeClass('ui-state-disabled');
            else
                $('#btnSelectDocument').attr('disabled', true).addClass('ui-state-disabled');

        }
    });

}
function SearchDocumentDataForPrint() {
    var fromDate = $('#txtFromDate2').val();
    var toDate = $('#txtToDate2').val();
    var dStatus = $('#ddlSDStatus2').val();
    var dInvId = 1;
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=searchdoc' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ txtFromDate: fromDate, txtToDate: toDate, dStatus: dStatus, dInv: dInvId }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jGDocument2")[0];
            gridDoc.addXmlData(xhr.responseXML);
            if ($("#jGDocument2").jqGrid('getGridParam', 'records') > 0)
                $('#btnSelectDocument2').attr('disabled', false).removeClass('ui-state-disabled');
            else
                $('#btnSelectDocument2').attr('disabled', true).addClass('ui-state-disabled');

        }
    });

}
//======================================================== เลือกรอบเอกสารที่ต้องการพิมพ์ =========================================================//
function SelectDocumentForPrintTransfer() {

    //alert(addParamDocId + ':' + addParamShopId);
    var rowCheckedDel = $("#jGDocument2").jqGrid('getGridParam', 'selarrrow');
    if (rowCheckedDel != '') {

        for (var i = 0; i <= rowCheckedDel.length; i++) {
            var rowData = $('#jGDocument2').jqGrid('getRowData', rowCheckedDel[i]);
            if (rowData.DocumentBatchID != null && rowData.DocumentBatchID != '') {
                if (addFPParamDocId == '') {
                    addFPParamDocId = rowData.DocumentBatchID;
                } else {
                    addFPParamDocId += "," + rowData.DocumentBatchID;
                }
            }
            if (rowData.DocumentShopID != null && rowData.DocumentShopID != '') {
                if (addFPParamShopId == '') {
                    addFPParamShopId = rowData.DocumentShopID;
                } else {
                    addFPParamShopId += "," + rowData.DocumentShopID;
                }
            }
        }

    } else {
        alert("กรุณาเลือกเอกสาร!");
        $('#jGDocument2').setGridParam(({ multiselect: true })); /*.showCol('cb');*/
    }
    //alert(addParamDocId + ':' + addParamShopId);

    if (addFPParamDocId != '' && addFPParamShopId != '') {

        $.ajax({
            url: 'DataXML/PackingDocumentXML.aspx?action=CreateSessionArrayForPrintTransfer&newDocID=' + addFPParamDocId + '&newShopID=' + addFPParamShopId + getUrlDocTypID,
            cache: false,
            context: document.body,
            success: function(data) {
                closeDialogSearchDocument('dialogSearchDocumentForPrint');
                window.open('../Inventory/Report/CrDocRequestAndTransfer.aspx', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
                $(this).val("0");

            }
        });

        addFPParamDocId = '';
        addFPParamShopId = '';
    }
}

//======================================================== ค้นหาเอกสารการขอสินค้าที่ยังไม่เข้าร่วมใน batch ============================================//

function openDialogSearchDocumentRequest(id, statusId) {
    $('#' + id).dialog({ width: 800, height: 550, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#hdfSearchDoc').val(statusId);
    $('#' + id).parent().appendTo($("form:first"));

    $("#jgdocsearch").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร','วันที่จัดส่ง', 'จากคลัง', 'ไปคลัง',
                'หมายเหตุ', 'DocumentShopID', 'DocumentID', 'DocumentType'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
                    { name: 'DocumentDate', index: 'DocumentDate', width: 150 },
                    { name: 'DueDate', index: 'DueDate', width: 150 },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100 },
                    { name: 'DocumentToInventoryName', index: 'DocumentToInventoryName', width: 100 },                    
                    { name: 'DocumentNote', index: 'DocumentNote', width: 100 },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                    { name: 'DocumentType', index: 'DocumentType', width: 100, hidden: true }

                     	],
        autowidth: true,
        height: 300,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: true,
        multiboxonly: true,
        pager: $('#pagedocsearch'),
        viewrecords: true,
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
    SearchDocumentRequest();

}

function SearchDocumentRequest() {
    var fromDate = $('#txtCTFFromDate').val();
    var toDate = $('#txtCTFToDate').val();
    var dStatus = $('#ddlRQStatus').val();
    var dInvID = $('#ddlTFInv').val();
    var statusDialog = $('#hdfSearchDoc').val();
    var chkDaliveryDateValue;
    var chkCreateDocValue;
    if ($('#chkDaliveryDate').attr('checked') == true) {
        chkDaliveryDateValue = 1
    } else {
        chkDaliveryDateValue = 0
    }
    if ($('#chkCreateDoc').attr('checked') == true) {
        chkCreateDocValue = 1
    } else {
        chkCreateDocValue = 0
    }

    //alert(dStatus);
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=searchdocRQ' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ txtFromDate: fromDate, txtToDate: toDate, dStatus: dStatus, dInv: dInvID, searchCreateDoc: chkCreateDocValue, searchDaliveryDate: chkDaliveryDateValue }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jgdocsearch")[0];
            gridDoc.addXmlData(xhr.responseXML);
            if (statusDialog == 2) {
                if ($("#jgdocsearch").jqGrid('getGridParam', 'records') > 0)
                    $('#btnOkTFR').attr('disabled', false).removeClass('ui-state-disabled');
                else
                    $('#btnOkTFR').attr('disabled', true).addClass('ui-state-disabled');
            } else if (statusDialog == 1) {
                $('#btnOkTFR').attr('disabled', true).addClass('ui-state-disabled');
            }

        }
    });

}
//======================================================== แสดงสาขาที่ยังไม่ส่งการขอสินค้า ============================================//

function openDialogSearchInventoryNotInRequestBatch() {
    $('#DialogListInventoryNotInRequstBatch').dialog({ width: 600, height: 450, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#DialogListInventoryNotInRequstBatch').dialog('open');
    $('#DialogListInventoryNotInRequstBatch').parent().appendTo($("form:first"));

    $("#jqGridInvNotRequest").jqGrid({
        //url: '?',
        colNames: ['#', 'รหัสคลัง', 'ชื่อคลัง'],
        colModel: [
   		            { name: 'id', index: 'id', width: 30, align: 'center' },
                    { name: 'InventoryCode', index: 'InventoryCode', width: 100 },
                    { name: 'InventoryName', index: 'InventoryName', width: 300 },
                  ],
        autowidth: true,
        height: 300,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        pager: $('#pGridInvNotRequest'),
        viewrecords: true,
        caption: "Result."
    }).navGrid('#pGridInvNotRequest', { edit: false, add: false, del: false, search: false, refresh: false });
    SearchInventoryNotInRequestBatch();
}
function SearchInventoryNotInRequestBatch() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=ListInventoryNotInRequestBatch' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jqGridInvNotRequest")[0];
            gridDoc.addXmlData(xhr.responseXML);
        }
    });

}
// ค้นหาเอกสารใบใหม่เพื่อมาทำรายการ
function LoadNewDocumentData() {
    var gridRow = $("#jGDocument").getGridParam('selrow');
    var data = $("#jGDocument").getRowData(gridRow);
    newDocumentBatchID = data.DocumentBatchID;
    newDocumentShopID = data.DocumentShopID;

    if (newDocumentBatchID != '' && newDocumentShopID != '' || newDocumentBatchID != 0 && newDocumentShopID != 0) {
        $.ajax({
            url: 'DataXML/PackingDocumentXML.aspx?action=loadNewDocment' + getUrlDocTypID,
            cache: false,
            datatype: 'json',
            type: 'GET',
            data: ({ newDocID: newDocumentBatchID, newShopID: newDocumentShopID }),
            complete: function(xhr, status) {
                //alert(xhr.responseText);
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);
                    if (data.status == 1) {
                        DocmentHeader();
                        CheckDocumentStatus();
                        CreateGridview();
                        $("#theGrid").jqGrid().trigger("reloadGrid");

                    } else {
                        alert(data.ResultText);
                        CheckDocumentOnLoad();
                        CheckCreateTransferdocument();
                        MatrixtGridviewOnLoad();
                    }
                } else {
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                    CheckDocumentOnLoad();
                    CheckCreateTransferdocument();
                }
            }
        });

    }

}

function LoadNewDocumentDataFormDocumentBox(newDocID, newShopID) {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=loadNewDocment' + getUrlDocTypID,
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
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");

                } else {
                    alert(data.ResultText);
                    CheckDocumentOnLoad();
                    CheckCreateTransferdocument();
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
                CheckDocumentOnLoad();
                CheckCreateTransferdocument();
            }
        }
    });
}


// ปิดหน้าต่าง Dialog การค้นหาเอกสารการโอน
function closeDialogSearchDocument(id) {
    $('#' + id).dialog('close');
}


//======================================================== ส่วนของการจัดการเอกสาร เพิ่ม ลบ สินค้า ============================================//

var selectedRowID = 0;      //selected rowid for edit

function addEditMaterialJqGrid() {

    $("#theGrid").jqGrid({
        url: 'DataXML/PackingDocumentXML.aspx?action=loadDocDetail' + getUrlDocTypID,
        datatype: 'xml',
        colNames: ['#', 'เลขที่เอกสาร', 'วันที่เอกสาร', 'ไปคลัง',
               'วันที่นัดส่ง', 'หมายเหตุ', 'DocumentID', 'DocumentShopID', 'DocumentInventoryID', 'DocumentReceiveBy', 'DocumentStatus', 'DocumentToInventoryID',
                'DocumentTypeID'],
        colModel: [
                { name: 'id', index: 'id', width: 50, align: 'center' },
                { name: 'DocumentNumber', index: 'DocumentNumber', width: 100 },
                { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                { name: 'DocumentInventoryName', index: 'DocumentInventoryName', width: 150 },
                { name: 'DocumentDeliveryDate', index: 'DocumentDeliveryDate', width: 100 },
                { name: 'DocumentNote', index: 'DocumentNote', width: 300 },
                { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                { name: 'DocumentInventoryID', index: 'DocumentInventoryID', width: 100, hidden: true },
                { name: 'DocumentReceiveBy', index: 'DocumentReceiveBy', width: 100, hidden: true },
                { name: 'DocumentStatus', index: 'DocumentStatus', width: 100, hidden: true },
                { name: 'DocumentToInventoryID', index: 'DocumentToInventoryID', width: 100, hidden: true },
                { name: 'DocumentTypeID', index: 'DocumentTypeID', width: 100, hidden: true }

                ],
        pager: '#pager',
        autowidth: true,
        height: 150,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: true,
        multiboxonly: true,
        viewrecords: true,
        caption: 'เอกสารการขอสินค้า',
        ondblClickRow: function(rowidx, iRow, iCol, e) {
            var docData = $(this).jqGrid('getRowData', rowidx);
            //  AddTabWorkingDocument('2', docData.DocumentID, docData.ShopID, docData.DocumentTypeID, docData.DocumentStatus, docData.ToInventoryID, docData.FromInventoryID);
        }
    });
    SettingPageGridView(true);
}

function SettingPageGridView(action) {
    var delParamDocId = '';
    var delParamShopId = '';
    var delURL;
    if (action == true) {
        //-- จัดการ page
        $("#theGrid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false }).navButtonAdd('#pager', {
            id: 'theGrid-del-btn', // Add id ให้ปุ่ม Delete
            caption: "ลบรายการ",
            buttonicon: "ui-icon-trash",
            onClickButton: function() {
                var rowCheckedDel = $("#theGrid").jqGrid('getGridParam', 'selarrrow');
                delParamDocId = '';
                delParamShopId = '';
                for (var i = 0; i <= rowCheckedDel.length; i++) {
                    var rowData = $(this).jqGrid('getRowData', rowCheckedDel[i]);
                    //alert(delParamDocId);
                    if (rowData.DocumentID != null && rowData.DocumentID != '') {
                        if (delParamDocId == '') {
                            delParamDocId = rowData.DocumentID;
                        } else {
                            delParamDocId += "," + rowData.DocumentID;
                        }
                    }
                    if (rowData.DocumentShopID != null && rowData.DocumentShopID != '') {
                        if (delParamShopId == '') {
                            delParamShopId = rowData.DocumentShopID;
                        } else {
                            delParamShopId += "," + rowData.DocumentShopID;
                        }
                    }
                }
                delURL = '';
                delURL = 'DataXML/PackingDocumentXML.aspx?action=DelDocInBatch&newDocID=' + delParamDocId + '&newShopId=' + delParamShopId + getUrlDocTypID
                //alert(delURL);
                if (rowCheckedDel != '') {
                    deleteDocumentInBatch('ลบข้อมูล', 'ต้องการลบข้อมูล ใช่หรือไม่', 'ตกลง', 'ยกเลิก', delURL);
                } else {
                    alert("กรุณาเลือกแถวที่ท่านต้องการลบก่อน!");
                    $(this).setGridParam(({ multiselect: true }));
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
    } else {
        $("#theGrid").jqGrid('navGrid', '#pager', { edit: edit, add: add, del: del, search: search });

    }

}

//-- resize grid when resize browser
$(window).bind('resize', function() {
    $("#theGrid").setGridWidth($(window).width() - 8);
}).trigger('resize');


function addRow() {
    $("#boxAddRow").dialog({
        resizable: false,
        height: 60,
        width: 170,
        title: 'เพิ่มแถว',
        modal: false
    });
    $("#btnAddRow").click(function() {
        $.post('DataXML/PackingDocumentXML.aspx?action=addrow' + getUrlDocTypID,
             { custom_row: $("#txtAddRow").val() },
             function(data, textStatus, XMLHttpRequest) {
                 //alert(textStatus);
                 $("#theGrid").jqGrid().trigger("reloadGrid");
             });
        $("#boxAddRow").dialog('close');
    });
}

function setFocus(theGrid, elm_name) {
    //-- set focus to element
    $(elm_name).focus();
}


function succesfunc() {
    rowState = null;
    $("#theGrid").jqGrid().trigger("reloadGrid");

}
function aftersavefunc() {
    //alert('affter save');
    rowState = null;
    $("#theGrid").jqGrid().trigger("reloadGrid");

}
function errorfunc() {
    //alert('error');
    rowState = null;
}
function afterrestorefunc() {
    //alert('after restore');
    rowState = null;
}
function closedialog(id) {
    $('#' + id).dialog('close');
}
function OpenDialog(id) {
    $('#' + id).dialog({ width: 600, autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));
}

//========================================================   Matrixt Gridview Prepare Data ============================================//
function CreateGridview() {
    var viewGridBy;
    if ($('#cbMaterialViewMatrix').attr('checked') == true) {
        viewGridBy = "CreateGridviewMatrixt"
        //alert(viewGridBy);
    } else {
        viewGridBy = "CreateGridviewMaterial"
        //alert(viewGridBy);
    }
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=' + viewGridBy + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            //alert(data);
            $("#GridViewMatrix").html(data);
        }
    });

}
function MatrixtGridviewOnLoad() {
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=ViewGridOnLoad' + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            $("#GridViewMatrix").html(data);

        }
    });
}
function DisableIncludeNoDelivery() {
    if ($('#ddlDeliveryDate').val() == 1) {
        $('#IncludeNoDelivery').attr("disabled", true).addClass("ui-state-disabled");
    } else {
        $('#IncludeNoDelivery').attr("disabled", false).removeClass("ui-state-disabled");
    }

}
function SaveMaterial(rowid, cellname, value, iRow, iCol) {
    //alert(cellname);
    var gridData = $("#theGrid2").jqGrid('getRowData', rowid);
    var batchShopID;
    var batchMaterial;
    var viewGridBy;
    var batchMaterialUnitId;
    if ($('#cbMaterialViewMatrix').attr('checked') == true) {
        ary_data = cellname.split("_");
        batchShopID = ary_data[1];
        batchMaterial = gridData.MaterialID;
        batchMaterialUnitId = gridData.UnitLargeID;
    } else {
        batchShopID = gridData.InventoryId;
        batchMaterial = gridData.MaterialID;
        batchMaterialUnitId = gridData.UnitLargeID;
    }
    //alert(batchShopID);
    if (parseFloat(batchShopID) > -1) {
        //alert(batchShopID);
        updateMT(batchShopID, batchMaterial, batchMaterialUnitId, value);
    }
}
function updateMT(batchShopId, batchMaterilId, batchMaterilUnitId, materialAmount) {
    //alert(batchMaterilId);
    //alert(batchShopId);
    //alert(materialAmount);
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=UpdateMaterial' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'POST',
        data: ({ batchShopId: batchShopId, batchMaterilId: batchMaterilId, batchMaterilUnitId: batchMaterilUnitId, materialAmount: materialAmount }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var data = eval("(" + xhr.responseText + ")");
            //alert(data.status);
            if (data.status == 1) {
                //alert(data.strResultText);
                $("#theGrid2").jqGrid().trigger("reloadGrid");
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);

            }

        }
    });

}
function ViewSummaryReport() {
    newWindow = window.open('../Inventory/SummaryPackingTransfer.aspx?LangID=' + langID + getUrlDocTypID, '', 'width=1024,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    $(this).val("0");
}
