#!/bin/bash


# 1
./company_query -q 1 -p %PNO%=P1
# 2
./company_query -q 2 -p %PNAME%=OS
# 3
./company_query -q 3 -p %DNAME%=HR
# 4
./company_query -q 4 -p %DNAME%=HR %SALARY%=7000
# 5
./company_query -q 5 -p %PNO%=P2
# 6
./company_query -q 6 -p %ENAME%=张红
# 7
./company_query -q 7 -p %PNO1%=P1 %PNO2%=P2
# 8
./company_query -q 8 -p %SALARY%=10000
# 9
./company_query -q 9 -p %N%=2 %HOURS%=200

#10
./company_query -q 10 -p %PNO%=P2
