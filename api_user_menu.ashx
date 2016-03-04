<%@ WebHandler Language="C#" Class="api_usermenu" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Configuration;
using System.Data.OleDb;
using System.Linq;
using MldOnLine.TableHelper;
using EricLib.Utility;

public class api_usermenu : IHttpHandler
{
    private readonly string connStr = ConfigurationManager.ConnectionStrings["dbmldol"].ConnectionString;
    private readonly string dtNow = DateTime.Now.ToString("yyyy-MM-dd hh:mm");
    private Dictionary<string, string> menuItems = new Dictionary<string, string>() {
        {"AdminStudent", @"<a href=""AdminStudent.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-users fa-fw""></i>&nbsp;學員管理</a>"}
        , {"AdminClass", @"<a href=""AdminClass.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-book fa-fw""></i>&nbsp;課程管理</a>"}
        , {"AdminClassroom", @"<a href=""AdminClassroom.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-video-camera fa-fw""></i>&nbsp;教室管理</a>"}
        , {"Contract", @"<a href=""Contract.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-check-square-o fa-fw""></i>&nbsp;課程服務契約</a>"}
        , {"MyClass", @"<a href=""MyClass.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-pencil fa-fw""></i>&nbsp;我的教室</a>"}
        , {"Logout", @"<a href=""Logout.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-sign-out fa-fw""></i>&nbsp;登出</a>"}
    };
    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string returnString = string.Empty;
        try
        {
            if (context.Request.Params.Count != 0)
            {
                if (context.Request.Params["user_role"] != null)
                {
                    var userRole = EnumHelper.ToEnum<UserRole>(context.Request.Params["user_role"]);
                    returnString = GetMenu(userRole);
                }
                else if (context.Request.Params["user_acc"] != null && context.Request.Params["user_pwd"] != null)
                {
                    var tblUserLogin = new TblUserLogin();
                    var userAcc = context.Request.Params["user_acc"];
                    var userPwd = context.Request.Params["user_pwd"];
                    returnString = tblUserLogin.IsValidLogin(userAcc, userPwd) ? GetMenu(tblUserLogin.GetUserLogin(userAcc).Role) : "帳號或密碼錯誤";
                }
                else returnString = "online";
            }
            context.Response.Write(returnString);
        }
        catch (Exception ex) { context.Response.Write("錯誤訊息:" + ex.Message); }
    }

    private string GetUserMenu(string items) {
        return string.Format("<div class='easyui-panel' style='padding: 5px'>{0}</div>", items);
    }

    public string GetMenu(UserRole role) {
        string returnString = string.Empty;
        switch (role)
        {
            case UserRole.Admin:
                returnString = GetMenuAdmin();
                break;
            case UserRole.Operator:
                returnString = GetMenuItemsStudent();
                break;
            case UserRole.Sale:
                returnString = GetMenuItemsStudent();
                break;
            case UserRole.Student:
                returnString = GetMenuItemsStudent();
                break;
            default:
                break;
        }
        return returnString;
    }

    public string GetMenuAdmin()
    {
        //string items = @"<a href=""AdminStudent.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-users fa-fw""></i>&nbsp;學員管理</a>"
        //        + @"<a href=""AdminClass.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-book fa-fw""></i>&nbsp;課程管理</a>"                
        //        + @"<a href=""Contract.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-check-square-o fa-fw""></i>&nbsp;服務契約</a>"
        //        + @"<a href=""Logout.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-sign-out fa-fw""></i>&nbsp;登出</a>";
        string items = string.Concat(menuItems["AdminStudent"], menuItems["AdminClass"], menuItems["AdminClassroom"], menuItems["Contract"], menuItems["Logout"]);
        return GetUserMenu(items);
    }

    public string GetMenuOperator()
    {
        //string items = @"<a href=""AdminStudent.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-users fa-fw""></i>&nbsp;學員管理</a>"
        //        + @"<a href=""AdminClass.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-book fa-fw""></i>&nbsp;課程管理</a>"                
        //        + @"<a href=""Contract.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-check-square-o fa-fw""></i>&nbsp;服務契約</a>"
        //        + @"<a href=""Logout.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-sign-out fa-fw""></i>&nbsp;登出</a>";
        string items = string.Concat(menuItems["AdminStudent"], menuItems["AdminClass"], menuItems["Contract"], menuItems["Logout"]);
        return GetUserMenu(items);
    }

    public string GetMenuSales()
    {
        //string items = @"<a href=""AdminStudent.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-users fa-fw""></i>&nbsp;學員管理</a>"
        //        + @"<a href=""AdminClass.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-book fa-fw""></i>&nbsp;課程管理</a>"                
        //        + @"<a href=""Contract.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-check-square-o fa-fw""></i>&nbsp;服務契約</a>"
        //        + @"<a href=""Logout.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-sign-out fa-fw""></i>&nbsp;登出</a>";
        string items = string.Concat(menuItems["AdminStudent"], menuItems["AdminClass"], menuItems["Contract"], menuItems["Logout"]);
        return GetUserMenu(items);
    }

    public string GetMenuItemsStudent() {
        //string items = @"<a href=""StudentClassList.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-pencil fa-fw""></i>&nbsp;個人選課管理</a>"
        //        + @"<a href=""Contract.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-check-square-o fa-fw""></i>&nbsp;服務契約</a>"
        //        + @"<a href=""Logout.aspx"" class=""easyui-linkbutton"" data-options=""plain:true""><i class=""fa fa-sign-out fa-fw""></i>&nbsp;登出</a>";
        string items = string.Concat(menuItems["MyClass"], menuItems["Contract"], menuItems["Logout"]);
        return GetUserMenu(items);
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}