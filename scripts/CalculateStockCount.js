function setMatCountToGrid() {
    //alert('setmaterial');
    var countAmount = $("#txtCountAmount").val();
    var remainAmount = $("#txtMatRemainAmount").val();
    var grid = $("#theGrid");
    var ids = grid.jqGrid('getDataIDs');
    var selRow = parseInt(grid.jqGrid('getGridParam', 'selrow'));
    //alert(selRow);
    //alert(countAmount + ' ' + remainAmount);

    if ($("#txtCountAmount").val() != "" && $("#txtMatRemainAmount").val() != "") {
        
        // disable control
        $("#txtMatCode").attr('disabledd', true).addClass('ui-state-disabled');
        $("#txtMatName").attr('disabledd', true).addClass('ui-state-disabled');
        $("#txtMatRemainAmount").attr('disabledd', true).addClass('ui-state-disabled');
        $("#txtCountAmount").attr('disabledd', true).addClass('ui-state-disabled');
        $("#txtCountUnitName").attr('disabledd', true).addClass('ui-state-disabled');

        $.ajax({
            url: 'DataXML/StockCountData.aspx?action=calculateCountAmount',
            global: false,
            type: 'POST',
            data: ({ countAmount: countAmount, summaryAmount: remainAmount }),
            dataType: 'json',
            cache: false,
            complete: function (xhr, status) {
                //alert(xhr.responseText);
                try {
                    var data = eval('(' + xhr.responseText + ')');
                    //for (var i = 0; i < ids.length; i++) {

                    //if (grid.jqGrid('getRowData', ids[i]).mcode == $("#txtMatCode").val()) {

                    grid.jqGrid('setRowData', selRow, { mcode: $("#txtMatCode").val(),
                        mname: $("#txtMatName").val(), mcountamount: data.countAmount,
                        mdiffdisplay: data.diffAmount, mdiff: data.diffAmount
                    });

                    if (selRow < ids[ids.length]) {
                        grid.jqGrid('setSelection', selRow + 1);
                        var dataSl = grid.jqGrid('getRowData', selRow + 1)
                        $("#txtMatCode").val(dataSl.mcode);
                        $("#txtMatName").val(dataSl.mname);
                        $("#txtMatRemainAmount").val(dataSl.summary);
                        if (dataSl.mcountamount != "")
                            $("#txtCountAmount").val(dataSl.mcountamount).select();
                        else
                            $("#txtCountAmount").val(dataSl.summary).select();
                        $("#txtCountUnitName").val(dataSl.munit);
                        materialId = dataSl.mid;
                        unitSmallAmount = dataSl.unitSmallAmount;
                        unitLargeId = dataSl.munitlargeid;
                    }


                    // enable control
                    $("#txtMatCode").attr('disabled', false).removeClass('ui-state-disabled');
                    $("#txtMatName").attr('disabled', false).removeClass('ui-state-disabled');
                    $("#txtMatRemainAmount").attr('disabled', false).removeClass('ui-state-disabled');
                    $("#txtCountAmount").attr('disabled', false).removeClass('ui-state-disabled');
                    $("#txtCountUnitName").attr('disabled', false).removeClass('ui-state-disabled');


                    scrollToRow("#theGrid", selRow - 2);
                    // break;
                    // }
                    // }
                } catch (e) {
                    //alert('Ajax Error Calculate count amount' + e.msg);
                    alert(xhr.responseText);
                }
            }
        });
    }
}