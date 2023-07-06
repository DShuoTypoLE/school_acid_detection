<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/17
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
</head>
<body>
<div class="layui-card-header">个人信息</div>
<div class="layui-card-body" pad15="">
    <form class="layui-form">
        <!--隐藏参数-->
        <%--        <input type="hidden" name="id" value="..."/>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input"  name="username"
                       value="${adminInfo.username}" disabled="disabled" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="nickname"
                       value="${adminInfo.nickname}" lay-verify="nickname" autocomplete="off"
                       placeholder="请输入昵称">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <c:if test="${adminInfo.sex=='男'}">
                    <input type="radio" name="sex" value="男" title="男" checked>
                    <input type="radio" name="sex" value="女" title="女">
                    <input type="radio" name="sex" value="保密" title="保密">
                </c:if>
                <c:if test="${adminInfo.sex=='女'}">
                    <input type="radio" name="sex" value="男" title="男">
                    <input type="radio" name="sex" value="女" title="女" checked>
                    <input type="radio" name="sex" value="保密" title="保密">
                </c:if>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="phone"
                       value="${adminInfo.phone}" lay-verify="required|phone" autocomplete="off">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="email"
                       value="${adminInfo.email}" lay-verify="required|email" autocomplete="off">
            </div>
        </div>
        <div class="layui-card-header"></div>
    </form>
</div>
<script type="text/javascript">
    //渲染form让单选框效果出来
    layui.use('form',function(){
        const form = layui.form;
        form.render();
    });
</script>
</body>
</html>
