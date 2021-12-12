create table t_import(
    id              number(38) not null,
    txn_num         varchar2(100 char) not null,
    txn_date        date not null,
    txn_sum         number(18, 10) not null,
    ts_inserted     timestamp(6) with local time zone default localtimestamp not null,
    process_result  number(1) default 0 not null
);

create index t_import_i1 on t_import(process_result, ts_inserted);

create unique index t_import_pk on t_import(id) reverse;

alter table t_import
    add constraint t_import_pk primary key(id)
        using index t_import_pk;

comment on table t_import is 'Interface transaction import table';
comment on column t_import.id               is 'Interface table record ID';
comment on column t_import.txn_num          is 'Transaction number';
comment on column t_import.txn_date         is 'Transaction date';
comment on column t_import.txn_sum          is 'Transaction sum';
comment on column t_import.ts_inserted      is 'Timestamp when the record was inserted';
comment on column t_import.process_result   is 'Process status (0 - Not processed yet, 1 - Processed successfully, 2 - Failed to process';