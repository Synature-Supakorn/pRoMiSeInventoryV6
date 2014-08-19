<%@ WebHandler Language="C#" Class="RefreshStockCount" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using POSMySQL.POSControl;
using MySql.Data.MySqlClient;

public class RefreshStockCount : IHttpHandler {
    protected CDBUtil dbUtil;
    protected MySqlConnection conn;
    protected String result = "";
    
    public void ProcessRequest (HttpContext context) {
        JSONResult jsonResult = new JSONResult();
        
        if (context.Request.Params.Get("documentId") != null &&
            context.Request.Params.Get("shopId") != null)
        {
            dbUtil = new CDBUtil();

            OpenDatabase();

            int documentId = int.Parse(context.Request.Params.Get("documentId"));
            int shopId = int.Parse(context.Request.Params.Get("shopId"));

            if (POSInventoryPOROModule.POSInventoryPOROModule.
            StockCount_RefreshStockCountMaterialInDocument(dbUtil, conn, documentId, shopId, true, ref result))
            {
                jsonResult.Status = 1;
                jsonResult.Msg = "successfully";
            }
            else
            {
                jsonResult.Status = 0;
                jsonResult.Msg = result;
            }

            CloseDatabase();

        }
        else
        {
            jsonResult.Status = -1;
            jsonResult.Msg = "invalid parameter!";
        }
        
        JavaScriptSerializer jsSerial = new JavaScriptSerializer();
        string strJson = jsSerial.Serialize(jsonResult);
        context.Response.ContentType = "application/json";
        context.Response.Write(strJson);
    }

    protected void OpenDatabase()
    {
        conn = dbUtil.EstablishConnection();
    }

    protected void CloseDatabase()
    {
        conn.Close();
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

    protected class JSONResult
    {
        private int status;
        private String msg;
        
        public int Status
        {
            get { return status; }
            set { status = value; }
        }

        public String Msg
        {
            get { return msg; }
            set { msg = value; }
        }
    }

}