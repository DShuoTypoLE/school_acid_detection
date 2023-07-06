package cn.tongda.domain.pojo;

import java.io.Serializable;

/**
 * 用于显示用户排队人数
 * @author 丁硕
 * @version 1.0
 */
public class UserQueueNumber implements Serializable {
    private Integer id;
    private String address;
    private Integer count;

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

    @Override
    public String toString() {
        return "UserQueueNumber{" +
                "id=" + id +
                ", address='" + address + '\'' +
                ", count=" + count +
                '}';
    }
}
