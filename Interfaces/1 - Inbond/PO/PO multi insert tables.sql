select * from hr_locations;
select * from mtl_system_items_b;
select * from fnd_currencies;
select * from mtl_categories_b;
--------------interface_tables---------------
select * from po_line_locations_interface;
select * from po_headers_interface order by creation_date desc;
select * from po_lines_interface order by creation_date desc;
select * from po_distributions_interface order by creation_date desc;
-----------base_tables-------------------
select * from po_headers_all order by creation_date desc;
select * from po_lines_all order by creation_date desc;
select * from po_distributions_all;
-----------------------------------------
select * from per_all_people_f;
select * from ap_suppliers;
select * from ap_supplier_sites_all;
select * from hr_operating_units;
select * from mtl_units_of_measure;
select * from po_interface_errors order by creation_date desc;
/

