create database if not exists company;
use company;
-- employee
create table if not exists `employee`(
    `ename` varchar(100),
    `essn` varchar(30),
    `address` varchar(255),
    `salary` float(50),
    `superssn` varchar(30),
    `dno` varchar(50),
    primary key(`essn`)
);
-- department
create table if not exists `department`(
    `dname` varchar(50),
    `dno` varchar(50),
    `mgrssn` varchar(30),
    `mgrstartdate` date,
    primary key(`dno`)
);
-- project
create table if not exists `project`(
    `pname` varchar(50),
    `pno` varchar(50),
    `plocation` varchar(255),
    `dno` varchar(50),
    primary key(`pno`)
);
-- works_on
create table if not exists `works_on`(
    `essn` varchar(30),
    `pno` varchar(50),
    `hours` float(20),
    primary key(`essn`, `pno`)
);

