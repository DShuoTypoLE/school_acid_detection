/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.19 : Database - my_acid_detection_plus
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`my_acid_detection_plus` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `my_acid_detection_plus`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`id`,`username`,`password`,`roleid`) values 
(1,'root','63a9f0ea7bb98050796b649e85481845',1),
(3,'李伟彬','9c82ae4c73da2daeb11845fe7f9c1ab8',1);

/*Table structure for table `admininfo` */

DROP TABLE IF EXISTS `admininfo`;

CREATE TABLE `admininfo` (
  `id` int(11) DEFAULT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admininfo` */

insert  into `admininfo`(`id`,`nickname`,`sex`,`phone`,`email`) values 
(1,'楽','男','19929393941','2870728720@qq.com');

/*Table structure for table `channel` */

DROP TABLE IF EXISTS `channel`;

CREATE TABLE `channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `channel` */

insert  into `channel`(`id`,`address`) values 
(1,'体育馆西门'),
(2,'一号教学楼');

/*Table structure for table `notify` */

DROP TABLE IF EXISTS `notify`;

CREATE TABLE `notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `releaseTime` varchar(100) DEFAULT NULL,
  `newsMsg` varchar(10) DEFAULT NULL,
  `isMatter` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notify` */

/*Table structure for table `recordinfo` */

DROP TABLE IF EXISTS `recordinfo`;

CREATE TABLE `recordinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deteTime` varchar(100) NOT NULL,
  `resTime` varchar(100) NOT NULL,
  `resMsg` varchar(100) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `recordinfo_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `recordinfo` */

insert  into `recordinfo`(`id`,`deteTime`,`resTime`,`resMsg`,`uid`) values 
(1,'2023-04-06 11:45:23','2023-04-06 20:37:23','阴性',1),
(2,'2023-04-05 11:26:34','2023-04-05 20:42:17','阴性',1),
(3,'2023-04-04 11:14:20','2023-04-04 20:21:14','阴性',1),
(4,'2023-04-03 11:11:33','2023-04-03 20:37:41','阴性',1),
(5,'2023-04-02 11:23:35','2023-04-02 20:56:23','阴性',1),
(6,'2023-04-01 11:07:23','2023-04-01 20:41:02','阴性',1),
(7,'2023-03-28 11:09:11','2023-03-28 20:11:23','阴性',1),
(8,'2023-03-26 11:43:10','2023-03-26 20:55:03','阴性',1),
(9,'2023-03-24 11:14:05','2023-03-24 20:22:34','阴性',1),
(10,'2023-03-22 11:42:23','2023-03-22 20:37:11','阴性',1);

/*Table structure for table `result` */

DROP TABLE IF EXISTS `result`;

CREATE TABLE `result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resMsg` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `result` */

insert  into `result`(`id`,`resMsg`) values 
(1,'阳性'),
(2,'阴性');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(100) NOT NULL,
  `roleMsg` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`roleName`,`roleMsg`) values 
(1,'超级管理员','管理后台信息以及平台维护'),
(2,'用户','使用系统查询信息');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `sex` varchar(10) NOT NULL,
  `phone` varchar(20) DEFAULT '',
  `queueStatus` varchar(10) DEFAULT 'N',
  `nickname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cid` int(11) NOT NULL,
  `resultid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `resultid` (`resultid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `channel` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`resultid`) REFERENCES `result` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`sex`,`phone`,`queueStatus`,`nickname`,`email`,`cid`,`resultid`,`roleid`) values 
(1,'丁硕','698d51a19d8a121ce581499d7b701668','男','19850516006','N','通达地板','666@qq.com',1,2,2),
(2,'朱盛奥','bcbe3365e6ac95ea2c0343a2395834dd','男','19850524258','N',NULL,NULL,1,2,2),
(3,'李伟彬','310dcbbf4cce62f762a2aaa148d556bd','女','19850511111','N',NULL,NULL,1,2,2),
(4,'张三','550a141f12de6341fba65b0ad0433500','女','19850522222','N',NULL,NULL,2,1,2),
(5,'李四','15de21c670ae7c3f6f3f1f37029303c9','女','19850533333','N',NULL,NULL,2,1,2),
(6,'王五','fae0b27c451c728867a567e8c1bb4e53','男','19850544444','N',NULL,NULL,2,1,2),
(7,'小强','f1c1592588411002af340cbaedd6fc33','男','19850555555','N',NULL,NULL,1,2,2),
(8,'张无忌','0a113ef6b61820daa5611c870ed8d5ee','女','19850526666','N',NULL,NULL,2,2,2),
(9,'唐三','b706835de79a2b4e80506f582af3676a','男','19850599999','N',NULL,NULL,1,2,2),
(10,'小舞','c6f057b86584942e415435ffb1fa93d4','女','00000000000','N',NULL,NULL,2,1,2),
(11,'石昊','b59c67bf196a4758191e42f76670ceba','男','19850516006','Y',NULL,NULL,1,2,2),
(12,'石毅','934b535800b1cba8f96a5d72f72f1611','男','19850524258','Y',NULL,NULL,1,2,2),
(13,'柳神','2be9bd7a3434f7038ca27d1918de58bd','女','19850511111','N',NULL,NULL,1,2,2),
(14,'云曦','dbc4d84bfcfe2284ba11beffb853a8c4','女','19850522222','Y',NULL,NULL,2,1,2),
(15,'月禅','6074c6aa3488f3c2dddff2a7ca821aab','女','19850533333','N',NULL,NULL,2,1,2),
(16,'安澜','e9510081ac30ffa83f10b68cde1cac07','男','19850544444','Y',NULL,NULL,2,1,2),
(17,'无始大帝','d79c8788088c2193f0244d8f1f36d2db','男','19850555555','N',NULL,NULL,1,2,2),
(18,'狠人大帝','cf79ae6addba60ad018347359bd144d2','女','19850526666','Y',NULL,NULL,2,2,2),
(19,'尸骸仙帝','fa246d0262c3925617b0c72bb20eeb1d','男','19850599999','N',NULL,NULL,1,2,2),
(20,'火灵儿','4a7d1ed414474e4033ac29ccb8653d9b','女','00000000000','Y',NULL,NULL,2,1,2),
(21,'小塔','b0baee9d279d34fa1dfd71aadb908c3f','男','19850516006','Y',NULL,NULL,1,2,2),
(22,'朱厌','00c78d079caeb306fe52e5b3e1643db7','男','19850524258','Y',NULL,NULL,1,2,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
