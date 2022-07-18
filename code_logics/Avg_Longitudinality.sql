with testcases as (
    select * from (
        values
            (1, date('2020-01-01'), 'migraine'),
            (2, date('2021-01-01'), 'migraine'),
            (3, date('2020-01-01'), 'migraine'),
            (4, date('2021-01-01'), 'migraine'),
            (5, date('2020-01-01'), 'migraine'),
            (6, date('2021-01-01'), 'migraine')
    ) testcases (ptid, dt, evt)
) ,table1 as (
    select * from (
        values
            (1, date('2007-01-01')),
            (1, date('2008-01-01')),
            (2, date('2007-01-01')),
            (2, date('2009-01-01')),
            (4, date('2007-03-01')),
            (5, date('2007-09-01'))
    ) table1 (ptid, dt)
) ,max_and_min as (
    select ptid, min(dt) as minimum_dt, max(dt) as maximum_dt
    from table1
    where ptid in (select ptid from testcases where evt = 'migraine')
    group by ptid
) select ptid, avg(date_diff('month', minimum_dt, maximum_dt))
from max_and_min
group by ptid
order by ptid
;
