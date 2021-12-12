@init/create_schema.sql

alter session set current_schema = importer;

@sequences/t_import_seq.sql
@tables/t_import.sql

@packages/interface_api_s.sql
@packages/interface_api_b.sql
@packages/public_api_s.sql
@packages/public_api_b.sql

exit