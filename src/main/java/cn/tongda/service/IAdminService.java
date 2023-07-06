package cn.tongda.service;

import cn.tongda.domain.Admin;
import cn.tongda.domain.Channel;
import cn.tongda.domain.pojo.AdminInfo;
import cn.tongda.domain.pojo.UserQueueNumber;

import java.util.List;

/**
 * 管理员业务层
 * @author 丁硕
 * @version 1.0
 */
public interface IAdminService {
    /**
     * 根据姓名和密码查询管理员,此时用于登陆验证
     * @param username
     * @param password
     * @return
     */
    Admin findAdmin(String username, String password);

    /**
     * 根据用户名和密码查询管理员信息
     * @param username
     * @param password
     * @return
     */
    AdminInfo findAdminInfo(String username, String password);

    /**
     * 修改管理员密码
     * @param admin
     */
    void updateAdminPassword(Admin admin);

    /**
     * 查询检测通道列表并查出排队人数
     * @return
     */
    List<UserQueueNumber> findChannel();

    /**
     * 查询检测通道数量
     * @return
     */
    int countChannel();

    /****************************管理员CRUD***********************/
    /**
     * 查询所有管理员信息，这里后面进行优化,添加了分页功能
     * @return
     */
    List<Admin> findAll(int selectedPage,int selectedLimit);

    /**
     * 返回admin表数据总数
     * @return
     */
    int countAdmin();

    /**
     * 删除管理员信息(根据管理员id)
     * @param id
     * @return
     */
    int deleteAdminInfo(Integer id);

    /**
     * 修改管理员信息
     * @param admin
     * @return
     */
    int updateAdminInfo(Admin admin);

    /**
     * 添加管理员信息
     * @param admin
     * @return
     */
    int addAdminInfo(Admin admin);
}
