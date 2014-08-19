
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
var hdfARStatus;
var hdfARStatusDocument;
var cmMaterialId;
var actionAdd;
var CanEditMaterialAmount = 0;
$(function() {

    //กำหนด DocumentType ให้กับเอกสาร
    docTransferTypeId = $.getUrlVar('DocTrnasferTypeID');
    docRequestTypeId = $.getUrlVar('DocRequestTypeID');
    docReceiveTransfer = $.getUrlVar('DocReceiveTypeId');

    getUrlDocTypID = "&docTransferTypeId=" + docTransferTypeId + "&docRequestTypeId=" + docRequestTypeId + "&docReceiveTransfer=" + docReceiveTransfer;
    postUrlDocTypeID = "docTransferTypeId:" + docTransferTypeId + "docRequestTypeId:" + docRequestTypeId + "docReceiveTransfer:" + docReceiveTransfer;

    //alert(getUrlDocTypID);
    var sltNameInv = "ddlSDFromInv";
    var sltNameInv2 = "ddlTFInv";
    LoadInventory(sltNameInv);
    //LoadInventory(sltNameInv2);

    //LoadRQStatus();

    CheckDocumentOnLoad();
    AddEditMaterialJqGrid();
    ReduceMaterialJqGrid();
    PrefinishMaterialJqGrid();
    GridViewAddReduceDocument();
    jqGridMeterial();
    GridViewSummary();
    jqGridMeterialInStock();
    GridViewSummaryBatch();
    GridViewSummaryBatchCompareStandard();
    langID = $.getUrlVar('LangID');
    CheckCanEditMaterialAmount();
    // ปุ่มเพิ่มเอกสารการขอ
    $('#btnOkTFR').click(function() {
        AddDocumentToBatch();
    }).attr('disabled', true).addClass('ui-state-disabled');

    $('#btnSelectDocument').click(function() {
        LoadNewDocumentData();
        CheckDocumentStatus();
        $('#dialogSearchDocument').dialog('close');
    }).attr('disabled', true).addClass('ui-state-disabled');

    $('#txtDocumentDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar_blue.png',
        buttonImageOnly: true

    });
    $('#txtARDocumentDate').datepicker({
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
    $("#btnSOkAppDoc").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnSCAppDoc").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkAppDoc2").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCAppDoc2").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnOkAppDocBatch2").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCAppDocBatch2").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });

    $("#btnOkCancelDoc").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnCCancelDoc").button({
        icons: { primary: 'ui-icon-cancel' }, text: true
    });
    $("#btnSOkCancelDoc").button({
        icons: { primary: 'ui-icon-check' }, text: true
    });
    $("#btnSCCancelDoc").button({
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
    $("#SearchMaterial").button({
        icons: { primary: 'ui-icon-search' }, text: true
    });

    $("button, input:submit, a", "#btnHeader").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-new'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print-preview'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });
    $("button, input:submit, a", "#btnHeader2").button({ icons: { primary: 'icon-action-new' }, text: true })
        .next().button({ icons: { primary: 'icon-action-copy'} });
    $("button, input:submit, a", "#btnHeader3").button({ icons: { primary: 'icon-action-new' }, text: true })
        .next().button({ icons: { primary: 'icon-action-copy'} });
    $("button, input:submit, a", "#btnHeader4").button({ icons: { primary: 'icon-action-new' }, text: true })
        .next().button({ icons: { primary: 'icon-action-copy'} });

    $("button, input:submit, a", "#btnHeader5").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} });

    $("#accordion").accordion({
        collapsible: true,
        autoHeight: false,
        navigation: true,
        icons: { 'header': 'ui-icon-circle-arrow-s', 'headerSelected': 'ui-icon-circle-arrow-n' }
    });
    $("#accordion2").accordion({
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
    $("#txtMCode").keyup(function(e) {
        if (e.keyCode == 13) {
            setDataWhenEnterSearchJSONByTextBox($(this).val());
            $("#txtMCode").focus();
        }

    });
    $("#txtMAmount").keyup(function(e) {
        if (e.keyCode == 13) {
            $("#selUnit").focus();
        }
    });
    $("#selUnit").keyup(function(e) {
        if (e.keyCode == 13) {
            CompareMaterial(cmMaterialId);
            $("#txtMCode").focus();
        }
    });

});
//======================================================== CheckSession  ========================================//
function CheckSessionTimeOut() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckSession',
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            //alert(status);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 0) {
                    parent.location.href = "../logout.aspx"
                }
            } else {
                parent.location.href = "../logout.aspx"
            }
        }
    });

}
//======================================================== Check can edit material amount ========================================//
function CheckCanEditMaterialAmount() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=chekcaneditamount',
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

//======================================================== สถานะเอกสารการ  ============================================//

function LoadRQStatus() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=loadRQStatus',
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
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckDocumentOnLoad',
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
function CheckSubDocumentOnLoad(acLoad) {   
    var statusSubDoc;
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckSubDocumentOnLoad&acLoad=' + acLoad,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                hdfARStatusDocument = data.status;             
                statusSubDoc = data.status
                SetStatusSubButton(statusSubDoc);

            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });

}
//======================================================== กลุ่มสินค้า หมวดสินค้า ============================================//

function LoadMaterialGroup(acLoad) {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=loadMatGroup&acLoad=' + acLoad,
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
        url: 'DataXML/PrefinishDocumentXML.aspx?action=loadMatDept&acLoad=' + hdfARStatus,
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
        url: 'DataXML/PrefinishDocumentXML.aspx?action=searchMatByGroupAndCode&acLoad=' + hdfARStatus,
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


//======================================================== ส่วนแสดงหัวเอกสาร ========================================//

function DocumentHeader() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=DocumentHeaderBatch',
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
//======================================================== ส่วนแสดงหัวเอกสาร เบิก/โอนสินค้า ========================================//

function DocumentHeaderDataForARMaterial(acLoad) {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=DocumentHeaderDataForARMaterial&acLoad=' + acLoad,
        cache: false,
        context: document.body,
        success: function(data) {
            ary_data = data.split(",");
            for (i = 0; i < ary_data.length; i++) {
                if (ary_data[i] != '') {
                    ary_data2 = ary_data[i].split(";");
                    if (ary_data2[0] == 'lbStaffCreatePFNName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbStaffEditPFNName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbStaffApprovePFNName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbStaffCancelPFNName') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbARStatus') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'txtDocumentType') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'lbARDocumentNo') {
                        $("#" + ary_data2[0]).html(ary_data2[1]);
                    } else if (ary_data2[0] == 'hdfARStatusDocument') {
                        hdfARStatusDocument = ary_data2[1]
                    } else {
                        $("#" + ary_data2[0]).val(ary_data2[1]);
                    }
                }
            }

        }
    });
}
//======================================================== ส่วนแสดงสินค้าในเอกสาร เบิก/โอนสินค้า ========================================//
function DocumentDetailForARMaterial(acLoad) {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=DocumentDetailForARMaterial&acLoad=' + acLoad,
        cache: false,
        type: 'GET',
        datatype: 'xml',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#GVAddReduceDoc")[0];
            gridDoc.addXmlData(xhr.responseXML);
        }
    });

}
//======================================================== กำหนดสถานะปุ่มจักการเอกสาร ========================================//
function CheckDocumentStatus() {
    var statusDoc;
    var docRefId;
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckDocumentStatus',
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
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('enable');
        //$('#txtDeliveryDate').datepicker().datepicker('enable');
        $('#txtPackingName').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        DocumentHeader();
        $('#btnAddMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnReduceMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrefinishMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryAddMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryReduceMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryPrefinishMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryPacking').attr("disabled", true).addClass("ui-state-disabled");

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
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        //$('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtNote').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnAddMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnReduceMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrefinishMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryAddMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryReduceMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryPrefinishMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryPacking').attr("disabled", true).addClass("ui-state-disabled");

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
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        //$('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAddMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnReduceMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrefinishMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryAddMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryReduceMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryPrefinishMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryPacking').attr("disabled", false).removeClass("ui-state-disabled");

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
        $('#btnPrint').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        //$('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAddMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnReduceMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrefinishMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryAddMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryReduceMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryPrefinishMaterial').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSummaryPacking').attr("disabled", true).addClass("ui-state-disabled");

    } else {

        //$("#theGrid").attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCreateDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSeachDocument').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSave').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSeachDocumentRequest').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnTemplate').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnAppove').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCancelDocment').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrint').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSearchVendor').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrepareBatch').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtDocumentDate').datepicker().datepicker('disable');
        //$('#txtDeliveryDate').datepicker().datepicker('disable');
        $('#txtPackingName').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtNote').attr("disabled", true).addClass("ui-state-disabled");

        $('#btnAddMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnReduceMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnPrefinishMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryAddMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryReduceMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryPrefinishMaterial').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSummaryPacking').attr("disabled", true).addClass("ui-state-disabled");
    }
}
function SetStatusSubButton(statusSubDoc) {
    if (statusSubDoc == 0) {
        $('#btnCNARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSHDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnADARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtARDocumentDate').datepicker().datepicker('enable');
        $('#txtARNote').attr("disabled", false).removeClass("ui-state-disabled");
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        if (CanEditMaterialAmount == 0) {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        } else {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        }
        rowState = 'editing';
    } else if (statusSubDoc == 1) {
        $('#btnCNARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnSHDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnADARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnCDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#txtARDocumentDate').datepicker().datepicker('disable');
        $('#txtARNote').attr("disabled", false).removeClass("ui-state-disabled");
        $("#theGrid-del-btn").attr('disabled', false).removeClass("ui-state-disabled");
        if (CanEditMaterialAmount == 0) {
            $("#SearchMaterial").attr('disabled', false).removeClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', false).removeClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
            rowState = 'editing';
        } else {
            $("#SearchMaterial").attr('disabled', false).removeClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', false).removeClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', false).removeClass("ui-state-disabled");
            $("#selUnit").attr('disabled', false).removeClass("ui-state-disabled");
            rowState = null;
        }

    } else if (statusSubDoc == 2) {
        $('#btnCNARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSHDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnADARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtARDocumentDate').datepicker().datepicker('disable');
        $('#txtARNote').attr("disabled", true).addClass("ui-state-disabled");
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        if (CanEditMaterialAmount == 0) {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        } else {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        }
        rowState = 'editing';

    } else if (statusSubDoc == 99 || statusSubDoc == 3 || statusSubDoc == 4) {
        $('#btnCNARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSHDARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnADARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtARDocumentDate').datepicker().datepicker('disable');
        $('#txtARNote').attr("disabled", true).addClass("ui-state-disabled");
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        if (CanEditMaterialAmount == 0) {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        } else {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        }
        rowState = 'editing';

    } else {

        $('#btnCNARPrefinish').attr("disabled", false).removeClass("ui-state-disabled");
        $('#btnSHDARPrefinish').attr("disabled", true).removeClass("ui-state-disabled");
        $('#btnSDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnADARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#btnCDARPrefinish').attr("disabled", true).addClass("ui-state-disabled");
        $('#txtARDocumentDate').datepicker().datepicker('disable');
        $('#txtARNote').attr("disabled", true).addClass("ui-state-disabled");
        $("#theGrid-del-btn").attr('disabled', true).addClass("ui-state-disabled");
        if (CanEditMaterialAmount == 0) {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        } else {
            $("#SearchMaterial").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMCode").attr('disabled', true).addClass("ui-state-disabled");
            $("#txtMAmount").attr('disabled', true).addClass("ui-state-disabled");
            $("#selUnit").attr('disabled', true).addClass("ui-state-disabled");
        }
        rowState = 'editing';



    }
}
//======================================================== ค้นหาคลังสินค้า ============================================//

// คลังสินค้า
function LoadInventory(selectorName) {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=ListInventoryName',
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

//======================================================== สร้างรอบเอกสาร ============================================//
function CreateNewDocumentBatch() {
    CheckSessionTimeOut();
    CreateDocumentBatch();
}
function CreateDocumentBatch() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=NewPrefinishBatch',
        cache: false,
        success: function(data) {
            CheckDocumentStatus();
            DocumentHeader();
            $("#theGrid").jqGrid().trigger("reloadGrid");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
function CreateNewAddMaterialAndReduceMaterialForPrefinishDocument() {
    CheckSessionTimeOut();
    if (hdfARStatus == 1) {
        CreateNewReduceMaterialForPrefinishDocument();
    } else if (hdfARStatus == 2) {
        CreateNewAddMaterialForPrefinishDocument();
    } else if (hdfARStatus == 3) {
        CreateNewPrefinishDocument();
    }
}
function SaveAddMaterialAndReduceMaterialForPrefinishDocument() {
    CheckSessionTimeOut();
    if (hdfARStatus == 1) {
        SaveDocumentDataIntoDB(1)
        $("#theGrid").jqGrid().trigger("reloadGrid");
    } else if (hdfARStatus == 2) {
        SaveDocumentDataIntoDB(2)
        $("#theGrid2").jqGrid().trigger("reloadGrid");
    } else if (hdfARStatus == 3) {
        SaveDocumentDataIntoDB(3)
        $("#theGrid3").jqGrid().trigger("reloadGrid");
    }
}
function CancelAddMaterialAndReduceMaterialForPrefinishDocument() {
    CheckSessionTimeOut();
    if (hdfARStatus == 1) {
        opendialogConfirmDoc('dialogConfirmCancelSubDoc', 99);
    } else if (hdfARStatus == 2) {
        opendialogConfirmDoc('dialogConfirmCancelSubDoc', 99);
    } else if (hdfARStatus == 3) {
        opendialogConfirmDoc('dialogConfirmCancelSubDoc', 99);
    }
}
function ApproveAddMaterialAndReduceMaterialForPrefinishDocument() {
    CheckSessionTimeOut();
    if (hdfARStatus == 1) {
        opendialogConfirmDoc('dialogConfirmApproveSubDoc', 2);
    } else if (hdfARStatus == 2) {
        opendialogConfirmDoc('dialogConfirmApproveSubDoc', 2);
    } else if (hdfARStatus == 3) {
        opendialogConfirmDoc('dialogConfirmApproveSubDoc', 2);
    }
}
//======================================================== สร้างเอกสารโอนคืนคลัง ============================================//
function CreateNewAddMaterialForPrefinishDocument() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=NewAddMaterialForPrefinishDocument',
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(2);
                } else {
                    alert(data.ResultText);
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(2);

                }
            } else {
                alert(xhr.responseText);
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
//======================================================== สร้างเอกสารเบิกสินค้าเพื่อผลิต ============================================//
function CreateNewReduceMaterialForPrefinishDocument() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=NewReduceMaterialForPrefinishDocument',
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    //alert(hdfARStatus);
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(1);
                } else {
                    alert(data.ResultText);
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(1);
                }
            } else {
                alert(xhr.responseText);
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}
//======================================================== สร้างเอกสารแปรรูป ============================================//
function CreateNewPrefinishDocument() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=NewPrefinishDocument',
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(3);
                } else {
                    alert(data.ResultText);
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(3);
                }
            } else {
                alert(xhr.responseText);
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            MessageError(xhr.responseText);
        }
    });
}

//======================================================== บันทึกเอกสารการโอน ============================================//

function SaveDocument() {
    var batchDate = $('#txtDocumentDate').val();
    var batchNote = $('#txtNote').val();
    var batchName = $('#txtPackingName').val();
    var batchDeliveryDate = $('#txtDeliveryDate').val();
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=SaveDocumentBatch',
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
                    DocumentHeader();
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    $("#theGrid3").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmSaveDoc').dialog('close');
                    alert(data.strResultText);
                    DocumentHeader();
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    $("#theGrid3").jqGrid().trigger("reloadGrid");
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }
    });
}
function SaveDocumentDataIntoDB(acLoad) {
    var docDate = $('#txtARDocumentDate').val();
    var docNote = $('#txtARNote').val();
    var docInvoice = $('#txtARInvoiceNo').val();
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=SaveDocumentDataIntoDB&acLoad=' + acLoad,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ docDate: docDate, docNote: docNote, docInvoice: docInvoice }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(hdfARStatus);
                    if (hdfARStatus == 1) {
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 2) {
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 3) {
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    }


                } else {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(hdfARStatus);
                    if (hdfARStatus == 1) {
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 2) {
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 3) {
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    }
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
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=cancelDoc',
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
                    DocumentHeader();
                    CheckDocumentStatus();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                } else {
                    $('#dialogConfirmCancelDoc').dialog('close');
                    alert(data.strResultText);
                    DocumentHeader();
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
//======================================================== อนุมัติรอบเอกสาร ============================================//
function CheckApproveDocumentBatch() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckApproveBatch',
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 0) {
                    alert(data.strResultText);
                } else if (data.status == 1) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    $('#hdfDocumentDateApproveBatch').val(data.newDocumentDate);
                    ApproveDocument();
                } else if (data.status == 2) {
                    $('#dialogConfirmApproveDoc').dialog('close');
                    $('#P2').html(data.strResultText);
                    $('#hdfDocumentDateApproveBatch').val(data.newDocumentDate);
                    opendialogConfirmDoc('dialogConfirmApproveDocBatchAgain', 2);
                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }

    });
}
function ApproveDocument() {
    var newDocumentDate = $('#hdfDocumentDateApproveBatch').val()
    ary_data = newDocumentDate.split("/");
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=ApprovePrefinishBatch',
        cache: false,
        datatype: 'json',
        type: 'POST',
        data: ({ day: ary_data[0], month: ary_data[1], year: ary_data[2] }),
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    closedialogConfirmDoc('dialogConfirmApproveDocBatchAgain');
                    //alert(data.ResultText);
                    DocumentHeader();
                    CheckDocumentStatus();
                    //SearchDocumentData();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    $("#theGrid3").jqGrid().trigger("reloadGrid");
                } else {
                    DocumentHeader();
                    CheckDocumentStatus();
                    //SearchDocumentData();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    $("#theGrid3").jqGrid().trigger("reloadGrid");
                    closedialogConfirmDoc('dialogConfirmApproveDocBatchAgain');
                    alert(data.ResultText);

                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.ResultText);
            }
        }

    });
}
function CheckStockForTransferDocument() {
    if (hdfARStatus == 1) {
        $.ajax({
            url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckStock',
            cache: false,
            datatype: 'json',
            type: 'GET',
            complete: function(xhr, status) {
                // alert(status);
                if (status == 'success') {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.status);
                    if (data.status == 0) {
                        $('#dialogConfirmApproveSubDoc').dialog('close');
                        CheckApproveDocument();
                    } else if (data.status == 1) {
                        $('#dialogConfirmApproveSubDoc').dialog('close');
                        alert(data.strResultText);
                        OpenDialogMaterialEnough('DialogMaterialInStock');
                        ShowMaterialInStockEnoughForTransfer()
                    } else {
                        var data = eval("(" + xhr.responseText + ")");
                        MessageError(data.strResultText);
                    }
                }
            }
        });
    } else {
        CheckApproveDocument();
    }
}
function ShowMaterialInStockEnoughForTransfer() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadStockEnoughForTransfer',
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
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CheckApprove&acLoad=' + hdfARStatus,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 0) {
                    alert(data.strResultText);
                } else if (data.status == 1) {
                    $('#dialogConfirmApproveSubDoc').dialog('close');
                    $('#hdfDocumentDateApprove').val(data.newDocumentDate);
                    ApproveSubDocument();
                } else if (data.status == 2) {
                    $('#dialogConfirmApproveSubDoc').dialog('close');
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
function ApproveSubDocument() {
    var newDocumentDate = $('#hdfDocumentDateApprove').val()
    ary_data = newDocumentDate.split("/");
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=ApproveDocumentData&acLoad=' + hdfARStatus,
        cache: false,
        datatype: 'json',
        type: 'POST',
        data: ({ day: ary_data[0], month: ary_data[1], year: ary_data[2] }),
        complete: function(xhr, status) {
            //alert(status);
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                if (data.status == 1) {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(hdfARStatus);
                    if (hdfARStatus == 1) {
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 2) {
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 3) {
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    }

                } else {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(hdfARStatus);
                    if (hdfARStatus == 1) {
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 2) {
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 3) {
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    }
                    alert(data.ResultText);

                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.ResultText);
            }
        }

    });
}
//======================================================== ยกเลิกเอกสาร ============================================//
function CancelDocumentBatch() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CancelDocumentBatch',
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    closedialogConfirmDoc('dialogConfirmCancelDoc');
                    DocumentHeader();
                    CheckDocumentStatus();
                    //SearchDocumentData();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    $("#theGrid3").jqGrid().trigger("reloadGrid");
                } else {
                    DocumentHeader();
                    CheckDocumentStatus();
                    //SearchDocumentData();
                    $("#theGrid").jqGrid().trigger("reloadGrid");
                    $("#theGrid2").jqGrid().trigger("reloadGrid");
                    $("#theGrid3").jqGrid().trigger("reloadGrid");
                    closedialogConfirmDoc('dialogConfirmCancelDoc');
                    alert(data.ResultText);

                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.ResultText);
            }
        }

    });
}
function CancelSubDocument() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=CancelDocument&acLoad=' + hdfARStatus,
        cache: false,
        datatype: 'json',
        type: 'GET',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            if (status == 'success') {
                var data = eval("(" + xhr.responseText + ")");
                //alert(data.status);
                if (data.status == 1) {
                    closedialogConfirmDoc('dialogConfirmCancelSubDoc');
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(hdfARStatus);
                    if (hdfARStatus == 1) {
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 2) {
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 3) {
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    }

                } else {
                    DocumentHeaderDataForARMaterial(hdfARStatus);
                    DocumentDetailForARMaterial(hdfARStatus);
                    CheckSubDocumentOnLoad(hdfARStatus);
                    if (hdfARStatus == 1) {
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 2) {
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                    } else if (hdfARStatus == 3) {
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    }
                    closedialogConfirmDoc('dialogConfirmCancelSubDoc');
                    alert(data.ResultText);

                }
            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.ResultText);
            }
        }

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

//======================================================== ค้นหาเอกสารรอบ ============================================//

function openDialogSearchDocument(id) {
    SearchDocumentData();
    $('#' + id).dialog({ width: 800, position: [200, 10], autoOpen: false, bgiframe: true, modal: true });
    $('#' + id).dialog('open');
    $('#' + id).parent().appendTo($("form:first"));
    $("#jGDocument").jqGrid({
        //url: 'No',
        colNames: ['#', 'เลขที่เอกสาร', 'วันที่เอกสาร', 'สถานะ', 'หมายเหตุ', 'DocumentBatchID', 'DocumentShopID'],
        colModel: [
                    { name: 'id', index: 'id', width: 30, align: 'center' },
   		            { name: 'BatchNumber', index: 'BatchNumber', width: 150 },
                    { name: 'BatchDate', index: 'BatchDate', width: 150 },
   		            { name: 'BatchStatus', index: 'BatchStatus', width: 100 },
                    { name: 'BatchNote', index: 'BatchNote', width: 100 },
                    { name: 'DocumentBatchID', index: 'DocumentBatchID', width: 100, hidden: true },
                    { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true }
                    ],
        rowNum: -1,
        height: 270,
        autowidth: true,
        pager: $('#pageDocument'),
        viewrecords: false,
        ondblClickRow: function(rowID, iRow, iCol, e) {
            LoadNewDocumentData();
            CheckDocumentStatus();
            DocumentHeader();
            $('#' + id).dialog('close');
            $("#theGrid").jqGrid().trigger("reloadGrid");
            $("#theGrid2").jqGrid().trigger("reloadGrid");
            $("#theGrid3").jqGrid().trigger("reloadGrid");
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });


}

// ค้นหาเอกสารรอบการโอนสินค้า
function SearchDocumentData() {
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();
    var dStatus = $('#ddlSDStatus').val();
    var dInvId = $('#ddlSDFromInv').val();
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=SearchPrefinishBatch',
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
function SearchSummaryDocument(acLoadStatus) {
    //alert(acLoadStatus);
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadSummaryDocument&acLoad=' + acLoadStatus,
        cache: false,
        type: 'GET',
        datatype: 'xml',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#GridViewSummary")[0];
            gridDoc.addXmlData(xhr.responseXML);
        }

    });

}
function SearchSummaryDocumentBatch() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadSummaryDocumentBatch',
        cache: false,
        type: 'GET',
        datatype: 'xml',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#GridViewSummaryBatch")[0];
            gridDoc.addXmlData(xhr.responseXML);
        }

    });

}
function SearchSummaryDocumentStandard() {
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadSummaryDocumentStandard',
        cache: false,
        type: 'GET',
        datatype: 'xml',
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridDoc = $("#GridViewSummaryBatchCompareStandard")[0];
            gridDoc.addXmlData(xhr.responseXML);
        }

    });

}
// ค้นหาเอกสารใบใหม่เพื่อมาทำรายการ
function LoadNewDocumentData() {
    var gridRow = $("#jGDocument").getGridParam('selrow');
    var data = $("#jGDocument").getRowData(gridRow);
    var newDocID = data.DocumentBatchID;
    var newShopID = data.DocumentShopID;
    if (newDocID != '' && newShopID != '' || newDocID != 0 && newShopID != 0) {
        $.ajax({
            url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadPrefinishBatchDetail',
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
                        DocumentHeader();
                        CheckDocumentStatus();
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
                    } else {
                        alert(data.ResultText);
                        CheckDocumentOnLoad();
                        //CheckCreateTransferdocument();
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                        $("#theGrid2").jqGrid().trigger("reloadGrid");
                        $("#theGrid3").jqGrid().trigger("reloadGrid");
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
function LoadNewDocumentDataFromAddMaterialAndReduceMaterial(newDocID, newShopID, acLoad) {
    //alert(newDocID + ':' + newShopID + ':' + acLoad);
    if (newDocID != '' && newShopID != '' || newDocID != 0 && newShopID != 0) {
        $.ajax({
            url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadNewDocumentFromAddReduce&acLoad=' + acLoad,
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
                        CheckSubDocumentOnLoad(acLoad);
                        DocumentHeaderDataForARMaterial(acLoad);
                        DocumentDetailForARMaterial(acLoad);
                        $("#theGrid").jqGrid().trigger("reloadGrid");
                    } else {
                        alert(data.ResultText);
                        CheckSubDocumentOnLoad(acLoad);
                        DocumentHeaderDataForARMaterial(acLoad);
                        DocumentDetailForARMaterial(acLoad);
                    }
                } else {
                    var data = eval("(" + xhr.responseText + ")");
                    MessageError(data.strResultText);
                    CheckSubDocumentOnLoad(acLoad);
                    DocumentHeaderDataForARMaterial(acLoad);
                    DocumentDetailForARMaterial(acLoad);
                }
            }
        });

    }

}
// ปิดหน้าต่าง Dialog การค้นหาเอกสารการโอน
function closeDialogSearchDocument(id) {
    $('#' + id).dialog('close');
}

//====================================================================================================//

function AddEditMaterialJqGrid() {

    $("#theGrid").jqGrid({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadReduceMaterialPrefinish',
        datatype: 'xml',
        colNames: ['#', 'เลขที่เอกสาร', 'วันที่เอกสาร', 'สถานะ', 'หมายเหตุ', 'DocumentID', 'DocumentShopID'],
        colModel: [
                { name: 'id', index: 'id', width: 20, align: 'center' },
                { name: 'DocumentNumber', index: 'DocumentNumber', width: 100 },
                { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                 { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                { name: 'DocumentNote', index: 'DocumentNote', width: 300 },
                { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true }

                ],
        pager: '#pager',
        autowidth: true,
        height: 120,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: false,
        multiboxonly: false,
        viewrecords: true,
        caption: 'เอกสารเบิกสินค้าเพื่อแปรรูป',
        ondblClickRow: function(rowidx, iRow, iCol, e) {
            var docData = $(this).jqGrid('getRowData', rowidx);
            LoadNewDocumentDataFromAddMaterialAndReduceMaterial(docData.DocumentID, docData.DocumentShopID, 1);
            OpenDialog(1, 1);

        }
    });

}
function ReduceMaterialJqGrid() {
    $("#theGrid2").jqGrid({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadAddMaterialPrefinish',
        datatype: 'xml',
        colNames: ['#', 'เลขที่เอกสาร', 'วันที่เอกสาร',
                'สถานะ', 'หมายเหตุ', 'DocumentID', 'DocumentShopID'],
        colModel: [
                { name: 'id', index: 'id', width: 20, align: 'center' },
                { name: 'DocumentNumber', index: 'DocumentNumber', width: 100 },
                { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                { name: 'DocumentNote', index: 'DocumentNote', width: 300 },
                { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true }

                ],
        pager: '#pager',
        autowidth: true,
        height: 120,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: false,
        multiboxonly: false,
        viewrecords: true,
        caption: 'เอกสารโอนคืนสินค้า',
        ondblClickRow: function(rowidx, iRow, iCol, e) {
            var docData = $(this).jqGrid('getRowData', rowidx);
            LoadNewDocumentDataFromAddMaterialAndReduceMaterial(docData.DocumentID, docData.DocumentShopID, 2);
            OpenDialog(2, 1);
        }
    });

}
function PrefinishMaterialJqGrid() {
    $("#theGrid3").jqGrid({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=LoadPrefinishMaterialPrefinish',
        datatype: 'xml',
        colNames: ['#', 'เลขที่เอกสาร', 'วันที่เอกสาร', 'สถานะ', 'หมายเหตุ', 'DocumentID', 'DocumentShopID'],
        colModel: [
                { name: 'id', index: 'id', width: 20, align: 'center' },
                { name: 'DocumentNumber', index: 'DocumentNumber', width: 100 },
                { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                { name: 'DocumentStatus', index: 'DocumentStatus', width: 100 },
                { name: 'DocumentNote', index: 'DocumentNote', width: 300 },
                { name: 'DocumentID', index: 'DocumentID', width: 100, hidden: true },
                { name: 'DocumentShopID', index: 'DocumentShopID', width: 100, hidden: true }

                ],
        pager: '#pager',
        autowidth: true,
        height: 120,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: false,
        multiboxonly: false,
        viewrecords: true,
        caption: 'เอกสารแปรรูปสินค้า',
        ondblClickRow: function(rowidx, iRow, iCol, e) {
            var docData = $(this).jqGrid('getRowData', rowidx);
            LoadNewDocumentDataFromAddMaterialAndReduceMaterial(docData.DocumentID, docData.DocumentShopID, 3);
            OpenDialog(3, 1);

        }
    });

}
function GridViewSummary() {
    $("#GridViewSummary").jqGrid({
        //url: '?',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวน', 'หน่วย'],
        colModel: [
        { name: 'ID', index: 'ID', width: 50 },
   		{ name: 'MaterialCode', index: 'MaterialCode', width: 100 },
   		{ name: 'MaterialName', index: 'MaterialName', width: 500 },
        { name: 'Amount', index: 'Amount', width: 100 },
        { name: 'Unit', index: 'Unit', width: 100 }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 350,
        autowidth: 850,
        pager: $('#PageSummary'),
        viewrecords: false,
        caption: "Result"
    }).navGrid('#PageSummary', { edit: false, add: false, del: false, search: false, refresh: false });
}
function GridViewSummaryBatch() {
    $("#GridViewSummaryBatch").jqGrid({
        //url: '?',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวน', 'หน่วย'],
        colModel: [
        { name: 'ID', index: 'ID', width: 50 },
   		{ name: 'MaterialCode', index: 'MaterialCode', width: 100 },
   		{ name: 'MaterialName', index: 'MaterialName', width: 500 },
        { name: 'Amount', index: 'Amount', width: 100 },
        { name: 'Unit', index: 'Unit', width: 100 }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 150,
        autowidth: 850,
        pager: $('#PageSummaryBatch'),
        viewrecords: false,
        caption: "วัตถุดิบที่ใช้ในการผลิต"
    }).navGrid('#PageSummaryBatch', { edit: false, add: false, del: false, search: false, refresh: false });
}
function GridViewSummaryBatchCompareStandard() {
    $("#GridViewSummaryBatchCompareStandard").jqGrid({
        //url: '?',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวนมาตรฐาน', 'จำนวนที่ใช้จริง', 'หน่วย', 'StandardUnitSmallAmount', 'ActualUnitSmallAmount'],
        colModel: [
        { name: 'ID', index: 'ID', width: 50 },
   		{ name: 'MaterialCode', index: 'MaterialCode', width: 100 },
   		{ name: 'MaterialName', index: 'MaterialName', width: 400 },
        { name: 'StandardDisplayAmount', index: 'StandardDisplayAmount', width: 100 },
        { name: 'ActualDisplayAmount', index: 'ActualDisplayAmount', width: 100 },
        { name: 'UnitLargeName', index: 'UnitLargeName', width: 100 },
        { name: 'StandardUnitSmallAmount', index: 'StandardUnitSmallAmount', width: 100, hidden: true },
        { name: 'ActualUnitSmallAmount', index: 'ActualUnitSmallAmount', width: 100, hidden: true }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 150,
        autowidth: 850,
        pager: $('#PageSummaryBatchCompareStandard'),
        viewrecords: false,
        caption: "วัตถุเปรียบเทียบกับมาตรฐาน"
    }).navGrid('#PageSummaryBatchCompareStandard', { edit: false, add: false, del: false, search: false, refresh: false });
}
var selectedRowID = 0;      //selected rowid for edit

function GridViewAddReduceDocument() {

    jQuery("#GVAddReduceDoc").jqGrid({
        //url: '?',
        datatype: 'xml',
        colNames: ['#', 'รหัสสินค้า', 'ชื่อสินค้า', 'จำนวน', 'ราคา/หน่วย', 'หน่วย', 'ส่วนลด', 'VAT', 'ราคารวม', 'editDocDetailID', 'materialvatype', 'materialid', 'unitid', 'discountamount', 'discountpercent'],
        colModel: [
   		{ name: 'id', index: 'id', width: 50, editable: false, hidden: false, align: 'center' },
        { name: 'mcode', index: 'mcode', width: 150, editable: true, edittype: 'custom', editrules: { custom: true, caption: 'ข้อความ',
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
                    elemStr += '<div><button id="' + options.id + '_bs" type="button" title="Search" onclick="searchMaterial(0);" style="height:19px; padding:0 4px; width:30px;" class="ui-button ui-state-default" ><span class="ui-icon ui-icon-search"></span></button></div>';
                    return elemStr;
                },
                custom_value: function(elem) {
                    return elem.val();
                }
            }
        },
   		{ name: 'mname', index: 'mname', width: 450, editable: false },
   		{ name: 'mamount', index: 'mamount', width: 100, editable: true, align: 'right', editrules: { custom: true, top: 10,
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
   		{ name: 'munit', index: 'munit', width: 100, editable: true, align: 'left', edittype: 'custom',
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
        pager: '#G1',
        autowidth: 860,
        height: 250,
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        multiselect: true,
        multiboxonly: true,
        ondblClickRow: function(rowid, iRow, iCol, e) {

            if (rowState != 'editing') {
                selectedRowID = rowid;
                $(this).editRow(rowid, false, oneditfunc);
                rowState = 'editing';

            }

        },
        onSelectRow: function(rowid) {

            if (rowid != selectedRowID) {
                var materialData = $(this).jqGrid('getRowData', selectedRowID);
                var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
                jQuery("#GVAddReduceDoc").saveRow(selectedRowID, succesfunc, 'DataXML/PrefinishDocumentXML.aspx?action=addMaterialInDocDetial&acLoad=' + hdfARStatus, { mid: materialData.mid, indexlist: selectedRowID, editdocdetailid: materialData.editdocdetailid, IsDiscount: mslDiscount }, aftersavefunc, errorfunc, afterrestorefunc);

            }
        },

        viewrecords: true,
        caption: 'รายการสินค้า'
    });
    SettingPageGridView(true);

}
function jqGridMeterialInStock() {
    var materialData = null;       //data from search material
    var materialCode = "";
    $("#MTStock").jqGrid({
        colNames: ['MaterialID', 'รหัสสินค้า', 'ชื่อสินค้า', 'TransferSmallAmount', 'จำนวนที่โอน', 'CurrentStockSmallAmount', 'คงเหลือ', 'UnitSmallID'],
        colModel: [
        { name: 'MaterialID', index: 'MaterialID', width: 50, hidden: true },
   		{ name: 'MaterialCode', index: 'MaterialCode', width: 100 },
   		{ name: 'MaterialName', index: 'MaterialName', width: 200 },
        { name: 'TransferSmallAmount', index: 'TransferSmallAmount', width: 100, hidden: true },
        { name: 'TransferDisplayText', index: 'TransferDisplayText', width: 100 },
        { name: 'CurrentStockSmallAmount', index: 'CurrentStockSmallAmount', width: 100, hidden: true },
        { name: 'CurrentStockDisplayText', index: 'CurrentStockDisplayText', width: 200 },
        { name: 'UnitSmallID', index: 'UnitSmallID', hidden: true }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 200,
        widht: 600,
        pager: $('#MTStockPage'),
        viewrecords: false,
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });
}
function SettingPageGridView(action) {
    if (action == true) {
        //-- จัดการ page
        $("#GVAddReduceDoc").jqGrid('navGrid', '#G1', { edit: false, add: false, del: false, search: false }).navButtonAdd('#G1', {
            id: 'theGrid-del-btn', // Add id ให้ปุ่ม Delete
            caption: "ลบรายการ",
            buttonicon: "ui-icon-trash",
            onClickButton: function() {
                var rowCheckedDel = $("#GVAddReduceDoc").jqGrid('getGridParam', 'selarrrow');
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
                    deleteMaterial('ลบข้อมูล', 'ต้องการลบข้อมูล ใช่หรือไม่', 'ตกลง', 'ยกเลิก', 'DataXML/PrefinishDocumentXML.aspx?action=delMaterialInDocDetial&docdetailid=' + delParam + "&acLoad=" + hdfARStatus);
                } else {
                    alert("กรุณาเลือกแถวที่ท่านต้องการลบก่อน!");
                    $(this).setGridParam(({ multiselect: true }));
                }
            },
            position: "first"
        }).navButtonAdd('#G1', {
            caption: "เพิ่มแถว",
            buttonicon: "icon-addrow-after",
            onClickButton: function() {
                addRow();
            },
            position: "first"
        });
    } else {
        $("#GVAddReduceDoc").jqGrid('navGrid', '#G1', { edit: edit, add: add, del: del, search: search });

    }

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
                DocumentDetailForARMaterial(hdfARStatus);
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

//-- resize grid when resize browser
$(window).bind('resize', function() {
    $("#GVAddReduceDoc").setGridWidth($(window).width() - 8);
}).trigger('resize');

//-- search material dialog
function searchMaterial(action) {
    var materialData = null;
    actionAdd = action
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

}
function SearchMaterialByCodeAndName(materialCode, searchAction) {
    //alert(materialCode);
    //alert(searchAction);
    var acLoad = hdfARStatus;
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=searchMatByCodeAndName&acLoad=' + acLoad,
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
        $.post('DataXML/PrefinishDocumentXML.aspx?action=addrow',
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
   		{ name: 'mname', index: 'mname', width: 430 },
        { name: 'vattype', index: 'vattype', hidden: true }

   	],
        rowNum: -1,
        pgbuttons: false,
        pgtext: null,
        height: 290,
        autowidth: 500,
        pager: $('#mpager'),
        viewrecords: false,
        ondblClickRow: function(rowidx, iRow, iCol, e) {
            materialData = $(this).jqGrid('getRowData', rowidx);
            if (actionAdd == 0) {
                setDataToTheGrid(materialData);
            } else if (actionAdd == 1) {
                setDataWhenEnterSearchJSONByTextBox(materialData.mcode);
            }
            $("#boxSearchProduct").dialog('close');
        },
        onSelectRow: function(rowidx) {
            materialData = $(this).jqGrid('getRowData', rowidx);
            $("#btnSMOk").click(function() {
                if (actionAdd == 0) {
                    setDataToTheGrid(materialData);
                } else if (actionAdd == 1) {
                    setDataWhenEnterSearchJSONByTextBox(materialData.mcode);
                }
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
    $.getJSON('DataXML/PrefinishDocumentXML.aspx?action=getPricePerUnit', { editdocdetailid: docDetailID, materialId: materialId, unitId: unitId, materialAmount: amount, materailDiscount: mdiscount, materialVat: vat, isDicount: msldiscount, mPricePerUnit: mpriceper, actionby: actionby }, function(data, status) {
        //alert(data.mTotalPrice);
        //{"priceperunit":"100"}
        if (data != null) {
            //-- update ราคา
            $("#" + selectedRowID + "_mpriceperunit").val(data.priceperunit);
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mTotalPrice });

        }
    });
}

//-- จากการ search แบบ dialog
function setDataToTheGrid(materialData) {
    var acLoad = hdfARStatus;
    $.getJSON('DataXML/PrefinishDocumentXML.aspx?action=getMaterialDataJSON&acLoad=' + acLoad, { editDetailId: -1, materialId: materialData.mid, materialCode: materialData.mcode, materialName: materialData.mname, materialAmount: 0, Price: 0, selectUnit: -1, Discouent: 0, IsDiscount: 0, materialVatType: materialData.vattype, actionby: 1 }, function(data, status) {
        //alert(data.d);
        if (data != null) {
            //alert(data.mtotalprice);
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mid: data.mid });
            $("#" + selectedRowID + "_mcode").val(data.mcode);
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mname: data.mname });
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
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
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
    var acLoad = hdfARStatus;
    var theGridData = $("#GVAddReduceDoc").jqGrid('getRowData', 'selrow');
    var editDocDetailId = theGridData.editdocdetailid;
    $.getJSON('DataXML/PrefinishDocumentXML.aspx?action=getMaterialDataJSONByCode&acLoad=' + acLoad, { materialCode: materialCode, editDocDetailId: editDocDetailId }, function(data, status) {
        //alert(data.d);
        if (data != null) {
            //alert(data.mtotalprice);
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mid: data.mid });
            $("#" + selectedRowID + "_mcode").val(data.mcode);
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mname: data.mname });
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
            $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
            $("#" + selectedRowID + "_unitid").val(data.unitid);
            $("#" + selectedRowID + "_mamount").focus();
            $("#" + selectedRowID + "_mamount").select();

        }
    });
}
function setDataWhenEnterSearchJSONByTextBox(materialCode) {
    var acLoad = hdfARStatus;
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=getMaterialDataJSONByCode&acLoad=' + acLoad,
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
                    cmMaterialId = data.mid;
                    var select = $("#selUnit");
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
                    if (CanEditMaterialAmount == 0) {
                        CompareMaterial(cmMaterialId);
                        $("#txtMCode").focus();
                        $("#txtMCode").select();
                    } else {
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
function CompareMaterial(mId) {
    var acLoad = hdfARStatus;
    var mUnit = $("#selUnit").val();
    var mAmount = $("#txtMAmount").val();
    $.ajax({
        url: 'DataXML/PrefinishDocumentXML.aspx?action=addMaterialInDocDetial&acLoad=' + acLoad,
        cache: false,
        datatype: 'json',
        type: 'GET',
        data: ({ mid: mId, munit: mUnit, mamount: mAmount, indexlist: 0, editdocdetailid: 0, mdiscount: 0, mpricePerUnit: 0, IsDiscount: 0, mvat: 0 }),
        complete: function(xhr, status) {
            // alert(status);
            if (status == 'success') {
                DocumentDetailForARMaterial(hdfARStatus);
                $("#txtMCode").val('');
                $("#txtMAmount").val('');

            } else {
                var data = eval("(" + xhr.responseText + ")");
                MessageError(data.strResultText);
            }
        }
    });
}
// ตรวจการเปลี่ยนแปลงข้อมูลภายในแต่ละ Row
function CheckOneditRow() {
    var acLoad = hdfARStatus;
    var materialData = $("#GVAddReduceDoc").jqGrid('getRowData', selectedRowID);
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
        $.getJSON('DataXML/PrefinishDocumentXML.aspx?action=getMaterialDataJSON&acLoad=' + acLoad, { editDetailId: materialData.editdocdetailid, materialId: materialData.mid, materialCode: mCode, materialName: materialData.mname, materialAmount: mAmount, Price: mPricePerUnit, selectUnit: materialData.unitid, IsDiscount: slIsDiscount, materialVatType: materialData.materialvattype, mDiscountAmount: materialData.discountamount, mDiscountPercent: materialData.discountpercent, actionby: 2 }, function(data, status) {

            if (data != null) {
                //alert(data.mtotalprice);
                $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mid: data.mid });
                $("#" + selectedRowID + "_mcode").val(data.mcode);
                $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mname: data.mname });
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
                $("#GVAddReduceDoc").jqGrid('setRowData', selectedRowID, { mtotalprice: data.mtotalprice });
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
            $("#GVAddReduceDoc").jqGrid().trigger("reloadGrid");
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
        var acLoad = hdfARStatus;
        if (e.keyCode == 13) {
            var materialData = $("#GVAddReduceDoc").jqGrid('getRowData', selectedRowID);
            var mslDiscount = $("#" + selectedRowID + "_mdiscount_sl").val();
            jQuery("#GVAddReduceDoc").saveRow(selectedRowID, succesfunc, 'DataXML/PrefinishDocumentXML.aspx?action=addMaterialInDocDetial&acLoad=' + acLoad, { mid: materialData.mid, indexlist: selectedRowID, editdocdetailid: materialData.editdocdetailid, IsDiscount: mslDiscount }, aftersavefunc, errorfunc, afterrestorefunc);

        }
    });

}

function setFocus(theGrid, elm_name) {
    //-- set focus to element
    $(elm_name).focus();
}


function succesfunc() {
    rowState = null;
    DocumentDetailForARMaterial(hdfARStatus);

}
function aftersavefunc() {
    //alert('affter save');
    rowState = null;
    DocumentDetailForARMaterial(hdfARStatus);

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
function OpenDialog(acLoad, action) {
    hdfARStatus = acLoad;
    LoadMaterialGroup(acLoad);
    var titleDialog;
    if (acLoad == 1) {
        titleDialog = 'เอกสารเบิกเพื่อแปรรูปสินค้า';
    } else if (acLoad == 2) {
        titleDialog = 'เอกสารโอนคืนสินค้า'
    } else if (acLoad == 3) {
        titleDialog = 'เอกสารแปรรูปสินค้า'
    }
    if (action == 0) {
        CheckSubDocumentOnLoad(acLoad);
        DocumentHeaderDataForARMaterial(acLoad);
        DocumentDetailForARMaterial(acLoad);
    } else {

        CheckSubDocumentOnLoad(acLoad);
        DocumentHeaderDataForARMaterial(acLoad);
        DocumentDetailForARMaterial(acLoad);

    }

    $('#DialogAddPrefinish').dialog({ width: 900, height: 600, modal: true, resiable: false, title: titleDialog });

}
function OpenDialogSummary(acLoadStatus) {
    //alert(acLoadStatus);
    SearchSummaryDocument(acLoadStatus);
    if (acLoadStatus == 1) {
        titleDialog = 'สรุปเบิกสินค้าเพื่อแปรรูปสินค้า';
    } else if (acLoadStatus == 2) {
        titleDialog = 'สรุปโอนคืนสินค้า'
    } else if (acLoadStatus == 3) {
        titleDialog = 'สรุปแปรรูปสินค้า'
    }
    $('#DialogSummary').dialog({ width: 870, height: 500, modal: true, resiable: false, title: titleDialog });

}
function OpenDialogSummaryBatch() {
    SearchSummaryDocumentBatch();
    SearchSummaryDocumentStandard();
    $('#DialogSummaryBatch').dialog({ width: 870, height: 500, modal: true, resiable: false, title: 'สรุปรอบเอกสารแปรรูปสินค้า' });
}
function OpenDialogMaterialEnough() {
    $('#DialogMaterialInStock').dialog({ width: 620, height: 370, modal: true, resiable: false, title: 'จำนวนวัตถุดิบที่ไม่เพียงพอในสต๊อก' });
}
