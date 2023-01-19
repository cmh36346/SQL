with testcases as (
    select * from (
        values 
            (1, NULL, 'A'),
            (2, 'b', 'B'),
            (3, 'c', 'C')
    ) testcases (ptid, val1, val2)
) select ptid,
    --NVL(val1, val2) as valu
    --ISNULL(val1, val2) as 
    coalesce(val1, val2)
from testcases 
