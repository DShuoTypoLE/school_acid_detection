<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/4/8
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改用户信息</title>
    <style>
        /*让表格对齐*/
        label{
            display: inline-block;
            min-width: 100px;/*或者 width: 100px;*/
        }
    </style>
</head>
<body>
<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
<div class="layui-form" lay-filter="updateUserInfo" id="updateUserInfo">
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="id">用户id :</label>
            <input type="text" name="id" id="id" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="username">用户名 :</label>
            <input type="text" name="username" id="username" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="password">用户密码 :</label>
            <input type="password" name="password" id="password" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="sex">性别 :</label>
            <input type="text" name="sex" id="sex" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="phone">联系方式 :</label>
            <input type="text" name="phone" id="phone" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="queueStatus">排队状态 :</label>
            <input type="text" name="queueStatus" id="queueStatus" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="nickname">昵称 :</label>
            <input type="text" name="nickname" id="nickname" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="email">邮箱 :</label>
            <input type="text" name="email" id="email" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="cid">检测通道id :</label>
            <input type="text" name="cid" id="cid" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="resultid">检测结果id :</label>
            <input type="text" name="resultid" id="resultid" class="layui-input">
        </div>
    </div>
    <br/>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <label for="roleid">角色id :</label>
            <input type="text" name="roleid" id="roleid" class="layui-input">
        </div>
    </div>
    <br/>
</div>
</body>
</html>
