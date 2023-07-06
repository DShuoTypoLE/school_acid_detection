<%@ page import="cn.tongda.domain.pojo.UserPredictQueueTime" %>
<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/15
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>预测排队时间</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css"    media="all">
    <script src="${pageContext.request.contextPath}/static/layui/dist/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/openStyle.css">
    <style>
        h2{
            text-align: center;
            font-family: "幼圆";
            margin-bottom: 15px;
        }
        .text1{
            font-size: 20px;
        }
        .text2{
            font-size: 15px;
            color: #40a9ff;
        }
        .text3{
            font-size: 15px;
            color: lightpink;
        }
        h2:hover{
            color: lightsalmon;
        }
        h2::selection{
            color: lightgreen;
        }
        div.clockdiv{
            text-align: center;
            margin-top: 20px;
        }
        div.clockdiv span{
            font-size: 30px;
            font-family: "幼圆";
            color:#2ce22b;
            font-weight: bold;
        }
    </style>
</head>
<body onload="showtime()">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>预测排队时间</legend>
</fieldset>
<%
    UserPredictQueueTime upqt = (UserPredictQueueTime) request.getSession().getAttribute("userPredictQueueTime");
    int id = upqt.getId();//通道id
    String address = upqt.getAddress();//通道地址
    int count = upqt.getCount();//排队数量
    int time = upqt.getTime();//预测的时间
%>
<div style="max-width: 1140px;">
    <ul class="layui-border-box site-doc-icon site-doc-anim">
        <li>
            <div class="layui-anim layui-anim-up"><h2 class="text1">尊敬的用户你好!</h2></div>
            <div class="layui-anim layui-anim-up"><h2 class="text2">您所在的检测通道ID:<%=id%></h2></div>
            <div class="layui-anim layui-anim-up"><h2 class="text3">您所在的检测通道地址:<%=address%></h2></div>
            <div class="layui-anim layui-anim-up"><h2 class="text2">您所在的检测通道地当前排队人数为:<%=count%></h2></div>
            <jsp:useBean id="userPredictQueueTime" scope="session" type="cn.tongda.domain.pojo.UserPredictQueueTime"/>
            <c:if test="${userPredictQueueTime.time<60}">
                <div class="layui-anim layui-anim-up"><h2 class="text3">预测排队时长需要:<span><%=time%></span> second(s)</h2></div>
            </c:if>
            <c:if test="${userPredictQueueTime.time>=60 && userPredictQueueTime.time<3600}">
                <div class="layui-anim layui-anim-up"><h2 class="text3">预测排队时长需要:<span><%=time/60.0%></span> minute(s)</h2></div>
            </c:if>
            <c:if test="${userPredictQueueTime.time>=3600 && userPredictQueueTime.time<3600*24}">
                <div class="layui-anim layui-anim-up"><h2 class="text3">预测排队时长需要:<span><%=time/3600.0%></span> hour(s)</h2></div>
            </c:if>

            <%-- 上下分界线(填充页面) --%>
            <div style="width: 580px;height: 1px;background-color: lightgreen;margin-bottom: 2px"></div>
            <%-- 小动画 --%>
            <div style="width: 580px;height: 264px;background-color: #40a9ff" id="showClock">
                <img src="${pageContext.request.contextPath}/images/wx.jpg" style="width: 100%;height: 100%">
            </div>
            <%--当前时间--%>
            <div class="layui-anim layui-anim-up clockdiv"><span id="clock"></span></div>
        </li>
    </ul>
</div>
<%--点击图片显示动态时钟--%>
<script src="${pageContext.request.contextPath}/static/jquery-3.4.1.min.js"></script>
<script>
    layui.use('layer', function(){
        $("#showClock").click(function (){
            //在父界面打开
            parent.layer.open({
                type: 2,
                title: '动态时钟',
                shadeClose: true,
                shade: 0.8,
                skin:'layerdemo',
                area: ['100%', '100%'],
                shadeClose: true,//shadeClose为true时，点击非弹出框的其他地方，弹出框消失。
                content: '${pageContext.request.contextPath}/page/predictQueueTimeToClock' //iframe的url
            });

            return false;
        });
    });
</script>

<%--时间--%>
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
