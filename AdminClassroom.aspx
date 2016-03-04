<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminClassroom.aspx.cs" Inherits="AdminClassroom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>教室管理 | 美爾頓英語線上課程</title>
    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/color.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
</head>
<body>
    <form id="Form1" runat="server">
        <asp:HiddenField ID="user_role" Value="" runat="server" />
        <div class="well well-sm">
            <div id="cc" class="easyui-layout" style="height: 630px">
                <div data-options="region:'north',collapsible:false,split:false" style="height:75px;">
                    <div class="row">
                        <div class="col-md-6"><h4>美爾頓英語線上課程系統管理後台</h4></div>
                        <div class="col-md-6 text-right"><h4>使用者: <asp:Label ID="user_cname" Value="" runat="server" Style="color: blue" /></h4></div>
                    </div>
                </div>
                <div data-options="region:'center',collapsible:false,title:'教室管理'" style="height: 100%;">
                    <table id="dg" class="easyui-datagrid" toolbar="#toolbar" ></table>
                </div>
            </div>
            <div id="toolbar">
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newUser()">新增</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-edit" plain="true" onclick="editUser()">編輯</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyUser()">刪除</a>
            </div>
        </div>
    </form>
    <div id="dlg" class="easyui-dialog" style="width: 500px; height: auto; padding: 10px 20px" data-option="" closed="true" buttons="#dlg-buttons">
        <form id="fm" method="post">
            <div class="fitem">
                <label>課程等級：</label>
                <select class="easyui-combobox" name="ClassLevel" validtype="ClassLevel" required="true" 
                    data-options="panelWidth: 'auto', panelHeight: 'auto', prompt:'Select', 
                        onSelect: function(rec){
                            var url = 'api_class.ashx?action=get_textidpairs&class_lv='+rec.value;
                            $('#ClassId').combobox('reload', url);
                            $('#ClassId').combobox('setValue', '');
                        }">
                    <option value="1">Beginner</option>
                    <option value="2">Elementary</option>
                    <option value="3">Intermediate</option>
                </select>
            </div>
            <div class="fitem">
                <label>課程名稱：</label>
                <select class="easyui-combobox" id="ClassId" name="ClassId" validtype="ClassId" required="true" style="width:300px;"  
                    data-options="panelWidth: '300', panelHeight: 'auto', valueField: 'ClassId', textField: 'Text'">
                </select>
            </div>
            <div class="fitem">
                <label>課程日期：</label>
                <input name="ClassDate" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" style="width:50%;" validtype="ClassDate" required="true"/>
            </div>
            <div class="fitem">
                <label>開始時間：</label>
                <input name="BeginTime" class="easyui-timespinner" style="width:50%;" validtype="BeginTime" required="true" />
            </div>
            <div class="fitem">
                <label>結束時間：</label>
                <input name="EndTime" class="easyui-timespinner" style="width:50%;" validtype="EndTime" required="true" />
            </div>
            <div class="fitem">
                <label>備註：</label>
                <input name="Comment" class="easyui-textbox" data-options="multiline:true" style="width: 300px; height: 100px" />
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconcls="icon-ok" onclick="saveUser()" style="width: 90px">儲存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width: 90px">取消</a>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="scripts/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="scripts/common.js"></script>
    <script type="text/javascript" src="scripts/admin_classroom.js"></script>
</body>
</html>