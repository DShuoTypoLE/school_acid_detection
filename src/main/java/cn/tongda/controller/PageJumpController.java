package cn.tongda.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author 丁硕
 * @version 1.0
 */
@Controller
@RequestMapping("/page")
public class PageJumpController {

    /**
     * 由登录界面跳转到管理员主页面
     *
     * @return
     */
    @RequestMapping("/loginToAdminPage")
    public String loginToAdminPage() {
        return "admin/adminPage";
    }

    /**
     * 由登录界面跳转到用户主页面
     *
     * @return
     */
    @RequestMapping("/loginToUserPage")
    public String loginToUserPage() {
        return "user/userPage";
    }

    /**
     * 用户主页跳转到查询自己的检测通道的页面
     *
     * @return
     */
    @RequestMapping("/userPageToUserChannel")
    public String userPageToUserChannel() {
        return "user/userChannel";
    }

    /**
     * 由用户界面弹出预测排队时间的界面
     *
     * @return
     */
    @RequestMapping("/predictQueueTime")
    public String userPageToPredictQueueTime() {
        return "user/predictQueueTime";
    }

    /**
     * 由用户界面右侧弹出核酸检测记录界面
     *
     * @return
     */
    @RequestMapping("/detectionRecordInfo")
    public String userPageToDetectionRecordInfo() {
        return "user/detectionRecordInfo";
    }

    /**
     * 用户界面跳转到用户修改密码界面
     *
     * @return
     */
    @RequestMapping("/userPageToUserChangePassword")
    public String userPageToUserChangePassword() {
        return "user/userChangePassword";
    }

    /***************************************下面是管理员界面跳转**************************************************/

    /**
     * 管理员界面显示首页
     *
     * @return
     */
    @RequestMapping("/adminPageToMain")
    public String adminPageToMain() {
        return "admin/main";
    }

    /**
     * 管理员界面显示个人信息
     *
     * @return
     */
    @RequestMapping("/adminPageToAdminInfo")
    public String adminPageToAdminInfo() {
        return "admin/adminInfo";
    }

    /**
     * 管理员界面修改密码
     *
     * @return
     */
    @RequestMapping("/adminPageToAdminChangePassword")
    public String adminPageToAdminChangePassword() {
        return "admin/adminChangePassword";
    }

    /**
     * 管理员界面查询检测通道
     * @return
     */
    @RequestMapping("/adminPageToFindChannel")
    public String adminPageToFindChannel() {
        return "admin/findChannel";
    }

    /**
     * 管理员界面查询所有用户并以列表形式展示
     * @return
     */
    @RequestMapping("/adminPageToAllUserList")
    public String adminPageToAllUserList(){
        return "admin/allUserList";
    }

    /**
     * 用户列表界面弹出编辑用户界面
     * @return
     */
    @RequestMapping("/allUserListToUpdateUserInfo")
    public String allUserListToUpdateUserInfo(){
        return "admin/updateUserInfo";
    }

    /**
     * 管理员界面添加用户
     * @return
     */
    @RequestMapping("/adminPageToAddUser")
    public String adminPageToAddUser(){
        return "admin/addUser";
    }

    /**
     * 管理员界面查询所有管理员并以列表的形式添加
     * @return
     */
    @RequestMapping("/adminPageToAllAdminList")
    public String adminPageToAllAdminList(){
        return "admin/allAdminList";
    }

    /**
     * 管理员界面添加管理员
     * @return
     */
    @RequestMapping("/adminPageToAddAdmin")
    public String adminPageToAddAdmin(){
        return "admin/addAdmin";
    }

    /*******************************************************************/

    @RequestMapping("/predictQueueTimeToClock")
    public String predictQueueTimeToClock(){
        return "user/clock";
    }
}