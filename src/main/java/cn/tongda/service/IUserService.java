package cn.tongda.service;

import cn.tongda.domain.User;
import cn.tongda.domain.pojo.DeteRecordInfo;
import cn.tongda.domain.pojo.UserChannel;
import cn.tongda.domain.pojo.UserPredictQueueTime;
import cn.tongda.domain.pojo.UserQueueNumber;

import java.util.List;

/**
 * 用户业务层
 * @author 丁硕
 * @version 1.0
 */
public interface IUserService {
    /**
     * 根据用户姓名和密码来验证用户信息,此处用于登录验证
     * @param username
     * @param password
     * @return
     */
    User findUser(String username, String password);

    /**
     * 根据用户姓名和密码查询用户id
     * @param username
     * @param password
     * @return
     */
    int findUid(String username, String password);

    /**
     * 根据用户id查询检测通道
     * @param uid
     * @return
     */
    UserChannel findUserChannel(int uid);

    /**
     * 查询检测通道数量
     * @return
     */
    Integer countChannel();

    /**
     * 查询用户排队数量(根据地点分组)
     * @return
     */
    List<UserQueueNumber> findUserQueueNumber();

    /**
     * 查询用户没有排队的数量(纯纯为了给图的数据看上去多点)
     * @return
     */
    Integer findUserNoQueueNumber();

    /**
     * 根据用户id让用户加入排队
     * @return
     */
    int startQueue(int id);

    /**
     * 根据用户id让用户结束排队
     * @param id
     * @return
     */
    int endQueue(int id);

    /**
     * 根据用户id查询当前用户通道id
     * @param id
     * @return
     */
    int findCurrentUserCid(int id);

    /**
     * 根据当前用户检测通道id查询当前用户所在检测地点排队数量
     * @param id
     * @return
     */
    UserQueueNumber findCurrentUserQueueNumber(int id);

    /**
     * 根据现在时间计算核酸检测时间
     * @return
     */
    String getDetectionTime();

    /**
     * 根据当前用户id得到上一次核酸检测结果
     * @param uid
     * @return
     */
    String findUserResMsg(int uid);

    /**
     * 根据用户id查询检测结果记录表信息
     * @param uid
     * @return
     */
    List<DeteRecordInfo> findDeteRecordInfo(int uid);

    /**
     * 根据用户名和密码查询用户信息(用于个人信息展示)
     * @param username
     * @param password
     * @return
     */
    User findUserInfo(String username, String password);

    /**
     * 修改用户密码
     * @param user
     */
    void updateUserPassword(User user);

//    /**
//     * 根据用户id查询用户(用于在同一次登陆中多次修改密码)
//     * @param uid
//     * @return
//     */
//    User findUserById(int uid);


    /*********************************用户的管理CRUD*******************************/
    /**
     * 查询所有用户信息,这里用User比较麻烦
     * @return
     */
    List<User> findAll(int selectedPage,int selectedLimit);

    /**
     * 返回user表数据总数
     * @return
     */
    int countUser();

    /**
     * 删除用户信息(根据用户id)
     * @param id
     * @return
     */
    int deleteUserInfo(int id);

    /**
     * 更新用户信息
     * @param user
     */
    int updateUserInfo(User user);

    /**
     * 添加用户信息
     * @param user
     * @return
     */
    int addUserInfo(User user);

    /**
     * 根据用户输入信息查询相应条件的用户
     * @param user
     * @param selectedPage
     * @param selectedLimit
     * @return
     */
    List<User> findUserByLike(User user,int selectedPage,int selectedLimit);

    /**
     * 根据用户输入信息查询相应条件的用户数量
     * @param user
     * @return
     */
    int countUserByLike(User user);
}
