#!/usr/bin/env python
#coding=utf-8

import sys
reload(sys)
sys.setdefaultencoding("utf-8")

querys = [
# 1
"""
select distinct essn
    from works_on
    where pno = "{pno}"
""",
# 2
"""
select ename from employee
    where essn in (select distinct essn
    from works_on natural join project
    where pname = "{pname}")
""",
# 3
"""
select ename, address
    from employee
    where dno = (select distinct dno
    from department
    where dname = "{dname}")
""",
# 4
"""
select ename, address
    from employee natural join department
    where dname = "{dname}"
    and salary < "{salary}"
""",
# 5
"""
select ename
    from employee
    where essn not in (
    select essn from works_on
    where pno = "{pno}")
""",
# 6
"""
select ename, dname
    from employee natural join department
    where superssn = (select essn
    from employee where ename = "{ename}")
""",
# 7
"""
select essn
    from works_on
    where pno = "{pno1}"
    and essn in (select essn
    from works_on where pno = "{pno2}")
""",
# 8
"""
select dname
    from employee natural join department
    group by dno
    having avg(salary) < "{salary}"
""",
# 9
"""
select ename
    from employee natural join works_on
    group by essn
    having count(distinct pno) >= "{n}"
    and sum(hours) <= "{hours}"
"""]

dbConf = dict(
    host = 'localhost',
    user = 'dbtest',
    passwd = '',
    db = 'company',
    port = 3306,
    charset = 'utf8'
)

import MySQLdb

def mysql_query(sql, **kw):
    conn = MySQLdb.connect(**dbConf)
    cur = conn.cursor()
    cur.execute(sql.format(**kw))
    results = cur.fetchall()

    for item in results:
        print '\t'.join(item)

    conn.commit()
    cur.close()
    conn.close()

def mysql_cli():
    """
    ./company_query -q 1 -p %pno%=P1
    """
    # print sys.argv
    if len(sys.argv) < 5:
        print """请按格式输入参数:\nExample:\n\n./company_query -q 1 -p %pno%=P1\n"""
        return
    if sys.argv[1] != '-q' or sys.argv[3] != '-p':
        print ("参数错误!")
        return
    num = sys.argv[2]
    kw = {}
    for arg in sys.argv[4:]:
        l = arg.split('=')
        key = l[0][0] == '%' and l[0][-1] == '%' and l[0][1:-1].lower() or ''
        value = l[1]
        if key and value:
            kw[key] = value

    mysql_query(querys[int(num)-1], **kw)

if __name__ == '__main__':
    mysql_cli()
