set serveroutput on
@tests/test_interface_api_s.sql
@tests/test_interface_api_b.sql
@tests/test_public_api_s.sql
@tests/test_public_api_b.sql

exec ut.run();
exit