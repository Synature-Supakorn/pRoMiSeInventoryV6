
// scroll jqgrid row
// targetGrid = $("#jqGridId")
// rowIndex = row you want to scroll to
function scrollToRow(targetGrid, rowIndex) {
    var rowHeight = 23; // rowheight
    var index = jQuery(targetGrid).getInd(id);
    jQuery(targetGrid).closest(".ui-jqgrid-bdiv").scrollTop(rowHeight * index);
}