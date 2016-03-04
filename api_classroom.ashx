<%@ WebHandler Language="C#" Class="api_classroom" %>

using System;
using System.Web;
using MldOnLine.TableHelper;
using EricLib.Utility;

public class api_classroom : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        try
        {
            var _returnString = string.Empty;
            var tblClassroom = new TblClassroom();

            switch (context.Request.Params["action"])
            {
                case "get_all":
                    var clv = string.IsNullOrEmpty(context.Request.QueryString["class_lv"]) 
                        ? new Nullable<ClassLevel>()
                        : EnumHelper.ToEnum<ClassLevel>(Convert.ToInt32(context.Request.QueryString["class_lv"]));
                    _returnString = tblClassroom.GetAll(clv);
                    break;
                case "add":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblClassroom.Create(context), tblClassroom.successMsg, tblClassroom.errorMsg);
                    break;
                case "save":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblClassroom.Update(Convert.ToInt32(context.Request.QueryString["id"]), context), tblClassroom.successMsg, tblClassroom.errorMsg);
                    break;
                case "delete":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblClassroom.Delete(Convert.ToInt32(context.Request.Params["id"])), tblClassroom.successMsg, tblClassroom.errorMsg);
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}