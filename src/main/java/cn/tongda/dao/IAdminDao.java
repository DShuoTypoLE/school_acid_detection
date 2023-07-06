package cn.tongda.dao;

import cn.tongda.domain.Admin;
import cn.tongda.domain.Channel;
import cn.tongda.domain.pojo.AdminInfo;
import cn.tongda.domain.pojo.UserQueueNumber;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 管理员持久层
 * @author 丁硕
 * @version 1.0
 */
@Repository
public interface IAdminDao {
    /**
     * 根据姓名和密码查询管理员,此时用于登陆验证
     * @param username
     * @param password
     * @return
     */
    @Select("select * from admin where username=#{username} and password=#{password}")
    Admin findAdmin(@Param("username") String username,@Param("password") String password);

    /**
     * 根据用户名和密码查询管理员信息
     * @param username
     * @param password
     * @return
     */
    @Select("SELECT username,nickname,sex,phone,email " +
            "FROM admin a,adminInfo ai " +
            "WHERE a.id=ai.id  " +
            "AND username=#{username} AND password=#{password}")
    AdminInfo findAdminInfo(@Param("username") String username, @Param("password") String password);

    /**
     * 修改管理员密码
     * @param admin
     */
    @Update("update admin set password=#{password} where id=#{id}")
    void updateAdminPassword(Admin admin);

    /**
     * 查询检测通道列表并查出排队人数
     * @return
     */
    @Select("SELECT channel.id,address,COUNT(1) AS count FROM `user`,channel " +
            "WHERE user.cid=channel.id " +
            "AND queueStatus='Y' GROUP BY channel.id,address")
    List<UserQueueNumber> findChannel();

    /**
     * 查询检测通道数量
     * @return
     */
    @Select("select count(*) as count from channel")
    int countChannel();

    /******************************管理员CRUD**************************/
    /**
     * 查询所有管理员信息，这里后面进行优化,添加了分页功能
     * @return
     */
    @Select("select * from admin limit #{page},#{limit}")
    List<Admin> findAll(@Param("page") int selectedPage, @Param("limit") int selectedLimit);

    /**
     * 返回admin表数据总数
     * @return
     */
    @Select("select count(*) as count from admin")
    int countAdmin();

    /**
     * 删除管理员信息(根据管理员id)
     * @param id
     * @return
     */
    @Delete("delete from admin where id=#{id}")
    int deleteAdminInfo(Integer id);

    /**
     * 修改管理员信息
     * @param admin
     * @return
     */
    @Update("update admin set username=#{username},password=#{password},roleid=#{roleid} where id=#{id}")
    int updateAdminInfo(Admin admin);

    /**
     * 添加管理员信息
     * @param admin
     * @return
     */
    @Insert("insert into admin(username,password,roleid) values(#{username},#{password},#{roleid})")
    int addAdminInfo(Admin admin);
}
