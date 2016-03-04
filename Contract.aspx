<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contract.aspx.cs" Inherits="Contract" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>服務契約 | 美爾頓英語線上課程</title>
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
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />
</head>
<body>
    <form id="Form1" runat="server">
        <asp:HiddenField ID="user_role" Value="" runat="server" />
        <div class="well well-sm">
            <div id="cc" class="easyui-layout" style="height: 630px">
                <div data-options="region:'north',collapsible:false,split:false" style="height: 75px;">
                    <div class="row">
                        <div class="col-md-6">
                            <h4>美爾頓英語線上課程系統管理後台</h4>
                        </div>
                        <div class="col-md-6 text-right">
                            <h4>使用者:
                                <asp:Label ID="user_cname" Value="" runat="server" Style="color: blue" /></h4>
                        </div>
                    </div>
                </div>
                <div data-options="region:'center',collapsible:false,title:'教室管理'" style="height: 100%;">
                    <div class="text-center">
                        <h2>美爾頓英語 線上課程服務契約
                        </h2>
                    </div>
                    <p>
                        歡迎加入美爾頓英語! 我們希望在學習英文時能給您最大的幫助~ 雙方約定下列條款，請詳細閱讀並共同遵守。
                    </p>

                    <p><strong>一. 一般事項</strong></p>
                    <ul style="list-style: none">
                        <li>1. 報名就讀後，須依個人程度、時間、及本班現況開設之課程表中，於約定之課程<strong>有效期間</strong>及<strong>堂數限制</strong>內，主動上網排定適合個人之課表並出席上課。<strong>課程有效期間</strong>或<strong>堂數</strong>
                            兩者任一條件先到達，視為合約期滿、課程服務結束。
                        </li>
                        <li>2. 本班於收據載明約定開課日起，開放報名課程供學員上課，請學員積極出席。自約定開課日起，若未及時選課、上課、或選課後未出席、或出席堂數不足、或逾期未修畢者，視為曠課，將由報名課程中扣除該堂堂數。
                        </li>
                        <li>3. 排課規定請參考「學員選課系統」排課須知。本班保有修改「學員選課系統」、「排課須知」及「模考須知」等規定的權利。
                        </li>
                        <li>
                            <strong>4. </strong>
                            <strong>學員上課前需上網登入排課。例如 : 中午12點後的課程，需在12小時前排課。中午12點前的課程，需在24小時前排課。</strong>
                        </li>
                        <li>5. 學員需<strong>依事實</strong>填寫「學員基本資料」，以便本班以電子郵件、簡訊或電話等方式通知課程訊息或異動。<strong>通訊資料如有更動，請學員務必告知補習班以便修改</strong>
                            。若因學員未主動告知、資料填寫不清或錯誤、電話或網路斷訊等非本班所能控制因素，導致本班無法即時通知學員課程異動訊息，學員自行負責，且<strong>不得以此為由要求退費或補償</strong>。
                        </li>
                        <li>6. 本班線上課程限報名線上課程之學員本人使用。若無該堂課上課權限，或該課程上課期限已到期者而逕入線上教室上課者，本班得請其離開線上教室。
                        </li>
                        <li>7. 未報名付費或未經本班同意而擅入教室上課情節嚴重者，將報警究辦。
                        </li>
                        <li>
                            <strong>8. </strong>
                            為維護其他學員權益、避免干擾課堂，<strong>學員選課後遲到超過20分鐘，不得進入教室上課。</strong>
                        </li>
                        <li>9. 本班「線上課程學員選課系統」網站內容，若與本課程服務契約日期不符，<strong>以本課程服務契約為準</strong>。
                        </li>
                    </ul>

                    <p><strong>二. 學員權益相關 </strong></p>
                    <ul style="list-style: none">
                        <li>
                            <strong>1. 延期</strong>
                            <ul style="list-style: none">
                                <li>A. <strong>學員報名課程後，</strong>如需延後課程，請學員在課程到期日前以電子郵件提出申請，本班將以電子郵件郵寄「<strong>會員期限延期申請表</strong>」給學員。學員填寫完畢寄回郵件，補習班以電子郵件或電話確認完成手續。延期需<strong>繳交200元手續費</strong>。</li>
                                <li>B. <strong>30堂課課程可延期1個月，60堂課程可延期2個月，90堂課程可延期3個月。每種課程申請延期以一次為限。延期期限需再復課時一次使用完畢，已申請延期，不得再申請退費。</strong></li>
                                <li>C. 其他規定詳見本班「<strong>會員期限保留延期申請</strong>」規定。本班保留更改「會員期限延期申請」規定或申請條件之權利，<strong>學員報名即代表接受以上規定。</strong></li>
                            </ul>
                        </li>
                        <li>
                            <strong>2. </strong>
                            <strong>請假 / 曠課 / 課程銜接 / 候補</strong>
                            <ul style="list-style: none">
                                <li>A. 學員登記排課後，若預知無法出席，<strong>請學員於上課4小時前，</strong>至美爾頓官網「學員選課系統」退選課程，缺課內容請學員於課程有效期間內補課完畢。<strong></strong></li>
                                <li>B. <strong>選課後未取消課程或缺席者，除視為曠課並扣除課程堂數</strong>外，選課系統自動將學員由所有已選課名單中刪除，學員需重新上網排課。<strong></strong></li>
                                <li>C. 學員需於報名時確認所有課程銜接順序，排課後可於「學員選課系統」中自行設定(或修改)選修課程順序。本班課程不提供電話或線上候補登記。<strong><u></u></strong></li>
                            </ul>
                        </li>
                        <li>
                            <strong>3. </strong>
                            <strong>課程轉讓</strong>
                            <ul style="list-style: none">
                                <li>A. 需於未達會員期限(或已使用總課程時數)1/3期間內，辦理轉讓課程手續。
                                </li>
                                <li>B. 申請課程<strong>轉讓學員，需繳交200元手續費</strong>。
                                </li>
                                <li>C. 接受轉讓課程之學員，需<strong>繳測驗費200元完成分級檢測，</strong>接受轉讓課程之學員需依檢測後程度入班就讀。
                                </li>
                                <li>&nbsp;</li>
                                <li>學員若有下列不當行為之一者，本班得不經通知提前中止學員權限或報警處理。<strong></strong>
                                </li>
                                <li>D. 學員擾亂上課秩序或違反本合約之規定，且情節重大者。<strong></strong>
                                </li>
                                <li>E. 學員於上課期間羞辱或危害授課教師、工作人員或其他學員。
                                </li>
                                <li>F. 公開線上教室網路連結或將帳號密碼交由他人使用，經本班查明屬實者。
                                </li>
                                <li>G. 將報名堂數給他人或多人共同使用。
                                </li>
                            </ul>
                        </li>

                        <li>4. <strong>退費相關規定(請務必詳細閱讀)</strong><br />
                            <ul style="list-style: none">
                                <li>學員註冊後欲申請退費時，依下列規定辦理:</li>
                                <li>A. <strong>辦理退費請於 _______ 年 _____ 月 _____ 日前且實際上課堂數未逾1/3(含)前提出，</strong></li>
                                <li>詳細規定及辦法依<u>台北市教育局規定</u>辦理。</li>
                                <li>B. 退費申請依【申請退費日】與【約定開課日】之期間，為【在班期間】計算退費。</li>
                                <li>C. 學員於開課前第60日前提出申請，退還所交學費總金額95%，惟補習班所收之學費5%金額不得超過新臺幣壹仟元。</li>
                                <li>D. 學員於開課日前第59日至開課日前提出退費申請，退還所交學費總金額90%，惟補習班所收學費之10%金額不得超過新台幣壹仟元。</li>
                                <li>E. 學員於實際開課日起第二日(或次)上課前(不含當次)提出退費申請，補習班退還所繳學費總額70%。</li>
                                <li>F. 學員於實際開課日起第二日(或次)上課後且未逾全期(或總課程堂數)1/3期間內提出退費申請，補習班退還所繳學費總額50%。</li>
                                <li>G. 學員於實際開課期間已逾全期(或總課程堂數)1/3者，所繳學費補習班不予退還。</li>
                            </ul>
                        </li>
                        <li>5. 補習班於學員購買課程前提供試聽機會(形式不拘)。
                        </li>
                        <li>6. 未經學員書面同意，補習班不得將學員資料提供給第三人或做不當利用。
                        </li>
                    </ul>

                    <p><strong>三. 購買課程內容</strong></p>
                    <ul style="list-style: none">
                        <li>1. 約定開課日：以收據開立課程開始日期實際開課日，課程權限由當天開始計算。自該日起，學員務必於會員課程有效期間內，自行排定適當課程且上課完畢，逾期失效。如因故無法排課、上課、或排課後不出席、或出席堂數不足、或逾期未修畢者，均視為曠課並扣除該堂課程。學員若欲辦理退費，以收據記載開課日做為基準辦理。</li>
                        <li>2. 約定課程類別(三選一)：
                        <ul>
                            <li>線上會員30堂(3個月)</li>
                            <li>線上會員60堂(4個月)</li>
                            <li>線上會員90堂(5個月)</li>
                        </ul>
                        </li>
                        <li>3. 為確保學員學習成效:
                        <ul>
                            <li>報名線上會員30堂課程學員，每月應最少出席4堂。</li>
                            <li>報名線上會員60堂課程學員，每月應最少出席5堂。</li>
                            <li>報名線上會員90堂課程學員，每月應最少出席6堂。</li>
                        </ul>
                        </li>
                        <li>4. 學員當月未將約定最低堂數使用完畢，系統將自動扣除當月最低堂數，請學員多加留意。</li>
                        <li>5. 請確實登入「學員選課系統」，並留意每月最低應上課堂數確實上課，以確保學習成效。</li>
                    </ul>
                </div>
            </div>
        </div>
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script type="text/javascript" src="scripts/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="scripts/common.js"></script>

    <script type="text/javascript">
        $(function () {
            setMenu($('#user_role').val());
        });
    </script>
</body>
</html>