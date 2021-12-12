create or replace package interface_api is
    -- Inserts transaction to t_import table
    -- Returns record ID to the caller
    function insert_txn(
        p_txn_num   in varchar2,
        p_txn_date  in date,
        p_txn_sum   in number
    ) return number;
end;
/