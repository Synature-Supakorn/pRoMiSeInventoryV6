var documentData;
var hdfSDDocumentID;
var hdfSDShopID;
var rowState = null;
var docTransferTypeId;
var docRequestTypeId;
var docReceiveTransfer;
var getUrlDocTypID;
var postUrlDocTypeID;
var CanEditMaterialAmount;
var cmMaterialId;
var cmMaterialUnitId;
var cmAmount;
var langID;
// Already
$(function() {

    //กำหนด DocumentType ให้กับเอกสาร
    docTransferTypeId = $.getUrlVar('DocTrnasferTypeID');
    docRequestTypeId = $.getUrlVar('DocRequestTypeID');
    docReceiveTransfer = $.getUrlVar('DocReceiveTypeId');
    langID = $.getUrlVar('LangID');

    getUrlDocTypID = "&docTransferTypeId=" + docTransferTypeId + "&docRequestTypeId=" + docRequestTypeId + "&docReceiveTransfer=" + docReceiveTransfer;
    postUrlDocTypeID = "docTransferTypeId:" + docTransferTypeId + "docRequestTypeId:" + docRequestTypeId + "docReceiveTransfer:" + docReceiveTransfer;

    //alert(getUrlDocTypID);

    var sltNameInv = "ddlTFInv";
    var sltNameInvSearch = "ddlTPInv";
    LoadInventory(sltNameInv);
    LoadInventory(sltNameInvSearch);

    // check esc key
    $("html body").keyup(function(e) {
        if (e.keyCode == 27) {
            //alert(selectedRowID);
            $("#theGrid").restoreRow(selectedRowID);
            if (rowState == 'editing')
                rowState = null;
        }
    });

    jqGridMeterial()
    LoadMaterialGroup();
    addEditMaterialJqGrid();
    CheckCanEditMaterialAmount();
    var newDocumentID;
    var newShopID;
    var newInvId;
    var newOtherInvID;
    var newStatus;
    if ($.getUrlVar('lnd') != undefined && $.getUrlVar('docId') != undefined && $.getUrlVar('shopId') != undefined && $.getUrlVar('docStatus') != undefined && $.getUrlVar('docInvId') != undefined && $.getUrlVar('docOtherInv') != undefined) {
        newDocumentID = $.getUrlVar('docId');
        newShopID = $.getUrlVar('shopId');
        newStatus = $.getUrlVar('docStatus');
        newInvId = $.getUrlVar('docInvId');
        newOtherInvID = $.getUrlVar('docOtherInv');
        if ($.getUrlVar('lnd') == 1) {
            LoadNewDocumentDataFormDocumentBox(newDocumentID, newShopID);
        } else if ($.getUrlVar('lnd') == 2) {
            // alert(newStatus);
            // alert(newOtherInvID);
            CreateNewDocumentformDocumentBox(newDocumentID, newShopID, newStatus, newInvId, newOtherInvID);
        }
    } else {

        CheckDocumentOnLoad();
        LoadPoStatus();

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
    $('#txtTFFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $('#txtTFToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $.datepicker.setDefaults($.datepicker.regional[langID]);

    $('#btnLoadDocument').button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $('#btnSearchTFDocument').button({
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
    $("#btnOkTF").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCancelTF").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnDelMaterial").button({
        icons: { primary: 'icon-action-cancel' }, text: true
    });
    $("#SearchMaterial").button({
        icons: { primary: 'ui-icon-search' }, text: true
    });


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

    $("#txtMCode").keyup(function(e) {
        if (e.keyCode == 13) {
            setDataWhenEnterSearchJSON($(this).val());
            $("#txtMCode").focus();
        }

    });
    $("#txtMAmount").keyup(function(e) {
        if (e.keyCode == 13) {
            cmAmount = $("#txtMAmount").val();
            CompareMaterial(cmMaterialId, cmAmount, cmMaterialUnitId);
            $("#txtMCode").focus();
        }
    });

    $("#txtDelMCode").keyup(function(e) {
        if (e.keyCode == 13) {
            setDataWhenEnterSearchJSONForDelete($(this).val());
        }
    });

});
//======================================================== CheckSession  ========================================//
function CheckSessionTimeOut() {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=CheckSession',
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
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=chekDoc' + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            ary_data = data.split(";");
            $("#" + ary_data[0]).val(ary_data[1]);
            SetStatusButton(ary_data[1])
        }
    });
}
//======================================================== Check can edit material amount ========================================//
function CheckCanEditMaterialAmount() {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=chekcaneditamount' + getUrlDocTypID,
        cache: false,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            var data = eval("(" + xhr.responseText + ")");
            CanEditMaterialAmount = data.CanEditMaterialAmount;
        }
    });
}
//======================================================== ส่วนแสดงหัวเอกสาร ========================================//

function DocmentHeader() {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadDocHeader' + getUrlDocTypID,
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
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=chekDocStatus' + getUrlDocTypID,
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
    //$('#txtVendorCode').attr("disabled", true).addClass("ui-state-disabled");
    $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
    $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtDueDate').attr("disabled", true).addClass("ui-state-disabled");
    //$('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtInvName').attr("disabled", true).addClass("ui-state-disabled");
    $('#txtReferenceNo').attr("disabled", true).addClass("ui-state-disabled");
    $('#SearchMaterial').attr("disabled", true).addClass("ui-state-disabled");
    $('#btnDelMaterial').attr("disabled", true).addClass("ui-state-disabled");
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
        //$('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#creditDay').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", false).removeClass("ui-state-disabled");
        rowState = 'editing';
        //$("#compareMaterial").attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('enable');
        $('#SearchMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnDelMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMCode').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMAmount').attr("disabled", true).addClass("ui-state-disabled");

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
        //$('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#creditDay').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = null;
        //$("#compareMaterial").attr("disabled", false).removeClass("ui-state-disabled");
        $('#SearchMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnDelMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtMCode').attr("disabled", false).removeClass("ui-state-disabled");
        if (CanEditMaterialAmount == 0) {
            $('#txtMAmount').attr("disabled", true).addClass("ui-state-disabled");
        } else {
            $('#txtMAmount').attr("disabled", false).removeClass("ui-state-disabled");
        }
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
        //$('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = 'editing';
        $("#theGrid").setGridParam({ multiboxonly: false }).hideCol('cb');
        //$("#compareMaterial").attr("disabled", true).addClass("ui-state-disabled");
        $('#SearchMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnDelMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMCode').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMAmount').attr("disabled", true).addClass("ui-state-disabled");
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
        //$('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        rowState = 'editing';
        //$("#compareMaterial").attr("disabled", true).addClass("ui-state-disabled");
        $('#SearchMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnDelMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMCode').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMAmount').attr("disabled", true).addClass("ui-state-disabled");
    } else {

        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        //$('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtInvoiceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#creditDay').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTermOfPayment').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        //openDialogSearchDocumentTransfer('dialogSearchTransferDocument');
        rowState = 'editing';
        $("#theGrid").setGridParam({ multiboxonly: false }).hideCol('cb');
        $('#SearchMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnDelMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMCode').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtMAmount').attr("disabled", true).addClass("ui-state-disabled");

    }
}
//======================================================== สถานะเอกสารการโอนสินค้า ============================================//

function LoadPoStatus(selectorName) {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadPOStatus' + getUrlDocTypID,
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
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadInv' + getUrlDocTypID,
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName }),
        success: function(data) {
            // alert(data);
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);
            if (selectorName == 'ddlTFInv') {
                LoadInventoryViewForSelect('ddlTFFromInv', $('#ddlTFInv').val());
            }
        }
    });
}
function LoadInventoryViewForSelect(selectorName, selInvId) {
    ///alert(selInvId);
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadInvView' + getUrlDocTypID,
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName, selInvId: selInvId }),
        success: function(data) {
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);

        }
    });
}

function SearchFromInv() {
    LoadInventoryViewForSelect('ddlTFFromInv', $('#ddlTFInv').val());

}
//======================================================== กลุ่มสินค้า หมวดสินค้า ============================================//

function LoadMaterialGroup() {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadMatGroup' + getUrlDocTypID,
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
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadMatDept' + getUrlDocTypID,
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
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=searchMatByGroupAndCode' + getUrlDocTypID,
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

//======================================================== สร้างเอกสารรับจากการโอน ============================================//

// สร้างเอกสารการรับจากการโอน
function CreateNewDocument() {
    var gridRow = $("#jgdocsearch").getGridParam('selrow');
    var data = $("#jgdocsearch").getRowData(gridRow);
    var refDocumentId = data.DocumentID;
    var refDocumentShopId = data.DocumentShopID;
    var refDocumentStatus = data.DocumentStatus;
    var refFromInventoryId = data.DocumentInventoryID;
    var refInventoryId = data.DocumentToInventoryID;
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=newDoc' + getUrlDocTypID,
        cache: false,
        data: ({ refDocumentId: refDocumentId, refDocumentShopId: refDocumentShopId, refDocumentStatus: refDocumentStatus, refFromInventoryId: refFromInventoryId, refInventoryId: refInventoryId }),
        success: function(data) {
            CheckDocumentStatus();
            DocmentHeader();
            $("#theGrid").jqGrid().trigger("reloadGrid");
            $("#theGrid2").jqGrid().trigger("reloadGrid");
            $('#dialogSearchTransferDocument').dialog('close');
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}

function CreateNewDocumentformDocumentBox(DocumentID, DocumentShopID, DocumentStatus, DocumentInventoryID, DocumentOtherInventoryID) {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=newDoc' + getUrlDocTypID,
        cache: false,
        data: ({ refDocumentId: DocumentID, refDocumentShopId: DocumentShopID, refDocumentStatus: DocumentStatus, refFromInventoryId: DocumentOtherInventoryID, refInventoryId: DocumentInventoryID }),
        success: function(data) {
            CheckDocumentStatus();
            DocmentHeader();
            $("#theGrid").jqGrid().trigger("reloadGrid");
            $("#theGrid2").jqGrid().trigger("reloadGrid");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}

//======================================================== บันทึกเอกสารรับจากการโอน ============================================//

function SaveDocument() {
    CheckSessionTimeOut();
    var docDate = $('#txtDocumentDate').val();
    var note = $('#txtNote').val();
    var invoiceNo = $('#txtInvoiceNo').val();

    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=saveDoc' + getUrlDocTypID,
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
//======================================================== ยกเลิกเอกสารรับจากการโอน ============================================//

function CancelDocument() {
    CheckSessionTimeOut();
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=cancelDoc' + getUrlDocTypID,
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
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmCancelDoc').dialog('close');
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
//======================================================== อนุมัติเอกสารรับจากการโอน ============================================//

function CheckApproveDocument() {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=CheckApprove' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(status);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                // alert(data.status);
                if (data.status == 0) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    alert(data.strResultText);
                } else if (data.status == 1) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    $('#hdfDocumentDateApprove').val(data.newDocumentDate);
                    // alert($('#hdfDocumentDateApprove').val());
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
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=ApproveDoc' + getUrlDocTypID,
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
                    //alert(data.strResultText);
                    closeDialogSearchDocument('dialogConfirmApproveDocAgain');
                    DocmentHeader();
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

//======================================================== ค้นหาเอกสารรับจากการโอน ============================================//
// เปิด Dialoa ค้นหาเอกสาร เพื่อให้เลือกเงื่อนไขในการค้นหาได้
function openDialogSearchDocument(id) {
    $('#' + id).dialog({ width: 700, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));

    // GridView แสดงข้อมูลเอสารตามที่ค้นหา
    $("#jGDocument").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'เลขที่เอกสารอ้างอิง', 'วันที่เอกสาร', 'สถานะ', 'คลัง', 'DocumentShopID', 'DocumentID'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
                    { name: 'DocumentRefNumber', index: 'DocumentRefNumber', width: 150 },
   		            { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                    { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100 },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
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
    SearchRODocumentData();

}
//======================================================== ค้นหาเอกสารการโอนสินค้า ============================================//
// เปิด Dialoa ค้นหาเอกสาร เพื่อให้เลือกเงื่อนไขในการค้นหาได้
function openDialogSearchDocumentTransfer(id) {
    $('#' + id).dialog({ width: 700, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));

    // GridView แสดงข้อมูลเอสารตามที่ค้นหา
    $("#jgdocsearch").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร', 'คลัง', 'DocumentInventoryID', 'DocumentFromInventoryName', 'DocumentFromInventoryID', 'DocumentToInventoryName', 'DocumentToInventoryID', 'DocumentID', 'DocumentShopID', 'DocumentStatus'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
   		            { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100 },
                    { name: 'DocumentInventoryID', index: 'DocumentInventoryID', width: 100, hidden: true },
                    { name: 'DocumentFromInventoryName', index: 'DocumentFromInventoryName', width: 100, hidden: true },
                    { name: 'DocumentFromInventoryID', index: 'DocumentFromInventoryID', width: 100, hidden: true },
                    { name: 'DocumentToInventoryName', index: 'DocumentToInventoryName', width: 100, hidden: true },
                    { name: 'DocumentToInventoryID', index: 'DocumentToInventoryID', width: 100, hidden: true },
                    { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentStatus', index: 'DocumentStatus', width: 100, hidden: true },


                     	],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pagedocsearch'),
        viewrecords: false,
        ondblClickRow: function(rowID, iRow, iCol, e) {
            CreateNewDocument();
            $('#' + id).dialog('close');
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
    SearchDocumentData();

}
// ค้นหาเอกสารการโอนสินค้า
function SearchDocumentData() {
    CheckSessionTimeOut();
    var fromdate = $('#txtTFFromDate').val();
    var todate = $('#txtTFToDate').val();
    var inventoryId = $('#ddlTFInv').val();
    var fromInventoryId = $('#ddlTFFromInv').val();
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=searchTFdoc' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ fromdate: fromdate, todate: todate, inventoryId: inventoryId, fromInventoryId: fromInventoryId }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jgdocsearch")[0];
            gridDoc.addXmlData(xhr.responseXML);
            $('#btnOkTF').click(function() {
                CreateNewDocument();
                $('#dialogSearchDocumentPO').dialog('close');
            });
        }
    });

}

// ค้นหาเอกสารรับจากการโอน 
function SearchRODocumentData() {
    CheckSessionTimeOut();
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();
    var dStatus = $('#ddlSDStatus').val();
    var dInv = $('#ddlTPInv').val();
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=searchdoc' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ txtFromDate: fromDate, txtToDate: toDate, dStatus: dStatus, dInv: dInv }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jGDocument")[0];
            gridDoc.addXmlData(xhr.responseXML);
            $('#btnSelectDocument').click(function() {
                LoadNewDocumentData();
                CheckDocumentStatus();
                $('#dialogSearchDocument').dialog('close');
            });
        }
    });

}
// ค้นหาเอกสารใบใหม่เพื่อมาทำรายการ
function LoadNewDocumentData() {
    CheckSessionTimeOut();
    var gridRow = $("#jGDocument").getGridParam('selrow');
    var data = $("#jGDocument").getRowData(gridRow);
    var newDocID = data.DocumentID;
    var newShopID = data.DocumentShopID;
    //alert(newDocID);
    //alert(newShopID);
    if (newDocID != '' && newShopID != '' || newDocID != 0 && newShopID != 0) {
        $.ajax({
            url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadNewDocment' + getUrlDocTypID,
            cache: false,
            context: document.body,
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
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else {
                        alert(data.ResultText);
                        CheckDocumentOnLoad();
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
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadNewDocment' + getUrlDocTypID,
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
                    $("#theGrid2").jqGrid().trigger("reloadGrid");

                } else {
                    alert(data.ResultText);
                    CheckDocumentOnLoad();
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
                CheckDocumentOnLoad();
            }
        }
    });
}

// ปิดหน้าต่าง Dialog การค้นหาเอกสารรับจากการโอน
function closeDialogSearchDocument(id) {
    $('#' + id).dialog('close');
}


//======================================================== ส่วนของการจัดการเอกสาร เพิ่ม ลบ สินค้า ============================================//
var selectedRowID = 0;      //selected rowid for edit

function addEditMaterialJqGrid() {

    jQuery("#theGrid").jqGrid({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadDocDetail' + getUrlDocTypID,
        datatype: 'xml',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวนขอ', 'จำนวนโอน', 'จำนวนรับ', 'หน่วย', 'materialid'],
        colModel: [
   		{ name: 'id', index: 'id', width: 20, editable: false, hidden: false, align: 'center' },
        { name: 'mcode', index: 'mcode', width: 60, align: 'left' },
        { name: 'mname', index: 'mname', width: 150, align: 'left' },
        { name: 'mrequest', index: 'mrequest', width: 50, align: 'right' },
   		{ name: 'mamount', index: 'mamount', width: 50, align: 'right' },
   		{ name: 'mreceive', index: 'mreceive', width: 50, align: 'right' },
   		{ name: 'munit', index: 'munit', width: 30, editable: true, align: 'left' },
        { name: 'mid', index: 'mid', width: 10, hidden: true }


   	],
        pager: '#pager',
        autowidth: true,
        height: 200,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        viewrecords: true,
        caption: 'รายการสินค้า'
    });

    jQuery("#theGrid2").jqGrid({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=loadDocDetailSurplus' + getUrlDocTypID,
        datatype: 'xml',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวน', 'หน่วย', 'materialid'],
        colModel: [
   		{ name: 'id', index: 'id', width: 20, editable: false, hidden: false, align: 'center' },
        { name: 'mcode', index: 'mcode', width: 60, align: 'left' },
        { name: 'mname', index: 'mname', width: 250, align: 'left' },
   		{ name: 'mamount', index: 'mamount', width: 50, align: 'right' },
   		{ name: 'munit', index: 'munit', width: 30, editable: true, align: 'left' },
        { name: 'mid', index: 'mid', width: 10, hidden: true },

   	],
        pager: '#pager',
        autowidth: true,
        height: 100,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        viewrecords: true,
        caption: 'รายการสินค้าเกินจำนวน'
    });



}

function SettingPageGridView(action) {
    if (action == true) {
        //-- จัดการ page
        $("#theGrid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false }).navButtonAdd('#pager', {
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
                    deleteMaterial('ลบข้อมูล', 'ต้องการลบข้อมูล ใช่หรือไม่', 'ตกลง', 'ยกเลิก', 'DataXML/ReceiptCompareFormTransferXML.aspx?action=delMaterialInDocDetial&docdetailid=' + delParam + getUrlDocTypID);
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

//-- search material dialog
function searchMaterial() {
    var materialData = null;       //data from search material
    var materialCode = "";
    $("#boxSearchProduct").dialog({
        resizable: false,
        height: 550,
        width: 550,
        title: 'ค้นหาวัตถุดิบ',
        modal: true
    });

    $("#btnSMCancel").click(function() {
        $("#boxSearchProduct").dialog('close');
    });

    $("#txtMaterialCode").keyup(function(e) {
        var searchAction;
        var materialCode = $("#txtMaterialCode").val();
        if ($('#rdoSmatByCode').is(':checked')) {
            searchAction = 1;
        } else if ($('#rdoSmatByName').is(':checked')) {
            searchAction = 2;
        }
        //alert(materialCode);
        //alert(searchAction);
        $.ajax({
            url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=searchMatByCodeAndName' + getUrlDocTypID,
            cache: false,
            type: 'POST',
            datatype: 'xml',
            data: ({ searchCode: materialCode, searchBy: searchAction }),
            complete: function(xhr, status) {
                // alert(xhr.responseText);
                var mgrid = jQuery("#msearch")[0];
                mgrid.addXmlData(xhr.responseXML);

            },
            error: function(xhr, ajaxOptions, thrownError) {
                MessageError(xhr.responseText);
            }
        });
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
        $.post('DataXML/ReceiptCompareFormTransferXML.aspx?action=addrow' + getUrlDocTypID,
             { custom_row: $("#txtAddRow").val() },
             function(data, textStatus, XMLHttpRequest) {
                 //alert(textStatus);
                 $("#theGrid").jqGrid().trigger("reloadGrid");
             });
        $("#boxAddRow").dialog('close');
    });
}
function DelMaterial() {
    $("#BoxDelMaterial").dialog({
        resizable: false,
        height: 60,
        width: 300,
        title: 'ลบรายการสินค้า',
        modal: false
    });
    $("#txtDelMCode").select();

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
            AddMaterialInTexbox(materialData);
            $("#boxSearchProduct").dialog('close');
        },
        onSelectRow: function(rowidx) {
            materialData = $(this).jqGrid('getRowData', rowidx);
            $("#btnSMOk").click(function() {
                AddMaterialInTexbox(materialData);
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
    $.getJSON('DataXML/ReceiptCompareFormTransferXML.aspx?action=getPricePerUnit' + getUrlDocTypID, { editdocdetailid: docDetailID, materialId: materialId, unitId: unitId, materialAmount: amount, materailDiscount: mdiscount, materialVat: vat, isDicount: msldiscount, mPricePerUnit: mpriceper, actionby: actionby }, function(data, status) {
        //alert(data.mTotalPrice);
        //{"priceperunit":"100"}
        if (data != null) {
            //-- update ราคา
            $("#" + selectedRowID + "_mpriceperunit").val(data.priceperunit);
            $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mTotalPrice });

        }
    });
}

//-- จากการ search แบบ dialog
function setDataToTheGrid(materialData) {
    $.getJSON('DataXML/ReceiptCompareFormTransferXML.aspx?action=getMaterialDataJSON' + getUrlDocTypID, { editDetailId: -1, materialId: materialData.mid, materialCode: materialData.mcode, materialName: materialData.mname, materialAmount: 0, Price: 0, selectUnit: -1, Discouent: 0, IsDiscount: 0, materialVatType: materialData.vattype, actionby: 1 }, function(data, status) {
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

        }
    });
}

//-- จากการ search แบบ enter
function setDataWhenEnterSearchJSON(materialCode) {
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=getMaterialDataJSONByCode' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ materialCode: materialCode, editDocDetailId: -1 }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                if (xhr.responseText != '') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);

                    $("#txtMCode").val(data.mcode);
                    $("#lbMName").html(data.mname);
                    if (data.mamount == 0) {
                        $("#txtMAmount").val(1);
                        mAmount = 1
                    } else {
                        $("#txtMAmount").val(data.mamount);
                        mAmount = data.mamount
                    }
                    $("#lbMUnit").html('--');
                    if (CanEditMaterialAmount == 0) {
                        CompareMaterial(data.mid, mAmount, data.unitid);
                    } else {
                        cmMaterialId = data.mid;
                        cmMaterialUnitId = data.unitid;
                        $("#txtMAmount").focus();
                        $("#txtMAmount").select();
                    }
                } else {
                    alert('ไม่พบรหัสสินค้าในระบบ');
                }
            } else {
                $("#txtMCode").val('');
                $("#lbMName").html('');
                $("#txtMAmount").val('');
                $("#txtMCode").focus();
                $("#lbMUnit").html('');
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }
    });
}
function setDataWhenEnterSearchJSONForDelete(materialCode) {
    if (materialCode != '') {
        $.ajax({
            url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=getMaterialDataJSONByCode' + getUrlDocTypID,
            cache: false,
            datatype: 'json',
            type: 'GET',
            data: ({ materialCode: materialCode, editDocDetailId: -1 }),
            complete: function(xhr, status) {
                //alert(xhr.responseText);
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);
                    CompareMaterial(data.mid, -1, data.unitid);
                    $("#txtDelMCode").val('');
                    $("#txtDelMCode").select();

                } else {
                    $("#txtDelMCode").val('');
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                }
            }
        });
    } else {
        alert('กรุณาระบุรหัสสินค้า !')

    }
}
function CompareMaterial(mId, mAmount, mUnit) {
    alert(mId + ':' + mAmount + ':' + mUnit);
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=CompareMaterials' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ mId: mId, mAmount: mAmount, mUnitId: mUnit }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                if (data.status == 1) {
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    setRowColor(data.indexInCompareList, '#FF6666')
                    $("#txtMCode").val('');
                    $("#txtMAmount").val('');
                } else {
                    alert(data.strResultText);
                    $("#txtMCode").val('');
                    $("#txtMAmount").val('');
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
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
        $.getJSON('DataXML/ReceiptCompareFormTransferXML.aspx?action=getMaterialDataJSON' + getUrlDocTypID, { editDetailId: materialData.editdocdetailid, materialId: materialData.mid, materialCode: mCode, materialName: materialData.mname, materialAmount: mAmount, Price: mPricePerUnit, selectUnit: materialData.unitid, IsDiscount: slIsDiscount, materialVatType: materialData.materialvattype, mDiscountAmount: materialData.discountamount, mDiscountPercent: materialData.discountpercent, actionby: 2 }, function(data, status) {

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
                $("#" + selectedRowID + "_mdiscount_sl").val(data.isdiscount);
                $("#" + selectedRowID + "_mvat").val(data.mvat);
                $("#theGrid").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
                $("#" + selectedRowID + "_unitid").val(data.unitid);

            }
        });
    }
}

// ค้นหาข้อมูลสินค้าแล้วในเข้าไปใน TexBox
function AddMaterialInTexbox(materialCode) {
    //alert(materialCode.mcode);
    $.ajax({
        url: 'DataXML/ReceiptCompareFormTransferXML.aspx?action=getMaterialDataJSONByCode' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ materialCode: materialCode.mcode, editDocDetailId: -1 }),
        complete: function(xhr, status) {
            alert(xhr.responseText);
            alert(CanEditMaterialAmount);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                $("#lbMUnit").html('--');
                if (CanEditMaterialAmount == 0) {
                    if (data.mamount == 0 || data.mamount == '' || data.mamount == null) {
                        $("#txtMAmount").val(1);
                        cmAmount = 1
                    } else {
                        $("#txtMAmount").val(data.mamount);
                        cmAmount = data.mamount
                    }
                    CompareMaterial(data.mid, cmAmount, data.unitid);
                    $("#txtMCode").focus();
                    $("#txtMCode").select();
                } else {
                    cmMaterialId = data.mid;
                    cmMaterialUnitId = data.unitid;
                    $("#txtMCode").val(data.mcode);
                    $("#lbMName").html(data.mname);
                    if (data.mamount == 0) {
                        $("#txtMAmount").val(1);
                        cmAmount = 1
                    } else {
                        $("#txtMAmount").val(data.mamount);
                        cmAmount = data.mamount

                    }
                    $("#txtMAmount").focus();
                    $("#txtMAmount").select();

                }


            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }
    });
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

function setRowColor(rowIndex, color) {
    //alert(selRow);
    //alert(color);
    $("#theGrid").ajaxStop(function() {
        var colModel = $("#theGrid").jqGrid('getGridParam', 'colModel');
        for (var i = 0; i <= colModel.length - 1; i++) {
            // $("#theGrid").setCell(rowIndex, i, '', { 'background': color });
        }
    });
}
          
