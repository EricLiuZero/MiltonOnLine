<%@ WebHandler Language="C#" Class="api_myclass" %>

using System;
using System.Web;
using MldOnLine.TableHelper;
using EricLib.Utility;

public class api_myclass : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            var _returnString = string.Empty;
            var tblMyClass = new TblMyClass();
            switch (context.Request.Params["action"])
            {
                case "get_all":
                    _returnString = tblMyClass.GetAll(context.Request.QueryString["student_id"]);
                    break;
                case "add":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblMyClass.Create(context), tblMyClass.successMsg, tblMyClass.errorMsg);
                    break;
                case "save":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblMyClass.Update(Convert.ToInt32(context.Request.QueryString["id"]), context), tblMyClass.successMsg, tblMyClass.errorMsg);
                    break;
                case "delete":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblMyClass.Delete(Convert.ToInt32(context.Request.Params["id"])), tblMyClass.successMsg, tblMyClass.errorMsg);
                    break;
                case "reset_id":
                    _returnString = TblMyClass.ResetAutoNumber();
                    break;
                default:
                    _returnString = "[action] is null";
                    break;
            }
            context.Response.Write(_returnString);
        }
        catch (Exception ex) { context.Response.Write("錯誤訊息:" + ex.Message); }
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}