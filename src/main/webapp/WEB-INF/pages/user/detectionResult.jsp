<%@ page import="cn.tongda.domain.pojo.Result" %>
<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/14
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>查询检测结果</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detectionResult.css">
</head>
<body>
<%--从session域中获取数据--%>
<%
    Result result = (Result) request.getSession().getAttribute("result");
%>
<div class="result-body">
    <table>
        <tr>
            <td>姓名:</td>
            <td><span><%=result.getUsername()%></span></td>
        </tr>
        <tr>
            <td>采样点:</td>
            <td><span><%=result.getAddress()%></span></td>
        </tr>
        <tr>
            <td>检测时间:</td>
            <td><span class="span3"><%=result.getDetectionTime()%></span></td>
        </tr>
        <tr>
            <td>检测结果:</td>
            <td><span class="span4"><%=result.getResMsg()%></span></td>
        </tr>
    </table>
    <div class="divNum">48小时</div>
</div>

<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>

</body>
</html>
