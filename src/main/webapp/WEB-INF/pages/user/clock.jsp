<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/4/11
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>动态时钟</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/clock.css">
</head>
<body>
<ul class="clock" id="helang-clock">
    <hr>
</ul>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/clock.js"></script>
<script type="text/javascript"> $("#helang-clock").clock(); </script>
</body>
</html>
