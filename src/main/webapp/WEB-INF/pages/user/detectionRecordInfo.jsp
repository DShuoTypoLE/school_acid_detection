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
    <title>核酸检测记录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css" media="all">
</head>
<body>

<table id="demo" lay-filter="test"></table>

<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 'full-10'//一开始为312,修改为full-10使分页栏贴近底部,值越小越贴近底部
            ,method:'get'
            ,url: '../user/detectionRecordInfo' //数据接口
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
                {type: 'numbers', fixed: 'left'}
                ,{field: 'username', title: '用户名', width:80}
                ,{field: 'address', title: '采样点', width:100}
                ,{field: 'deteTime', title: '检测时间', width:168}
                ,{field: 'resTime', title: '结果时间', width:168}
                ,{field: 'resMsg', title: '检测结果', width:100}
            ]]
        });
    });
</script>
</body>
</html>
