<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/17
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
</head>
<body>
<div class="layui-card-header">修改密码</div>
<div class="layui-card-body" pad15="">
    <form class="layui-form" id="cpwd">
        <input type="hidden" name="id" value="${id}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名：</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="username"
                       value="${username}" disabled="disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">旧密码：</label>
            <div class="layui-input-inline">
                <input type="password" name="oldPassword" lay-verify="required"
                       placeholder="请输入旧密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码：</label>
            <div class="layui-input-inline">
                <input type="password" name="newPassword1" id="newPassword1"
                       lay-verify="newPassword1" placeholder="请输入新密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">重复密码：</label>
            <div class="layui-input-inline">
                <input type="password" name="newPassword2" id="newPassword2"
                       lay-verify="newPassword2" placeholder="请输入新密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-card-body" pad15="">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="changePassword">
                        确认修改
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
<script>
    layui.use(['form','layer'],function () {
        var layer=layui.layer;
        var $=layui.jquery;
        var form=layui.form;
        form.verify({
            newPassword1:[/(.+){3,16}$/,'密码必须3到16位'],
            newPassword2:function (value) {
                var repassvalue=$('#newPassword1').val();
                if(value!=repassvalue)
                {
                    return '两次输入的密码不一致！';
                }
            }
        });
        //监听提交
        form.on("submit(changePassword)",function (data) {
            var data1 = data.field;
            var index=layer.load(1,{shade:[0.5,'#000']});
            $.ajax({
                url:"../user/changeUserPassword",
                type:"post",
                data:JSON.stringify(data1),
                contentType:'application/json;charset=utf-8',
                dataType:"json",
                success:function (res) {
                    if(res.code==0)
                    {
                        layer.close(index);
                        $('#cpwd')[0].reset(); //表单内 有默认值的恢复默认值
                        //渐显效果
                        layer.msg("修改成功!请重新登录!",{time:1000,anim:5},function (){
                            //如果修改密码,强制重新登录
                            location.href = "${pageContext.request.contextPath}/index.jsp";
                        });
                    }
                    else
                    {
                        layer.close(index);
                        layer.msg(res.msg);
                        $('#cpwd')[0].reset();
                    }
                }
            });
            return false;
        });

    });
</script>
</body>
</html>

