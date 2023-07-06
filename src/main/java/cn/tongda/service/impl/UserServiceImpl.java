package cn.tongda.service.impl;

import cn.tongda.dao.IUserDao;
import cn.tongda.domain.User;
import cn.tongda.domain.pojo.DeteRecordInfo;
import cn.tongda.domain.pojo.UserChannel;
import cn.tongda.domain.pojo.UserQueueNumber;
import cn.tongda.service.IUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author 丁硕
 * @version 1.0
 */
@Service
public class UserServiceImpl implements IUserService {
    @Autowired
    private IUserDao userDao;
    /**
     * 根据用户姓名和密码来验证用户信息,此处用于登录验证
     * @param username
     * @param password
     * @return
     */
    @Override
    public User findUser(String username, String password) {
        return userDao.findUser(username,password);
    }

    /**
     * 根据用户姓名和密码查询用户id
     * @param username
     * @param password
     * @return
     */
    @Override
    public int findUid(String username, String password) {
        return userDao.findUid(username,password);
    }

    /**
     * 根据用户id查询检测通道
     * @param uid
     * @return
     */
    @Override
    public UserChannel findUserChannel(int uid) {
        return userDao.findUserChannel(uid);
    }

    /**
     * 查询检测通道数量
     * @return
     */
    @Override
    public Integer countChannel() {
        return userDao.countChannel();
    }

    /**
     * 查询用户排队数量(根据地点分组)
     * @return
     */
    @Override
    public List<UserQueueNumber> findUserQueueNumber() {
        return userDao.findUserQueueNumber();
    }

    /**
     * 查询用户没有排队的数量(纯纯为了给图的数据看上去多点)
     * @return
     */
    @Override
    public Integer findUserNoQueueNumber() {
        return userDao.findUserNoQueueNumber();
    }

    /**
     * 根据用户id让用户加入排队
     * @param id
     * @return
     */
    @Override
    public int startQueue(int id) {
        return userDao.startQueue(id);
    }

    /**
     * 根据用户id让用户结束排队
     * @param id
     * @return
     */
    @Override
    public int endQueue(int id) {
        return userDao.endQueue(id);
    }

    /**
     * 根据用户id查询当前用户通道id
     * @param id
     * @return
     */
    @Override
    public int findCurrentUserCid(int id) {
        return userDao.findCurrentUserCid(id);
    }

    /**
     * 根据当前用户检测通道id查询当前用户所在检测地点排队数量
     * @param id
     * @return
     */
    @Override
    public UserQueueNumber findCurrentUserQueueNumber(int id) {
        return userDao.findCurrentUserQueueNumber(id);
    }

    /**
     * 根据现在时间计算核酸检测时间,假定向前推24小时
     * @return
     */
    @Override
    public String getDetectionTime() {
        Calendar calendar = Calendar.getInstance();
        //得到前一天的时间
        calendar.add(Calendar.DAY_OF_MONTH,-1);
        Date yesterday = calendar.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String yesterday_ = sdf.format(yesterday);

        return yesterday_;
    }

    /**
     * 根据当前用户id得到上一次核酸检测结果
     * @param uid
     * @return
     */
    @Override
    public String findUserResMsg(int uid) {
        return userDao.findUserResMsg(uid);
    }

    /**
     * 根据用户id查询检测结果记录表信息
     * @param uid
     * @return
     */
    @Override
    public List<DeteRecordInfo> findDeteRecordInfo(int uid) {
        return userDao.findDeteRecordInfo(uid);
    }

    /**
     * 根据用户名和密码查询用户信息(用于个人信息展示)
     * @param username
     * @param password
     * @return
     */
    @Override
    public User findUserInfo(String username, String password) {
        return userDao.findUserInfo(username,password);
    }

    /**
     * 修改用户密码
     * @param user
     */
    @Override
    public void updateUserPassword(User user) {
        userDao.updateUserPassword(user);
    }



//    /**
//     * 根据用户id查询用户(用于在同一次登陆中多次修改密码)
//     * @param uid
//     * @return
//     */
//    @Override
//    public User findUserById(int uid) {
//        return userDao.findUserById(uid);
//    }

    /*********************************用户的管理CRUD*******************************/
    /**
     * 查询所有用户信息,这里用User比较麻烦
     * @param selectedPage
     * @param selectedLimit
     * @return
     */
    @Override
    public List<User> findAll(int selectedPage, int selectedLimit) {
        return userDao.findAll(selectedPage,selectedLimit);
    }

    /**
     * 返回user表数据总数
     * @return
     */
    @Override
    public int countUser() {
        return userDao.countUser();
    }

    /**
     * 删除用户信息(根据用户id)
     * @param id
     * @return
     */
    @Override
    public int deleteUserInfo(int id) {
        return userDao.deleteUserInfo(id);
    }

    /**
     * 更新用户信息
     * @param user
     * @return
     */
    @Override
    public int updateUserInfo(User user) {
        return userDao.updateUserInfo(user);
    }

    /**
     * 添加用户信息
     * @param user
     * @return
     */
    @Override
    public int addUserInfo(User user) {
        return userDao.addUserInfo(user);
    }

    /**
     * 根据用户输入信息查询相应条件的用户
     * @param user
     * @param selectedPage
     * @param selectedLimit
     * @return
     */
    @Override
    public List<User> findUserByLike(User user,int selectedPage,int selectedLimit) {
        return userDao.findUserByLike(user,selectedPage,selectedLimit);
    }

    /**
     * 根据用户输入信息查询相应条件的用户数量
     * @param user
     * @return
     */
    @Override
    public int countUserByLike(User user) {
        return userDao.countUserByLike(user);
    }
}
