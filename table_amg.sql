-- phpMyAdmin SQL Dump
-- version 3.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 11, 2012 at 02:08 AM
-- Server version: 5.5.21
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `amg`
--

-- --------------------------------------------------------

--
-- Table structure for table `anime`
--
/* Additional info for anime type of resources */
CREATE TABLE IF NOT EXISTS `anime` (
  `res_id` bigint(20) unsigned NOT NULL,
  `audio` varchar(32) DEFAULT NULL,
  `subtitles` varchar(32) DEFAULT NULL,
  `subgroup` varchar(32) DEFAULT NULL,
  `format_info` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `artbook`
--
/* Additional info for artbook type of resources */
CREATE TABLE IF NOT EXISTS `artbook` (
  `res_id` bigint(20) unsigned NOT NULL,
  `author` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--
/* Company info - connected with table galge... */
CREATE TABLE IF NOT EXISTS `company` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name_eng` varchar(128) DEFAULT NULL,
  `name_jpn` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=55 ;

-- --------------------------------------------------------

--
-- Table structure for table `galge`
--
/* Additional info for galge type of resources */
CREATE TABLE IF NOT EXISTS `galge` (
  `res_id` bigint(20) unsigned NOT NULL,
  `release_date` date DEFAULT NULL,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `platform_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `hentai`
--
/* Additional info for anime type of resources */
CREATE TABLE IF NOT EXISTS `hentai` (
  `res_id` bigint(20) unsigned NOT NULL,
  `audio` varchar(32) DEFAULT NULL,
  `subtitles` varchar(32) DEFAULT NULL,
  `subgroup` varchar(32) DEFAULT NULL,
  `format_info` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--
/* Additional images */
CREATE TABLE IF NOT EXISTS `image` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `res_id` bigint(20) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `mime_type` varchar(255) NOT NULL,
  `file_size` int(10) unsigned NOT NULL,
  `file_data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `info`
--
/* Additional info */
CREATE TABLE IF NOT EXISTS `info` (
  `res_id` bigint(20) unsigned NOT NULL,
  `text_data` text NOT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `manga`
--

CREATE TABLE IF NOT EXISTS `manga` (
  `res_id` bigint(20) unsigned NOT NULL,
  `author` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--
/* Additional info for movie type of resources */
CREATE TABLE IF NOT EXISTS `movie` (
  `res_id` bigint(20) unsigned NOT NULL,
  `audio` varchar(32) DEFAULT NULL,
  `subtitles` varchar(32) DEFAULT NULL,
  `subgroup` varchar(32) DEFAULT NULL,
  `format_info` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `music`
--
/* Additional info for music type of resources */
CREATE TABLE IF NOT EXISTS `music` (
  `res_id` bigint(20) unsigned NOT NULL,
  `format_info` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `music_video`
--
/* Additional info for music video type of resources */
CREATE TABLE IF NOT EXISTS `music_video` (
  `res_id` bigint(20) unsigned NOT NULL,
  `format_info` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `platform`
--
/* Platforms */
CREATE TABLE IF NOT EXISTS `platform` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `reference`
--
/* Additional references */
CREATE TABLE IF NOT EXISTS `reference` (
  `res_id1` bigint(20) unsigned NOT NULL,
  `res_id2` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`res_id1`,`res_id2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--
/* Main information table */
CREATE TABLE IF NOT EXISTS `resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` mediumint(8) unsigned NOT NULL,
  `title` varchar(1024) NOT NULL,
  `title_romaji` varchar(1024) DEFAULT NULL,
  `title_english` varchar(1024) DEFAULT NULL,
  `storage_id` bigint(20) unsigned NOT NULL,
  `directory` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=537 ;

-- --------------------------------------------------------

--
-- Table structure for table `resource_type`
--
/* Base types and their tables that extends amg.resources */
CREATE TABLE IF NOT EXISTS `resource_type` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `storage`
--
/* Storage info */
CREATE TABLE IF NOT EXISTS `storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `thumb`
--
/* Thumbnails for resources */
CREATE TABLE IF NOT EXISTS `thumb` (
  `res_id` bigint(20) unsigned NOT NULL,
  `mime_type` varchar(255) NOT NULL,
  `file_size` int(10) unsigned NOT NULL,
  `file_data` longblob NOT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tv`
--
/* Additional info for TV type of resources */
CREATE TABLE IF NOT EXISTS `tv` (
  `res_id` bigint(20) unsigned NOT NULL,
  `format_info` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--
/* Administration accounts, password in SHA-512 */
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `pass` char(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;
