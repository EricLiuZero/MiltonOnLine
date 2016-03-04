<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminStudent.aspx.cs" Inherits="AdminStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>學員管理 | 美爾頓英語線上課程</title>
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
            <div id="cc" class="easyui-layout" style="height: 700px">
                <div data-options="region:'north',collapsible:false,split:false" style="height:75px;">
                    <div class="row">
                        <div class="col-md-6"><h4>美爾頓英語線上課程系統管理後台</h4></div>
                        <div class="col-md-6 text-right"><h4>使用者: <asp:Label ID="user_cname" Value="" runat="server" Style="color: blue" /></h4></div>
                    </div>
                </div>
                <div data-options="region:'center',collapsible:false,title:'學員管理'" style="height: 100%;">
                    <table id="dg" class="easyui-datagrid" toolbar="#toolbar" ></table>
                </div>
            </div>
        </div>
        <div id="toolbar">
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newUser()">新增</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-edit" plain="true" onclick="editUser()">編輯</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyUser()">刪除</a>
            </div>
    </form>
    <div id="dlg" class="easyui-dialog" style="width: auto; height: auto; padding: 10px 20px" data-option="" closed="true" buttons="#dlg-buttons">
        <div class="ftitle"></div>
        <form id="fm" method="post">
            <div class="fitem">
                <label>學號：</label>
                <input name="StudentID" class="easyui-textbox" validtype="StudentID" />
            </div>
            <div class="fitem">
                <label>程度：</label>
                <input name="ClassLevel" class="easyui-textbox" validtype="ClassLevel" />
            </div>
            <div class="fitem">
                <label>學生類別：</label>
                <select class="easyui-combobox" name="Type" data-options="panelWidth: 'auto', panelHeight: 'auto'" required="true">
                    <option value="新生">新生</option>
                    <option value="舊生">舊生</option>
                </select>
            </div>
            <div class="fitem">
                <label>中文姓名：</label>
                <input name="CName" class="easyui-textbox" validtype="CName" required="true" />
            </div>
            <div class="fitem">
                <label>英文姓名：</label>
                <input name="EName" class="easyui-textbox" validtype="EName" />
            </div>
            <div class="fitem">
                <label>性別：</label>
                <select class="easyui-combobox" name="Gender" data-options="panelWidth: 'auto', panelHeight: 'auto'">
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <div class="fitem">
                <label>Email：</label>
                <input name="Email" class="easyui-textbox" validtype="email" required="true" />
            </div>
            <div class="fitem">
                <label>個人電話：</label>
                <input name="Phone" class="easyui-textbox" validtype="Phone" required="true" />
            </div>
            <div class="fitem">
                <label>家長電話：</label>
                <input name="PhoneParents" class="easyui-textbox" validtype="PhoneParents" />
            </div>
            <div class="fitem">
                <label>建檔日期：</label>
                <%--<input name="RegistryDate" class="easyui-textbox" validtype="RegistryDate" />--%>
                <input name="RegistryDate" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
            </div>
            <div class="fitem">
                <label>試讀日期：</label>
                <input name="TrialDate" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
            </div>
            <div class="fitem">
                <label>諮詢顧問：</label>
                <input name="ConsultantName" class="easyui-textbox" validtype="ConsultantName" />
            </div>
            <div class="fitem">
                <label>備註資料：</label>
                <input name="Comment" class="easyui-textbox" data-options="multiline:true" style="width: 100px; height: 50px" />
            </div>
            <div class="fitem">
                <label>完成報名：</label>
                <select class="easyui-combobox" name="IsRegistered" required="true" data-options="panelWidth: 'auto', panelHeight: 'auto'">
                    <option value="1">是</option>
                    <option value="0">否</option>
                </select>
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
    <%--<script type="text/javascript" src="scripts/admin_student.js"></script>--%>
    <script type="text/javascript">
        var _apiUrl = 'api_student.ashx';
        $(function () {
            setMenu($('#user_role').val());
            initDataGrid();
        });

        function initDataGrid() {
            $('#dg').datagrid({
                //title: '學員資料管理',// + $('#user_cname').val(),
                url: _apiUrl + '?action=get_all',
                loadFilter: pagerFilter,
                columns: [[
                    { field: 'StudentID', title: '學號', align: 'right' },
                    {
                        field: 'ClassLevel', title: '等級', align: 'right'
                        , formatter: function (value, index) {
                            switch (value) {
                                case 1: return '<a style="color:green">Beginner</a>';
                                case 2: return '<a style="color:blue">Elementary</a>';
                                case 3: return '<a style="color:red">Intermediate</a>';
                            }
                        }
                    },
                    {
                        field: 'IsRegistered'
                        , title: '完成報名', align: 'right'
                        , formatter: function (value, index) {
                            switch (value) {
                                case 1: return '<a style="color:blue">是</a>';
                                case 0: return '<a style="color:red">否</a>';
                            }
                        }
                    },
                    { field: 'CName', title: '中文姓名', align: 'right' },
                    { field: 'EName', title: '英文姓名', align: 'right' },
                    { field: 'Gender', title: '性別', align: 'right' },//,formatter: function(value,row,index){ return (value==true) ? '男' : '女'; }
                    { field: 'Email', title: 'Email', align: 'right' },
                    { field: 'Phone', title: '聯絡電話', align: 'right' },
                    { field: 'PhoneParents', title: '家長電話', align: 'right' },
                    { field: 'ConsultantName', title: '諮詢顧問', align: 'right' },
                    { field: 'TrialDate', title: '試讀日期', align: 'right' },
                    { field: 'RegistryDate', title: '建檔日期', align: 'right' },
                    { field: 'Comment', title: '備註資料', align: 'right' },
                    { field: 'CreatedDate', title: '建立時間', formatter: function (value, index) { return '<a style="color:gray">' + value + '</a>'; } },
                    { field: 'UpdatedDate', title: '更新時間', formatter: function (value, index) { return '<a style="color:gray">' + value + '</a>'; } }
                ]],
                fit: true,
                fitcolumns: true,
                autoRowHeight: true,
                rownumbers: true,
                singleselect: true,
                pagination: true,
                pageNumber: 1,
                pageSize: 15,
                pageList: [15, 30, 45, 60]
            });

            $('#dg').datagrid('getPager').pagination({
                beforePageText: '第',
                afterPageText: '頁',
                displayMsg: '顯示 [{from}] 到 [{to}] 共 [{total}] 筆'
            });
        }

        var url;
        function newUser() {
            $('#dlg').dialog('open').dialog('setTitle', '新增資料');
            $('#fm').form('clear');
            url = _apiUrl + '?action=add';
        }
        function editUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $('#dlg').dialog('open').dialog('setTitle', '編輯資料');
                $('#fm').form('load', row);
                url = _apiUrl + '?action=save&id=' + row.Id;
            }
        }
        function saveUser() {
            $('#fm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.show({
                            title: '成功',
                            msg: result.msg
                        });
                        $('#dlg').dialog('close');        // close the dialog
                        $('#dg').datagrid('reload');    // reload the user data
                    } else {
                        $.messager.show({
                            title: '失敗',
                            msg: result.errorMsg
                        });
                    }
                }
            });
        }
        function destroyUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $.messager.confirm('刪除資料', '是否確定刪除此筆資料？', function (r) {
                    if (r) {
                        $.post(_apiUrl + '?action=delete', { id: row.Id }, function (result) {
                            if (result.success) {
                                $.messager.show({    // show error message
                                    title: '成功',
                                    msg: result.msg
                                });
                                $('#dg').datagrid('reload');    // reload the user data
                            } else {
                                $.messager.show({    // show error message
                                    title: '失敗',
                                    msg: result.errorMsg
                                });
                            }
                        }, 'json');
                    }
                });
            }
        }

        function pagerFilter(data) {
            if (typeof data.length == 'number' && typeof data.splice == 'function') {    // is array
                data = {
                    total: data.length,
                    rows: data
                }
            }
            var dg = $(this);
            var opts = dg.datagrid('options');
            var pager = dg.datagrid('getPager');
            pager.pagination({
                onSelectPage: function (pageNum, pageSize) {
                    opts.pageNumber = pageNum;
                    opts.pageSize = pageSize;
                    pager.pagination('refresh', {
                        pageNumber: pageNum,
                        pageSize: pageSize
                    });
                    dg.datagrid('loadData', data);
                }
            });
            if (!data.originalRows) {
                data.originalRows = (data.rows);
            }
            var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
            var end = start + parseInt(opts.pageSize);
            data.rows = (data.originalRows.slice(start, end));
            return data;
        }

        function doSearch() {
            $('#dg').datagrid('load', {
                No: $('#itemid').val(),
                //productid: $('#productid').val()
            });
        }

        function myformatter(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        }
        function myparser(s) {
            if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        }
    </script>
</body>
</html>