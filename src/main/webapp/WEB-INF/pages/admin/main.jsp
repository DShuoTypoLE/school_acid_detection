<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/14
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body{
            background:url(${pageContext.request.contextPath}/images/3.png) no-repeat center top;
            background-size:cover;
            background-attachment:fixed;
        }
    </style>
</head>
<body>
<h1>欢迎登录</h1>
<div class="wrap">
    <span><strong>校园核酸检测系统</strong></span>
</div>
<% String username = (String)request.getSession().getAttribute("username");%>
<h2>当前登录:<%=username%></h2>
</body>
</html>