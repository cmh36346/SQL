with cdr_202206 as (
    select * from (
        values 
            ('H123', 'Y'),
            ('H124', 'Y'),
            ('H125', 'Y'),
            ('H126', 'Y')
    ) cdr_202206 (groupid, cdr_flag)
) select groupid, 
    case
        when groupid = 'H123' then 'N'
        when groupid in (select groupid from cdr_202206) then 'Y'
        else 'Y'
    end as cdr_202206_flag
from cdr_202206 
;
