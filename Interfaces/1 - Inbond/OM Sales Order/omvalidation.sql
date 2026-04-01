declare
vn number;
vn1 varchar(20);
vn2  number;
vn3  number;
vn4 number;
vn5 number;
vn6 number;
vn7 number;
vn8 number;
vn9 number;
v_flag varchar(20);
flag varchar(20);
cursor cc is select * from salesinterface;
begin
for  I in cc loop
v_flag:='S';
if i.version_number is not null then
begin
select distinct version_number into vn from oe_order_headers_all where version_number=i.version_number;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
v_flag:='F1';
end;
end if;
----------------------------
if i.order_category_code is not null then
begin
select distinct order_category_code into vn1 from oe_order_headers_all where order_category_code=i.order_category_code;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':order_category_code');
v_flag:='f2';
end;
end if;if i.LINE_NUMBER is not null then
begin
select distinct LINE_NUMBER into vn from oe_order_lines_all where LINE_NUMBER=i.LINE_NUMBER;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
flag:='F7';
end;
end if;
-----------------
if i.order_type_id is not null then
begin
select distinct order_type_id into vn2 from oe_order_headers_all where order_type_id=i.order_type_id;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || 'oe_order_headers_all');
v_flag:='f3';

end;
end if;
-----------
if i.ORDER_NUMBER is not null then
begin
select distinct ORDER_NUMBER into vn3 from oe_order_headers_all where ORDER_NUMBER=i.ORDER_NUMBER;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || 'ORDER_NUMBER');
v_flag:='F4';
end;
end if;
------------------
if i.BOOKED_flag is not null  then

begin
select distinct BOOKED_flag into vn4 from oe_order_headers_all where BOOKED_flag=i.BOOKED_flag;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
end;
end if;
-------------
if i.LINE_NUMBER is not null then
begin
select distinct LINE_NUMBER into vn5 from oe_order_lines_all where LINE_NUMBER=i.LINE_NUMBER;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
end;
end if;
------------------
if i.INVENTORY_ITEM_ID is not null then
begin
select distinct INVENTORY_ITEM_ID into vn6 from oe_order_lines_all where INVENTORY_ITEM_ID=i.INVENTORY_ITEM_ID;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
v_flag:='F8';
end;
end if;
---------------
if i.SHIPMENT_NUMBER is not null then
begin
select distinct SHIPMENT_NUMBER into vn7 from oe_order_lines_all where SHIPMENT_NUMBER=i.SHIPMENT_NUMBER;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
v_flag:='F9';
end;
end if;
-------------------
if i.LINE_TYPE_ID is not null then
begin
select distinct LINE_TYPE_ID into vn8 from oe_order_lines_all where LINE_TYPE_ID=i.LINE_TYPE_ID;
EXCEPTION
when others then
dbms_output.put_line(sqlerrm || ':version number');
v_flag:='F10';
end;
end if;
update salesinterface set flag=v_flag where seq=i.seq;

if v_flag='S' then
-----inserting------
insert into oe_headers_iface_all(
HEADER_ID,
LAST_UPDATE_DATE,
CREATED_BY,
CREATION_DATE,
LAST_UPDATED_BY,
VERSION_NUMBER,
ORDER_CATEGORY,
ORDER_TYPE_ID,
ORDER_NUMBER,
BOOKED_FLAG)
values
( oe_order_headers_s.nextval,
sysdate,
1318,
sysdate-1,
1318,
i.VERSION_NUMBER,
i.ORDER_CATEGORY_CODE,
i.ORDER_TYPE_ID,
i.ORDER_NUMBER,
i.BOOKED_FLAG);
insert into oe_lines_iface_all(

LINE_ID,
CREATED_BY,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE,
LINE_CATEGORY_CODE,

LINE_NUMBER,
INVENTORY_ITEM_ID,
SHIPMENT_NUMBER,
LINE_TYPE_ID)
values
(

 oe_order_lines_s.nextval,
 1318,
 sysdate,
 1318,
 sysdate-1,
 'ORDER',

 i.LINE_NUMBER,
 i.INVENTORY_ITEM_ID,
 i.SHIPMENT_NUMBER,
 i.LINE_TYPE_ID);
 end if;

end loop;
end;
/
 select OPEN_FLAG,org_id from oe_order_headers_all