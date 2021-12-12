create or replace package body process_mgr
is
    subtype t_txn_line is t_import%rowtype;
    c_worker_amount constant number := 4;
    c_worker_batch_size constant number := 10000;

    procedure process_txn(
        p_txn_line in out nocopy t_txn_line
    )
        is
    begin
        public_api.process_txn(
                p_txn_line.txn_num,
                p_txn_line.txn_date,
                p_txn_line.txn_sum
            );
        p_txn_line.process_result := 1;
    exception
        when others then
            p_txn_line.process_result := 2;
    end;

    procedure query_txn(
        p_txn_line in out nocopy t_txn_line
    )
        is
    begin
        select ti.*
        into p_txn_line
        from t_import ti
        where ti.id = p_txn_line.id;
    exception
        when no_data_found then
            null; -- skip missing lines
    end;

    procedure save_processing_result(
        p_txn_line in out nocopy t_txn_line
    )
        is
    begin
        update t_import t
        set t.process_result = p_txn_line.process_result
        where t.id = p_txn_line.id;
    end;

    procedure do_routine(
        p_worker_id in number
    )
        is
        type t_id_list is table of t_import.id%type index by binary_integer;

        l_id_list      t_id_list;
        l_fetched_rows number;
    begin
        loop
            -- Force using index to extract sorted rows
            select /*+USE_INDEX(t, t_import_i1)*/ t.id bulk collect
            into l_id_list
            from t_import t
            where t.process_result = 0
              and ora_hash(
                  t.txn_num || chr(10) || to_char(t.txn_date, 'DD.MM.YYYY HH24:MI:SS'),
                  c_worker_amount
              ) + 1 = p_worker_id
              and rownum <= c_worker_batch_size;

            l_fetched_rows := l_id_list.count;
            if l_fetched_rows is null then
                continue;
            end if;

            for i in 1 .. l_fetched_rows
            loop
                declare
                    l_txn_line t_txn_line;
                begin
                    l_txn_line.id := l_id_list(i);
                    query_txn(l_txn_line);
                    if l_txn_line.txn_num is null then
                        continue;
                    end if;
                    process_txn(l_txn_line);
                    save_processing_result(l_txn_line);
                    commit;
                end;
            end loop;
        end loop;
    end;
end;
/