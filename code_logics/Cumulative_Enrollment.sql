-- Evaluate Cumulative Enrollment, as opposed to coninuous enrollment

with testcases as (
    select * from (
        values 
            (1, date('2020-01-01'), date('2021-01-01')),
            (1, date('2018-01-01'), date('2019-01-01')),
            
            (2, date('2020-01-01'), date('2020-06-01')),
            (2, date('2021-01-01'), date('2021-04-01'))
    ) testcase (ptid, eligeff, eligend)
) ,date_difference as (
    select ptid, date_diff('month', eligeff, eligend) as enrollment_duration
    from testcases 
) select ptid, 
    case 
        when sum(enrollment_duration) <= 5 then '0_5' 
        when sum(enrollment_duration) > 5 and sum(enrollment_duration) <= 11 then '6_11' 
        when sum(enrollment_duration) > 11 and sum(enrollment_duration) <=25 then '12_25' 
    end as cumulative_enrollment 
from date_difference
group by ptid
;
