/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80017
Source Host           : localhost:3306
Source Database       : online-taxi

Target Server Type    : MYSQL
Target Server Version : 80017
File Encoding         : 65001

Date: 2020-02-12 21:51:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_app_version_update
-- ----------------------------
DROP TABLE IF EXISTS `tbl_app_version_update`;
CREATE TABLE `tbl_app_version_update` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `platform_type` int(2) NOT NULL DEFAULT '0' COMMENT '上线系统 平台 1: ios, 2: android',
  `notice_type` int(2) NOT NULL DEFAULT '0' COMMENT '通知类型（1:强制 2:非强制）',
  `prompt` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '升级提示（不超过30个字）',
  `note` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `start_time` datetime NOT NULL COMMENT '生效开始时间	',
  `end_time` datetime NOT NULL COMMENT '生效结束时间',
  `download_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '安装包url',
  `operator_id` int(11) NOT NULL COMMENT '创建人',
  `app_type` int(2) NOT NULL COMMENT '1:乘客端，2：司机端  3:车机端',
  `app_version` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'app版本号',
  `use_status` int(2) NOT NULL DEFAULT '1' COMMENT '启用停用状态，0：停用，1：启用',
  `version_code` int(11) NOT NULL DEFAULT '0' COMMENT '版本号code',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='乘客端,司机端，车机端app更新';

-- ----------------------------
-- Table structure for tbl_passenger_address
-- ----------------------------
DROP TABLE IF EXISTS `tbl_passenger_address`;
CREATE TABLE `tbl_passenger_address` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `passenger_info_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '乘客id',
  `latitude` double(10,6) DEFAULT NULL COMMENT '地址纬度',
  `longitude` double(10,6) DEFAULT NULL COMMENT '地址经度',
  `address_name` varchar(64) DEFAULT '' COMMENT '详细地址',
  `type` int(2) DEFAULT NULL COMMENT '0:家，1：公司',
  `address_desc` varchar(2048) DEFAULT '' COMMENT '地址描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for tbl_passenger_info
-- ----------------------------
DROP TABLE IF EXISTS `tbl_passenger_info`;
CREATE TABLE `tbl_passenger_info` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电话',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `passenger_name` varchar(16) NOT NULL DEFAULT '' COMMENT '乘客名称',
  `gender` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '0：女，1：男',
  `head_img` varchar(256) NOT NULL DEFAULT '' COMMENT '头像',
  `passenger_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型，1：个人用户，2：企业用户',
  `register_type` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '注册渠道 1 安卓 2 ios',
  `last_login_method` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '上次登陆方式:1,验证码,2密码',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for tbl_passenger_wallet
-- ----------------------------
DROP TABLE IF EXISTS `tbl_passenger_wallet`;
CREATE TABLE `tbl_passenger_wallet` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `passenger_info_id` int(16) DEFAULT NULL COMMENT '乘客Id',
  `capital` double(10,2) DEFAULT NULL COMMENT '本金',
  `give_fee` double(10,2) DEFAULT NULL COMMENT '赠费',
  `freeze_capital` double(10,2) DEFAULT NULL COMMENT '冻结本金',
  `freeze_give_fee` double(10,2) DEFAULT NULL COMMENT '冻结赠费',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_userid` (`passenger_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8 COMMENT='乘客钱包';

-- ----------------------------
-- Table structure for tbl_passenger_wallet_record
-- ----------------------------
DROP TABLE IF EXISTS `tbl_passenger_wallet_record`;
CREATE TABLE `tbl_passenger_wallet_record` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `passenger_info_id` int(16) NOT NULL COMMENT '用户ID',
  `transaction_id` varchar(32) DEFAULT '' COMMENT '第三方支付ID',
  `pay_time` datetime NOT NULL COMMENT '支付时间',
  `pay_capital` double(10,2) NOT NULL COMMENT '本金',
  `pay_give_fee` double(10,2) NOT NULL COMMENT '赠费',
  `refund_capital` double(10,2) DEFAULT '0.00' COMMENT '退款本金',
  `refund_give_fee` double(10,2) DEFAULT '0.00' COMMENT '退款赠费',
  `recharge_discount` double(10,2) NOT NULL COMMENT '充值折扣',
  `pay_type` tinyint(2) NOT NULL COMMENT '1：微信 ，2：账户余额，3：平台账户，4：支付宝',
  `pay_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1：已支付 ，0：未支付',
  `trade_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '交易类型：\r\n1充值\r\n2消费\r\n3退款\r\n4订单冻结\r\n5订单补扣\r\n6尾款支付\r\n7解冻',
  `trade_reason` varchar(100) NOT NULL DEFAULT '' COMMENT '交易原因',
  `description` varchar(200) NOT NULL COMMENT '描述',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建用户',
  `order_id` int(10) DEFAULT NULL COMMENT '订单Id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_userid` (`passenger_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3001 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='交易记录';

-- ----------------------------
-- Table structure for tbl_sms
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sms`;
CREATE TABLE `tbl_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '乘客手机号',
  `sms_content` varchar(512) NOT NULL DEFAULT '' COMMENT '短信内容',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `operator` varchar(255) NOT NULL DEFAULT '' COMMENT '操作人',
  `send_flag` tinyint(1) NOT NULL COMMENT '发送状态 0:失败  1: 成功',
  `send_number` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发送失败次数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1973 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
