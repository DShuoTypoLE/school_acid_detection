package cn.tongda.controller;

import cn.tongda.domain.Admin;
import cn.tongda.domain.User;
import cn.tongda.service.IAdminService;
import cn.tongda.service.IUserService;
import cn.tongda.utils.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author 丁硕
 * @version 1.0
 */
@Controller
@RequestMapping("/login")
public class CheckLoginController {
    @Autowired
    private IUserService userService;
    @Autowired
    private IAdminService adminService;

    @RequestMapping("/checkLogin")
    @ResponseBody
    public String checkLogin(@RequestParam("username") String username,
                             @RequestParam("password") String password,
                             @RequestParam("role") String roleId,
                             HttpServletRequest request){
        //获取用户名并存入session中用于后面后台首页显示
        request.getSession().setAttribute("username",username);
        //获取用户密码并存入session中用于后面后台重名问题
        request.getSession().setAttribute("password",password);

        //在登陆时进行密码加密和数据库中已经加密好的数据进行比较
        password = EncryptUtil.encrypt(password);
        if("1".equals(roleId)){//超级管理员
            Admin admin = adminService.findAdmin(username, password);
            if(admin!=null){
                return "success";
            }else{
                return "fail";
            }
        }else if("2".equals(roleId)){//用户
            User user = userService.findUser(username, password);
            if(user!=null){
                return "success";
            }else{
                return "fail";
            }
        }else{
            //以后扩展
            return "请联系管理员...";
        }
    }

}
