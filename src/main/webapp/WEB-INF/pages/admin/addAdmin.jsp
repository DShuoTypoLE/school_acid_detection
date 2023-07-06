<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/4/8
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加管理员信息</title>
    <script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
    <link  rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-left: 50px">
    <legend><b>添加管理员信息</b></legend>
</fieldset>
<div class="layui-form" style="width: 80%;">
    <div class="layui-form-item">
        <label class="layui-form-label" for="username">管理员姓名</label>
        <div class="layui-input-inline">
            <input class="layui-input" type="text" name="username" id="username"
                   placeholder="请输入管理员姓名">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="password">密码</label>
        <div class="layui-input-inline">
            <input class="layui-input" type="password" name="password" id="password"
                   placeholder="请输入密码">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" for="roleid">角色id</label>
        <div class="layui-input-inline">
            <input type="text" id="roleid" name="roleid" class="layui-input"
                   placeholder="请输入角色id" >
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <!--from 中的 button 如果没有指明type 那么默认就是表单的提交 所以下面这个注册按钮要指明
        type类型 表明是个普通按钮-->
            <button type="button" id="submit" class="layui-btn">立即提交</button>
        </div>
    </div>
</div>
<script>
    layui.use('layer', function(){
        var layer = layui.layer;

        $("#submit").click(function (){
            var username = $("#username").val();
            var password = $("#password").val();
            var roleid = $("#roleid").val();

            var jsonStr = {
                'username':username,
                'password':password,
                'roleid':roleid
            };

            $.ajax({
                url:'../admin',
                type:'POST',
                contentType:'application/json;charset=utf-8',
                dataType:'text',
                data:JSON.stringify(jsonStr),
                success:function (res){
                    if(res=="success"){
                        layer.msg('添加成功!',{anim: 1,skin:'errorMsg'},function (){
                            window.location.reload();
                        });
                    }
                },
                error:function (res){
                    if(res=="fail"){
                        layer.msg('添加失败!',{anim: 6,skin:'errorMsg'});
                    }
                }
            });
        });


    });

</script>
</body>
</html>