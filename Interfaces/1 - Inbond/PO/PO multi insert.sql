alter session set nls_language = 'american'
/
declare 
cursor cc is select * from stag2;
    v_flag             VARCHAR2(1);
    v_org              NUMBER;
    v_curr             VARCHAR2(5);
    v_agent            NUMBER;
    v_supp             NUMBER;
    v_supp_site        NUMBER;
    v_ship             NUMBER;
    v_bill             NUMBER;
    v_uom              VARCHAR2(25);
    v_item             NUMBER;
    v_catg             NUMBER;
    v_desc             VARCHAR2(200);
begin
for i in cc loop
v_flag:='S'; 
--operating_unit-----------------------------------------------------------------
   IF i.operating_unit is not null then 
      BEGIN
        select ORGANIZATION_ID into v_org from hr_operating_units
        where name=i.operating_unit;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':operating_unit');
        v_flag:='F';
      END;
   END IF;
--currency_code-----------------------------------------------------------------
   IF i.currency_code is not null then 
      BEGIN
        select currency_code into v_curr from fnd_currencies
        where currency_code=i.currency_code;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':currency_code');
        v_flag:='F';
      END;
   END IF;
--agent_name-----------------------------------------------------------------
   IF i.agent_name is not null then 
      BEGIN
        select unique person_id into v_agent from per_all_people_f
        where full_name=i.agent_name;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':agent_name');
        v_flag:='F';
      END;
   END IF;
--vendor_name-----------------------------------------------------------------
   IF i.vendor_name is not null then 
      BEGIN
        select vendor_id into v_supp from ap_suppliers
        where vendor_name=i.vendor_name;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':vendor_name');
        v_flag:='F';
      END;
   END IF;
--vendor_site_code-----------------------------------------------------------------
   IF i.vendor_site_code is not null then 
      BEGIN
        select distinct vendor_site_id into v_supp_site from ap_supplier_sites_all
        where vendor_site_code=i.vendor_site_code and org_id=v_org;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':vendor_site_code');
        v_flag:='F';
      END;
   END IF;
--ship_to_location_code-----------------------------------------------------------------
   IF i.ship_to_location_code is not null then 
      BEGIN
        select location_id into v_ship from hr_locations
        where location_code=i.ship_to_location_code;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':ship_to_location_code');
        v_flag:='F';
      END;
   END IF;
--bill_to_location_code-----------------------------------------------------------------
   IF i.bill_to_location_code is not null then 
      BEGIN
        select location_id into v_bill from hr_locations
        where location_code=i.bill_to_location_code;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':bill_to_location_code');
        v_flag:='F';
      END;
   END IF;
--item_number-----------------------------------------------------------------
   IF i.item_number is not null then 
      BEGIN
        select distinct inventory_item_id,description into v_item,v_desc from mtl_system_items_b
        where segment1=i.item_number;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':item_number');
        v_flag:='F';
      END;
   END IF;
--item_category-----------------------------------------------------------------
   IF i.item_category is not null then 
      BEGIN
        select category_id into v_catg from mtl_categories_b
        where segment1=i.item_category and (segment2 LIKE 'MISC' OR segment2 LIKE 'SUPPLIES') and STRUCTURE_ID=201 
        and STRUCTURE_ID=201 FETCH FIRST ROW ONLY;
      EXCEPTION 
        when others then
        dbms_output.put_line(sqlerrm||':item_category');
        v_flag:='F';
      END;
   END IF;
--UOM_CODE-----------------------------------------------------------------
   IF i.UOM_CODE IS NOT NULL THEN
     BEGIN
       SELECT UNIT_OF_MEASURE INTO v_uom FROM MTL_UNITS_OF_MEASURE
       WHERE UOM_CODE = i.UOM_CODE;
     EXCEPTION
       WHEN OTHERS THEN
       dbms_output.put_line(sqlerrm||':UOM_CODE');
       V_FLAG:='F';
     END;
   END IF;

       update stag2 set P_FLAG = v_flag where id = i.id;
-----------------------------------------------------------------------------
  IF V_FLAG = 'S' THEN
    INSERT INTO PO_HEADERS_INTERFACE
    (
    INTERFACE_HEADER_ID,
    BATCH_ID,
    ACTION,
    DOCUMENT_TYPE_CODE,
    CURRENCY_CODE,
    AGENT_ID,
    VENDOR_ID,
    VENDOR_SITE_ID,
    SHIP_TO_LOCATION_ID,
    BILL_TO_LOCATION_ID,
    ORG_ID,
    CREATION_DATE,
    CREATED_BY,
    document_num
    )
    VALUES
    (
    po_headers_interface_s.NEXTVAL,  --INTERFACE_HEADER_ID
    160419763,                       --BATCH_ID
    i.action,                        --ACTION
    i.document_type_code,            --DOCUMENT_TYPE_CODE 
    v_curr,                          --CURRENCY_CODE
    v_agent,                         --AGENT_ID
    v_supp,                          --VENDOR_ID
    v_supp_site,                     --VENDOR_SITE_ID 
    v_ship,                          --SHIP_TO_LOCATION_ID
    v_bill,                          --BILL_TO_LOCATION_ID
    v_org,                           --ORG_ID
    SYSDATE,                         --CREATION_DATE
    1318,
      TO_CHAR(po_headers_interface_s.currvaL)--CREATED_BY
    );
    INSERT INTO PO_LINES_INTERFACE
    (
    INTERFACE_LINE_ID,
    INTERFACE_HEADER_ID,
    ACTION,
    LINE_TYPE,
    LINE_NUM,
    SHIP_TO_LOCATION_ID,
    SHIP_TO_ORGANIZATION_ID,
    UNIT_OF_MEASURE,
    UNIT_PRICE,
    QUANTITY,
    ITEM_ID,
    ITEM_DESCRIPTION,
    CREATION_DATE,
    CREATED_BY,
    SHIPMENT_NUM,
    CATEGORY_ID,
    PROMISED_DATE
    )
    VALUES
    (
    po_lines_interface_s.nextval,  --INTERFACE_LINE_ID
    po_headers_interface_s.currval,--INTERFACE_HEADER_ID
    i.action,                      --ACTION
    i.line_type,                   --LINE_TYPE 
    i.line_number,                 --LINE_NUM
    v_ship,                        --SHIP_TO_LOCATION_ID
    204,                           --SHIP_TO_ORGANIZATION_ID
    v_uom,                         --UNIT_OF_MEASURE
    i.unit_price,                  --UNIT_PRICE
    i.quantity,                    --QUANTITY
    v_item,                        --ITEM_ID
    v_desc,                        --ITEM_DESCRIPTION  
    SYSDATE,                       --CREATION_DATE
    1318,                          --CREATED_BY 
    1,                             --SHIPMENT_NUM
    v_catg,                        --CATEGORY_ID
    SYSDATE + 10                   --PROMISED_DATE
    );
    INSERT INTO PO_DISTRIBUTIONS_INTERFACE
    (
    INTERFACE_DISTRIBUTION_ID,
    INTERFACE_HEADER_ID,
    INTERFACE_LINE_ID,
    DISTRIBUTION_NUM,
    DESTINATION_TYPE_CODE,
    ACCRUE_ON_RECEIPT_FLAG,
    CREATION_DATE,
    CREATED_BY,
    ORG_ID,
    QUANTITY_ORDERED
    )
    VALUES 
    (
    po_distributions_interface_s.nextval,--INTERFACE_DISTRIBUTION_ID
    po_headers_interface_s.currval,      --INTERFACE_HEADER_ID
    po_lines_interface_s.currval,        --INTERFACE_LINE_ID  
    i.distribution_number,               --DISTRIBUTION_NUM
    I.DESTINATION_TYPE_CODE,             --DESTINATION_TYPE_CODE
    'N',                                 --ACCRUE_ON_RECEIPT_FLAG
    SYSDATE,                             --CREATION_DATE
    1318,                                --CREATED_BY
    v_org,                               --ORG_ID
    i.quantity                           --QUANTITY_ORDERED
    ); 
    END IF;

    END LOOP;
END;
/
commit;

/
set serverout on