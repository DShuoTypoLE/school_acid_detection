<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/4/8
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加用户信息</title>
    <script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
    <link  rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-left: 50px">
    <legend><b>添加用户信息</b></legend>
</fieldset>
<div class="layui-form" style="width: 80%;">
    <div class="layui-form-item">
        <label class="layui-form-label" for="username">用户名</label>
        <div class="layui-input-inline">
            <input class="layui-input" type="text" name="username" id="username"
                   placeholder="请输入用户姓名">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="password">密码</label>
        <div class="layui-input-inline">
            <input class="layui-input" type="password" name="password" id="password"
                   placeholder="请输入用户密码">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="sex">性别</label>
        <div class="layui-input-inline">
            <input class="layui-input" type="text" name="sex" id="sex"
                   placeholder="请填写性别">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="phone">手机号</label>
        <div class="layui-input-inline">
            <input type="text" id="phone" name="phone" class="layui-input"
                   placeholder="请输入手机号" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="nickname">昵称</label>
        <div class="layui-input-inline">
            <input type="text" id="nickname" name="nickname" class="layui-input"
                   placeholder="请输入昵称" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="email">邮箱</label>
        <div class="layui-input-inline">
            <input type="text" id="email" name="email" class="layui-input"
                   placeholder="请输入邮箱" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="cid">检测通道</label>
        <div class="layui-input-inline">
            <input type="text" id="cid" name="cid" class="layui-input"
                   placeholder="请输入检测通道" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" for="resultid">检测结果id</label>
        <div class="layui-input-inline">
            <input type="text" id="resultid" name="resultid" class="layui-input"
                   placeholder="请输入检测结果id" >
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
            var sex = $("#sex").val();
            var phone = $("#phone").val();
            var nickname = $("#nickname").val();
            var email = $("#email").val();
            var cid = $("#cid").val();
            var resultid = $("#resultid").val();
            var roleid = $("#roleid").val();

            var jsonStr = {
                'username':username,
                'password':password,
                'sex':sex,
                'phone':phone,
                'nickname':nickname,
                'email':email,
                'cid':cid,
                'resultid':resultid,
                'roleid':roleid
            };

            $.ajax({
                url:'../user',
                type:'POST',
                contentType:'application/json;charset=utf-8',
                dataType:'text',
                data:JSON.stringify(jsonStr),
                success:function (res){
                    if(res=="success"){//顶部掉落
                        layer.msg('添加成功!',{anim: 1,skin:'errorMsg'},function (){
                            window.location.reload();
                        });
                    }
                },
                error:function (res){
                    if(res=="fail"){//抖动
                        layer.msg('添加失败!',{anim: 6,skin:'errorMsg'});
                    }
                }
            });
        });


    });

</script>
</body>
</html>
