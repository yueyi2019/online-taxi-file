/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80017
Source Host           : localhost:3306
Source Database       : online-taxi

Target Server Type    : MYSQL
Target Server Version : 80017
File Encoding         : 65001

Date: 2020-02-29 18:49:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sms_template`;
CREATE TABLE `tbl_sms_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` varchar(16) NOT NULL DEFAULT '' COMMENT '短信模板ID',
  `template_name` varchar(128) DEFAULT NULL,
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '模板内容',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `template_type` tinyint(1) NOT NULL DEFAULT '3' COMMENT '模板类型（1：营销；2：通知；3：订单）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `TEMPLATE_ID` (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_sms_template
-- ----------------------------
INSERT INTO `tbl_sms_template` VALUES ('5', 'SMS_144145499', '登录验证码', '手机验证码：${code}，10分钟内有效。如非本人操作，请忽略。', '2018-09-07 15:00:11', '2018-09-12 13:24:14', '3');
