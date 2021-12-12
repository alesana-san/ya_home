create or replace package body helper is

    procedure generate_rows
    is
        l_id            number;
        l_batch_count   number;
    begin
        loop
            l_batch_count := dbms_random.value(1, 1000);
            for i in 1 .. l_batch_count
            loop
                l_id := interface_api.insert_txn(
                    dbms_random.string('X', 10),
                    trunc(sysdate - dbms_random.value(1, 30)),
                    round(dbms_random.value() * 100, 2)
                );
            end loop;
            commit;
            dbms_session.sleep(1);
        end loop;
    end;

    procedure spawn_workers
    is
    begin
        for i in 1..4
        loop
            dbms_scheduler.create_job(
                job_name => 'WORKER' || to_char(i),
                job_type => 'PLSQL_BLOCK',
                job_action => 'BEGIN PROCESS_MGR.DO_ROUTINE(' || to_char(i) || '); END;',
                start_date => systimestamp,
                enabled => true,
                auto_drop => false
            );
        end loop;
    end;

    procedure kill_workers
    is
    begin
        for i in 1..4
        loop
            dbms_scheduler.drop_job(
                'WORKER' || to_char(i),
                true
            );
        end loop;
    end;

    procedure spawn_producers
    is
    begin
        for i in 1..3
        loop
            dbms_scheduler.create_job(
                job_name => 'PRODUCER' || to_char(i),
                job_type => 'PLSQL_BLOCK',
                job_action => 'BEGIN HELPER.GENERATE_ROWS; END;',
                start_date => systimestamp,
                enabled => true,
                auto_drop => false
            );
        end loop;
    end;

    procedure kill_producers
    is
    begin
        for i in 1..3
        loop
            dbms_scheduler.drop_job(
                'PRODUCER' || to_char(i),
                true
            );
        end loop;
    end;
end;
/