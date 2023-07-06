package cn.tongda.domain.pojo;

import java.io.Serializable;

/**
 * 用户排队时间预测实体类
 * @author 丁硕
 * @version 1.0
 */
public class UserPredictQueueTime implements Serializable {
    private Integer id;
    private String address;
    private Integer count;
    private Integer time;

    public UserPredictQueueTime() {
    }

    public UserPredictQueueTime(Integer id, String address, Integer count, Integer time) {
        this.id = id;
        this.address = address;
        this.count = count;
        this.time = time;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "UserPredictQueueTime{" +
                "id=" + id +
                ", address='" + address + '\'' +
                ", count=" + count +
                ", time=" + time +
                '}';
    }
}
