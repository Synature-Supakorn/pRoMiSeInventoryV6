$(function () {
    $(".txt-numeric").keypress(function (evt) {
        /*if ($(this).val() != "") {
            this.value = this.value.replace(/[^0-9+,.]/g, "");
        }*/
        var charCode = (evt.which) ? evt.which : event.keyCode;
        //alert(charCode);
         if (charCode > 47 && charCode < 58 || charCode == 46)
            return true; 
         else
            return false;
    });
});