-- 1

select distinct ename
    from employee
    where essn in (select essn
    from works_on natural join project
    where pname = "SQL Project");

-- 2

select distinct ename, address
    from employee natural join department
    where dname = "Research Department"
    and salary < 3000;

-- 3

select distinct ename
    from employee
    where essn not in (select essn
    from works_on where pno="P1")


-- 4

select ename, dname
    from employee natural join department
    where superssn = (select essn from employee
    where ename="张红")

-- 5

select distinct essn from works_on
    where pno = "p1"
    and essn in (select essn from works_on
    where pno="p2");

-- 6

select distinct essn, ename
    from employee natural join works_on
    group by essn
    having count(distinct pno) = (
    select count(distinct pno)
    from project);

-- 7

select distinct dname
    from employee natural join department
    group by dno
    having avg(salary) < 3000;

-- 8

select ename
    from employee natural join works_on
    group by essn
    having count(distinct pno) > 2
    and sum(hours) <= 8;

-- 9

select dno, sum(salary)/sum(hours) as average
    from employee natural join works_on
    group by dno;


select essn, count(pno)
    from employee natural join works_on
    group by essn;

select pno, count(essn)
    from employee natural join works_on
    group by pno;

