<%@ WebHandler Language="C#" Class="ssc" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Configuration;
using System.Data.OleDb;
using System.Linq;
using Newtonsoft.Json;
using MldOnLine.Entity;
using EricLib.Utility;

public class ssc : IHttpHandler
{
    private string _successMsg = string.Empty;
    private string _errorMsg = string.Empty;
    private string _returnString = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            switch (context.Request.Params["action"])
            {
                case "get_all":
                    _returnString = GetAll(context.Request.QueryString["StudentID"].ToString());
                    break;
                case "add":
                    _returnString = JsonHelper.GetEasyUiJsonStr(Create(context), _successMsg, _errorMsg);
                    break;
                case "save":
                    _returnString = JsonHelper.GetEasyUiJsonStr(Update(Convert.ToInt32(context.Request.QueryString["id"]), context), _successMsg, _errorMsg);
                    break;
                case "delete":
                    _returnString = JsonHelper.GetEasyUiJsonStr(Delete(Convert.ToInt32(context.Request.Params["id"])), _successMsg, _errorMsg);
                    break;
                case "reset_id":
                    _returnString = ResetAutoNumber();
                    break;
                default:
                    _returnString = "[action] is null";
                    break;
            }
            context.Response.Write(_returnString);
        }
        catch (Exception ex) { context.Response.Write("錯誤訊息:" + ex.Message); }
    }

    private string GetAll(string studentID)
    {
        var dataList = new List<StudentClassChoice>();
        string sqlStr = @"SELECT b.ClassName AS ClassName, b.Degree AS ClassDegree, a.IsAttended, a.CreatedDate, a.UpdatedDate" + 
                        " FROM StudentClassChoice a JOIN ClassProfile b ON a.ClassId = b.Id WHERE StudnetID='" + studentID + "'";
        using (OleDbConnection myConnection = new OleDbConnection(GlobalConst.connStr))
        {
            OleDbCommand cmd = new OleDbCommand(sqlStr, myConnection);
            myConnection.Open();
            using (OleDbDataReader dr = cmd.ExecuteReader())
            {
                if (myConnection.State == ConnectionState.Closed)
                    myConnection.Open();

                try
                {
                    if (dr.HasRows)
                    {
                        dataList = dr.Cast<IDataRecord>().Select(row => new StudentClassChoice()
                        {
                            ClassName = row["ClassName"].ToString(),
                            ClassLevel = EnumHelper.ToEnum<ClassLevel>(Convert.ToInt16(row["ClassDegree"])),
                            IsAttended = Convert.ToInt16(row["IsAttended"]),
                            CreatedDate = row["CreatedDate"].ToString(),
                            UpdatedDate = row["UpdatedDate"].ToString()
                        }).ToList();
                    }
                    cmd.Cancel();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
        dataList.OrderByDescending(x => x.Id);

        var rlt = new StudentClassChoicePagination();
        rlt.total = dataList.Count().ToString();
        rlt.rows = dataList;
        return JsonConvert.SerializeObject(rlt, Newtonsoft.Json.Formatting.Indented);
    }

    private string GetClassName(int classId)
    {
        var dataList = new List<StudentClassChoice>();
        string sqlStr = @"SELECT ClassName FROM ClassProfile WHERE Id=" + classId;
        string className = string.Empty;
        
        using (OleDbConnection myConnection = new OleDbConnection(GlobalConst.connStr))
        {
            OleDbCommand cmd = new OleDbCommand(sqlStr, myConnection);
            myConnection.Open();
            using (OleDbDataReader dr = cmd.ExecuteReader())
            {
                if (myConnection.State == ConnectionState.Closed)
                    myConnection.Open();
                
                try
                {
                    if (dr.HasRows)
                        className = dr[0].ToString();
                    cmd.Cancel();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
        return JsonConvert.SerializeObject(className, Newtonsoft.Json.Formatting.Indented);
    }
    
    private bool Create(HttpContext context)
    {
        bool isSuccess = false;
        string sqlStr = @"INSERT INTO StudentClassChoice (StudentID, ClassId, CreatedDate) "
                        + "VALUES(?, ?, ?)";

        using (OleDbConnection myConnection = new OleDbConnection(GlobalConst.connStr))
        {
            myConnection.Open();
            using (OleDbCommand cmd = new OleDbCommand(sqlStr, myConnection))
            {
                if (myConnection.State == ConnectionState.Closed)
                    myConnection.Open();

                try
                {
                    cmd.Parameters.AddWithValue("StudentID", context.Request.Params["StudentID"]);
                    cmd.Parameters.AddWithValue("ClassId", context.Request.Params["ClassId"]);
                    cmd.Parameters.AddWithValue("CreatedDate", GlobalConst.dtNow);

                    cmd.ExecuteNonQuery();
                    isSuccess = true;
                    _successMsg = string.Format("新增選課", context.Request.Params["ClassName"]);
                }
                catch (Exception ex) { _errorMsg = ex.Message; }
                finally { DbHelper.releaseDBResource(myConnection, cmd); }
            }
        }

        return isSuccess;
    }

    private bool Update(int id, HttpContext context)
    {
        bool isSuccess = false;
        string sqlStr = @"UPDATE StudentClassChoice SET StudentID=?, ClassId=?, IsAttended=?, UpdatedDate=? WHERE Id=" + id;
        using (OleDbConnection myConnection = new OleDbConnection(GlobalConst.connStr))
        {
            myConnection.Open();
            using (OleDbCommand cmd = new OleDbCommand(sqlStr, myConnection))
            {
                if (myConnection.State == ConnectionState.Closed)
                    myConnection.Open();
                try
                {
                    cmd.Parameters.AddWithValue("StudentID", context.Request.Params["StudentID"]);
                    cmd.Parameters.AddWithValue("ClassId", context.Request.Params["ClassId"]);
                    cmd.Parameters.AddWithValue("IsAttended", context.Request.Params["IsAttended"]);
                    cmd.Parameters.AddWithValue("UpdatedDate", GlobalConst.dtNow);

                    cmd.ExecuteNonQuery();
                    isSuccess = true;
                    _successMsg = string.Format("更新({0})", id);
                }
                catch (Exception ex) { _errorMsg = ex.Message; }
                finally { DbHelper.releaseDBResource(myConnection, cmd); }
            }
        }

        return isSuccess;
    }

    private bool Delete(int id)
    {
        bool isSuccess = false;
        string sqlStr = @"DELETE FROM StudentClassChoice WHERE Id=?";
        using (OleDbConnection myConnection = new OleDbConnection(GlobalConst.connStr))
        {
            myConnection.Open();
            using (OleDbCommand cmd = new OleDbCommand(sqlStr, myConnection))
            {
                if (myConnection.State == ConnectionState.Closed)
                    myConnection.Open();
                try
                {
                    cmd.Parameters.AddWithValue("Id", id);

                    cmd.ExecuteNonQuery();
                    isSuccess = true;
                    _successMsg = string.Format("刪除選課", this.GetClassName(id));
                }
                catch (Exception ex) { _errorMsg = ex.Message; /*throw new Exception(ex.Message);*/ }
                finally { DbHelper.releaseDBResource(myConnection, cmd); }
            }
        }

        return isSuccess;
    }

    private string ResetAutoNumber()
    {
        string sqlStr = @"ALTER TABLE StudentClassChoice ALTER COLUMN Id COUNTER(1, 1)";
        using (OleDbConnection myConnection = new OleDbConnection(GlobalConst.connStr))
        {
            myConnection.Open();
            using (OleDbCommand cmd = new OleDbCommand(sqlStr, myConnection))
            {
                if (myConnection.State == ConnectionState.Closed)
                    myConnection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    return "reset success";
                }
                catch (Exception ex) { return ex.Message; }
                finally { DbHelper.releaseDBResource(myConnection, cmd); }
            }
        }
    }

    private static void releaseDBResource(OleDbConnection oleDbCon, OleDbCommand oleDbCmd)
    {
        if (oleDbCon != null)
        {
            try
            {
                oleDbCmd.Dispose();
                oleDbCon.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
                //log.Error(e.GetType() + " " + e.Message);
            }
        }
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}