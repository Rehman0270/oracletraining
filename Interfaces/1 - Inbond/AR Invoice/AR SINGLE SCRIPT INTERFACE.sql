 -->> ----------------------------------------------------------------------------------
--> Base Tables:
Select * from RA_CUSTOMER_TRX_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE) ;
Select * from RA_CUSTOMER_TRX_LINES_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
Select * from RA_CUST_TRX_LINE_GL_DIST_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
 
--> Interface Tables:
Select * from RA_INTERFACE_LINES_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--DELETE RA_INTERFACE_LINES_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--COMMIT; 

Select * from RA_INTERFACE_DISTRIBUTIONS_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--DELETE RA_INTERFACE_DISTRIBUTIONS_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--COMMIT; 
 
--> Error Table:
Select * from RA_INTERFACE_ERRORS_ALL ORDER BY INTERFACE_LINE_ID DESC;

-->> ----------------------------------------------------------------------------------
--> Validation Queries
select ORGANIZATION_ID
  from hr_operating_units
 where name = 'Vision Operations';

SELECT *
  FROM RA_BATCH_SOURCES_ALL
 WHERE NAME = 'VISION BUILD'
   AND ORG_ID = 204;

select *
  from all_objects
 where object_type = 'TABLE'
   and object_name like '%REVENUE_ASSIGNMENTS%';

SELECT *
  FROM ra_cust_trx_types_all
 where NAME = 'Invoice'
   and ORG_ID =204;
 
SELECT *
  FROM AR_LOOKUPS
 WHERE MEANING ='Line'
   AND LOOKUP_TYPE = 'AR_LINE_INVOICE';
  
 select CURRENCY_CODE
   from fnd_currencies
  where CURRENCY_CODE = 'USD';
 
  select TERM_ID
    from ra_terms_tl
   where NAME = '30 NET';

select UOM_CODE
  from MTL_UNITS_OF_MEASURE_TL
 where UNIT_OF_MEASURE = 'Each';

SELECT HCSU.site_use_code,HCSU.LOCATION,HCAS.cust_acct_site_id,HCA.cust_account_id,HP.PARTY_NUMBER, hp.PARTY_ID
FROM hz_parties HP
,hz_party_sites HPS
,hz_cust_accounts HCA
,hz_cust_acct_sites_all HCAS
,hz_cust_site_uses_all HCSU
WHERE HP.party_id = HPS.party_id
AND HCA.party_id = HP.party_id
AND HCA.cust_account_id = HCAS.cust_account_id
AND HCAS.cust_acct_site_id = HCSU.cust_acct_site_id
and hps.PARTY_SITE_ID = hcas.PARTY_SITE_ID
AND HCSU.site_use_code = 'SHIP_TO'
AND HP.PARTY_ID= 1290
AND HCAs.org_id = 204
AND LOCATION = 'Provo (OPS)';

SELECT HCSU.site_use_code,HCSU.LOCATION,HCAS.cust_acct_site_id,HCA.cust_account_id,HP.PARTY_NUMBER, hp.PARTY_ID
FROM hz_parties HP
,hz_party_sites HPS
,hz_cust_accounts HCA
,hz_cust_acct_sites_all HCAS
,hz_cust_site_uses_all HCSU
WHERE HCA.party_id = HP.party_id
AND HP.party_id = HPS.party_id
AND HCA.cust_account_id = HCAS.cust_account_id
AND HCAS.cust_acct_site_id = HCSU.cust_acct_site_id
AND HCSU.site_use_code = 'BILL_TO'
AND HCSU.primary_flag = 'Y'
AND upper (ltrim (rtrim (HP.party_name))) = upper (ltrim (rtrim ('A. C. Networks')))
AND HCAs.org_id = 204
;

 select INVENTORY_ITEM_ID
   from mtl_system_items_b
  where segment1 = 'AS54999'
    and ORGANIZATION_ID = 204;
   
 select conversion_type
from gl_daily_conversion_types
where conversion_type = 'User';
 
SELECT LOOKUP_CODE
FROM fnd_lookup_values
WHERE lookup_type = 'FOB'
  and MEANING = 'Destination'
  AND VIEW_APPLICATION_ID =222;
 
SELECT CODE_COMBINATION_ID
  FROM GL_CODE_COMBINATIONS_KFV
 WHERE CONCATENATED_SEGMENTS = '01-520-5250-0000-000';

-->> ----------------------------------------------------------------------------------
--> Interface Tables:
Select * from RA_INTERFACE_LINES_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--DELETE RA_INTERFACE_LINES_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--COMMIT; 

Select * from RA_INTERFACE_DISTRIBUTIONS_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--DELETE RA_INTERFACE_DISTRIBUTIONS_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
--COMMIT; 
 
--> Error Table:
Select * from RA_INTERFACE_ERRORS_ALL ORDER BY INTERFACE_LINE_ID DESC;


INSERT INTO ra_interface_lines_all
  (
    interface_line_id,
    batch_source_name,
    line_number,
    line_type,
    cust_trx_type_name,
    cust_trx_type_id,
    trx_date,
    gl_date,
    currency_code,
    term_id,
    orig_system_bill_customer_id,
    orig_system_bill_customer_ref,
    orig_system_bill_address_id,
    orig_system_bill_address_ref,
    orig_system_ship_customer_id,
    orig_system_ship_address_id,
    orig_system_sold_customer_id,
--    sales_order,
    inventory_item_id,
    uom_code,
    quantity,
    unit_selling_price,
    amount,
    description,
    conversion_type,
    conversion_rate,
    interface_line_context,
    interface_line_attribute1,
    interface_line_attribute2,
    org_id,
    set_of_books_id,
    fob_point,
    last_update_date,
    last_updated_by,
    creation_date,
    created_by
  )
  VALUES
  (
    ra_customer_trx_lines_s.NEXTVAL,    --> interface_line_id,
    'VISION BUILD',             --> batch_source_name,
    1,                      --> line_number,
    'LINE',                     --> line_type,
    'Invoice',                  --> cust_trx_type_name,
    1,                      --> cust_trx_type_id,
    SYSDATE,                    --> trx_date,
    TO_DATE('20-JAN-2014'),         --> gl_date,
    'USD',                      --> currency_code,
    4,                      --> term_id,
    1290,                       --> orig_system_bill_customer_id,
    1290,                       --> orig_system_bill_customer_ref,
    1340,                       --> orig_system_bill_address_id,
    1340,                       --> orig_system_bill_address_ref,
    1290,                       --> orig_system_ship_customer_id,
    1340,                       --> orig_system_ship_address_id,
    1290,                       --> orig_system_sold_customer_id,
--    66500,                    --> sales_order,
    2155,                       --> inventory_item_id,
    'Ea',                       --> uom_code,
    20,                     --> quantity,
    400,                        --> unit_selling_price,
    8000,                       --> amount,
    'XXAA Invoice',             --> description,
    'User',                     --> conversion_type,
    1,                      --> conversion_rate,
    'VISION BUILD',             --> interface_line_context,
    '5805',                     --> interface_line_attribute1,
    '2541',                     --> interface_line_attribute2,
    204,                        --> org_id,
    1,                      --> set_of_books_id,
    'Destination',              --> fob_point,
    SYSDATE,                    --> last_update_date,
    1318, -- fnd_global.user_id,        --> last_updated_by,
    SYSDATE,                    --> creation_date,
    1318  -- fnd_global.user_id     --> created_by
  );


INSERT INTO ra_interface_distributions_all
  (
    interface_line_id,
    account_class,
    amount,
    code_combination_id,
    PERCENT,
    interface_line_context,
    interface_line_attribute1,
    INTERFACE_LINE_ATTRIBUTE2,
    org_id,
    last_update_date,
    last_updated_by,
    creation_date,
    created_by
  )
  VALUES
  (
    ra_customer_trx_lines_s.CURRVAL,
    'REV',
    8000,
    17021,
    100,
    'VISION BUILD',
    '5805',
    '2541',
    204,
    SYSDATE,
    1318, -- fnd_global.user_id,
    SYSDATE,
    1318  -- fnd_global.user_id
  );
 
COMMIT; 
 
-->> ----------------------------------------------------------------------------------
-->Run 'Autoinvoice Master Program' from Receivable, Vision Operation (USA) responsibility

-->> ----------------------------------------------------------------------------------
--> Error Table:
Select * from RA_INTERFACE_ERRORS_ALL ORDER BY INTERFACE_LINE_ID DESC;

--> Base Tables:
Select * from RA_CUSTOMER_TRX_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE) ;
Select * from RA_CUSTOMER_TRX_LINES_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
Select * from RA_CUST_TRX_LINE_GL_DIST_ALL where TRUNC(CREATION_DATE) = TRUNC(SYSDATE);
-->> ----------------------------------------------------------------------------------
