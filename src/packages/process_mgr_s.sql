create or replace package process_mgr is

    procedure do_routine(
        p_worker_id in number
    );

end;
/