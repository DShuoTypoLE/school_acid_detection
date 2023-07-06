<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/2/18
  Time: 13:39
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
    <style>
        <%--  容器居中    --%>
        body {
            background-image: url("${pageContext.request.contextPath}/images/1.jpeg"); /*加载背景图*/ /* 背景图不平铺 */
            background-repeat: no-repeat;
            background-position: center center;
            background-size: cover; /* 让背景图基于容器大小伸缩 */
            background-attachment: fixed; /* 当内容高度大于图片高度时，背景图像的位置相对于viewport固定 */
        / /此条属性必须设置否则可能无效/
        }

        div.outer {
            width: 460px;
            height: 520px;
            border-radius: 5px;
            opacity: 0.7;
            background-color: lightblue;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }

        div.channelInfo input {
            width: 120px;
            height: 30px;
            border-radius: 5px;
            background-color: lightsalmon;
            font-family: "幼圆";
            cursor: pointer;
        }

        div.channelInfo input:hover {
            color: #fff;
            background-color: black;
        }

        div.channelInfo {
            text-align: center;
        }
        div.layui-form-item{
            padding-left: 20px;
        }
    </style>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
<div class="outer">
    <div class="layui-card-header">个人信息</div>
    <div class="layui-card-body" pad15="" style="margin: 0 auto">
        <form class="layui-form">
            <!--隐藏参数-->
            <%--        <input type="hidden" name="id" value="..."/>--%>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="username"
                           value="${userInfo.username}" disabled="disabled">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">昵称</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="nickname"
                           value="${userInfo.nickname}" lay-verify="nickname" autocomplete="off"
                           placeholder="请输入昵称">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <c:if test="${userInfo.sex=='男'}">
                        <input type="radio" name="sex" value="男" title="男" checked>
                        <input type="radio" name="sex" value="女" title="女">
                        <input type="radio" name="sex" value="保密" title="保密">
                    </c:if>
                    <c:if test="${userInfo.sex=='女'}">
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
                           value="${userInfo.phone}" lay-verify="required|phone" autocomplete="off">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="email"
                           value="${userInfo.email}" lay-verify="required|email" autocomplete="off">
                </div>
            </div>
            <div class="layui-card-header"></div>
        </form>
    </div>
    <div class="channelInfo">
        <input id="returnToIndex" type="button" value="返回主页"/>
    </div>
</div>
<script type="text/javascript">
    //渲染form让单选框效果出来
    layui.use('form', function () {
        const form = layui.form;
        form.render();
    });
</script>
<script>
    <%--跳转回首页--%>
    $(function (){
        $("#returnToIndex").click(function (){
            window.location="../page/loginToUserPage";
        });
    });
</script>
</body>
</html>

