declare
cursor c1 is select * from rdata5;
v_counts number;
v_count number;
v_flag varchar2(20);
v_orgid number;
v_CTT  NUMBER;
v_SBI NUMBER;
v_BSA varchar2(20);
begin 
for i in c1 loop
v_flag := 'S';
--ORGID-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
if  i.ORG_ID is not null then
begin
select ORGANIZATION_ID into v_orgid from hr_operating_units where ORGANIZATION_ID = i.ORG_ID ;
DBMS_OUTPUT.PUT_LINE(v_orgid);
exception
when others then v_flag:= 'F';
DBMS_OUTPUT.PUT_LINE(v_orgid||'ORG ID IS ERROR');
end;
end if;
--LINE_TYPE-------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
if i.line_type is not null then
begin
if i.line_type = 'LINE' or i.line_type = 'TAX' or i.line_type = 'FREIGHT' or i.line_type = 'CHARGES'
THEN DBMS_OUTPUT.PUT_LINE(I.LINE_TYPE);

ELSE DBMS_OUTPUT.PUT_LINE(I.LINE_TYPE||' LINE IS ERROR');
v_flag:= 'F';
END IF;
END;
END IF;
----CUST_TRX_TYPE_ID----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
if  i.CUST_TRX_TYPE_ID is not null then
begin
select CUST_TRX_TYPE_ID into v_CTT from RA_CUST_TRX_TYPES_ALL where CUST_TRX_TYPE_ID = i.CUST_TRX_TYPE_ID ;
DBMS_OUTPUT.PUT_LINE(v_CTT);
exception
when others then v_flag:= 'F';
DBMS_OUTPUT.PUT_LINE(v_CTT||' CUSTTYPE IS ERROR');
end;
end if;
----SET_OF_BOOKS_ID----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
if i.SET_OF_BOOKS_ID is not null then
begin
select SET_OF_BOOKS_ID into v_SBI from AR_SYSTEM_PARAMETERS_ALL where SET_OF_BOOKS_ID = i.SET_OF_BOOKS_ID ;
DBMS_OUTPUT.PUT_LINE(v_SBI);
exception
when others then v_flag:= 'F';
DBMS_OUTPUT.PUT_LINE(v_SBI||' SBI IS ERROR');
end;
end if;
------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
if i.batch_source_name is not null then
begin
select DISTINCT NAME into v_BSA from RA_BATCH_SOURCES_ALL where NAME = i.batch_source_name AND BATCH_SOURCE_TYPE = 'FOREIGN';
DBMS_OUTPUT.PUT_LINE(v_BSA);
exception
when others then v_flag:= 'F';
DBMS_OUTPUT.PUT_LINE(v_BSA||' BSA IS ERROR');
end;
end if;
-------trxnumber-----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
if i.TRX_NUMBER is not null then
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM RA_CUSTOMER_TRX_ALL
    WHERE TRX_NUMBER = I.trx_number;
    IF v_count > 0 THEN
      v_flag:= 'F';
DBMS_OUTPUT.PUT_LINE(v_count||' TRXN IS ERROR');
    END IF;
    SELECT COUNT(*)
    INTO v_counts
    FROM RA_CUSTOMER_TRX_ALL
    WHERE BATCH_SOURCE_ID = I.trx_number;

    IF v_counts > 0 THEN
    v_flag:= 'F';
DBMS_OUTPUT.PUT_LINE(v_counts||' TRXN IS ERROR');
    END IF;
END;
end if;
------------------------------------------------------------
UPDATE RDATA5 SET FLAG = v_flag WHERE SEQ = I.SEQ;
-----------------------------------------------------------------------------------------------------------------------------
IF V_FLAG = 'S' THEN
INSERT INTO ra_interface_lines_all (
 CUSTOMER_TRX_ID,
 INTERFACE_LINE_ID,
    creation_date,
    created_by,
    last_updated_by,
    last_update_date,
    last_update_login,
   TRX_NUMBER,
    SET_OF_BOOKS_ID,
    CUST_TRX_TYPE_ID,
    LINE_NUMBER,
    LINE_TYPE,
    EXTENDED_AMOUNT,
    ORG_ID,
    CONVERSION_TYPE,
    conversion_RATE,
    currency_code,
    batch_source_name,
    description
) VALUES (RA_CUSTOMER_TRX_S.NEXTVAL,
RA_CUSTOMER_TRX_LINES_S.NEXTVAL,
    sysdate,
    100,
    100,
    sysdate,
    100,
    I.TRX_NUMBER,
    I.SET_OF_BOOKS_ID,
    I.CUST_TRX_TYPE_ID,
    I.LINE_NUMBER,
    I.LINE_TYPE,
    I.EXTENDED_AMOUNT,
    I.ORG_ID,
    I.CONVERSION_TYPE,
    1,
    I.CURRENCY,
    I.BATCH_SOURCE_NAME,
    I.DESCRIPTION
);
END IF;
end loop;
END;
/
