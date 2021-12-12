create or replace package body public_api is

    -- Processes transaction
    procedure process_txn(
        p_txn_num   in varchar2,
        p_txn_date  in date,
        p_txn_sum   in number
    ) is
        l_process_result    boolean;
    begin
        l_process_result := dbms_random.value > 0.1;
        if not l_process_result then
            raise_application_error(
                -20010,
                'Error while processing Txn "' || p_txn_num || '" (' || to_char(p_txn_date, 'YYYY-MM-DD')
                    || ') with sum = ' || to_char(p_txn_sum)
            );
        end if;
    end;
end;
/