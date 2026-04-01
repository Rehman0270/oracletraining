--=============sql===========================

--How to find duplicate records with the number they are duplicated?
select job,count(*) from emp group by job;

--Write a Query to select to the Nth highest salary from a table?
select min(sal) from (select  sal from emp order by sal desc) where rownum < 3;  

--Can Dual table be deleted or dropped or altered or inserted?
select round(123.45) from dual; --it cant be deleted or dropped or altered or inserted

--List the emps in dept 20 whose sal is > the avg sal of deptno 10 emps?
select * from emp where deptno = 20  and sal>(select avg(sal)from emp where deptno = 10);

--List the empno, ename, sal, dname of all the 'Mgrs' and 'Analyst' working in NEWYORK,
--DALLAS with an exp more than 7 years without receiving the Comma Asc order of Loc?

select empno,ename,sal,dname from emp,dept where emp.deptno= dept.deptno and  loc in('NEWYORK', 'DALLAS')
and job in ('manager','analyst')and trunc(months_between(sysdate,hiredate)/12)>7 and comm is null order by loc;

--Find out the emps who joined in the company before their managers?
select * from emp where hiredate <ALL(select hiredate from  emp where job = 'MANAGER');
SELECT DISTINCT e.empno FROM emp e INNER JOIN emp m ON e.Mgr = m.empno AND e.hiredatr < m.hiredate;

-- List the emps who are working for dept 10 or 20 with designation as CLERK or analyst with a sal is
--either 3 or 4 digits with an exp > 8y, but not belongs to months of MAR, APR & SEP and
--working for mgrs & no is not ending with 88 or 56?

select * from emp where deptno in (10,20) and job in('CLERK','analyst')and length(sal) in (3,4)
and trunc(months_between(sysdate,hiredate)/12)>8 and to_char(hiredate,'mon') not in ('MAR','APR','SEP') and 
(mgr not like '%88' and mgr not like '%56');

-- List the managers name who is having max no of emps working under him
select * from emp where empno = (select mgr from emp group by mgr having count(*) = (select max(count(*)) from emp group by mgr)) ; 

--to find how many  duplicate values
--select(column_name),count(*) from emp group by(column_name) having count()>1;
select job, count(*) from emp group by job ;

--find out  employees who joined in the comany before manager 
select min(hiredate) from emp where job = 'MANAGER';
select * from emp where hiredate <all(select hiredate from emp where job = 'MANAGER');

-- nth  highest salary and 1st, 2nd, 3rd salaries
select sal from emp  order by sal desc;
SELECT max(sal) from emp;
select sal from emp where sal=(select max(sal) from emp );--1st highest salary
select sal from emp where sal =(select max(sal) from emp where sal<(select max(sal) from emp));-- 2nd highest salary

--3rd highest salary
SELECT sal from emp where sal=(select max(sal) from emp where sal <(select max(sal) from emp where sal<(select max(sal) from emp)));

--to remove duplicate values from a table
SELECT DISTINCT mgr FROM emp;
SELECT job FROM emp GROUP BY job;

-- display the details of the most senior employye who belongs to 1981
select * from emp where hiredate =(select min(hiredate) from emp where to_char(hiredate,'yyyy')='1981');

--list the employes who joined in 1981 with same job
select * from emp  where to_char(hiredate,'yyyy')=1981;

--List the employee names and his average salary department wise.
select ename,sal,deptno, sal/2 avg_sal from emp order by deptno asc;
select ename,sal,(sal+1)/2 avg_sal,deptno from emp order by deptno asc;

--list the employee with exp and dailysal >100 
select empno,ename,job,hiredate,trunc((sysdate-hiredate)/365) exp, round(sal/30) dailysal  from emp where sal in (select sal from emp where dailysal >100);


select * from emp where hiredate in(select max(hiredate) from emp group by  deptno)  order by hiredate;

--15
select * from emp where to_char(hiredate,'mm')=01 and sal between 1500 and 4000;





-- ========================plsql============================

set serveroutput on;

-- no of vowles and consonants in a word
DECLARE   
    
    v              VARCHAR2(400) := 'Ramesh is a Geek'; 
    noofvowels     NUMBER := 0; 
    noofconsonants NUMBER := 0; 
    C              CHAR; 
BEGIN 
    FOR i IN 1..Length(v) LOOP 
        c := Substr(v, i, 1); 
  
          IF c IN ( 'A', 'E', 'I', 'O', 'U' ) 
            OR c IN ( 'a', 'e', 'i', 'o', 'u' ) THEN 
          noofvowels := noofvowels + 1; 
        
        ELSE 
          IF c NOT IN ( ' ' ) THEN 
            noofconsonants := noofconsonants + 1; 
            
          END IF; 
        END IF; 
    END LOOP; 
    dbms_output.Put_line('No. of Vowels: ' 
                         || noofvowels); 
            dbms_output.Put_line('No. of Consonants: ' 
                         || noofconsonants); 
  
END; 
/ 

--  odd/even  total  numbers 
DECLARE
ODD  NUMBER:=0;
BEGIN
    FOR I IN 1..100 LOOP
    IF MOD(I,2)!=0 THEN
    ODD:=ODD+I;
            DBMS_OUTPUT.PUT_LINE(I);-- ODD NUMBERS
    END IF;
    END LOOP;
                DBMS_OUTPUT.PUT_LINE(odd);--SUM
    END;  
/  

-- find a leap year and specific day in that month

 DECLARE
  year  NUMBER := &year;
BEGIN
  IF MOD(year, 4)=0 and
    MOD(year, 100)!=0 or
    MOD(year, 400)=0 THEN
    dbms_output.Put_line(year || ' is a leap year ');
  ELSE
    dbms_output.Put_line(year || ' is not a leap year.');
  END IF;
END; 

/

---14--display all the numbers whose sum of digits is 9 from 1 to 9999---  
 DECLARE
N   NUMBER;
SUM1 NUMBER;
M    NUMBER;
BEGIN
N:=9999;
FOR J IN 1..N LOOP
SUM1:=0;
FOR I IN 1..LENGTH(J) LOOP
M:=SUBSTR(J,I,1);
SUM1:=SUM1+M;
END LOOP;
IF(SUM1=9) THEN
DBMS_OUTPUT.PUT_LINE(J);
END IF;
END LOOP;               
END; 
/
--WAP to calculate the sum of 1!+2!+......+n!
declare
n number:=&n;
s number:=1;
f number:=1;
begin
 for i in 1..n loop
 for j in 1..i loop
 f:=f*j;
 end loop;
 s:=s+f;
 end loop;
 dbms_output.put_line('sum of fact is '||s);
 end;
 /
 --What is the difference between OPEN-FETCH-CLOSE and FOR LOOP in CURSORS?
 So with open fetch you can use dynamic cursors but with for loop you can define normal cursor without declaration.
 /
 --Write a program to accept a number and find out the sum of first and last digits?
 
     DECLARE 
    a number := &a; 
    b number := 0; 
    C number := 0; 
    s number; 
BEGIN 
    IF a > 9 THEN 
      c := Substr(a, 1, 1); 
  
      b := Substr(a, Length(a), 1); 
  
      s := b + c; 
    ELSE 
      s := a; 
    END IF; 
  
    dbms_output.Put_line('Sum of the first and last digit is ' ||s); 
END; 
/
--Write a program to accept the annual income of the emp and find the income tax
--i) If the annual > 60000 then tax is 10% of income
--ii) If the annual > 100000 then tax is Rs 800+16% of income
--iii) If the annual > 140000 then tax is Rs 2500+25% of income

DECLARE
    CURSOR income IS SELECT ename,sal,sal*12 ann_sal FROM emp;
    z income%rowtype;
    ann_sal NUMBER(8,2);
    tax     NUMBER(8,2);
BEGIN
    OPEN income;
    LOOP
        FETCH income INTO z;
        EXIT
    WHEN income%notfound;
        IF ann_sal>60000 THEN
            tax  :=ann_sal*10/100;
        elsif ann_sal>100000 THEN
            tax     :=800+ann_sal*16/100;
        elsif ann_sal>140000 THEN
            tax     :=2500+ann_sal*25/100;
        ELSE
            tax:='';
        END IF;
        dbms_output.put_line(z.ename || '  ' || z.sal || ' ' ||z.ann_sal|| '  ' || z.tax);
    END LOOP;
    CLOSE income;
END;
/
--Write a program to print the following series
--1
--21
--321
--4321
--54321

declare 
v varchar2(100);
begin 
for i in 1..5 loop
for j in 1..i loop
--for j in reverse 1..i loop
v:=v||''||j;
end loop;
dbms_output.put_line(v);
v:=null;
end loop;
end;
/

----------------------------MULTIPLICATION -------------

-- 8.plsql

declare
var1        number:=0;
var2        number;
v_res        number;

begin
for i in 1..10 loop
    var1:=var1+1;
    var2:=5*var1;
    v_res:=var2;
    dbms_output.put_line(5 || ' x ' ||var1|| ' = '||v_res);
    exit when var1=10;
    end loop;
    end;
    /
    
----------------------
--Find the factorials of numbers from 1 to 10
DECLARE
FACT NUMBER:=1;
V VARCHAR2(100);
BEGIN
FOR I IN 1..10
LOOP
FOR J IN 1..I
LOOP
FACT:=FACT*J;
V:=J||'*'||V;
END LOOP;
DBMS_OUTPUT.PUT_LINE(RTRIM(V,'*')||'='||FACT);
FACT:=1;
V:=NULL;
END LOOP;
END;

---triangle
declare

a number:=&a;
b number:=&b;
c number:=&c;

begin

if a=b and b=c and c=a then
    dbms_output.put_line('equilateral triangle');
elsif a=b and b!=c and a!=c then
    dbms_output.put_line('isoceleous triangle triangle');
elsif a!=b and b!=c and a!=c then
    dbms_output.put_line('scaler triangle triangle');

end if;
 end;  
 /
-------------------------------------
---5. sql
select job,  count(*) from emp  group by(job) having count(*)>1;
--------------------------------
--6.sql
select * from emp where length(ename)=4 and ename like'__R%';
-------------------------
--7.
select *  from emp where hiredate between('01-01-81')and('31-12-81')
and job in (select job from emp where hiredate in(select min(hiredate) from emp where hiredate like '%81'));
--9.List the emps whose jobs same as SMITH or ALLEN
select * from emp where job in (select job from emp where ename in('SMITH','ALLEN'));

--List the emps whose Jobs are same as ALLEN. 
select * from emp where job = (select job from emp where ename = 'ALLEN'); 

-- List the emps whose job is same as either allen or sal>allen. 
 select * from emp where job = (select job from emp where ename = 'ALLEN') or sal > (select sal from emp where ename = 'ALLEN'); 


--10 List the emps with loc and grade of accounting dept or the locs dallas or  Chicago with the grades 3 to 5 &exp >6y 
 select e.deptno,e.empno,e.ename,e.sal,d.dname,d.loc,s.grade from emp e,salgrade s,dept d 
 where e.deptno = d.deptno and e.sal between s.losal and s.hisal 
and s.grade in (3,5) and ((months_between(sysdate,hiredate))/12) > 6  
and ( d.dname = 'ACCOUNTING' or D.loc in ('DALLAS','CHICAGO')) ;
 


--6.plsql-----------sum of even numbers

declare
i  number;
even number:=0;

begin
for i in 1..100 loop
if   mod(i,2)=0 then
dbms_output.put_line(even);
even:=even+i;
end if;
end loop;
end;
/
-----------------------stars-----------------------------------
/*

* 
* * 
* * * 
* * * * 
* * * * * 

*/
DECLARE  
        n number;  --no of rows
BEGIN  
    n:=&n;  
    FOR i IN 1..n LOOP  -->1--4
    FOR j IN 1..i LOOP  -->i=1,i=1,2,i=1,2,3.....
    dbms_output.put('* ');  
    END LOOP;  
    DBMS_OUTPUT.NEW_LINE;  
    END LOOP;  
    END;  
/

/*
    
* * * * * 
* * * * * 
* * * * * 
* * * * * 
* * * * * 

*/
    
DECLARE
 N NUMBER:=5;
 BEGIN
 FOR I IN 1..N LOOP
 FOR J IN 1..N LOOP
 DBMS_OUTPUT.PUT('* ');
 END LOOP;
 DBMS_OUTPUT.NEW_LINE;
 END LOOP;
 END;
 /

/*

* * * * * 
* * * * 
* * * 
* * 
*

*/

DECLARE  
n number;  --no of rows
BEGIN  
    n:=&n;  
    FOR i IN 1..n LOOP  -->1--4
    FOR j IN 1..n-i+1 LOOP  -->i=1,2,3,4,5  , i = 1,2,3,4,.....
    dbms_output.put('* ');  
    END LOOP;  
    DBMS_OUTPUT.NEW_LINE;  
    END LOOP;  
    END;  
/

/*

* 
* * 
* * * 
* * * * 
* * * * * 
* * * * 
* * * 
* * 
* 

*/
SET SERVEROUTPUT ON;

DECLARE 
N NUMBER:=9;
STAR NUMBER:=1;
BEGIN 
 FOR I IN 1..N LOOP
 FOR J IN 1..STAR LOOP
 DBMS_OUTPUT.PUT('* ');
 END LOOP;
  dbms_output.new_line;
 IF I<=4 THEN 
 STAR := STAR+1;
-- ELSE IF I>=5 THEN 
ELSE
 STAR:=STAR-1;
-- END IF;
 END IF; 
 END LOOP;
 END;
 
 /
 declare
 n number:=10;
 space1 number:=4;
 star1 number :=1;
 i number;
 j number;
 a number;
 begin
 for i in 1..n loop
 for j in 1..space1 loop
 dbms_output.put(' ');
  end loop;
 for a in 1..star1 loop
 dbms_output.put('*');
 end loop;
 if(i<5) then
 star1:=star1+1;
 space1:=space1-1;
 else if(i>=5) then
 star1:=star1-1;
 space1:=space1+1;
 end if;
 end if;
dbms_output.new_line;
 end loop;
 end;
 /
 
----------------------prime number
declare
n number :=&n;                        
temp number := 1;         
begin                
for i in 2..n/2 loop
if mod(n, i) = 0  then
temp := 0;
exit;
end if;
end loop;
if temp = 1 then
dbms_output.put_line('prime no');
else
dbms_output.put_line('non prime no');
end if;
end; 
/
/*  
   * * 
  * * * 
 * * * * 
* * * * */ 
BEGIN 
FOR I IN 1..5 LOOP
FOR J IN 1..5-I LOOP
DBMS_OUTPUT.PUT(' ');
END LOOP;
FOR J IN 1..I LOOP
DBMS_OUTPUT.PUT('* ');
END LOOP;
DBMS_OUTPUT.NEW_LINE; 
END LOOP;
END;

/
/*
1
01
101
0101
10101 */
BEGIN
FOR I IN 1..5 LOOP
FOR J IN 1..I LOOP
IF MOD(I+J,2) = 0 THEN
DBMS_OUTPUT.PUT('1');
ELSE DBMS_OUTPUT.PUT('0');
END IF;
END LOOP;
DBMS_OUTPUT.NEW_LINE; 
END LOOP;
END;
/
/*      *  
      * * 
    * * * 
  * * * * 
* * * * */ 
BEGIN 
FOR I IN 1..5 LOOP
FOR J IN 1..5-I LOOP
DBMS_OUTPUT.PUT('  ');
END LOOP;
FOR J IN 1..I LOOP
DBMS_OUTPUT.PUT('* ');
END LOOP;
DBMS_OUTPUT.NEW_LINE; 
END LOOP;
END;
/
--find out the most recently hired employee in each dept order by hiredate
SELECT * FROM emp e  WHERE hiredate IN(SELECT max(hiredate)FROM emp WHERE  e.deptno = deptno )
ORDER BY hiredate DESC;

select * from emp;
--List the employee names and his average salary department wise.
select ename,sal,sal/2 avg_sal,deptno from emp order by deptno asc;

select count(comm) from emp ;
 select empno, ename, LOWER(ename) from emp;
 select empno, ename, upper(ename) from emp;
select INITCAP(ename) from emp;
select CONCAT (ename, job ) from emp;
select SUBSTR('oracle',2 , 3) from dual;
select SUBSTR('oracle',5 ,1 ) from dual;
select * from emp where length(ename) = 4;
 select INSTR('oracle', 'a' ) from dual;
select INSTR('oracle' ,'h') from dual;
select INSTR('oracle', 'acl') from dual;
select LPAD ( 'oracle', 10 , '*') from dual;
select RPAD ( 'oracle', 10 , '*') from dual;
select LTRIM ( 'zzzzoracle' , 'z') from dual;
select RTRIM ( 'oraclezzzz' , 'z') from dual;
select sysdate from dual;
select ename , hiredate, SYSDATE, round(MONTHS_BETWEEN ( SYSDATE, hiredate )) from emp;
select deptno, sum(sal)from emp
group by deptno;
select deptno, job, SUM(sal)from emp group by deptno, job;
Select job,deptno, MIN(sal), MAX(sal) from emp where job ='CLERK'GROUP BY deptno,job HAVING MIN(sal) < 1000;
select ename , job, sal from emp where sal > 2500 ORDER BY  ename,job DESC;
/
--Write a program to print the numbers from 1 to 100
DECLARE
N NUMBER(3):=1;
V VARCHAR2(1000);
BEGIN
WHILE N <=100
LOOP
V:=V||''||N;
N:=N+1;
END LOOP;
DBMS_OUTPUT.PUT_LINE(V);
END;
/
