--
-- Database: `company`
--

-- --------------------------------------------------------

--
-- 表的结构 `DEPARTMENT`
--

CREATE TABLE IF NOT EXISTS `DEPARTMENT` (
  `DNAME` varchar(20) DEFAULT NULL,
  `DNO` varchar(10) NOT NULL,
  `MGRSSN` varchar(20) DEFAULT NULL,
  `MGRSTARTDATE` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `DEPARTMENT`
--

INSERT INTO `DEPARTMENT` (`DNAME`, `DNO`, `MGRSSN`, `MGRSTARTDATE`) VALUES
('Research Department', 'DD001', '00002', '2010-04-01'),
('Future Direction', 'FT002', '00003', '2009-01-01'),
('Human Resource', 'HR000', '00001', '2014-05-01'),
('Product Department', 'PR003', '00004', '2012-02-09'),
('Safety Department', 'SF004', '00005', '2013-03-12');

-- --------------------------------------------------------

--
-- 表的结构 `EMPLOYEE`
--

CREATE TABLE IF NOT EXISTS `EMPLOYEE` (
  `ENAME` varchar(10) DEFAULT NULL,
  `ESSN` varchar(20) NOT NULL,
  `ADDRESS` varchar(50) DEFAULT NULL,
  `SALARY` int(11) DEFAULT NULL,
  `SUPERSSN` varchar(20) DEFAULT NULL,
  `DNO` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `EMPLOYEE`
--

INSERT INTO `EMPLOYEE` (`ENAME`, `ESSN`, `ADDRESS`, `SALARY`, `SUPERSSN`, `DNO`) VALUES
('John', '00001', 'America', 10000, NULL, 'HR000'),
('Mike', '00002', 'America', 10000, NULL, 'DD001'),
('Carpela', '00003', 'PRC', 20000, NULL, 'FT002'),
('张蔷', '00004', 'PRC', 8000, NULL, 'PR003'),
('李为', '00005', 'PRC', 12000, NULL, 'SF004'),
('Hover', '00006', 'Italy', 8000, '00001', 'HR000'),
('Winter', '00007', 'France', 7000, '00006', 'HR000'),
('王里', '00008', 'PRC', 8000, '00001', 'HR000'),
('李从文', '00009', 'PRC', 9000, '00001', 'HR000'),
('张红', '00010', 'PRC', 6000, '00008', 'HR000'),
('TJ', '00011', 'Fenland', 8000, '00002', 'DD001'),
('张天佑', '00012', 'PRC', 8000, '00002', 'DD001'),
('李天斯', '00013', 'PRC', 8000, '00012', 'DD001'),
('Steve', '00014', 'America', 8000, '00012', 'DD001'),
('Bill', '00015', 'America', 8000, '00012', 'DD001'),
('Kelinton', '00016', 'America', 2000, '00012', 'DD001'),
('Peter', '00017', 'England', 6000, '00010', 'HR000'),
('Robert', '00018', 'England', 1000, '00004', 'PR003'),
('Lee', '00019', 'America', 1000, '00004', 'PR003'),
('Micheal', '00020', 'India', 1000, '00004', 'PR003'),
('张一', '00021', 'PRC', 1000, '00004', 'SF004'),
('张二', '00022', 'PRC', 1000, '00004', 'PR003'),
('张三', '00023', 'PRC', 1000, '00004', 'HR000'),
('李一', '00024', 'PRC', 1000, '00004', 'SF004'),
('李二', '00025', 'PRC', 1000, '00004', 'PR003'),
('李三', '00026', 'PRC', 1000, '00004', 'SF004'),
('李四', '00027', 'PRC', 1000, '00004', 'PR003'),
('李五', '00028', 'PRC', 1000, '00004', 'PR003'),
('赵地', '00029', 'PRC', 1000, '00004', 'SF004'),
('赵天', '00030', 'PRC', 1000, '00004', 'PR003'),
('赵静', '00031', 'PRC', 1000, '00004', 'PR003'),
('赵耀', '00032', 'PRC', 1000, '00004', 'SF004'),
('赵群', '00033', 'PRC', 1000, '00004', 'PR003'),
('赵天穹', '00034', 'PRC', 1000, '00004', 'SF004'),
('钱松', '00035', 'PRC', 1000, '00004', 'SF004'),
('钱前', '00036', 'PRC', 1000, '00004', 'FT002'),
('钱由', '00037', 'PRC', 1000, '00004', 'PR003'),
('钱德宝', '00038', 'PRC', 1000, '00004', 'PR003'),
('孙大圣', '00039', 'PRC', 1000, '00004', 'SF004'),
('孙小果', '00040', 'PRC', 1000, '00004', 'PR003'),
('孙建', '00041', 'PRC', 1000, '00004', 'PR003'),
('孙李', '00042', 'PRC', 1000, '00004', 'PR003'),
('Alice', '00043', 'America', 1000, '00004', 'FT002'),
('Bob', '00044', 'America', 1000, '00004', 'PR003'),
('Candy', '00045', 'America', 1000, '00004', 'SF004'),
('Herbert', '00046', 'America', 1000, '00004', 'SF004'),
('Dijkstra', '00047', 'America', 1000, '00004', 'PR003'),
('Ert', '00048', 'America', 1000, '00004', 'PR003'),
('Jack', '00049', 'America', 1000, '00004', 'FT002'),
('Mozart', '00050', 'America', 1000, '00004', 'FT002'),
('Zed', '00051', 'America', 1000, '00004', 'FT002');

-- --------------------------------------------------------

--
-- 表的结构 `PROJECT`
--

CREATE TABLE IF NOT EXISTS `PROJECT` (
  `PNAME` varchar(20) DEFAULT NULL,
  `PNO` varchar(10) NOT NULL,
  `PLOCATION` varchar(50) DEFAULT NULL,
  `DNO` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `PROJECT`
--

INSERT INTO `PROJECT` (`PNAME`, `PNO`, `PLOCATION`, `DNO`) VALUES
('统一互联网', 'P1', 'Washington', 'FT002'),
('六环公路', 'P10', '北京', 'PR003'),
('Linux Project', 'P2', '北京', 'DD001'),
('SQL Project', 'P3', '哈尔滨', 'DD001'),
('OS Project', 'P4', 'Seattle', 'PR003'),
('Internet Project', 'P5', 'New York', 'SF004'),
('PL Project', 'P6', '杭州', 'DD001'),
('明日之星', 'P7', '中国', 'HR000'),
('饮食中心', 'P8', '哈尔滨', 'PR003'),
('上海中心', 'P9', '上海', 'FT002');

-- --------------------------------------------------------

--
-- 表的结构 `WORKS_ON`
--

CREATE TABLE IF NOT EXISTS `WORKS_ON` (
  `ESSN` varchar(20) NOT NULL DEFAULT '',
  `PNO` varchar(10) NOT NULL DEFAULT '',
  `HOURS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `WORKS_ON`
--

INSERT INTO `WORKS_ON` (`ESSN`, `PNO`, `HOURS`) VALUES
('00001', 'P1', 40),
('00002', 'P1', 40),
('00003', 'P1', 40),
('00004', 'P1', 40),
('00005', 'P1', 40),
('00006', 'P1', 40),
('00007', 'P1', 40),
('00008', 'P1', 40),
('00009', 'P1', 40),
('00010', 'P1', 40),
('00011', 'P1', 120),
('00011', 'P10', 21),
('00011', 'P2', 60),
('00011', 'P3', 40),
('00011', 'P4', 40),
('00011', 'P5', 40),
('00011', 'P6', 40),
('00011', 'P7', 40),
('00011', 'P8', 20),
('00011', 'P9', 35),
('00012', 'P1', 40),
('00012', 'P2', 80),
('00013', 'P1', 40),
('00013', 'P3', 10),
('00014', 'P1', 40),
('00014', 'P3', 30),
('00015', 'P1', 40),
('00015', 'P3', 110),
('00016', 'P1', 40),
('00017', 'P1', 40),
('00018', 'P1', 40),
('00019', 'P1', 40),
('00020', 'P1', 40),
('00021', 'P1', 40),
('00022', 'P1', 40),
('00023', 'P1', 40),
('00024', 'P1', 40),
('00025', 'P1', 40),
('00026', 'P1', 40),
('00027', 'P1', 40),
('00028', 'P1', 40),
('00029', 'P1', 40),
('00030', 'P1', 40),
('00031', 'P1', 40),
('00032', 'P1', 40),
('00033', 'P1', 40),
('00034', 'P1', 40),
('00035', 'P1', 40),
('00036', 'P1', 40),
('00037', 'P1', 40),
('00038', 'P1', 40),
('00039', 'P1', 40),
('00040', 'P1', 40),
('00041', 'P1', 40),
('00042', 'P1', 40),
('00043', 'P1', 40),
('00044', 'P1', 40),
('00045', 'P1', 40),
('00046', 'P1', 40),
('00047', 'P1', 40),
('00048', 'P1', 40),
('00049', 'P1', 40),
('00050', 'P1', 40),
('00051', 'P1', 40);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `DEPARTMENT`
--
ALTER TABLE `DEPARTMENT`
 ADD PRIMARY KEY (`DNO`);

--
-- Indexes for table `EMPLOYEE`
--
ALTER TABLE `EMPLOYEE`
 ADD PRIMARY KEY (`ESSN`);

--
-- Indexes for table `PROJECT`
--
ALTER TABLE `PROJECT`
 ADD PRIMARY KEY (`PNO`);

--
-- Indexes for table `WORKS_ON`
--
ALTER TABLE `WORKS_ON`
 ADD PRIMARY KEY (`ESSN`,`PNO`);
