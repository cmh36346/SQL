with testcases as (
    select * from (
        values 
            (1, 'None'),
            (1, 'None'),
            
            (2, 'None'),
            (3, 'Side Effects'),
            (4, 'Side Effects'),
            (5, 'Cost'),
            (5, 'Side Effects')
    ) testcases (ptid, reason_general)
) ,pt_tbl as (
    select * from (
        values 
            (1, 'Y'),
            (2, 'Y'),
            (3, 'Y'),
            (4, 'N'),
            (5, 'N')
    ) pt_tbl (ptid, has_notes)
) select a.reason_general, b.has_notes, count(a.ptid)
from testcases a
join pt_tbl b
on a.ptid = b.ptid
group by reason_general, has_notes

-- account for static and active pts 
with testcases as (
    select * from (
        values 
            (1, 'None'),
            (1, 'None'),
            
            (2, 'None'),
            (3, 'Side Effects'),
            (4, 'Side Effects'),
            (5, 'Cost'),
            (5, 'Side Effects')
    ) testcases (ptid, reason_general)
) ,pt_tbl as (
    select * from (
        values 
            (1, 'Y', '202112'),
            (2, 'Y', '202112'),
            (3, 'Y', '202008'),
            (4, 'Y', '200705'),
            (5, 'Y', '201501')
    ) pt_tbl (ptid, has_notes, source_data_through)
) select a.reason_general, 
    case
        when source_data_through = '202112' then 'active'
        else 'static'
    end as pt_activity, 
    count(a.ptid)
from testcases a
join pt_tbl b
on a.ptid = b.ptid
group by reason_general, case when source_data_through = '202112' then 'active' else 'static' end
