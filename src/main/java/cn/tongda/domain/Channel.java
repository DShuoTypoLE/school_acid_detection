package cn.tongda.domain;

import java.io.Serializable;

/**
 * 核酸检测通道实体类
 * @author 丁硕
 * @version 1.0
 */
public class Channel implements Serializable {
    private Integer id;
    private String address;

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

    @Override
    public String toString() {
        return "Channel{" +
                "id=" + id +
                ", address='" + address + '\'' +
                '}';
    }
}
