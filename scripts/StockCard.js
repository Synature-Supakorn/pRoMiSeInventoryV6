$(function() {

    $('#txtFromDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar_blue.png',
        buttonImageOnly: true

    });
    $('#txtToDate').datepicker({
        showOn: 'button', buttonImage: '../images/calendar_blue.png',
        buttonImageOnly: true

    });
    var langID = $.getUrlVar('LangID');
    $.datepicker.setDefaults($.datepicker.regional[langID]);

    $("button, input:submit, a", "#btnHeader").button({ icons: { primary: 'icon-export-xls' }, text: true });
    $("#CheckAll").button();
    $("#UnCheckAll").button();
    $('#btnSearch').button({ icons: { primary: 'ui-icon-document'} });
    $("#btMaterailproblem").button();
    $("#btnSearchProduct").button({ icons: { primary: 'ui-icon-search' }, text: false });

    $("#accordion").accordion({
        collapsible: true,
        autoHeight: false,
        navigation: true,
        icons: { 'header': 'ui-icon-circle-arrow-s', 'headerSelected': 'ui-icon-circle-arrow-n' }
    });

    ViewStockCardOnLoad();
    jqStockDetail();
});

function OnChangeCheckBox1(selectedOption) {
    var objCheckListBox = document.getElementById('chkInv');
    var chkBoxCount = objCheckListBox.getElementsByTagName("input");
    if (selectedOption == 1) {

        for (var i = 0; i < chkBoxCount.length; i++) {
            chkBoxCount[i].checked = true;
        }

    }
    else if (selectedOption == 2) {
        for (var i = 0; i < chkBoxCount.length; i++) {
            chkBoxCount[i].checked = false;
        }

    }
}
function fprintPage() {
    $("#printPage").printElement({

        printMode: 'popup',
        leaveOpen: true
    });
}

function popupdialog() {
    $("#dialog").dialog({ width: 800, modal: true });
}
function ViewStockCard() {
    var param;
    var textDisplay;
    var materialGroupId = $('#ddlMaterialGroup').val();
    var materialDeptId = $('#ddlMaterialDept').val();
    var materialCode = $('#txtMaterialCode').val();

    var cbMaterialHasMovement;
    if ($('#cbMaterialHasMovement').checked == true) {
        cbMaterialHasMovement = 1
    } else {
        cbMaterialHasMovement = 2
    }
    //alert(cbMaterialHasMovement);
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();

    ary_fromDate = fromDate.split("/");
    ary_toDate = toDate.split("/");

    var objCheckListBox = document.getElementById('chkInv');
    var chkBoxCount = objCheckListBox.getElementsByTagName("input");
    var chkValues = "";
    var chkItemName = ""

    for (var i = 0; i < chkBoxCount.length; i++) {
        if (chkBoxCount[i].checked == true) {
            //alert(chkBoxCount[i].value);
            var labelArray = chkBoxCount[i].parentNode.getElementsByTagName('label');

            if (chkValues == '') {
                chkValues = chkBoxCount[i].value;
                chkItemName = labelArray[i].innerHTML;
            } else {
                chkValues += ',' + chkBoxCount[i].value;
                chkItemName += ',' + labelArray[i].innerHTML;
            }
        }
    }
    //alert(chkValues);
    param = "&shopId=" + chkValues + "&mGroupId=" + materialGroupId + "&mDeptId=" + materialDeptId + "&mCode=" + materialCode + "&hasMoveMent=" + cbMaterialHasMovement;
    param += "&fromDay=" + ary_fromDate[0] + "&fromMonth=" + ary_fromDate[1] + "&fromYear=" + ary_fromDate[2];
    param += "&toDay=" + ary_toDate[0] + "&toMonth=" + ary_toDate[1] + "&toYear=" + ary_toDate[2];
    // alert(param);

    textDisplay = "การเคลื่อนไหวของวัตถุดิบรหว่างวันที่ " + $('#txtFromDate').val() + " ถึง " + $('#txtToDate').val();
    if (chkValues.length > 0) {
        $.ajax({
            url: 'DataXML/StockCardXML.aspx?action=ViewStockCard' + param,
            cache: false,
            context: document.body,
            success: function(data) {
                // alert(data);
                $("#ViewStockCardData").html(data);
                $("#txtDisplay").html(textDisplay);

            }
        });
    } else {
        alert('กรุณาเลือกคลังที่ต้องการแสดงข้อมูล');
    }
}
function ViewStockCardOnLoad() {
    $.ajax({
        url: 'DataXML/StockCardXML.aspx?action=ViewStockCardOnload',
        cache: false,
        context: document.body,
        success: function(data) {
            $("#ViewStockCardData").html(data);
        }
    });
}
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

function jqStockDetail() {
    $("#jqStockCardDetail").jqGrid({
        //url: '?',
        colNames: ['วันที่เอกสาร', 'เลขที่เอกสาร', 'จำนวน', 'คงเหลือ', 'หน่วย'],
        colModel: [
   		            { name: 'DocumentDate', index: 'DocumentDate', width: 100 },
                    { name: 'DocumentNumber', index: 'DocumentNumber', width: 370 },
   		            { name: 'MovementAmount', index: 'MovementAmount', width: 100, align: 'right' },
                    { name: 'CurrentAmount', index: 'CurrentAmount', width: 100, align: 'right' },
                    { name: 'UnitName', index: 'UnitName', width: 100}],
        rowNum: -1,
        height: 350,
        autowidth: true,
        pager: $('#pageStockDetail'),
        viewrecords: false,
        caption: ""
    });

}
function ShowStockCardDetail(materialId, materialName) {
    var param;
    var textDisplay;
    var fromDate = $('#txtFromDate').val();
    var toDate = $('#txtToDate').val();

    ary_fromDate = fromDate.split("/");
    ary_toDate = toDate.split("/");

    var objCheckListBox = document.getElementById('chkInv');
    var chkBoxCount = objCheckListBox.getElementsByTagName("input");
    var chkValues = "";
    var chkItemName = ""

    for (var i = 0; i < chkBoxCount.length; i++) {
        if (chkBoxCount[i].checked == true) {
            //alert(chkBoxCount[i].value);
            var labelArray = chkBoxCount[i].parentNode.getElementsByTagName('label');

            if (chkValues == '') {
                chkValues = chkBoxCount[i].value;
                chkItemName = labelArray[i].innerHTML;
            } else {
                chkValues += ',' + chkBoxCount[i].value;
                chkItemName += ',' + labelArray[i].innerHTML;
            }
        }
    }
    //alert(chkValues);
    param = "&groupOfInvId=" + chkValues + "&materialId=" + materialId;
    param += "&fromDay=" + ary_fromDate[0] + "&fromMonth=" + ary_fromDate[1] + "&fromYear=" + ary_fromDate[2];
    param += "&toDay=" + ary_toDate[0] + "&toMonth=" + ary_toDate[1] + "&toYear=" + ary_toDate[2];
    //alert(param);
    $.ajax({
        url: 'DataXML/StockCardXML.aspx?action=ViewStockDetail' + param,
        cache: false,
        complete: function(xhr, status) {
            //alert(xhr.responseText);
            var gridVen = $("#jqStockCardDetail")[0];
            gridVen.addXmlData(xhr.responseXML);

        }
    });
}
function openDialogStockDetail(materailID,materialName) {
    ShowStockCardDetail(materailID, materialName);
    var titleName;
    titleName='แสดงความเคลื่อนไหวของวัตถุดิบ '+ materialName
  $('#dialogStockCardDetail').dialog({ width: 800, height: 470, modal: true, resiable: false, title: titleName });    
  
}