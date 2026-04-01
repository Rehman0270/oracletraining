OPTIONS(SKIP=1)
LOAD DATA
INFILE '/u02/oracle/VIS/fs1/EBSapps/appl/ar/12.0.0/bin/rdata5.csv'
append
into table rdata5
fields terminated by ','
optionally enclosed by '"'
trailing nullcols
(TRX_DATE,
TRX_NUMBER,
SET_OF_BOOKS_ID,
CUST_TRX_TYPE_ID,
LINE_NUMBER,
LINE_TYPE,
EXTENDED_AMOUNT,
ORG_ID,
SEQ,
CURRENCY,
DESCRIPTION,
BATCH_SOURCE_NAME,
CONVERSION_TYPE,
CONVERSION_RATE
)
