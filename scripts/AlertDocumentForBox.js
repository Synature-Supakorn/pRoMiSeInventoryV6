        var maintab = null;
        var inventoryName1 = 'ddlInv';
        var inventoryName2 = 'ddlFromInv';
        var langID;
        $(function () {
            langID = $.getUrlVar('LangID');
            noneApproveDocGrid();
            newWorkingDocGrid();        
            SearchNotApproveDocument();
            SearchDocumentFromOtherInventory();  
            $("#btnRefresh").button({
                icons: { primary: 'ui-icon-refresh' }, text: true
            });

        });

        function noneApproveDocGrid() {
            $("#noneApproveDocGrid").jqGrid({
                //url: '',
                datatype: 'xml',
                colNames: ['#', 'ประเภทเอกสาร', 'เลขที่เอกสาร', 'วันที่สร้าง'],
                colModel: [
                { name: 'Id', index: 'Id', width: 30, align: 'center' },
                { name: 'DocumentTypeName', index: 'DocumentTypeName', width: 100 },
                { name: 'DocumentNumber', index: 'DocumentNumber', width: 500 },
                { name: 'DocumentDate', index: 'DocumentDate', width: 100 }
                ],
                pager: '#noneApproveDocPager',
                rowNum: -1,
                pgbuttons: false,
                pgtext: null,
                height: 120,
                autowidth: true,
                grouping: true,
                groupingView: {
                    groupField: ['DocumentTypeName'],
                    groupColumnShow: [false],
                    groupCollapse : true
                },
                 
            }).jqGrid('navGrid', '#noneApproveDocPager', { edit: false, add: false, del: false, search: false, refresh: true });
            $(window).bind('resize', function () {
                $("#noneApproveDocGrid").setGridWidth($(window).width() - 28);
            }).trigger('resize');
        }

        function newWorkingDocGrid() {
            $("#newWorkingDocGrid").jqGrid({
                url: '?',
                datatype: 'xml',
                 colNames: ['#', 'ประเภทเอกสาร', 'เลขที่เอกสาร','จากคลัง', 'วันที่สร้าง'],
                colModel: [
                { name: 'Id', index: 'Id', width: 30, align: 'center' },
                { name: 'DocumentTypeName', index: 'DocumentTypeName', width: 100 },
                { name: 'DocumentNumber', index: 'DocumentNumber', width: 500 },
                { name: 'FromInventoryName', index: 'FromInventoryName', width: 100 },                
                { name: 'DocumentDate', index: 'DocumentDate', width: 100 }
                ],
                pager: '#noneApproveDocPager',
                rowNum: -1,
                pgbuttons: false,
                pgtext: null,
                height: 120,
                autowidth: true,
                grouping: true,
                groupingView: {
                    groupField: ['DocumentTypeName'],
                    groupColumnShow: [false],
                    groupCollapse : true
                },
                
            }).jqGrid('navGrid', '#newWorkingDocPager', { edit: false, add: false, del: false, search: false, refresh: true });
            $(window).bind('resize', function () {
                $("#newWorkingDocGrid").setGridWidth($(window).width() - 28);
            }).trigger('resize');
        }

        //======================================================== ค้นหาเอกสาร ============================================//
        function SearchNotApproveDocument() {
            $.ajax({
                url: 'DataXML/DocumentInboxXML.aspx?action=searchNotAppDoc',
                cache: false,
                type: 'POST',
                datatype: 'xml',
                complete: function (xhr, status) {
                    var appgrid = $("#noneApproveDocGrid")[0];
                    appgrid.addXmlData(xhr.responseXML);
                }
            });

        }
        function SearchDocumentFromOtherInventory() {
            $.ajax({
                url: 'DataXML/DocumentInboxXML.aspx?action=searchDocFromOther',
                cache: false,
                type: 'POST',
                datatype: 'xml',              
                complete: function (xhr, status) {
                    // alert(xhr.responseText);
                    var xgrid = $("#newWorkingDocGrid")[0];
                    xgrid.addXmlData(xhr.responseXML);
                }
            });

        }
        //======================================================== ฟังก์ชันในการสร้าง Tab ============================================//
        function AddTabWorkingDocument(tabId,tabName,url) {
              parent.addTab(tabId, tabName, url);
         }
       
        //======================================================== จำนวนเอกสารที่ยังไม่ Approve ============================================//
        function ShowSumdocumentNotApprove() {
            $.ajax({
                url: 'DataXML/DocumentInboxXML.aspx?action=SumNotAppDoc',
                cache: false,
                datatype: 'json',
                type: 'GET',
                complete: function (xhr, status) {
                    // alert(xhr.responseText);
                    if (status == 'success') {
                        var data = eval("(" + xhr.responseText + ")");
                        $('#lblNoneApproveDocResult').html(data.Amount)
                    } else {
                        var data = eval("(" + xhr.responseText + ")");
                        MessageError(data.strResultText);
                    }
                }

            });
        }
        //======================================================== จำนวนเอกสารที่มาจากคลังอื่น ============================================//
        function ShowSumdocumentOtherInventory() {
            $.ajax({
                url: 'DataXML/DocumentInboxXML.aspx?action=SumDocFromOther',
                cache: false,
                datatype: 'json',
                type: 'GET',
                complete: function (xhr, status) {
                   if (status == 'success') {
                        var data = eval("(" + xhr.responseText + ")");
                        $('#lblNewWorkingDoc').html(data.Amount)
                    } else {
                        var data = eval("(" + xhr.responseText + ")");
                        MessageError(data.strResultText);
                    }
                }

            });
        }

