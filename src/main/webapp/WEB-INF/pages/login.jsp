<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>核酸检测系统登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css" media="all">

    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {background: #1e9fff;}
        body:after {content:'';background-repeat:no-repeat;background-size:cover;-webkit-filter:blur(3px);-moz-filter:blur(3px);-o-filter:blur(3px);-ms-filter:blur(3px);filter:blur(3px);position:absolute;top:0;left:0;right:0;bottom:0;z-index:-1;}
        .layui-container {width: 100%;height: 100%;overflow: hidden}
        .admin-login-background {width:360px;height:300px;position:absolute;left:50%;top:40%;margin-left:-180px;margin-top:-100px;}
        .logo-title {text-align:center;letter-spacing:2px;padding:14px 0;}
        .logo-title h1 {color:#1E9FFF;font-size:25px;font-weight:bold;}
        .login-form {background-color:#fff;border:1px solid #fff;border-radius:3px;padding:14px 20px;box-shadow:0 0 8px #eeeeee;}
        .login-form .layui-form-item {position:relative;}
        .login-form .layui-form-item label {position:absolute;left:1px;top:1px;width:38px;line-height:36px;text-align:center;color:#d2d2d2;}
        .login-form .layui-form-item input {padding-left:36px;border-radius: 50px;}
        .captcha {width:60%;display:inline-block;}
        .captcha-img {display:inline-block;width:34%;float:right;}
        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
    </style>
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" action="">
                <div class="layui-form-item logo-title">
                    <h1>校园核酸检测系统</h1>
                </div>

                <!-- 选择登录身份 -->
                <div class="layui-form-item">
                    <!-- 这里不能直接在select标签下直接加style -->
                    <div class="layui-input-inline" style="width: 318px;height: 38px" >
                        <select name="role" lay-verify="required">
                            <option value="0">请选择用户类型</option>
                            <option value="1">超级管理员</option>
                            <option value="2">用户</option>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username" for="username"></label>
                    <input type="text" id="username" name="username" lay-verify="required|account" placeholder="用户名或者邮箱" autocomplete="off" class="layui-input" value="root">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password" for="password"></label>
                    <input type="password" id="password" name="password" lay-verify="required|password" placeholder="密码" autocomplete="off" class="layui-input" value="root">
                </div>
                <div class="layui-form-item" style="display:flex"><!-- 垂直居中 -->
                    <label class="layui-icon layui-icon-vercode" for="captcha"></label>
                    <input type="text" id="captcha" name="captcha" lay-verify="required|captcha" placeholder="图形验证码" autocomplete="off" class="layui-input verification captcha" value="xszg">
                    <canvas id="canvas" width="100%" height="30%"></canvas>
                </div>
                <div class="layui-form-item">
                    <input type="checkbox" name="rememberMe" value="true" lay-skin="primary" title="记住密码">
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login">登 入</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/static/jquery.particleground.min.js" charset="utf-8"></script>

<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer;

        // 登录过期的时候，跳出ifram框架
        if (top.location != self.location) top.location = self.location;

        // 粒子线条背景
        $(document).ready(function(){
            $('.layui-container').particleground({
                dotColor:'#7ec7fd',
                lineColor:'pink'
            });
        });

        $(function (){
            var show_num=[];
            draw(show_num); //上来就生成一个验证码
            $("#canvas").on('click',function () {
                draw(show_num);//点击验证码重新生成
            });


            // 进行登录操作
            form.on('submit(login)', function (data) {
                data = data.field;//当前容器的全部表单字段，名值对形式：{name: value}
                //role=1&username=admin&password=123456&captcha=xszg&rememberMe=true
                // alert(data.role);
                // alert(data.username);
                // alert(data.password);
                // alert(data.captcha);
                // alert(data.rememberMe);

                //验证码校验
                var captcha = data.captcha;//获取用户输入的验证码
                var num=show_num.join("");//将生成的验证码数组转换成字符串
                if(captcha==num){
                    $.ajax({
                        url:"login/checkLogin",
                        data:data,
                        type:"POST",
                        //contentType:"application/json;charset=utf-8",
                        dataType:"text",
                        success:function(res){
                            if(res=="success"){
                                if(data.role==1){
                                    alert("登陆成功!即将跳转管理员界面...");
                                    window.location="page/loginToAdminPage";
                                }else if(data.role==2){
                                    alert("登陆成功!即将跳转用户界面...");
                                    window.location="page/loginToUserPage";
                                }else{
                                    alert("请选择正确的角色!!");
                                }

                            }else if(res=="fail"){
                                alert("登录失败...");
                            }else{
                                alert("无效...");
                            }
                        },
                    });
                }else{
                    layer.msg('验证码错误!!');
                    $("#captcha").val('');
                    //$("#password").val('');
                    draw(show_num);
                    return false;
                }


                if (data.username == '') {
                    layer.msg('用户名不能为空');
                    return false;
                }
                if (data.password == '') {
                    layer.msg('密码不能为空');
                    return false;
                }
                if (data.captcha == '') {
                    layer.msg('验证码不能为空');
                    return false;
                }
                // layer.msg('登录成功', function () {
                //     window.location = 'homepage.jsp';
                // });
                return false;
            });
        });
    });

    //画验证码
    function draw(show_num) {
        //页面中有个id 为canvas的元素 所以用#获取
        var canvas_width=$('#canvas').width();
        var canvas_height=$('#canvas').height();
        var canvas=document.getElementById("canvas");
        var context=canvas.getContext("2d");//参数 contextID 指定了您想要在画布上绘制的类型。当前唯一的合法值是 "2d"，它指定了二维绘图，并且导致这个方法返回一个环境对象，该对象导出一个二维绘图 API。
        canvas.width=canvas_width;
        canvas.height=canvas_height;
        var sCode="q,w,e,r,t,y,u,i,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m,A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
        var aCode=sCode.split(","); //aCode是一个数组
        var aLength=aCode.length;
        for(var i=0;i<=3;i++) //绘制四位随机验证码
        {
            var j=Math.floor(Math.random()*aLength); //random只产生0到1之间的小数 floor返回小于等于参数的最大整数
            var deg=Math.random()*30*Math.PI/180;//这是个度数 猜测0到30度
            var txt=aCode[j];
            //show_num[i]=txt.toLowerCase();
            show_num[i]=txt;
            var x = 10 + i * 20;
            var y = 20 + Math.random() * 8;
            context.font = "bold 23px 微软雅黑";

            context.translate(x, y);
            context.rotate(deg);

            context.fillStyle = randomColor();
            context.fillText(txt, 0, 0);

            context.rotate(-deg);
            context.translate(-x, -y);
        }
        for (var i = 0; i <= 5; i++) { //绘制随机的6个线条
            context.strokeStyle = randomColor();
            context.beginPath();
            context.moveTo(Math.random() * canvas_width, Math.random()
                * canvas_height);
            context.lineTo(Math.random() * canvas_width, Math.random()
                * canvas_height);
            context.stroke();
        }
        for (var i = 0; i <= 30; i++) { //绘制31个干扰点
            context.strokeStyle = randomColor();
            context.beginPath();
            var x = Math.random() * canvas_width;
            var y = Math.random() * canvas_height;
            context.moveTo(x, y);
            context.lineTo(x + 1, y + 1);
            context.stroke();
        }
    };
    //颜色随机
    function randomColor() {
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        return "rgb(" + r + "," + g + "," + b + ")";
    };
</script>
</body>
</html>
