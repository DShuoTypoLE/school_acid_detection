package cn.tongda.domain.pojo;

import java.io.Serializable;

/**
 * 用户查询检测结果实体类
 * @author 丁硕
 * @version 1.0
 */
public class Result implements Serializable {
    private String username;
    private String address;
    private String detectionTime;//检测时间
    private String resMsg;//结果信息

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetectionTime() {
        return detectionTime;
    }

    public void setDetectionTime(String detectionTime) {
        this.detectionTime = detectionTime;
    }

    public String getResMsg() {
        return resMsg;
    }

    public void setResMsg(String resMsg) {
        this.resMsg = resMsg;
    }

    @Override
    public String toString() {
        return "Result{" +
                "username='" + username + '\'' +
                ", address='" + address + '\'' +
                ", detectionTime='" + detectionTime + '\'' +
                ", resMsg='" + resMsg + '\'' +
                '}';
    }
}
