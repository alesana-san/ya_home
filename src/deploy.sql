@init/create_schema.sql

alter session set current_schema = importer;

@sequences/t_import_seq.sql
@tables/t_import.sql

@packages/interface_api_s.sql
@packages/interface_api_b.sql
@packages/public_api_s.sql
@packages/public_api_b.sql
@packages/process_mgr_s.sql
@packages/process_mgr_b.sql
@packages/helper_s.sql
@packages/helper_b.sql

show errors

exit