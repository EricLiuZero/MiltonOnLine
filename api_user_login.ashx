<%@ WebHandler Language="C#" Class="api_user_login" %>

using System;
using System.Web;
using MldOnLine.TableHelper;
using EricLib.Utility;

public class api_user_login : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (string.IsNullOrEmpty(context.Request.Params["action"]))
                context.Response.Write("online");
            else
            {
                var _returnString = string.Empty;
                var tblUserLogin = new TblUserLogin();
                var userAcc = context.Request.Params["user_acc"];
                var userPwd = context.Request.Params["user_pwd"];
                string returnUrl = context.Request.QueryString["returnUrl"];

                switch (context.Request.Params["action"])
                {
                    case "get_all":
                        _returnString = tblUserLogin.GetAll();
                        break;
                    case "is_valid":
                        _returnString = JsonHelper.GetEasyUiJsonStr(
                            tblUserLogin.IsValidLogin(userAcc, userPwd), tblUserLogin.successMsg, tblUserLogin.errorMsg);
                        break;
                    case "login":
                        if (!tblUserLogin.IsValidLogin(userAcc, userPwd))
                            _returnString = JsonHelper.GetEasyUiJsonStr(false, tblUserLogin.successMsg, tblUserLogin.errorMsg);
                        else
                        {
                            var objUserLogin = tblUserLogin.GetUserLogin(userAcc);
                            var objUserRolePortal = new TblUserRolePortalPage();
                            context.Session.Clear();
                            context.Session["user_acc"] = objUserLogin.Account;
                            context.Session["user_role"] = objUserLogin.Role;
                            context.Session["user_status"] = objUserLogin.Status;
                            
                            //check user is staff
                            if (!StringHelper.IsEmail(userAcc))
                            {
                                var tblStaff = new TblStaff();
                                var objStaff = tblStaff.GetStaff(userAcc);
                                if (objStaff != null)
                                {
                                    context.Session["user_cname"] = objStaff.CName;
                                }
                            }
                            else
                            {
                                var tblStudent = new TblStudentProfile();
                                var objStudent = tblStudent.GetStudentByEmail(userAcc);
                                context.Session["user_cname"] = objStudent.CName;
                                context.Session["user_ename"] = objStudent.EName;
                                context.Session["student_id"] = objStudent.StudentID;
                                context.Session["student_classlv"] = objStudent.ClassLevel;
                            }
                            var fullUrl = context.Request.Url.AbsoluteUri;
                            var portalPage = GetTargetPage(objUserRolePortal.GetPortalPage(objUserLogin.Role), returnUrl);
                            var userPortalUrl = fullUrl.Replace("api_user_login.ashx?action=login", portalPage);
                            _returnString = JsonHelper.GetEasyUiJsonStr(true, userPortalUrl, tblUserLogin.errorMsg);
                        }
                        break;
                    case "add":
                        var userRole = EnumHelper.ToEnum<UserRole>(context.Request.Params["user_role"]);
                        _returnString = JsonHelper.GetEasyUiJsonStr(tblUserLogin.Create(userAcc, userPwd, userRole), tblUserLogin.successMsg, tblUserLogin.errorMsg);
                        break;
                    case "save":
                        _returnString = JsonHelper.GetEasyUiJsonStr(
                            tblUserLogin.Update(Convert.ToInt32(context.Request.QueryString["id"]), context), tblUserLogin.successMsg, tblUserLogin.errorMsg);
                        break;
                    case "delete":
                        _returnString = JsonHelper.GetEasyUiJsonStr(tblUserLogin.Delete(Convert.ToInt32(context.Request.QueryString["id"])), tblUserLogin.successMsg, tblUserLogin.errorMsg);
                        break;
                    default:
                        _returnString = "undefined action";
                        break;
                }
                context.Response.Write(_returnString);
            }
        }
        catch (Exception ex) { context.Response.Write(string.Format("錯誤訊息: {0}", ex.Message)); }
    }

    private string GetTargetPage(string defaultPortal, string returnUrl)
    {
        return string.IsNullOrEmpty(returnUrl) ? defaultPortal : returnUrl;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}