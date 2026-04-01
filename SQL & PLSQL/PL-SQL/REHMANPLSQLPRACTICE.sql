set SERVEROUTPUT ON;
--write a program to display the employee information of empID 7654?
declare
e emp%rowtype;
a number:= 7654;
begin
select ename,deptno into e.ename,e.deptno from emp where empno=a;
dbms_output.put_line(e.ename||' '||e.deptno);
end;
/
--Write a program to display number of CLERK from the EMP 
declare 
e emp.job%type;
a number;
begin
select count(*),job into a,e from emp where job='CLERK' group by job;
dbms_output.put_line(a||'   '||e);
end;
/
SELECT * FROM cust_dtls;
/ 
--Write  a program to display number of male customers and number of female customers?
DECLARE
MALE_NO NUMBER;
FEMALE_NO NUMBER;
BEGIN
SELECT COUNT(*) INTO MALE_NO FROM CUST_DTLS  WHERE EGENDER='M' GROUP BY EGENDER;
SELECT COUNT(*) INTO FEMALE_NO FROM CUST_DTLS  WHERE EGENDER='F' GROUP BY EGENDER;
dbms_output.put_line(MALE_NO||'   '||FEMALE_NO);
END;
/
--3) Write a program to display the LOC,DEPTNO,EMPNO of EMPS WORKING IN CHICAGO?
CREATE OR REPLACE PROCEDURE EDX IS
CURSOR C1 IS SELECT D.LOC,D.DNAME,E.EMPNO FROM DEPT D,EMP E WHERE E.DEPTNO=D.DEPTNO AND D.LOC = 'CHICAGO';
TYPE F IS RECORD(
L DEPT.LOC%TYPE,
D DEPT.DNAME%TYPE,
E EMP.EMPNO%TYPE);
SH F;
BEGIN
OPEN C1;
LOOP
FETCH C1 INTO SH;
EXIT WHEN C1%NOTFOUND;
dbms_output.put_line(SH.L||'  '||SH.D||'  '||SH.E);
END LOOP;
CLOSE C1;
END;
/
EXEC EDX;
/
--function process
CREATE OR REPLACE FUNCTION MATHS(A NUMBER, B NUMBER, OP VARCHAR2)
RETURN VARCHAR2 IS
BEGIN
IF OP='+' THEN RETURN (A+B);
ELSIF OP='-' THEN RETURN (A-B);
ELSIF OP NOT IN('+','-') THEN RETURN 'ENTER CORRECT OPERATOR';
ELSE 
dbms_output.put_line('ENTER A CORRECT OPERATOR OR NUMBER');
END IF;
END;
/
SELECT MATHS(2,3,'D') FROM DUAL;
/
--procedure process
CREATE OR REPLACE PROCEDURE MATHD(A NUMBER, B NUMBER, OP VARCHAR2)
IS
EX EXCEPTION;
DD EXCEPTION;
PRAGMA EXCEPTION_INIT(DD,-20999);
BEGIN
IF A=B THEN RAISE EX;
ELSIF OP='-' THEN dbms_output.put_line(A-B);
ELSIF OP='/' THEN dbms_output.put_line(A/B);
ELSIF OP='*' THEN dbms_output.put_line(A*B);
ELSIF OP='+' THEN dbms_output.put_line(A+B);
ELSIF OP NOT IN('+','-','*','/') THEN RAISE_APPLICATION_ERROR(-20999, ' ENTER CORRECT OPERATOR');
ELSE 
dbms_output.put_line('ENTER A CORRECT OPERATOR OR NUMBER');
END IF;
EXCEPTION WHEN EX THEN dbms_output.put_line( A||' IS EQUAL TO '||B);
WHEN DD THEN dbms_output.put_line(sqlerrm);
WHEN ZERO_DIVIDE THEN dbms_output.put_line('DO NOT DIVIDE WITH ZERO');
END;
/
--using implicit cursor
declare
cc emp%rowtype;
begin
select ename into cc.ename from emp where empno=&m;
if sql%notfound then dbms_output.put_line('no data found');
elsif sql%found then dbms_output.put_line('data found');
end if;
--cc.empno:=sql%rowcount; 
--DBMS_OUTPUT.PUT_LINE('no of rows fetched are '||cc.empno);
end;
/
--using parametric cursor
declare
cursor c1(ss number) is select * from emp where deptno=ss;
e emp%rowtype;
begin
open c1(30);
loop
fetch c1 into e;
exit when c1%notfound;
dbms_output.put_line(e.ename||'   '||e.empno);
end loop;
close c1;
end;
/ --- ref cursor
declare
type t1 is ref cursor;
c1 t1;
e emp%rowtype;
d dept%rowtype;
begin
open c1 for select * from emp where deptno=30;
loop
fetch c1 into e;
exit when c1%notfound;
dbms_output.put_line(e.ename);
end loop;
close c1;
open c1 for select * from dept;
loop
fetch c1 into d;
exit when c1%notfound;
dbms_output.put_line(d.dname);
end loop;
close c1;
end;
/ 
--for loop cursor
declare
cursor c1 is select * from emp;
begin
for i in c1
loop
dbms_output.put_line('empno '||i.empno||chr(10)||i.ename);
end loop;
end;
/
--pre-defined exceptions
declare
e emp%rowtype;
begin 
select ename,empno into e.ename,e.empno from emp where deptno=&d;
dbms_output.put_line(e.ename||'  '||e.empno);
exception when no_data_found then dbms_output.put_line('no such record');
when value_error then dbms_output.put_line('enter correct value');
when too_many_rows then dbms_output.put_line('there are more than 1 rows');
end;
/
--user defined exceptions
declare 
type t is record (
e  emp.empno%type,
n  emp.ename%type,
s  emp.sal%type
);
tpe t;
ex exception;
begin
select sal into tpe.s from emp where empno=7499;
if tpe.s <1000 then dbms_output.put_line('the sal is '||tpe.s);
else 
raise ex;
end if;
exception when ex then dbms_output.put_line('there is exception');
end;
/
---------------creating a package specification
create or replace package pkg12 is
PROCEDURE MATHD(A NUMBER, B NUMBER, OP VARCHAR2);
FUNCTION MATHS(A NUMBER, B NUMBER, OP VARCHAR2)
RETURN VARCHAR2;
end;
/
----------------creating package body
create or replace package body pkg12 as
FUNCTION MATHS(A NUMBER, B NUMBER, OP VARCHAR2)
RETURN VARCHAR2 IS
BEGIN
IF OP='+' THEN RETURN (A+B);
ELSIF OP='-' THEN RETURN (A-B);
ELSIF OP NOT IN('+','-') THEN RETURN 'ENTER CORRECT OPERATOR';
ELSE 
dbms_output.put_line('ENTER A CORRECT OPERATOR OR NUMBER');
END IF;
END;
PROCEDURE MATHD(A NUMBER, B NUMBER, OP VARCHAR2)
IS
EX EXCEPTION;
DD EXCEPTION;
PRAGMA EXCEPTION_INIT(DD,-20999);
BEGIN
IF A=B THEN RAISE EX;
ELSIF OP='-' THEN dbms_output.put_line(A-B);
ELSIF OP='/' THEN dbms_output.put_line(A/B);
ELSIF OP='*' THEN dbms_output.put_line(A*B);
ELSIF OP='+' THEN dbms_output.put_line(A+B);
ELSIF OP NOT IN('+','-','*','/') THEN RAISE_APPLICATION_ERROR(-20999, ' ENTER CORRECT OPERATOR');
ELSE 
dbms_output.put_line('ENTER A CORRECT OPERATOR OR NUMBER');
END IF;
EXCEPTION WHEN EX THEN dbms_output.put_line( A||' IS EQUAL TO '||B);
WHEN DD THEN dbms_output.put_line(sqlerrm);
WHEN ZERO_DIVIDE THEN dbms_output.put_line('DO NOT DIVIDE WITH ZERO');
END;
end pkg12;
/
select pkg12.maths(2,3,'+') from dual;
/
---trigger for making new values upper case
create or replace trigger t121 BEFORE insert or update on ij for each row
begin
:new.ename:= upper(:new.ename);
end;
/
----trigger for not letting updating ename
create or replace trigger t122 before insert or update on ij for each row
begin
:new.ename:=(:old.ename);
end;
/
create or replace trigger t124 before insert or update or delete on ij for each row
begin
if updating then dbms_output.put_line('do not update');
elsif deleting then RAISE_APPLICATION_ERROR(-20010, 'Acsdfffffffffffffffffff');
end if;
end;
/
-- SESSION LEVEL TRIGGERS
create or replace trigger t124 before update on ij for each row
begin
if to_char(sysdate,'HH24:MM') BETWEEN '13:00' AND '20:00' then RAISE_APPLICATION_ERROR(-20000, 'DO NOT UPDATE');
end if;
end;
/
--Deptno does not exist in dept table.
CREATE OR REPLACE TRIGGER check_deptno
BEFORE INSERT ON emp
FOR EACH ROW
DECLARE
v_count NUMBER;
BEGIN
SELECT COUNT(*) INTO v_count FROM dept
WHERE deptno = :NEW.deptno;
IF v_count = 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'Deptno does not exist in dept table.');
END IF;
END;
/
-- TO execute DDL  in plsql
declare
emp1 varchar2(1000);
begin 
emp1 := 'create table rg94328784 as select * from emp';
EXECUTE IMMEDIATE emp1;
end;
                        