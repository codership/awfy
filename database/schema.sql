CREATE TABLE `awfy_breakdown` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `build_id` int(11) DEFAULT NULL,
  `suite_test_id` int(10) DEFAULT NULL,
  `score` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `build_id` (`build_id`),
  KEY `suite_test_id` (`suite_test_id`)
);

CREATE TABLE `awfy_build` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `run_id` int(10) unsigned NOT NULL,
  `mode_id` int(10) unsigned NOT NULL,
  `cset` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`run_id`,`mode_id`)
);

CREATE TABLE `awfy_config` (
  `key` varchar(64) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`key`)
);

INSERT INTO `awfy_config` VALUES ('version','3');

CREATE TABLE `awfy_machine` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `os` varchar(30) NOT NULL,
  `cpu` varchar(30) NOT NULL,
  `description` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `frontpage` tinyint(1) NOT NULL DEFAULT '1',
  `last_checked` int(10) unsigned NOT NULL,
  `timeout` int(11) unsigned NOT NULL,
  `contact` mediumtext NOT NULL,
  `pushed_separate` tinyint(1),
  PRIMARY KEY (`id`)
);

INSERT INTO `awfy_machine` VALUES (1,'linux','i686','main',1,1,1413897072,0,'email@example.com', NULL);

CREATE TABLE `awfy_mode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_id` int(10) unsigned NOT NULL,
  `mode` varchar(24) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mode` (`mode`),
  UNIQUE KEY `index3` (`vendor_id`,`mode`)
);

INSERT INTO `awfy_mode` VALUES (1,1,'mysql_single','Single-node MySQL','#FF0000',1);

CREATE TABLE `awfy_run` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `machine` int(10) unsigned NOT NULL,
  `stamp` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL,
  `error` mediumtext NOT NULL,
  `finish_stamp` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `machine` (`machine`),
  KEY `status` (`status`)
);

CREATE TABLE `awfy_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `build_id` int(11) DEFAULT NULL,
  `suite_version_id` int(11) DEFAULT NULL,
  `score` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `build_id` (`build_id`),
  KEY `suite_id` (`suite_version_id`)
);

CREATE TABLE `awfy_suite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `better_direction` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
);

INSERT INTO `awfy_suite` VALUES (1,'suite1','suite1_description',-1,80);

CREATE TABLE `awfy_suite_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suite_version_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `suite_id` (`suite_version_id`,`name`)
);

CREATE TABLE `awfy_suite_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suite_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `awfy_vendor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `vendor` varchar(30) NOT NULL,
  `csetURL` varchar(255) NOT NULL,
  `browser` varchar(30) NOT NULL,
  `rangeURL` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `awfy_vendor` VALUES (1,'MySQL','MySQL','http://www.mysql.com','None','http://www.mysql.com');
