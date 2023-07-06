package cn.tongda.domain;

import java.io.Serializable;

/**
 * 管理员实体类
 * @author 丁硕
 * @version 1.0
 */
public class Admin implements Serializable {
    private int id;
    private String username;
    private String password;
    private int roleid;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", roleid=" + roleid +
                '}';
    }
}
