/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 100422
 Source Host           : localhost:3306
 Source Schema         : clmis

 Target Server Type    : MySQL
 Target Server Version : 100422
 File Encoding         : 65001

 Date: 30/05/2024 09:32:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alerts
-- ----------------------------
DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `person_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `designation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cell_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stkid` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `prov_id` int NULL DEFAULT NULL,
  `dist_id` int NULL DEFAULT NULL,
  `level` enum('National','Provincial','District','All') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `office_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_log
-- ----------------------------
DROP TABLE IF EXISTS `alerts_log`;
CREATE TABLE `alerts_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stakeholder_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `to` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cc` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `subject` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `body` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `response` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `interface` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warehouse_id` int NULL DEFAULT NULL,
  `sent_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_log_detail
-- ----------------------------
DROP TABLE IF EXISTS `alerts_log_detail`;
CREATE TABLE `alerts_log_detail`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `alert_log_master_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_cell` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_type` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_log_master
-- ----------------------------
DROP TABLE IF EXISTS `alerts_log_master`;
CREATE TABLE `alerts_log_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stakeholder_id` int NULL DEFAULT NULL,
  `stakeholder_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `province_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  `district_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warehouse_id` int NULL DEFAULT NULL,
  `warehouse_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `body` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `response` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alert_type` int NULL DEFAULT NULL,
  `alert_category` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_mapping
-- ----------------------------
DROP TABLE IF EXISTS `alerts_mapping`;
CREATE TABLE `alerts_mapping`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stakeholder_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `hf_type_id` int NULL DEFAULT NULL,
  `warehouse_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `alert_type` int NULL DEFAULT NULL,
  `value` enum('X','N/A','Available','Available (at selected HFs)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE,
  UNIQUE INDEX `stakeholder_id`(`stakeholder_id`, `province_id`, `hf_type_id`, `warehouse_id`, `product_id`, `alert_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_mapping_history
-- ----------------------------
DROP TABLE IF EXISTS `alerts_mapping_history`;
CREATE TABLE `alerts_mapping_history`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `alert_mapping_id` int NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `hf_type_id` int NULL DEFAULT NULL,
  `warehouse_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `alert_type` int NULL DEFAULT NULL,
  `value` enum('X','N/A','Available','Available (at selected HFs)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_stk_items
-- ----------------------------
DROP TABLE IF EXISTS `alerts_stk_items`;
CREATE TABLE `alerts_stk_items`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stk_id` int NULL DEFAULT NULL,
  `itm_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for alerts_stockout_table
-- ----------------------------
DROP TABLE IF EXISTS `alerts_stockout_table`;
CREATE TABLE `alerts_stockout_table`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `prov_id` int NULL DEFAULT NULL COMMENT 'province of warehouse',
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stkid` int NULL DEFAULT NULL COMMENT 'stakeholder',
  `Stakeholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dist_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `District` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wh_id` int NOT NULL DEFAULT 0 COMMENT 'id',
  `wh_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `itm_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `AMC` double NULL DEFAULT NULL,
  `SOH` double NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for api_get_reporting_lhw_kp
-- ----------------------------
DROP TABLE IF EXISTS `api_get_reporting_lhw_kp`;
CREATE TABLE `api_get_reporting_lhw_kp`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `api_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `month` date NULL DEFAULT NULL,
  `distcode` int NULL DEFAULT NULL,
  `facode` int NULL DEFAULT NULL,
  `item_code` int NULL DEFAULT NULL,
  `item_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `opening` double NULL DEFAULT NULL,
  `received` double NULL DEFAULT NULL,
  `issue` double NULL DEFAULT NULL,
  `closing` double NULL DEFAULT NULL,
  `entry_date` date NULL DEFAULT NULL,
  `update_dt` date NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_processed` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for api_get_reporting_lhw_punjab
-- ----------------------------
DROP TABLE IF EXISTS `api_get_reporting_lhw_punjab`;
CREATE TABLE `api_get_reporting_lhw_punjab`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `api_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `month` date NULL DEFAULT NULL,
  `distcode` int NULL DEFAULT NULL,
  `facode` int NULL DEFAULT NULL,
  `item_code` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `opening` double NULL DEFAULT NULL,
  `received_from_ppiu_tcs` double NULL DEFAULT NULL,
  `received_from_lhs` double NULL DEFAULT NULL,
  `received` double NULL DEFAULT NULL,
  `issue` double NULL DEFAULT NULL,
  `closing` double NULL DEFAULT NULL,
  `stockout` double NULL DEFAULT NULL,
  `clients` double NULL DEFAULT NULL,
  `entry_date` date NULL DEFAULT NULL,
  `update_dt` date NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_processed` int NULL DEFAULT NULL,
  `type` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  UNIQUE INDEX `hash`(`hash`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for api_get_reporting_mnch
-- ----------------------------
DROP TABLE IF EXISTS `api_get_reporting_mnch`;
CREATE TABLE `api_get_reporting_mnch`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `api_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `dhis_code` int NULL DEFAULT NULL,
  `cmw_id` int NULL DEFAULT NULL,
  `yy_mm` date NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `ob` double NULL DEFAULT NULL,
  `rcv` double NULL DEFAULT NULL,
  `issue` double NULL DEFAULT NULL,
  `cb` double NULL DEFAULT NULL,
  `de_dt` date NULL DEFAULT NULL,
  `update_dt` date NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_processed` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for api_get_reporting_mnch_kp
-- ----------------------------
DROP TABLE IF EXISTS `api_get_reporting_mnch_kp`;
CREATE TABLE `api_get_reporting_mnch_kp`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `api_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `dhis_code` int NULL DEFAULT NULL,
  `cmw_id` int NULL DEFAULT NULL,
  `yy_mm` date NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `ob` double NULL DEFAULT NULL,
  `rcv` double NULL DEFAULT NULL,
  `issue` double NULL DEFAULT NULL,
  `cb` double NULL DEFAULT NULL,
  `de_dt` date NULL DEFAULT NULL,
  `update_dt` date NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_processed` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for api_requests_log
-- ----------------------------
DROP TABLE IF EXISTS `api_requests_log`;
CREATE TABLE `api_requests_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `api_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `data` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `response` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `apk_version` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_key_1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'ECR: To save client id',
  `responded_at` datetime NULL DEFAULT NULL,
  `query_run` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `ref_key_2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'ECR: To save visit id',
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `api_name_index`(`api_name`) USING BTREE,
  INDEX `api_user`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clr_details
-- ----------------------------
DROP TABLE IF EXISTS `clr_details`;
CREATE TABLE `clr_details`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `pk_master_id` int NOT NULL,
  `itm_id` int UNSIGNED NULL DEFAULT NULL,
  `avg_consumption` double NULL DEFAULT NULL,
  `soh_dist` double NULL DEFAULT NULL,
  `soh_field` double NULL DEFAULT NULL,
  `total_stock` double NULL DEFAULT NULL,
  `desired_stock` double NULL DEFAULT NULL,
  `replenishment` double NULL DEFAULT NULL,
  `available_qty` int NULL DEFAULT NULL,
  `approve_qty` int NULL DEFAULT NULL,
  `approval_status` enum('Pending','Denied','Issued','Prov_Approved','Prov_Saved','Dist_Approved','RS_Approved','RS_Saved','Approved') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'Pending',
  `approve_date` datetime NULL DEFAULT NULL,
  `approved_by` int NULL DEFAULT NULL,
  `stock_master_id` int NULL DEFAULT NULL,
  `qty_req_dist_lvl1` double(11, 0) NULL DEFAULT NULL,
  `qty_req_dist_lvl2` double(11, 0) NULL DEFAULT NULL,
  `qty_req_prov` double(11, 0) NULL DEFAULT NULL,
  `qty_req_central` double(11, 0) NULL DEFAULT NULL,
  `remarks_dist_lvl1` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `remarks_dist_lvl2` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `remarks_prov` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `remarks_central` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `received_by_consignee` double(11, 0) NULL DEFAULT NULL,
  `var_req_n_disp` double(11, 0) NULL DEFAULT NULL,
  `var_disp_n_rec` double(11, 0) NULL DEFAULT NULL,
  `remarks_clr7` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `sale_of_last_3_months` double(11, 0) NULL DEFAULT NULL,
  `sale_of_last_month` double(11, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_master_id`(`pk_master_id`) USING BTREE,
  INDEX `itm_id`(`itm_id`) USING BTREE,
  CONSTRAINT `clr_details_ibfk_1` FOREIGN KEY (`pk_master_id`) REFERENCES `clr_master` (`pk_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 80261 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clr_details_approval
-- ----------------------------
DROP TABLE IF EXISTS `clr_details_approval`;
CREATE TABLE `clr_details_approval`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `clr_details_id` int NULL DEFAULT NULL,
  `manufacturer` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `carton_size` int NULL DEFAULT NULL,
  `qty_approved` int NULL DEFAULT NULL,
  `is_issued` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clr_distribution_plans
-- ----------------------------
DROP TABLE IF EXISTS `clr_distribution_plans`;
CREATE TABLE `clr_distribution_plans`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `plan_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `prov_id` int NULL DEFAULT NULL,
  `plan_status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `month` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `year` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `submitted_to` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 586 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clr_distribution_plans_stk
-- ----------------------------
DROP TABLE IF EXISTS `clr_distribution_plans_stk`;
CREATE TABLE `clr_distribution_plans_stk`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int NULL DEFAULT NULL,
  `stk_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 692 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clr_master
-- ----------------------------
DROP TABLE IF EXISTS `clr_master`;
CREATE TABLE `clr_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `requisition_num` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `requisition_to` int NOT NULL,
  `wh_id` int NOT NULL,
  `stk_id` int NOT NULL,
  `fk_stock_id` int NULL DEFAULT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `requested_by` int NOT NULL,
  `requested_on` datetime NOT NULL,
  `approval_status` enum('Pending','Denied','Issued','Issue in Process','RS_Approved','RS_Saved','Prov_Approved','Prov_Saved','Dist_Approved','Approved','Hard_Copy','Hard_Copy_Issued') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'Pending',
  `distribution_plan_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `attachment_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `receiving_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `requisition_num`(`requisition_num`) USING BTREE,
  INDEX `requisition_to`(`requisition_to`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE,
  INDEX `stk_id`(`stk_id`) USING BTREE,
  INDEX `date_from`(`date_from`) USING BTREE,
  INDEX `date_to`(`date_to`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8804 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clr_master_log
-- ----------------------------
DROP TABLE IF EXISTS `clr_master_log`;
CREATE TABLE `clr_master_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `master_id` int NULL DEFAULT NULL,
  `requisition_to` int NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `requested_by` int NULL DEFAULT NULL,
  `log_timestamp` datetime NULL DEFAULT NULL,
  `approval_status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `approval_level` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for company_products
-- ----------------------------
DROP TABLE IF EXISTS `company_products`;
CREATE TABLE `company_products`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `item_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `stkid`(`user_id`) USING BTREE,
  INDEX `stk_item`(`item_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11503 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contains detail information of stakeholder and itm_info_tab' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cron_log_time
-- ----------------------------
DROP TABLE IF EXISTS `cron_log_time`;
CREATE TABLE `cron_log_time`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `last_run` datetime NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ctbl_bi_hf
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_bi_hf`;
CREATE TABLE `ctbl_bi_hf`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `District` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Stakeholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `HealthFacilityName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `HFId` int NOT NULL,
  `ReportingDate` date NOT NULL,
  `Product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `opening_balance` double NULL DEFAULT NULL,
  `received_balance` double NULL DEFAULT NULL,
  `issue_balance` double NULL DEFAULT NULL,
  `closing_balance` double NULL DEFAULT NULL,
  `adjustment_positive` double NULL DEFAULT NULL,
  `adjustment_negative` double NULL DEFAULT NULL,
  `avg_consumption` double NULL DEFAULT NULL,
  `CYPFactor` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_cyp
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_cyp`;
CREATE TABLE `ctbl_cyp`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Stakeholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Yeary` int NULL DEFAULT NULL,
  `CYP` double(19, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_dataentryusers
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_dataentryusers`;
CREATE TABLE `ctbl_dataentryusers`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL DEFAULT 0,
  `login_id` int NOT NULL DEFAULT 0,
  `role` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stkid` int NULL DEFAULT NULL COMMENT 'stakeholder',
  `prov_id` int NULL DEFAULT NULL COMMENT 'province of warehouse',
  `LocName` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stkname` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_ms_bi
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_ms_bi`;
CREATE TABLE `ctbl_ms_bi`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Staekholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `District` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Reporting_Year` int NULL DEFAULT NULL,
  `Reporting_Month` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fyscal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `consumption` double NULL DEFAULT NULL,
  `AMC` double NULL DEFAULT NULL,
  `SOH` double NULL DEFAULT NULL,
  `MOS` double NULL DEFAULT NULL,
  `Reporting_Rate` decimal(6, 2) NULL DEFAULT NULL,
  `Dist_Reporting_Rate` decimal(6, 2) NULL DEFAULT NULL,
  `Field_Reporting_Rate` decimal(6, 2) NULL DEFAULT NULL,
  `Total_HF` int NULL DEFAULT NULL,
  `CYP` double NULL DEFAULT NULL,
  `StakeholderType` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_ms_bi_old
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_ms_bi_old`;
CREATE TABLE `ctbl_ms_bi_old`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Staekholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `District` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Reporting_Year` int NULL DEFAULT NULL,
  `Reporting_Month` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fyscal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `consumption` double NULL DEFAULT NULL,
  `AMC` double NULL DEFAULT NULL,
  `SOH` double NULL DEFAULT NULL,
  `MOS` double NULL DEFAULT NULL,
  `Reporting_Rate` decimal(6, 2) NULL DEFAULT NULL,
  `Total_HF` int NULL DEFAULT NULL,
  `CYP` double NULL DEFAULT NULL,
  `StakeholderType` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_pivot_bi
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_pivot_bi`;
CREATE TABLE `ctbl_pivot_bi`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Stakeholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `District` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Reporting_Year` int NULL DEFAULT NULL,
  `Reporting_Month` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fiscal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `consumption` double NULL DEFAULT NULL,
  `AMC` double NULL DEFAULT NULL,
  `SOH` double NULL DEFAULT NULL,
  `MOS` double NULL DEFAULT NULL,
  `Reporting_Rate` decimal(6, 2) NULL DEFAULT NULL,
  `Total_HF` int NULL DEFAULT NULL,
  `CYP` double NULL DEFAULT NULL,
  `StakeholderType` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 749944 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ctbl_reporting_points
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_reporting_points`;
CREATE TABLE `ctbl_reporting_points`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stkid` int NULL DEFAULT NULL COMMENT 'stakeholder',
  `provid` int NULL DEFAULT NULL COMMENT 'province of warehouse',
  `stkname` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `NoOfDistricts` bigint NOT NULL DEFAULT 0,
  `NoOfPoints` bigint NOT NULL DEFAULT 0,
  `LocName` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hf_type` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_reporting_rate
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_reporting_rate`;
CREATE TABLE `ctbl_reporting_rate`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `main_stakeholder` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  `total_districts` int NULL DEFAULT NULL,
  `reporting_districts` int NULL DEFAULT NULL,
  `total_SDPs` int NULL DEFAULT NULL,
  `reporting_SDPs` int NULL DEFAULT NULL,
  `district_stockout_instances` int NULL DEFAULT NULL,
  `sdps_stockout_instances` int NULL DEFAULT NULL,
  `province_id` int NOT NULL DEFAULT 0,
  `stakeholder_id` int NOT NULL DEFAULT 0 COMMENT 'stakeholder id',
  `reporting_rate_dist` decimal(11, 2) NULL DEFAULT NULL,
  `reporting_rate_sdps` decimal(11, 2) NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for ctbl_summary_bi
-- ----------------------------
DROP TABLE IF EXISTS `ctbl_summary_bi`;
CREATE TABLE `ctbl_summary_bi`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Stakeholder` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT 'quantity in one carton',
  `Product` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Month` date NULL DEFAULT NULL,
  `MOS` decimal(11, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dashboard_comments
-- ----------------------------
DROP TABLE IF EXISTS `dashboard_comments`;
CREATE TABLE `dashboard_comments`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `dashlet_id` int NULL DEFAULT NULL,
  `dashboard_id` int NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `location_id` int NULL DEFAULT NULL,
  `month_year` date NULL DEFAULT NULL,
  `comments` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for data_mismatches
-- ----------------------------
DROP TABLE IF EXISTS `data_mismatches`;
CREATE TABLE `data_mismatches`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `match_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `province` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `reporting_date` date NULL DEFAULT NULL,
  `hf_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `table_1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `table_2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bad_value_1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bad_value_2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ok_value_1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ok_value_2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `action_taken` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `dist`(`district`) USING BTREE,
  INDEX `item`(`item_id`) USING BTREE,
  INDEX `reportingdate`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 357 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for data_mismatches_log
-- ----------------------------
DROP TABLE IF EXISTS `data_mismatches_log`;
CREATE TABLE `data_mismatches_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `comparison_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `month` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `province` int NULL DEFAULT NULL,
  `district` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mismatches_count` int NULL DEFAULT NULL,
  `out_of_possibilites_checked` int NULL DEFAULT NULL,
  `checked_at_time` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for data_myisam
-- ----------------------------
DROP TABLE IF EXISTS `data_myisam`;
CREATE TABLE `data_myisam`  (
  `pk_id` int NOT NULL,
  `data` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dhis_dates_temp
-- ----------------------------
DROP TABLE IF EXISTS `dhis_dates_temp`;
CREATE TABLE `dhis_dates_temp`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `date` date NULL DEFAULT NULL,
  `is_processed` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dhis_temporary_data
-- ----------------------------
DROP TABLE IF EXISTS `dhis_temporary_data`;
CREATE TABLE `dhis_temporary_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `dhis_frmid` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dhis_distcode` int NULL DEFAULT NULL,
  `district_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dhis_facode` int NULL DEFAULT NULL,
  `fac_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fyear` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fmonth` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `addeddate` date NULL DEFAULT NULL,
  `N_58680` int NULL DEFAULT NULL,
  `N_86` int NULL DEFAULT NULL,
  `N_87` int NULL DEFAULT NULL,
  `N_88` int NULL DEFAULT NULL,
  `N_89` int NULL DEFAULT NULL,
  `N_90` int NULL DEFAULT NULL,
  `N_91` int NULL DEFAULT NULL,
  `N_92` int NULL DEFAULT NULL,
  `N_93` int NULL DEFAULT NULL,
  `N_94` int NULL DEFAULT NULL,
  `N_110` int NULL DEFAULT NULL,
  `is_processed` int NULL DEFAULT 0,
  `hf_data_id` int NULL DEFAULT NULL,
  `data_fetched_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for dtl_requests
-- ----------------------------
DROP TABLE IF EXISTS `dtl_requests`;
CREATE TABLE `dtl_requests`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `batch_id` int NULL DEFAULT NULL,
  `quantity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `saved_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dtl_requests_history
-- ----------------------------
DROP TABLE IF EXISTS `dtl_requests_history`;
CREATE TABLE `dtl_requests_history`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `batch_id` int NULL DEFAULT NULL,
  `quantity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `saved_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ecr_client_visits
-- ----------------------------
DROP TABLE IF EXISTS `ecr_client_visits`;
CREATE TABLE `ecr_client_visits`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NULL DEFAULT NULL,
  `remarks_of_date` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date_of_visit` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `wh_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `outcome_last_preg` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `period_from_last_preg` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_method` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_method_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_qty` int NULL DEFAULT NULL,
  `additional_item` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `additional_item_qty` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_from` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_from_desig` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_counseling` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_patient_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_diagnosis` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_treatment` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_referred_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_method` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_method_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_period` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_reason` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activity_under` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_updated` datetime NULL DEFAULT current_timestamp,
  `parity_alive` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `parity_death` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_for` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_reason_of_referral` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activity_uc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activity_num` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `visit_purpose` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type_of_visit` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_to_fac_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_to_fac` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `app_local_visit_id` int NULL DEFAULT NULL,
  `app_local_client_id` int NULL DEFAULT NULL,
  `from_api` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 989338 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ecr_client_visits_log
-- ----------------------------
DROP TABLE IF EXISTS `ecr_client_visits_log`;
CREATE TABLE `ecr_client_visits_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `visit_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `date_of_visit` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `remarks_of_date` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `outcome_last_preg` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `period_from_last_preg` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_method` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_method_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_qty` int NULL DEFAULT NULL,
  `additional_item` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `additional_item_qty` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_from` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_from_desig` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_counseling` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_patient_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_diagnosis` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_treatment` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gen_health_referred_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_method` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_method_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_period` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `larc_reason` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activity_under` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_updated` datetime NULL DEFAULT current_timestamp,
  `parity_alive` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `parity_death` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_referred_for` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fp_reason_of_referral` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activity_uc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activity_num` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `visit_purpose` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20598 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ecr_clients
-- ----------------------------
DROP TABLE IF EXISTS `ecr_clients`;
CREATE TABLE `ecr_clients`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `crc_new_old` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `client_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `father_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catchment_area` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nationality` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `foreigner_identity` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cnic` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `occupation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `education` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_today` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_when_married` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `parity_alive` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `registered_at` int NULL DEFAULT NULL,
  `parity_death` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `crc_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_on` datetime NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT current_timestamp,
  `app_local_client_id` int NULL DEFAULT NULL,
  `from_api` tinyint(1) NULL DEFAULT NULL,
  `status` smallint NULL DEFAULT 1,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 835743 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ecr_clients_duplicates
-- ----------------------------
DROP TABLE IF EXISTS `ecr_clients_duplicates`;
CREATE TABLE `ecr_clients_duplicates`  (
  `pk_id` int NOT NULL,
  `serial_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `crc_new_old` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `client_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `father_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catchment_area` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cnic` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `occupation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `education` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_today` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_when_married` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `parity_alive` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `registered_at` int NULL DEFAULT NULL,
  `parity_death` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `crc_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_on` datetime NULL DEFAULT current_timestamp,
  `merged_into_client` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ecr_clients_log
-- ----------------------------
DROP TABLE IF EXISTS `ecr_clients_log`;
CREATE TABLE `ecr_clients_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NULL DEFAULT NULL,
  `status` smallint NULL DEFAULT 1,
  `crc_new_old` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `client_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `father_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catchment_area` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nationality` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `foreigner_identity` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cnic` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `occupation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `education` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_today` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_when_married` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `crc_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_on` datetime NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `last_updated` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14493 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ecr_duplications_temp
-- ----------------------------
DROP TABLE IF EXISTS `ecr_duplications_temp`;
CREATE TABLE `ecr_duplications_temp`  (
  `client_id` int NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `date_of_visit` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `visit_purpose` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `app_local_visit_id` int NULL DEFAULT NULL,
  `app_local_client_id` int NULL DEFAULT NULL,
  `cc` bigint NOT NULL DEFAULT 0,
  `pks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `orig` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for email_actions
-- ----------------------------
DROP TABLE IF EXISTS `email_actions`;
CREATE TABLE `email_actions`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `action_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for email_bridge
-- ----------------------------
DROP TABLE IF EXISTS `email_bridge`;
CREATE TABLE `email_bridge`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `action_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for email_persons_list
-- ----------------------------
DROP TABLE IF EXISTS `email_persons_list`;
CREATE TABLE `email_persons_list`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `person_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `designation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cell_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stkid` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `prov_id` int NULL DEFAULT NULL,
  `office_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for email_verification
-- ----------------------------
DROP TABLE IF EXISTS `email_verification`;
CREATE TABLE `email_verification`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `is_verified` int NULL DEFAULT 0,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for facility_types
-- ----------------------------
DROP TABLE IF EXISTS `facility_types`;
CREATE TABLE `facility_types`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `facility_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for fc_referral
-- ----------------------------
DROP TABLE IF EXISTS `fc_referral`;
CREATE TABLE `fc_referral`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `family_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `visiting_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `treatment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hf_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `lhw_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referring_lhw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `further_details` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `incharge_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_date` datetime NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fixation_logs
-- ----------------------------
DROP TABLE IF EXISTS `fixation_logs`;
CREATE TABLE `fixation_logs`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `run` enum('auto','interface') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `issue_voucher_id` int NULL DEFAULT NULL,
  `receive_voucher_id` int NULL DEFAULT NULL,
  `stock_detail_id` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'i=insert, u=update',
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fp2020_status
-- ----------------------------
DROP TABLE IF EXISTS `fp2020_status`;
CREATE TABLE `fp2020_status`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `wh_id` int NULL DEFAULT NULL,
  `no_of_items` int NULL DEFAULT NULL,
  `type` enum('so','sa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `reporting_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fp_adp_consumption
-- ----------------------------
DROP TABLE IF EXISTS `fp_adp_consumption`;
CREATE TABLE `fp_adp_consumption`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stk_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `prov_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dist_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `report_month` date NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `wh_obl_a` int NULL DEFAULT NULL,
  `wh_issue_up` int NULL DEFAULT NULL,
  `wh_cbl_a` int NULL DEFAULT NULL,
  `new_clients` int NULL DEFAULT NULL,
  `followup_clients` int NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 485 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fp_adp_referral
-- ----------------------------
DROP TABLE IF EXISTS `fp_adp_referral`;
CREATE TABLE `fp_adp_referral`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stk_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `prov_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dist_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `report_month` date NULL DEFAULT NULL,
  `lhw` int NULL DEFAULT NULL,
  `fwa` int NULL DEFAULT NULL,
  `sm` int NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fp_referral
-- ----------------------------
DROP TABLE IF EXISTS `fp_referral`;
CREATE TABLE `fp_referral`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `family_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `visiting_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `treatment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hf_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `lhw_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referring_lhw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `further_details` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `incharge_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_date` datetime NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fq_age_groups
-- ----------------------------
DROP TABLE IF EXISTS `fq_age_groups`;
CREATE TABLE `fq_age_groups`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `age_group_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perc_out_of_tot_population` decimal(11, 4) NULL DEFAULT NULL,
  `rank` int NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `clinical_condition_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_calculation_indicators
-- ----------------------------
DROP TABLE IF EXISTS `fq_calculation_indicators`;
CREATE TABLE `fq_calculation_indicators`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `indicator_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `first_label` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `second_label` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `formula` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `indicator_value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `indicator_unit` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `age_group_id` int NULL DEFAULT NULL,
  `rank` int NULL DEFAULT NULL,
  `calculate_on` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `section` int NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_cc_products_bridge
-- ----------------------------
DROP TABLE IF EXISTS `fq_cc_products_bridge`;
CREATE TABLE `fq_cc_products_bridge`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `clinical_condition_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_clinical_conditions
-- ----------------------------
DROP TABLE IF EXISTS `fq_clinical_conditions`;
CREATE TABLE `fq_clinical_conditions`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `short_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `is_active` int NULL DEFAULT NULL,
  `rank` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_cols
-- ----------------------------
DROP TABLE IF EXISTS `fq_cols`;
CREATE TABLE `fq_cols`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `item_group` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `short_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `long_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `is_active` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `order_by` int NULL DEFAULT NULL,
  `col_type` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `default_percentage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `percentage_of` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_default_settings
-- ----------------------------
DROP TABLE IF EXISTS `fq_default_settings`;
CREATE TABLE `fq_default_settings`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `default_value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `unit` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_active` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_demographics_child
-- ----------------------------
DROP TABLE IF EXISTS `fq_demographics_child`;
CREATE TABLE `fq_demographics_child`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `master_id` int NULL DEFAULT NULL,
  `location_id` int NULL DEFAULT NULL,
  `col_id` int NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `fk`(`master_id`) USING BTREE,
  CONSTRAINT `fq_demographics_child_ibfk_1` FOREIGN KEY (`master_id`) REFERENCES `fq_demographics_master` (`pk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 531 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_demographics_master
-- ----------------------------
DROP TABLE IF EXISTS `fq_demographics_master`;
CREATE TABLE `fq_demographics_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `date_of_data_entry` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `year` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `level_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `item_group` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_forecasting_child
-- ----------------------------
DROP TABLE IF EXISTS `fq_forecasting_child`;
CREATE TABLE `fq_forecasting_child`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `master_id` int NULL DEFAULT NULL,
  `location_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `year` int NULL DEFAULT NULL,
  `dg_1` decimal(15, 4) NULL DEFAULT NULL,
  `dg_2` decimal(15, 4) NULL DEFAULT NULL,
  `dg_3` decimal(15, 4) NULL DEFAULT NULL,
  `cons_1` decimal(15, 4) NULL DEFAULT NULL,
  `cons_2` decimal(15, 4) NULL DEFAULT NULL,
  `cons_3` decimal(15, 4) NULL DEFAULT NULL,
  `fc_1` decimal(15, 4) NULL DEFAULT NULL,
  `fc_2` decimal(15, 4) NULL DEFAULT NULL,
  `fc_3` decimal(15, 4) NULL DEFAULT NULL,
  `fc_4` decimal(15, 4) NULL DEFAULT NULL,
  `final_fc` decimal(15, 4) NULL DEFAULT NULL,
  `adjustment` decimal(15, 4) NULL DEFAULT NULL,
  `proposed_fc` decimal(15, 4) NULL DEFAULT NULL,
  `remarks` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_forecasting_master
-- ----------------------------
DROP TABLE IF EXISTS `fq_forecasting_master`;
CREATE TABLE `fq_forecasting_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `year` int NULL DEFAULT NULL,
  `reference` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `level_id` int NULL DEFAULT NULL,
  `item_group` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_fp_assumptions
-- ----------------------------
DROP TABLE IF EXISTS `fq_fp_assumptions`;
CREATE TABLE `fq_fp_assumptions`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `text_value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `order_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_fp_products_data
-- ----------------------------
DROP TABLE IF EXISTS `fq_fp_products_data`;
CREATE TABLE `fq_fp_products_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `master_id` int NULL DEFAULT NULL,
  `prod_id` int NULL DEFAULT NULL,
  `base_year_1` int NULL DEFAULT NULL,
  `base_year_2` int NULL DEFAULT NULL,
  `base_year_3` int NULL DEFAULT NULL,
  `average_amc_of_base_years` int NULL DEFAULT NULL,
  `adjustment` decimal(15, 4) NULL DEFAULT NULL,
  `remarks` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `last_modified` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_fp_products_forecasting
-- ----------------------------
DROP TABLE IF EXISTS `fq_fp_products_forecasting`;
CREATE TABLE `fq_fp_products_forecasting`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `fp_product_key` int NULL DEFAULT NULL,
  `year` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `percent_increase` decimal(15, 4) NULL DEFAULT NULL,
  `forecasted_val` decimal(15, 4) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 783 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_item_settings
-- ----------------------------
DROP TABLE IF EXISTS `fq_item_settings`;
CREATE TABLE `fq_item_settings`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `age_group_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `form_of_prod` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Tablet/Capsule/Injection/Solution/Gel/Dry Mixture',
  `qty_per_episode` int NULL DEFAULT NULL COMMENT 'Number of tablets/injections per episode ie 10 Tablets/episode',
  `treatment_duration_days` int NULL DEFAULT NULL COMMENT 'Number of days for the durations',
  `size_of_prod` int NULL DEFAULT NULL COMMENT 'Number with reference to unit ie 10 of 10mg',
  `unit_of_prod` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Unit of the size ie mg of 10mg',
  `last_modified` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_master_data
-- ----------------------------
DROP TABLE IF EXISTS `fq_master_data`;
CREATE TABLE `fq_master_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `base_year` int NULL DEFAULT NULL,
  `start_year` int NULL DEFAULT NULL,
  `end_year` int NULL DEFAULT NULL,
  `purpose` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholders` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `forecasting_methods` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `item_group` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_morbidity_child
-- ----------------------------
DROP TABLE IF EXISTS `fq_morbidity_child`;
CREATE TABLE `fq_morbidity_child`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `master_id` int NULL DEFAULT NULL,
  `location_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 593 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_morbidity_master
-- ----------------------------
DROP TABLE IF EXISTS `fq_morbidity_master`;
CREATE TABLE `fq_morbidity_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `year` int NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date_of_data_entry` timestamp NULL DEFAULT NULL,
  `reference` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `level_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_group` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_non_lmis_consumption_child
-- ----------------------------
DROP TABLE IF EXISTS `fq_non_lmis_consumption_child`;
CREATE TABLE `fq_non_lmis_consumption_child`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `master_id` int NULL DEFAULT NULL,
  `location_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 849 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_non_lmis_consumption_master
-- ----------------------------
DROP TABLE IF EXISTS `fq_non_lmis_consumption_master`;
CREATE TABLE `fq_non_lmis_consumption_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `year` int NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date_of_data_entry` timestamp NULL DEFAULT NULL,
  `reference` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `level_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_group` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_quantification_child
-- ----------------------------
DROP TABLE IF EXISTS `fq_quantification_child`;
CREATE TABLE `fq_quantification_child`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `quantification_master_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `year` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `forecast` decimal(20, 4) NULL DEFAULT NULL,
  `soh` decimal(20, 4) NULL DEFAULT NULL,
  `pipeline` decimal(20, 4) NULL DEFAULT NULL,
  `quantification` decimal(20, 4) NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `orderFrequency` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `price` decimal(20, 4) NULL DEFAULT NULL,
  `amount` decimal(20, 4) NULL DEFAULT NULL,
  `remarks` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 222 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for fq_quantification_master
-- ----------------------------
DROP TABLE IF EXISTS `fq_quantification_master`;
CREATE TABLE `fq_quantification_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `date_of_entry` timestamp NULL DEFAULT NULL,
  `year` int NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level_id` int NULL DEFAULT NULL,
  `item_group` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `forecasting_master_id` int NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `reference` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for funding_stk_prov
-- ----------------------------
DROP TABLE IF EXISTS `funding_stk_prov`;
CREATE TABLE `funding_stk_prov`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stakeholder_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `funding_source_id` int NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT 1,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `modified_by` int NULL DEFAULT 1,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 83 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for gatepass_detail
-- ----------------------------
DROP TABLE IF EXISTS `gatepass_detail`;
CREATE TABLE `gatepass_detail`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `quantity` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_detail_id` int NULL DEFAULT NULL,
  `gatepass_master_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `gatepass_detail_gatepass_master_fk2`(`gatepass_master_id`) USING BTREE,
  CONSTRAINT `gatepass_detail_ibfk_1` FOREIGN KEY (`gatepass_master_id`) REFERENCES `gatepass_master` (`pk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for gatepass_master
-- ----------------------------
DROP TABLE IF EXISTS `gatepass_master`;
CREATE TABLE `gatepass_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `transaction_date` datetime NULL DEFAULT NULL,
  `gatepass_vehicle_id` int NOT NULL,
  `warehouse_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `gatepass_master_gatepass_vehicle_fk1`(`gatepass_vehicle_id`) USING BTREE,
  CONSTRAINT `gatepass_master_ibfk_1` FOREIGN KEY (`gatepass_vehicle_id`) REFERENCES `gatepass_vehicles` (`pk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for gatepass_vehicle_types
-- ----------------------------
DROP TABLE IF EXISTS `gatepass_vehicle_types`;
CREATE TABLE `gatepass_vehicle_types`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `vehicle_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for gatepass_vehicles
-- ----------------------------
DROP TABLE IF EXISTS `gatepass_vehicles`;
CREATE TABLE `gatepass_vehicles`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `vehicle_type_id` int NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `gatepass_vehicles_list_detail_fk1`(`vehicle_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for geo_color
-- ----------------------------
DROP TABLE IF EXISTS `geo_color`;
CREATE TABLE `geo_color`  (
  `id` int NOT NULL,
  `color_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for geo_indicator_values
-- ----------------------------
DROP TABLE IF EXISTS `geo_indicator_values`;
CREATE TABLE `geo_indicator_values`  (
  `id` int NOT NULL,
  `geo_indicator_id` int NULL DEFAULT NULL,
  `start_value` decimal(11, 2) NULL DEFAULT NULL,
  `end_value` decimal(11, 2) NULL DEFAULT NULL,
  `interval` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `geo_color_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for geo_indicators
-- ----------------------------
DROP TABLE IF EXISTS `geo_indicators`;
CREATE TABLE `geo_indicators`  (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for hr_list
-- ----------------------------
DROP TABLE IF EXISTS `hr_list`;
CREATE TABLE `hr_list`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `f_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `husband_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cnic` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `facility_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tehsil_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dist_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dist_id` int NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cell_no` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `uc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `centre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `total_lhw` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `deployment` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `working_under` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bps` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `place_of_posting` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `name_of_post` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'cmw/lhw/lhs/sba/lhv/facility_incharge',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1453 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for impact_calculator
-- ----------------------------
DROP TABLE IF EXISTS `impact_calculator`;
CREATE TABLE `impact_calculator`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` int NULL DEFAULT NULL,
  `year` int NOT NULL,
  `source` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `female` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_date` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for integrated_stakeholders
-- ----------------------------
DROP TABLE IF EXISTS `integrated_stakeholders`;
CREATE TABLE `integrated_stakeholders`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `province_id` int NULL DEFAULT NULL,
  `main_stk_id` int NULL DEFAULT NULL,
  `sub_stk_id` int NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT current_timestamp,
  `created_by` int NULL DEFAULT NULL,
  `modified_date` datetime NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 85 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for item_price
-- ----------------------------
DROP TABLE IF EXISTS `item_price`;
CREATE TABLE `item_price`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `stakeholder_id` int NOT NULL,
  `province_id` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `qty` int NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for item_price_copy1
-- ----------------------------
DROP TABLE IF EXISTS `item_price_copy1`;
CREATE TABLE `item_price_copy1`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `stakeholder_id` int NOT NULL,
  `province_id` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `qty` int NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for itemgroups
-- ----------------------------
DROP TABLE IF EXISTS `itemgroups`;
CREATE TABLE `itemgroups`  (
  `PKItemGroupID` int NOT NULL AUTO_INCREMENT,
  `ItemGroupName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PKItemGroupID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for itemsofgroups
-- ----------------------------
DROP TABLE IF EXISTS `itemsofgroups`;
CREATE TABLE `itemsofgroups`  (
  `pkItemsofGroupsID` int NOT NULL AUTO_INCREMENT,
  `ItemID` int NULL DEFAULT NULL,
  `GroupID` int NULL DEFAULT NULL,
  PRIMARY KEY (`pkItemsofGroupsID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for itminfo_tab
-- ----------------------------
DROP TABLE IF EXISTS `itminfo_tab`;
CREATE TABLE `itminfo_tab`  (
  `itmrec_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `itm_id` int NOT NULL AUTO_INCREMENT,
  `itm_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `generic_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `generic_updated` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `method_type` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `method_rank` int NULL DEFAULT NULL,
  `itm_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qty_carton` int NOT NULL DEFAULT 0 COMMENT 'quantity in one carton',
  `quantity_per_blister` bigint NULL DEFAULT NULL,
  `field_color` varchar(7) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `itm_des` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `itm_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `frmindex` int NOT NULL DEFAULT 0 COMMENT 'not implemented in v1',
  `user_factor` decimal(10, 5) NULL DEFAULT NULL,
  `extra` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `itm_category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `item_unit_id` int NULL DEFAULT NULL,
  `volume` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mnch_id` int NULL DEFAULT NULL,
  `lhw_kp_id` int NULL DEFAULT NULL,
  `lhw_punjab_id` int NULL DEFAULT NULL,
  `mnch_kp_id` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `dhis_stock_field` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `drug_reg_num` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `merf_product_id` int NULL DEFAULT NULL,
  `ihs_product_id` int NULL DEFAULT NULL,
  `pphi_product_id` int NULL DEFAULT NULL,
  `hands_product_id` int NULL DEFAULT NULL,
  `mcc_category_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `strength` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dosage_form` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `generic_unique` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  UNIQUE INDEX `itm_id`(`itm_id`) USING BTREE,
  UNIQUE INDEX `itmrec_id`(`itmrec_id`) USING BTREE,
  INDEX `frmindex`(`frmindex`) USING BTREE,
  INDEX `itm_type`(`itm_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13978 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'contain information about product attributes' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lhw_data
-- ----------------------------
DROP TABLE IF EXISTS `lhw_data`;
CREATE TABLE `lhw_data`  (
  `reporting_id` int NOT NULL AUTO_INCREMENT,
  `reportingDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_designation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lhwName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lhwContact` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `uc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `taluka` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gpsLoc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `highRiskChk` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `countHighRisk` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dangerSign` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `referedChk` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `detailsRef` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hospitalName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `followUp` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `samDetected` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `samIdentified` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `samDignosed` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `samReferred` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `countDetected` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `countIdentified` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `countDignosed` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `countReferred` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `samRefCenter` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `samFollowup` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `notVaccinated` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `droppedOut` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `updated_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `deleted_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `synced_status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  PRIMARY KEY (`reporting_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for list_detail
-- ----------------------------
DROP TABLE IF EXISTS `list_detail`;
CREATE TABLE `list_detail`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `list_value` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `rank` int NULL DEFAULT NULL,
  `reference_id` int NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `list_master_id` int NULL DEFAULT NULL,
  `created_by` int NOT NULL DEFAULT 0,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp,
  `modified_by` int NULL DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `list_detail_list_master_id_list_master_fk1`(`list_master_id`) USING BTREE,
  INDEX `list_detail_created_by_users_fk2`(`created_by`) USING BTREE,
  INDEX `list_detail_modified_by_users_fk3`(`modified_by`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 226 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for list_master
-- ----------------------------
DROP TABLE IF EXISTS `list_master`;
CREATE TABLE `list_master`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `list_master_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_by` int NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_by` int NOT NULL,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `category` enum('IM','CC','CS') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `list_master_created_by_users_fk1`(`created_by`) USING BTREE,
  INDEX `list_master_modified_by_users_fk2`(`modified_by`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for manufacturer_update_log
-- ----------------------------
DROP TABLE IF EXISTS `manufacturer_update_log`;
CREATE TABLE `manufacturer_update_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `batch_id` int NOT NULL,
  `manufacturer_old_id` int NULL DEFAULT NULL,
  `manufacturer_new_id` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for map_district_mapping
-- ----------------------------
DROP TABLE IF EXISTS `map_district_mapping`;
CREATE TABLE `map_district_mapping`  (
  `province_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  `mapping_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `default_district` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for map_district_mapping_copy1
-- ----------------------------
DROP TABLE IF EXISTS `map_district_mapping_copy1`;
CREATE TABLE `map_district_mapping_copy1`  (
  `province_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  `mapping_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `default_district` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for map_population
-- ----------------------------
DROP TABLE IF EXISTS `map_population`;
CREATE TABLE `map_population`  (
  `district_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `population` int NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`district_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for map_population_copy1
-- ----------------------------
DROP TABLE IF EXISTS `map_population_copy1`;
CREATE TABLE `map_population_copy1`  (
  `district_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `population` int NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`district_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mcc_list_categories
-- ----------------------------
DROP TABLE IF EXISTS `mcc_list_categories`;
CREATE TABLE `mcc_list_categories`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mcc_list_dosage
-- ----------------------------
DROP TABLE IF EXISTS `mcc_list_dosage`;
CREATE TABLE `mcc_list_dosage`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `dosage_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mcc_list_items
-- ----------------------------
DROP TABLE IF EXISTS `mcc_list_items`;
CREATE TABLE `mcc_list_items`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `f_no` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `drug_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `strength` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dosage_form` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `volume` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 434 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mcc_list_mapping
-- ----------------------------
DROP TABLE IF EXISTS `mcc_list_mapping`;
CREATE TABLE `mcc_list_mapping`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NULL DEFAULT NULL,
  `mcc_f_no` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `proc_type` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 865 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for member_data
-- ----------------------------
DROP TABLE IF EXISTS `member_data`;
CREATE TABLE `member_data`  (
  `reporting_id` int NOT NULL AUTO_INCREMENT,
  `reportingDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_designation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `membrName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `designationMembr` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `membrContact` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `uc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `taluka` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gpsLoc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `potableSrc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `enablers` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `updated_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `deleted_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `synced_status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  PRIMARY KEY (`reporting_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for midwife_data
-- ----------------------------
DROP TABLE IF EXISTS `midwife_data`;
CREATE TABLE `midwife_data`  (
  `reporting_id` int NOT NULL AUTO_INCREMENT,
  `reportingDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_designation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `midWifeName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `midWifeContact` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `uc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `taluka` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gpsLoc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `highRiskChk` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `referedChk` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `detailsRef` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hospitalName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `followUp` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `assistedCount` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `updated_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `deleted_at` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `synced_status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  PRIMARY KEY (`reporting_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mne_accuracy
-- ----------------------------
DROP TABLE IF EXISTS `mne_accuracy`;
CREATE TABLE `mne_accuracy`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `prod_id` int NULL DEFAULT NULL,
  `method` int NULL DEFAULT NULL,
  `item_group` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bal_lmis` int NULL DEFAULT NULL,
  `bal_recently_reported` int NULL DEFAULT NULL,
  `bal_current` int NULL DEFAULT NULL,
  `phycial_count` int NULL DEFAULT NULL,
  `stock_accurate` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_availability
-- ----------------------------
DROP TABLE IF EXISTS `mne_availability`;
CREATE TABLE `mne_availability`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `prod_id` int NULL DEFAULT NULL,
  `item_group` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `offered` int NULL DEFAULT NULL,
  `stock_tools` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tools_available` int NULL DEFAULT NULL,
  `s_o_h` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `open_balance` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `close_balance` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `receive` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `issue` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `a_m_c` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `min` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `max` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_avl_rating
-- ----------------------------
DROP TABLE IF EXISTS `mne_avl_rating`;
CREATE TABLE `mne_avl_rating`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `item_group` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_prod` int NULL DEFAULT NULL,
  `no_req_data` int NULL DEFAULT NULL,
  `tot_req_data` int NULL DEFAULT NULL,
  `tot_elements` int NULL DEFAULT NULL,
  `perc_elements` decimal(10, 0) NULL DEFAULT NULL,
  `rating` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_basic_child
-- ----------------------------
DROP TABLE IF EXISTS `mne_basic_child`;
CREATE TABLE `mne_basic_child`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `description` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `available` int NULL DEFAULT NULL,
  `accuracy` int NULL DEFAULT NULL,
  `timeliness` int NULL DEFAULT NULL,
  `total` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_basic_followup
-- ----------------------------
DROP TABLE IF EXISTS `mne_basic_followup`;
CREATE TABLE `mne_basic_followup`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `followup_value_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_group_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `actions` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `support` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `responsible` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `completion_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_basic_parent
-- ----------------------------
DROP TABLE IF EXISTS `mne_basic_parent`;
CREATE TABLE `mne_basic_parent`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `prov_id` int NULL DEFAULT NULL,
  `dist_id` int NULL DEFAULT NULL,
  `fac_id` int NULL DEFAULT NULL,
  `fac_level` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date_visit` date NULL DEFAULT NULL,
  `name` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sig` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_mgr` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_group` int NULL DEFAULT NULL,
  `as_per_lmis` int NULL DEFAULT NULL,
  `as_per_current_stock` int NULL DEFAULT NULL,
  `accuracy_to3_comments` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `accuracy_to4_comments` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `availability_to4_comments` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `availability_to3_comments` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `timeliness_comments` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `availability_site_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_followup_values
-- ----------------------------
DROP TABLE IF EXISTS `mne_followup_values`;
CREATE TABLE `mne_followup_values`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `values` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_monitoring_tools
-- ----------------------------
DROP TABLE IF EXISTS `mne_monitoring_tools`;
CREATE TABLE `mne_monitoring_tools`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `monitoring_tool` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_timeliness
-- ----------------------------
DROP TABLE IF EXISTS `mne_timeliness`;
CREATE TABLE `mne_timeliness`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `item_group` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `report` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date_due` date NULL DEFAULT NULL,
  `date_sub` date NULL DEFAULT NULL,
  `due_1w` int NULL DEFAULT NULL,
  `due_1to2w` int NULL DEFAULT NULL,
  `due_2wto1m` int NULL DEFAULT NULL,
  `due_1m_above` int NULL DEFAULT NULL,
  `unknown` int NULL DEFAULT NULL,
  `not_sub` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_timerating
-- ----------------------------
DROP TABLE IF EXISTS `mne_timerating`;
CREATE TABLE `mne_timerating`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `basic_id` int NULL DEFAULT NULL,
  `item_group` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `report_1w` int NULL DEFAULT NULL,
  `report_1to2w` int NULL DEFAULT NULL,
  `report2to4w` int NULL DEFAULT NULL,
  `report4w_above` int NULL DEFAULT NULL,
  `rating` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mne_to4
-- ----------------------------
DROP TABLE IF EXISTS `mne_to4`;
CREATE TABLE `mne_to4`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `product_to4` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for moderation
-- ----------------------------
DROP TABLE IF EXISTS `moderation`;
CREATE TABLE `moderation`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `to` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cc` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `subject` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `body` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `interface` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warehouse_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sent_by` int NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sent_to` int NULL DEFAULT NULL,
  `remarks` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for month_year
-- ----------------------------
DROP TABLE IF EXISTS `month_year`;
CREATE TABLE `month_year`  (
  `month` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `year` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for mosscale_tab
-- ----------------------------
DROP TABLE IF EXISTS `mosscale_tab`;
CREATE TABLE `mosscale_tab`  (
  `row_id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `itmrec_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `shortterm` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `longterm` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sclstart` float NOT NULL DEFAULT 0 COMMENT 'Scale start at',
  `sclsend` float NOT NULL DEFAULT 0 COMMENT 'scale ends at',
  `extra` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `colorcode` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stkid` int NULL DEFAULT NULL COMMENT 'Foreign Key: Stakeholder',
  `lvl_id` int NULL DEFAULT NULL COMMENT 'Foreign Key: distribution level',
  PRIMARY KEY (`row_id`) USING BTREE,
  INDEX `itmrec_id`(`itmrec_id`) USING BTREE,
  INDEX `shortterm`(`shortterm`) USING BTREE,
  INDEX `fk_Stk`(`stkid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17299 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contain inforamtion about min/max values of product code etc' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for national_stock
-- ----------------------------
DROP TABLE IF EXISTS `national_stock`;
CREATE TABLE `national_stock`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stk_id` int NULL DEFAULT NULL,
  `prov_id` int NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `tr_date` date NULL DEFAULT NULL,
  `quantity` decimal(11, 0) NULL DEFAULT NULL,
  `ref` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `comments` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stk_id2` int NULL DEFAULT NULL,
  `prov_id2` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16371 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for national_stock_control
-- ----------------------------
DROP TABLE IF EXISTS `national_stock_control`;
CREATE TABLE `national_stock_control`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stkid` int NULL DEFAULT NULL,
  `provid` int NULL DEFAULT NULL,
  `checked` int NULL DEFAULT NULL,
  `last_modified_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `date_from` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 541 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for placement_config
-- ----------------------------
DROP TABLE IF EXISTS `placement_config`;
CREATE TABLE `placement_config`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warehouse_id` int NOT NULL,
  `rack_information_id` int NOT NULL,
  `area` int NOT NULL,
  `row` int NOT NULL,
  `rack` int NOT NULL,
  `pallet` int NOT NULL,
  `level` int NOT NULL,
  `status` tinyint NULL DEFAULT 1,
  `volume_used` decimal(10, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `non_ccm_locations_warehouses_fk1`(`warehouse_id`) USING BTREE,
  INDEX `non_ccm_locations_rack_information_fk2`(`rack_information_id`) USING BTREE,
  INDEX `non_ccm_locations_list_detail_fk3`(`area`) USING BTREE,
  INDEX `non_ccm_locations_list_detail_fk4`(`row`) USING BTREE,
  INDEX `non_ccm_locations_list_detail_fk5`(`rack`) USING BTREE,
  INDEX `non_ccm_locations_list_detail_fk6`(`pallet`) USING BTREE,
  INDEX `non_ccm_locations_list_detail_fk7`(`level`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4444 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for placements
-- ----------------------------
DROP TABLE IF EXISTS `placements`;
CREATE TABLE `placements`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `quantity` bigint NULL DEFAULT 0,
  `placement_location_id` int NULL DEFAULT NULL COMMENT 'it can be cold chain and non cold chain id',
  `stock_batch_id` int NULL DEFAULT NULL,
  `stock_detail_id` int NULL DEFAULT NULL,
  `placement_transaction_type_id` int NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT NULL,
  `is_placed` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `placement_location_id`(`placement_location_id`) USING BTREE,
  INDEX `stock_batch_id`(`stock_batch_id`) USING BTREE,
  INDEX `stock_detail_id`(`stock_detail_id`) USING BTREE,
  INDEX `placement_transaction_type_id`(`placement_transaction_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67243 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for provincial_cyp_factors
-- ----------------------------
DROP TABLE IF EXISTS `provincial_cyp_factors`;
CREATE TABLE `provincial_cyp_factors`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `province_id` int NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `cyp_factor` decimal(11, 9) NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT 1,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `modified_by` int NULL DEFAULT 1,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 722 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for provincial_stock
-- ----------------------------
DROP TABLE IF EXISTS `provincial_stock`;
CREATE TABLE `provincial_stock`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `trans_date` datetime NULL DEFAULT NULL,
  `trans_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trans_type_id` int NULL DEFAULT NULL,
  `transaction_ref` int NULL DEFAULT NULL,
  `funding_source_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `stk_id` int NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `remarks` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_by` int NULL DEFAULT 1,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `PkStockID`(`pk_id`) USING BTREE,
  INDEX `WHIDFrom`(`funding_source_id`) USING BTREE,
  INDEX `WHIDTo`(`province_id`) USING BTREE,
  INDEX `TranNo`(`trans_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for rack_information
-- ----------------------------
DROP TABLE IF EXISTS `rack_information`;
CREATE TABLE `rack_information`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `rack_type` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_of_bins` smallint NULL DEFAULT NULL,
  `bin_net_capacity` float NULL DEFAULT NULL,
  `gross_capacity` float NULL DEFAULT NULL,
  `capacity_unit` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_date` datetime NULL DEFAULT NULL,
  `modified_by` int NOT NULL,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for referral_form
-- ----------------------------
DROP TABLE IF EXISTS `referral_form`;
CREATE TABLE `referral_form`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `patient_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `yearly_opd_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referred_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_history` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_date` datetime NULL DEFAULT current_timestamp,
  `referral_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `feedback_diagnosis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `feedback_treatment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `feedback_followup` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `feedback_date` datetime NULL DEFAULT current_timestamp,
  `feedback_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `feedback_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reports
-- ----------------------------
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports`  (
  `report_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `report_group` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_type` decimal(1, 0) NULL DEFAULT NULL COMMENT 'graph or report',
  `report_title` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_xaxis` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_yaxis` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_units` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_factor` decimal(8, 0) NULL DEFAULT NULL COMMENT 'factor to scale down y-axix',
  `report_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `staticpage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `footer_staticpage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_order` smallint NULL DEFAULT NULL,
  `report_show_simple` smallint NULL DEFAULT 1,
  `report_show_comp` smallint NULL DEFAULT 1,
  PRIMARY KEY (`report_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for requisition_module_actions
-- ----------------------------
DROP TABLE IF EXISTS `requisition_module_actions`;
CREATE TABLE `requisition_module_actions`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `action_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for requisition_module_flow
-- ----------------------------
DROP TABLE IF EXISTS `requisition_module_flow`;
CREATE TABLE `requisition_module_flow`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `action_id` int NULL DEFAULT NULL,
  `can_submit_to` int NULL DEFAULT NULL,
  `is_active` int NULL DEFAULT NULL,
  `prov_id` int NULL DEFAULT NULL,
  `stk_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resource_types
-- ----------------------------
DROP TABLE IF EXISTS `resource_types`;
CREATE TABLE `resource_types`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_by` int NOT NULL,
  `modified_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `created_by`(`created_by`) USING BTREE,
  INDEX `modified_by`(`modified_by`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `page_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `resource_type_id` int NOT NULL,
  `icon_class` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT NULL,
  `modified_by` int NOT NULL,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `resource_type_id`(`resource_type_id`) USING BTREE,
  INDEX `resources_created_by_users_pk`(`created_by`) USING BTREE,
  INDEX `resources_created_by_users_pk2`(`modified_by`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 595 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role_resources
-- ----------------------------
DROP TABLE IF EXISTS `role_resources`;
CREATE TABLE `role_resources`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `resource_id` int NOT NULL,
  `rank` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `role_resources_roles_fk1`(`role_id`) USING BTREE,
  INDEX `role_resources_resources_fk2`(`resource_id`) USING BTREE,
  CONSTRAINT `role_resources_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`pk_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25534 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_level` int NULL DEFAULT NULL,
  `role_category_id` int NULL DEFAULT 1 COMMENT 'list master id 29',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `landing_resource_id` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_date` datetime NULL DEFAULT NULL,
  `modified_by` int NOT NULL,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `roles_users_fk2`(`created_by`) USING BTREE,
  INDEX `roles_users_fk3`(`modified_by`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contain user type information' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shipments
-- ----------------------------
DROP TABLE IF EXISTS `shipments`;
CREATE TABLE `shipments`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `reference_number` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `manufacturer` int NULL DEFAULT NULL,
  `shipment_date` date NULL DEFAULT NULL,
  `shipment_quantity` decimal(10, 0) NULL DEFAULT NULL,
  `stk_id` int NULL DEFAULT NULL,
  `procured_by` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT 1,
  `modified_date` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('Tender','PO','Cancelled','Received','Pre Shipment') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stakeholder
-- ----------------------------
DROP TABLE IF EXISTS `stakeholder`;
CREATE TABLE `stakeholder`  (
  `stkid` int NOT NULL AUTO_INCREMENT COMMENT 'stakeholder id',
  `stkname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `merged_stk` int NULL DEFAULT NULL,
  `report_title1` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_title2` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_title3` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_logo` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stkcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stkorder` int UNSIGNED NULL DEFAULT NULL COMMENT 'the order in which stakeholder will appear in report or data entry form',
  `ParentID` int NULL DEFAULT NULL,
  `stk_type_id` int NULL DEFAULT 0,
  `lvl` int NULL DEFAULT NULL,
  `MainStakeholder` int NULL DEFAULT NULL,
  `is_reporting` tinyint NULL DEFAULT 1,
  `contact_person` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_numbers` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_emails` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `company_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ntn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gstn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `origin_country` int NULL DEFAULT NULL,
  `b_w_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `relevant_stk` int NULL DEFAULT NULL,
  `currency` enum('PKR','USD') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stkid`) USING BTREE,
  INDEX `stkid`(`stkid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3588 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contain information about stakeholders' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stakeholder_item
-- ----------------------------
DROP TABLE IF EXISTS `stakeholder_item`;
CREATE TABLE `stakeholder_item`  (
  `stk_id` int NOT NULL AUTO_INCREMENT COMMENT 'stakeholder id (primary key)',
  `stkid` int NOT NULL,
  `stk_item` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(222) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `brand_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit_price` decimal(20, 6) NULL DEFAULT NULL,
  `quantity_per_pack` double NULL DEFAULT NULL,
  `gtin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gross_capacity` double NULL DEFAULT NULL,
  `net_capacity` double NULL DEFAULT NULL,
  `pack_length` double NULL DEFAULT NULL,
  `pack_width` double NULL DEFAULT NULL,
  `pack_height` double NULL DEFAULT NULL,
  `carton_per_pallet` int NULL DEFAULT NULL,
  `quantity_per_blister` bigint NULL DEFAULT NULL,
  `carton_volume` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `old_item_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stk_id`) USING BTREE,
  INDEX `stkid`(`stkid`) USING BTREE,
  INDEX `stk_item`(`stk_item`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18175 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contains detail information of stakeholder and itm_info_tab' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stakeholder_item_bkp
-- ----------------------------
DROP TABLE IF EXISTS `stakeholder_item_bkp`;
CREATE TABLE `stakeholder_item_bkp`  (
  `stk_id` int NOT NULL AUTO_INCREMENT COMMENT 'stakeholder id (primary key)',
  `stkid` int NOT NULL,
  `stk_item` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(222) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `brand_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit_price` decimal(20, 6) NULL DEFAULT NULL,
  `quantity_per_pack` double NULL DEFAULT NULL,
  `gtin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gross_capacity` double NULL DEFAULT NULL,
  `net_capacity` double NULL DEFAULT NULL,
  `pack_length` double NULL DEFAULT NULL,
  `pack_width` double NULL DEFAULT NULL,
  `pack_height` double NULL DEFAULT NULL,
  `carton_per_pallet` int NULL DEFAULT NULL,
  `quantity_per_blister` bigint NULL DEFAULT NULL,
  `carton_volume` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `old_item_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stk_id`) USING BTREE,
  INDEX `stkid`(`stkid`) USING BTREE,
  INDEX `stk_item`(`stk_item`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11467 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contains detail information of stakeholder and itm_info_tab' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stakeholder_type
-- ----------------------------
DROP TABLE IF EXISTS `stakeholder_type`;
CREATE TABLE `stakeholder_type`  (
  `stk_type_id` int NOT NULL DEFAULT 0,
  `stk_type_descr` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stk_type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stats_tab_reporting_rate
-- ----------------------------
DROP TABLE IF EXISTS `stats_tab_reporting_rate`;
CREATE TABLE `stats_tab_reporting_rate`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `province_id` int NOT NULL DEFAULT 0,
  `province_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `district_id` int NOT NULL DEFAULT 0,
  `district_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL COMMENT 'stakeholder',
  `stakeholder_name` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stakeholder_type` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `warehouse_id` int NOT NULL DEFAULT 0 COMMENT 'id',
  `warehouse_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `warehouse_rank` decimal(10, 0) NULL DEFAULT NULL,
  `reporting_month` date NOT NULL,
  `add_date` date NULL DEFAULT NULL,
  `last_update` datetime NULL DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stock_batch
-- ----------------------------
DROP TABLE IF EXISTS `stock_batch`;
CREATE TABLE `stock_batch`  (
  `batch_id` int NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `batch_expiry` date NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `Qty` bigint NULL DEFAULT NULL,
  `status` enum('Finished','Stacked','Running') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Stacked',
  `unit_price` float NULL DEFAULT NULL,
  `dollar_rate` float NULL DEFAULT NULL,
  `production_date` date NULL DEFAULT NULL,
  `vvm_type` int NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `funding_source` int NULL DEFAULT NULL,
  `manufacturer` int NULL DEFAULT NULL,
  `phy_inspection` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dtl` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dist_plan` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`batch_id`) USING BTREE,
  INDEX `batch_id`(`batch_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE,
  INDEX `funding_source`(`funding_source`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 526776 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stock_batch_log
-- ----------------------------
DROP TABLE IF EXISTS `stock_batch_log`;
CREATE TABLE `stock_batch_log`  (
  `logid` int NOT NULL AUTO_INCREMENT,
  `Batchdetails` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`logid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35783 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stock_optimization_draft
-- ----------------------------
DROP TABLE IF EXISTS `stock_optimization_draft`;
CREATE TABLE `stock_optimization_draft`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `from_wh_id` int NULL DEFAULT NULL,
  `to_wh_id` int NULL DEFAULT NULL,
  `transfer_qty` int NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  `stk_id` int NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `created_on` datetime NULL DEFAULT NULL,
  `soh` float NULL DEFAULT NULL,
  `amc` float NULL DEFAULT NULL,
  `mos` float NULL DEFAULT NULL,
  `over_stock_qty` float NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stock_out_reasons
-- ----------------------------
DROP TABLE IF EXISTS `stock_out_reasons`;
CREATE TABLE `stock_out_reasons`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `wh_id` int NULL DEFAULT NULL,
  `itm_id` int NULL DEFAULT NULL,
  `month` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_modified_by` int NULL DEFAULT NULL,
  `last_modified_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `action_suggested` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `comments` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5439 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stock_out_reasons_district_level
-- ----------------------------
DROP TABLE IF EXISTS `stock_out_reasons_district_level`;
CREATE TABLE `stock_out_reasons_district_level`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `dist_id` int NULL DEFAULT NULL,
  `stk_id` int NULL DEFAULT NULL,
  `itm_id` int NULL DEFAULT NULL,
  `month` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_modified_by` int NULL DEFAULT NULL,
  `last_modified_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `action_suggested` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 577 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stock_sources
-- ----------------------------
DROP TABLE IF EXISTS `stock_sources`;
CREATE TABLE `stock_sources`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stock_source_id` int NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `lvl` int NULL DEFAULT 7,
  `is_default` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  UNIQUE INDEX `pk_id`(`stock_source_id`, `stakeholder_id`, `province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for stock_sources_data
-- ----------------------------
DROP TABLE IF EXISTS `stock_sources_data`;
CREATE TABLE `stock_sources_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stock_sources_id` int NULL DEFAULT NULL,
  `hf_data_id` int NULL DEFAULT NULL,
  `received` double NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `wh_data_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `hf_data_id`(`hf_data_id`) USING BTREE,
  CONSTRAINT `stock_sources_data_ibfk_1` FOREIGN KEY (`hf_data_id`) REFERENCES `tbl_hf_data` (`pk_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2860686 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for summary_data_myisam
-- ----------------------------
DROP TABLE IF EXISTS `summary_data_myisam`;
CREATE TABLE `summary_data_myisam`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Stakeholder` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Province` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `District` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Product` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Reporting_Month` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Reporting_Year` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Health_Facility` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `opening_balance` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `received_balance` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `issue_balance` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `closing_balance` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `adjustment_positive` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `adjustment_negative` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `avg_consumption` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `new` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `old` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `reporting_date` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_date` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_update` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `Stakeholder`(`Stakeholder`) USING BTREE,
  INDEX `Province`(`Province`) USING BTREE,
  INDEX `District`(`District`) USING BTREE,
  INDEX `Product`(`Product`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for summary_district
-- ----------------------------
DROP TABLE IF EXISTS `summary_district`;
CREATE TABLE `summary_district`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `item_id` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `reporting_date` date NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `district_id` int NOT NULL,
  `consumption` double NULL DEFAULT NULL,
  `avg_consumption` double NULL DEFAULT NULL,
  `soh_district_store` double NULL DEFAULT NULL,
  `soh_district_lvl` double NULL DEFAULT NULL,
  `dist_reporting_rate` decimal(6, 2) NULL DEFAULT NULL,
  `field_reporting_rate` decimal(6, 2) NULL DEFAULT NULL,
  `reporting_rate` decimal(6, 2) NULL DEFAULT NULL,
  `total_health_facilities` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `stakeholder_id`(`stakeholder_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE,
  INDEX `province_id`(`province_id`) USING BTREE,
  INDEX `district_id`(`district_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 995076 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for summary_national
-- ----------------------------
DROP TABLE IF EXISTS `summary_national`;
CREATE TABLE `summary_national`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `item_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `reporting_date` date NULL DEFAULT NULL,
  `consumption` double NULL DEFAULT NULL,
  `avg_consumption` double NULL DEFAULT NULL,
  `soh_national_store` double NULL DEFAULT NULL,
  `soh_national_lvl` double NULL DEFAULT NULL,
  `reporting_rate` decimal(6, 2) NULL DEFAULT NULL,
  `total_health_facilities` int NULL DEFAULT NULL,
  `is_copied` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `stakeholder_id`(`stakeholder_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for summary_province
-- ----------------------------
DROP TABLE IF EXISTS `summary_province`;
CREATE TABLE `summary_province`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `item_id` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stakeholder_id` int NULL DEFAULT NULL,
  `reporting_date` date NULL DEFAULT NULL,
  `province_id` int NULL DEFAULT NULL,
  `consumption` double NULL DEFAULT NULL,
  `avg_consumption` double NULL DEFAULT NULL,
  `soh_province_store` double NULL DEFAULT NULL,
  `soh_province_lvl` double NULL DEFAULT NULL,
  `reporting_rate` decimal(6, 2) NULL DEFAULT NULL,
  `total_health_facilities` int NULL DEFAULT NULL,
  `is_copied` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `stakeholder_id`(`stakeholder_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE,
  INDEX `province_id`(`province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for support_login_log
-- ----------------------------
DROP TABLE IF EXISTS `support_login_log`;
CREATE TABLE `support_login_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `support_user_id` int NULL DEFAULT NULL,
  `user_login_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `application` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for survey
-- ----------------------------
DROP TABLE IF EXISTS `survey`;
CREATE TABLE `survey`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `department` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `office` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cell_number` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `q1_data_difficulty` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `q2_report` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `comment` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `q1_y_n` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `q2_y_n` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `user_id` int NOT NULL,
  `created_by` int NOT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `modified_by` int NOT NULL DEFAULT 1,
  `modified_date` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `created_by`(`created_by`) USING BTREE,
  INDEX `modified_by`(`modified_by`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for system_settings
-- ----------------------------
DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setting_value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for sysuser_tab
-- ----------------------------
DROP TABLE IF EXISTS `sysuser_tab`;
CREATE TABLE `sysuser_tab`  (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `sysusrrec_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `sysusr_type` int NULL DEFAULT NULL,
  `user_level` tinyint NULL DEFAULT NULL,
  `whrec_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `usrlogin_id` varchar(155) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stkid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_pwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysgroup_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysgroup_prv` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sysgroup_subprv` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sysusr_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `vis_org` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_dgcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_deg` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_dept` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_photo` blob NULL COMMENT 'user photo - not implemented in v1',
  `sysusr_addr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sysusr_ph` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_cell` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sysgroup_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sysusr_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `acopen_dt` timestamp NOT NULL DEFAULT current_timestamp COMMENT 'date when account was opened',
  `extra` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `homepage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `staticmenu` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  PRIMARY KEY (`UserID`) USING BTREE,
  INDEX `UserID`(`UserID`) USING BTREE,
  INDEX `stkid`(`stkid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12287 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contain user information' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_referral
-- ----------------------------
DROP TABLE IF EXISTS `tb_referral`;
CREATE TABLE `tb_referral`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `family_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `visiting_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `treatment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hf_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `lhw_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referring_lhw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `further_details` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `incharge_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referral_date` datetime NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_cms
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cms`;
CREATE TABLE `tbl_cms`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'static page id',
  `title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Stkid` int NULL DEFAULT NULL,
  `homepage_chk` int NULL DEFAULT 0 COMMENT 'flag for homepage',
  `homepageflag` tinyint(1) NULL DEFAULT NULL,
  `heading` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `province_id` int NOT NULL,
  `logo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LogoFeild` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 181 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contain information about static pages' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_dist_levels
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dist_levels`;
CREATE TABLE `tbl_dist_levels`  (
  `lvl_id` int NOT NULL AUTO_INCREMENT COMMENT 'distribution level id',
  `lvl_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lvl_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`lvl_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'distribution level like district, province, national' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_hf_data
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_data`;
CREATE TABLE `tbl_hf_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `opening_balance` double NULL DEFAULT NULL,
  `received_balance` double NULL DEFAULT NULL,
  `issue_balance` double NULL DEFAULT NULL,
  `closing_balance` double NULL DEFAULT NULL,
  `adjustment_positive` double NULL DEFAULT NULL,
  `adjustment_negative` double NULL DEFAULT NULL,
  `avg_consumption` double NULL DEFAULT NULL,
  `new` int NULL DEFAULT NULL,
  `old` int NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp,
  `last_update` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `ip_address` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  `is_amc_calculated` tinyint NOT NULL DEFAULT 0,
  `temp` tinyint NULL DEFAULT 1,
  `removals` double NULL DEFAULT NULL,
  `dropouts` double NULL DEFAULT NULL,
  `demand` double NULL DEFAULT NULL,
  `change_pos` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `change_neg` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `retrieved` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28015322 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_hf_data_reffered_by
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_data_reffered_by`;
CREATE TABLE `tbl_hf_data_reffered_by`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `hf_data_id` int NOT NULL,
  `hf_type_id` int NOT NULL,
  `ref_surgeries` int NULL DEFAULT NULL,
  `static` int NULL DEFAULT NULL,
  `camp` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `hf_data_id`(`hf_data_id`) USING BTREE,
  CONSTRAINT `tbl_hf_data_reffered_by_ibfk_1` FOREIGN KEY (`hf_data_id`) REFERENCES `tbl_hf_data` (`pk_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_mother_care
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_mother_care`;
CREATE TABLE `tbl_hf_mother_care`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `pre_natal_new` int NULL DEFAULT NULL,
  `pre_natal_old` int NULL DEFAULT NULL,
  `post_natal_new` int NULL DEFAULT NULL,
  `post_natal_old` int NULL DEFAULT NULL,
  `ailment_children` int NULL DEFAULT NULL,
  `ailment_adults` int NULL DEFAULT NULL,
  `general_ailment` int NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 719767 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_hf_mother_care_ngo_breakdown
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_mother_care_ngo_breakdown`;
CREATE TABLE `tbl_hf_mother_care_ngo_breakdown`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `reporting_date` date NOT NULL,
  `warehouse_id` int NOT NULL,
  `hf_type_id` int NULL DEFAULT NULL,
  `pre_natal_new` int NULL DEFAULT NULL,
  `pre_natal_old` int NULL DEFAULT NULL,
  `post_natal_new` int NULL DEFAULT NULL,
  `post_natal_old` int NULL DEFAULT NULL,
  `ailment_children` int NULL DEFAULT NULL,
  `ailment_adults` int NULL DEFAULT NULL,
  `general_ailment` int NULL DEFAULT NULL,
  `referred_implants` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_non_program_count
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_non_program_count`;
CREATE TABLE `tbl_hf_non_program_count`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_id` int UNSIGNED NOT NULL,
  `reporting_date` date NOT NULL,
  `total_facilities` int UNSIGNED NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_satellite_data
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_satellite_data`;
CREATE TABLE `tbl_hf_satellite_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `issue_balance` double NULL DEFAULT NULL,
  `new` int NULL DEFAULT NULL,
  `old` int NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  `created_date` datetime NOT NULL,
  `last_update` datetime NULL DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 116574 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_satellite_data_reffered_by
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_satellite_data_reffered_by`;
CREATE TABLE `tbl_hf_satellite_data_reffered_by`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `hf_data_id` int NOT NULL,
  `hf_type_id` int NOT NULL,
  `ref_surgeries` int NULL DEFAULT NULL,
  `static` int NULL DEFAULT NULL,
  `camp` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `hf_data_id`(`hf_data_id`) USING BTREE,
  CONSTRAINT `tbl_hf_satellite_data_reffered_by_ibfk_1` FOREIGN KEY (`hf_data_id`) REFERENCES `tbl_hf_satellite_data` (`pk_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_satellite_mother_care
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_satellite_mother_care`;
CREATE TABLE `tbl_hf_satellite_mother_care`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `pre_natal_new` int NULL DEFAULT NULL,
  `pre_natal_old` int NULL DEFAULT NULL,
  `post_natal_new` int NULL DEFAULT NULL,
  `post_natal_old` int NULL DEFAULT NULL,
  `ailment_children` int NULL DEFAULT NULL,
  `ailment_adults` int NULL DEFAULT NULL,
  `general_ailment` int NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_satellite_rep_start_date
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_satellite_rep_start_date`;
CREATE TABLE `tbl_hf_satellite_rep_start_date`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NULL DEFAULT NULL,
  `reporting_start_date` date NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp,
  `modified_by` int NULL DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_type`;
CREATE TABLE `tbl_hf_type`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `hf_type` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stakeholder_id` int NOT NULL COMMENT 'Use ZERO stk for HF types used everywhere.',
  `hf_rank` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 140 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_hf_type_data
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_type_data`;
CREATE TABLE `tbl_hf_type_data`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `district_id` int NOT NULL,
  `facility_type_id` int NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `opening_balance` double NULL DEFAULT NULL,
  `received_balance` double NULL DEFAULT NULL,
  `issue_balance` double NULL DEFAULT NULL,
  `closing_balance` double NULL DEFAULT NULL,
  `adjustment_positive` double NULL DEFAULT NULL,
  `adjustment_negative` double NULL DEFAULT NULL,
  `new` int NULL DEFAULT NULL,
  `old` int NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  `created_date` datetime NOT NULL,
  `last_update` datetime NULL DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by` int NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  UNIQUE INDEX `unique_index`(`district_id`, `facility_type_id`, `item_id`, `reporting_date`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `district_id`(`district_id`) USING BTREE,
  INDEX `facility_type_id`(`facility_type_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1870199 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_hf_type_mother_care
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_type_mother_care`;
CREATE TABLE `tbl_hf_type_mother_care`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `facility_type_id` int NULL DEFAULT NULL,
  `district_id` int NOT NULL,
  `pre_natal_new` int NULL DEFAULT NULL,
  `pre_natal_old` int NULL DEFAULT NULL,
  `post_natal_new` int NULL DEFAULT NULL,
  `post_natal_old` int NULL DEFAULT NULL,
  `ailment_children` int NULL DEFAULT NULL,
  `ailment_adults` int NULL DEFAULT NULL,
  `general_ailment` int NULL DEFAULT NULL,
  `reporting_date` date NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `facility_type_id`(`facility_type_id`) USING BTREE,
  INDEX `district_id`(`district_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_hf_type_province
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_type_province`;
CREATE TABLE `tbl_hf_type_province`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stakeholder_id` int NOT NULL,
  `hf_type_id` int NOT NULL,
  `province_id` int NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `stakeholder_id`(`stakeholder_id`) USING BTREE,
  INDEX `hf_type_id`(`hf_type_id`) USING BTREE,
  INDEX `province_id`(`province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_hf_type_rank
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hf_type_rank`;
CREATE TABLE `tbl_hf_type_rank`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `stakeholder_id` int NOT NULL,
  `hf_type_id` int NOT NULL,
  `province_id` int NOT NULL,
  `hf_type_rank` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `stakeholder_id`(`stakeholder_id`) USING BTREE,
  INDEX `hf_type_id`(`hf_type_id`) USING BTREE,
  INDEX `province_id`(`province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_itemunits
-- ----------------------------
DROP TABLE IF EXISTS `tbl_itemunits`;
CREATE TABLE `tbl_itemunits`  (
  `pkUnitID` int NOT NULL AUTO_INCREMENT,
  `UnitType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkUnitID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_locations
-- ----------------------------
DROP TABLE IF EXISTS `tbl_locations`;
CREATE TABLE `tbl_locations`  (
  `PkLocID` int NOT NULL AUTO_INCREMENT,
  `LocName` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `LocLvl` int NULL DEFAULT NULL,
  `ParentID` int NULL DEFAULT NULL,
  `LocType` int NULL DEFAULT NULL,
  `temp_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dhis_code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pop_male_rural` int NULL DEFAULT NULL,
  `pop_female_rural` int NULL DEFAULT NULL,
  `growth_rate_rural` decimal(15, 4) NULL DEFAULT NULL,
  `pop_male_urban` int NULL DEFAULT NULL,
  `pop_female_urban` int NULL DEFAULT NULL,
  `growth_rate_urban` decimal(15, 4) NULL DEFAULT NULL,
  `ihs_code` int NULL DEFAULT NULL,
  `merf_code` int NULL DEFAULT NULL,
  `pphi_code` int NULL DEFAULT NULL,
  `division` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PkLocID`) USING BTREE,
  INDEX `PkLocID`(`PkLocID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1768 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_locations_copy1
-- ----------------------------
DROP TABLE IF EXISTS `tbl_locations_copy1`;
CREATE TABLE `tbl_locations_copy1`  (
  `PkLocID` int NOT NULL AUTO_INCREMENT,
  `LocName` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `LocLvl` int NULL DEFAULT NULL,
  `ParentID` int NULL DEFAULT NULL,
  `LocType` int NULL DEFAULT NULL,
  `temp_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dhis_code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pop_male_rural` int NULL DEFAULT NULL,
  `pop_female_rural` int NULL DEFAULT NULL,
  `growth_rate_rural` decimal(15, 4) NULL DEFAULT NULL,
  `pop_male_urban` int NULL DEFAULT NULL,
  `pop_female_urban` int NULL DEFAULT NULL,
  `growth_rate_urban` decimal(15, 4) NULL DEFAULT NULL,
  `ihs_code` int NULL DEFAULT NULL,
  `merf_code` int NULL DEFAULT NULL,
  `pphi_code` int NULL DEFAULT NULL,
  PRIMARY KEY (`PkLocID`) USING BTREE,
  INDEX `PkLocID`(`PkLocID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1748 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_locationtype
-- ----------------------------
DROP TABLE IF EXISTS `tbl_locationtype`;
CREATE TABLE `tbl_locationtype`  (
  `LoctypeID` int NOT NULL AUTO_INCREMENT,
  `LoctypeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TypeLvl` int NOT NULL,
  PRIMARY KEY (`LoctypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_product_category
-- ----------------------------
DROP TABLE IF EXISTS `tbl_product_category`;
CREATE TABLE `tbl_product_category`  (
  `PKItemCategoryID` int NOT NULL AUTO_INCREMENT,
  `ItemCategoryName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `parent_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`PKItemCategoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_product_status
-- ----------------------------
DROP TABLE IF EXISTS `tbl_product_status`;
CREATE TABLE `tbl_product_status`  (
  `PKItemStatusID` int NOT NULL AUTO_INCREMENT,
  `ItemStatusName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`PKItemStatusID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_product_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_product_type`;
CREATE TABLE `tbl_product_type`  (
  `PKItemTypeID` int NOT NULL AUTO_INCREMENT,
  `ItemTypeName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`PKItemTypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_satellite_camps
-- ----------------------------
DROP TABLE IF EXISTS `tbl_satellite_camps`;
CREATE TABLE `tbl_satellite_camps`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_id` int UNSIGNED NOT NULL,
  `reporting_date` date NOT NULL,
  `camps_target` int UNSIGNED NOT NULL,
  `camps_held` int UNSIGNED NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `pk_id`(`pk_id`) USING BTREE,
  INDEX `warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `reporting_date`(`reporting_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_stock_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_stock_detail`;
CREATE TABLE `tbl_stock_detail`  (
  `PkDetailID` int NOT NULL AUTO_INCREMENT,
  `fkStockID` int NULL DEFAULT NULL,
  `BatchID` int NULL DEFAULT NULL,
  `fkUnitID` int NULL DEFAULT NULL,
  `Qty` bigint NULL DEFAULT NULL,
  `temp` tinyint(1) NULL DEFAULT NULL,
  `vvm_stage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IsReceived` tinyint NULL DEFAULT NULL,
  `adjustmentType` tinyint(1) NULL DEFAULT NULL,
  `comments` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `manufacturer` int NULL DEFAULT NULL,
  `receiving_price` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driver_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driver_cnic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driver_contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name_of_service` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `consignment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name_of_agency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `builty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PkDetailID`) USING BTREE,
  INDEX `PkDetailID`(`PkDetailID`) USING BTREE,
  INDEX `fkStockID`(`fkStockID`) USING BTREE,
  INDEX `BatchID`(`BatchID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1956463313 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_stock_detail_copy1
-- ----------------------------
DROP TABLE IF EXISTS `tbl_stock_detail_copy1`;
CREATE TABLE `tbl_stock_detail_copy1`  (
  `PkDetailID` int NOT NULL AUTO_INCREMENT,
  `fkStockID` int NULL DEFAULT NULL,
  `BatchID` int NULL DEFAULT NULL,
  `fkUnitID` int NULL DEFAULT NULL,
  `Qty` bigint NULL DEFAULT NULL,
  `temp` tinyint(1) NULL DEFAULT NULL,
  `vvm_stage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IsReceived` tinyint NULL DEFAULT NULL,
  `adjustmentType` tinyint(1) NULL DEFAULT NULL,
  `comments` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `manufacturer` int NULL DEFAULT NULL,
  `receiving_price` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driver_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driver_cnic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driver_contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name_of_service` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `consignment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name_of_agency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `builty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PkDetailID`) USING BTREE,
  INDEX `PkDetailID`(`PkDetailID`) USING BTREE,
  INDEX `fkStockID`(`fkStockID`) USING BTREE,
  INDEX `BatchID`(`BatchID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1956357915 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_stock_master
-- ----------------------------
DROP TABLE IF EXISTS `tbl_stock_master`;
CREATE TABLE `tbl_stock_master`  (
  `PkStockID` int NOT NULL AUTO_INCREMENT,
  `TranDate` datetime NULL DEFAULT NULL,
  `TranNo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TranTypeID` int NULL DEFAULT NULL,
  `TranRef` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `WHIDFrom` int NULL DEFAULT NULL,
  `WHIDTo` int NULL DEFAULT NULL,
  `CreatedBy` int NULL DEFAULT NULL,
  `CreatedOn` date NULL DEFAULT NULL,
  `ReceivedRemarks` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `temp` tinyint(1) NULL DEFAULT NULL,
  `trNo` int NULL DEFAULT NULL,
  `LinkedTr` int NULL DEFAULT NULL,
  `issued_by` int NULL DEFAULT NULL,
  `is_copied` tinyint NULL DEFAULT 0,
  `shipment_id` int NULL DEFAULT NULL,
  `WHIDFromSupplier` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `shipment_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `attachment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requisition_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `source_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `po_detail` int NULL DEFAULT NULL,
  PRIMARY KEY (`PkStockID`) USING BTREE,
  INDEX `PkStockID`(`PkStockID`) USING BTREE,
  INDEX `WHIDFrom`(`WHIDFrom`) USING BTREE,
  INDEX `WHIDTo`(`WHIDTo`) USING BTREE,
  INDEX `TranNo`(`TranNo`) USING BTREE,
  INDEX `TranTypeID`(`TranTypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 576663 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_system
-- ----------------------------
DROP TABLE IF EXISTS `tbl_system`;
CREATE TABLE `tbl_system`  (
  `sys_id` smallint NOT NULL DEFAULT 0 COMMENT 'id',
  `sys_version` float(11, 1) NULL DEFAULT NULL COMMENT 'application version',
  `sys_tagline` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sys_start_date` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sys_show_rate_summary` smallint NULL DEFAULT NULL COMMENT 'flags control if summary percentages are shown in reports',
  `sys_show_rate_detail` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`sys_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contains system wide global information.' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_trans_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_trans_type`;
CREATE TABLE `tbl_trans_type`  (
  `trans_id` int NOT NULL AUTO_INCREMENT,
  `trans_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `trans_nature` varchar(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `is_adjustment` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`trans_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_login_log`;
CREATE TABLE `tbl_user_login_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `login_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 398 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `tbl_warehouse`;
CREATE TABLE `tbl_warehouse`  (
  `wh_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `wh_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dist_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `prov_id` int NULL DEFAULT NULL COMMENT 'province of warehouse',
  `stkid` int NULL DEFAULT NULL COMMENT 'stakeholder',
  `wh_type_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `locid` int NULL DEFAULT NULL,
  `stkofficeid` int NULL DEFAULT NULL,
  `is_allowed_im` tinyint(1) NOT NULL DEFAULT 0,
  `hf_type_id` int NULL DEFAULT 13,
  `hf_cat_id` int NULL DEFAULT 1 COMMENT '1=Primary, 2=Secondary, 3=Tertiary',
  `wh_rank` decimal(10, 0) NULL DEFAULT NULL,
  `dhis_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT 1,
  `reporting_start_month` date NULL DEFAULT NULL,
  `editable_data_entry_months` tinyint NOT NULL DEFAULT 2,
  `is_lock_data_entry` tinyint NOT NULL DEFAULT 0,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp,
  `created_by` int NULL DEFAULT 1,
  `modified_date` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int NULL DEFAULT 1,
  `im_start_month` date NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `merf_code` int NULL DEFAULT NULL,
  `ihs_code` int NULL DEFAULT NULL,
  `pphi_code` int NULL DEFAULT NULL,
  `ecr_start_month` date NULL DEFAULT NULL,
  `ecr_data_open_since` date NULL DEFAULT NULL,
  `cnic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`wh_id`) USING BTREE,
  INDEX `fk_whtype`(`wh_type_id`) USING BTREE,
  INDEX `fk_dist`(`dist_id`) USING BTREE,
  INDEX `fk_prov`(`prov_id`) USING BTREE,
  INDEX `fk_stk`(`stkid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113247 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'contain information about warehouse' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_warehouse_config
-- ----------------------------
DROP TABLE IF EXISTS `tbl_warehouse_config`;
CREATE TABLE `tbl_warehouse_config`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `wh_id` int NULL DEFAULT NULL,
  `key` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `month` date NULL DEFAULT NULL,
  `config` enum('Enable','Disable') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_wh_data
-- ----------------------------
DROP TABLE IF EXISTS `tbl_wh_data`;
CREATE TABLE `tbl_wh_data`  (
  `w_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_month` int NULL DEFAULT NULL,
  `report_year` int NULL DEFAULT NULL,
  `item_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `wh_obl_a` int NULL DEFAULT NULL,
  `wh_obl_c` int NULL DEFAULT NULL,
  `wh_received` int NULL DEFAULT NULL,
  `wh_issue_up` int NULL DEFAULT NULL,
  `wh_cbl_c` int NULL DEFAULT NULL,
  `wh_cbl_a` int NULL DEFAULT NULL,
  `wh_adja` int NULL DEFAULT NULL,
  `wh_adjb` int NULL DEFAULT NULL,
  `lvl` smallint NULL DEFAULT NULL,
  `RptDate` date NULL DEFAULT NULL,
  `add_date` datetime NULL DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `is_calculated` tinyint NULL DEFAULT 0,
  `comments` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`w_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE,
  INDEX `RptDate`(`RptDate`) USING BTREE,
  INDEX `report_month`(`report_month`) USING BTREE,
  INDEX `report_year`(`report_year`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7127513 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 61440 kB; (`item_id`) REFER `paklmis/itminfo_ta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_wh_data_copy1
-- ----------------------------
DROP TABLE IF EXISTS `tbl_wh_data_copy1`;
CREATE TABLE `tbl_wh_data_copy1`  (
  `w_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_month` int NULL DEFAULT NULL,
  `report_year` int NULL DEFAULT NULL,
  `item_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `wh_obl_a` int NULL DEFAULT NULL,
  `wh_obl_c` int NULL DEFAULT NULL,
  `wh_received` int NULL DEFAULT NULL,
  `wh_issue_up` int NULL DEFAULT NULL,
  `wh_cbl_c` int NULL DEFAULT NULL,
  `wh_cbl_a` int NULL DEFAULT NULL,
  `wh_adja` int NULL DEFAULT NULL,
  `wh_adjb` int NULL DEFAULT NULL,
  `lvl` smallint NULL DEFAULT NULL,
  `RptDate` date NULL DEFAULT NULL,
  `add_date` datetime NULL DEFAULT NULL,
  `last_update` datetime NULL DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `is_calculated` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`w_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE,
  INDEX `RptDate`(`RptDate`) USING BTREE,
  INDEX `report_month`(`report_month`) USING BTREE,
  INDEX `report_year`(`report_year`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 61440 kB; (`item_id`) REFER `paklmis/itminfo_ta' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_wh_data_draft
-- ----------------------------
DROP TABLE IF EXISTS `tbl_wh_data_draft`;
CREATE TABLE `tbl_wh_data_draft`  (
  `w_id` int NOT NULL AUTO_INCREMENT,
  `report_month` int NULL DEFAULT NULL,
  `report_year` int NULL DEFAULT NULL,
  `item_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `wh_obl_a` int NULL DEFAULT NULL,
  `wh_obl_c` int NULL DEFAULT NULL,
  `wh_received` int NULL DEFAULT NULL,
  `wh_issue_up` int NULL DEFAULT NULL,
  `wh_cbl_c` int NULL DEFAULT NULL,
  `wh_cbl_a` int NULL DEFAULT NULL,
  `wh_adja` int NULL DEFAULT NULL,
  `wh_adjb` int NULL DEFAULT NULL,
  `lvl` smallint NULL DEFAULT NULL,
  `RptDate` date NULL DEFAULT NULL,
  `add_date` datetime NULL DEFAULT NULL,
  `last_update` datetime NULL DEFAULT NULL,
  `ip_address` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`w_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE,
  INDEX `RptDate`(`RptDate`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 61440 kB; (`item_id`) REFER `paklmis/itminfo_ta' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_wh_data_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_wh_data_history`;
CREATE TABLE `tbl_wh_data_history`  (
  `w_id` int NOT NULL AUTO_INCREMENT,
  `report_month` int NULL DEFAULT NULL,
  `report_year` int NULL DEFAULT NULL,
  `item_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `wh_obl_a` int NULL DEFAULT NULL,
  `wh_received` int NULL DEFAULT NULL,
  `wh_issue_up` int NULL DEFAULT NULL,
  `wh_cbl_a` int NULL DEFAULT NULL,
  `wh_adja` int NULL DEFAULT NULL,
  `wh_adjb` int NULL DEFAULT NULL,
  `RptDate` date NULL DEFAULT NULL,
  `add_date` datetime NULL DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`w_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE,
  INDEX `RptDate`(`RptDate`) USING BTREE,
  INDEX `wh_id_2`(`wh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 61440 kB; (`item_id`) REFER `paklmis/itminfo_ta' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tbl_wh_update_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_wh_update_history`;
CREATE TABLE `tbl_wh_update_history`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `wh_id` int NOT NULL,
  `reporting_date` date NOT NULL,
  `update_on` datetime NULL DEFAULT NULL,
  `updated_by` int NULL DEFAULT NULL,
  `ip_address` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tc
-- ----------------------------
DROP TABLE IF EXISTS `tc`;
CREATE TABLE `tc`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tc_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for temp_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `temp_warehouse`;
CREATE TABLE `temp_warehouse`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `wh_id` int NOT NULL,
  `wh_name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wh_type_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wh_prov_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `wh_id`(`wh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for transfer_form
-- ----------------------------
DROP TABLE IF EXISTS `transfer_form`;
CREATE TABLE `transfer_form`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `transfer_slip_from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_slip_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `patient_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `patient_father_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `family_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `registration_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `taluka` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `uc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `village` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date_of_admission` datetime NULL DEFAULT current_timestamp,
  `muac` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `oedema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_from_hf` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_to_hosp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_to_tsfp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date_of_transfer` datetime NULL DEFAULT NULL,
  `nsc_transfer_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `medical_complications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `treatment_given` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_by_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_by_designation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_by_contact_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_by_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transfer_by_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_click_paths
-- ----------------------------
DROP TABLE IF EXISTS `user_click_paths`;
CREATE TABLE `user_click_paths`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `resource_id` tinyint NOT NULL,
  `user_login_log_id` int NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `resource_id`(`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for user_prov
-- ----------------------------
DROP TABLE IF EXISTS `user_prov`;
CREATE TABLE `user_prov`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `prov_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for user_status_history
-- ----------------------------
DROP TABLE IF EXISTS `user_status_history`;
CREATE TABLE `user_status_history`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `comments` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for user_stk
-- ----------------------------
DROP TABLE IF EXISTS `user_stk`;
CREATE TABLE `user_stk`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `stk_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 326 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ussd_adjustment
-- ----------------------------
DROP TABLE IF EXISTS `ussd_adjustment`;
CREATE TABLE `ussd_adjustment`  (
  `pk_id` bigint NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `adjustment_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `ussd_master_id` bigint NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_hf
-- ----------------------------
DROP TABLE IF EXISTS `ussd_hf`;
CREATE TABLE `ussd_hf`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `wh_id` int NULL DEFAULT NULL,
  `session_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serial_number` int NULL DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_log
-- ----------------------------
DROP TABLE IF EXISTS `ussd_log`;
CREATE TABLE `ussd_log`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `insertion_date` timestamp NULL DEFAULT NULL,
  `data_inserted` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_screen_level
-- ----------------------------
DROP TABLE IF EXISTS `ussd_screen_level`;
CREATE TABLE `ussd_screen_level`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `screen_level` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_session_master
-- ----------------------------
DROP TABLE IF EXISTS `ussd_session_master`;
CREATE TABLE `ussd_session_master`  (
  `pk_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `insert_date` datetime NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `week_number` int NULL DEFAULT NULL,
  `reporting_year` int NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_receive_date` datetime NULL DEFAULT NULL,
  `reporting_month` int NULL DEFAULT NULL,
  `wh_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `week_start_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_sessions
-- ----------------------------
DROP TABLE IF EXISTS `ussd_sessions`;
CREATE TABLE `ussd_sessions`  (
  `pk_id` bigint NOT NULL AUTO_INCREMENT,
  `insert_date` timestamp NULL DEFAULT current_timestamp,
  `item_id` int NULL DEFAULT NULL,
  `stock_received` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_consumed` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_adjustment_p` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_adjustment_n` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ussd_master_id` bigint NULL DEFAULT NULL,
  `is_processed` int NULL DEFAULT 0,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_sessions_history
-- ----------------------------
DROP TABLE IF EXISTS `ussd_sessions_history`;
CREATE TABLE `ussd_sessions_history`  (
  `pk_id` bigint NOT NULL AUTO_INCREMENT,
  `insert_date` timestamp NULL DEFAULT current_timestamp,
  `ussd_master_id` bigint NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `column_name` enum('stock_received','stock_consumed','stock_adjustment_p','stock_adjustment_n') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `value_entered` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_temp
-- ----------------------------
DROP TABLE IF EXISTS `ussd_temp`;
CREATE TABLE `ussd_temp`  (
  `pk_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `insert_date` datetime NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `week_number` int NULL DEFAULT NULL,
  `reporting_year` int NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `wh_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_receive_date` datetime NULL DEFAULT NULL,
  `reporting_month` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_temp_item
-- ----------------------------
DROP TABLE IF EXISTS `ussd_temp_item`;
CREATE TABLE `ussd_temp_item`  (
  `pk_id` bigint NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `data_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wh_id` int NULL DEFAULT NULL,
  `ussd_master_id` bigint NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ussd_weeks
-- ----------------------------
DROP TABLE IF EXISTS `ussd_weeks`;
CREATE TABLE `ussd_weeks`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `year` int NULL DEFAULT NULL,
  `month` int NULL DEFAULT NULL,
  `week` int NULL DEFAULT NULL,
  `date_start` date NULL DEFAULT NULL,
  `date_end` date NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 251 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for vtbl_alerts
-- ----------------------------
DROP TABLE IF EXISTS `vtbl_alerts`;
CREATE TABLE `vtbl_alerts`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `Stakeholder` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Province` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `District` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Recepient` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Text` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `Username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `UserID` int NOT NULL DEFAULT 0,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `interface` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT PARTITION BY HASH (`pk_id`)
PARTITIONS 8
(PARTITION `p0` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p1` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p2` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p3` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p4` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p5` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p6` ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `p7` ENGINE = InnoDB) MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Table structure for warehouse_doctors
-- ----------------------------
DROP TABLE IF EXISTS `warehouse_doctors`;
CREATE TABLE `warehouse_doctors`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `rhsa_warehouse_id` int UNSIGNED NOT NULL,
  `dr_warehouse_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for warehouse_status_history
-- ----------------------------
DROP TABLE IF EXISTS `warehouse_status_history`;
CREATE TABLE `warehouse_status_history`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `status` tinyint NOT NULL,
  `reporting_month` date NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for warehouses_by_month
-- ----------------------------
DROP TABLE IF EXISTS `warehouses_by_month`;
CREATE TABLE `warehouses_by_month`  (
  `pk_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `total_stores` int UNSIGNED NOT NULL,
  `level` tinyint NOT NULL,
  `stakeholder_id` int NOT NULL,
  `district_id` int UNSIGNED NOT NULL,
  `reporting_date` date NOT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for wh_user
-- ----------------------------
DROP TABLE IF EXISTS `wh_user`;
CREATE TABLE `wh_user`  (
  `wh_user_id` int NOT NULL AUTO_INCREMENT,
  `sysusrrec_id` int NOT NULL,
  `wh_id` int NOT NULL,
  `is_default` int NULL DEFAULT 1,
  PRIMARY KEY (`wh_user_id`) USING BTREE,
  INDEX `sysusrrec_id`(`sysusrrec_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 163922 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_user_bkp
-- ----------------------------
DROP TABLE IF EXISTS `wh_user_bkp`;
CREATE TABLE `wh_user_bkp`  (
  `wh_user_id` int NOT NULL AUTO_INCREMENT,
  `sysusrrec_id` int NOT NULL,
  `wh_id` int NOT NULL,
  `is_default` int NULL DEFAULT 1,
  PRIMARY KEY (`wh_user_id`) USING BTREE,
  INDEX `sysusrrec_id`(`sysusrrec_id`) USING BTREE,
  INDEX `wh_id`(`wh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125879 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for winners
-- ----------------------------
DROP TABLE IF EXISTS `winners`;
CREATE TABLE `winners`  (
  `pk_id` int NOT NULL AUTO_INCREMENT,
  `tender_id` int NULL DEFAULT NULL,
  `item_id` int NULL DEFAULT NULL,
  `item_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `company_id` int NULL DEFAULT NULL,
  `company_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `technical_marks` int NULL DEFAULT NULL,
  `financial_marks` int NULL DEFAULT NULL,
  `total_obtained_marks` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `last_modified` datetime NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `saved_by` int NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 273 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- View structure for cwh_soh
-- ----------------------------
DROP VIEW IF EXISTS `cwh_soh`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `cwh_soh` AS select `itminfo_tab`.`itm_name` AS `itm_name`,sum(`tbl_stock_detail`.`Qty`) AS `soh`,`tbl_itemunits`.`UnitType` AS `UnitType`,`stock_batch`.`funding_source` AS `funding_source`,`tbl_warehouse`.`wh_name` AS `funding_source_name`,(select `shipments`.`shipment_quantity` from `shipments` where ((`shipments`.`stk_id` = `stock_batch`.`funding_source`) and (`shipments`.`shipment_date` >= curdate()) and (`shipments`.`item_id` = `itminfo_tab`.`itm_id`) and (`shipments`.`status` not in ('Received','Cancelled')))) AS `shipment_qty` from (((((`stock_batch` join `itminfo_tab` on((`stock_batch`.`item_id` = `itminfo_tab`.`itm_id`))) join `tbl_itemunits` on((`itminfo_tab`.`itm_type` = `tbl_itemunits`.`UnitType`))) join `tbl_stock_detail` on((`stock_batch`.`batch_id` = `tbl_stock_detail`.`BatchID`))) join `tbl_stock_master` on((`tbl_stock_detail`.`fkStockID` = `tbl_stock_master`.`PkStockID`))) join `tbl_warehouse` on((`stock_batch`.`funding_source` = `tbl_warehouse`.`wh_id`))) where ((date_format(`tbl_stock_master`.`TranDate`,'%Y-%m-%d') <= curdate()) and ((`tbl_stock_master`.`WHIDFrom` = 123) or (`tbl_stock_master`.`WHIDTo` = 123)) and `stock_batch`.`funding_source` in (select `funding_stk_prov`.`funding_source_id` from `funding_stk_prov` where (`funding_stk_prov`.`province_id` in (1,2,3,4))) and (`tbl_stock_master`.`temp` = 0)) group by `itminfo_tab`.`itm_id`,`stock_batch`.`funding_source` order by `itminfo_tab`.`frmindex` ;

-- ----------------------------
-- View structure for cyp
-- ----------------------------
DROP VIEW IF EXISTS `cyp`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `cyp` AS select `prov`.`LocName` AS `Province`,`stakeholder`.`stkname` AS `Stakeholder`,`itminfo_tab`.`itm_name` AS `Product`,year(`summary_district`.`reporting_date`) AS `Yeary`,round((`summary_district`.`consumption` * `itminfo_tab`.`extra`),2) AS `CYP` from (((((`summary_district` join `itminfo_tab` on((convert(`summary_district`.`item_id` using utf8) = `itminfo_tab`.`itmrec_id`))) join `stakeholder` on((`summary_district`.`stakeholder_id` = `stakeholder`.`stkid`))) join `tbl_locations` `prov` on((`summary_district`.`province_id` = `prov`.`PkLocID`))) join `tbl_locations` `dist` on((`summary_district`.`district_id` = `dist`.`PkLocID`))) join `stakeholder_type` on((`stakeholder`.`stk_type_id` = `stakeholder_type`.`stk_type_id`))) where (`stakeholder_type`.`stk_type_id` = 0) order by `prov`.`PkLocID`,`stakeholder`.`stkid`,`itminfo_tab`.`itm_id`,year(`summary_district`.`reporting_date`) ;

-- ----------------------------
-- View structure for c_dataentryusers
-- ----------------------------
DROP VIEW IF EXISTS `c_dataentryusers`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `c_dataentryusers` AS select distinct `sysuser_tab`.`UserID` AS `UserID`,`tbl_user_login_log`.`pk_id` AS `login_id`,`sysuser_tab`.`sysusr_type` AS `role`,`tbl_warehouse`.`stkid` AS `stkid`,`tbl_warehouse`.`prov_id` AS `prov_id`,`tbl_locations`.`LocName` AS `LocName`,`stakeholder`.`stkname` AS `stkname`,`tbl_user_login_log`.`login_time` AS `login_time` from (((((`wh_user` join `sysuser_tab` on((`sysuser_tab`.`UserID` = `wh_user`.`sysusrrec_id`))) join `tbl_user_login_log` on((`sysuser_tab`.`UserID` = `tbl_user_login_log`.`user_id`))) join `tbl_warehouse` on((`wh_user`.`wh_id` = `tbl_warehouse`.`wh_id`))) join `tbl_locations` on((`tbl_warehouse`.`prov_id` = `tbl_locations`.`PkLocID`))) join `stakeholder` on((`tbl_warehouse`.`stkid` = `stakeholder`.`stkid`))) where ((`tbl_user_login_log`.`login_time` >= (now() - interval 6 month)) and (`tbl_warehouse`.`prov_id` <> 10) and (`stakeholder`.`stk_type_id` = 0)) order by `tbl_locations`.`PkLocID`,`stakeholder`.`stkid`,`tbl_user_login_log`.`login_time` ;

-- ----------------------------
-- View structure for c_reporting_points
-- ----------------------------
DROP VIEW IF EXISTS `c_reporting_points`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `c_reporting_points` AS select `tbl_warehouse`.`stkid` AS `stkid`,`tbl_warehouse`.`prov_id` AS `provid`,`stakeholder`.`stkname` AS `stkname`,`Province`.`LocName` AS `province`,count(distinct `tbl_warehouse`.`dist_id`) AS `NoOfDistricts`,count(distinct `tbl_warehouse`.`wh_id`) AS `NoOfPoints`,`Districts`.`LocName` AS `LocName`,ifnull(`tbl_hf_type`.`hf_type`,'HF') AS `hf_type` from ((((`tbl_warehouse` join `stakeholder` on((`tbl_warehouse`.`stkid` = `stakeholder`.`stkid`))) join `tbl_locations` `Province` on((`Province`.`PkLocID` = `tbl_warehouse`.`prov_id`))) join `tbl_locations` `Districts` on((`tbl_warehouse`.`dist_id` = `Districts`.`PkLocID`))) left join `tbl_hf_type` on((`tbl_hf_type`.`pk_id` = `tbl_warehouse`.`hf_type_id`))) where ((`tbl_warehouse`.`stkid` in (1,2,5,6,7,9,73)) and (`tbl_warehouse`.`prov_id` not in (8,10))) group by `tbl_warehouse`.`stkid`,`tbl_warehouse`.`prov_id`,`tbl_warehouse`.`dist_id`,`tbl_warehouse`.`hf_type_id` ;

-- ----------------------------
-- View structure for hfs
-- ----------------------------
DROP VIEW IF EXISTS `hfs`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `hfs` AS select `Pro`.`LocName` AS `Province`,`stakeholder`.`stkname` AS `stakeholder`,count(0) AS `Total_Facilities_CMWs` from ((((`tbl_warehouse` join `tbl_locations` on((`tbl_warehouse`.`dist_id` = `tbl_locations`.`PkLocID`))) join `tbl_locations` `Pro` on((`tbl_warehouse`.`prov_id` = `Pro`.`PkLocID`))) join `stakeholder` on((`tbl_warehouse`.`stkid` = `stakeholder`.`stkid`))) join `stakeholder` `stkofice` on((`tbl_warehouse`.`stkofficeid` = `stkofice`.`stkid`))) where ((`stkofice`.`lvl` = 7) and (`tbl_warehouse`.`is_active` = 1)) group by `tbl_warehouse`.`prov_id`,`stakeholder`.`stkid` order by `tbl_warehouse`.`prov_id`,`stakeholder`.`stkid` ;

-- ----------------------------
-- Triggers structure for table summary_district
-- ----------------------------
DROP TRIGGER IF EXISTS `Update Province Summary Table Insert`;
delimiter ;;
CREATE TRIGGER `Update Province Summary Table Insert` AFTER INSERT ON `summary_district` FOR EACH ROW BEGIN
    CALL REPUpdateSummaryProvince(NEW.item_id, NEW.reporting_date, NEW.stakeholder_id, NEW.province_id);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table summary_district
-- ----------------------------
DROP TRIGGER IF EXISTS `Update Province Summary Table Update`;
delimiter ;;
CREATE TRIGGER `Update Province Summary Table Update` AFTER UPDATE ON `summary_district` FOR EACH ROW BEGIN
    CALL REPUpdateSummaryProvince(NEW.item_id, NEW.reporting_date, NEW.stakeholder_id, NEW.province_id);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
