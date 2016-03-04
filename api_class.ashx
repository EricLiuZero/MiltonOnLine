<%@ WebHandler Language="C#" Class="api_class" %>

using System;
using System.Web;
using MldOnLine.TableHelper;
using EricLib.Utility;

public class api_class : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            var _returnString = string.Empty;
            var tblClass = new TblClassProfile();
            
            switch (context.Request.Params["action"])
            {
                case "get_all":
                    _returnString = tblClass.GetAll();
                    break;
                case "get_textidpairs":
                    var clv = string.IsNullOrEmpty(context.Request.QueryString["class_lv"]) 
                        ? new Nullable<ClassLevel>()
                        : EnumHelper.ToEnum<ClassLevel>(Convert.ToInt32(context.Request.QueryString["class_lv"]));
                    _returnString = JsonHelper.GetJsonStr(tblClass.GetTextIdPair(clv));
                    break;
                case "add":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblClass.Create(context), tblClass.successMsg, tblClass.errorMsg);
                    break;
                case "save":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblClass.Update(Convert.ToInt32(context.Request.QueryString["id"]), context), tblClass.successMsg, tblClass.errorMsg);
                    break;
                case "delete":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblClass.Delete(Convert.ToInt32(context.Request.Params["id"])), tblClass.successMsg, tblClass.errorMsg);
                    break;
                case "reset_id":
                    _returnString = TblClassProfile.ResetAutoNumber();
                    break;
                default:
                    _returnString = "[action] is null";
                    break;
            }
            context.Response.Write(_returnString);
        }
        catch (Exception ex) { context.Response.Write(string.Format("錯誤訊息: {0}", ex.Message)); }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}