------------------------------------->PROGRAMS<-------------------------------------
--set serverout on;
declare
x number:=10;
y number:=9;
a number(2);
s number(2);
ma varchar2(10);
mi varchar2(10);
begin
a:=x+y;
s:=a/2;
select greatest(x,y) into ma from dual;
select least(x,y)  into mi from dual;
dbms_output.put_line('maximum_value = '||ma ||chr(10)||'minmum value = '||mi||chr(10)||a||chr(10)||s);
end;
/
--2 TYPES = 1.STATIC 2.DYNAMIC
----------1.STATIC PRGM-----------------------

--write a program to display the employee information of empID 7654?
DECLARE
 I_EMPNO  NUMBER;--NUMBER;
 I_ENAME  VARCHAR2(15);
 I_JOB    VARCHAR2(20);
 I_SAL    NUMBER(10);
 I_DEPTNO NUMBER(10);
BEGIN
 SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
    INTO I_EMPNO, I_ENAME, I_JOB, I_SAL, I_DEPTNO
       FROM EMP WHERE EMPNO=7654 ; --EMPNO=:IJ;
 DBMS_OUTPUT.PUT_LINE(' EMPNO = '||I_EMPNO);
 DBMS_OUTPUT.PUT_LINE(' ENAME = '||I_ENAME);
 DBMS_OUTPUT.PUT_LINE(' JOB   = '||I_JOB);
 DBMS_OUTPUT.PUT_LINE(' SAL   = '||I_SAL);
 DBMS_OUTPUT.PUT_LINE(' DEPTNO= '||I_DEPTNO);
END;

/

--Write a program to display number of CLERK from the EMP 
DECLARE
I_JOB   VARCHAR(15):='CLERK';
NO_EMP  INT;
BEGIN
  SELECT COUNT(*) INTO NO_EMP FROM EMP WHERE JOB=I_JOB;
DBMS_OUTPUT.PUT_LINE (I_JOB || NO_EMP);  --('NO OF CUSTOMR IN '||I_JOB||' = '||NO_EMP);
END;
--------------------------OR--------------------------------
DECLARE
I_JOB  VARCHAR(20);
BEGIN
SELECT COUNT(*) INTO I_JOB FROM EMP WHERE JOB='CLERK';
DBMS_OUTPUT.PUT_LINE(' NO. OF CLERK = '||I_JOB);
END;

/

SELECT * FROM cust_dtls;

/

--Write  a program to display number of male customers and number of female customers?
DECLARE
M_INFO  INT;
F_INFO  INT;
BEGIN
SELECT COUNT(*) INTO M_INFO FROM cust_dtls WHERE GENDER='M';
SELECT COUNT(*) INTO F_INFO FROM cust_dtls WHERE GENDER='F';
DBMS_OUTPUT.PUT_LINE(' NO. OF MALES = '||M_INFO);
DBMS_OUTPUT.PUT_LINE(' NO. OF FEMALES = '||F_INFO);
END;

/

--1) Write a program to display designition of empid 7788?
SELECT * FROM EMP;
DECLARE
I_EMPNO   INT:=7788;
I_ENAME   VARCHAR2(15);
I_JOB     VARCHAR2(15);
BEGIN
  SELECT EMPNO, ENAME, JOB INTO I_EMPNO, I_ENAME, I_JOB
    FROM EMP WHERE EMPNO=I_EMPNO;
DBMS_OUTPUT.PUT_LINE('EMPID = '||I_EMPNO||CHR(10)||'NAME = '||I_ENAME||CHR(10)||'DESIGNITION = '||I_JOB);
END;

/

--2) Write a program to display the city and mobile number of customer id " cust-5"?
SELECT * FROM cust_dtls; 
 DECLARE
  I_ID    VARCHAR(20):='CUST-5';
  I_CITY  VARCHAR2(20);
  I_MN    NUMBER;
BEGIN
  SELECT CUST_ID, CITY, MOBILE_NUM INTO I_ID, I_CITY, I_MN
      FROM <TABLE_NAME> WHERE CUST_ID=I_ID;
 DBMS_OUTPUT.PUT_LINE('CUSTOMER ID = '||I_ID);
 DBMS_OUTPUT.PUT_LINE('CITY = '||I_CITY);
 DBMS_OUTPUT.PUT_LINE('MOBILE NUMBER ='||I_MN);
END;

/

--3) Write a program to display the location of department " RESEARCH "?
SELECT * FROM DEPT;
 DECLARE
  I_DNAME  VARCHAR2(20);
  I_LOC    VARCHAR2(20);
 BEGIN
   SELECT DNAME, LOC INTO I_DNAME, I_LOC FROM DEPT
     WHERE DNAME='RESEARCH';
  DBMS_OUTPUT.PUT_LINE('D.NAME ='||I_DNAME||CHR(10)||'LOCATION ='||I_LOC);
 END;

/

---------------2.DYNAMIC PGRM--------------------------------

write a program to display the details of employee for the 
given empno?
DECLARE
 I_EMPNO  NUMBER;
 I_ENAME  VARCHAR2(20);
 I_JOB    VARCHAR2(20);
 I_SAL    NUMBER;
BEGIN
   I_EMPNO:='&I_EMPNO';   --IF WE USE PARAMETER AT LAST NO NEED TO WRITE THIS
  SELECT EMPNO, ENAME,JOB, SAL INTO I_EMPNO, I_ENAME, I_JOB, I_SAL
     FROM EMP WHERE EMPNO=I_EMPNO; --WHERE EMPNO=:JI; --WHERE EMPNO='&I_EMPNO'
 DBMS_OUTPUT.PUT_LINE('NUMBER ='||I_EMPNO);
 DBMS_OUTPUT.PUT_LINE('NAME ='||I_ENAME);
 DBMS_OUTPUT.PUT_LINE('JOB ='||I_JOB);
 DBMS_OUTPUT.PUT_LINE('SAL ='||I_SAL);
END;

/

--Write a program to display the number of emps in the given deptno?
DECLARE
 I_DEPTNO  NUMBER;
BEGIN
  SELECT COUNT(*) INTO I_DEPTNO FROM EMP WHERE DEPTNO=:I_DEPTNO;
 DBMS_OUTPUT.PUT_LINE('DEPTNO ='||I_DEPTNO);
END;
/
----------------------OR-------------------------
DECLARE
 I_DEPTNO  NUMBER;
 I_JI      INT;
BEGIN
   I_DEPTNO:='&DN';  --NO NEED OF GIVING IF WE GIVE PAR..
  SELECT  COUNT(EMPNO) INTO I_JI  FROM EMP WHERE DEPTNO=I_DEPTNO ;--WHERE DEPTNO=:I_DEPTNO;
 DBMS_OUTPUT.PUT_LINE('NO. OF DEPT '||I_DEPTNO||' = '||I_JI);
END;
/

DECLARE
I_CITY  VARCHAR2(10);
I_CTY  VARCHAR2(10);
BEGIN
 I_CITY:='&C';--Delhi(THIS FORMATE)
  SELECT COUNT(*) INTO I_CTY FROM cust_dtls WHERE CITY=I_CITY;
    DBMS_OUTPUT.PUT_LINE('LOC  '||I_CITY||' = '||I_CTY);
END;
/

DECLARE
I_EMPNO  IJ.EMPNO%TYPE;
I_ENAME  IJ.ENAME%TYPE;
BEGIN
SELECT EMPNO,ENAME INTO I_EMPNO,I_ENAME FROM IJ WHERE EMPNO=7566;
DBMS_OUTPUT.PUT_LINE('NUMBER ='||I_EMPNO||CHR(10)||'NAME ='||I_ENAME);
END;

/

declare
vempno emp.empno%type;
vename emp.ename%type;
vjob emp.job%type;
begin
select empno,ename,job into vempno,vename,vjob from emp where sal=8700;
dbms_output.put_line('empno: '||vempno||chr(10)||'ename: '||vename||chr(10)||'job: '||vjob);
end;
/
set serverout on;
        //
        declare
        va emp%rowtype;
        begin
        select * into va from emp where sal=4000;
        dbms_output.put_line('empno: '||va.empno||chr(10)||'ename: '||va.ename||chr(10)||'sal: '||va.sal);
        end;
        /
    declare
        type sa is record
        (vempno emp.empno%type,
        vename emp.ename%type,
        vjob emp.job%type
        );
        ijsa sa;
         begin
        select empno,ename,job into ijsa from emp where sal=4000;
        dbms_output.put_line('empno: '||ijsa.vempno||chr(10)||'ename: '||ijsa.vename||
        chr(10)||'job: '||ijsa.vjob);
        end;

/

DECLARE
VI  IJ%ROWTYPE;
BEGIN
SELECT * INTO VI FROM IJ WHERE EMPNO=7566;
DBMS_OUTPUT.PUT_LINE('EMPNO ='||VI.EMPNO||CHR(10)||'ENAME ='||VI.ENAME);
END;
/
------------OR---------------
DECLARE
VI  IJ%ROWTYPE;
BEGIN
SELECT EMPNO,ENAME INTO VI.EMPNO,VI.ENAME FROM IJ WHERE EMPNO=7566;
DBMS_OUTPUT.PUT_LINE('EMPNO ='||VI.EMPNO||CHR(10)||'ENAME ='||VI.ENAME);
END;
/
------------OR----------------
declare
vr  ij%rowtype;
V   SHA%ROWTYPE;
begin
 select E.EMPNO,E.ENAME,E.DEPTNO,D.DNAME  
  into vr.EMPNO,VR.ENAME,VR.DEPTNO,V.DNAME from IJ E,SHA D 
    where E.DEPTNO=D.DEPTNO AND  E.empno=7369;
dbms_output.put_line('empno: '||vr.empno||chr(10)||'ename: '||vr.ename||chr(10)||
'deptno: '||vr.deptno||CHR(10)||V.DNAME);
end;
/
DECLARE
TYPE IJ_TY IS RECORD 
(
 vempno   IJ.empno%type,
 vename   IJ.ename%type,
 VDEPTNO  IJ.DEPTNO%typE,
 VDNAME   SHA.DNAME%TYPE
 );
VR IJ_TY;
BEGIN
select E.EMPNO,E.ENAME,E.DEPTNO,D.DNAME into vr from IJ E,SHA D where E.DEPTNO=D.DEPTNO AND E.empno=7369;
dbms_output.put_line('empno: '||vr.Vempno||chr(10)||'ename: '||vr.Vename||chr(10)||
'deptno: '||vr.Vdeptno||CHR(10)||VR.VDNAME);
end;
/
DECLARE
TYPE IJ_TY IS RECORD 
(
 vempno   IJ.empno%type,
 vename   IJ.ename%type,
 VDEPTNO  IJ.DEPTNO%typE,
 VDNAME   SHA.DNAME%TYPE
);
VR IJ_TY;
VS NUMBER;
BEGIN
select E.EMPNO,E.ENAME,E.DEPTNO,D.DNAME into vr from IJ E,SHA D where E.DEPTNO=D.DEPTNO AND E.SAL=:VS;
dbms_output.put_line('empno: '||vr.Vempno||chr(10)||'ename: '||vr.Vename||chr(10)||
'deptno: '||vr.Vdeptno||CHR(10)||VR.VDNAME);
end;
/

create or replace procedure proc_ijs ( a number, b number)
is
ax ij%rowtype;
ji sha%rowtype;
begin
 select i.empno, i.ename, s.dname into ax.empno, ax.ename, ji.dname from ij i , sha s where i.empno=a 
 and i.deptno=b and i.deptno=s.deptno;
dbms_output.put_line('number ='||ax.empno||chr(10)||'name ='||ax.ename||chr(10)||'dname ='||ji.dname);
exception
when no_data_found then 
dbms_output.put_line(' check karle ');
end proc_ijs;
/
begin
proc_ijs (7566,20);
end;
/
create or replace procedure proc_ijs                                   --static
is
ax ij%rowtype;
ji sha%rowtype;
begin
 select i.empno, i.ename, s.dname into ax.empno, ax.ename, ji.dname from ij i , sha s where i.empno=7566
  and i.deptno=s.deptno;
dbms_output.put_line('number ='||ax.empno||chr(10)||'name ='||ax.ename||chr(10)||'dname ='||ji.dname);
exception
when no_data_found then 
dbms_output.put_line(' check karle ');
end proc_ijs;
/
exec proc_ijs;
/

create or replace procedure proc_ijs ( a in number, b  out number)      --dynamic
is
ax ij%rowtype;
ji sha%rowtype;
begin
 select i.empno, i.ename, s.dname,i.deptno into ax.empno, ax.ename, ji.dname,b from ij i , sha s 
 where i.empno=a and i.deptno=s.deptno;
dbms_output.put_line('number ='||ax.empno||chr(10)||'name ='||ax.ename||chr(10)||'dname ='||ji.dname);
end proc_ijs;

/
declare
b number;
begin
proc_ijs(7566,b);
dbms_output.put_line('Dept no = ' ||b);
end;
/
--Write a procedure to display the name,sal,job,hiredate,deptno for the given employee id?

create or replace procedure pro_i_j ( a number ) is
vij ij%rowtype;
begin
 select ename,sal,job,hiredate,deptno 
  into vij.ename,vij.sal,vij.job,vij.hiredate,vij.deptno from ij
    where empno=a;
dbms_output.put_line(' details of employee = ' ||a||chr(10)||
                     ' ename    = ' ||vij.ename||chr(10)||
                     ' sal      = ' ||vij.sal||chr(10)||
                     ' job      = ' ||vij.job||chr(10)||
                     ' hiredate = ' ||vij.hiredate||chr(10)||
                     ' deptno   = ' ||vij.deptno);
end pro_i_j;
/
exec pro_i_j(7369);
/
create or replace procedure pax1(a in out number,b out number) is
ax emp%rowtype;
begin 
select deptno,empno,ename into b,a,ax.ename from emp where empno=a;
dbms_output.put_line( ax.ename ||chr(10)|| a) ;
end;
/
declare
b number;
a number :=7369;
begin
pax1(a,b);
dbms_output.put_line( b );
end;
/
create or replace function fn_shas(a number, b number, op varchar2)      --functiond(sub program)
return number
is
begin
if op='+' then
return (a+b);
elsif op='-' then
return (a-b);
elsif op='*' then
return (a*b);
else
return(a/b);
end if;
end ;
/
select fn_shas(10,20,'/') from dual;
/
create or replace function fnc_shas(a number, b number)
return varchar2
is
vsa ij%rowtype;
begin
select ename,job,sal,hiredate into vsa.ename,vsa.job,vsa.sal,vsa.hiredate from ij 
  where deptno=a and empno=b;
return(vsa.sal);
end;
/
select fnc_shas(20,7369) from dual;
/
set serverout on;
/
---------------------------control structure-------------------------------
--1.conditional stmts

  ----if__then=
declare
va ij%rowtype;
begin
select empno,ename,sal into va.empno,va.ename,va.sal from ij where empno=7839;
if va.sal>3000 then
dbms_output.put_line(va.empno||' = '||va.ename|| ' salary is greater than 3000 and the present salary is  ' 
||va.sal);
end if;
end;
/
  ----if_then_else=
declare
va  ij%rowtype;
begin
select empno,ename,sal into va.empno,va.ename,va.sal from ij where empno=7785;
if va.sal >= 7000 then
dbms_output.put_line('empno: '||va.empno||' = '||va.ename||' sal is greater then and equal to 7000 and present sal is '
                             ||va.sal);
else
dbms_output.put_line('empno: '||va.empno||' = '||va.ename||' sal is less then 7000 and present sal is '||va.sal);
end if;
end;

  ----COMPOUND IF / Nested IF=
declare
va ij%rowtype;
begin
 select empno,ename,sal,comm into va.empno,va.ename,va.sal,va.comm from ij where empno=7839;
   if (va.sal>6000) then
      if va.comm is not null then
      dbms_output.put_line(va.ename||' sal is '||va.sal ||' comm is not null and sal is greater than 6000');
      else 
      dbms_output.put_line(va.ename||' sal is '||va.sal|| '  comm is  null');
      end if;
   dbms_output.put_line(va.ename||' sal is '||va.sal|| ' sal is greater than 6000');
   else
   dbms_output.put_line(va.ename||' sal is '||va.sal|| ' sal is less than 6000');
   end if;
end; 
/
declare
 va  ij%rowtype;
  begin
   select empno,ename,sal,comm,mgr into va.empno,va.ename,va.sal,va.comm,va.mgr from ij where empno=7839 ;
     if va.sal >= 4000 and va.sal <= 6500 then
       if va.comm is null then
         if va.mgr is null then
         dbms_output.put_line(va.ename||' mgr is  null ');
         else
         dbms_output.put_line(va.ename||' mgr is not null ');
         end if;
       dbms_output.put_line(va.ename||' comm is null ');
       else
       dbms_output.put_line(va.ename||'comm is not null ');
       end if;
     dbms_output.put_line(va.ename||' sal is in b/w 4000 to 6500 and actual sal is '||va.sal);
     else
     dbms_output.put_line(va.ename||' sal is not in b/w 4000 to 6500 and actual sal is '||va.sal);
     end if;
  end;
/
-- ELSIF LADDER

declare
 va  ij%rowtype;
  begin
   select empno,ename,sal into va.empno,va.ename,va.sal from ij where empno=7839 ;
     if va.sal >= 5000 and va.sal <= 6500 then
     dbms_output.put_line(va.ename||' sal is in b/w 4000 to 6500 and actual sal is '||va.sal);
       elsif va.sal >= 6501 and va.sal <= 8500 then
       dbms_output.put_line(va.ename||' sal is in b/w 6501 to 8500 and actual sal is '||va.sal);
       elsif va.sal >= 8501 and va.sal <= 10500 then
       dbms_output.put_line(va.ename||' sal is in b/w 8501 to 10500 and actual sal is '||va.sal);
       else
       dbms_output.put_line(va.ename||' sal is less than 5000 and actual sal is '||va.sal);
     end if;
  end;
/
Declare
Va  Ij%Rowtype;
  Begin
   Select Empno,Ename,Sal Into Va.Empno,Va.Ename,Va.Sal From Ij Where Empno=7785;
   If Va.Sal Between 3900 And  5000 Then
   Dbms_Output.Put_Line(Va.Empno||' = '||Va.Ename||' sal is greater then and equal to 5000 and present sal is '||Va.Sal||' low');
   Elsif Va.Sal Between 5001 And 6500 Then
   Dbms_Output.Put_Line(Va.Empno||' = '||Va.Ename||' sal is greater then 6500 and present sal is '||Va.Sal||' medium');
   Elsif Va.Sal Between 6501 And 7500 Then
   Dbms_Output.Put_Line(Va.Empno||' = '||Va.Ename||' sal is greater then 7500 and present sal is '||Va.Sal||' beyond  medium');
   Else
   Dbms_Output.Put_Line(Va.Empno||' = '||Va.Ename||' sal is greater then 10000 and present sal is '||Va.Sal||' high');
  End If;
 End;

/
--------------loops------------
--1) simple loop
--2) for    loop
--3) while  loop
--------->(1)simple loop<---------

declare
a number:=0;
begin
loop
a:=a+1;
dbms_output.put_line(a);
exit when a>=10;
end loop;
end;
/
declare
a number:=0;
b number;
begin
loop
a:=a+1;
b:=9*a;
dbms_output.put_line('9 ' ||'* ' || a||' = '||b);
exit when a>=10;
end loop;
end;
/
declare
va ij%rowtype;
begin
loop
select ename,sal,job into va.ename,va.sal,va.job from ij where empno=7839;
dbms_output.put_line(va.ename||' sal is '||va.sal||' and job is '||va.job);
exit when va.sal<7000;
end loop;
end;
/
declare
va  ij%rowtype;
begin
select ename,job,sal into va.ename,va.job,va.sal from ij where empno=7788 ;
loop
dbms_output.put_line(va.ename||' job '||va.job||' salary '||va.sal);
exit when va.sal>6000;
end loop;
end;
/
--------->for loop<---------
declare
b number;
begin
for r in 1..10
loop
b:=9*r;
dbms_output.put_line('9 ' ||'* ' || r||' = '||b);
end loop;
end;
/
begin
for r in reverse 5..10
loop
dbms_output.put_line(r);
end loop;
end;
/
DECLARE
begin
for r in (select * from ij where sal>8000)
loop
dbms_output.put_line(r.ename||'  '||r.empno||'  '||r.sal );
end loop;
end;
/
DECLARE
begin
for r in (SELECT Empno,ename,ROUND((SYSDATE-HIREDATE)/365) EXP FROM EMP  WHERE EMPNO IN (SELECT MGR FROM EMP))
loop
dbms_output.put_line(r.ename||'  '||r.empno||'   ' ||r.exp);
end loop;
end;
/
------>while loop<------

declare
a number:=0;
begin
while a<10 loop
a:=a+1;
dbms_output.put_line(a);
end loop;
end;
/
declare
a number:=0;
b number;
begin
while a<10 
loop
a:=a+1;
b:=9*a;
dbms_output.put_line('9 ' ||'* ' || a||' = '||b);
end loop;
end;
/
declare
a number:=2;
b number;
begin
while a<20
loop
a:=a+3;
b:=5*a;
dbms_output.put_line(a||'  '||b);
end loop;
end;
/

----------->case statement<-----------

declare
grade varchar2(20);
begin
grade:=:s;
case grade
when 'a' then
dbms_output.put_line('excellent');
when 'b' then
dbms_output.put_line('very good');
when 'c' then
dbms_output.put_line('good');
when 'd' then
dbms_output.put_line('ok');
when 'e' then
dbms_output.put_line('fair');
end case;
end;
/
declare
va ij%rowtype;
begin
select empno,ename,job,sal into va.empno,va.ename,va.job,va.sal from ij where empno=7788;
case 
when va.sal>=4000 and va.sal<=6000 then
dbms_output.put_line(va.ename||' sal is '||va.sal|| ' and sal range between 4000 to 6000');
when va.sal>=6001 and va.sal<=8000 then
dbms_output.put_line(va.ename||' sal is '||va.sal|| ' and sal range between  6001 to 8000');
when va.sal>=8001 and va.sal<=10000 then
dbms_output.put_line(va.ename||' sal is '||va.sal|| ' and sal range between 8001 to 10000');
end case;
end;
/

----------------------CURSORS-----------------------
--2 TYPES( implicit , explicit )
--------------------->explicit => (a)cursor_varable
                                --(b)for_loop
                                --(c)parametric 
                                --(d)ref curser 

----->(1)implicit cursor*****

syntax :=
*******
declare
<varble 1>  <table_name>%rowtype;
<varvle 2>  <table_name>.<column_name>%type;
begin
sql query;
if sql%notfound then                                      --1st condition
<dbms_output>(<varble 1>.<column_name>||'not found');
elsif sql%found then                                      --2nd condition
<dbms_output>(<varble 1>.<column_name>||'found');
<varble 2>:=sql%rowcount;                                 --3rd condition
<dbms_output>(<varble 2>||' rows are counted ');
end if;
end; 
/
declare
va   ij.empno%type;
varl ij%rowtype;
begin
select deptno,empno into varl.deptno,varl.empno from ij where empno=7566; 
if sql%notfound  then
dbms_output.put_line(varl.deptno||' no deptno exists '||varl.empno);
elsif sql%found  then
dbms_output.put_line(varl.deptno||' is the deptno of '||varl.empno);
va:=SQL%ROWCOUNT;
dbms_output.put_line(va||' rows are counted');
end if;
end;
/
declare
ve ij.empno%type;
begin
delete from ij where empno=<empno> ;
if sql%notfound then
dbms_output.put_line(' not found');
elsif sql%found then
dbms_output.put_line(' deleted');
ve:=sql%rowcount;
dbms_output.put_line(ve||' is effected records in ij table');
end if;
end;
/
declare
ve ij.empno%type;
begin
update ij set comm=100 where deptno=30;
if sql%notfound then
dbms_output.put_line('deptno=30 is not updated');
elsif sql%found then
dbms_output.put_line('deptno=30 is  updated');
ve:=sql%rowcount;
dbms_output.put_line(ve||' is effected records in ij table');
end if;
end;
/

----->(2)explicit cursor*****

syntax :=
*******
declare
cursor <cursor_name> is sql stmt;
<varble> <table_name>%rowtype;
--ve ij.empno%type;
begin
open <cur_name>;
loop
fetch <cur_name> into variable_name.column_name;
exit when cur_name%notfound;
<output stmt>;
--ve:=<cus_name>%rowcount;
--dbms_output.put_line(ve||' records effected');
end loop;
close <cur_name>;
end;
/

declare
cursor cr is select empno,ename,sal,job from emp ;  --(or)--where empno=7369;
va  emp%rowtype;
begin
open cr;
loop
fetch cr into va.empno,va.ename,va.sal,va.job;
exit when cr%notfound;
dbms_output.put_line('empno = '||va.empno||chr(10)||
                     'ename = '||va.ename||chr(10)||
                     'sal   = '|| va.sal ||chr(10)||
                     'job   = '|| va.job);
end loop;
close cr;
end;
/
declare
cursor cr is select * from ij;
va  ij%rowtype;
ve  ij.empno%type;
begin
open cr;
loop
fetch cr into va;
exit when cr%notfound;
dbms_output.put_line('empno = '||va.empno||chr(10)||
                     'ename = '||va.ename||chr(10)||
                     'sal   = '|| va.sal ||chr(10)||
                     'job   = '|| va.job);
end loop;
close cr;
end;
/

----->(a)cursor_varable*****

syntax :=
*******
declare
cursor <cur_name> is sql query;
<varble> <cur_name>%rowtype;
begin
open <cur_name>;
loop
fetch <cur_name> into <varble>.<columns_names>;
exit when <cur_name>%notfound;
<dbms_output>;
end loop;
close <cur_name>;
end;
/
declare
cursor c2 is select * from ij where deptno=30;
vr c2%rowtype;
begin
open c2;
loop
fetch c2 into vr;
exit when c2%notfound;
dbms_output.put_line('empno = '||vr.empno||chr(10)||
                     'ename = '||vr.ename||chr(10)||
                     'sal   = '|| vr.sal ||chr(10)||
                     'job   = '|| vr.job);
end loop;
close c2;
end;
/
declare
cursor c3 is select dname,loc,deptno from sha;
vr  sha%rowtype;
begin
open c3;
loop
fetch c3 into vr.dname,vr.loc,vr.deptno;
exit when c3%notfound;
dbms_output.put_line(vr.dname||'  =>  '||vr.loc||'  =>  '||vr.deptno);
end loop;
close c3;
end;
/

----->(b)for_loop cursor*****

syntax :=
*******
declare
cursor <cur_name> is sql query;
begin
for <varble> in <cur_name>
loop
<dbms_output>;
end loop;
end;
/
declare
cursor c1 is select empno,ename,job from ij;
begin
for S in c1
loop
dbms_output.put_line('empno '||S.empno||' '||'ename '||S.ename||' '||'job '||S.job);
end loop;
end;
/
declare
cursor c1 is select * from sha;
begin
for A in c1
loop
dbms_output.put_line('dname '||A.dname||' '||'loc '||A.loc||' '||'deptno '||A.deptno);
end loop;
end;
/

----->(c)parametric cursor*****

syntax :=
*******
declare
cursor <cur_name> (<varble 1>  <table_name>.<column_name>%type) is sql query; --<where <colm_nm>=<varble 1>;
<varble 2>  <table_name>%rowtype;
--<varble 3>  <table_name>.<column_name>%type;
begin
open <cur_name> (<:varble 1 parameter>);
loop
fetch <cur_name> into <varble 2>;
exit when <cur_name>%notfound;
<dbmd_stmts>; --(<varble 2>.<column_name>);
end loop;
--<varble 3>:=<cur_name>%rowcount;
--<dbms_stmts>(' no. of rows '||<varble 3>);
close <cur_name>;
end;
/
declare
cursor c1(vi ij.empno%type) is select * from ij where empno=vi;
vij  ij%rowtype;
begin
open c1 (:vi);  -->(or direct empno no.);
loop
fetch c1 into vij;
exit when c1%notfound;
dbms_output.put_line('empno '||vij.empno||' ename '||vij.ename||' job '||vij.job);
end loop;
close c1;
end;
/
declare
cursor c1(vi ij.deptno%type) is select * from ij where deptno=vi;
vij  ij%rowtype;
ji   ij.empno%type;
begin
open c1 (30);
loop
fetch c1 into vij;
exit when c1%notfound;
dbms_output.put_line('empno '||vij.empno||' ename '||vij.ename||' job '||vij.job);
end loop;
ji:=c1%rowcount;
dbms_output.put_line('no. of rows '||ji);
close c1;
end;
/
declare
cursor c3(va ij.sal%type) is select * from ij where sal<va;
begin
for s in c3(7000)
loop
dbms_output.put_line('empno '||S.empno||' '||'ename '||S.ename||' '||'job '||S.job||chr(10)||'sal= '||s.sal);
end loop;
end;
/

----->(d)ref cursor*****

syntax :=
*******
declare
type <type_name> is ref cursor;
<cursor_name> <type_name>;
<variable> <table_name>%rowtype;
begin
open <cursor_name> for <sql query>;
loop
fetch <cursor_name> into <variable_name.column_names>;
exit when <cursor_name>%notfound;
<output_stmt>;
end loop;
close <cursor_name>;
end;
/
declare
type ty_pe is ref cursor;
c1 ty_pe;
ve ij%rowtype;
begin
open c1 for select * from ij where empno=7369;
loop
fetch c1 into ve;
exit when c1%notfound;
dbms_output.put_line('empno '||ve.empno||' '||'ename '||ve.ename);
end loop;
close c1;
end;
/
declare
type ty_pe is ref cursor;
c1 ty_pe;
ve ij%rowtype;
va ij.empno%type;
begin
open c1 for select * from ij;
loop
fetch c1 into ve;
exit when c1%notfound;
dbms_output.put_line('empno '||ve.empno||' '||'ename '||ve.ename);
end loop;
va:=c1%rowcount;
dbms_output.put_line(va);
close c1;
end;
/
declare
type ty_pe is ref cursor;
c1 ty_pe;
ve ij%rowtype;
vz sha%rowtype;
va ij.empn  o%type;
begin
open c1 for select * from ij;
loop
fetch c1 into ve;
exit when c1%notfound;
dbms_output.put_line('empno '||ve.empno||' '||'ename '||ve.ename);
end loop;
va:=c1%rowcount;
dbms_output.put_line(va ||' rows are from ij');
close c1;
open c1 for select * from sha;
loop
fetch c1 into vz;
exit when c1%notfound;
dbms_output.put_line('deptno '||vz.deptno||' '||'dname '||vz.dname);
end loop;
close c1;
end;
/
---------------->EXCEPTIONS<-----------------
--2 TYPES=(A)PRE-DEFINED-EXEC
        --(B)USER-DEFINE-EXEC

----1.PRE-DEFINED-EXEC=

create or replace procedure pr_sd
(a number)
as
v IJ%rowtype;
begin
select empno,ename,job,sal,deptno into v.empno,v.ename,v.job,v.sal,v.deptno from IJ where sal=a;
dbms_output.put_line ('empno: '||v.empno||chr(10)||'ename: '||v.ename||chr(10)||'job: '||v.job||chr(10)||'sal: '||v.sal||chr(10)||'deptno: '||v.deptno);
exception
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE(' SAL is High');
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No emp Getting this salary');
WHEN zero_divide THEN
DBMS_OUTPUT.PUT_LINE(' Value not find');
end pr_sd;
/
exec pr_sd (7900)

----2.USER-DEFINE-EXEC
declare
vr  ij%rowtype;
ex exception;
begin
select empno,ename,sal into vr.empno,vr.ename,vr.sal from ij where empno=7839; 
if vr.sal>5000 then --king sal is 4000
dbms_OUTPUT.PUT_LINE('sal is greater than 5000');
else
raise ex;
end if;
exception
when ex then
dbms_OUTPUT.PUT_LINE('sal is less than 5000');
end;
/
create or replace procedure pr_sd2(a number)
as
v IJ%rowtype;
e_n exception;
begin
select empno,ename,job,sal,deptno into v.empno,v.ename,v.job,v.sal,v.deptno from IJ where sal=a;
if v.sal>a then 
raise e_n;
else
dbms_output.put_line ('empno: '||v.empno||chr(10)||'ename: '||v.ename||chr(10)||'job: '||v.job||chr(10)||'sal: '||v.sal||chr(10)||'deptno: '||v.deptno);
end if;
exception
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE(' SAL is High');
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No emp Getting this salary');
end pr_sd2;

/
exec pr_sd2 (7900)
/
create or replace procedure de_sam (a varchar2)
as
vr IJ%rowtype;
sam_ex exception;
pragma exception_init(sam_ex,-02292);
begin
delete from IJ where ename=a;
exception
when sam_ex then
dbms_output.put_line(' Dont delete ename');
when no_data_found then
dbms_output.put_line(' ename is not valid');
end de_sam;

/
exec de_sam('SMITH')
/
create or replace procedure pr_s (ve IJ.empno%type)
as
vr IJ%rowtype;
e_n exception;
pragma exception_init(e_n,-02909);
begin
select comm into vr.comm from IJ where empno=ve;
dbms_output.put_line(vr.comm);
exception
when e_n then
dbms_output.put_line('Decline');
when no_data_found then
dbms_output.put_line('Data not found');
end pr_s;
/
exec pr_s(6343)
/
select * from IJ;
/
create or replace procedure pr_ss (ve IJ.empno%type)
as
vr IJ%rowtype;
begin
select sal into vr.sal from IJ where empno=ve;
if vr.sal<5000 or vr.sal>8000 then
raise_application_error(-20416,'DECLINE please enter valid amount min 5000  and max 8000');
end if;
dbms_output.put_line(vr.sal);
end pr_ss;
/
exec pr_ss(7839);
/

---------------->PACKAGES<-------------------
-- PACKAGES ARE 2 PARTS =(A)package specification
                       --(B)package body

--package specification
create or replace package pck_ij is
procedure pr_ijs1 (a number);
procedure pr_ijs2( b number);
function fn_ijs3 (c varchar2)
return varchar2;
end pck_ij;
/
--package body
create or replace package body pck_ij is

procedure pr_ijs1 (a number)
is
vr ij%rowtype;
ex exception;
begin
select empno,ename,comm into vr.empno,vr.ename,vr.comm from ij where empno=a;
if vr.comm is null then
dbms_output.put_line(vr.ename|| ' - '||'comm is null');
else
raise ex;
end if;
exception
when ex then
dbms_output.put_line(vr.ename|| ' - '||'comm is not null');
end pr_ijs1;
procedure pr_ijs2 (b number)
is
va sha%rowtype;
begin
select deptno,dname,loc into va.deptno,va.dname,va.loc from sha where deptno=b;
if va.dname='RESEARCH' then
if va.loc='BOSTON' then
dbms_output.put_line(vA.LOC|| ' - '||'LOCATION IS BoSTON');
else
dbms_output.put_line(vA.LOC|| ' - '||'LOCATION IS not BoSTON');
end if;
dbms_output.put_line(vA.dname|| ' - '||'dname IS RESEARCH');
else
dbms_output.put_line(vA.dname|| ' - '||'dname IS not RESEARCH');
end if;
end pr_ijs2;
function fn_ijs3 (c varchar2)
return varchar2
is
vf ij%rowtype;
begin
select empno,ename,job into vf.empno,vf.ename,vf.job from ij where ename=c;
return (vf.job);
end fn_ijs3;
end pck_ij;
/
exec pck_ij.pr_ijs1(7788);
/
exec pck_ij.pr_ijs2(20);
/
select pck_ij.fn_ijs3('SMITH') from dual;

/
---------------->TRIGGERS<-------------------
--set serverout on;
SELECT * FROM IJS;
/
--SYNTAX TRIGGER
CREATE OR REPLACE TRIGGER <TRIGEGR_NAME> BEFORE/AFTER
INSERT OR UPDATE OR DELETE ON <TABLE_NAME>
FOR EACH ROW
ENABLE --OPTIONAL
DECLARE
<VARIABLE_STATEMENT> --VA IJ%ROWTYPE;
BEGIN
IF INSERTING THEN --IF INSERTING THEN
<SQL_STATEMENTS(DDL,DML)> OR <EXCEPTIONS_STMTS> --RAISE_APPLICATION_ERROR(-20145,'CANNOT INSERT');
ELSIF UPDATING THEN
<SQL_STMT(DDL,DML)>  OR <EXCEPTIONS_STMTS>
ELSIF DELETING THEN
<SQL_STMT(DDL,DML)>  OR <EXCEPTIONS_STMTS>
END IF;
END <TR_NAME>;
/
CREATE OR REPLACE TRIGGER TR_IJSS BEFORE
INSERT OR UPDATE OR DELETE ON IJS
FOR EACH ROW
BEGIN
IF INSERTING THEN
RAISE_APPLICATION_ERROR(-20145,'CANNOT INSERT');
ELSIF DELETING THEN
RAISE_APPLICATION_ERROR(-20954,'CANNOT DELETE');
ELSIF UPDATING THEN
RAISE_APPLICATION_ERROR(-20654,'CANNOT UPDATE');
END IF;
END;
/
DELETE FROM IJS WHERE DEPTNO=30;
SELECT * FROM IJS;
/
CREATE OR REPLACE  TRIGGER TR_IJSS BEFORE
DELETE ON IJS
FOR EACH ROW
BEGIN
IF TO_CHAR(SYSDATE,'HH24:MI') BETWEEN '11:00AM' AND '17:49PM' THEN
RAISE_APPLICATION_ERROR(-20234,'CANNOT DELETE');
END IF;
END TR_IJSS;
/
UPDATE IJS SET SAL=5454;
/
CREATE OR REPLACE  TRIGGER TR_IJSS BEFORE
UPDATE ON IJS
FOR EACH ROW
BEGIN
IF TO_CHAR(SYSDATE,'HH24:MI') BETWEEN '11:00AM' AND '20:30PM' THEN
RAISE_APPLICATION_ERROR(-20234,'CANNOT UPDATED');
END IF;
END TR_IJSS;
/
INSERT INTO IJS (EMPNO,ENAME,JOB) VALUES (1244,'IJ','MANAGER');
/
CREATE OR REPLACE  TRIGGER TR_IJSS BEFORE
INSERT ON IJS
FOR EACH ROW
BEGIN
IF TO_CHAR(SYSDATE,'HH24:MI') BETWEEN '11:00AM' AND '20:30PM' THEN
RAISE_APPLICATION_ERROR(-20234,'CANNOT INSERTED');
END IF;
END TR_IJSS;
/
ALTER TRIGGER TR_IJSS DISABLE;

/
CREATE OR REPLACE  TRIGGER TR_IJSS AFTER
DELETE ON IJS
FOR EACH ROW
BEGIN
IF DELETING THEN
DBMS_OUTPUT.PUT_LINE('RECORD DELETED');
END IF;
END TR_IJSS;
/
CREATE TABLE SHAIJ (NEW_ENAME	VARCHAR2(21),
OLD_ENAME	VARCHAR2(20),
UPDATED_SAL	VARCHAR2(20),
LAST_UPDATED_DATE	VARCHAR2(20),
LAST_UPDATES_HIREDATE	VARCHAR2(30),
OPERATIONSS	VARCHAR2(20));
/
SELECT * FROM SHAIJ;
DELETE FROM SHAIJ
/
CREATE OR REPLACE TRIGGER TR_IJ_SHA BEFORE UPDATE OR DELETE OR INSERT
ON IJS 
FOR EACH ROW
ENABLE
DECLARE
V_DATE DATE;
BEGIN
SELECT SYSDATE INTO V_DATE FROM DUAL;
IF INSERTING THEN
INSERT INTO SHAIJ (NEW_ENAME,OLD_ENAME,UPDATED_SAL,LAST_UPDATED_DATE,LAST_UPDATES_HIREDATE,OPERATIONSS) VALUES(:NEW.ENAME,NULL,:NEW.SAL,V_DATE,:NEW.HIREDATE,'INSERTING');
ELSIF UPDATING THEN
INSERT INTO SHAIJ (NEW_ENAME,OLD_ENAME,UPDATED_SAL,LAST_UPDATED_DATE,LAST_UPDATES_HIREDATE,OPERATIONSS) VALUES(:NEW.ENAME,:OLD.ENAME,:NEW.SAL,V_DATE,:NEW.HIREDATE,'UPDATING');
ELSIF DELETING THEN
INSERT INTO SHAIJ (NEW_ENAME,OLD_ENAME,UPDATED_SAL,LAST_UPDATED_DATE,LAST_UPDATES_HIREDATE,OPERATIONSS) VALUES(NULL,:OLD.ENAME,:NEW.SAL,V_DATE,:NEW.HIREDATE,'DELETING');
END IF;
END TR_IJ_SHA;
/
INSERT INTO IJS (EMPNO,ENAME,JOB) VALUES (1244,'IJ','MANAGER');
/
DELETE FROM IJS WHERE ENAME='IJ';
/
UPDATE IJS SET SAL=5454 WHERE EMPNO=1244;
/
ALTER TRIGGER TR_IJ_SHA DISABLE;
/
SELECT * FROM SHAIJ;
/
SELECT * FROM IJ;
/
SELECT * FROM IJS;
/
select * from tu;
/
create or replace trigger tr_sammy9 before insert or update or delete
on syee 
for each row
begin
if inserting then
insert into tu (empno,ename,job,mgr,hiredate,sal,comm,deptno) values (:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
elsif deleting then
delete from tu where empno=:old.empno ;
update tu set empno=:new.empno,ename=:new.empno,job=:new.job,mgr=:new.mgr,hiredate=:new.hiredate,sal=:new.sal,comm=:new.comm,deptno=:new.deptno where ename=:old.ename and empno=:old.empno and sal=:old.sal and mgr=:old.mgr and hiredate=
:old.hiredate and comm=:old.comm and deptno=:old.deptno;
end if;
end tr_sammy10;
/
delete from syee where ename='ISHAQ'
/
update syee set ename='SAMMMI' where ename='ISHAQ'
/
insert into syee values(7845,'ISHAQ','CLERK',7839,'22-FEB-81',5861,254,30);
/
alter trigger tr_sammy10 disable
/
select * from syee
/
select * from tu;
/
delete sfrom syee where comm=254
/
update syee set empno=nvl(7369,empno) where ename='SMITH'
/

