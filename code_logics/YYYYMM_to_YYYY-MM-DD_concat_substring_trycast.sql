with testcases as (
    select * from (
        values 
            (1, 202301)
    ) testcases (ptid, YYYYMM)
) select try_cast(concat(substring(try_cast(YYYYMM as varchar), 1,4), '-', substring(try_cast(YYYYMM as varchar), 5,6), '-01') as date)
from testcases 
