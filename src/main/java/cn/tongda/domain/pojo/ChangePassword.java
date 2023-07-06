package cn.tongda.domain.pojo;

import java.io.Serializable;

/**
 * 用于用户或者管理员封装前端个人面板修改密码的对象参数实体
 * @author 丁硕
 * @version 1.0
 */
public class ChangePassword implements Serializable {
    private String username;
    private String oldPassword;
    private String newPassword1;
    private String newPassword2;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword1() {
        return newPassword1;
    }

    public void setNewPassword1(String newPassword1) {
        this.newPassword1 = newPassword1;
    }

    public String getNewPassword2() {
        return newPassword2;
    }

    public void setNewPassword2(String newPassword2) {
        this.newPassword2 = newPassword2;
    }
}
