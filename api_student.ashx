<%@ WebHandler Language="C#" Class="api_student" %>

using System;
using System.Web;
using MldOnLine.TableHelper;
using EricLib.Utility;

public class api_student : IHttpHandler
{
    public void ProcessRequest(HttpContext context) {
        context.Response.ContentType = "text/plain";
        try
        {
            var _returnString = string.Empty;
            var tblStudent = new TblStudentProfile();
            var tblUserLogin = new TblUserLogin();
            
            switch (context.Request.Params["action"])
            {
                    
                case "get_all":
                    _returnString = tblStudent.GetAll();
                    break;
                case "get_all_encode":
                    _returnString = tblStudent.GetAll(true);
                    //_returnString = objStudent.GetAllWithEncryptedName();
                    break;
                case "add":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblStudent.Create(context), tblStudent.successMsg, tblStudent.errorMsg);
                    break;
                case "save":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblStudent.Update(Convert.ToInt32(context.Request.QueryString["id"]), context), tblStudent.successMsg, tblStudent.errorMsg);
                    break;
                case "delete":
                    _returnString = JsonHelper.GetEasyUiJsonStr(tblStudent.Delete(Convert.ToInt32(context.Request.Params["id"])), tblStudent.successMsg, tblStudent.errorMsg);
                    break;
                case "register":
                    if (tblStudent.Create(context))
                    {
                        string userEmail = context.Request.Params["Email"];
                        string userPwd = context.Request.Params["Password"];
                        _returnString = JsonHelper.GetEasyUiJsonStr(tblUserLogin.Create(userEmail, userPwd, UserRole.Student), tblStudent.successMsg, tblStudent.errorMsg);
                    }
                    else _returnString = JsonHelper.GetEasyUiJsonStr(false, tblStudent.successMsg, tblStudent.errorMsg);
                    break;
                case "reset_id":
                    _returnString = TblStudentProfile.ResetAutoNumber();
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