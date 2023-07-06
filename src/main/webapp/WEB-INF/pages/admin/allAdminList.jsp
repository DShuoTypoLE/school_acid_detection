<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/4/8
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>所有管理员信息列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/openStyle1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">
</head>
<body>

<table id="demo" lay-filter="test"></table>

<script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete layui-icon layui-icon-delete" lay-event="delete">删除</a>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 'full-10'//一开始为312,修改为full-10使分页栏贴近底部,值越小越贴近底部
            ,method:'get'
            ,url: '../admin' //数据接口
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
                {type:'checkbox'}
                ,{field: 'id', title: 'adminID', width:120, sort: true}
                ,{field: 'username', title: '管理员姓名', width:120,edit: 'text'}
                ,{field: 'password', title: '密码', width:350,edit: 'text'}
                ,{field: 'roleid', title: '角色id(1:超级管理员)', width:230,sort:true,edit: 'text'}
                ,{field: 'operate', title: '操作', width: 150,toolbar:'#barDemo'}
            ]]
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'delete'){
                layer.confirm('真的删除行么',{anim: 1,skin:'layerdemo1'}, function(index){
                    obj.del();
                    //传入后台实现同步删除
                    var jsonStr = {"id":data.id};
                    $.ajax({
                        url:'../admin/id',
                        type:'DELETE',
                        data:JSON.stringify(jsonStr),
                        contentType: 'application/json;charset=utf-8',
                        success:function (res){
                            if(res=="success"){
                                layer.msg('删除成功!',{anim: 1,skin:'errorMsg'});
                            }
                        },
                        error:function (res){
                            if(res=="fail"){
                                layer.msg("删除失败",{anim: 6,skin:'errorMsg'});
                            }
                        }
                    });
                    layer.close(index);
                });
            }
        });

        //监听单元格编辑
        //第二种更新方式
        table.on('edit(test)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改值为：'+ value,{anim: 1,skin:'errorMsg'});

            var jsonStr = {
                'id':data.id,
                'username':data.username,
                'password':data.password,
                'roleid':data.roleid
            };

            $.ajax({
                url:'../admin',
                type:'PUT',
                contentType:'application/json;charset=utf-8',
                dataType:'text',
                data:JSON.stringify(jsonStr),
                success:function (res){
                    if(res=="success"){
                        layer.msg('update成功!',{anim: 1,skin:'errorMsg'});
                    }
                },
                error:function (res){
                    if(res=="fail"){
                        layer.msg('更新失败!',{anim: 6,skin:'errorMsg'});
                    }
                }
            });
        });

    });
</script>
</body>
</html>
