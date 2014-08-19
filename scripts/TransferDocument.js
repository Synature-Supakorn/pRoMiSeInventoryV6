var documentData;
var hdfSDDocumentID;
var hdfSDShopID;
var rowState = null;
var docTransferTypeId;
var docRequestTypeId;
var getUrlDocTypID;
var postUrlDocTypeID;
// Already
$(function() {

    var sltNameInv = "ddlTFInv";
    var sltNameInvSearch = "ddlSDFromInv";
    var sltNamePT1Inv = "ddlTP1Inv";

    // check esc key
    $("html body").keyup(function(e) {
        if (e.keyCode == 27) {
            //alert(selectedRowID);
            $("#theGrid").restoreRow(selectedRowID);
            if (rowState == 'editing')
                rowState = null;
        }
    });

    //กำหนด DocumentType ให้กับเอกสาร
    docTransferTypeId = $.getUrlVar('DocTrnasferTypeID');
    //docRequestTypeId = $.getUrlVar('DocRequestTypeID');

    getUrlDocTypID = "&docTransferTypeId=" + docTransferTypeId;
    postUrlDocTypeID = "docTransferTypeId:" + docTransferTypeId;

    //alert(getUrlDocTypID);

    LoadInventory(sltNameInv);
    LoadInventory(sltNameInvSearch);
    LoadInventory(sltNamePT1Inv);

    jqGridMeterial();
    jqGridMeterialInStock();
    LoadRQStatus();
    addEditMaterialJqGrid();


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
            //alert(newDocumentID);
            //alert(newShopID);
            LoadNewDocumentDataFormDocumentBox(newDocumentID, newShopID);
        } else if ($.getUrlVar('lnd') == 2) {
            //alert(newStatus);
            //alert(newOtherInvID);
            CreateNewDocumentformDocumentBox(newDocumentID, newShopID, newStatus, newOtherInvID);
        }
    } else {
        CheckDocumentOnLoad();
        CheckCreateTransferdocument();
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

    $('#txtCTFFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });
    $('#txtCTFToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar.gif',
        buttonImageOnly: true
    });


    $('#btnSearchVendor').button({
        icons: { primary: 'ui-icon-search' }, text: false
    });
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
    $("#btnAddMultiMaterials").button({
        icons: { primary: 'ui-icon-search' }, text: true
    });
    $("#btnCloseAndRefreshDocument").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnPreviosSelectMaterial").button({
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
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });

    $("#accordion").accordion({
        collapsible: true,
        autoHeight: false,
        navigation: true,
        icons: { 'header': 'ui-icon-circle-arrow-s', 'headerSelected': 'ui-icon-circle-arrow-n' }
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
        url: 'DataXML/TransferDocumentXML.aspx?action=CheckSession',
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

//======================================================== สถานะเอกสารการขอสินค้า ============================================//

function LoadRQStatus() {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=loadRQStatus' + getUrlDocTypID,
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
        url: 'DataXML/TransferDocumentXML.aspx?action=chekDoc' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                $('#hdfDocumentRefID').val(data.hdfDocumentRefID);
                SetStatusButton(data.hdfStatus, data.hdfDocumentRefID, data.StaffCanTF, data.StaffCanAprove, data.StaffCanCancel);
            } else {
                location.href = "../logout.aspx"
            }
        }
    });
}

//======================================================== ส่วนแสดงหัวเอกสาร ========================================//

function DocmentHeader() {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=loadDocHeader' + getUrlDocTypID,
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
                    } else if (ary_data2[0] == 'ddlTP1Inv') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'ddlTP1FromInv') {
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
        url: 'DataXML/TransferDocumentXML.aspx?action=chekDocStatus' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                $('#hdfDocumentRefID').val(data.hdfDocumentRefID);
                SetStatusButton(data.hdfStatus, data.hdfDocumentRefID, data.StaffCanTF, data.StaffCanAprove, data.StaffCanCancel);
            } else {
                location.href = "../logout.aspx"
            }
        }
    });

}

function SetStatusButton(statusDoc, documentRefId, staffCreate, staffApprove, staffCancel) {
    //alert(documentRefId);
    //alert(statusDoc);
    if (statusDoc == 0) {

        $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", true).addClass("ui-state-disabled");
        if (staffCreate == 1) {
            $('#btnSave').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrintTransfer').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('enable');
        $('#txtReferenceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTP1Inv').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTP1FromInv').attr("disabled", false).removeClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");
    } else if (statusDoc == 1) {

        if (staffCreate == 1) {
            $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        if (staffApprove == 1) {
            $('#btnAppove').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        }
        if (staffCancel == 1) {
            $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnPrintTransfer').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtReferenceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#ddlTP1Inv').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1FromInv').attr("disabled", true).addClass("ui-state-disabled");

        rowState = null;
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");


    } else if (statusDoc == 2) {

        if (staffCreate == 1) {
            $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        if (staffCancel == 1) {
            $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnPrintTransfer').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtReferenceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1Inv').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1FromInv').attr("disabled", true).addClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
    } else if (statusDoc == 99 || statusDoc == 3 || statusDoc == 4) {
        if (staffCreate == 1) {
            $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrintTransfer').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtReferenceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1Inv').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1FromInv').attr("disabled", true).addClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
    } else {

        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        if (staffCreate == 1) {
            $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        } else {
            $('#btnCreateDocument').attr("disabled", true).addClass("ui-state-disabled");
        }
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrintTransfer').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        $('#txtReferenceNo').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1Inv').attr("disabled", true).addClass("ui-state-disabled");
        $('#ddlTP1FromInv').attr("disabled", true).addClass("ui-state-disabled");
        rowState = 'editing';
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        openDialogSearchDocumentTransfer('dialogSearchTransferDocument');

    }
}

//======================================================== ค้นหาคลังสินค้า ============================================//

// คลังสินค้า
function LoadInventory(selectorName) {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=loadInv' + getUrlDocTypID,
        cache: false,
        context: document.body,
        data: ({ selectorName: selectorName }),
        success: function(data) {
            // alert(data);
            ary_data = data.split(";");
            $("#" + ary_data[0]).html(ary_data[1]);
            if (selectorName == 'ddlTFInv') {
                LoadInventoryViewForSelect('ddlTFFromInv', $('#ddlTFInv').val());
            } else if (selectorName == 'ddlTP1Inv') {
                LoadInventoryViewForSelect('ddlTP1FromInv', $('#ddlTP1Inv').val());
            } else if (selectorName == 'ddlSDFromInv') {
                LoadInventoryViewForSelect('ddlSDToInv', $('#ddlSDFromInv').val());
            }
        }
    });
}
function LoadInventoryViewForSelect(selectorName, selInvId) {
    ///alert(selInvId);
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=loadInvView' + getUrlDocTypID,
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
//======================================================== กลุ่มสินค้า หมวดสินค้า ============================================//

function LoadMaterialGroup() {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=loadMatGroup' + getUrlDocTypID,
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
        url: 'DataXML/TransferDocumentXML.aspx?action=loadMatDept' + getUrlDocTypID,
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
        url: 'DataXML/TransferDocumentXML.aspx?action=searchMatByGroupAndCode' + getUrlDocTypID,
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

//======================================================== สร้างเอกสารการโอน ============================================//

// สร้างเอกสารการโอนจากการขอสินค้า
function CreateNewDocument() {
    CheckSessionTimeOut();
    var gridRow = $("#jgdocsearch").getGridParam('selrow');
    var data = $("#jgdocsearch").getRowData(gridRow);
    var documentid = data.DocumentID;
    var documentshopid = data.DocumentShopID;
    var documentstatus = data.DocumentStatus;
    var documentinventoryid = data.DocumentInventoryID;
    var documentstatus = data.DocumentStatus;
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=newDoc' + getUrlDocTypID,
        cache: false,
        data: ({ documentid: documentid, documentshopid: documentshopid, documentstatus: documentstatus, documentinventoryid: documentinventoryid, documentstatus: documentstatus }),
        success: function(data) {
            CheckDocumentStatus();
            DocmentHeader();
            $("#theGrid").jqGrid().trigger("reloadGrid");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
function CreateNewDocumentformDocumentBox(DocumentID, DocumentShopID, DocumentStatus, DocumentInventoryID) {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=newDoc' + getUrlDocTypID,
        cache: false,
        data: ({ documentid: DocumentID, documentshopid: DocumentShopID, documentinventoryid: DocumentInventoryID, documentstatus: DocumentStatus }),
        success: function(data) {
            CheckDocumentStatus();
            DocmentHeader();
            $("#theGrid").jqGrid().trigger("reloadGrid");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
//สร้างเอกสารโดยที่ไม่มีการร้องขอมาจากสาขา
function CreateNewTransferDocument() {
    CheckSessionTimeOut();
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=newTransferDoc' + getUrlDocTypID,
        cache: false,
        success: function(data) {
            $("#dialogSearchTransferDocument").dialog('close');
            CheckDocumentStatus();
            DocmentHeader();
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
    var docDate = $('#txtDocumentDate').val();
    var note = $('#txtNote').val();
    //var invoiceNo = $('#txtReferenceNo').val();
    var fromInventoryId = $('#ddlTP1Inv').val();
    var toInventoryID = $('#ddlTP1FromInv').val();
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=saveDoc' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ docDate: docDate, note: note, fromInventoryId: fromInventoryId, toInventoryId: toInventoryID }),
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
                    LoadMaterialGroup();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmSaveDoc').dialog('close');
                    alert(data.strResultText);
                    DocmentHeader();
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
//======================================================== ยกเลิกเอกสารการโอน ============================================//

function CancelDocument() {
    CheckSessionTimeOut();
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=cancelDoc' + getUrlDocTypID,
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
//======================================================== อนุมัติเอกสารการโอน ============================================//
function CheckStockForTransferDocument() {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=CheckStock' + getUrlDocTypID,
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
                    CheckApproveDocument()
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
        url: 'DataXML/TransferDocumentXML.aspx?action=LoadStockEnoughForTransfer' + getUrlDocTypID,
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
function CheckApproveDocument() {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=CheckApprove' + getUrlDocTypID,
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
        url: 'DataXML/TransferDocumentXML.aspx?action=ApproveDoc' + getUrlDocTypID,
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

//======================================================== ค้นหาเอกสารการโอน ============================================//
// เปิด Dialoa ค้นหาเอกสาร เพื่อให้เลือกเงื่อนไขในการค้นหาได้
function openDialogSearchDocument(id) {
    $('#' + id).dialog({ width: 800, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));

    // GridView แสดงข้อมูลเอสารตามที่ค้นหา
    $("#jGDocument").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร', 'สถานะ', 'คลัง', 'ไปที่คลัง', 'DocumentInventoryID', 'DocumentToInventoryID', 'DocumentShopID', 'DocumentID'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
                    { name: 'DocumentDate', index: 'DocumentDate', width: 150 },
   		            { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100 },
                    { name: 'DocumentToInventoryName', index: 'DocumentToInventoryName', width: 100 },
                    { name: 'DocumentInventoryID', index: 'DocumentInventoryID', width: 100, hidden: true },
                    { name: 'DocumentToInventoryID', index: 'DocumentToInventoryID', width: 100, hidden: true },
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
    SearchDocumentData();


}
//======================================================== ค้นหาเอกสารการโอนสินค้า ============================================//
// เปิด Dialoa ค้นหาเอกสาร เพื่อให้เลือกเงื่อนไขในการค้นหาได้
function openDialogSearchDocumentTransfer(id) {
    $('#' + id).dialog({ width: 800, height: 600, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));

    // GridView แสดงข้อมูลเอสารตามที่ค้นหา
    $("#jgdocsearch").jqGrid({
        //url: 'No',
        colNames: ['เลขที่เอกสาร', 'วันที่เอกสาร', 'สถานะ', 'คลัง', 'ไปที่คลัง', 'DocumentInventoryID', 'DocumentToInventoryID', 'DocumentShopID', 'DocumentID'],
        colModel: [
   		            { name: 'DocumentNumber', index: 'DocumentNumber', width: 150 },
                    { name: 'DocumentDate', index: 'DocumentDate', width: 150 },
   		            { name: 'DocumentStatus', index: 'DocumentStatus', width: 100, hidden: true },
                    { name: 'DocumentInvetoryName', index: 'DocumentInvetoryName', width: 100 },
                    { name: 'DocumentToInventoryName', index: 'DocumentToInventoryName', width: 100 },
                    { name: 'DocumentInventoryID', index: 'DocumentInventoryID', width: 100, hidden: true },
                    { name: 'DocumentToInventoryID', index: 'DocumentToInventoryID', width: 100, hidden: true },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true },
                    { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
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


}
// ค้นหาเอกสารการโอนสินค้า
function SearchDocumentData() {
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();
    var dStatus = $('#ddlSDStatus').val();
    var fromInvId = $('#ddlSDFromInv').val();
    var toInvId = $('#ddlSDToInv').val();
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=searchdoc' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ txtFromDate: fromDate, txtToDate: toDate, dStatus: dStatus, dInv: fromInvId, dToInv: toInvId }),
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

// ค้นหาเอกสารการข้อสินค้าเพื่อนำไปสร้างเป็นเอกสารการโอน 
function SearchRQDocumentData() {
    var fromDate = $('#txtCTFFromDate').val();
    var toDate = $('#txtCTFToDate').val();
    var dStatus = $('#ddlRQStatus').val();
    var dInv = $('#ddlTFInv').val();
    var dFromInv = $('#ddlTFFromInv').val();

    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=searchForCreatedoc' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ fromDate: fromDate, toDate: toDate, dStatus: dStatus, dInv: dInv, dFromInv: dFromInv }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#jgdocsearch")[0];
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
    var gridRow = $("#jGDocument").getGridParam('selrow');
    var data = $("#jGDocument").getRowData(gridRow);
    var newDocID = data.DocumentID;
    var newShopID = data.DocumentShopID;
    //alert(newDocID);
    //alert(newShopID);
    if (newDocID != '' && newShopID != '' || newDocID != 0 && newShopID != 0) {
        $.ajax({
            url: 'DataXML/TransferDocumentXML.aspx?action=loadNewDocment' + getUrlDocTypID,
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
                        LoadMaterialGroup();
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else {
                        alert(data.ResultText);
                        CheckDocumentOnLoad();
                        CheckCreateTransferdocument();
                        LoadMaterialGroup();
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
        url: 'DataXML/TransferDocumentXML.aspx?action=loadNewDocment' + getUrlDocTypID,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ newDocID: newDocID, newShopID: newShopID }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    DocmentHeader();
                    CheckDocumentStatus();
                    LoadMaterialGroup();
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

    jQuery("#theGrid").jqGrid({
        url: 'DataXML/TransferDocumentXML.aspx?action=loadDocDetail' + getUrlDocTypID,
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
   		        if (value <= 0 || value == '')
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
   		{ name: 'mpriceperunit', index: 'mpriceperunit', width: 40, align: 'right', editable: true, hidden: true, edittype: 'custom',
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
   		            var elemStr = '<select id="' + options.id + '" style="width:100px; padding:1px 0;" >';
   		            elemStr += '</select>';

   		            //alert(options.id);
   		            return elemStr;
   		        },
   		        custom_value: function(elem) {
   		            return elem.val();
   		        }
   		    }
   		},
   		{ name: 'mdiscount', index: 'mdiscount', width: 40, align: 'right', hidden: true, editable: true, edittype: 'custom',
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
   		{ name: 'mvat', index: 'mvat', width: 40, editable: false, hidden: true, align: 'right', edittype: 'select', editoptions: { value: "1:Exclude;2:Include;0:No VAT", hidden: true }
   		},
   		{ name: 'mtotalprice', index: 'totalprice', width: 40, editable: false, align: 'right', hidden: true },
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
            /*if (rowid != selectedRowID) {
            var materialData = $(this).jqGrid('getRowData', selectedRowID);
            var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
            jQuery("#theGrid").saveRow(selectedRowID, succesfunc, 'DataXML/TransferDocumentXML.aspx?action=addMaterialInDocDetial' + getUrlDocTypID, { mid: materialData.mid, indexlist: selectedRowID, editdocdetailid: materialData.editdocdetailid, IsDiscount: mslDiscount }, aftersavefunc, errorfunc, afterrestorefunc);

            }*/
            if (rowState != 'editing') {
                selectedRowID = rowid;
                $(this).editRow(rowid, false, oneditfunc);
                rowState = 'editing';

            }
        },

        viewrecords: true,
        caption: 'รายการสินค้า'
    });
    SettingPageGridView(true);

}

function SettingPageGridView(action) {
    if (action == true) {
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
                    deleteMaterial('ลบข้อมูล', 'ต้องการลบข้อมูล ใช่หรือไม่', 'ตกลง', 'ยกเลิก', 'DataXML/TransferDocumentXML.aspx?action=delMaterialInDocDetial&docdetailid=' + delParam + getUrlDocTypID);
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
        url: 'DataXML/TransferDocumentXML.aspx?action=searchMatByCodeAndName' + getUrlDocTypID,
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
        $.post('DataXML/TransferDocumentXML.aspx?action=addrow' + getUrlDocTypID,
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
    $.getJSON('DataXML/TransferDocumentXML.aspx?action=getPricePerUnit' + getUrlDocTypID, { editdocdetailid: docDetailID, materialId: materialId, unitId: unitId, materialAmount: amount, materailDiscount: mdiscount, materialVat: vat, isDicount: msldiscount, mPricePerUnit: mpriceper, actionby: actionby }, function(data, status) {
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
    $.getJSON('DataXML/TransferDocumentXML.aspx?action=getMaterialDataJSON' + getUrlDocTypID, { editDetailId: -1, materialId: materialData.mid, materialCode: materialData.mcode, materialName: materialData.mname, materialAmount: 0, Price: 0, selectUnit: -1, Discouent: 0, IsDiscount: 0, materialVatType: materialData.vattype, actionby: 1 }, function(data, status) {
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
            if (data.unitid > 0) {
                $("#" + selectedRowID + "_mamount").select();
            } else {
                alert('!ไม่อนุญาติให้บันทึกสินค้าที่ไม่มีหน่วยนับให้เลือก');
                rowState = null;
                $("#theGrid").jqGrid().trigger("reloadGrid");
            }

        }
    });
}

//-- จากการ search แบบ enter
function setDataWhenEnterSearchJSON(materialCode) {
    //alert(materialCode);
    //alert(selectedRowID);
    var theGridData = $("#theGrid").jqGrid('getRowData', 'selrow');
    var editDocDetailId = theGridData.editdocdetailid;
    $.getJSON('DataXML/TransferDocumentXML.aspx?action=getMaterialDataJSONByCode' + getUrlDocTypID, { materialCode: materialCode, editDocDetailId: editDocDetailId }, function(data, status) {
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
        $.getJSON('DataXML/TransferDocumentXML.aspx?action=getMaterialDataJSON' + getUrlDocTypID, { editDetailId: materialData.editdocdetailid, materialId: materialData.mid, materialCode: mCode, materialName: materialData.mname, materialAmount: mAmount, Price: mPricePerUnit, selectUnit: materialData.unitid, IsDiscount: slIsDiscount, materialVatType: materialData.materialvattype, mDiscountAmount: materialData.discountamount, mDiscountPercent: materialData.discountpercent, actionby: 2 }, function(data, status) {

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

// เปิด Row เพื่อแก้ไขข้อมูลสินค้า
function oneditfunc() {
    CheckOneditRow()
    $("#" + selectedRowID + "_code_bs").button({
        icons: {
            primary: ' ui-icon-search',
            text: false
        }
    });

    $("#" + selectedRowID + "_mcode").focus();

    //check enter
    $("#" + selectedRowID + "_mcode").keyup(function(e) {

        if (e.keyCode == 27) {
            rowState = null;
            $("#theGrid").jqGrid().trigger("reloadGrid");
        } else {
            if (e.keyCode == 13) {
                setDataWhenEnterSearchJSON($("#" + selectedRowID + "_mcode").val());
            }
        }
    });

    $("#" + selectedRowID + "_mamount").keyup(function(e) {
        if (e.keyCode == 13) {
            if ($(this).val() != "" && parseFloat($(this).val()) > 0) {
                $("#" + selectedRowID + "_munit").focus();
            }
            else {
                alert('จำนวนสินค้าต้องมากกว่า 0 ');
            }
        }
    });
    $("#" + selectedRowID + "_munit").keyup(function(e) {
        if (e.keyCode == 13) {
            var materialData = $("#theGrid").jqGrid('getRowData', selectedRowID);
            var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();

            jQuery("#theGrid").saveRow(selectedRowID, succesfunc, 'DataXML/TransferDocumentXML.aspx?action=addMaterialInDocDetial' + getUrlDocTypID, { mid: materialData.mid, indexlist: selectedRowID, editdocdetailid: materialData.editdocdetailid, IsDiscount: mslDiscount }, aftersavefunc, errorfunc, afterrestorefunc);

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
function closedialog(id) {
    $('#' + id).dialog('close');
}
function OpenDialog(id) {
    $('#' + id).dialog({ width: 600, autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));
}

//========================================== สำหรับเพิ่มสินค้าแบบที่หละหลายๆ ตัว ========================================
function jqGridMeterialWithDocDetail() {
    $("#jqGridAddMultiMeterial").jqGrid({
        colNames: ['MaterialID', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวน', 'หน่วยนับ'],
        colModel: [
        { name: 'mid', index: 'mid', width: 40, hidden: true },
   		{ name: 'mcode', index: 'mcode', width: 100 },
   		{ name: 'mname', index: 'mname', width: 400 },
   		{ name: 'mamount', index: 'mamount', width: 100, editable: true, align: 'right' },
   		{ name: 'munit', index: 'munit', width: 100 }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 350,
        rowNum: -1,
        autowidth: true,
        pager: $('#mpagerselectmaterial'),
        viewrecords: false,
        cellEdit: true,
        caption: "รายการสินค้า",
        cellsubmit: 'clientArray',
        afterSaveCell: function(rowid, cellname, value, iRow, iCol) {
            SaveMaterialAmount(rowid, cellname, value, iRow, iCol);
        }
    });
}
function ListViewSelectMaterial(materialDept) {
    $.ajax({
        url: 'DataXML/TransferDocumentXML.aspx?action=ListSelectMaterials' + getUrlDocTypID,
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ materialDept: materialDept }),
        complete: function(xhr, status) {
            var gridDoc = $("#jqGridAddMultiMeterial")[0];
            gridDoc.addXmlData(xhr.responseXML);
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
function SaveMaterialAmount(rowid, cellname, value, iRow, iCol) {
    if (parseFloat(value) > 0) {
        $.ajax({
            url: 'DataXML/TransferDocumentXML.aspx?action=UpdateListMaterials' + getUrlDocTypID,
            cache: false,
            datatype: 'json',
            type: 'POST',
            data: ({ materialDept: materialDeptForAddList, updateIndex: iRow, materialAmount: value }),
            complete: function(xhr, status) {
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    if (data.status == 1) {
                        //ListViewSelectMaterial(materialDeptForAddList);
                    } else {
                        alert(data.strResultText);
                    }
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                MessageError(xhr.responseText);
            }
        });
    }
}
function openDialogAddMultiMaterial() {
    $('#dialogAddMultiMaterials').dialog({ width: 900, height: 500, modal: true, resiable: false });
    jqGridMeterialWithDocDetail();
    materialDeptForAddList = $('#ddlMatByDept').val();
    var additionalURL;
    additionalURL = "&materialDept=" + materialDeptForAddList
    ListViewSelectMaterial(materialDeptForAddList);

}
function CloseDialogAddMultiMaterial() {
    $("#boxSearchProduct").dialog('close');
    $('#dialogAddMultiMaterials').dialog('close');
    $("#theGrid").jqGrid().trigger("reloadGrid");
    rowState = null;
}
function CloseDialogAddMultiMaterialForNewSelect() {
    $("#dialogAddMultiMaterials").dialog('close');
    rowState = null;
}
function PrintDocument() {
    newWindow = window.open('../Inventory/Report/CrDocRequestAndTransfer.aspx?docID=' + $('#hdfDocId').val() + '&docShopID=' + $('#hdfDocShopId').val() + '&docTypeID=' + docTransferTypeId, '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    newWindow.focus();
}
