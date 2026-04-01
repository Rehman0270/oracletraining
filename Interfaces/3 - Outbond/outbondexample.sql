CREATE OR REPLACE PROCEDURE REHMAN212 (
ERRBUF OUT VARCHAR2,
RETCODE OUT VARCHAR2) as
CURSOR C1 IS SELECT * FROM EMP;
R UTl_FILE.FILE_TYPE;
COUNTER NUMBER := 0;
BEGIN
R := utl_FILE.fopen('XXBATCH_221123','RTEST321.csv','w');
utl_file.put_line(R,'empno'||','||'ename'||','||'sal');
for i in c1 loop
utl_file.put_line(R,i.empno||','||i.ename||','||i.sal);
end loop;
utl_file.fclose(R);
END;
/
select * from all_directories