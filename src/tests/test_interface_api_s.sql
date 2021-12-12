create or replace package test_interface_api is
    --%suite(Test interface_api package)

    --%test(Inserts a row into import table)
    procedure insert_row;

    --%test(Inserts a row into import table with empty txn num)
    --%throws(-20001)
    procedure insert_row_with_empty_txn_num;
end;
/