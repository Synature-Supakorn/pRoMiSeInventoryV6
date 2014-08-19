<%@ page language="C#" autoeventwireup="true" inherits="Inventory_Vendors, App_Web_vendor.aspx.9758fd70" enableEventValidation="false" %>

<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendors</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/Default.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .table tr
        {
            margin: 2px 0;
        }
        .table td
        {
            margin: 0;
            padding: 2px 0;
            height: 22px;
        }
        .txt
        {
            padding: 2px;
            width: 168px;
        }
        .txtarea
        {
            width: 170px;
        }
        .style4
        {
            height: 44px;
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

    <script type="text/javascript">
        var maxVendorId = 0;
        var maxVendorGroupId = 0;

        // for edit grid
        var rowState = '';
        var currentRow = null;

        $(function() {
            $("#option_accordion").accordion({
                collapsible: true
            });

            //--dialog Add/Edit Vendor button
            $("#btnOkAddVendor").button({
                icons: {
                    primary: 'icon-btn-ok'
                }
            }).click(function() {
                if ($("#txtVendorCode").val() != "" && $("#txtVendorName").val() != "") {
                    $("#addVendorDialog").dialog('close');
                    addVendor();
                } else {
                    if ($("#txtVendorCode").val() == "")
                        $("#txtVendorCode").addClass('ui-state-error').select()
                    else if ($("#txtVendorName").val() == "")
                        $("#txtVendorName").addClass('ui-state-error').select();
                }
            });
            $("#btnCancelAddVendor").button({
                icons: {
                    primary: 'icon-btn-cancel'
                }
            }).click(function() {
                $("#addVendorDialog").dialog('close');
            });

            $("#btnOkEditVendor").button({
                icons: {
                    primary: 'icon-btn-ok'
                }
            }).click(function() {
                if ($("#txtVendorCode").val() != "" && $("#txtVendorName").val() != "") {
                    $("#addVendorDialog").dialog('close');
                    editVendor();
                } else {
                    if ($("#txtVendorCode").val() == "")
                        $("#txtVendorCode").addClass('ui-state-error').select()
                    else if ($("#txtVendorName").val() == "")
                        $("#txtVendorName").addClass('ui-state-error').select();
                }
            });
            $("#btnCancelEditVendor").button({
                icons: {
                    primary: 'icon-btn-cancel'
                }
            }).click(function() {
                $("#addVendorDialog").dialog('close');
            });
            // -------------------------

            // button Add/Edit vendor group
            $("#btnOkAddVendorGroup").button({
                icons: {
                    primary: 'icon-btn-ok'
                }
            }).click(function() {
                if ($("#txtVendorGroupCode").val() != "" && $("#txtVendorGroupName").val() != "") {
                    addVendorGroup();
                    $("#addVendorGroupDialog").dialog('close');
                } else {
                    if ($("#txtVendorGroupCode").val() == "")
                        $("#txtVendorGroupCode").addClass('ui-state-error').select();
                    else if ($("#txtVendorGroupName").val() == "")
                        $("#txtVendorGroupName").addClass('ui-state-error').select();
                }
            });

            $("#btnCancelAddVendorGroup").button({
                icons: {
                    primary: 'icon-btn-cancel'
                }
            }).click(function() {
                $("#addVendorGroupDialog").dialog('close');
            });


            $("#btnAddEditVendorGroup").button({
                icons: {
                    primary: 'icon-btn-vendorgroup'
                }
            }).click(function() {
                addEditVendorGroupDialog();
            });
            $("#btnAddVendor").button({
                icons: {
                    primary: 'icon-btn-add-vendor'
                }
            }).click(function() {
                getMaxVendorId();

                //debug
                //console.log('addVendor' + maxVendorId);
                addVendorDialog('add', maxVendorId);
            });
            /*$("#btnEditVendor").button({
            icons: {
            primary: 'icon-btn-edit-vendor'
            }
            }).click(function() {
            addVendorDialog('edit');
            });
            */

            $("#btnDelVendor").button({
                icons: {
                    primary: 'icon-btn-del-vendor'
                }
            }).click(function() {
                var theGrid = $("#theGrid");
                var selrow = theGrid.jqGrid('getGridParam', 'selrow');
                if (selrow != null) {
                    delGridRow(theGrid, selrow);
                }
                else {
                    alert("กรุณาเลือกรายการที่ท่านต้องการลบก่อน!");
                }
            });
            $("#btnAddVendorGroup").button({
                icons: {
                    primary: 'icon-btn-add-vendor'
                }
            }).click(function() {
                addVendorGroupDialog();
            });
            $("#btnEditVendorGroup").button({
                icons: {
                    primary: 'icon-btn-edit-vendor'
                }
            }).click(function() {
                $("#vendorGroupList").jqGrid('editGridRow', 1, { height: 280, reloadAfterSubmit: false });
            });
            $("#btnDelVendorGroup").button({
                icons: {
                    primary: 'icon-btn-del-vendor'
                }
            }).click(function() {
                var vendorGroupGrid = $("#vendorGroupList");
                var selrow = vendorGroupGrid.jqGrid('getGridParam', 'selrow');
                if (selrow != null) {
                    delVendorGroup(vendorGroupGrid, selrow)
                } else {
                    alert('กรุณาเลือกกลุ่มที่ต้องการลบ.');
                }
            });

            $("#slFilterVendorGroup").change(function() {
                var url;
                if ($("#slFilterVendorGroup :selected").val() == "1") {
                    url = 'DataXML/VendorsDataXML?action=loadVendorGroup&filter=inv' + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId;
                    $("#vendorGroupList").jqGrid('setGridParam', { url: url });
                    $("#vendorGroupList").jqGrid().trigger('reloadGrid');
                }
                else {
                    url = 'DataXML/VendorsDataXML?action=loadVendorGroup' +
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId;
                    $("#vendorGroupList").jqGrid('setGridParam', { url: url });
                    $("#vendorGroupList").jqGrid().trigger('reloadGrid');
                }
            });

            $('#<%=ddlAddEditVenderGroup.ClientID %>').change(function() {
                getMaxVendorId();
            });

            $('#<%=ddlVendorGroup.ClientID%>').change(function() {

                var vendorGroupParam = $('#<%=ddlVendorGroup.ClientID%>').val() != null ? $('#<%=ddlVendorGroup.ClientID%>').val().split('_') : [0, 0];
                var vGId = vendorGroupParam[0];
                var vGShopId = vendorGroupParam[1];
                $("#theGrid").jqGrid('setGridParam', { url: 'DataXML/VendorsDataXML.aspx?action=load&vgrid=' + vGId +
                    '&shopId=' + vGShopId +
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId
                });
                $("#theGrid").trigger('reloadGrid');

                getMaxVendorGroupId();
            });

            //-- call funtion create jqGrid
            getMaxVendorId();
            getMaxVendorGroupId();
            VendorList();
            VendorGroupAddEdit();
        });
        function addVendorDialog(mode, selRow) {
            // clear require field
            $("#txtVendorName").removeClass('ui-state-error');
            $("#txtVendorCode").removeClass('ui-state-error');
            
            //--dialog
            var title = '';
            switch (mode) {
                case 'add':
                    title = '<%=lbl_3_1.Text %>';
                    //$('#<%=ddlAddEditVenderGroup.ClientID %>').val($('#<%=ddlVendorGroup.ClientID %> :selected').val());
                    $("#dialogName").text(title);
                    $("#txtVendorId").val(maxVendorId);
                    $("#txtVendorCode").val('');
                    $("#txtVendorName").val('');
                    $("#txtContactName").val('');
                    $("#txtContactLastName").val('');
                    $("#txtAddress1").val('');
                    $("#txtAddress2").val('');
                    $("#txtAmphur").val('');
                    $("#txtZipCode").val('');
                    $("#txtPhone").val('');
                    $("#txtMobile").val('');
                    $("#txtFax").val('');
                    $("#txtEmail").val('');
                    $("#txtCreditExp").val('0');
                    $("#slDefaultTaxType").val(0);

                    $("#btnOkAddVendor").css('display', '');
                    $("#btnCancelAddVendor").css('display', '');
                    $("#btnOkEditVendor").css('display', 'none');
                    $("#btnCancelEditVendor").css('display', 'none');

                    if (maxVendorId > 0) {
                        $("#btnOkAddVendor").attr('disabled', false).removeClass('ui-state-disabled');
                    } else {
                        $("#btnOkAddVendor").attr('disabled', true).addClass('ui-state-disabled');
                    }

                    $("#addVendorDialog").dialog({
                        dialogClass: 'dialogWithDropShadow',
                        title: title,
                        width: 860,
                        modal: true,
                        resizable: false
                    });
                    break;
                case 'edit':
                    title = '<%=lbl_3_2.Text %>';
                    $("#dialogName").text(title);

                    var gridData = $("#theGrid").jqGrid('getRowData', selRow);
                    if (selRow == null)
                        gridData = $("#theGrid").jqGrid('getRowData', 1);

                    //debug
                    //console.log('Edit vendor at vendorid ' + gridData.vendorId + ' vendorgroupid ' + gridData.vendorGroupId + ' TT_TT..>_<" ');

                    //$('#<%=ddlAddEditVenderGroup.ClientID %>').val($('#<%=ddlVendorGroup.ClientID %> :selected').val());
                    $("#txtVendorId").val(gridData.vendorId);
                    $("#txtVendorCode").val(gridData.vendorcode);
                    $("#txtVendorName").val(gridData.vendorname);
                    $("#txtContactName").val(gridData.contactname);
                    $("#txtContactLastName").val(gridData.vendorlastname);
                    $('#<%=ddlAddEditVenderGroup.ClientID %>').val(gridData.vendorGroupId + '_' + gridData.shopId);
                    $("#txtAddress1").val(gridData.addr1);
                    $("#txtAddress2").val(gridData.addr2);
                    $("#txtAmphur").val(gridData.city);
                    $('#<%=ddlProvince.ClientID %>').val(gridData.province);
                    $("#txtZipCode").val(gridData.zipCode);
                    $("#txtPhone").val(gridData.tel);
                    $("#txtMobile").val(gridData.mobile);
                    $("#txtFax").val(gridData.fax);
                    $("#txtEmail").val(gridData.email);
                    $("#txtCreditExp").val(gridData.creditExp);
                    $("#slPayType").val(gridData.payType);
                    $("#slDefaultTaxType").val(gridData.defaultTaxType);

                    $("#btnOkAddVendor").css('display', 'none');
                    $("#btnCancelAddVendor").css('display', 'none');
                    $("#btnOkEditVendor").css('display', '');
                    $("#btnCancelEditVendor").css('display', '');

                    $("#addVendorDialog").dialog({
                        dialogClass: 'dialogWithDropShadow',
                        title: title,
                        width: 860,
                        modal: true,
                        resizable: false
                    });
                    break;
                case 'view':
                    break;
            }
        }

        function addEditVendorGroupDialog() {
            $("#txtVendorGroupId").val(maxVendorGroupId);
            $("#addEditVendorGroupDialog").dialog({
                dialogClass: 'dialogWithDropShadow',
                width: 800,
                resizable: false,
                modal: true,
                draggable: false,
                close: function(event, ui) {
                    window.location = "Vendor.aspx?StaffId=" + page_var.staffId + '&StaffRoleID=' + page_var.staffRole + '&LangID=' + page_var.langId;
                }
            });
        }

        function searchVendor() {
            var vendorCode = $("#txtSearchVendorCode").val();
            var vendorName = $("#txtSearchVendorName").val();
            var vendorGroupParam = $('#<%=ddlVendorGroup.ClientID%>').val() != null ? $('#<%=ddlVendorGroup.ClientID%>').val().split('_') : [0, 0];
            var vGId = vendorGroupParam[0];
            var vGShopId = vendorGroupParam[1];

            $("#theGrid").jqGrid('setGridParam', { url: 'DataXML/VendorsDataXML.aspx?action=load&vgrid=' + vGId +
                    '&shopId=' + vGShopId + '&vendorCode=' + vendorCode + '&vendorName=' + vendorName +
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId
            }).trigger('reloadGrid');
        }

        function VendorList(vGId, vGShopId) {
            $("#theGrid").jqGrid({
                url: 'DataXML/VendorsDataXML.aspx?action=load&vgrid=' + vGId +
                    '&shopId=' + vGShopId +
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId,
                datatype: 'xml',
                colNames: [$('#<%=lbl_4_1.ClientID %>').text(), $('#<%=lbl_4_2.ClientID %>').text(), $('#<%=lbl_4_3.ClientID %>').text(), $('#<%=lbl_4_4.ClientID %>').text(), $('#<%=lbl_4_5.ClientID %>').text(), $('#<%=lbl_4_6.ClientID %>').text(), 'VAT', $('#<%=lbl_4_7.ClientID %>').text(), $('#<%=lbl_4_8.ClientID %>').text(), 'vendorId',
                'vendorGroupId', 'addr1', 'addr2', 'city', 'province', 'zipCode', 'mobile', 'fax', 'email', 'creditExp', 'payType', 'vendorlastname', 'shopId'],
                colModel: [{ name: 'id', index: 'idx', width: 20, sortable: false, align: 'right' },
                { name: 'vendorcode', index: 'vc', width: 50 },
                { name: 'vendorname', index: 'vn', width: 90 },
                { name: 'vendorgroup', index: 'vg', width: 80 },
                { name: 'contactname', index: 'cn', width: 100 },
                { name: 'tel', index: 'telx', width: 60 },
                { name: 'defaultTaxType', width:40, hidden:true},
                { name: 'inv', index: 'invx', width: 40 },
                { name: 'act', index: 'act', align: 'center', width: 70 },
                { name: 'vendorId', index: 'vendorId', hidden: true },
                { name: 'vendorGroupId', index: 'vendorGroupId', hidden: true },
                { name: 'addr1', index: 'addr1', hidden: true },
                { name: 'addr2', index: 'addr2', hidden: true },
                { name: 'city', index: 'city', hidden: true },
                { name: 'province', index: 'province', hidden: true },
                { name: 'zipCode', index: 'zipCode', hidden: true },
                { name: 'mobile', index: 'mobile', hidden: true },
                { name: 'fax', index: 'fax', hidden: true },
                { name: 'email', index: 'email', hidden: true },
                { name: 'creditExp', index: 'creditExp', hidden: true },
                { name: 'payType', index: 'payType', hidden: true },
                { name: 'vendorlastname', index: 'contactlastname', hidden: true },
                { name: 'shopId', index: 'shopId', hidden: true }
                ],
                emptyrecords: '',
                pager: '#pager',
                rowNum: 100000,
                pgbuttons: false,
                pgtext: null,
                autowidth: true,
                height: 400,
                ondblClickRow: function(rowId, iRow, iCol, e) {
                    addVendorDialog("edit", rowId);
                },
                caption: '<%=lbl_1_24.Text %>',
                gridComplete: function() {
                    var dbShopId = page_var.dbShopId;
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        be = '<input type="button" id="be_' + ids[i] + '" value="<%=lbl_2_13.Text %>" onclick="addVendorDialog(\'edit\', ' + ids[i] + ');" />';
                        bd = '<input type="button" id="bd_' + ids[i] + '" value="<%=lbl_2_14.Text %>" onclick="delGridRow(\'#theGrid\', ' + ids[i] + ');" />';

                        //if(dbShopId == $(this).jqGrid('getRowData', ids[i]).shopId)
                        $(this).jqGrid('setRowData', ids[i], { act: be + '&nbsp;' + bd });
                    }
                    //alert($(this).jqGrid('getGridParam', 'records'));
                    if ($(this).jqGrid('getGridParam', 'records') == 1000) {
                        //alert($(this).jqGrid('getGridParam', 'records'));
                        $(this).jqGrid('setCaption', '<%=lbl_1_24.Text %> Limit 1000 rows');
                    } else {
                        $(this).jqGrid('setCaption', '<%=lbl_1_24.Text %>');
                    }
                }, loadComplete: function(data) {
                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";
                }
            });
            //-- จัดการ page
            $("#theGrid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false, refresh: false }); /*.navButtonAdd('#pager', {
                caption: "ลบข้อมูล",
                buttonicon: "ui-icon-trash",
                onClickButton: function () {
                    var theGrid = $("#theGrid").jqGrid('getGridParam', 'selrow');
                    if (theGrid != null) {
                        delGridRow('theGrid', theGrid);
                    }
                    else {
                        alert("กรุณาเลือกแถวที่ท่านต้องการลบก่อน!");
                    }
                },
                position: "last"
            }).navButtonAdd('#pager', {
                caption: "แก้ไขข้อมูล",
                buttonicon: "ui-icon-pencil",
                onClickButton: function () {
                    addVendorDialog('edit');
                },
                position: "first"
            }).navButtonAdd('#pager', {
                caption: "เพิ่มข้อมูล",
                buttonicon: "ui-icon-plus",
                onClickButton: function () {
                    getMaxVendorId();
                    addVendorDialog('add');
                },
                position: "first"
            }); */
            //-- resize grid when resize browser
            $(window).bind('resize', function () {
                $("#theGrid").setGridWidth($(window).width() - 15);
            }).trigger('resize');
        }

        // Add/Edit VendorGroup Func
        function addVendorGroupDialog() {
            $("#txtVendorGroupCode").val('').removeClass('ui-state-error');
            $("#txtVendorGroupName").val('').removeClass('ui-state-error');
            
            getMaxVendorGroupId();
            $("#addVendorGroupDialog").dialog({
                dialogClass: 'dialogWithDropShadow',
                width: 300,
                modal: true,
                resizable: false,
                draggable: false,
                close: function (event, ui) {
                //window.location = "Vendor.aspx?StaffID=" + page_var.staffId + '&StaffRoleID=' + page_var.staffRole + '&LangID=' + page_var.langId;
                }
            });
        }

        function VendorGroupAddEdit() {

            $("#vendorGroupList").jqGrid({
                url: 'DataXML/VendorsDataXML.aspx?action=loadVendorGroup' + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId,
                datatype: 'xml',
                colNames: [$('#<%=lbl_4_9.ClientID %>').text(), 'vGroupId', $('#<%=lbl_4_10.ClientID %>').text(), $('#<%=lbl_4_11.ClientID %>').text(), $('#<%=lbl_4_12.ClientID %>').text(), $('#<%=lbl_4_13.ClientID %>').text(), 'shopId', ''],
                colModel: [{ name: 'id', index: 'id', width: 30, sortable:false },
                { name: 'vGroupId', index: 'vGroupId', hidden: true },
                { name: 'vendorGroupCode', index: 'vendorGroupCode', width: 180, editable: true },
                { name: 'vendorGroupName', index: 'vendorGroupName', width: 290, editable: true },
                { name: 'invname', index: 'invname', width: 150, align: 'center' },
                { name: 'act', index: 'act', width: 120, align: 'center' },
                { name: 'shopId', hidden: true },
                { name: 'spacer', width:10 }
                ],
                pager: '#vendorGroupListpager',
                rowNum: -1,
                pgbuttons: false,
                pgtext: null,
                autowidth: true,
                height: 300,
                gridComplete: function() {
                    var ids = $("#vendorGroupList").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        //alert(gridData.procode);
                        var cl = ids[i];
                        //console.log(cl);
                        var be = '<input type="button" style="" id="btnE_' + cl + '" onclick="if(rowState != \'editing\') {$(\'#vendorGroupList\').jqGrid(\'editRow\', ' + cl + ', false, oneditfunc, succesfunc, \'clientArray\', {}, aftersavefunc, errorfunc, afterrestorefunc);}" value="<%=lbl_2_13.Text %>"/>';
                        var se = '<input type="button" style="display:none; margin:0 4px;" id="btnS_' + cl + '" onclick="editVendorGroup(' + cl + ');" value="<%=lbl_2_15.Text %>" />';
                        var ce = '<input type="button" style="display:none;" id="btnC_' + cl + '" onclick="rowState=\'\'; $(\'#vendorGroupList\').jqGrid().trigger(\'reloadGrid\');" value="<%=lbl_2_16.Text %>"/>';
                        var bd = '<input type="button" id="btnD_' + ids[i] + '" value="<%=lbl_2_14.Text %>" onclick="delVendorGroup(\'#vendorGroupList\', ' + ids[i] + ');" />';
                        $("#vendorGroupList").jqGrid('setRowData', ids[i], { act: be + '&nbsp;' + se + '&nbsp;' + ce + '&nbsp;' + bd });
                        $("#vendorGroupList").setCell(ids[i], 'act', '', '', { title: 'แก้ไขข้อมูล' });
                    }
                }, loadComplete: function(data) {

                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";
                },
                caption: ''
            });

            //-- จัดการ page
            $("#vendorGroupList").jqGrid('navGrid', '#vendorGroupListpager', { edit: false, add: false, del: false, search: false, refresh: false }); /*.navButtonAdd('#vendorGroupListpager', {
                caption: "ลบข้อมูล",
                buttonicon: "ui-icon-trash",
                onClickButton: function () {
                    var VendorGroupList = $("#vendorGroupList").jqGrid('getGridParam', 'selrow');
                    if (VendorGroupList != null) $("#vendorGroupList").jqGrid('delGridRow', VendorGroupList, {
                        bSubmit: 'ลบ', bCancel: 'ยกเลิก', msg: 'ต้องการลบข้อมูล แน่ใจหรือไม่', caption: 'ลบข้อมูล',
                        url: 'DataXML/VendorsDataXML.aspx?action=delVendorGroup', reloadAfterSubmit: true
                    });
                    else alert("กรุณาเลือกแถวที่ท่านต้องการลบก่อน!");
                },
                position: "last"
            }).navButtonAdd('#vendorGroupListpager', {
                caption: "แก้ไขข้อมูล",
                buttonicon: "ui-icon-pencil",
                onClickButton: function () {
                    addVendorDialog('edit');
                },
                position: "first"
            }).navButtonAdd('#vendorGroupListpager', {
                caption: "เพิ่มข้อมูล",
                buttonicon: "ui-icon-plus",
                onClickButton: function () {
                    getMaxVendorId();
                    addVendorDialog('add');
                },
                position: "first"
            }); */
        }

        // Add Edit Vendor Function
        function getMaxVendorId() {
            var vendorGroupParam = $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val() != null ? $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val().split('_') : [0, 0];
            var vGId = vendorGroupParam[0];
            var vGShopId = vendorGroupParam[1];
            $.ajax({
            url: 'DataXML/VendorsDataXML.aspx?action=getMaxVendorId&vgrid=' + vGId +
                '&shopId=' + vGShopId + 
                '&staffId=' + page_var.staffId + '&langId=' + page_var.langId,
                type: 'GET',
                complete: function (xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.maxVendorId);
                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    maxVendorId = data.maxVendorId;
                    $("#txtVendorId").val(data.maxVendorId);
                    if (maxVendorId > 0) {
                        $("#btnOkAddVendor").attr('disabled', false).removeClass('ui-state-disabled');
                    } else {
                        $("#btnOkAddVendor").attr('disabled', true).addClass('ui-state-disabled');
                    }
                }
            });
        }

        function getMaxVendorGroupId() {
            $.ajax({
                url: 'DataXML/VendorsDataXML.aspx?action=getMaxVendorGroupId' + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId,
                type: 'GET',
                complete: function(xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");
                    //alert(data.maxVendorId);
                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";
                    maxVendorGroupId = data.maxVendorGroupId;
                    $("#txtVendorGroupId").val(maxVendorGroupId);
                }
            });
        }

        function addVendorGroup() {
            $.ajax({
                url: 'DataXML/VendorsDataXML.aspx?action=addVendorGroup' + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId,
                data: ({ txtVendorGroupId: $("#txtVendorGroupId").val(), txtVendorGroupCode: $("#txtVendorGroupCode").val(),
                    txtVendorGroupName: $("#txtVendorGroupName").val()
                }),
                type: 'POST',
                complete: function (xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");

                    //if (data.sess_timeout && data.sess_timeout == 1)
                       // window.location = "vendor.aspx?staffId=" + page_var.staffId + '&StaffRoleID=' + page_var.staffRole + '&langId=' + page_var.langId;
                    
                    alert('<%=lbl_3_8.Text %>');
                    $("#vendorGroupList").jqGrid().trigger('reloadGrid');
                    //window.location = "Vendor.aspx?staffId=" + page_var.staffId + '&StaffRoleID=' + page_var.staffRole + '&langId=' + page_var.langId;
                }
            });
        }

        function editVendorGroup(gridRowId) {
            if ($("#" + gridRowId + "_vendorGroupCode").val() != "" &&
                $("#" + gridRowId + "_vendorGroupName").val() != "") {
                var gridData = $("#vendorGroupList").jqGrid('getRowData', gridRowId);
                $.ajax({
                    url: 'DataXML/VendorsDataXML.aspx?action=editVendorGroup' + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId,
                    data: ({ txtVendorGroupId: gridData.vGroupId,
                        txtVendorGroupCode: $("#" + gridRowId + "_vendorGroupCode").val(),
                        txtVendorGroupName: $("#" + gridRowId + "_vendorGroupName").val()
                    }),
                    type: 'POST',
                    complete: function(xhr, status) {
                        var data = eval("(" + xhr.responseText + ")");

                        //if (data.sess_timeout && data.sess_timeout == 1)
                        //    window.location = "vendor.aspx?staffId=" + page_var.staffId + '&StaffRoleID=' + page_var.staffRole + '&langId=' + page_var.langId;

                        alert('<%=lbl_3_7.Text %>');
                        $("#vendorGroupList").jqGrid().trigger('reloadGrid');
                        // window.location = "Vendor.aspx?staffId=" + page_var.staffId + '&StaffRoleID=' + page_var.staffRole + '&langId=' + page_var.langId;
                        rowState = "";
                    }
                });
            } else {
                if ($("#" + gridRowId + "_vendorGroupCode").val() == "")
                    $("#" + gridRowId + "_vendorGroupCode").addClass('ui-state-error').select();
                else if($("#" + gridRowId + "_vendorGroupName").val() == "")
                    $("#" + gridRowId + "_vendorGroupName").addClass('ui-state-error').select();
            }
        }

        function addVendor() {
            var vendorGroupParam = $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val() != null ? $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val().split('_') : [0, 0];
            var vGId = vendorGroupParam[0];
            var vGShopId = vendorGroupParam[1];
            
            $.ajax({
                url: 'DataXML/VendorsDataXML.aspx?action=add&staffId=' + page_var.staffId + '&staffRole=' + page_var.staffRole + '&langId=' + page_var.langId,
                data: ({ txtVendorId: $("#txtVendorId").val(), txtVendorName: $("#txtVendorName").val(), txtContactName: $("#txtContactName").val(),
                    txtAddress1: $("#txtAddress1").val(), txtAddress2: $("#txtAddress2").val(), txtZipCode: $("#txtZipCode").val(),
                    txtPhone: $("#txtPhone").val(), txtMobile: $("#txtMobile").val(), slPayType: $("#slPayType :selected").val(),
                    ddlAddEditVenderGroup: vGId, txtVendorCode: $("#txtVendorCode").val(),
                    txtContactLastName: $("#txtContactLastName").val(), txtAmphur: $("#txtAmphur").val(),
                    ddlProvince: $('#<%=ddlProvince.ClientID %> :selected').val(), txtFax: $("#txtFax").val(), txtEmail: $("#txtEmail").val(),
                    txtCreditExp: $("#txtCreditExp").val(), shopId: vGShopId, defaultTaxType: $("#slDefaultTaxType :selected").val()
                }),
                type: 'POST',
                complete: function(xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");

                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    alert('<%=lbl_3_8.Text %>');
                    $("#theGrid").jqGrid().trigger('reloadGrid');
                }
            });
        }
        function editVendor() {
            var vendorGroupParam = $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val() != null ? $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val().split('_') : [0, 0];
            var vGId = vendorGroupParam[0];
            var vGShopId = vendorGroupParam[1];
            
            $.ajax({
                url: 'DataXML/VendorsDataXML.aspx?action=edit&staffId=' + page_var.staffId + '&staffRole=' + page_var.staffRole + '&langId=' + page_var.langId,
                data: ({ txtVendorId: $("#txtVendorId").val(), txtVendorName: $("#txtVendorName").val(), txtContactName: $("#txtContactName").val(),
                    txtAddress1: $("#txtAddress1").val(), txtAddress2: $("#txtAddress2").val(), txtZipCode: $("#txtZipCode").val(),
                    txtPhone: $("#txtPhone").val(), txtMobile: $("#txtMobile").val(), slPayType: $("#slPayType :selected").val(),
                    ddlAddEditVenderGroup: vGId, txtVendorCode: $("#txtVendorCode").val(),
                    txtContactLastName: $("#txtContactLastName").val(), txtAmphur: $("#txtAmphur").val(),
                    ddlProvince: $('#<%=ddlProvince.ClientID %> :selected').val(), txtFax: $("#txtFax").val(), txtEmail: $("#txtEmail").val(),
                    txtCreditExp: $("#txtCreditExp").val(), shopId: vGShopId, defaultTaxType: $("#slDefaultTaxType :selected").val()
                }),
                type: 'POST',
                complete: function (xhr, status) {
                    var data = eval("(" + xhr.responseText + ")");

                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    alert('<%=lbl_3_7.Text %>');
                    $("#theGrid").jqGrid().trigger('reloadGrid');
                }
            });
        }

        function delGridRow(gridId, rowid) {
            var gridData = $(gridId).jqGrid('getRowData', rowid);
            $(gridId).jqGrid('delGridRow', rowid, {
                bSubmit: '<%=lbl_2_9.Text %>', bCancel: '<%=lbl_2_10.Text %>', msg: '<%=lbl_3_3.Text %>',
                caption: '<%=lbl_3_5.Text %>', zIndex: 1000, width: 300, top: 100, left: 500,
                url: 'DataXML/VendorsDataXML.aspx?action=delVendor&txtVendorID=' + gridData.vendorId + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId, reloadAfterSubmit: true
            });
        }

        function delVendorGroup(gridId, rowid) {
            var gridData = $(gridId).jqGrid('getRowData', rowid);
            $(gridId).jqGrid('delGridRow', rowid, {
                bSubmit: '<%=lbl_2_9.Text %>', bCancel: '<%=lbl_2_10.Text %>', msg: '<%=lbl_3_4.Text %>',
                caption: '<%=lbl_3_5.Text %>', zIndex: 5000, width: 300, top: 100, left: 500,
                url: 'DataXML/VendorsDataXML.aspx?action=delVendorGroup&txtVendorGroupId=' + gridData.vGroupId + '&shopId=' + gridData.shopId + 
                    '&staffId=' + page_var.staffId + '&langId=' + page_var.langId, reloadAfterSubmit: true
            });
        }

        // edit grid row
        function oneditfunc(rowId) {
            currentRow = rowId;
            //console.log(rowId);

            $("#" + currentRow + "_vendorGroupCode").removeClass('ui-state-error');
            $("#" + currentRow + "_vendorGroupName").removeClass('ui-state-error');
            
            $("#btnE_" + currentRow).css('display', 'none');
            $("#btnD_" + currentRow).css('display', 'none');
            $("#btnS_" + currentRow).css('display', '');
            $("#btnC_" + currentRow).css('display', '');
            rowState = 'editing';
        }

        function succesfunc() {
            alert('successfunc' + currentRow);
            rowState = "";
        }

        function aftersavefunc() {
            //var selRow = $("#websale_grid").jqGrid('getGridParam', 'selrow');
            //alert('aftersave' + currentRow);
            
            $("#btnE_" + currentRow).css('display', '');
            $("#btnD_" + currentRow).css('display', '');
            $("#btnS_" + currentRow).css('display', 'none');
            $("#btnC_" + currentRow).css('display', 'none');
            rowState = "";
        }

        function errorfunc() {
            alert('error');
        }

        function afterrestorefunc() {
            //alert('afterrestorefunc' + currentRow);

            $("#btnE_" + currentRow).css('display', '');
            $("#btnD_" + currentRow).css('display', '');
            $("#btnS_" + currentRow).css('display', 'none');
            $("#btnC_" + currentRow).css('display', 'none');
            rowState = "";
            return true;
        }

//        function getVendorGroupShopId2(callbackFunc) {
//            var vendorGroupParam = $('#<%=ddlVendorGroup.ClientID %> :selected').val().split('_');
//            var vGId = vendorGroupParam[0];
//            var vGShopId = vendorGroupParam[1];
//            $.ajax({
//                url: 'DataXML/VendorsDataXML.aspx?action=getVendorGroupShopId&vgrid=' +
//                 + vGId + '&shopId=' +  vGShopId,
//                type: 'json',
//                complete: function(xhr, status) {
//                    var vendorObj = eval('(' + xhr.responseText + ')');
//                    vendorGroupShopId = vendorObj.ShopId;
//                    //alert(JSON.stringify(vendorObj));
//                    callbackFunc();
//                }
//            });
//        }
//        
//        function getVendorGroupShopId(callbackFunc) {
//            $.ajax({
//                url: 'DataXML/VendorsDataXML.aspx?action=getVendorGroupShopId&vgrid=' +
//                $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').val() +
//                '&vendorGroupName=' + $('#<%=ddlAddEditVenderGroup.ClientID %> :selected').text(),
//                type: 'json',
//                complete: function(xhr, status) {
//                    var vendorObj = eval('(' + xhr.responseText + ')');
//                    vendorGroupShopId = vendorObj.ShopId;
//                    //alert(JSON.stringify(vendorObj));
//                    callbackFunc();
//                }
//            });
//        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="display:none;" id="page_var" runat="server"></div>
    <div>
        <div class="ui-widget ui-widget-header" style="height: 30px; padding: 4px 10px;">
            <div style="float: left; font-size: 14px;">
                <div class="icon-vendors" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
                </div>
                <div style="float: left;">
                    <div style="height: 4px; margin-top: 4px;">
                        &nbsp;</div>
                    <div style="margin: 2px;">
                        <asp:Label ID="lbl_1_1" runat="server" Text="ผู้จัดจำหน่ายวัตถุดิบ"></asp:Label></div>
                </div>
            </div>
            <div style="float: right;">
                <button id="btnAddVendor" type="button" class="btn">
                    <asp:Label ID="lbl_2_1" runat="server" Text="เพิ่มผู้จัดจำหน่าย"></asp:Label>
                </button>
                <button id="btnAddEditVendorGroup" type="button" class="btn">
                    <asp:Label ID="lbl_2_2" runat="server" Text="กลุ่มผู้จัดจำหน่าย"></asp:Label>
                </button>
            </div>
            <div class="clear">
                &nbsp;</div>
        </div>
        <div id="content">
            <div class="panel">
                <div class="ui-widget-content" style="margin: 4px 0;">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tbody>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_2" runat="server" Text="กลุ่มผู้จัดจำหน่าย"></asp:Label>
                                </td>
                                <td width="200">
                                    <asp:DropDownList ID="ddlVendorGroup" runat="server" Style="width: 200px; padding: 1px 0;">
                                    </asp:DropDownList>
                                   
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_22" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtSearchVendorCode" />
                                    
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_23" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtSearchVendorName" />
                                    <button type="button" id="btnSearchVendor" onclick="searchVendor();">Search</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <button id="btnEditVendor" type="button" class="btn" style="display: none;">
                        <asp:Label ID="lblBtnEditVendor" runat="server" Text="แก้ไขข้อมูลผู้จัดจำหน่าย"></asp:Label>
                    </button>
                    <button id="btnDelVendor" type="button" class="btn" style="display: none;">
                        <asp:Label ID="lblBtnDelVendor" runat="server" Text="ลบข้อมูลผู้จัดจำหน่าย"></asp:Label>
                    </button>
                </div>
            </div>
            <div style="margin: 4px 2px;">
                <table id="theGrid" class="scroll">
                </table>
                <div id="pager" class="scroll">
                </div>
            </div>
            <div style="text-align: center">
                <uc1:Footer ID="Footer1" runat="server" />
            </div>
            <!-- dialog add vendor -->
            <div id="addVendorDialog" style="display: none; overflow: hidden; font-family: Segoe UI, Tahoma, Arial;">
                <!-- head box -->
                <div class="ui-widget ui-widget-content" style="height: 30px; padding: 8px 4px 4px 10px;
                    border-bottom: none;">
                    <h1>
                        <span id="dialogName"></span>
                    </h1>
                    <div style="clear: both; height: 1px; border-bottom: 1px #ccc solid">
                        &nbsp;</div>
                </div>
                <!-- body box -->
                <div class="ui-widget-content" style="border-top: none; font-size: 1.1em;">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tbody>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_3" Text="ลำดับ" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtVendorId" readonly="readonly" disabled="disabled" style="width: 70px;
                                        color: #000;" class="ui-state-disabled" />
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_4" runat="server" Text="กลุ่มผู้จัดจำหน่าย"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlAddEditVenderGroup" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_6" Text="รหัสผู้จัดจำหน่าย" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtVendorCode" class="txt" />
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_7" runat="server" Text="ชื่อผู้ติดต่อ"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtContactName" class="txt" />
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_5" runat="server" Text="ชื่อผู้จัดจำหน่าย"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtVendorName" class="txt" />
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_8" runat="server" Text="นามสกุล"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtContactLastName" class="txt" />
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_9" runat="server" Text="ที่อยู่ 1"></asp:Label>
                                </td>
                                <td>
                                    <textarea id="txtAddress1" rows="3" cols="40" class="txtarea"></textarea>
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_10" runat="server" Text="อำเภอ"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtAmphur" class="txt" />
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_11" runat="server" Text="ที่อยู่ 2"></asp:Label>
                                </td>
                                <td>
                                    <textarea id="txtAddress2" rows="3" cols="40" class="txtarea"></textarea>
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_12" runat="server" Text="จังหวัด"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlProvince" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_13" runat="server" Text="รหัสไปรษณีย์"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtZipCode" class="txt" />
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_14" runat="server" Text="แฟกซ์"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtFax" class="txt" />
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_15" runat="server" Text="โทรศัพท์"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtPhone" class="txt" />
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_16" runat="server" Text="อีเมล์"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtEmail" class="txt" />
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_17" runat="server" Text="มือถือ"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtMobile" class="txt" />
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_vendor_vattype" Text="VAT" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <select id="slDefaultTaxType">
                                        <option value="0">No VAT</option>
                                        <option value="2">Include</option>
                                        <option value="1">Exclude</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_18" runat="server" Text="การชำระเงิน"></asp:Label>
                                </td>
                                <td>
                                    <select id="slPayType">
                                        <option value="1">
                                            <asp:Label ID="lbl_2_3" runat="server" Text="เงินสด"></asp:Label></option>
                                        <option value="2">
                                            <asp:Label ID="lbl_2_4" runat="server" Text="เครดิต"></asp:Label></option>
                                    </select>
                                </td>
                                <td class="paramlist_key">
                                    <asp:Label ID="lbl_1_19" runat="server" Text="จำนวนวันเครดิต"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtCreditExp" value="0" class="txt" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div style="text-align: right; padding: 4px 0 4px 0;">
                    <button id="btnOkAddVendor" type="button" class="btn" style="display: none;">
                        <asp:Label ID="lbl_2_9" runat="server" Text="ตกลง"></asp:Label>
                    </button>
                    <button id="btnCancelAddVendor" type="button" class="btn" style="display: none;">
                        <asp:Label ID="lbl_2_10" runat="server" Text="ยกเลิก"></asp:Label>
                    </button>
                    <button id="btnOkEditVendor" type="button" class="btn" style="display: none;">
                        <asp:Label ID="lbl_2_11" runat="server" Text="ตกลง"></asp:Label>
                    </button>
                    <button id="btnCancelEditVendor" type="button" class="btn" style="display: none;">
                        <asp:Label ID="lbl_2_12" runat="server" Text="ยกเลิก"></asp:Label>
                    </button>
                </div>
            </div>
            <!-- addVendorGroup dialog -->
            <div style="display: none;" id="addEditVendorGroupDialog" title="<%=lbl_3_9.Text %>">
                <div style="padding: 4px;">
                    <div style="float: left; padding: 4px 0 0 0; display: none;">
                        <span class="ui-widget">
                            <asp:Label ID="lblSlFilterVendorGroup" runat="server" Text="แสดงผล"></asp:Label></span>
                        <select id="slFilterVendorGroup" style="width: 200px; padding: 1px 0; margin-right: 4px;">
                            <option value="0">
                                <asp:Label ID="lbl_2_5" runat="server" Text="ทุกกลุ่ม"></asp:Label></option>
                            <option value="1">
                                <asp:Label ID="lbl_2_6" runat="server" Text="สาขานี้เท่านั้น"></asp:Label></option>
                        </select>
                    </div>
                    <div style="float: right">
                        <button id="btnAddVendorGroup" type="button" class="btn">
                            <asp:Label ID="lbl_2_7" runat="server" Text="เพิ่มกลุ่ม"></asp:Label>
                        </button>
                        <!--<button id="btnEditVendorGroup" type="button" class="btn">
                        <asp:Label ID="lblBtnEditVendorGroup" runat="server" Text="แก้ไขกลุ่ม"></asp:Label>
                    </button>-->
                        <button id="btnDelVendorGroup" type="button" class="btn" style="display: none;">
                            <asp:Label ID="lbl_2_8" runat="server" Text="ลบกลุ่ม"></asp:Label>
                        </button>
                    </div>
                    <div style="clear: both; height: 1px;">
                        &nbsp;</div>
                </div>
                <div>
                    <table id="vendorGroupList">
                    </table>
                    <div id="vendorGroupListpager">
                    </div>
                </div>
            </div>
            <div style="display: none;" id="addVendorGroupDialog" title="<%=lbl_3_6.Text %>">
                <div>
                </div>
                <div>
                    <div style="margin: 4px;">
                        <div style="float: left; width: 120px; padding-top: 4px;">
                            ID</div>
                        <div style="float: left;">
                            <input type="text" id="txtVendorGroupId" disabled="disabled" style="width: 70px;"
                                class="ui-state-disabled" />
                        </div>
                        <div style="clear: both; height: 1px;">
                            &nbsp;</div>
                    </div>
                    <div style="margin: 4px;">
                        <div style="float: left; width: 120px; padding-top: 4px;">
                            <asp:Label ID="lbl_1_20" runat="server" Text="รหัสกลุ่มผู้จัดจำหน่าย"></asp:Label></div>
                        <div style="float: left;">
                            <input type="text" id="txtVendorGroupCode" />
                        </div>
                        <div style="clear: both; height: 1px;">
                            &nbsp;
                        </div>
                    </div>
                    <div style="margin: 4px;">
                        <div style="float: left; width: 120px; padding-top: 4px;">
                            <asp:Label ID="lbl_1_21" runat="server" Text="ชื่อกลุ่มผู้จัดจำหน่าย"></asp:Label></div>
                        <div style="float: left;">
                            <input type="text" id="txtVendorGroupName" />
                        </div>
                        <div style="clear: both; height: 1px;">
                            &nbsp;</div>
                    </div>
                </div>
                <div style="margin: 4px; text-align: right; border-top: #ccc 1px solid; padding-top: 4px;">
                    <button id="btnOkAddVendorGroup" type="button">
                        Ok</button>&nbsp;
                    <button id="btnCancelAddVendorGroup" type="button">
                        Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <asp:Label ID="lbl_1_24" runat="server" Style="display: none;"></asp:Label>
    <!-- for btn -->
    <asp:Label ID="lbl_2_13" runat="server" Text="แก้ไข" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_2_14" runat="server" Text="ลบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_2_15" runat="server" Text="บันทึก" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_2_16" runat="server" Text="ยกเลิก" Style="display: none;"></asp:Label>
    <!-- for alert -->
    <asp:Label ID="lbl_3_1" runat="server" Text="เพิ่มผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_2" runat="server" Text="แก้ไขผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_3" runat="server" Text="คุณกำลังจะลบ ผู้จัดจำหน่าย แน่ใจหรือไม่ ?"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_4" runat="server" Text="คุณกำลังจะลบ กลุ่มผู้จัดจำหน่าย แน่ใจหรือไม่ ?"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_5" runat="server" Text="ลบข้อมูล" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_6" runat="server" Text="เพิ่มกลุ่มผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_7" runat="server" Text="แก้ไขข้อมูลผู้จัดจำหน่ายวัตถุดิบสำเร็จ"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_8" runat="server" Text="เพิ่มข้อมูลผู้จัดจำหน่ายสำเร็จ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_9" runat="server" Text="กลุ่มผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <!-- for colmodel -->
    <asp:Label ID="lbl_4_1" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_2" runat="server" Text="รหัสผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_3" runat="server" Text="ชื่อผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_4" runat="server" Text="กลุ่มผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_5" runat="server" Text="ชื่อผู้ติดต่อ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_6" runat="server" Text="โทรศัพท์" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_7" runat="server" Text="คลัง" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_8" runat="server" Text="แก้ไข" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_9" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_10" runat="server" Text="รหัสผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_11" runat="server" Text="ชื่อผู้จัดจำหน่าย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_12" runat="server" Text="คลัง" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_13" runat="server" Text="แก้ไข" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_14" runat="server" Text="แก้ไข" Style="display: none;"></asp:Label>
    </form>
</body>
</html>
