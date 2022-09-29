with testcases as (
    select * from (
        values
            (1, date('2022-01-01'), 'ALP'),
            
            (2, date('2022-01-01'), 'ALP'),
            (2, date('2020-01-01'), 'BUN'),
            
            (3, date('2022-01-01'), 'ALP'),
            (3, date('2020-01-01'), 'ALP'),
            (3, date('2021-01-01'), 'BUN'),
            
            (5, date('2022-01-01'), 'ALP'),
            (5, date('2020-01-01'), 'BUN'),
            (5, date('2021-01-01'), 'ALP'),
            
            (4, date('2022-01-01'), 'ALP'),
            (4, date('2022-01-01'), 'ALP')
            
            -- output should be
            /*
            ALP     1 count_lab     3 count_patients 
            ALP     2 count_lab     2 count patients 
            BUN     1 count_lab     3 count patients 
            */
    ) testcases (ptid, dt, lab)
) select lab, count_labs as count_events, count(ptid) as count_patients
from (select ptid, lab, count(distinct dt) as count_labs from testcases group by lab, ptid
)
group by lab, count_labs
order by lab, count_labs
;
