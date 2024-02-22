-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2024 at 04:47 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_voting`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_customuser`
--

CREATE TABLE `account_customuser` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) NOT NULL,
  `user_type` varchar(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_photo` varchar(255) NOT NULL,
  `validation_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `ni` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_customuser`
--

INSERT INTO `account_customuser` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`, `user_type`, `created_at`, `updated_at`, `user_photo`, `validation_status`, `ni`) VALUES
(1, 'pbkdf2_sha256$600000$a0j4B35XBPdfVvCKqwiLLS$0rZ1KS6NCfzbauTlCbJ1t9bsZFxrI7OWqFKZV1Im2fg=', '2024-02-22 14:34:38.678377', 1, 'Administrator', 'System', 1, 1, '2024-01-30 10:13:06.269505', 'admin@admin.com', '1', '2024-01-30 10:13:06.581229', '2024-01-30 10:13:06.581229', '', 'pending', '0000000000000000'),
(2, 'pbkdf2_sha256$600000$pUC2gGtSKlwRzzeK5C3yEy$bUabMrfYtrfQLt6b/CKtbcxrTW6X5sL5Zz5ONq7xf20=', '2024-02-16 14:19:10.815641', 0, 'voters1', '1', 0, 1, '2024-01-30 10:14:13.059334', 'voters1@gmail.com', '2', '2024-01-30 10:14:13.492212', '2024-02-22 12:40:01.044222', 'account_customuser\\47_0_0_20170105173110477.jpg.chip.jpg', 'approved', '0000000000000001'),
(3, 'pbkdf2_sha256$600000$f69KzYsFiWYo6ZZ8pTnJg3$pIxqVqmzkH96VvfvUp6nHwneo4AxJ6xlkYKZfnKapk0=', '2024-02-11 06:19:09.714866', 0, 'voters2', '2', 0, 1, '2024-01-31 05:31:41.645656', 'voters2@gmail.com', '2', '2024-01-31 05:31:41.965831', '2024-02-01 01:13:41.399810', 'account_customuser\\47_0_0_20170105173114291.jpg.chip.jpg', 'approved', '0000000000000002'),
(4, 'pbkdf2_sha256$600000$rpmmcy6uIyJINO3CJVCNn8$Gt2ThaCzfpPYoBVFhG+M7s/wX8l72bTpNJ+hSJL0H+4=', '2024-02-11 06:30:54.036086', 0, 'voters', '3', 0, 1, '2024-01-31 06:16:19.190815', 'voters3@gmail.com', '2', '2024-01-31 06:16:19.566810', '2024-02-02 05:00:03.019406', 'account_customuser\\47_0_0_20170105173116787.jpg.chip.jpg', 'approved', '0000000000000003'),
(5, 'pbkdf2_sha256$600000$kykOHFZ2C2XSCy8vB8ahtj$Af92Pxm3r/HzzyGZ1R57BRvdtiZcR3LzNKx3oaNVpTc=', NULL, 0, 'voters', '4', 0, 1, '2024-01-31 06:21:48.484354', 'voters4@gmail.com', '2', '2024-01-31 06:21:48.892264', '2024-01-31 06:21:48.892264', 'account_customuser\\47_0_0_20170105173121444.jpg.chip.jpg', 'pending', '0000000000000004'),
(6, 'pbkdf2_sha256$600000$NHAGSi6tIkK98zLdvm6CTF$TMLnxdUZ5SzzC5uxFKjPs4UHXWlnUh5Oq++WZIWaQW4=', NULL, 0, 'voters', '5', 0, 1, '2024-01-31 06:32:37.912701', 'voters5@gmail.com', '2', '2024-01-31 06:32:38.243085', '2024-02-01 04:11:09.764701', 'account_customuser\\47_0_0_20170105173138581.jpg.chip.jpg', 'approved', '0000000000000005'),
(7, 'pbkdf2_sha256$600000$ERlgRGZiRJfZzjmwzFcbmo$NdODLUIXE5/504V3RZqrDda6TNhrq96d1VV3o6OIlXE=', NULL, 0, 'voters', '6', 0, 1, '2024-01-31 07:45:51.903464', 'voters6@gmail.com', '2', '2024-01-31 07:45:52.863595', '2024-01-31 07:45:52.863595', 'account_customuser\\47_0_0_20170105173254709.jpg.chip.jpg', 'pending', '0000000000000006'),
(8, 'pbkdf2_sha256$600000$ApTfQmIMTnz7XFvgYMOSQu$BUjSnBYOqAGq7lZt2LW2M39nmfWlBtjS0V4tXocMtAs=', '2024-02-01 03:41:40.377598', 0, 'voters', '7', 0, 1, '2024-01-31 11:05:42.554216', 'voters7@gmail.com', '2', '2024-01-31 11:05:43.010766', '2024-02-01 01:13:29.308317', 'account_customuser\\10_0_0_20170110220111082.jpg.chip.jpg', 'rejected', '0000000000000007'),
(9, 'pbkdf2_sha256$600000$ZJxOWoo12XdNsJ1pZ43F7E$ixF7Q0LBjvXAtP9lV7y/myU+zWFzRyiCDwswwEIlZQ4=', NULL, 0, '8', 'voters', 0, 1, '2024-02-18 11:31:07.106503', 'voters8@gmail.com', '2', '2024-02-18 11:31:07.421694', '2024-02-18 11:31:07.421694', 'account_customuser\\52_0_2_20170112220324599.jpg.chip.jpg', 'pending', '0000000000000008'),
(10, 'pbkdf2_sha256$600000$elYe8GVxaUApFuJaLGDgLz$1lOWxsZP0F5wGcnWjdckbJZisFN9ndOLmapD+keY3NE=', NULL, 0, '9', 'voters', 0, 1, '2024-02-18 11:51:46.051714', 'voters9@gmail.com', '2', '2024-02-18 11:51:46.571715', '2024-02-18 11:51:46.571715', 'account_customuser\\52_0_2_20170112220444687.jpg.chip.jpg', 'approved', '0000000000000009'),
(11, 'pbkdf2_sha256$600000$pA74x0DLJ2eEACn6gsyOVv$adSN23m8i+RzlRky77rJjqROIdLhu8Zxn2qef4D9gCE=', NULL, 0, '10', 'voters', 0, 1, '2024-02-18 11:53:31.566652', 'voters10@gmail.com', '2', '2024-02-18 11:53:32.098975', '2024-02-22 14:38:35.774588', 'account_customuser\\28_0_3_20170119194513954.jpg.chip.jpg', 'pending', '0000000000000010'),
(12, 'pbkdf2_sha256$600000$RY7qz0tjG4fcu5l5WMrzcX$n4jq2TX09GyiPrkyVZKvvIWH1yFsRZmoiqPBS6lgEH8=', NULL, 0, '11', 'voters', 0, 1, '2024-02-18 11:58:59.652647', 'voters11@gmail.com', '2', '2024-02-18 11:59:00.195311', '2024-02-18 11:59:00.195311', 'account_customuser\\52_0_2_20170116183811379.jpg.chip.jpg', 'pending', '0000000000000011'),
(13, 'pbkdf2_sha256$600000$HXTbvPOCXtTKKqjHZI5c9m$Fx2VeEQSrd+1j5brIuFkghgT4321u9r8OEA6wMEIyME=', NULL, 0, '12', 'voters', 0, 1, '2024-02-18 15:53:50.888509', 'voters12@gmail.com', '2', '2024-02-18 15:53:51.610173', '2024-02-18 15:53:51.610173', 'account_customuser\\52_0_2_20170116191323693.jpg.chip.jpg', 'pending', '0000000000000012'),
(14, 'pbkdf2_sha256$600000$2Xn2jEpr4GY777TZxA7e5C$IFDT5YIS5GDMBjopuk1Ajh9mBBzYBUmRgrwnQXlUhUk=', NULL, 0, '13', 'voters', 0, 1, '2024-02-22 09:58:13.160460', 'voters13@gmail.com', '2', '2024-02-22 09:58:14.156508', '2024-02-22 09:58:14.156508', 'account_customuser\\21_0_3_20170104230524803.jpg.chip.jpg', 'pending', '0000000000000013'),
(15, 'pbkdf2_sha256$600000$1xLvDX5j33PXnFaGmDlMrW$bn8GpcsnhUbAiMxBs+xSciKaw/Q6PuXiBNg7TCInaqg=', NULL, 0, '14', 'voters', 0, 1, '2024-02-22 13:29:02.839847', 'voters14@gmail.com', '2', '2024-02-22 13:29:03.885706', '2024-02-22 13:29:03.885706', 'account_customuser\\105_0_0_20170112213001988.jpg.chip.jpg', 'pending', '0000000000000014'),
(16, 'pbkdf2_sha256$600000$WyEpcFIHzYoDicVuhl9d4j$rH4a1GwxpPF31UMP5mUddAZI2I1YEL1DiWjGooDUeoA=', NULL, 0, '15', 'voters', 0, 1, '2024-02-22 13:30:06.483839', 'voters15@gmail.com', '2', '2024-02-22 13:30:07.218703', '2024-02-22 13:30:07.218703', 'account_customuser\\10_0_0_20170110215927291.jpg.chip.jpg', 'pending', '0000000000000015'),
(17, 'pbkdf2_sha256$600000$SAKAsTOArSSQTYuZdXbyU8$QYOrX5TK3yE7iLBiedxAeBH8Rc2dBpITqptbsCMBjtQ=', NULL, 0, '16', 'voters', 0, 1, '2024-02-22 14:08:13.779477', 'voters16@gmail.com', '2', '2024-02-22 14:08:14.507065', '2024-02-22 14:08:14.507065', 'account_customuser\\24_0_1_20170112204730931.jpg.chip.jpg', 'pending', '0000000000000016'),
(18, 'pbkdf2_sha256$600000$2VzaF4hTzpE4bUZUQtAVNT$qbhRkoXRPgmp5vqksDWGTofdyJ6RIJ1A8TmrasyVgT0=', NULL, 0, '17', 'voters', 0, 1, '2024-02-22 14:12:01.364739', 'voters17@gmail.com', '2', '2024-02-22 14:12:02.236937', '2024-02-22 14:12:02.236937', 'account_customuser\\52_0_2_20170116192904934.jpg.chip.jpg', 'pending', '0000000000000017'),
(19, 'pbkdf2_sha256$600000$TTZW87uXyUgb3ioj6BrmSs$dcZgCTHtlYUhnbd0CPaAOUyHF1DhK4zVcpwsneb56u4=', NULL, 0, '18', 'voters', 0, 1, '2024-02-22 14:14:40.054618', 'voters18@gmail.com', '2', '2024-02-22 14:14:40.922425', '2024-02-22 14:14:40.922425', 'account_customuser\\101_0_0_20170112213500903.jpg.chip.jpg', 'pending', '0000000000000018'),
(20, 'pbkdf2_sha256$600000$rDzaV8fensIZsUqgiWzho7$ScQuFWvvj5DUZlN5juFD5cpHOJbqQsx0+aSrRf6fYhw=', NULL, 0, '19', 'voters', 0, 1, '2024-02-22 14:16:10.994380', 'voters19@gmail.com', '2', '2024-02-22 14:16:11.639197', '2024-02-22 14:16:11.639197', 'account_customuser\\52_0_2_20170117161035782.jpg.chip.jpg', 'pending', '0000000000000019'),
(21, 'pbkdf2_sha256$600000$l6zBs4VGrmb4yZXY4GBsdm$x657YBVAJnqVhsFExhdpcR2dhQ1UoGcfUlTvXDAF4Kg=', NULL, 0, '20', 'voters', 0, 1, '2024-02-22 14:21:16.428862', 'voters20@gmail.com', '2', '2024-02-22 14:21:16.744465', '2024-02-22 15:38:09.888491', 'account_customuser\\52_0_3_20170104202143258.jpg.chip.jpg', 'rejected', '0000000000000020'),
(22, 'pbkdf2_sha256$600000$euePu0FvkDihDIkLQegm4Q$Oit6htCFPyfhoxxiI1zMXIM+pNsVxCCoFq4+qvRpbwE=', NULL, 0, '21', 'voters', 0, 1, '2024-02-22 14:34:27.058683', 'voters21@gmail.com', '2', '2024-02-22 14:34:27.479161', '2024-02-22 14:39:23.899533', 'account_customuser\\99_1_0_20170110182052119.jpg.chip.jpg', 'approved', '0000000000000021');

-- --------------------------------------------------------

--
-- Table structure for table `account_customuser_groups`
--

CREATE TABLE `account_customuser_groups` (
  `id` int(11) NOT NULL,
  `customuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_customuser_user_permissions`
--

CREATE TABLE `account_customuser_user_permissions` (
  `id` int(11) NOT NULL,
  `customuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_customuser'),
(22, 'Can change user', 6, 'change_customuser'),
(23, 'Can delete user', 6, 'delete_customuser'),
(24, 'Can view user', 6, 'view_customuser'),
(25, 'Can add position', 7, 'add_position'),
(26, 'Can change position', 7, 'change_position'),
(27, 'Can delete position', 7, 'delete_position'),
(28, 'Can view position', 7, 'view_position'),
(29, 'Can add candidate', 8, 'add_candidate'),
(30, 'Can change candidate', 8, 'change_candidate'),
(31, 'Can delete candidate', 8, 'delete_candidate'),
(32, 'Can view candidate', 8, 'view_candidate'),
(33, 'Can add voter', 9, 'add_voter'),
(34, 'Can change voter', 9, 'change_voter'),
(35, 'Can delete voter', 9, 'delete_voter'),
(36, 'Can view voter', 9, 'view_voter'),
(37, 'Can add votes', 10, 'add_votes'),
(38, 'Can change votes', 10, 'change_votes'),
(39, 'Can delete votes', 10, 'delete_votes'),
(40, 'Can view votes', 10, 'view_votes');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(6, 'account', 'customuser'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(8, 'voting', 'candidate'),
(7, 'voting', 'position'),
(9, 'voting', 'voter'),
(10, 'voting', 'votes');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-01-30 10:11:29.837073'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-01-30 10:11:29.910871'),
(3, 'auth', '0001_initial', '2024-01-30 10:11:30.207967'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-01-30 10:11:30.285940'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-01-30 10:11:30.291923'),
(6, 'auth', '0004_alter_user_username_opts', '2024-01-30 10:11:30.297907'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-01-30 10:11:30.303891'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-01-30 10:11:30.306887'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-01-30 10:11:30.312868'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-01-30 10:11:30.318881'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-01-30 10:11:30.324862'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-01-30 10:11:30.337829'),
(13, 'auth', '0011_update_proxy_permissions', '2024-01-30 10:11:30.345806'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-01-30 10:11:30.352818'),
(15, 'account', '0001_initial', '2024-01-30 10:11:30.730912'),
(16, 'admin', '0001_initial', '2024-01-30 10:11:30.905645'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-01-30 10:11:30.912373'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-01-30 10:11:30.921318'),
(19, 'sessions', '0001_initial', '2024-01-30 10:11:30.961239'),
(20, 'voting', '0001_initial', '2024-01-30 10:11:31.400160'),
(21, 'voting', '0002_voter_photo_voter_validation_status', '2024-01-31 03:51:15.031744');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('ixwhpr59ium7u5a7hp5eyser5jz2peer', '.eJxVi0EKwjAQRe-StZRpMkmtS6HnCDOTDClqBdusxLu3BQu6_O-_9zaR6lJinfMrjslcjDWnX8YktzztB4k867Q0-UHj_eDNsK_rV_orC81ly1wA6sQndizWBmcFUJ1iz7hxwR4SoVdyHYiCAnJgSP7sPWhubWs-Kzj6NUQ:1rVCfR:yu4R6RJgvN81gDOvRB41LUfAuyXWcYw-T7AgafvfKSY', '2024-02-14 15:38:25.619288'),
('utsnhjsbrm770glzp28xwnifg4tvffrg', '.eJxVi8sKwjAQRf8laymZybMuhX5HuZ0kpKgVbLMS_10LCrq8557zUCPaVse25vs4J3VUpA6_bIKc87IfELm1ZevyFfPly7thX6eP9FdWrPWd9d4QdGKIhmYuxgI-2GgkOGYKBI46kTfRgWx0usQ8SZDiiuuzJPV8AQ2-NMM:1rdA9m:IiqSFYGJNrYMQNJGGyskEiqKvtJwb-NF84u6w1HU8LA', '2024-03-07 14:34:38.682295');

-- --------------------------------------------------------

--
-- Table structure for table `votes_encrypt`
--

CREATE TABLE `votes_encrypt` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `candidate_encrypt_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `voter_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voting_candidate`
--

CREATE TABLE `voting_candidate` (
  `id` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `bio` longtext NOT NULL,
  `position_id` int(11) NOT NULL,
  `skorenk` varchar(500) NOT NULL DEFAULT '0',
  `skordek` varchar(500) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voting_candidate`
--

INSERT INTO `voting_candidate` (`id`, `fullname`, `photo`, `bio`, `position_id`, `skorenk`, `skordek`) VALUES
(1, 'Candidate 1', 'candidates/24_0_3_20170117145945091.jpg.chip.jpg', 'Choose me for Otaku\'s Mirai', 1, '19800857114011597309554292863513479470', '0'),
(2, 'Candidate 2', 'candidates/31_0_0_20170104201545729.jpg.chip.jpg', 'pilih saya maka program hilirisasi berlanjut', 1, '69091283421656554157598586759205682717', '0'),
(3, 'Candidate 3', 'candidates/55_1_0_20170110122115175.jpg.chip.jpg', 'Yang ke 3 soalnya bukan first choice maupun second choice :)', 1, '53404211747188778589240845810764689827', '1');

-- --------------------------------------------------------

--
-- Table structure for table `voting_position`
--

CREATE TABLE `voting_position` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `max_vote` int(11) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voting_position`
--

INSERT INTO `voting_position` (`id`, `name`, `max_vote`, `priority`) VALUES
(1, 'Pemilihan Ketua Lingkungan Desa X', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `voting_voter`
--

CREATE TABLE `voting_voter` (
  `id` int(11) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `voted` tinyint(1) NOT NULL,
  `otp_sent` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voting_voter`
--

INSERT INTO `voting_voter` (`id`, `phone`, `otp`, `verified`, `voted`, `otp_sent`, `admin_id`) VALUES
(1, '08553655359', '1968758', 1, 1, 0, 2),
(2, '0812345765', NULL, 0, 0, 0, 3),
(3, '08333333333', NULL, 0, 0, 0, 4),
(4, '08444444444', NULL, 0, 0, 0, 5),
(5, '08555555555', NULL, 0, 0, 0, 6),
(6, '08666666666', NULL, 0, 0, 0, 7),
(7, '08777777777', NULL, 0, 0, 0, 8),
(8, '08888888888', NULL, 0, 0, 0, 9),
(9, '08199999999', NULL, 0, 0, 0, 10),
(10, '08100000000', NULL, 0, 0, 0, 11),
(11, '08011111111', NULL, 0, 0, 0, 12),
(12, '08022222222', NULL, 0, 0, 0, 13),
(13, '08133333333', NULL, 0, 0, 0, 14),
(14, '08144444444', NULL, 0, 0, 0, 15),
(15, '08155555555', NULL, 0, 0, 0, 16),
(16, '08066666666', NULL, 0, 0, 0, 17),
(17, '08077777777', NULL, 0, 0, 0, 18),
(18, '08088888888', NULL, 0, 0, 0, 19),
(19, '08000000019', NULL, 0, 0, 0, 20),
(20, '08000000020', NULL, 0, 0, 0, 21),
(21, '08000000021', NULL, 0, 0, 0, 22);

-- --------------------------------------------------------

--
-- Table structure for table `voting_votes`
--

CREATE TABLE `voting_votes` (
  `id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `voter_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voting_votes`
--

INSERT INTO `voting_votes` (`id`, `candidate_id`, `position_id`, `voter_id`) VALUES
(1, 3, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `voting_votes_encrypt`
--

CREATE TABLE `voting_votes_encrypt` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `candidate_encrypt_id` varchar(500) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `voter_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voting_votes_encrypt`
--

INSERT INTO `voting_votes_encrypt` (`id`, `candidate_encrypt_id`, `position_id`, `voter_id`) VALUES
(1, '1041365884793179221649614022765192983', 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_customuser`
--
ALTER TABLE `account_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `ni` (`ni`);

--
-- Indexes for table `account_customuser_groups`
--
ALTER TABLE `account_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_customuser_groups_customuser_id_group_id_7e51db7b_uniq` (`customuser_id`,`group_id`),
  ADD KEY `account_customuser_groups_group_id_2be9f6d7_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `account_customuser_user_permissions`
--
ALTER TABLE `account_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_customuser_user__customuser_id_permission_650e378f_uniq` (`customuser_id`,`permission_id`),
  ADD KEY `account_customuser_u_permission_id_f4aec423_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_account_customuser_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `votes_encrypt`
--
ALTER TABLE `votes_encrypt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voting_candidate`
--
ALTER TABLE `voting_candidate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voting_candidate_position_id_11fc864a_fk_voting_position_id` (`position_id`);

--
-- Indexes for table `voting_position`
--
ALTER TABLE `voting_position`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `voting_voter`
--
ALTER TABLE `voting_voter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `admin_id` (`admin_id`);

--
-- Indexes for table `voting_votes`
--
ALTER TABLE `voting_votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voting_votes_candidate_id_4f8a611d_fk_voting_candidate_id` (`candidate_id`),
  ADD KEY `voting_votes_position_id_2d19ba9a_fk_voting_position_id` (`position_id`),
  ADD KEY `voting_votes_voter_id_f4b66619_fk_voting_voter_id` (`voter_id`);

--
-- Indexes for table `voting_votes_encrypt`
--
ALTER TABLE `voting_votes_encrypt`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_customuser`
--
ALTER TABLE `account_customuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `account_customuser_groups`
--
ALTER TABLE `account_customuser_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_customuser_user_permissions`
--
ALTER TABLE `account_customuser_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `votes_encrypt`
--
ALTER TABLE `votes_encrypt`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voting_candidate`
--
ALTER TABLE `voting_candidate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `voting_position`
--
ALTER TABLE `voting_position`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `voting_voter`
--
ALTER TABLE `voting_voter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `voting_votes`
--
ALTER TABLE `voting_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `voting_votes_encrypt`
--
ALTER TABLE `voting_votes_encrypt`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_customuser_groups`
--
ALTER TABLE `account_customuser_groups`
  ADD CONSTRAINT `account_customuser_g_customuser_id_b6c60904_fk_account_c` FOREIGN KEY (`customuser_id`) REFERENCES `account_customuser` (`id`),
  ADD CONSTRAINT `account_customuser_groups_group_id_2be9f6d7_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `account_customuser_user_permissions`
--
ALTER TABLE `account_customuser_user_permissions`
  ADD CONSTRAINT `account_customuser_u_customuser_id_03bcc114_fk_account_c` FOREIGN KEY (`customuser_id`) REFERENCES `account_customuser` (`id`),
  ADD CONSTRAINT `account_customuser_u_permission_id_f4aec423_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `account_customuser` (`id`);

--
-- Constraints for table `voting_candidate`
--
ALTER TABLE `voting_candidate`
  ADD CONSTRAINT `voting_candidate_position_id_11fc864a_fk_voting_position_id` FOREIGN KEY (`position_id`) REFERENCES `voting_position` (`id`);

--
-- Constraints for table `voting_voter`
--
ALTER TABLE `voting_voter`
  ADD CONSTRAINT `voting_voter_admin_id_62ab8e8d_fk_account_customuser_id` FOREIGN KEY (`admin_id`) REFERENCES `account_customuser` (`id`);

--
-- Constraints for table `voting_votes`
--
ALTER TABLE `voting_votes`
  ADD CONSTRAINT `voting_votes_candidate_id_4f8a611d_fk_voting_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `voting_candidate` (`id`),
  ADD CONSTRAINT `voting_votes_position_id_2d19ba9a_fk_voting_position_id` FOREIGN KEY (`position_id`) REFERENCES `voting_position` (`id`),
  ADD CONSTRAINT `voting_votes_voter_id_f4b66619_fk_voting_voter_id` FOREIGN KEY (`voter_id`) REFERENCES `voting_voter` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
