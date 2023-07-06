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
    <title>我的检测通道</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css" media="all">
    <style>
        body{
            width: 100%;
            height: 100%;
            background-image: url("${pageContext.request.contextPath}/images/4.png");
            background-size: 100% 100%;
        }
        div.channelInfo input{
            width: 120px;
            height: 30px;
            border-radius: 5px;
            background-color: lightsalmon;
            font-family: "幼圆";
            cursor:pointer;
        }
        div.channelInfo input:hover{
            color: #fff;
            background-color: black;
        }
        div.channelInfo {
            text-align: center;
        }
    </style>
</head>
<body>

<table id="demo" lay-filter="test"></table>
<div class="channelInfo">
    <input id="returnToIndex" type="button" value="返回主页"/>
</div>


<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script>
    <%--跳转回首页--%>
    $(function (){
       $("#returnToIndex").click(function (){
            window.location="../page/loginToUserPage";
       });
    });
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 'full-10'//一开始为312,修改为full-10使分页栏贴近底部,值越小越贴近底部
            ,method:'get'
            ,url: '../user/findUserChannel' //数据接口
            ,page: true //开启分页
            ,parseData: function(res){ //res 即为原始返回的数据
                return {//需要换成Vo类中的变量，其实是传过来json数据的键
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
            ,cols: [[ //表头
                {field: 'id', title: '用户ID', width:120, sort: true}
                ,{field: 'username', title: '用户名', width:120}
                ,{field: 'sex', title: '性别', width:80}
                ,{field: 'phone', title: '联系方式', width:120}
                ,{field: 'queueStatus', title: '排队状态', width:120, sort: true}
                ,{field: 'address', title: '检测地点', width:120}
            ]]
        });
    });
</script>
</body>
</html>
