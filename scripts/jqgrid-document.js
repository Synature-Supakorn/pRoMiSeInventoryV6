function bindDataToGrid() {
    var lastsel;
    jQuery("#theGrid").jqGrid({
        url: 'Inventory/DataXML/PourShaseDocumentXML.aspx',
        datatype: "xml",
        colNames: ['#', 'รหัสสินค้า', 'รายการสินค้า', 'จำนวน', 'ราคา/หน่วย', 'หน่วย', 'ส่วนลด', 'VAT', 'ราคารวม'],
        colModel: [
   		{ name: 'id', index: 'id', width: 30, editable: false, align: 'center' },
   		{ name: 'code', index: 'code', width: 150, editable: true, /*edittype:'custom',*/editoptions: { size: 20, maxlength: 30 }, edittype: 'text', align: 'center' },
   		{ name: 'name', index: 'name', width: 60, editable: false/*edittype: "checkbox", editoptions: { value: "Yes:No"}*/ },
   		{ name: 'amount', index: 'amount', width: 90, editable: true, editrules: { required: true }, align: 'center'  /*edittype: "select", editoptions: { value: "FE:FedEx;IN:InTime;TN:TNT;AR:ARAMEX"}*/ },
   		{ name: 'pricePerUnit', index: 'pricePerUnit', width: 90, editable: true, align: 'right'  /*, sortable: false, , edittype: "textarea", editoptions: { rows: "2", cols: "10"}*/ },
   		{ name: 'unit', index: 'unit', width: 60, editable: true, align: 'center', edittype: "select", editoptions: { value: "gl:กรัม; boal:ถ้วย"} },
   		{ name: 'discount', index: 'discount', width: 90, editable: true, align: 'right' },
   		{ name: 'vat', index: 'vat', width: 90, align: 'center', editable: true, edittype: "select", editoptions: { value: "ex:Exclude; in:Include; no:NoVAT"} },
   		{ name: 'totalPrice', index: 'totalPrice', width: 100, editable: false, align: 'right' }
   	],
        pager: '#pager',
        autowidth: true,
        height: 300,
        rowNum: 50,
        sortname: 'id',
        sortorder: 'desc',
        rowList: [50, 100, 200, 400],
        cellEdit: true,
        afterEditCell: function (rowid, cellname, value, iRow, iCol) {
            //alert('beforeeditcell');
            jQuery("#theGrid").jqGrid('setRowData', rowid, { code: "<input type='text' id='" + rowid + "_" + cellname + "' name='" + cellname + "' value='" + value + "' role='textbox' /> <input type='button' value='search' onclick=\"javascript:dialogSearchCode('"+ rowid +"', '" + cellname + "');\"/>" });
            //$("#" + rowid + "_" + cellname).focus();
        },
        /*onSelectRow: function (id) {
        if (id && id !== lastsel) {
        $(this).restoreRow(lastsel);
        lastsel = id;
        }
        //$(this).editRow(id, true);
        },*/
        viewrecords: true,
        cellurl: 'Inventory/DataXML/PourShaseDocumentXML.aspx?action=edit',
        editurl: 'Inventory/DataXML/PourShaseDocumentXML.aspx?action=edit',
        caption: 'รายการสินค้า'
    });
    jQuery("#theGrid").jqGrid('navGrid', '#pager', { edit: true, add: true, del: true });
    //        jQuery("#btnAdd").click(function () {
    //            jQuery("#theGrid").jqGrid('editGridRow', 'new');
    //        });
}

function dialogSearchCode(rowid, cellname) {
    //alert(rowid + ' ' + cellname);
    $("#boxSearchProduct").dialog({
        height: 520,
        width: 400,
        title: 'ค้นหาวัตถุดิบ',
        position: [500, 60],
        modal: false
    });

    $("#msearch").jqGrid({
        datatype: "xml",
        colNames: ['Material Code', 'Material Name'],
        colModel: [
   		{ name: 'mcode', index: 'mcode', width: 40 },
   		{ name: 'mname', index: 'mname', width: 100 }
   	],
        rowNum: 10,
        height: 290,
        autowidth: true,
        rowList: [10, 20, 30],
        pager: $('#mpager'),
        viewrecords: true,
        onSelectRow: function (rowidx) {
            var data = $(this).jqGrid().getRowData(rowidx);
            //alert(data.mcode);
            //$("#theGrid, #1_code").html("hello");
            //$("#theGrid").jqGrid('setRowData', rowid, {code: "<input type='text' id='" + rowid + "_" + cellname + "' name='" + cellname + "' value='" + data.mcode + "' role='textbox' /> <input type='button' value='search' onclick=\"javascript:dialogSearchCode('"+ rowid +"', '" + cellname + "');\"/>"});
        },
        caption: "Search Result"
    }).navGrid('#mpager', { edit: false, add: false, del: false });	
}

function materialData() {
    var materialCode = "";

    if ($("#txtMaterialCode").val() != "") {
        materialCode += $("#txtMaterialCode").val();
    }
    else {
        materialCode = "";
    }
    //alert(materialCode);
    $.ajax({
        url: 'Inventory/DataXML/SearchMaterial.aspx',
        cache: false,
        type: 'POST',
        datatype: 'xml',
        data: ({ code: materialCode }),
        complete: function (xhr, status) {
            //alert(xhr.responseText);
            var mgrid = jQuery("#msearch")[0];
            mgrid.addXmlData(xhr.responseXML);
        }
    });

    function get
}