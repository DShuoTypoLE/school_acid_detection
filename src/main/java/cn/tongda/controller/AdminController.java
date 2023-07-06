package cn.tongda.controller;

import cn.tongda.domain.Admin;
import cn.tongda.domain.User;
import cn.tongda.domain.Vo;
import cn.tongda.domain.pojo.AdminInfo;
import cn.tongda.domain.pojo.ChangePassword;
import cn.tongda.exception.SysException;
import cn.tongda.service.IAdminService;
import cn.tongda.service.IUserService;
import cn.tongda.utils.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理员表现层
 * 使用restful风格:
 * 增加一个朋友,接口类型：POST
 * 删除一个朋友, 接口类型：DELETE
 * 修改一个朋友, 接口类型：PUT
 * 查找一个朋友, 接口类型：GET
 * @author 丁硕
 * @version 1.0
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private IAdminService adminService;


    /**
     * 查询管理员信息放入session
     */
    @RequestMapping("/findAdminInfo")
    @ResponseBody
    public String findAdminInfo(HttpServletRequest request) {
        //通过登录时的用户名和密码获取uid
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //同理这里在添加的时候要先对admin密码进行加密存入对象
        password = EncryptUtil.encrypt(password);
        AdminInfo adminInfo = adminService.findAdminInfo(username, password);
        request.getSession().setAttribute("adminInfo", adminInfo);
        return "success";
    }

    /**
     * @return
     * @RequestParam("oldPassword") String oldPassword,
     * @RequestParam("newPassword1") String newPassword1
     * 管理员在个人面板修改密码
     */
    @RequestMapping("/changeAdminPassword")
    @ResponseBody
    public Vo changeAdminPassword(@RequestBody ChangePassword changePassword,
                                  HttpServletRequest request) {
        String oldPassword = changePassword.getOldPassword();
        String newPassword1 = changePassword.getNewPassword1();
        System.out.println(oldPassword);
        System.out.println(newPassword1);
        Vo vo = new Vo();
        //通过登录时的用户名和密码获取uid,管理员对象
        String username = request.getSession().getAttribute("username").toString();
        String password = request.getSession().getAttribute("password").toString();
        //这里要加密一下,不然查不出来，后期这里可以加保护语句
        password = EncryptUtil.encrypt(password);
        Admin admin = adminService.findAdmin(username, password);
        if (admin.getPassword().equals(EncryptUtil.encrypt(oldPassword))) {
            admin.setPassword(EncryptUtil.encrypt(newPassword1));
            adminService.updateAdminPassword(admin);
            vo.setMsg("密码修改成功!");
        } else {
            vo.setMsg("旧密码输入有误!!");
        }
        vo.setCode(0);
        vo.setCount(1);
        vo.setData(admin);
        return vo;
    }

    /**
     * 查询检测通道列表并查出排队人数
     *
     * @return
     */
    @RequestMapping("/findChannel")
    @ResponseBody
    public Vo findChannel() {
        Vo vo = new Vo();
        vo.setCode(0);
        vo.setMsg("success");
        vo.setCount(adminService.countChannel());
        vo.setData(adminService.findChannel());
        return vo;
    }

    /****************************************管理员的管理CRUD*************************************/

    /**
     * 查询所有用户信息,以列表形式展示,并且添加分页功能
     *produces ="application/json;charset=UTF-8" 解决json在页面中文乱码问题
     * @return
     */
    @GetMapping(produces ="application/json;charset=UTF-8")
    @ResponseBody
    public Vo get(@RequestParam("page") String page,
                  @RequestParam("limit") String limit)  {

        //把传入参数转为int类型
        int tempPage = Integer.parseInt(page);//选中的页码
        int selectedLimit = Integer.parseInt(limit);//选中的每页显示条数

        //计算一下选中的页码在limit后面的index
        int selectedPage=(tempPage-1)*selectedLimit;

        List<Admin> admins = adminService.findAll(selectedPage,selectedLimit);

        Vo vo = new Vo();
        vo.setCode(0);
        vo.setMsg("success");
        //vo.setCount(users.size());
        //这里应该得到总表数量,->countUser()
        vo.setCount(adminService.countAdmin());
        vo.setData(admins);

        //使用jackson
        //ObjectMapper mapper = new ObjectMapper();
        //String res = mapper.writeValueAsString(vo);

        return vo;
    }

    /**
     * 实现删除管理员信息
     *
     * @param admin
     * @return
     */
    @DeleteMapping("/{id}")
    @ResponseBody
    public String delete(@RequestBody Admin admin){
        String res="success";

        if(adminService.deleteAdminInfo(admin.getId())==0){
            res="fail";
        }
        return res;
    }

    /**
     * 更新管理员信息
     * @param admin
     * @return
     */
    @PutMapping
    @ResponseBody
    public String put(@RequestBody Admin admin) {
        String res="success";
        //同理这里在添加的时候要先对admin密码进行加密存入对象
        if (admin.getPassword().length()!=32){
            admin.setPassword(EncryptUtil.encrypt(admin.getPassword()));
        }
        int result = adminService.updateAdminInfo(admin);
        System.out.println(result);
        if (result==0){
            res="fail";
        }
        return res;
    }

    /**
     * 实现添加管理员信息
     * @param admin
     * @return
     */
    @PostMapping
    @ResponseBody
    public String post(@RequestBody Admin admin){
        String res="success";
        //同理这里在添加的时候要先对admin密码进行加密存入对象
        admin.setPassword(EncryptUtil.encrypt(admin.getPassword()));
        if(adminService.addAdminInfo(admin)==0){
            res="fail";
        }
        return res;
    }
}
