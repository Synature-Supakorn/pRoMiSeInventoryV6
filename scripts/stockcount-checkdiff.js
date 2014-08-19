function chkCountDiffInJqGrid(grid) {
    var record  = grid.jqGrid('getGridParam', 'records');
    var diff    = false;
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