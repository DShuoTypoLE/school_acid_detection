/**

 @Name：layuiAdmin 主页控制台
 @Author：贤心
 @Site：http://www.layui.com/admin/
 @License：GPL-2
    
 */


layui.define(function(exports){
  
  /*
    下面通过 layui.use 分段加载不同的模块，实现不同区域的同时渲染，从而保证视图的快速呈现
  */
  
  
  //区块轮播切换
  layui.use(['admin', 'carousel'], function(){
    var $ = layui.$
    ,admin = layui.admin
    ,carousel = layui.carousel
    ,element = layui.element
    ,device = layui.device();

    //轮播切换
    $('.layadmin-carousel').each(function(){
      var othis = $(this);
      carousel.render({
        elem: this
        ,width: '100%'
        ,arrow: 'none'
        ,interval: othis.data('interval')
        ,autoplay: othis.data('autoplay') === true
        ,trigger: (device.ios || device.android) ? 'click' : 'hover'
        ,anim: othis.data('anim')
      });
    });
    
    element.render('progress');
    
  });

  //数据概览
  layui.use(['admin', 'carousel', 'echarts','layer'], function(){
    var $ = layui.$
    ,admin = layui.admin
    ,carousel = layui.carousel
    ,echarts = layui.echarts
    ,layer = layui.layer;

    //使用ajax动态加载数据
    $.ajax({
      url: '../user/findUserQueueNumber',
      type: "post",
      async: true,//异步
      complete: function (XHR, TS) {
        if (XHR.status != 200) {
          layer.alert("系统繁忙，稍后重试");
        }
      },
      success: function (result) {
        if(result.code==0){
          var echartsApp = [], options = [
            //今日流量趋势
            {
              title: {
                text: '今日流量趋势',
                x: 'center',
                textStyle: {
                  fontSize: 14
                }
              },
              tooltip : {
                trigger: 'axis'
              },
              legend: {
                data:['','']
              },
              xAxis : [{
                type : 'category',
                boundaryGap : false,
                data: ['06:00','06:30','07:00','07:30','08:00','08:30','09:00','09:30','10:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00','22:30','23:00','23:30']
              }],
              yAxis : [{
                type : 'value'
              }],
              series : [{
                name:'PV',
                type:'line',
                smooth:true,
                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                data: [111,155,167,178,201,221,254,2321,555,666,546,437,421,398,348,312,245,198,234,298,267,204,301,312,324,354,927,699,588,544,423,320,220,111]
              },{
                name:'UV',
                type:'line',
                smooth:true,
                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                data: [11,22,33,44,55,66,33,33,55,12,33,33,66,118,266,38,66,42,39,288,177,96,65,55,33,22,31,69,58,27,166,99,88,77]
              }]
            },

            //访客浏览器分布
            {
              title : {
                text: '各通道排队人数分布',
                x: 'center',
                textStyle: {
                  fontSize: 14
                }
              },
              tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
              },
              legend: {
                orient : 'vertical',
                x : 'left',
                data:['体育馆西门','一号教学楼','其他未排队的学生数量']
              },
              series : [{
                name:'各通道人数',
                type:'pie',
                radius : '55%',
                center: ['50%', '50%'],
                data:result.data
              }]
            },

            //新增的用户量
            {
              title: {
                text: '最近一周新增的访问量',
                x: 'center',
                textStyle: {
                  fontSize: 14
                }
              },
              tooltip : { //提示框
                trigger: 'axis',
                formatter: "{b}<br>新增访问人数：{c}"
              },
              xAxis : [{ //X轴
                type : 'category',
                data : ['5-21', '5-22', '5-23', '5-24', '5-25', '5-26', '5-27']
              }],
              yAxis : [{  //Y轴
                type : 'value'
              }],
              series : [{ //内容
                type: 'line',
                data:[20, 30, 40, 61, 15, 27, 38],
              }]
            }
          ]
              ,elemDataView = $('#LAY-index-dataview').children('div')
              ,renderDataView = function(index){
            echartsApp[index] = echarts.init(elemDataView[index], layui.echartsTheme);

            echartsApp[index].setOption(options[index]);
            //window.onresize = echartsApp[index].resize;
            admin.resize(function(){
              echartsApp[index].resize();
            });
          };

          //没找到DOM，终止执行
          if(!elemDataView[0]) return;

          renderDataView(0);

          //监听数据概览轮播
          var carouselIndex = 0;
          carousel.on('change(LAY-index-dataview)', function(obj){
            renderDataView(carouselIndex = obj.index);
          });

          //监听侧边伸缩
          layui.admin.on('side', function(){
            setTimeout(function(){
              renderDataView(carouselIndex);
            }, 300);
          });

          //监听路由
          layui.admin.on('hash(tab)', function(){
            layui.router().path.join('') || renderDataView(carouselIndex);
          });
        }else{
          layer.msg("服务器提示:" + result.msg);
        }
      },
      error: function () {
        layer.alert("error");
      }
    });

  });

  //最新订单
  layui.use('table', function(){
    var $ = layui.$
    ,table = layui.table;
    
    //今日热搜
    table.render({
      elem: '#LAY-index-topSearch'
      ,url: layui.setter.base + 'json/console/top-search.js' //模拟接口
      ,page: true
      ,cols: [[
        {type: 'numbers', fixed: 'left'}
        ,{field: 'keywords', title: '关键词', minWidth: 300, templet: '<div><a href="{{d.href}}" target="_blank" class="layui-table-link">{{ d.keywords }}</div>'}
        ,{field: 'frequency', title: '搜索次数', minWidth: 120, sort: true}
        ,{field: 'userNums', title: '点赞数量', sort: true}
      ]]
      ,skin: 'line'
    });

    //今日热贴
    table.render({
      elem: '#LAY-index-topCard'
      ,url: layui.setter.base + 'json/console/top-card.js' //模拟接口
      ,page: true
      ,cellMinWidth: 120
      ,cols: [[
        {type: 'numbers', fixed: 'left'}
        ,{field: 'title', title: '标题', minWidth: 300, templet: '<div><a href="{{ d.href }}" target="_blank" class="layui-table-link">{{ d.title }}</div>'}
        ,{field: 'channel', title: '类别'}
        ,{field: 'crt', title: '点击率', sort: true}
      ]]
      ,skin: 'line'
    });
  });
  
  exports('console', {})
});