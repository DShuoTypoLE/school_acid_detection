<%--
  Created by IntelliJ IDEA.
  User: 硕硕说你好
  Date: 2023/4/8
  Time: 18:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>所有用户信息列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/dist/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/openStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/openStyle1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiAdmin/src/layuiadmin/style/admin.css" media="all">

    <script src="${pageContext.request.contextPath}/static/layui/dist/layui.js"></script>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
<%--搜索用户列表--%>
<div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label" for="username">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" id="username" name="username" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" for="cid">通道id</label>
                    <div class="layui-input-block">
                        <input type="text" id="cid" name="cid" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-block">
                        <select name="sex">
                            <option value="0">不限</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-user-front-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
<table id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit layui-icon layui-icon-edit" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete layui-icon layui-icon-delete" lay-event="delete">删除</a>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table,
        form = layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 'full-10'//一开始为312,修改为full-10使分页栏贴近底部,值越小越贴近底部
            ,method:'get'
            ,url: '../user' //数据接口
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
                {field: 'id', title: 'userID', width:120, sort: true}
                ,{field: 'username', title: '用户名', width:100}
                ,{field: 'password', title: '密码', width:355}
                ,{field: 'sex', title: '性别', width:80,sort:true}
                ,{field: 'phone', title: '联系电话', width: 150}
                ,{field: 'queueStatus', title: '排队状态', width: 120}
                ,{field: 'nickname', title: '昵称', width: 100}
                ,{field: 'email', title: '邮箱', width: 150}
                ,{field: 'cid', title: '通道id', width: 100,sort:true}
                ,{field: 'resultid', title: '检测结果id', width: 120,sort:true}
                ,{field: 'roleid', title: '角色id', width: 100}
                ,{field: 'operate', title: '操作', width: 150,toolbar:'#barDemo'}
            ]]
        });

        //监听搜索
        form.on('submit(LAY-user-front-search)', function(data){
            // var field = data.field;

            // 装载数据,防止空数据强行传参导致异常
            var resultData = {};
            if(data.field.username != '')
                resultData.username = data.field.username;
            if(data.field.cid != '' )
                resultData.cid = data.field.cid;
            if(data.field.sex != '' )
                resultData.sex = data.field.sex;
            //执行重载
            table.reload('demo', {
                url:"../user/findUserByLike"
                , where: resultData
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'delete'){
                layer.confirm('真的要删除么',{anim: 1,skin:'layerdemo1'}, function(index){
                    obj.del();
                    //传入后台同步删除
                    var jsonStr = {"id":data.id};
                    $.ajax({
                        url:'../user/id',
                        type:'delete',
                        data:JSON.stringify(jsonStr),
                        contentType: 'application/json;charset=utf-8',
                        success:function (res){
                            if(res=="success"){
                                layer.msg('删除成功!',{anim: 1,skin:'errorMsg'});
                            }
                        },
                        error:function (res){
                            if(res=="fail"){//6是抖动效果
                                layer.msg("删除失败",{anim: 6,skin:'errorMsg'});
                            }
                        }
                    });
                    layer.close(index);
                });
            } else if(obj.event === 'edit') {
                //实现编辑的功能
                layer.open({
                    type:2,
                    title:'更新用户信息',
                    content:'${pageContext.request.contextPath}/page/allUserListToUpdateUserInfo',
                    maxmin:true,
                    area:['500px','450px'],
                    skin:'layerdemo',
                    btn:['确定','取消'],
                    yes:function(index,layero){
                        //回调的数值
                        //$(layero).find("iframe")[0].contentWindow;//通过该对象可以获取iframe中的变量，调用iframe中的方法
                        var id = $(layero).find('iframe')[0].contentWindow.id.value;
                        var username = $(layero).find('iframe')[0].contentWindow.document.getElementById('username').value;
                        var password = $(layero).find('iframe')[0].contentWindow.document.getElementById('password').value;
                        var sex = $(layero).find('iframe')[0].contentWindow.document.getElementById('sex').value;
                        var phone = $(layero).find('iframe')[0].contentWindow.document.getElementById('phone').value;
                        var queueStatus = $(layero).find('iframe')[0].contentWindow.document.getElementById('queueStatus').value;
                        var nickname = $(layero).find('iframe')[0].contentWindow.document.getElementById('nickname').value;
                        var email = $(layero).find('iframe')[0].contentWindow.document.getElementById('email').value;
                        var cid = $(layero).find('iframe')[0].contentWindow.document.getElementById('cid').value;
                        var resultid = $(layero).find('iframe')[0].contentWindow.document.getElementById('resultid').value;
                        var roleid = $(layero).find('iframe')[0].contentWindow.document.getElementById('roleid').value;

                        //同步数据表格中的数据
                        obj.update({
                            'id':id,
                            'username':username,
                            'password':password,
                            'sex':sex,
                            'phone':phone,
                            'queueStatus':queueStatus,
                            'nickname':nickname,
                            'email':email,
                            'cid':cid,
                            'resultid':resultid,
                            'roleid':roleid
                        });

                        var jsonStr = {
                            'id':id,
                            'username':username,
                            'password':password,
                            'sex':sex,
                            'phone':phone,
                            'queueStatus':queueStatus,
                            'nickname':nickname,
                            'email':email,
                            'cid':cid,
                            'resultid':resultid,
                            'roleid':roleid
                        };

                        $.ajax({
                            url:'../user',
                            type:'PUT',
                            contentType:'application/json;charset=utf-8',
                            dataType:'text',
                            data:JSON.stringify(jsonStr),
                            success:function (res){
                                if(res=="success"){
                                    layer.msg('update成功!');
                                }
                            },
                            error:function (res){
                                if(res=="fail"){
                                    layer.msg('更新失败!');
                                }
                            }
                        });
                        layer.close(index);
                    }
                    ,success:function(layero,index){
                        var div = layero.find('iframe').contents().find('#updateUserInfo');
                        var body = layer.getChildFrame('body',index);
                        var iframeWindow = window['layui-layer-iframe'+index];
                        //让选中的行数据放到修改页面的框框里
                        body.find('#id').val(data.id);
                        body.find('#username').val(data.username);
                        body.find('#password').val(data.password);
                        body.find('#sex').val(data.sex);
                        body.find('#phone').val(data.phone);
                        body.find('#queueStatus').val(data.queueStatus);
                        body.find('#nickname').val(data.nickname);
                        body.find('#email').val(data.email);
                        body.find('#cid').val(data.cid);
                        body.find('#resultid').val(data.resultid);
                        body.find('#roleid').val(data.roleid);
                    }
                });
            }
        });
    });
</script>
</body>
</html>
