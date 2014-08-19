function ExitDocument(ui) {
    //alert(ui.panel.id);
    var strURL;
    if (ui.panel.id == 't15045') {
        strURL = 'Inventory/DataXML/PurchaseXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15061') {
        strURL = 'Inventory/DataXML/ReceiptFormPOXML.aspx?action=ExitDocument'
    }
    else if (ui.panel.id == 't15062') {
        strURL = 'Inventory/DataXML/ReceiveROXML.aspx?action=ExitDocument'
    }
    else if (ui.panel.id == 't15063') {
        strURL = 'Inventory/DataXML/ReceiptFormTransferXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15047') {
        strURL = 'Inventory/DataXML/TransferDocumentXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15079') {
        strURL = 'Inventory/DataXML/ReceiptFormTransferXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15048') {
        //strURL =''+ additionalURL + '&action=ExitDocument'
        strURL = 'Inventory/DataXML/RequestDocumentXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15068') {
        strURL = 'Inventory/DataXML/PackingDocumentXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15069') {
        strURL = 'Inventory/DataXML/PrepareBatchXML.aspx?action=ExitDocument'
    } else if (ui.panel.id == 't15096') {
        strURL = 'Inventory/DataXML/PrefinishDocumentXML.aspx?action=ExitDocument'
    }
    if (ui.panel.id == 't15045' || ui.panel.id == 't15061' || ui.panel.id == 't15062' || ui.panel.id == 't15063' || ui.panel.id == 't15047' || ui.panel.id == 't15079' || ui.panel.id == 't15048' || ui.panel.id == 't15068' || ui.panel.id == 't15069' || ui.panel.id == 't15096') {

        $.ajax({
            url: strURL,
            datatype: 'json',
            type: 'GET',
            complete: function(xhr, status) {
                //alert(xhr.responseText);
                var data = eval("(" + xhr.responseText + ")");
                if (data.status == 1) {
                    //alert('ออกจากเอกสารไม่สำเร็จ.');
                } else {
                    //alert('ออกจากเอกสารเรียบร้อยแล้ว');
                }
            }
        });
    }
}

function Logout() {
    parent.location.href = "logout.aspx"
}

