-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Host: internal-db.s134855.gridserver.com
-- Generation Time: Feb 13, 2015 at 03:28 PM
-- Server version: 5.1.55-rel12.6
-- PHP Version: 5.3.29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT=0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `db134855_servicespark`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE IF NOT EXISTS `addresses` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address1` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `address2` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `state` char(2) COLLATE utf8_bin DEFAULT NULL,
  `zip` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `type` enum('mailing','physical','both') COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `addresses_events`
--

CREATE TABLE IF NOT EXISTS `addresses_events` (
  `address_id` int(11) NOT NULL COMMENT 'fk: address',
  `event_id` int(11) NOT NULL COMMENT 'fk: event',
  PRIMARY KEY (`event_id`,`address_id`),
  KEY `FK_addresses_events_TO_addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `addresses_organizations`
--

CREATE TABLE IF NOT EXISTS `addresses_organizations` (
  `address_id` int(11) NOT NULL COMMENT 'fk: address',
  `organization_id` int(11) NOT NULL COMMENT 'fk: organization',
  PRIMARY KEY (`organization_id`,`address_id`),
  KEY `FK_addresses_organizations_TO_addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `addresses_users`
--

CREATE TABLE IF NOT EXISTS `addresses_users` (
  `address_id` int(11) NOT NULL COMMENT 'fk: address',
  `user_id` int(11) NOT NULL COMMENT 'fk: user',
  PRIMARY KEY (`user_id`,`address_id`),
  KEY `FK_addresses_users_TO_addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL COMMENT 'fk: event.event_id',
  `user_id` int(11) NOT NULL COMMENT 'fk: users.user_id',
  `parent_id` int(11) DEFAULT NULL COMMENT 'fk: posts.post_id',
  `body` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL COMMENT 'fk: organization',
  `title` varchar(100) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `start_time` datetime NOT NULL,
  `stop_time` datetime NOT NULL,
  `rsvp_desired` int(11) NOT NULL,
  `rsvp_count` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '0',
  `start_token` varchar(9) COLLATE utf8_bin NOT NULL,
  `stop_token` varchar(9) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_events_TO_organizations` (`organization_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `events_skills`
--

CREATE TABLE IF NOT EXISTS `events_skills` (
  `event_id` int(11) NOT NULL COMMENT 'fk ;event',
  `skill_id` int(11) NOT NULL COMMENT 'fk: skill',
  PRIMARY KEY (`event_id`,`skill_id`),
  KEY `FK_events_skills_TO_skills` (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE IF NOT EXISTS `organizations` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `publish` tinyint(1) NOT NULL,
  `read` tinyint(1) NOT NULL,
  `write` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `USER_ORG_UNIQUE` (`organization_id`,`user_id`),
  KEY `FK_permissions_TO_users` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `recoveries`
--

CREATE TABLE IF NOT EXISTS `recoveries` (
  `user_id` int(11) NOT NULL,
  `expiration` datetime NOT NULL,
  `token` varchar(40) COLLATE utf8_bin NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `rsvps`
--

CREATE TABLE IF NOT EXISTS `rsvps` (
  `rsvp_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL COMMENT 'fk: event.event_id',
  `user_id` int(11) NOT NULL COMMENT 'fk: user',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`rsvp_id`),
  UNIQUE KEY `event_user_unique` (`event_id`,`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE IF NOT EXISTS `skills` (
  `skill_id` int(11) NOT NULL AUTO_INCREMENT,
  `skill` varchar(100) CHARACTER SET utf8 NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `skills_users`
--

CREATE TABLE IF NOT EXISTS `skills_users` (
  `skill_id` int(11) NOT NULL COMMENT 'fk: skills',
  `user_id` int(11) NOT NULL COMMENT 'fk: users',
  PRIMARY KEY (`skill_id`,`user_id`),
  KEY `FK_skills_users_TO_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `times`
--

CREATE TABLE IF NOT EXISTS `times` (
  `time_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `stop_time` datetime DEFAULT NULL,
  PRIMARY KEY (`time_id`),
  UNIQUE KEY `UNIQUE_event-user` (`event_id`,`user_id`),
  KEY `FK_times_TO_users` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `super_admin` tinyint(1) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(40) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `first_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `last_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `missed_punches` int(11) NOT NULL DEFAULT '0' COMMENT 'this field will be maintained by CakePHP''s counter cache',
  `email_attending` tinyint(1) NOT NULL DEFAULT '1',
  `email_mentions` tinyint(1) NOT NULL DEFAULT '1',
  `email_participation` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=0 ;


COMMIT;