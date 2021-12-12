create or replace package body test_interface_api is

    procedure insert_row
    is
        l_id        number;
        l_result    number;
    begin
        l_id := interface_api.insert_txn(
            'test-txn1',
            date'2000-01-01',
            '10.99'
        );
        select count(*)
        into l_result
        from t_import ti
        where ti.id = l_id;

        ut.expect(l_result).to_equal(1);
    end;

    procedure insert_row_with_empty_txn_num
    is
        l_id        number;
    begin
        l_id := interface_api.insert_txn(
            null,
            date'2000-01-01',
            '10.99'
        );
    end;
end;
/