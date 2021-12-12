begin
    for line in (
        select du.username
        from dba_users du
        where du.username = 'IMPORTER'
    ) loop
        execute immediate 'DROP USER ' || line.username || ' CASCADE';
    end loop;
end;
/
create user importer identified by importer;
grant unlimited tablespace to importer;
grant create session to importer;
grant create procedure to importer;
