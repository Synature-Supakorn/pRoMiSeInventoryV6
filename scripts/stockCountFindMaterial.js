function findMaterial(matCode) {
    $.ajax({
        url: 'DataXML/MaterialListDataXML.aspx?action=findMaterial&matCode=' + matCode,
        dataType: 'json',
        cache: false,
        success: function (result) {
            return result;
        },
        error: function (xhr, status) {
            return xhr.responseText;
        }
    });
}