<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/11
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>校园核酸检测系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css">
</head>
<body onload="showtime()">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black layui-icon layui-icon-component">校园核酸检测系统</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>

            <li class="layui-nav-item layui-hide-xs">
                <b style="color: #40AFFE;size: A3">抗击疫情是一场全民行动，核酸检测是一道你我防线!</b>
            </li>
            <%--            <li class="layui-nav-item layui-hide-xs"><a href="">nav 2</a></li>--%>
            <%--            <li class="layui-nav-item layui-hide-xs"><a href="">nav 3</a></li>--%>
            <%--            <li class="layui-nav-item">--%>
            <%--                <a href="javascript:;">nav groups</a>--%>
            <%--                <dl class="layui-nav-child">--%>
            <%--                    <dd><a href="">menu 11</a></dd>--%>
            <%--                    <dd><a href="">menu 22</a></dd>--%>
            <%--                    <dd><a href="">menu 33</a></dd>--%>
            <%--                </dl>--%>
            <%--            </li>--%>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item " >
                <span id="clock" style="color:#ffffff"></span>
            </li>
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <a href="javascript:;">
                    <img src="${pageContext.request.contextPath}/images/1.jpg" class="layui-nav-img">
                    管理员
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/index.jsp" id="endQueue">Sign out</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <!-- 让页面加载完成后被选中 -->
                <li class="layui-nav-item layui-nav-itemed layui-this">
                    <a class="" href="${pageContext.request.contextPath}/page/adminPageToMain"><i class="layui-icon layui-icon-home"></i> 后台首页</a>
                    <%--                    <dl class="layui-nav-child">--%>
                    <%--                        <dd class="layui-this"><a href="><i class="layui-icon layui-icon-read"></i> 首页</a></dd>--%>
                    <%--                    </dl>--%>
                </li>
                <li class="layui-nav-item layui-nav-item">
                    <a class="" href="javascript:;"><i class="layui-icon layui-icon-username"></i> 我的面板</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToAdminInfo" id="getAdminInfo"><i class="layui-icon layui-icon-username"></i> 个人信息</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToAdminChangePassword"><i class="layui-icon layui-icon-password"></i> 修改密码</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-item">
                    <a class="" href="javascript:;"><i class="layui-icon layui-icon-search"></i> 管理员查询</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToFindChannel"><i class="layui-icon layui-icon-location"></i> 查询检测通道</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon layui-icon-friends"></i> 用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToAllUserList"><i class="layui-icon layui-icon-search"></i> 查询用户信息</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToAddUser"><i class="layui-icon layui-icon-add-1"></i> 添加用户</a></dd>
                        <%--                        <dd><a href="javascript:;">删除用户信息</a></dd>--%>
                        <%--                        <dd><a href="">修改用户信息</a></dd>--%>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon layui-icon-chat"></i> admin管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToAllAdminList"><i class="layui-icon layui-icon-search"></i> 查询管理员信息</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/page/adminPageToAddAdmin"><i class="layui-icon layui-icon-add-1"></i> 添加管理员</a></dd>
                        <%--                        <dd><a href="javascript:;">删除管理员信息</a></dd>--%>
                        <%--                        <dd><a href="">修改管理员信息</a></dd>--%>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <%--        <div style="padding: 15px;">内容主体区域。记得修改 layui.css 和 js 的路径</div>--%>
        <%--        <iframe src="${pageContext.request.contextPath}/pages/main.html" id="main" height="100%" width="100%"></iframe>--%>
        <iframe src="${pageContext.request.contextPath}/page/adminPageToMain" id="main" height="100%" width="100%"></iframe>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        底部固定区域
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
<script>
    layui.use('element',function(){
        var element = layui.element;
        var $= layui.jquery;
        //$(document).ready
        //DOM元素被加载完成的情况下执行，所以，使用document.ready()方法的执行速度比onload()的方法要快
        $(document).ready(function(){
            $("dd>a").click(function(e){
                e.preventDefault();//阻止默认浏览器动作
                $('#main').attr("src",$(this).attr("href"));
            });
            $("li>a").click(function(e){
                e.preventDefault();//阻止默认浏览器动作
                $('#main').attr("src",$(this).attr("href"));
            });
        });
    });
</script>
<script src="${pageContext.request.contextPath}/static/jquery-3.4.1.min.js"></script>
<%--<script>--%>
<%--    //实现退出登录时修改排队状态--%>
<%--    $(function (){--%>
<%--        $("#endQueue").click(function (){--%>
<%--            $.ajax({--%>
<%--                url:'../key/endQueue',--%>
<%--                type:'get',--%>
<%--                dataType:'text'--%>
<%--                //这里就不做响应了--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<script>
    //在个人面板中展示管理员信息
    $(function (){
        $("#getAdminInfo").click(function (){
            $.ajax({
                url:'${pageContext.request.contextPath}/admin/findAdminInfo',
                type:'get',
                dataType: 'text'
                //这里也不做响应
            });
        });
    });
</script>

<script>
    function showtime() {
        var today;
        var hour;
        var second;
        var minute;
        var year;
        var month;
        var date;
        var strDate;
        today = new Date();
        var n_day = today.getDay();
        switch (n_day) {
            case 0: {
                strDate = "星期日"
            }
                break;
            case 1: {
                strDate = "星期一"
            }
                break;
            case 2: {
                strDate = "星期二"
            }
                break;
            case 3: {
                strDate = "星期三"
            }
                break;
            case 4: {
                strDate = "星期四"
            }
                break;
            case 5: {
                strDate = "星期五"
            }
                break;
            case 6: {
                strDate = "星期六"
            }
                break;
            case 7: {
                strDate = "星期日"
            }
                break;
        }
        year = today.getYear() - 100 + 2000;
        month = today.getMonth() + 1;
        date = today.getDate();
        hour = today.getHours();
        minute = today.getMinutes();
        second = today.getSeconds();
        if (month < 10)
            month = "0" + month;
        if (date < 10)
            date = "0" + date;
        if (hour < 10)
            hour = "0" + hour;
        if (minute < 10)
            minute = "0" + minute;
        if (second < 10)
            second = "0" + second;
        document.getElementById('clock').innerHTML = year + "年" + month
            + "月" + date + "日 " + strDate + " " + hour + ":" + minute
            + ":" + second;
        setTimeout("showtime();", 1000); //1秒调用一次showTime()函数
    }
</script>

</body>
</html>
