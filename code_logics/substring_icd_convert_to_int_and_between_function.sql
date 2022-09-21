with testcases as (
    select * from (
        values
            (1, 'I9'),
            (1, 'I10.005'),
            
            (2, 'I11'),
            
            (3, 'I12'),
            
            (4, 'I12.005'),
            (4, 'I13'),
            
            (5, 'I16')
    ) testcases (ptid, icd)
) ,icd_number_only as (
    select ptid
        ,try_cast(substring(icd, 2) as double) as icd
    from testcases
) select ptid, icd
from icd_number_only
where icd > 10 and icd < 15
;
