using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string sql = "select * from sys_config where name='online'";
            //dt = LeoDbOleDb.Get_Table(sql, constr);
            //string activeValue = dt.Rows[0]["active"].ToString();
            ////string isActive = ConfigurationManager.AppSettings["active_mode"];
            ////if (isActive != "true")
            //if (activeValue != "1")
            //{
            //    user_id.Enabled = false;
            //    user_pwd.Enabled = false;
            //    Button1.Enabled = false;
            //    msg.Text = "系統維護中,請稍候再次登入!";
            //    return;
            //}
            //user_id.Focus();
        }
    }
}