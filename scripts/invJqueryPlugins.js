function calculate(evt, id, length) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 47 && charCode < 58 || charCode == 46) {
        return true;
    } else if (evt.keyCode == 13) {
        var _unitSmallAmount = 0;
        var displayAmount = 0;
        //var defaultRatio = 0;
        //$("#txt_" + id).val($("#txt_" + id).val().replace(/[^0-9+,.]/gim, ""));
        if (length != undefined) {
            if (length > 0) {
                var unitSmallArr = new Array();
                for (var i = 1; i <= length; i++) {
                    if ($("#txt_" + materialId + "_" + i + "").val() != '') {
                        if (!isNaN(parseFloat($("#txt_" + materialId + "_" + i + "").val()))) {
                            var amount = parseFloat($("#txt_" + materialId + "_" + i + "").val().replace(',', ''));
                            var ratio = parseFloat($("#hide_" + materialId + "_" + i + "").val().replace(',', ''));
                            //_unitSmallAmount += amount * ratio;
                            unitSmallArr.push(amount + ":" + ratio);
                            //alert(JSON.stringify(unitSmallArr));
                        }
                    }
                }
                //alert(_unitSmallAmount);
                if ($("#materialCountAmount")) {
                    $("#upm").html('<img src="../Images/loadingSmall.gif" alt="" style="margin-right:4px;"/>');
                    $.ajax({
                        url: 'DataXML/MaterialListDataXML.aspx?action=getUnitDetail' +
                        '&staffId=' + require_var.staffId +
                        '&staffRole=' + require_var.staffRole +
                        '&langId=' + require_var.langId,
                        type: 'POST',
                        data: "materialId=" + materialId + "&calUnit[]=" + unitSmallArr,
                        dataType: 'json',
                        cache: false,
                        global: false,
                        complete: function(xhr, status) {
                            //alert(xhr.responseText);
                            $("#upm").html('');
                        },
                        success: function(result) {
                            if (result.displayInLargeUnit.length > 0) {
                                for (var i = 0; i <= result.displayInLargeUnit.length - 1; i++) {
                                    /*if (result.displayInLargeUnit[i].isDefault == "1") {
                                    defaultRatio = result.displayInLargeUnit[i].unitSmallRatio;
                                    }*/
                                    displayAmount = result.displayInLargeUnit[i].displayAmount;
                                }

                                $("#materialCountAmount").val(result.defaultAmount);
                                $("#bOk_" + materialId).attr('disabled', false).removeClass('ui-state-disabled');
                            }
                            $("#txt_" + materialId + "_1").select();
                            //$("#materialCountAmount").val(result.totalUnitSmallAmount);
                        }, error: function(xhr, status) {
                            alert('Errorr ! ' + xhr.responseText);
                        }
                    });
                } else {
                    alert($("#materialCountAmount"));
                }
            }
        }
    }
    return false;
}

(function($) {
    $.fn.customDialog = function(options) {
        var defaults = {
            mesg: '<p></p>',
            title: 'Custom Dialog By Tooi',
            modal: true,
            height: 80,
            bOk: 'Ok',
            bCancel: 'Cancel',
            showButton: true,
            click: function() {
                //alert('ส่งชื่อ function ที่จะให้ทำตอนกด Ok ให้ด้วย');
            }
        }
        var options = $.extend(defaults, options);
        return this.each(function() {
            var $this = $(this);
            //$this.css('height':'inherit');
            var html = '';
            html += '<p style="font-weight:bold; font-size:1.2em;">' + options.mesg + '</p>';
            if (options.showButton) {
                html += '<div style="padding-bottom:2px; border-top:#ccc 1px solid; text-align:right">';
                html += '<button type="button" id="bOk">' + options.bOk + '</button>';
                html += '<button type="button" id="bCancel">' + options.bCancel + '</button>';
            }
            html += '</div>';
            $this.html(html);

            $this.dialog({
                title: options.title,
                width: 'inherit',
                height: options.height,
                modal: options.modal,
                resizable: false
            });

            $("#bOk").button({
                icons: {
                    primary: 'icon-btn-ok'
                }
            }).click(function() {
                $this.dialog('close');
            });

            $("#bCancel").button({
                icons: {
                    primary: 'icon-btn-cancel'
                }
            }).click(function() {
                $this.dialog('close');
            });
        });
    }


    // stockcount get unit detail
    $.fn.stockCountUnit = function(options) {
        var defaults = {
            materialId: 0,
            materialCode: '',
            materialName: '',
            materialRemainAmount: 0,
            materialAmount: 0,
            unitSmallAmount: 0,
            materialUnitName: ''
        }

        var options = $.extend(defaults, options);

        return this.each(function() {
            //alert(options.materialId);
            var $this = $(this);
            var html = '<div>';
            //alert(options.unitSmallAmount);
            $.ajax({
                url: 'DataXML/MaterialListDataXML.aspx?action=getUnitDetail' +
                '&staffId=' + require_var.staffId +
                '&staffRole=' + require_var.staffRole +
                '&langId=' + require_var.langId,
                type: 'POST',
                data: ({ materialId: options.materialId, unitSmallAmount: options.unitSmallAmount }),
                dataType: 'json',
                cache: false,
                success: function (result) {
                    if (result.displayInLargeUnit != undefined) {
                        html += '<fieldset><legend class="font-bold">Material info.</legend>';
                        html += '<p>';
                        html += '<div style="float:left; width:80px; padding-top:4px;">Material : </div><div><input type="text" class="font-bold" style="width:80%;" readonly="readonly" value="' + options.materialCode + ':' + options.materialName + '" /></div>';
                        html += '</p>';
                        html += '<p>';
                        html += '<div style="float:left; width:80px; padding-top:4px;">Balance : </div><div><input type="text" class=" font-bold" style="text-align:right;"  readonly="readonly"  value="' + options.materialRemainAmount + '" /> ' + options.materialUnitName + '</div>';
                        html += '</p>';
                        html += '<p>';
                        html += '<div style="float:left; width:80px; padding-top:4px;">Count : </div><div><input type="text" id="materialCountAmount" class="font-bold" style="text-align:right;" readonly="readonly" value="' + options.materialAmount + '" /> ' + options.materialUnitName + '</div>';
                        html += '</p>';
                        html += '</fieldset>';
                        if (result.displayInLargeUnit.length > 0) {
                            //alert(result.displayInLargeUnit.length);
                            html += '<fieldset><legend class="font-bold">Press enter for calculate amount.</legend>';
                            for (var i = 0; i < result.displayInLargeUnit.length; i++) {
                                html += '<div>';
                                html += '<div style="float:left; width:80px;">&nbsp;</div>';
                                html += '<div>';
                                html += '<input type="text" class="txt-unitCount" style="text-align:right; " id="txt_' + options.materialId + '_' + (i + 1) + '" value="' + result.displayInLargeUnit[i].displayAmount + '" onkeypress="return calculate(event, \'' + options.materialId + '_' + (i + 1) + '\',' + result.displayInLargeUnit.length + ');" />';
                                html += '<input type="hidden" id="hide_' + options.materialId + '_' + (i + 1) + '" value="' + result.displayInLargeUnit[i].unitSmallRatio + '" />';
                                html += '<span> ' + result.displayInLargeUnit[i].unitLargeName + ' (1 :' + result.displayInLargeUnit[i].unitSmallRatio + ')</span>';
                                html += '</div>';
                                html += '</div>';
                            }
                            html += '</fieldset>';
                        }
                        html += '<div style="margin-top:4px;padding-top:4px;border-top:#ccc 1px solid; text-align:right;">';
                        html += '<span id="upm"></span>';
                        html += '<button type="button" id="bOk_' + options.materialId + '">Ok</button>';
                        html += '<button type="button" id="bCancel_' + options.materialId + '">Cancel</button>';
                        html += '</div>';
                        html += '</div>';
                        $this.html(html);


                        $("#txt_" + options.materialId + "_1").click(function () {
                            $(this).select();
                        }).focus();

                        //alert(html);
                        $("#bOk_" + options.materialId + "").button({
                            icons: {
                                primary: 'icon-btn-ok'
                            }
                        }).click(function () {
                            $this.dialog('close');
                            $("#txtCountAmount").val($("#materialCountAmount").val()).select();
                        }).attr('disabled', true).addClass('ui-state-disabled');
                        $("#bCancel_" + options.materialId + "").button({
                            icons: {
                                primary: 'icon-btn-cancel'
                            }
                        }).click(function () {
                            $this.dialog('close');
                        });
                    } else {
                        $("#alert_msg").text("No unit detail.");
                        alertDialog();
                    }
                }, error: function(xhr, status) {
                    alert(xhr.responseText);
                }
            });
            $this.dialog({
                dialogClass: 'dialogWithDropShadow',
                title: 'Unit detail',
                width: 490,
                position: ['auto', 100],
                //height: options.height,
                modal: true,
                resizable:false
            });
        });
    }
})(jQuery);
