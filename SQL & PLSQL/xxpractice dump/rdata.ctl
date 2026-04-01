OPTIONS(SKIP=1)
LOAD DATA
INFILE '/u02/oracle/VIS/fs1/EBSapps/appl/ar/12.0.0/bin/rdata1.csv'
append
into table rdata
fields terminated by ','
optionally enclosed by '"'
trailing nullcols
(CUSTOMER_TRX_ID,CREATED_FROM,LAST_UPDATE_DATE,LAST_UPDATED_BY,CREATION_DATE,COMPLETE_FLAG,TRX_NUMBER,CUST_TRX_TYPE_ID,TRX_DATE,SET_OF_BOOKS_ID,CREATED_BY
)
