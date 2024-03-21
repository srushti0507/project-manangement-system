-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2021 at 07:17 AM
-- Server version: 8.0.21
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_mgmt`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTask` (`title` VARCHAR(50), `descr` VARCHAR(1000), `pid` INT, `priority` INT, `uid` INT, `status` INT)  BEGIN
declare id int;
declare taskid varchar(10);

SELECT ifnull(max(t.id)+1,1) into id FROM tasks t WHERE t.pid=pid;
select concat(p.abbr,'-',id) into taskid from projects p where p.id=pid;

insert into tasks(id,title,descr,pid,priority,uid,status,taskid) 
values(id,title,descr,pid,priority,uid,status,taskid);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser` (`uname` VARCHAR(30), `email` VARCHAR(30), `gender` CHAR(1), `dob` DATE, `filename` VARCHAR(50), `role` CHAR(1), `designation` INT, `pwd` VARCHAR(20), `pid` INT)  BEGIN
declare id int;
insert into users(uname,email,gender,dob,photo,role,designation,pwd,pid) 
values(uname,email,gender,dob,filename,role,designation,pwd,pid);

set id=last_insert_id();

if(role='M') then
	update projects p set p.mgrid=id where p.id=pid;
    if (select count(*)=1 from projects p where mgrid=id) then
		update projects p set active=1 where p.mgrid=id;
	end if;
end if;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int NOT NULL,
  `adate` date NOT NULL,
  `progress` varchar(40) NOT NULL,
  `logtime` decimal(4,2) NOT NULL,
  `tid` int NOT NULL,
  `pid` int NOT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `adate`, `progress`, `logtime`, `tid`, `pid`, `createdon`, `approved`) VALUES
(1, '2021-06-21', 'Login screen api create', '9.00', 3, 1, '2021-06-25 06:54:53', 1),
(2, '2021-06-22', 'Login screen api work', '9.00', 3, 1, '2021-06-25 06:56:16', 1),
(3, '2021-06-23', 'Validation added', '9.00', 3, 1, '2021-06-25 07:01:19', 1),
(4, '2021-06-24', 'CF Works', '9.00', 3, 1, '2021-06-26 07:16:24', 2),
(5, '2021-06-25', 'API works', '9.00', 3, 1, '2021-06-26 07:19:47', 1),
(6, '2021-06-26', 'CF Works', '9.00', 20, 7, '2021-06-26 09:31:23', 2),
(7, '2021-06-21', 'Work done', '9.00', 20, 7, '2021-06-26 09:31:38', 1),
(8, '2021-06-22', 'Progress', '9.00', 20, 7, '2021-06-26 09:32:01', 1),
(9, '2021-06-24', 'Progress', '9.00', 20, 7, '2021-06-26 09:33:08', 1),
(10, '2021-06-25', 'Done', '9.00', 20, 7, '2021-06-26 09:34:33', 2),
(11, '2021-06-26', 'CF Works', '9.00', 3, 1, '2021-06-28 08:39:46', 0),
(12, '2021-06-28', 'Progress', '9.00', 3, 1, '2021-06-28 08:39:56', 0),
(13, '2021-06-27', 'Progress', '9.00', 3, 1, '2021-06-28 10:01:23', 0),
(14, '2021-06-28', 'Task done', '9.00', 7, 2, '2021-07-03 06:02:23', 1),
(15, '2021-06-29', 'Task done', '9.00', 7, 2, '2021-07-03 06:02:37', 1),
(16, '2021-06-30', 'Progress', '9.00', 7, 2, '2021-07-03 06:02:55', 1),
(17, '2021-07-01', 'Progress', '9.00', 7, 2, '2021-07-03 06:03:06', 1),
(18, '2021-07-02', 'Progress', '9.00', 7, 2, '2021-07-03 06:03:18', 0),
(19, '2021-07-03', 'On Leave', '0.00', 7, 2, '2021-07-03 06:45:00', 1),
(21, '2021-06-28', 'Home Page develop', '9.00', 26, 10, '2021-07-03 10:04:41', 1),
(22, '2021-06-29', 'Task done', '9.00', 26, 10, '2021-07-03 10:05:04', 1),
(23, '2021-06-30', 'Task done', '9.00', 26, 10, '2021-07-03 10:05:16', 1),
(24, '2021-07-01', 'Progress', '9.00', 26, 10, '2021-07-03 10:05:33', 1),
(25, '2021-06-27', 'Task done', '9.00', 26, 10, '2021-07-03 10:05:54', 2),
(26, '2021-07-02', 'On Leave', '0.00', 26, 10, '2021-07-03 10:09:12', 1),
(27, '2021-07-03', 'Absent', '0.00', 26, 10, '2021-07-03 10:09:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int NOT NULL,
  `tid` int NOT NULL,
  `pid` int NOT NULL,
  `uid` int NOT NULL,
  `comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `tid`, `pid`, `uid`, `comment`, `createdon`) VALUES
(1, 2, 1, 1, 'API created for login. \r\nPlease check the sheet for reference.', '2021-06-25 16:31:43'),
(2, 4, 1, 3, 'API has been created\r\nPlease refer sheet Patient for the request payload.', '2021-06-25 16:54:29'),
(3, 4, 1, 4, 'API has been integrated.\r\nPlease test as per requirements', '2021-06-25 16:55:50'),
(4, 1, 7, 19, 'Screen is now ready.', '2021-06-26 08:41:02'),
(5, 2, 7, 19, 'API created', '2021-06-26 08:43:04'),
(6, 4, 1, 2, 'API is working fine.', '2021-06-28 09:28:33'),
(7, 1, 1, 2, 'task is ok done', '2021-06-28 10:00:23'),
(8, 1, 10, 26, 'Home Page created.', '2021-07-03 09:57:10'),
(9, 4, 10, 26, 'Dashboard developed and ready', '2021-07-03 10:01:01');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `id` int NOT NULL,
  `fromdate` date NOT NULL,
  `todate` date NOT NULL,
  `uid` int NOT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `approved` tinyint NOT NULL DEFAULT '0',
  `reqdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leaves`
--

INSERT INTO `leaves` (`id`, `fromdate`, `todate`, `uid`, `reason`, `approved`, `reqdate`) VALUES
(2, '2021-07-03', '2021-07-03', 7, 'Sick Leave', 1, '2021-07-03 06:27:00'),
(3, '2021-07-02', '2021-07-02', 26, 'Sick Leave', 1, '2021-07-03 10:08:26'),
(4, '2021-07-03', '2021-07-03', 26, 'Urgent Work', 2, '2021-07-03 10:08:51');

-- --------------------------------------------------------

--
-- Table structure for table `masters`
--

CREATE TABLE `masters` (
  `id` int NOT NULL,
  `catname` varchar(20) NOT NULL,
  `mastername` varchar(30) NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `masters`
--

INSERT INTO `masters` (`id`, `catname`, `mastername`, `active`) VALUES
(1, 'Priority', 'Low', 1),
(2, 'Priority', 'Medium', 1),
(3, 'Priority', 'High', 1),
(4, 'Priority', 'Highest', 1),
(6, 'Task Status', 'To Do', 1),
(8, 'Task Status', 'In Progress', 1),
(9, 'Task Status', 'Development Done', 1),
(12, 'Task Status', 'In Testing', 1),
(14, 'Task Status', 'Done', 1),
(15, 'Designation', 'Project Manager', 1),
(16, 'Designation', 'Backend Developer', 1),
(17, 'Designation', 'Frontend Developer', 1),
(18, 'Designation', 'QA Tester', 1),
(19, 'Project Status', 'Created', 1),
(20, 'Project Status', 'In Progress', 1),
(21, 'Project Status', 'Completed', 1),
(22, 'Priority', 'Very High', 0);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int NOT NULL,
  `title` varchar(30) NOT NULL,
  `startdt` date NOT NULL,
  `enddt` date NOT NULL,
  `description` varchar(1000) NOT NULL,
  `status` varchar(20) NOT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mgrid` int DEFAULT NULL,
  `abbr` varchar(5) DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `title`, `startdt`, `enddt`, `description`, `status`, `createdon`, `mgrid`, `abbr`, `active`) VALUES
(1, 'Hospital Management System', '2021-06-24', '2021-06-30', 'Hospital Management\r\nDoctos\r\nPatients\r\nAppointments\r\nMedicines\r\nBills', '20', '2021-06-24 07:04:03', 2, 'HMS', 1),
(2, 'Online Examination System', '2021-06-25', '2021-08-31', 'Online student examination system', '19', '2021-06-24 07:09:36', 11, 'OES', 1),
(3, 'School Management', '2021-06-25', '2021-06-25', 'School Management with staff salary and student reports.', '19', '2021-06-25 13:20:58', 6, 'SM', 1),
(7, 'E-Commerce Website', '2021-06-26', '2021-07-26', 'Online shopping website', '20', '2021-06-26 08:33:33', 19, 'ECW', 1),
(10, 'Online Shopping', '2021-07-03', '2021-07-31', 'Online shopping of grocerry items', '19', '2021-07-03 09:43:04', 24, 'OS', 1),
(11, 'Online Examination System', '2021-07-12', '2021-08-31', 'Online student examination system', '19', '2021-07-03 09:43:54', 24, 'OES', 1);

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int NOT NULL,
  `uid` int NOT NULL,
  `pid` int NOT NULL,
  `restype` varchar(20) NOT NULL,
  `details` varchar(100) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `resources`
--

INSERT INTO `resources` (`id`, `uid`, `pid`, `restype`, `details`, `status`, `createdon`) VALUES
(1, 3, 1, 'Hardware', 'RAM required 8 GB', 1, '2021-06-25 09:35:46'),
(2, 3, 1, 'Software', 'MS Office required', 1, '2021-06-25 09:38:33'),
(3, 3, 1, 'Software', 'Ebook for Java required for study', 0, '2021-06-25 09:39:09'),
(5, 26, 10, 'Hardware', 'RAM 16 GB', 1, '2021-07-03 10:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `descr` varchar(2000) NOT NULL,
  `pid` int NOT NULL,
  `parentid` int DEFAULT NULL,
  `priority` varchar(10) NOT NULL,
  `uid` int DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `deleted` tinyint NOT NULL DEFAULT '0',
  `taskid` varchar(12) DEFAULT NULL,
  `timespent` int DEFAULT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `descr`, `pid`, `parentid`, `priority`, `uid`, `status`, `deleted`, `taskid`, `timespent`, `createdon`) VALUES
(1, 'Frontend - Develop login screen', 'Create an attractive login screen with validations', 1, NULL, '3', 4, '14', 0, 'HMS-1', 3, '2021-06-24 08:18:46'),
(1, 'Create Login Screen', 'Create API to login from the login screen.\r\nTake input of userid and password with validations.\r\nMake a post method with JWT Token', 2, NULL, '3', 7, '14', 0, 'CM-1', 3, '2021-06-28 08:28:17'),
(1, 'Create Login Screen', 'Login Screen', 7, NULL, '2', 21, '7', 0, 'ECW-1', 2, '2021-06-26 08:59:28'),
(1, 'Create Home Page', 'Create Home page with html and bootstrap.\r\nProvide tabs for all related options like\r\nProducts, Services, About and Contact us link', 10, NULL, '3', 26, '14', 0, 'OS-1', 4, '2021-07-03 09:53:08'),
(2, 'Backend- Create API to login', 'Create API to login and validate the user', 1, NULL, '3', 3, '14', 0, 'HMS-2', 5, '2021-06-24 08:24:06'),
(2, 'Student Registration', 'Create api to register students.\r\nStore information about student into database.', 2, NULL, '3', 7, '6', 0, 'CM-2', NULL, '2021-06-28 08:28:55'),
(2, 'API to validate login', 'API to validate login', 7, NULL, '3', 20, '6', 0, 'ECW-2', NULL, '2021-06-26 09:36:31'),
(2, 'Customer Registration', 'Create the functionality of customer registration', 10, NULL, '2', 25, '6', 0, 'OS-2', NULL, '2021-07-03 09:53:45'),
(3, 'Create API to store Doctor Information', 'Backend api to create api to store doctor information \r\nwith all required information and fields.\r\nAlso add validation while storing data.', 1, NULL, '3', 3, '14', 0, 'HMS-3', NULL, '2021-06-24 21:52:43'),
(3, 'Student Search', 'Create screen to search student', 2, NULL, '2', 7, '6', 0, 'CM-3', NULL, '2021-07-03 05:48:12'),
(3, 'Login Customer', 'Create functionality of login for customer.\r\nProvide validation.', 10, NULL, '2', 25, '6', 0, 'OS-3', NULL, '2021-07-03 09:54:16'),
(4, 'Create API to store Patient Information', 'Backend needs to create API to store all information of the patient\r\nStore information to database\r\nProvide validation and excepiton handling.', 1, NULL, '3', 5, '12', 0, 'HMS-4', NULL, '2021-06-24 21:55:15'),
(4, 'Create Screen to store products', 'Products screen to store product information from dashboard', 10, NULL, '4', 26, '14', 0, 'OS-4', 2, '2021-07-03 09:58:57'),
(5, 'Create Screen to Store the Doctor Data', 'Frontend needs to create a screen from where the user\r\nwill store the data into the database.\r\nProvide javascript validation while store.', 1, NULL, '3', 4, '6', 0, 'HMS-5', NULL, '2021-06-24 21:56:48'),
(5, 'Create dashboard ', 'Create dashboard for admin purpose', 10, NULL, '2', 26, '6', 0, 'OS-5', NULL, '2021-07-03 09:59:17'),
(6, 'Create Screen to store patient', 'Create a form to store patient information\r\nDefine all validations over fields', 1, NULL, '2', 4, '14', 0, 'HMS-6', NULL, '2021-06-25 08:44:47'),
(7, 'Create API to create Appointment', 'You have to create an api to store information regarding the appointment.\r\nThe appointment will be stored in database.\r\nValidation should be done from backend.', 1, NULL, '4', 3, '8', 0, 'HMS-7', 0, '2021-06-25 13:11:22'),
(8, 'Test API', 'Test API', 1, NULL, '4', 3, '8', 0, 'HMS-8', 0, '2021-06-25 14:03:50'),
(9, 'Api to create Medicine data', 'API to store the medicine data into database', 1, NULL, '2', 6, '3', 0, 'HMS-9', NULL, '2021-06-26 04:57:16');

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `id` int NOT NULL,
  `pid` int NOT NULL,
  `uid` int NOT NULL,
  `startdt` date NOT NULL,
  `enddt` date NOT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`id`, `pid`, `uid`, `startdt`, `enddt`, `createdon`) VALUES
(1, 1, 3, '2021-06-21', '2021-07-31', '2021-06-24 21:34:47'),
(2, 1, 4, '2021-06-14', '2021-07-31', '2021-06-24 21:42:14'),
(3, 1, 5, '2021-06-21', '2021-06-30', '2021-06-24 21:42:36');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `uname` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'M',
  `dob` date DEFAULT NULL,
  `pwd` varchar(20) NOT NULL,
  `photo` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pics/NoImage.jpg',
  `role` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'A=Admin,M=Manager,E=Employee\r\n',
  `designation` varchar(25) DEFAULT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `deleted` tinyint NOT NULL DEFAULT '0',
  `pid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uname`, `email`, `gender`, `dob`, `pwd`, `photo`, `role`, `designation`, `createdon`, `active`, `deleted`, `pid`) VALUES
(1, 'Administrator', 'admin@admin.com', 'M', NULL, 'anand', 'pics/NoImage.jpg', 'A', 'Company Owner', '2021-06-23 20:30:29', 1, 0, NULL),
(2, 'Ajay Kumar', 'ajaykumar@gmail.com', 'M', '2000-10-10', 'anand', 'pics/1624496864226.jpg', 'M', '15', '2021-06-24 06:37:44', 1, 0, 1),
(3, 'Rajesh Kumar', 'rajeshkumar@gmail.com', 'M', '1999-12-12', 'anand', 'pics/1624497364725.jpg', 'E', '16', '2021-06-24 06:46:04', 1, 0, 1),
(4, 'Akshay Kumar', 'akshaykumar@gmail.com', 'M', '1999-10-12', 'anand', 'pics/1624497425849.jpg', 'E', '17', '2021-06-24 06:47:05', 1, 0, 1),
(5, 'Neeraj Kumar', 'neerajkumar@gmail.com', 'M', '1999-09-12', 'anand', 'pics/1624502152485.jpg', 'E', '18', '2021-06-24 08:05:52', 1, 0, 1),
(6, 'Ajay Devgan', 'ajaydev@gmail.com', 'M', '2000-10-15', 'anand', 'pics/1624548493092.jpg', 'M', '15', '2021-06-24 20:58:13', 1, 0, 2),
(7, 'Arun Verma', 'arunverma@gmail.com', 'M', '2000-10-10', 'anand', 'pics/1624667459929.jpg', 'E', '16', '2021-06-26 06:00:59', 1, 0, 2),
(8, 'Anita Goel', 'anitagoel@gmail.com', 'F', '1999-12-10', 'anand', 'pics/1624668126816.jpg', 'E', '18', '2021-06-26 06:12:07', 1, 0, 2),
(9, 'Amrita Sharma', 'amritasharma@gmail.com', 'F', '1999-03-19', 'anand', 'pics/1624668246886.jpg', 'E', '17', '2021-06-26 06:14:06', 1, 0, 2),
(10, 'Ravi Kumar', 'ravikumar1@gmail.com', 'M', '1998-09-09', 'anand', 'pics/1624668417493.jpg', 'E', '16', '2021-06-26 06:16:57', 1, 0, 2),
(12, 'Arjun Verma', 'arjunverma@gmail.com', 'M', '2005-03-22', 'anand', 'pics/1624668944443.jpg', 'E', '16', '2021-06-26 06:25:44', 1, 0, 2),
(19, 'Pradeep Khulbe', 'pradeep@gmail.com', 'M', '1999-10-10', 'anand', 'pics/1624676659326.jpg', 'M', '15', '2021-06-26 08:34:19', 1, 0, 7),
(20, 'Surya', 'surya@gmail.com', 'M', '2000-10-12', 'anand', 'pics/1624676767005.jpg', 'E', '16', '2021-06-26 08:36:07', 1, 0, 7),
(21, 'Indersen', 'indersen@gmail.com', 'M', '1999-12-12', 'anand', 'pics/1624676800788.jpg', 'E', '17', '2021-06-26 08:36:40', 1, 0, 7),
(22, 'Sunita', 'sunita@gmail.com', 'F', '2000-10-15', 'anand', 'pics/1624676833955.jpg', 'E', '18', '2021-06-26 08:37:13', 1, 0, 7),
(24, 'Abhijeet Sharma', 'abhijeet@gmail.com', 'M', '1999-10-10', 'anand', 'pics/1625285687079.jpg', 'M', '15', '2021-07-03 09:44:47', 1, 0, 10),
(25, 'Devender Singh', 'devender@gmail.com', 'M', '2000-10-15', 'anand', 'pics/1625286068003.jpg', 'E', '16', '2021-07-03 09:51:08', 1, 0, 10),
(26, 'Komal Bansal', 'komal@gmail.com', 'F', '1999-11-11', 'anand', 'pics/1625286107914.jpg', 'E', '17', '2021-07-03 09:51:47', 1, 0, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `masters`
--
ALTER TABLE `masters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`,`pid`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `masters`
--
ALTER TABLE `masters`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
