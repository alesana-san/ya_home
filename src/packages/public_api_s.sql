create or replace package public_api is

    -- Processes transaction
    procedure process_txn(
        p_txn_num   in varchar2,
        p_txn_date  in date,
        p_txn_sum   in number
    );
end;
/