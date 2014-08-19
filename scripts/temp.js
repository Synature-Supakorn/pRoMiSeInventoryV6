
/*function customElm(val, opts) {
var elm = document.createElement("input");
elm.type = "text";
elm.value = val;
return elm;
}
function customVal(elm) {
alert(elm.val());
return $(elm).val();
}

function getData() {
$.ajax({
url: "Inventory/DataXML/PourShaseDocumentXML.aspx",
cache:false,
type: "POST",
datatype: "xml",
complete: function(xhr, status) {
var thegrid = jQuery("#theGrid")[0];
thegrid.addXmlData(xhr.responseXML);
//alert(xhr.responseText);
}
});
}*/

 function searchCode(id) {
        var scode = $("#" + id).val();
        alert(scode);
        /*
        var cellData = null;
        $.ajax({
            url: "Inventory/DataXML/JSON.aspx?action=search",
            type: "POST",
            cache: false,
            data: ({ code: $("#"+id).val() }),
            datatype: "json",
            complete: function (data, status) {
                alert(data.responseText);
                var json = eval("(" + data.responseText + ")");

                //-- check product code
                if (json[0].code != "notfound") {
                    cellData = [
                        { code: json[0].code, name: json[0].name, amount: json[0].amount, pricePerUnit: json[0].pricePerUnit, unit: json[0].unit,
                            discount: json[0].discount, vat: json[0].vat, totalPrice: json[0].totalPrice
                        }
                        ];
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });*/


                function getData() {
            //alert('start call');
            $.ajax({
                url: 'jqGrid.aspx/GetData',
                type: 'POST',
                data: '{"name":"' + $('#txtTest').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                complete: function (xhr, status) {
                    alert(xhr.responseText);
                    var res = xhr.responseText.replace(/\\/g, '');
                    alert(res);

                    var theGrid = $("#theGrid")[0];
                    var jsonData = eval("(" + res + ")");
                    alert(jsonData);
                    //theGrid.addJSONData(jsonData.d);
                    
                }
            });
        }