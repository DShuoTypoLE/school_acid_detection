package cn.tongda.controller;

import cn.tongda.domain.User;
import cn.tongda.domain.Vo;
import cn.tongda.domain.pojo.*;
import cn.tongda.exception.SysException;
import cn.tongda.exception.SysExceptionResolver;
import cn.tongda.service.IUserService;
import cn.tongda.utils.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 丁硕
 * @version 1.0
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;

    /**
     * 查询当前用户检测通道
     * @param request
     * @return
     */
    @RequestMapping("/findUserChannel")
    @ResponseBody
    public Vo findUserChannel(HttpServletRequest request){
        //从刚才的session会话中得到username
        String username = request.getSession().getAttribute("username").toString();
        //从刚才的session会话中得到password
        String password = request.getSession().getAttribute("password").toString();
        //根据username和password得到uid(尽量降低重名风险)
        //这里要对密码进行加密
        password = EncryptUtil.encrypt(password);
        int uid = userService.findUid(username,password);
        //根据uid查询当前用户userChannel信息
        UserChannel userChannel = userService.findUserChannel(uid);
        //这里要放在list里面,不然返回后layui无法解析
        List<UserChannel> list = new ArrayList<>();
        list.add(userChannel);

        Vo vo = new Vo();
        vo.setCode(0);
        vo.setMsg("success");
        vo.setCount(1);
        vo.setData(list);
        return vo;
    }

    /**
     * 显示排队人数
     * @return
     */
    @RequestMapping("/findUserQueueNumber")
    @ResponseBody
    public Vo findUserQueueNumber(){

        //第一个位置封装人数信息
        Map<String,Object> firstQueueNumber = new LinkedHashMap<>();
        List<UserQueueNumber> userQueueNumbers = userService.findUserQueueNumber();
        firstQueueNumber.put("name",userQueueNumbers.get(0).getAddress());
        firstQueueNumber.put("value",userQueueNumbers.get(0).getCount());

        //第二个位置封装人数信息
        Map<String,Object> secondQueueNumber = new LinkedHashMap<>();
        secondQueueNumber.put("name",userQueueNumbers.get(1).getAddress());
        secondQueueNumber.put("value",userQueueNumbers.get(1).getCount());

        //没有排队的学生人数
        Map<String,Object> noQueueNumber = new LinkedHashMap<>();
        noQueueNumber.put("name","其他未排队的学生数量");
        noQueueNumber.put("value",userService.findUserNoQueueNumber());

        //封装信息
        List<Map<String,Object>> list = new ArrayList();
        list.add(firstQueueNumber);
        list.add(secondQueueNumber);
        list.add(noQueueNumber);

        Vo vo = new Vo();
        vo.setCode(0);
        vo.setMsg("success");
        vo.setCount(userService.countChannel()+1);
        vo.setData(list);
        return vo;
    }

    /**
     * 加入排队
     * @param request
     * @return
     */
    @RequestMapping("/startQueue")
    @ResponseBody
    public String startQueue(HttpServletRequest request){
        //通过用户名和密码得到用户id
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //这里同样需要对密码进行加密
        password = EncryptUtil.encrypt(password);
        int uid = userService.findUid(username,password);
        //通过uid修改排队状态N-->Y
        String res = "success";
        if(userService.startQueue(uid)==0){
            res="fail";
        }
        return res;
    }

    /**
     * 排队结束/不在排队状态
     * @param request
     * @return
     */
    @RequestMapping("/endQueue")
    @ResponseBody
    public String endQueue(HttpServletRequest request){
        //通过用户名和密码得到用户id
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //这里同样需要对密码进行加密
        password = EncryptUtil.encrypt(password);
        int uid = userService.findUid(username,password);
        //通过uid修改排队状态Y-->N
        String res = "success";
        if(userService.endQueue(uid)==0){
            res="fail";
        }
        return res;
    }

    /**
     * 预测排队时间
     * @param request
     * @return
     */
    @RequestMapping("/predictQueueTime")
    public String predictQueueTime(HttpServletRequest request){
        UserPredictQueueTime userPredictQueueTime = new UserPredictQueueTime();
        //通过登录时的用户名和密码获取uid
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //这里同样需要对密码进行加密
        password = EncryptUtil.encrypt(password);
        int uid = userService.findUid(username,password);
        //根据用户id得到通道id,通道address,当前排队人数,预测时间
        userPredictQueueTime.setId(userService.findCurrentUserCid(uid));//通道id
        //得到当前用户排队通道信息
        UserQueueNumber currentUserQueueNumber = userService.findCurrentUserQueueNumber(userService.findCurrentUserCid(uid));

        userPredictQueueTime.setAddress(currentUserQueueNumber.getAddress());//通道address
        userPredictQueueTime.setCount(currentUserQueueNumber.getCount());//count
        userPredictQueueTime.setTime(currentUserQueueNumber.getCount() * 60);//time--单位秒,这里假设一个人需要一分钟去完成检测过程

        request.getSession().setAttribute("userPredictQueueTime",userPredictQueueTime);
        return "user/predictQueueTime";
    }

    /**
     * 查询当前用户检测结果
     * @param request
     * @return
     */
    @RequestMapping("/findDetectionResult")
    public String findDetectionResult(HttpServletRequest request){
        //通过登录时的用户名和密码获取uid
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //这里同样需要对密码进行加密
        password = EncryptUtil.encrypt(password);
        int uid = userService.findUid(username,password);
        //将信息装进Result实体类中
        Result result = new Result();
        result.setUsername(username);//封装姓名
        result.setAddress(userService.findUserChannel(uid).getAddress());//封装通道地点
        result.setDetectionTime(userService.getDetectionTime());
        result.setResMsg(userService.findUserResMsg(uid));

        //存入session域中
        request.getSession().setAttribute("result",result);
        return "user/detectionResult";
    }

    /**
     * 查询核酸检测记录
     * @param request
     * @return
     */
    @RequestMapping("/detectionRecordInfo")
    @ResponseBody
    public Vo detectionRecordInfo(HttpServletRequest request){
        //通过登录时的用户名和密码获取uid
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //这里同样需要对密码进行加密
        password = EncryptUtil.encrypt(password);
        int uid = userService.findUid(username,password);//得到用户uid

        //得到检测时间、结果时间、检测结果
        List<DeteRecordInfo> deteRecordInfos = userService.findDeteRecordInfo(uid);

//        DeteRecordInfo deteRecordInfo = new DeteRecordInfo();
//        deteRecordInfo.setUsername(username);//装入用户名
//
//        //得到address并分装进实体类
//        deteRecordInfo.setAddress(userService.findUserChannel(uid).getAddress());

        for (DeteRecordInfo recordInfo : deteRecordInfos) {
            recordInfo.setUsername(username);
            recordInfo.setAddress(userService.findUserChannel(uid).getAddress());
        }

        Vo vo = new Vo();
        vo.setCode(0);
        vo.setMsg("success");
        vo.setData(deteRecordInfos);
        vo.setCount(deteRecordInfos.size());
        return vo;
    }

    /**
     * 查询用户信息放入session
     */
    @RequestMapping("/findUserInfo")
    public String findUserInfo(HttpServletRequest request){
        //通过登录时的用户名和密码获取uid
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //同理这里在添加的时候要先对admin密码进行加密存入对象
        password = EncryptUtil.encrypt(password);
        User userInfo = userService.findUserInfo(username, password);
        System.out.println(userInfo);
        request.getSession().setAttribute("userInfo",userInfo);
        return "user/userInfo";
    }

    /**
     * 用户在个人面板修改密码
     * @return
     */
    @RequestMapping("/changeUserPassword")
    @ResponseBody
    public Vo changeUserPassword(@RequestBody ChangePassword changePassword,
                                 HttpServletRequest request){
        String oldPassword = changePassword.getOldPassword();
        String newPassword1 = changePassword.getNewPassword1();
        System.out.println(oldPassword);
        System.out.println(newPassword1);
        Vo vo = new Vo();
        //boolean isDoubleUpdate = false;//判断在同一次登陆中有没有多次修改密码
        //通过登录时的用户名和密码获取uid,管理员对象
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();

        //这里要加密一下,不然查不出来，后期这里可以加保护语句
        password = EncryptUtil.encrypt(password);

        User user = userService.findUser(username, password);

        if(user.getPassword().equals(EncryptUtil.encrypt(oldPassword))) {
            user.setPassword(EncryptUtil.encrypt(newPassword1));
            userService.updateUserPassword(user);
            vo.setMsg("密码修改成功!");
        }else{
            vo.setMsg("旧密码输入有误!!");
        }
        vo.setCode(0);
        vo.setCount(1);
        vo.setData(user);
        return vo;
    }

    /*******************************************用户的管理CRUD*******************************************/

    /**
     * 查询所有用户信息,以列表形式展示,并且添加分页功能
     *produces ="application/json;charset=UTF-8" 解决json在页面中文乱码问题
     * @return
     */
    @GetMapping(produces ="application/json;charset=UTF-8")
    @ResponseBody
    public Vo get(@RequestParam("page") String page,
                  @RequestParam("limit") String limit) throws SysException {

        //把传入参数转为int类型
        int tempPage = Integer.parseInt(page);//选中的页码
        int selectedLimit = Integer.parseInt(limit);//选中的每页显示条数

        //计算一下选中的页码在limit后面的index
        int selectedPage=(tempPage-1)*selectedLimit;

        List<User> users = userService.findAll(selectedPage,selectedLimit);

        Vo vo = new Vo();
        vo.setCode(0);
        vo.setMsg("success");
        //vo.setCount(users.size());
        //这里应该得到总表数量,->countUser()
        vo.setCount(userService.countUser());
        vo.setData(users);

        //使用jackson
        //ObjectMapper mapper = new ObjectMapper();
        //String res = mapper.writeValueAsString(vo);

        return vo;
    }

    /**
     * 实现删除用户信息
     *
     * @param user
     * @return
     */
    @DeleteMapping("/{id}")
    @ResponseBody
    public String delete(@RequestBody User user){
        String res="success";

        if(userService.deleteUserInfo(user.getId())==0){
            res="fail";
        }
        return res;
    }

    /**
     * RequestParam要与name搭配否则会报错400
     *       @RequestParam("uid") String uid, @RequestParam("username") String username,
     *       @RequestParam("password") String password, @RequestParam("usex") String usex,
     *       @RequestParam("uphone") String uphone, @RequestParam("queue_status") String queue_status,
     *       @RequestParam("cid") String cid, @RequestParam("rid") String rid,
     *       @RequestParam("roleid") String roleid
     * @return
     */
    @PutMapping
    @ResponseBody
    public String put(@RequestBody User user) {
//        int uid_temp = Integer.parseInt(uid);
//        int cid_temp = Integer.parseInt(cid);
//        int rid_temp = Integer.parseInt(rid);
//        int roleid_temp = Integer.parseInt(roleid);

//        User user = new User();
//        user.setUid(uid_temp);
//        user.setUsername(username);
//        user.setPassword(password);
//        user.setUsex(usex);
//        user.setUphone(uphone);
//        user.setQueue_status(queue_status);
//        user.setCid(cid_temp);
//        user.setRid(rid_temp);
//        user.setRoleid(roleid_temp);
        //修改后对user密码进行加密后传入数据库保存
        user.setPassword(EncryptUtil.encrypt(user.getPassword()));
        int result = userService.updateUserInfo(user);
        System.out.println(result);
        if (result==0){
            return "fail";
        }
        return "success";
    }

    /**
     * 实现添加用户信息
     * @param user
     * @return
     */
    @PostMapping
    @ResponseBody
    public String post(@RequestBody User user){
        String res="success";

        //添加用户信息前先把密码加密以后存入数据库
        if (user.getPassword().length()!=32){
            user.setPassword(EncryptUtil.encrypt(user.getPassword()));
        }
        if(userService.addUserInfo(user)==0){
            res="fail";
        }
        return res;
    }

    /**
     * 在用户列表界面根据模糊查询,查询用户信息
     * @param user
     * @return
     */
    @RequestMapping("/findUserByLike")
    @ResponseBody
    public Vo findUserByLike(@RequestParam("page") String page,
                             @RequestParam("limit") String limit,
                             User user){

        //把传入参数转为int类型
        int tempPage = Integer.parseInt(page);//选中的页码
        int selectedLimit = Integer.parseInt(limit);//选中的每页显示条数

        //计算一下选中的页码在limit后面的index
        int selectedPage=(tempPage-1)*selectedLimit;

        String sex = user.getSex();
        if (sex.equals("0")){
            sex="";
            user.setSex(sex);
        }
        if (sex.equals("1")){
            sex="男";
            user.setSex(sex);
        }
        if (sex.equals("2")){
            sex="女";
            user.setSex(sex);
        }
        List<User> list = userService.findUserByLike(user,selectedPage,selectedLimit);
        Vo vo = new Vo();
        vo.setCode(0);
        vo.setData(list);
        vo.setMsg("success");
        //这里不能用list.size(),要查出总数
        vo.setCount(userService.countUserByLike(user));
        return vo;
    }
}
