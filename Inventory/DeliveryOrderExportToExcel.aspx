<%@ page language="VB" autoeventwireup="false" inherits="Inventory_DeliveryOrderExportToExcel, App_Web_deliveryorderexporttoexcel.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delivery Order Export To Excel.</title>
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="../css/menu.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin:30px;">
        <div style="width:70%;">
         <fieldset>
             <legend><h1>Delivery Order.</h1></legend>
  <table>
                <tr>
                    <td style="text-align:right"><asp:Label ID="lbCompany" runat="server" Text="Companay : "></asp:Label> </td>
                    <td>
                            <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="true" Width="220px"></asp:DropDownList>
                    </td>
                    
                    <td> 
                       <asp:Label ID="lbFromDate" runat="server" Text="From Date :"></asp:Label>  

                    </td>
                    <td>
                       <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
 <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                                </td>
               </tr>
               <tr>
                   <td  style="text-align:right"><asp:Label ID="lbWhareHouse" runat="server" Text="Whare House : "></asp:Label> </td>
                   <td>
                       <asp:DropDownList ID="ddlWhareHouse" runat="server" Width="220px">
                       </asp:DropDownList>
                   </td>
                   <td  style="text-align:right">
                        <asp:Label ID="lbToDate" runat="server" Text="To Date :"></asp:Label>
                    </td>
                   <td>
                        <asp:DropDownList ID="RdoDoce_DdlDay" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="RdoDoce_DdlMonth" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="RdoDoce_DdlYear" runat="server">
                        </asp:DropDownList></td>
               </tr>
                <tr>
                    
                  <td  style="text-align:right">
                        <asp:Label ID="lbStatus" runat="server" Text="Stutus :"></asp:Label>  
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDocumentStatus" runat="server" Width="220px">                          
                        </asp:DropDownList>
                    </td>
                    <td></td>
                   <td>
                        <asp:Button ID="btnShowReport" runat="server" Text="Show Report" />
                        <asp:Button ID="btnExportData" runat="server" Text="Export To Excel" /></td>
                </tr>
                </table>

         </fieldset>
            
          
            </div>
        <div style="width:70%;">
        <fieldset>
            <legend>Documents.</legend>
             
             <span id="resultText" runat="server"></span>
       
        </fieldset>  

        </div>      
        
    </div>
    </form>
</body>
</html>
