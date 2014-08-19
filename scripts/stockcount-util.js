function checkPermission(permissId, staffCode, staffPass, successFunc, errorFunc) {
    //console.log(permissId + staffCode + staffPass);
    $.ajax({
        url: 'DataXML/ServiceInventory.asmx/CheckPermision',
        dataType: 'json',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: '{"permissionId": ' + permissId + ', "userName": "' + staffCode + '", "password": "' + staffPass + '" }',
        success: successFunc,
        error: errorFunc
    });

    //$.ajax({
    //    type: "POST",
    //    url: "DataXML/ServiceInventory.asmx/" + action,
    //    data: param,
    //    contentType: "application/json; charset=utf-8",
    //    dataType: "json",
    //    success: function (msg) {
    //        //alert(msg.d);
    //        var data = eval("(" + msg.d + ")");
    //        if (data.Status == true) {
    //            $("#dialog_approvedocument").dialog('close');
    //            alert(data.ResultText);
    //            window.location.reload();
    //        } else {
    //            //$("#dialog_approvedocument").dialog('close');
    //            alert(data.ResultText);
    //            $("#txtUserName").select();
    //        }
    //    },
    //    error: function (XMLHttpRequest, textStatus, errorThrown) {
    //        console.log(XMLHttpRequest);

    //    }
    //});
}

/**
* get params from url
*/
function get(name) {
    if (name = (new RegExp('[?&]' + encodeURIComponent(name) + '=([^&]*)')).exec(location.search))
        return decodeURIComponent(name[1]);
}

/*Disable enter key */
function DisableEnterKey(e) {
    var key;
    if (window.event)
        key = window.event.keyCode; //IE
    else
        key = e.which; //firefox     

    return (key != 13);
}

/**
* load stock material json
* params stockType 1=daily, 2=weekly, 3=monthly
* params langId
* params shopId
* params documentId
* params callback function when success
* params callback function when error
*/
function loadStockMaterial(stockType, langId, shopId, documentId, successFunc, errorFunc) {
    var loading = $("#loading");
    $.ajax({
        url: 'DataXML/LoadStockMaterialHandler.ashx?action=' + stockType
            + '&langId=' + langId + '&documentId=' + documentId + '&shopId=' + shopId,
        dataType: 'json',
        type: 'GET',
        contentType: "application/json; charset=utf-8",
        beforeSend: function (xhr, settings) {
            loading.dialog({
                dialogClass: 'noTitleStuff dialogWithDropShadow ui-corner-all',
                height: 30,
                width: 100,
                position: 'auto',
                modal: true,
                resizable: false
            });
        },
        success: successFunc,
        error: errorFunc,
        complete: function (xhr, status) {
            loading.dialog('close');
        }
    });
}

function refreshSettingStockCount(documentId, shopId, successFunc, errorFunc) {
    $.ajax({
        url: 'DataXML/RefreshStockCount.ashx?documentId=' + documentId + '&shopId=' + shopId,
        dataType: 'json',
        type: 'GET',
        contentType: "application/json; charset=utf-8",
        success: successFunc,
        error: errorFunc
    });
}

function ajaxWorkingCallback(startFunc, stopFunc) {
    $("#loading").ajaxStart(function () {
        $(this).dialog({
            dialogClass: 'noTitleStuff dialogWithDropShadow ui-corner-all',
            height: 30,
            width: 100,
            position: 'auto',
            modal: true,
            resizable: false
        });
        startFunc();
    }).ajaxStop(function () {
        $(this).dialog('close');
        stopFunc();
    }).removeClass('ui-widget-content');
}

function ajaxWorking() {
    $("#loading").ajaxStart(function () {
        $(this).dialog({
            dialogClass: 'noTitleStuff dialogWithDropShadow ui-corner-all',
            height: 30,
            width: 100,
            position: 'auto',
            modal: true,
            resizable: false
        });

    }).ajaxStop(function () {
        $(this).dialog('close');
    }).removeClass('ui-widget-content');
}

function chkNotCount(grid) {
    var record = grid.jqGrid('getGridParam', 'records');
    var rowToSelect = 0;
    var isCount = true;
    for (var i = 1; i <= record; i++) {
        var gridRowData = grid.jqGrid('getRowData', i);
        if (gridRowData.mcountamount == '') {
            isCount = false;
            rowToSelect = rowToSelect == 0 ? i : rowToSelect;
            grid.jqGrid('setCell', i, 6, '', { 'background': '#F53333', 'color': '#FFFFFF' });
            break;
        }
    }
    if (!isCount) {
        grid.jqGrid('setSelection', rowToSelect);
    }
    return isCount;
}

function chkCountDiffInJqGrid(grid) {
    var record = grid.jqGrid('getGridParam', 'records');
    var diff = false;
    for (var i = 1; i <= record; i++) {
        var gridRowData = grid.jqGrid('getRowData', i);
        //console.log(gridRowData.summary);
        if (gridRowData.summary < 0) {
            diff = true;
            grid.jqGrid('setCell', i, 5, '', { 'background': '#F53333', 'color': '#FFFFFF' });
        }
    }
    //console.log(diff);
    return diff;
}

function notAllowCount() {
    // if hq not allow countstock for branch
    require_var.docStatus = require_var.docStatus != 0 ? require_var.docStatus : 1;
    var control = new Array();
    control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount",
    "#txtCountAmount", "#txtCountUnitName", "#btnCountMat",
    "#btnApprove", "#btnSaveForm",
    "#btnAutoTransferStock", "#btnDisplayMaterial", "#btnCancelCountStock");
    if (require_var.dbShopId == 1) {

        //alert(JSON.stringify(require_var));
        if ($('#ddlInv :selected').val() != require_var.dbShopId) {
            disableControl(control);
        } else {
            if (require_var.docStatus == 1)
                enableControl(control);
        }
    }
}