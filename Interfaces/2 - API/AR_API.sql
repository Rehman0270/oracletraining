
/
select batch_source_id, name
from ra_batch_sources_all
where name = 'Manual'
and org_id  = 204;

select b.cust_account_id,party_name
from hz_parties a,
hz_cust_accounts b
where 1=1 
and a.party_name like 'A. C. Networks%'
and a.party_id = b.party_id
order by 2;

select cust_trx_type_id, name
from ra_cust_trx_types_all
where 1=1
and name = 'Invoice'
and org_id  = 204;

/

/
select * from ra_customer_trx_all
where 1=1
and Customer_Trx_Id = 766715
And Creation_Date >= Sysdate - 1 ;


select * from ra_customer_trx_lines_all
where 1=1
and Customer_Trx_Id = 766715
And Creation_Date >= Sysdate - 1 ;
/


--> Creating Single Invoice
-- a.Turn on DBMS_OUTPUT to display messages on screen
SET SERVEROUTPUT ON SIZE 1000000

-- b.Declaration section
DECLARE
   l_return_status          VARCHAR2 (1);
   l_msg_count              NUMBER;
   l_msg_data               VARCHAR2 (2000);
   l_batch_id               NUMBER;
   l_cnt                    NUMBER := 0;
   l_batch_source_rec       ar_invoice_api_pub.batch_source_rec_type;
   l_trx_header_tbl         ar_invoice_api_pub.trx_header_tbl_type;
   l_trx_lines_tbl          ar_invoice_api_pub.trx_line_tbl_type;
   l_trx_dist_tbl           ar_invoice_api_pub.trx_dist_tbl_type;
   l_trx_salescredits_tbl   ar_invoice_api_pub.trx_salescredits_tbl_type;
   l_customer_trx_id        NUMBER;

   CURSOR list_errors
   IS
      SELECT trx_header_id,
             trx_line_id,
             trx_salescredit_id,
             trx_dist_id,
             trx_contingency_id,
             error_message,
             invalid_value
        FROM ar_trx_errors_gt;
BEGIN
   --c.SET the applications context
   mo_global.init ('AR');
   mo_global.set_policy_context ('S', '204');
   fnd_global.apps_initialize (1318, 50559, 222, 0);
  
   --d.Populate batch source information.
   l_batch_source_rec.batch_source_id := -1;
  
   --e.Populate header information.
   l_trx_header_tbl (1).trx_header_id := 101;
   l_trx_header_tbl (1).bill_to_customer_id := 1290;
   l_trx_header_tbl (1).cust_trx_type_id := 1;
  
   --f.Populate line 1 information.
   l_trx_lines_tbl (1).trx_header_id := 101;
   l_trx_lines_tbl (1).trx_line_id := 401;
   l_trx_lines_tbl (1).line_number := 1;
   l_trx_lines_tbl (1).description := 'Product Description 1';
   l_trx_lines_tbl (1).quantity_invoiced := 10;
   l_trx_lines_tbl (1).unit_selling_price := 12;
   l_trx_lines_tbl (1).line_type := 'LINE';
  
   --g.Populate line 2 information.
   l_trx_lines_tbl (2).trx_header_id := 101;
   l_trx_lines_tbl (2).trx_line_id := 402;
   l_trx_lines_tbl (2).line_number := 2;
   l_trx_lines_tbl (2).description := 'Product Description 2';
   l_trx_lines_tbl (2).quantity_invoiced := 12;
   l_trx_lines_tbl (2).unit_selling_price := 15;
   l_trx_lines_tbl (2).line_type := 'LINE';
  
   --h.Populate freight information and link it to line 1.
   l_trx_lines_tbl (3).trx_header_id := 101;
   l_trx_lines_tbl (3).trx_line_id := 403;
   l_trx_lines_tbl (3).link_to_trx_line_id := 401;
   l_trx_lines_tbl (3).line_number := 3;
   l_trx_lines_tbl (3).line_type := 'FREIGHT';
   l_trx_lines_tbl (3).amount := 25;
  
   --i.Call the invoice api to create the invoice
   AR_INVOICE_API_PUB.create_single_invoice (
      p_api_version            => 1.0,
      p_batch_source_rec       => l_batch_source_rec,
      p_trx_header_tbl         => l_trx_header_tbl,
      p_trx_lines_tbl          => l_trx_lines_tbl,
      p_trx_dist_tbl           => l_trx_dist_tbl,
      p_trx_salescredits_tbl   => l_trx_salescredits_tbl,
      x_customer_trx_id        => l_customer_trx_id,
      x_return_status          => l_return_status,
      x_msg_count              => l_msg_count,
      x_msg_data               => l_msg_data);

   --j.Check for errors
   IF    l_return_status = fnd_api.g_ret_sts_error
      OR l_return_status = fnd_api.g_ret_sts_unexp_error
   THEN
      DBMS_OUTPUT.put_line ('unexpected errors found!');
   ELSE
      SELECT COUNT (*) INTO l_cnt FROM ar_trx_errors_gt;

      IF l_cnt = 0
      THEN
         DBMS_OUTPUT.put_line ( 'SUCCESS: Created customer_trx_id = ' || l_customer_trx_id);
      ELSE
         --k.List errors
         DBMS_OUTPUT.put_line ( 'FAILURE: Errors encountered, see list below:');

         FOR i IN list_errors
         LOOP
            DBMS_OUTPUT.put_line ('');
            DBMS_OUTPUT.put_line ( 'Header ID = ' || TO_CHAR (i.trx_header_id));
            DBMS_OUTPUT.put_line ( 'Line ID = ' || TO_CHAR (i.trx_line_id));
            DBMS_OUTPUT.put_line ( 'Sales Credit ID = ' || TO_CHAR (i.trx_salescredit_id));
            DBMS_OUTPUT.put_line ( 'Dist Id = ' || TO_CHAR (i.trx_dist_id));
            DBMS_OUTPUT.put_line ( 'Contingency ID = ' || TO_CHAR (i.trx_contingency_id));
            DBMS_OUTPUT.put_line ( 'Message = ' || SUBSTR (i.error_message, 1, 80));
            DBMS_OUTPUT.put_line ( 'Invalid Value = ' || SUBSTR (i.invalid_value, 1, 80));
            DBMS_OUTPUT.put_line ('');
         END LOOP;
      END IF;
   END IF;
END;


--> Creating Multiple Invoices
--a.Turn on DBMS_OUTPUT to display messages on screen
SET SERVEROUTPUT ON SIZE 1000000

--b.Declaration section
DECLARE
   l_return_status          VARCHAR2 (1);
   l_msg_count              NUMBER;
   l_msg_data               VARCHAR2 (2000);
   l_batch_id               NUMBER;
   l_batch_source_rec       ar_invoice_api_pub.batch_source_rec_type;
   l_trx_header_tbl         ar_invoice_api_pub.trx_header_tbl_type;
  l_trx_lines_tbl          ar_invoice_api_pub.trx_line_tbl_type;
   l_trx_dist_tbl           ar_invoice_api_pub.trx_dist_tbl_type;
   l_trx_salescredits_tbl   ar_invoice_api_pub.trx_salescredits_tbl_type;
   l_trx_created            NUMBER;
   l_cnt                    NUMBER;

   CURSOR cbatch
   IS
      SELECT customer_trx_id
        FROM ra_customer_trx_all
       WHERE batch_id = l_batch_id;

   CURSOR list_errors
   IS
      SELECT trx_header_id,
             trx_line_id,
             trx_salescredit_id,
             trx_dist_id,
             trx_contingency_id,
             error_message,
             invalid_value
        FROM ar_trx_errors_gt;
BEGIN
   --c.Set the applications context
   mo_global.init ('AR');
   mo_global.set_policy_context ('S', '204');
   fnd_global.apps_initialize (1318, 50559, 222, 0);
  
   --d.Populate batch source information.
   l_batch_source_rec.batch_source_id := -1;
  
   --e.Populate header information for first invoice
   l_trx_header_tbl (1).trx_header_id := 101;
   l_trx_header_tbl (1).bill_to_customer_id := 1290;
   l_trx_header_tbl (1).cust_trx_type_id := 1;
  
   --f.Populate lines information for first invoice
   l_trx_lines_tbl (1).trx_header_id := 101;
   l_trx_lines_tbl (1).trx_line_id := 401;
   l_trx_lines_tbl (1).line_number := 1;
   l_trx_lines_tbl (1).description := 'Product Description 1';
   l_trx_lines_tbl (1).quantity_invoiced := 1;
   l_trx_lines_tbl (1).unit_selling_price := 150;
   l_trx_lines_tbl (1).line_type := 'LINE';
  
   l_trx_lines_tbl (2).trx_header_id := 101;
   l_trx_lines_tbl (2).trx_line_id := 402;
   l_trx_lines_tbl (2).line_number := 2;
   l_trx_lines_tbl (2).description := 'Product Description 2';
   l_trx_lines_tbl (2).quantity_invoiced := 2;
   l_trx_lines_tbl (2).unit_selling_price := 250;
   l_trx_lines_tbl (2).line_type := 'LINE';
  
   --g.Populate header information for second invoice
   l_trx_header_tbl (2).trx_header_id := 102;
   l_trx_header_tbl (2).bill_to_customer_id := 1290;
   l_trx_header_tbl (2).cust_trx_type_id := 1;
  
   --h.Populate line information for second invoice
   l_trx_lines_tbl (3).trx_header_id := 102;
   l_trx_lines_tbl (3).trx_line_id := 403;
   l_trx_lines_tbl (3).line_number := 1;
   l_trx_lines_tbl (3).description := 'Product Description 1';
   l_trx_lines_tbl (3).quantity_invoiced := 3;
   l_trx_lines_tbl (3).unit_selling_price := 150;
   l_trx_lines_tbl (3).line_type := 'LINE';
  
   l_trx_lines_tbl (4).trx_header_id := 102;
   l_trx_lines_tbl (4).trx_line_id := 404;
   l_trx_lines_tbl (4).line_number := 2;
   l_trx_lines_tbl (4).description := 'Product Description 2';
   l_trx_lines_tbl (4).quantity_invoiced := 4;
   l_trx_lines_tbl (4).unit_selling_price := 250;
   l_trx_lines_tbl (4).line_type := 'LINE';
  
   --i.Populate header information for third invoice
   l_trx_header_tbl (3).trx_header_id := 103;
   l_trx_header_tbl (3).bill_to_customer_id := 1290;
   l_trx_header_tbl (3).cust_trx_type_id := 1;
  
   --j.Populate line information for third invoice
   l_trx_lines_tbl (5).trx_header_id := 103;
   l_trx_lines_tbl (5).trx_line_id := 405;
   l_trx_lines_tbl (5).line_number := 1;
   l_trx_lines_tbl (5).description := 'Product Description 1';
   l_trx_lines_tbl (5).quantity_invoiced := 3;
   l_trx_lines_tbl (5).unit_selling_price := 150;
   l_trx_lines_tbl (5).line_type := 'LINE';
  
   l_trx_lines_tbl (6).trx_header_id := 103;
   l_trx_lines_tbl (6).trx_line_id := 406;
   l_trx_lines_tbl (6).line_number := 2;
   l_trx_lines_tbl (6).description := 'Product Description 2';
   l_trx_lines_tbl (6).quantity_invoiced := 4;
   l_trx_lines_tbl (6).unit_selling_price := 250;
   l_trx_lines_tbl (6).line_type := 'LINE';
  
   --k.Call the invoice api to create multiple invoices in a batch.
   AR_INVOICE_API_PUB.create_invoice (
      p_api_version            => 1.0,
      p_batch_source_rec       => l_batch_source_rec,
      p_trx_header_tbl         => l_trx_header_tbl,
      p_trx_lines_tbl          => l_trx_lines_tbl,
      p_trx_dist_tbl           => l_trx_dist_tbl,
      p_trx_salescredits_tbl   => l_trx_salescredits_tbl,
      x_return_status          => l_return_status,
      x_msg_count              => l_msg_count,
      x_msg_data               => l_msg_data);

   --l.check for errors
   IF    l_return_status = fnd_api.g_ret_sts_error
      OR l_return_status = fnd_api.g_ret_sts_unexp_error
   THEN
      DBMS_OUTPUT.put_line ('FAILURE: Unexpected errors were raised!');
   ELSE
      --m.check batch/invoices created
      SELECT DISTINCT batch_id INTO l_batch_id FROM ar_trx_header_gt;

      IF l_batch_id IS NOT NULL
      THEN
         DBMS_OUTPUT.put_line ('SUCCESS: Created batch_id = ' || l_batch_id || ' containing the following customer_trx_id:');

         FOR c IN cBatch
         LOOP
            DBMS_OUTPUT.put_line (' ' || c.customer_trx_id);
         END LOOP;
      END IF;
   END IF;

   --n.Within the batch, check if some invoices raised errors
  SELECT COUNT (*) INTO l_cnt FROM ar_trx_errors_gt;

   IF l_cnt > 0
   THEN
      DBMS_OUTPUT.put_line ('FAILURE: Errors encountered, see list below:');

      FOR i IN list_errors
      LOOP
         DBMS_OUTPUT.put_line ('');
         DBMS_OUTPUT.put_line ( 'Header ID = ' || TO_CHAR (i.trx_header_id));
         DBMS_OUTPUT.put_line ( 'Line ID = ' || TO_CHAR (i.trx_line_id));
         DBMS_OUTPUT.put_line ( 'Sales Credit ID = ' || TO_CHAR (i.trx_salescredit_id));
         DBMS_OUTPUT.put_line ( 'Dist Id = ' || TO_CHAR (i.trx_dist_id));
         DBMS_OUTPUT.put_line ( 'Contingency ID = ' || TO_CHAR (i.trx_contingency_id));
         DBMS_OUTPUT.put_line ( 'Message = ' || SUBSTR (i.error_message, 1, 80));
         DBMS_OUTPUT.put_line ( 'Invalid Value = ' || SUBSTR (i.invalid_value, 1, 80));
         DBMS_OUTPUT.put_line ('');
      END LOOP;
   END IF;

END;