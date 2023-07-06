package cn.tongda.service.impl;

import cn.tongda.dao.IAdminDao;
import cn.tongda.domain.Admin;
import cn.tongda.domain.Channel;
import cn.tongda.domain.pojo.AdminInfo;
import cn.tongda.domain.pojo.UserQueueNumber;
import cn.tongda.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 丁硕
 * @version 1.0
 */
@Service
public class AdminServiceImpl implements IAdminService {
    @Autowired
    private IAdminDao adminDao;

    /**
     * 根据姓名和密码查询管理员,此时用于登陆验证
     * @param username
     * @param password
     * @return
     */
    @Override
    public Admin findAdmin(String username, String password) {
        return adminDao.findAdmin(username,password);
    }

    /**
     * 根据用户名和密码查询管理员信息
     * @param username
     * @param password
     * @return
     */
    @Override
    public AdminInfo findAdminInfo(String username, String password) {
        return adminDao.findAdminInfo(username,password);
    }

    /**
     * 修改管理员密码
     * @param admin
     */
    @Override
    public void updateAdminPassword(Admin admin) {
        adminDao.updateAdminPassword(admin);
    }

    /**
     * 查询检测通道列表并查出排队人数
     * @return
     */
    @Override
    public List<UserQueueNumber> findChannel() {
        return adminDao.findChannel();
    }

    /**
     * 查询检测通道数量
     * @return
     */
    @Override
    public int countChannel() {
        return adminDao.countChannel();
    }

    /******************************管理员CRUD**************************/
    /**
     * 查询所有管理员信息，这里后面进行优化,添加了分页功能
     * @return
     */
    @Override
    public List<Admin> findAll(int selectedPage, int selectedLimit) {
        return adminDao.findAll(selectedPage,selectedLimit);
    }

    /**
     * 返回admin表数据总数
     * @return
     */
    @Override
    public int countAdmin() {
        return adminDao.countAdmin();
    }

    /**
     * 删除管理员信息(根据管理员id)
     * @param id
     * @return
     */
    @Override
    public int deleteAdminInfo(Integer id) {
        return adminDao.deleteAdminInfo(id);
    }

    /**
     * 修改管理员信息
     * @param admin
     * @return
     */
    @Override
    public int updateAdminInfo(Admin admin) {
        return adminDao.updateAdminInfo(admin);
    }

    /**
     * 添加管理员信息
     * @param admin
     * @return
     */
    @Override
    public int addAdminInfo(Admin admin) {
        return adminDao.addAdminInfo(admin);
    }
}
