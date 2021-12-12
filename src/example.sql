begin
    helper.spawn_workers();
    helper.spawn_producers();
end;
/
column job_name format a10
column state format a15
select d.job_name, d.state
from user_scheduler_jobs d
where (d.job_name like 'WORKER%' or d.job_name like 'PRODUCER%')
order by job_name;

exit;