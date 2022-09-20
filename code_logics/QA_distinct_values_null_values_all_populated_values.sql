-- count distinct values 
-- count null values 
-- count all populated values 

with testcases as (
    select * from (
        values 
            (1, 'S01'),
            (2, NULL),
            (3, 'S02'),
            (4, 'S01'),
            (5, NULL),
            (6, 'S03')
    ) testcases (ptid, sourceid)
) select 'sourceid' as column_name
    ,count(distinct sourceid) as num_distinct
    ,sum(case when sourceid is null then 1 else 0 end) as num_null
    ,sum(case when sourceid is not null then 1 else 0 end) as total_pop
from testcases 
;
