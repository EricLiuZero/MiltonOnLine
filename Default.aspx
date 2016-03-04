<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>美爾頓英語線上課程選課系統</title>
    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/color.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
    <%--<link rel="stylesheet" href="css/admin.css" />--%>
    <%--<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>--%>
    <!-- Fix $.messager.progress('close'); -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <!-- Optional theme -->
    <%--<link rel="stylesheet" href="css/bootstrap-theme.min.css" />--%>
    <link rel="stylesheet" href="css/common.css" />
</head>
<body style="background-color: #35C4A3">
    <section>
        <div class="text-center">
            <div class="data-wrap">
                <div class="easyui-panel" title="美爾頓線上課程選課系統">
                    <form id="ff" method="post">
                        <table>
                            <tr>
                                <td>Email:</td>
                                <td><%--<input class="easyui-textbox" type="text" name="email" data-options="required:true,validType:'email',iconCls:'icon-mail'" style="width:100%;height:38px" />--%>
                                    <input class="easyui-textbox" name="user_acc" data-options="prompt:'your@email',iconCls:'icon-man'" style="width: 100%; height: 38px" required="true" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>密碼:</td>
                                <td>
                                    <input class="easyui-textbox" type="text" name="user_pwd" data-options="prompt:'請輸入密碼',iconCls:'icon-lock'" style="width: 100%; height: 38px" required="true" />
                                </td>
                            </tr>
                        </table>
                    </form>
                    <div style="text-align: center; padding-top: 1em">
                        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px" onclick="submitForm()">登入</a>
                        &nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px" onclick="clearForm()">重設</a>
                    </div>
                 </div>
            </div>
        </div>
    </section>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script type="text/javascript" src="scripts/jquery.easyui.min.js"></script>
    <script>
        $(function () {
            $('#ff').keypress(function (evt) {
                if (evt.which == 13)
                    submitForm();
            });
        });
        var url = 'api_user_login.ashx?action=login';
        function submitForm() {
            $('#ff').form('submit', {
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
                        $('#dlg').dialog('close'); // close the dialog
                        window.location.href = result.msg;
                    } else {
                        $.messager.show({
                            title: '失敗',
                            msg: result.errorMsg
                        });
                    }
                }
            });
        }
        function clearForm() {
            $('#ff').form('clear');
        }
    </script>
</body>
</html>
