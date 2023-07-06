package cn.tongda.dao;

import cn.tongda.domain.User;
import cn.tongda.domain.pojo.DeteRecordInfo;
import cn.tongda.domain.pojo.UserChannel;
import cn.tongda.domain.pojo.UserQueueNumber;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户持久层
 * @author 丁硕
 * @version 1.0
 */
@Repository
public interface IUserDao {
    /**
     * 根据用户姓名和密码来验证用户信息,此处用于登录验证
     * @param username
     * @param password
     * @return
     */
    @Select("select * from user where username=#{username} and password=#{password}")
    User findUser(@Param("username") String username, @Param("password") String password);

    /**
     * 根据用户姓名和密码查询用户id
     * @param username
     * @param password
     * @return
     */
    @Select("select id from user where username = #{username} and password = #{password}")
    int findUid(@Param("username") String username, @Param("password") String password);

    /**
     * 根据用户id查询检测通道
     * @param uid
     * @return
     */
    @Select("select user.id,username,sex,phone,queueStatus,address from user,channel " +
            "where user.cid=channel.id and user.id=#{uid}")
    UserChannel findUserChannel(int uid);

    /**
     * 查询检测通道数量
     * @return
     */
    @Select("select count(*) as count from channel")
    Integer countChannel();

    /**
     * 查询用户排队数量(根据地点分组)
     * @return
     */
    @Select("select channel.id,address,COUNT(1) AS count FROM `user`,channel " +
            " WHERE user.cid=channel.id " +
            " AND queueStatus='Y' GROUP BY channel.id,address")
    List<UserQueueNumber> findUserQueueNumber();

    /**
     * 查询用户没有排队的数量(纯纯为了给图的数据看上去多点)
     * @return
     */
    @Select("select count(1) as count from user where queueStatus='N'")
    Integer findUserNoQueueNumber();

    /**
     * 根据用户id让用户加入排队
     * @return
     */
    @Update("update user set queueStatus = 'Y' where id = #{id}")
    int startQueue(int id);

    /**
     * 根据用户id让用户结束排队
     * @param id
     * @return
     */
    @Update("update user set queueStatus = 'N' where id = #{id}")
    int endQueue(int id);

    /**
     * 根据用户id查询当前用户通道id
     * @param id
     * @return
     */
    @Select("select cid from user where id = #{id}")
    int findCurrentUserCid(int id);

    /**
     * 根据当前用户检测通道id查询当前用户所在检测地点排队数量
     * @param id
     * @return
     */
    @Select("select t.* from (select channel.id as id,address,COUNT(1) AS count FROM `user`,channel " +
            " WHERE user.cid=channel.id " +
            " AND queueStatus='Y' GROUP BY channel.id,address) t where id = #{id}")
    UserQueueNumber findCurrentUserQueueNumber(int id);

    /**
     * 根据当前用户id得到上一次核酸检测结果
     * @param uid
     * @return
     */
    @Select("select resMsg from user,result where user.resultid = result.id " +
            " and user.id = #{uid}")
    String findUserResMsg(int uid);

    /**
     * 根据用户id查询检测结果记录表信息
     * @param uid
     * @return
     */
    @Select("select deteTime,resTime,resMsg from recordInfo where uid = #{uid}")
    List<DeteRecordInfo> findDeteRecordInfo(int uid);

    /**
     * 根据用户名和密码查询用户信息(用于个人信息展示)
     * @param username
     * @param password
     * @return
     */
    @Select("select username,nickname,sex,phone,email from user" +
            " where username = #{username} and " +
            " password = #{password}")
    User findUserInfo(@Param("username") String username,@Param("password") String password);

    /**
     * 修改用户密码
     * @param user
     */
    @Update("update user set password=#{password} where id=#{id}")
    void updateUserPassword(User user);

//    /**
//     * 根据用户id查询用户(用于在同一次登陆中多次修改密码)
//     * @param uid
//     * @return
//     */
//    @Select("select * from user where id = #{uid}")
//    User findUserById(int uid);


    /*********************************用户的管理CRUD*******************************/
    /**
     * 查询所有用户信息，这里后面进行优化,添加了分页功能
     * @return
     */
    @Select("select * from user limit #{page},#{limit}")
    List<User> findAll(@Param("page") int selectedPage,@Param("limit") int selectedLimit);

    /**
     * 返回user表数据总数
     * @return
     */
    @Select("select count(*) as count from user")
    int countUser();

    /**
     * 删除用户信息(根据用户id)
     * @param id
     * @return
     */
    @Delete("delete from user where id=#{id}")
    int deleteUserInfo(int id);

    /**
     * 更新用户信息
     * @param user
     */
    @Update("update user set username=#{username},password=#{password},sex=#{sex},phone=#{phone}," +
            "queueStatus=#{queueStatus},cid=#{cid},resultid=#{resultid},roleid=#{roleid} where id=#{id}")
    int updateUserInfo(User user);

    /**
     * 添加用户信息
     * @param user
     * @return
     */
    @Insert("insert into user(username,password,sex,phone,nickname,email,cid,resultid,roleid) " +
            "values(#{username},#{password},#{sex},#{phone},#{nickname},#{email},#{cid},#{resultid},#{roleid})")
    int addUserInfo(User user);

    /**
     * 根据用户输入信息查询相应条件的用户
     * @param user
     * @param selectedPage
     * @param selectedLimit
     * @return
     */
    @Select({"<script>                                                         "
            +"select * from user                                               "
            +"<where>                                                          "
            +"<if test=\"user.cid != null and user.cid !=''\">                 "
            +"    and cid = #{user.cid}                                        "
            +"</if>                                                            "
            +"<if test=\"user.username != null and user.username !=''\">       "
            +"    and username like CONCAT('%', #{user.username}, '%')         "
            +"</if>                                                            "
            +"<if test=\"user.sex != null and user.sex !=''\">                 "
            +"    and sex=#{user.sex}                                          "
            +"</if>                                                            "
            +"</where>                                                         "
            +"limit #{selectedPage},#{selectedLimit}                           "
            +"</script>                                                        "})
    List<User> findUserByLike(@Param("user") User user,
                              @Param("selectedPage") int selectedPage,
                              @Param("selectedLimit") int selectedLimit);

    /**
     * 根据用户输入信息查询相应条件的用户数量
     * @param user
     * @return
     */
    @Select({"<script>                                                         "
            +"select count(*) from user                                        "
            +"<where>                                                          "
            +"<if test=\"cid != null and cid !=''\">                           "
            +"    and cid = #{cid}                                             "
            +"</if>                                                            "
            +"<if test=\"username != null and username !=''\">                 "
            +"    and username like CONCAT('%', #{username}, '%')              "
            +"</if>                                                            "
            +"<if test=\"sex != null and sex !=''\">                           "
            +"    and sex=#{sex}                                               "
            +"</if>                                                            "
            +"</where>                                                         "
            +"</script>                                                        "})
    int countUserByLike(User user);
}
