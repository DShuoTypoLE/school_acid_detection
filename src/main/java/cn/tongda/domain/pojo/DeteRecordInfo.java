package cn.tongda.domain.pojo;

import java.io.Serializable;

/**
 * 检测结果记录信息
 * @author 丁硕
 * @version 1.0
 */
public class DeteRecordInfo implements Serializable {
    private String username;
    private String address;//采样点
    private String deteTime;//检测时间
    private String resTime;//得到结果的时间
    private String resMsg;//检测结果

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

    public String getDeteTime() {
        return deteTime;
    }

    public void setDeteTime(String deteTime) {
        this.deteTime = deteTime;
    }

    public String getResTime() {
        return resTime;
    }

    public void setResTime(String resTime) {
        this.resTime = resTime;
    }

    public String getResMsg() {
        return resMsg;
    }

    public void setResMsg(String resMsg) {
        this.resMsg = resMsg;
    }

    @Override
    public String toString() {
        return "DeteRecordInfo{" +
                "username='" + username + '\'' +
                ", address='" + address + '\'' +
                ", deteTime='" + deteTime + '\'' +
                ", resTime='" + resTime + '\'' +
                ", resMsg='" + resMsg + '\'' +
                '}';
    }
}
