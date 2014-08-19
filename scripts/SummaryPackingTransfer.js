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
var addParamDocId = '';
var addParamShopId = '';
// Already
$(function() {

    //กำหนด DocumentType ให้กับเอกสาร
    DocPackingTypeId = $.getUrlVar('DocPackingTypeId');

    getUrlDocTypID = "&DocPackingTypeId=" + DocPackingTypeId;
    postUrlDocTypeID = "DocPackingTypeId:" + DocPackingTypeId;

    //alert(getUrlDocTypID);
    var sltNameInv = "ddlSDFromInv";
    var sltNameInv2 = "ddlTFInv";
    LoadInventory(sltNameInv);
    LoadInventory(sltNameInv2);

    LoadRQStatus();

    langID = $.getUrlVar('LangID');

    $('#btnSelectDocument').click(function() {
        AddDocumentToBatch();
        $('#dialogSearchDocument').dialog('close');
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
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });
    MatrixtGridviewOnLoad()

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


//======================================================== เพิ่มเอกสารออกจากรอบการโอน ============================================//

function AddDocumentToBatch() {

    //alert(addParamDocId + ':' + addParamShopId);
    var rowCheckedDel = $("#jGDocument").jqGrid('getGridParam', 'selarrrow');
    if (rowCheckedDel != '') {

        for (var i = 0; i <= rowCheckedDel.length; i++) {
            var rowData = $('#jGDocument').jqGrid('getRowData', rowCheckedDel[i]);
            if (rowData.DocumentBatchID != null && rowData.DocumentBatchID != '') {
                if (addParamDocId == '') {
                    addParamDocId = rowData.DocumentBatchID;
                } else {
                    addParamDocId += "," + rowData.DocumentBatchID;
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
        alert("กรุณาเลือกเอกสาร!");
        $('#jGDocument').setGridParam(({ multiselect: true })); /*.showCol('cb');*/
    }
    //alert(addParamDocId + ':' + addParamShopId);

    if (addParamDocId != '' && addParamShopId != '') {

        $.ajax({
            url: 'DataXML/PackingDocumentXML.aspx?action=CreateGridviewSummaryMatrixtForm&newDocID=' + addParamDocId + '&newShopID=' + addParamShopId + getUrlDocTypID,
            cache: false,
            context: document.body,
            success: function(data) {
                //alert(data);
                $("#GridViewMatrix").html(data);
            }
        });
        $.ajax({
            url: 'DataXML/PackingDocumentXML.aspx?action=SummaryPrepareBatchReportMatrixForm&newDocID=' + addParamDocId + '&newShopID=' + addParamShopId + getUrlDocTypID,
            cache: false,
            type: 'GET',
            datatype: 'xml',
            complete: function(xhr, status) {
                var gridDoc = $("#GridSummary")[0];
                gridDoc.addXmlData(xhr.responseXML);
            }
        });
    }

    addParamDocId = '';
    addParamShopId = '';
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
        multiselect: true,
        multiboxonly: true,
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false, search: false, refresh: false });

    SearchDocumentData();

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


// ปิดหน้าต่าง Dialog การค้นหาเอกสารการโอน
function closeDialogSearchDocument(id) {
    $('#' + id).dialog('close');
}

//-- resize grid when resize browser
$(window).bind('resize', function() {
    $("#theGrid").setGridWidth($(window).width() - 8);
}).trigger('resize');

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
    $.ajax({
        url: 'DataXML/PackingDocumentXML.aspx?action=CreateGridviewSummaryMatrixtForm' + getUrlDocTypID,
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
        url: 'DataXML/PackingDocumentXML.aspx?action=ViewGridOnLoadSummary' + getUrlDocTypID,
        cache: false,
        context: document.body,
        success: function(data) {
            $("#GridViewMatrix").html(data);

        }
    });
}
