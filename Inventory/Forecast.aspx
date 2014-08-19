<%@ page language="VB" autoeventwireup="false" inherits="Inventory_Forecast, App_Web_forecast.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forcash Product</title>
    <style>
        /* -- General styles ------------------------------ */
        body
        {
            margin: 0;
            padding: 0;
            background: #fff;
            padding-bottom: 1px;
            font-family: Tahoma, Verdana;
            font-size: 12px;
        }
        body, td, th
        {
            font-family: Tahoma, Verdana;
            font-size: 12px;
        }
        html, body
        {
            height: 95%;
        }
        #minwidth
        {
            min-width: 960px;
        }
        .clr
        {
            clear: both;
            overflow: hidden;
            height: 0;
        }
        a, img
        {
            padding: 0;
            margin: 0;
        }
        img
        {
            border: 0 none;
        }
        form
        {
            margin: 0;
            padding: 0;
        }
        h1
        {
            margin: 0;
            padding-bottom: 8px;
            color: #0B55C4;
            font-size: 20px;
            font-weight: bold;
            font-family: Tahoma, Verdana;
        }
        h3
        {
            font-size: 13px;
            font-family: Tahoma, Verdana;
        }
        h4
        {
            font-size: 13px;
            font-family: Tahoma, Verdana;
        }
        a:link
        {
            color: #0B55C4;
            text-decoration: none;
        }
        a:visited
        {
            color: #0B55C4;
            text-decoration: none;
        }
        a:hover
        {
            text-decoration: underline;
        }
        fieldset
        {
            margin-bottom: 10px;
            border: 1px #ccc solid;
            padding: 5px;
            text-align: left;
        }
        fieldset p
        {
            margin: 10px 0px;
        }
        legend
        {
            color: #0B55C4;
            font-size: 12px;
            font-weight: bold;
        }
        /**/input, select
        {
            font-size: 12px;
            font-family: Tahoma, Verdana;
            height: 22px;
        }
        textarea
        {
            font-size: 11px;
            font-family: Tahoma, Verdana;
        }
        label
        {
            font-size: 12px;
            font-family: Tahoma, Verdana;
        }
        span
        {
            font-size: 11px;
            font-family: Tahoma, Verdana;
        }
        button
        {
            font-size: 11px;
            height: 25px;
            font-family: Tahoma, Verdana;
        }
        input.disabled
        {
            background-color: #F0F0F0;
        }
        input.button
        {
            cursor: pointer;
        }
        input.submit
        {
            height: 25px;
            font-size: 11px;
            font-family: Tahoma, Verdana;
        }
        input:focus, select:focus, textarea:focus
        {
            background-color: #ffd;
        }
        .text
        {
            font-size: 13px;
            line-height: 15px;
            font-family: sans-serif;
            font-family: Arial,Verdana,Geneva, Arial, Helvetica, sans-serif,Verdana,;
            color: black;
        }
        .texttitle
        {
            font-size: 16px;
            font-weight: bold;
        }
        /* -- overall styles ------------------------------ */
        #border-top.h_green
        {
            background: url(../images/h_green/j_header_middle.png) repeat-x;
        }
        #border-top.h_green div
        {
            background: url(../images/h_green/j_header_right.png) 100% 0 no-repeat;
        }
        #border-top.h_green div div
        {
            background: url(../images/h_green/j_header_left.png) no-repeat;
            height: 54px;
        }
        #border-top.h_teal
        {
            background: url(../images/h_teal/j_header_middle.png) repeat-x;
        }
        #border-top.h_teal div
        {
            background: url(../images/h_teal/j_header_right.png) 100% 0 no-repeat;
        }
        #border-top.h_teal div div
        {
            background: url(../images/h_teal/j_header_left.png) no-repeat;
            height: 54px;
        }
        #border-top.h_cherry
        {
            background: url(../images/h_cherry/j_header_middle.png) repeat-x;
        }
        #border-top.h_cherry div
        {
            background: url(../images/h_cherry/j_header_right.png) 100% 0 no-repeat;
        }
        #border-top.h_cherry div div
        {
            background: url(../images/h_cherry/j_header_left.png) no-repeat;
            height: 54px;
        }
        #border-top .title
        {
            font-size: 22px;
            font-weight: bold;
            color: #fff;
            line-height: 44px;
            padding-left: 180px;
        }
        #border-top .version
        {
            display: block;
            float: right;
            color: #fff;
            padding: 25px 5px 0 0;
        }
        #border-bottom
        {
            background: url(../images/j_bottom.png) repeat-x;
        }
        #border-bottom div
        {
            background: url(../images/j_corner_br.png) 100% 0 no-repeat;
        }
        #border-bottom div div
        {
            background: url(../images/j_corner_bl.png) no-repeat;
            height: 11px;
        }
        #footer .copyright
        {
            margin: 10px;
            text-align: center;
        }
        #header-box
        {
            border: 1px solid #ccc;
            background: #f0f0f0;
        }
        #footer-box
        {
            text-align: center;
        }
        #content-box
        {
            border-left: 1px solid #ccc;
            border-right: 1px solid #ccc;
            padding: 5px;
        }
        #content-box .padding
        {
            padding: 10px 10px 0 10px;
        }
        #toolbar-box
        {
            background: #fbfbfb;
            margin-bottom: 10px;
        }
        #toolbar-button
        {
            margin: 0px;
            padding: 5px;
            text-align: right;
            background-color: #F6F6F6;
        }
        .toolbar-title
        {
            margin: 0px;
            padding: 5px;
            text-align: left;
            font-size: 14px;
            font-weight: bold;
            float: left;
        }
        #content
        {
            margin: 0px;
            padding: 0px;
        }
        #submenu-box
        {
            background: #f6f6f6;
            margin-bottom: 10px;
        }
        #submenu-box .padding
        {
            padding: 0px;
        }
        /* -- status layout */
        #module-status
        {
            float: right;
        }
        #module-status span
        {
            display: block;
            float: left;
            line-height: 16px;
            padding: 4px 10px 0 22px;
            margin-bottom: 5px;
        }
        #module-status
        {
            background: url(../images/mini_icon.png) 3px 5px no-repeat;
        }
        .legacy-mode
        {
            color: #c00;
        }
        #module-status .preview
        {
            background: url(../images/menu/icon-16-media.png) 3px 3px no-repeat;
        }
        #module-status .unread-messages, #module-status .no-unread-messages
        {
            background: url(../images/menu/icon-16-messages.png) 3px 3px no-repeat;
        }
        #module-status .unread-messages a
        {
            font-weight: bold;
        }
        #module-status .loggedin-users
        {
            background: url(../images/menu/icon-16-user.png) 3px 3px no-repeat;
        }
        #module-status .logout
        {
            background: url(../images/menu/icon-16-logout.png) 3px 3px no-repeat;
        }
        /* -- various styles -- */
        span.note
        {
            display: block;
            background: #ffd;
            padding: 5px;
            color: #666;
        }
        /** overlib **/
        .ol-foreground
        {
            background-color: #ffe;
        }
        .ol-background
        {
            background-color: #6db03c;
        }
        .ol-textfont
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #666;
        }
        .ol-captionfont
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 11px;
            color: #fff;
            font-weight: bold;
        }
        .ol-captionfont a
        {
            color: #0b5fc6;
            text-decoration: none;
        }
        .ol-closefont
        {
        }
        /** toolbar **/
        div.header
        {
            font-size: 22px;
            font-weight: bold;
            color: #0B55C4;
            line-height: 48px;
            padding-left: 55px;
            background-repeat: no-repeat;
            margin-left: 10px;
        }
        div.header span
        {
            color: #666;
        }
        div.configuration
        {
            font-size: 14px;
            font-weight: bold;
            color: #0B55C4;
            line-height: 16px;
            padding-left: 30px;
            margin-left: 10px;
            background-image: url(../images/menu/icon-16-config.png);
            background-repeat: no-repeat;
        }
        div.toolbar
        {
            float: right;
            text-align: right;
            padding: 0;
        }
        table.toolbar
        {
            border-collapse: collapse;
            padding: 0;
            margin: 0;
        }
        table.toolbar td
        {
            padding: 1px 1px 1px 4px;
            text-align: center;
            color: #666;
            height: 48px;
        }
        table.toolbar td.spacer
        {
            width: 10px;
        }
        table.toolbar td.divider
        {
            border-right: 1px solid #eee;
            width: 5px;
        }
        table.toolbar span
        {
            float: none;
            width: 32px;
            height: 32px;
            margin: 0 auto;
            display: block;
        }
        table.toolbar a
        {
            display: block;
            float: left;
            white-space: nowrap;
            border: 1px solid #fbfbfb;
            padding: 1px 5px;
            cursor: pointer;
        }
        table.toolbar a:hover
        {
            border-left: 1px solid #eee;
            border-top: 1px solid #eee;
            border-right: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            text-decoration: none;
            color: #0B55C4;
        }
        /** for massmail component **/
        td#mm_pane
        {
            width: 90%;
        }
        input#mm_subject
        {
            width: 200px;
        }
        textarea#mm_message
        {
            width: 100%;
        }
        /* pane-sliders  */
        .pane-sliders .title
        {
            margin: 0;
            padding: 2px;
            color: #666;
            cursor: pointer;
        }
        .pane-sliders .panel
        {
            border: 1px solid #ccc;
            margin-bottom: 3px;
        }
        .pane-sliders .panel h3
        {
            background: #f6f6f6;
            color: #666;
        }
        .pane-sliders .panel h2
        {
            background: #f6f6f6;
            color: #666;
        }
        .pane-sliders .panel h1
        {
            background: #f6f6f6;
            color: #666;
        }
        .pane-sliders .content
        {
            background: #f6f6f6;
        }
        .pane-sliders .adminlist
        {
            border: 1 none;
        }
        .pane-sliders .adminlist td
        {
            border: 1 none;
        }
        .jpane-toggler span
        {
            background: transparent url(../images/j_arrow.png) 5px 50% no-repeat;
            padding-left: 20px;
        }
        .jpane-toggler-down span
        {
            background: transparent url(../images/j_arrow_down.png) 5px 50% no-repeat;
            padding-left: 20px;
        }
        .jpane-toggler-down
        {
            border-bottom: 1px solid #ccc;
        }
        /* tabs */
        dl.tabs
        {
            float: left;
            margin: 10px 0 -1px 0;
            z-index: 50;
        }
        dl.tabs dt
        {
            float: left;
            padding: 4px 10px;
            border-left: 1px solid #ccc;
            border-right: 1px solid #ccc;
            border-top: 1px solid #ccc;
            margin-left: 3px;
            background: #f0f0f0;
            color: #666;
        }
        dl.tabs dt.open
        {
            background: #F9F9F9;
            border-bottom: 1px solid #F9F9F9;
            z-index: 100;
            color: #000;
        }
        div.current
        {
            clear: both;
            border: 1px solid #ccc;
            padding: 10px 10px;
        }
        div.current dd
        {
            padding: 0;
            margin: 0;
        }
        /** cpanel settings **/
        #cpanel div.icon
        {
            text-align: center;
            margin-right: 5px;
            float: left;
            margin-bottom: 5px;
        }
        #cpanel div.icon a
        {
            display: block;
            float: left;
            border: 1px solid #f0f0f0;
            height: 97px;
            width: 108px;
            color: #666;
            vertical-align: middle;
            text-decoration: none;
        }
        #cpanel div.icon a:hover
        {
            border-left: 1px solid #eee;
            border-top: 1px solid #eee;
            border-right: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            background: #f9f9f9;
            color: #0B55C4;
        }
        #cpanel img
        {
            padding: 10px 0;
            margin: 0 auto;
        }
        #cpanel span
        {
            display: block;
            text-align: center;
        }
        /* standard form style table */
        div.col
        {
            float: left;
        }
        div.width-45
        {
            width: 45%;
        }
        div.width-55
        {
            width: 55%;
        }
        div.width-50
        {
            width: 50%;
        }
        div.width-70
        {
            width: 70%;
        }
        div.width-30
        {
            width: 30%;
        }
        div.width-60
        {
            width: 60%;
        }
        div.width-40
        {
            width: 40%;
        }
        table.admintable td
        {
            padding: 1px;
        }
        table.admintable td.key, table.admintable td.paramlist_key
        {
            background-color: #f6f6f6;
            text-align: right;
            width: 140px;
            color: #666;
            font-weight: bold;
            border-bottom: 1px solid #e9e9e9;
            border-right: 1px solid #e9e9e9;
            font-family: Tahoma, Verdana;
            font-size: 11px;
        }
        table.paramlist td.paramlist_description
        {
            background-color: #f6f6f6;
            text-align: left;
            width: 170px;
            color: #333;
            font-weight: normal;
            border-bottom: 1px solid #e9e9e9;
            border-right: 1px solid #e9e9e9;
            font-family: Tahoma, Verdana;
            font-size: 11px;
        }
        table.admintable td.key.vtop
        {
            vertical-align: top;
        }
        table.adminform
        {
            background-color: #f9f9f9;
            border: solid 1px #d5d5d5;
            width: 100%;
            border-collapse: collapse;
            margin: 8px 0 10px 0;
            margin-bottom: 15px;
            width: 100%;
        }
        table.adminform.nospace
        {
            margin-bottom: 0;
        }
        table.adminform tr.row0
        {
            background-color: #f9f9f9;
        }
        table.adminform tr.row1
        {
            background-color: #eeeeee;
        }
        table.adminform th
        {
            font-size: 11px;
            padding: 2px 2px 2px 2px;
            text-align: left;
            height: 25px;
            color: #000;
            background-repeat: repeat;
        }
        table.adminform td
        {
            padding: 1px;
            text-align: left;
        }
        table.adminform td.filter
        {
            text-align: left;
        }
        table.adminform td.helpMenu
        {
            text-align: right;
        }
        fieldset.adminform
        {
            border: 1px solid #ccc;
            margin: 0 10px 10px 10px;
        }
        /** Table styles **/
        table.adminlist
        {
            width: 100%;
            border-spacing: 1px;
            background-color: #e7e7e7;
            color: #666;
        }
        table.adminlist td, table.adminlist th
        {
            padding: 1px;
        }
        table.adminlist thead th
        {
            text-align: center;
            background: #f0f0f0;
            color: #666;
            border-bottom: 1px solid #999;
            border-left: 1px solid #fff;
        }
        table.adminlist thead a:hover
        {
            text-decoration: none;
        }
        table.adminlist thead th img
        {
            vertical-align: middle;
        }
        table.adminlist tbody th
        {
            font-weight: bold;
        }
        table.adminlist tbody tr
        {
            background-color: #fff;
            text-align: left;
        }
        table.adminlist tbody tr.row1
        {
            background: #f9f9f9;
            border-top: 1px solid #fff;
        }
        table.adminlist tbody tr.row0:hover td, table.adminlist tbody tr.row1:hover td
        {
            background-color: #ffd;
        }
        table.adminlist tbody tr td
        {
            height: 25px;
            background: #fff;
            border: 1px solid #fff;
        }
        table.adminlist tbody tr.row1 td
        {
            background: #f9f9f9;
            border-top: 1px solid #FFF;
        }
        table.adminlist tfoot tr
        {
            text-align: center;
            color: #333;
        }
        table.adminlist tfoot td, table.adminlist tfoot th
        {
            background-color: #f3f3f3;
            border-top: 1px solid #999;
            text-align: center;
        }
        table.adminlist td.order
        {
            text-align: center;
            white-space: nowrap;
        }
        table.adminlist td.order span
        {
            float: left;
            display: block;
            width: 20px;
            text-align: center;
        }
        table.adminlist .pagination
        {
            display: table;
            padding: 0;
            margin: 0 auto;
        }
        .pagination div.limit
        {
            float: left;
            height: 22px;
            line-height: 22px;
            margin: 0 10px;
        }
        /** stu nicholls solution for centering divs **/
        .container
        {
            clear: both;
            text-decoration: none;
        }
        
        /** table solution for global config **/
        table.noshow
        {
            width: 100%;
            border-collapse: collapse;
            padding: 0;
            margin: 0;
        }
        table.noshow tr
        {
            vertical-align: top;
        }
        table.noshow td
        {
        }
        table.noshow fieldset
        {
            margin: 15px 7px 7px 7px;
        }
        #editor-xtd-buttons
        {
            padding: 5px;
        }
        /* -- buttons -> STILL NEED CLEANUP*/
        .button1, .button1 div
        {
            height: 1%;
            float: right;
        }
        .button2-left, .button2-right, .button2-left div, .button2-right div
        {
            float: left;
        }
        .button1
        {
            background: url(../images/j_button1_left.png) no-repeat;
            white-space: nowrap;
            padding-left: 10px;
            margin-left: 5px;
        }
        .button1 .next
        {
            background: url(../images/j_button1_next.png) 100% 0 no-repeat;
        }
        .button1 a
        {
            display: block;
            height: 26px;
            float: left;
            line-height: 26px;
            font-size: 12px;
            font-weight: bold;
            color: #333;
            cursor: pointer;
            padding: 0 30px 0 6px;
        }
        .button1 a:hover
        {
            text-decoration: none;
            color: #0B55C4;
        }
        .button2-left a, .button2-right a, .button2-left span, .button2-right span
        {
            display: block;
            height: 22px;
            float: left;
            line-height: 22px;
            font-size: 11px;
            color: #333;
            cursor: pointer;
        }
        .button2-left span, .button2-right span
        {
            cursor: default;
            color: #999;
        }
        .button2-left .page a, .button2-right .page a, .button2-left .page span, .button2-right .page span, .button2-left .blank a, .button2-right .blank a, .button2-left .blank span, .button2-right .blank span
        {
            padding: 0 6px;
        }
        .page span, .blank span
        {
            color: #000;
            font-weight: bold;
        }
        .button2-left a:hover, .button2-right a:hover
        {
            text-decoration: none;
            color: #0B55C4;
        }
        .button2-left a, .button2-left span
        {
            padding: 0 24px 0 6px;
        }
        .button2-right a, .button2-right span
        {
            padding: 0 6px 0 24px;
        }
        .button2-left
        {
            background: url(../images/j_button2_left.png) no-repeat;
            float: left;
            margin-left: 5px;
        }
        .button2-right
        {
            background: url(../images/j_button2_right.png) 100% 0 no-repeat;
            float: left;
            margin-left: 5px;
        }
        .button2-right .prev
        {
            background: url(../images/j_button2_prev.png) no-repeat;
        }
        .button2-right.off .prev
        {
            background: url(../images/j_button2_prev_off.png) no-repeat;
        }
        .button2-right .start
        {
            background: url(../images/j_button2_first.png) no-repeat;
        }
        .button2-right.off .start
        {
            background: url(../images/j_button2_first_off.png) no-repeat;
        }
        .button2-left .page, .button2-left .blank
        {
            background: url(../images/j_button2_right_cap.png) 100% 0 no-repeat;
        }
        .button2-left .next
        {
            background: url(../images/j_button2_next.png) 100% 0 no-repeat;
        }
        .button2-left.off .next
        {
            background: url(../images/j_button2_next_off.png) 100% 0 no-repeat;
        }
        .button2-left .end
        {
            background: url(../images/j_button2_last.png) 100% 0 no-repeat;
        }
        .button2-left.off .end
        {
            background: url(../images/j_button2_last_off.png) 100% 0 no-repeat;
        }
        .button2-left .image
        {
            background: url(../images/j_button2_image.png) 100% 0 no-repeat;
        }
        .button2-left .readmore
        {
            background: url(../images/j_button2_readmore.png) 100% 0 no-repeat;
        }
        .button2-left .pagebreak
        {
            background: url(../images/j_button2_pagebreak.png) 100% 0 no-repeat;
        }
        .button2-left .blank
        {
            background: url(../images/j_button2_blank.png) 100% 0 no-repeat;
        }
        /* Tooltips */
        .tool-tip
        {
            float: left;
            background: #ffc;
            border: 1px solid #D4D5AA;
            padding: 5px;
            max-width: 200px;
            z-index: 50;
        }
        .tool-title
        {
            padding: 0;
            margin: 0;
            font-size: 100%;
            font-weight: bold;
            margin-top: -15px;
            padding-top: 15px;
            padding-bottom: 5px;
            background: url(../images/selector-arrow.png) no-repeat;
        }
        .tool-text
        {
            font-size: 100%;
            margin: 0;
        }
        /* Calendar */
        a img.calendar
        {
            width: 16px;
            height: 16px;
            margin-left: 3px;
            background: url(../images/calendar.png) no-repeat;
            cursor: pointer;
            vertical-align: middle;
        }
        /* System Standard Messages */
        #system-message dd.message ul
        {
            background: #C3D2E5 url(../images/notice-info.png) 4px center no-repeat;
        }
        /* System Error Messages */
        #system-message dd.error ul
        {
            color: #c00;
            background: #E6C0C0 url(../images/notice-alert.png) 4px top no-repeat;
            border-top: 3px solid #DE7A7B;
            border-bottom: 3px solid #DE7A7B;
        }
        /* System Notice Messages */
        #system-message dd.notice ul
        {
            color: #c00;
            background: #EFE7B8 url(../images/notice-note.png) 4px top no-repeat;
            border-top: 3px solid #F0DC7E;
            border-bottom: 3px solid #F0DC7E;
        }
    </style>
    <script src="../scripts/jquery-1.4.2.min.js"></script>
    <script src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>
     <script type="text/javascript">

         jQuery(document).ready(function ($) {


             $('.txtMV').click(function () {
                 $(this).select();
             });

             $(function () {
                 $(".txtMV").keypress(function (evt) {
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
             $.extend({
                 getUrlVars: function () {
                     var vars = [], hash;
                     var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                     for (var i = 0; i < hashes.length; i++) {
                         hash = hashes[i].split('=');
                         vars.push(hash[0]);
                         vars[hash[0]] = hash[1];
                     }
                     return vars;
                 },
                 getUrlVar: function (name) {
                     return $.getUrlVars()[name];
                 }
             });
             $('.txtMV').keyup(function (e) {
                 if (e.keyCode == 13) {
                     var nxtIdx = $('input:text').index(this) + 1;
                     $(":input:text:eq(" + nxtIdx + ")").focus();
                 }
             });

         });

    </script>
    
    
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 800px; margin: 10px;">
        <fieldset>
            <legend>เงื่อนไขสำหรับค่าประมาณการ</legend>
            <table class="adminlist" cellspacing="1">
                <tr>
                     <th style="width:200px;"><label>ช่วงเวลา:</label></th><td><div id="date_bystartmonth" runat="server" style="float: left;">
                            </div><div id="date_byendmonth" runat="server" style="float: left;">
                            </div>
                         <asp:Button ID="btnProductSetting" runat="server" Text="กำหนดสินค้าเข้าร่วม" Height="24px" TabIndex="1" />
                         <asp:Button ID="btnSaveConfig" runat="server" Text="ตั้งค่าช่วงเวลา" Height="24px" TabIndex="2" />
                                                                           </td>
                </tr>
                  <tr>
                     <th><label>ค่าเฉลี่ยต่อหัว:</label></th><td>
                      <asp:TextBox ID="txtAvgHead" runat="server"  Width="200px" ReadOnly="true" BackColor="#ccccff" ></asp:TextBox>
                      <asp:Label ID="lbAvgHead" runat="server"  ></asp:Label>
                      </td>
                </tr>
                 <tr>
                     <th><label>ยอดขาย:</label></th><td>
                     <asp:TextBox ID="txtEstimateSale" runat="server" Width="200px"></asp:TextBox>
                     <asp:Button ID="btnForcash" runat="server" Text="คำนวณจากยอดขาย" Height="24px" TabIndex="3" Width="150px"/>
                     </td>
                </tr>
                 <tr>
                     <th><label>จำนวนลูกค้า:</label></th><td>
                     <asp:TextBox ID="txtCutomerNo" runat="server" Width="200px"></asp:TextBox>
                         <asp:Button ID="btnForecastByCustomer" runat="server" Text="คำนวณจากจำนวนลูกค้า" Height="24px" TabIndex="3" Width="150px"/>
                     </td>
                </tr>
            </table>
        </fieldset>
       
    </div>
    <div style="margin: 10px;">        
         <fieldset>
            <legend>ค่าประมาณการของสินค้าแต่หละตัว</legend>
                <table  class="adminlist" cellspacing="1">
                            <tr>
                                <th  style="width:200px;">
                                    <asp:Label ID="lb4" runat="server" Text="Label">กลุ่มสินค้า</asp:Label>
                                </th>
                                <td>
                                    <asp:DropDownList ID="ddlProductGroup" runat="server" AutoPostBack="True" Width="200px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <asp:Label ID="lb5" runat="server">หมวดสินค้า</asp:Label>
                                </th>
                                <td>
                                    <asp:DropDownList ID="ddlProductDept" runat="server" Width="200px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Button ID="btnSaveProduct" runat="server" Text="บันทึกอัตราส่วนลูกค้า" Height="24px"/>
                                </td>
                            </tr>
                        </table>
             <div id="resultdata" runat="server" ></div>
         </fieldset>
    </div>
    </form>
</body>
</html>
