package cn.tongda.domain.pojo;

import java.io.Serializable;

/**
 * 查询用户个人检测通道
 * @author 丁硕
 * @version 1.0
 */
public class UserChannel implements Serializable {
    private Integer id;
    private String username;
    private String sex;
    private String phone;
    private String queueStatus;
    private String address;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getQueueStatus() {
        return queueStatus;
    }

    public void setQueueStatus(String queueStatus) {
        this.queueStatus = queueStatus;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "UserChannel{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", sex='" + sex + '\'' +
                ", phone='" + phone + '\'' +
                ", queueStatus='" + queueStatus + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
