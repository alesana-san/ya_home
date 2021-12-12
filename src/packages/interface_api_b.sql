create or replace package body interface_api is
    -- Inserts transaction to t_import table
    -- Returns record ID to the caller
    function insert_txn(
        p_txn_num   in varchar2,
        p_txn_date  in date,
        p_txn_sum   in number
    ) return number
    is
        l_id    number;
    begin
        if p_txn_num is null then
            raise_application_error(-20001, 'Transaction number cannot be null');
        elsif p_txn_date is null then
            raise_application_error(-20002, 'Transaction date cannot be null');
        elsif p_txn_sum is null then
            raise_application_error(-20003, 'Transaction sum cannot be null');
        end if;

        l_id := t_import_seq.nextval;

        insert into t_import(
            id,
            txn_num,
            txn_date,
            txn_sum
        ) values (
            l_id,
            p_txn_num,
            p_txn_date,
            p_txn_sum
        );

        return l_id;
    end;
end;
/