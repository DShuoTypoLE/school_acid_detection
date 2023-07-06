<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiAdmin/src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiAdmin/src/layuiadmin/style/admin.css" media="all">
    <style>
        <%--    南邮标题样式    --%>
        #font-div {
            line-height: 137px;
            text-align: center;
            margin: 10px auto;
            text-shadow: 9px 8px 5px #5fb0b8;
            font-size: 44px;
            font-family: "幼圆";
            color: rgb(68, 84, 106);
            font-weight: bold;
        /*    设置鼠标划过,字体放大*/
            overflow: hidden;
            cursor: pointer;/*鼠标变成手指样式*/
            transition: all 0.6s;/*所有属性变化在0.6秒内执行动画*/
        }
        #font-div:hover{
            transform: scale(1.2);/*鼠标放上之后元素变成1.4倍大小*/
        }

        /*cite标签悬停颜色改变*/
        cite:hover {
            color: orange !important;
            font-size: large;
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/openStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/openStyle1.css">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">快捷方式</div>
                        <div class="layui-card-body">

                            <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                                <div carousel-item>
                                    <ul class="layui-row layui-col-space10">
                                        <li class="layui-col-xs3">
                                            <a href="userPageToUserChannel">
                                                <i class="layui-icon layui-icon-console"></i>
                                                <cite>查询检测通道</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a>
                                                <i class="layui-icon layui-icon-chart"></i>
                                                <cite id="startQueue">开始排队</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a>
                                                <i class="layui-icon layui-icon-template-1"></i>
                                                <cite id="predicatePage">预测排队时间</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a href="#notice">
                                                <i class="layui-icon layui-icon-chat"></i>
                                                <cite>查看通知</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a>
                                                <i class="layui-icon layui-icon-find-fill"></i>
                                                <cite id="findResult">查询检测结果</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a>
                                                <i class="layui-icon layui-icon-survey"></i>
                                                <cite id="recordInfo">查询检测记录</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a href="../user/findUserInfo">
                                                <i class="layui-icon layui-icon-user"></i>
                                                <cite>用户个人信息</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a>
                                                <i class="layui-icon layui-icon-set"></i>
                                                <cite id="userUpdatePwd">修改密码</cite>
                                            </a>
                                        </li>
                                    </ul>
                                    <ul class="layui-row layui-col-space10">
                                        <li class="layui-col-xs3">
                                            <a href="${pageContext.request.contextPath}/index.jsp">
                                                <i class="layui-icon layui-icon-console"></i>
                                                <cite id="endQueue">退出登录</cite>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">所属单位</div>
                        <div class="layui-card-body">

                            <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                <div id="font-div">
                                    南京邮电大学通达学院
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">数据概览</div>
                        <div class="layui-card-body">

                            <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" lay-filter="LAY-index-dataview">
                                <div carousel-item id="LAY-index-dataview">
                                    <div><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
                                    <div id="div_pie_chart"></div>
                                    <div></div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="layui-card">
                        <div class="layui-tab layui-tab-brief layadmin-latestData">
                            <ul class="layui-tab-title">
                                <li class="layui-this" id="notice">通知公告</li>
                                <li>疫情相关</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <table id="LAY-index-topSearch"></table>
                                </div>
                                <div class="layui-tab-item">
                                    <table id="LAY-index-topCard"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">防疫科普小视频</div>
                <div class="layui-card-body layui-text">
                    <video src="${pageContext.request.contextPath}/images/fy.mp4" controls="controls" loop="loop"
                           width="486px" height="200px"></video>
                </div>
            </div>

            <div class="layui-card">
                <div class="layui-card-header">友情链接</div>
                <div class="layui-card-body">
                    <div class="layui-carousel layadmin-carousel layadmin-news" data-autoplay="true" data-anim="fade" lay-filter="news">
                        <div carousel-item>
                            <div><a href="https://www.nytdc.edu.cn/" target="_blank" class="layui-bg-red">南京邮电大学通达学院官网</a></div>
                            <div><a href="https://www.xuexi.cn/" target="_blank" class="layui-bg-green">学习强国</a></div>
                            <div><a href="https://www.gov.cn/" target="_blank" class="layui-bg-blue">中共中央人民政府</a></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-card">
                <div class="layui-card-header">
                    作者心语
                    <i class="layui-icon layui-icon-tips" lay-tips="要支持的噢" lay-offset="5"></i>
                </div>
                <div class="layui-card-body layui-text layadmin-text">
                    <p>本系统创作的动力源自校园中众多人员核酸检测是以多轮次、大规模的形式,每当此时校园中各个核酸检测通道就会排起队伍"长龙"!</p>
                    <p>为此,在导师和同学的帮助下开始设计一款适用于此情形的系统模型来解决实际问题!</p>
                    <p>当然,其中仍有不足之处需要不断优化,如果你有好的想法或者对页面功能或者布局有更好的灵感,请（<a href="mailto:2870728720@qq.com" target="_blank">联系作者</a>）!</p>
                    <p>—— 爱记笔记的楽</p>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/static/layuiAdmin/src/layuiadmin/layui/layui.js?t=1"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/static/layuiAdmin/src/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'console','carousel', 'echarts']);
</script>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<%--用户点击加入排队--%>
<script><%-- 使用ajax实现数据库数据交互 --%>
    layui.use('layer', function(){
        $("#startQueue").click(function (){
            //通过用户名和密码得到用户id
            //通过uid修改排队状态N-->Y
            $.ajax({
                url:'../user/startQueue',
                type:'get',
                dataType:'text',
                success:function (res){
                    if(res=="success"){
                        layer.msg("您已加入排队!",{time: 1000},function (){
                            //点击开始排队以后刷新列表
                            window.location.reload();
                        });
                    }
                },
                error:function (res){
                    if (res=="fail"){
                        layer.msg("排队失败...");
                    }
                }
            });
            return false;//重要,不让layui执行默认的表单提交,执行回调函数
        });
    });
</script>
<%--退出登陆时修改排队状态为N--%>
<script>
    //实现退出登录时修改排队状态
    $(function (){
        $("#endQueue").click(function (){
            $.ajax({
                url:'../user/endQueue',
                type:'get',
                dataType:'text'
                //这里就不做响应了
            });
        });
    });
</script>
<%--预测排队时间--%>
<script>
    layui.use('layer', function(){
        $("#predicatePage").click(function (){
            layer.open({
                type: 2,
                title: '预测排队时间',
                shadeClose: true,
                shade: 0.8,
                skin:'layerdemo',
                area: ['580px', '90%'],
                shadeClose: true,//shadeClose为true时，点击非弹出框的其他地方，弹出框消失。
                content: '${pageContext.request.contextPath}/user/predictQueueTime' //iframe的url
            });

            return false;
        });
    });
</script>
<%--查询检测结果--%>
<script>
    layui.use('layer', function(){
        $("#findResult").click(function (){
            layer.open({
                type: 2,
                title: '核酸检测结果',
                shadeClose: true,
                shade: 0.8,
                skin: 'layerdemo1',
                area: ['255px', '160px'],
                shadeClose: true,//shadeClose为true时，点击非弹出框的其他地方，弹出框消失。
                content: '${pageContext.request.contextPath}/user/findDetectionResult' //iframe的url
            });

            return false;
        });
    });
</script>
<%--查询检测记录--%>
<script>
    layui.use('layer', function(){
        $("#recordInfo").click(function (){
            layer.open({
                type: 2,
                title: '核酸检测记录',
                offset: 'r',//右边
                anim: 5,//渐显
                shade: 0.8,
                skin: 'layerdemo',
                area: ['620px', '100%'],
                shadeClose: true,//shadeClose为true时，点击非弹出框的其他地方，弹出框消失。
                content: '${pageContext.request.contextPath}/page/detectionRecordInfo' //iframe的url
            });

            return false;
        });
    });
</script>
<%--用户修改密码--%>
<script>
    layui.use('layer', function(){
        $("#userUpdatePwd").click(function (){
            layer.open({
                type: 2,
                title: '修改密码',
                shadeClose: true,
                shade: 0.8,
                skin:'layerdemo',
                area: ['350px', '430px'],
                shadeClose: true,//shadeClose为true时，点击非弹出框的其他地方，弹出框消失。
                content: '${pageContext.request.contextPath}/page/userPageToUserChangePassword' //iframe的url
            });

            return false;
        });
    });
</script>
<%--这是隐藏的游戏彩蛋,在控制台可以玩哦!如果你无聊的话(｡･∀･)ﾉﾞ--%>
<script src="${pageContext.request.contextPath}/js/hiddenGame.js"></script>
</body>
</html>

