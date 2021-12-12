create or replace package test_public_api is
    --%suite(Test public_api package)

    --%test(Runs process procedure)
    procedure run_process;
end;
/