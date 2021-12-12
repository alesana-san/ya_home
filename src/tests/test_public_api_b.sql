create or replace package body test_public_api is
    procedure run_process
    is
        exc_process_error exception;
        pragma exception_init(exc_process_error, -20010);
    begin
        begin
            public_api.process_txn('test_txn', sysdate, '10.99');
        exception
            when exc_process_error then
                null;
        end;
    end;
end;
/