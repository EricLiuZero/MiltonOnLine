using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EricLib.Utility;

public partial class AdminClassroom : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_acc"] == null)
        {
            Server.Transfer("Default.aspx?returnUrl=" + Request.FilePath, false);
        }
        else
        {
            user_cname.Text = Session["user_cname"].ToString();
            user_role.Value = Session["user_role"].ToString();
            if (EnumHelper.ToEnum<UserRole>(Convert.ToInt16(Session["user_role"])) == UserRole.Student)
            {
                if (Session["student_id"] == null)
                    Response.Redirect("Default.aspx?returnUrl=" + Request.FilePath, false);
            }
        }
    }
}