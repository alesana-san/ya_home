create or replace package helper is

    procedure generate_rows;

    procedure spawn_workers;

    procedure kill_workers;

    procedure spawn_producers;

    procedure kill_producers;
end;
/