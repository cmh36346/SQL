with testcases as (
    select * from (
        values 
            -- group A
            ('H200272', 1, 'dcc_1'),
            
            -- group B
            ('H200272', 2, 'dcc_2'),
            ('H200272', 2, 'dcc_2.5'),
            
            -- group A
            ('H200272', 3, 'dcc_3'),
            ('H200272', 4, 'dcc_3'), 
            
            -- not relevant
            ('H223937', 5, 'dcc_5'), 
            ('H223937', 5, 'dcc_5.5'), 
            
            ('H200272', 6, 'dcc_6'),
            ('H200272', 6, 'dcc_6.5'),
            ('H200272', 6, 'dcc_6.5')
    ) testcases (groupid, rxorderid, dcc)
) select distinct(dcc), rxorderid, groupid
from ( select a.groupid, a.rxorderid, b.dcc
    from (select groupid, rxorderid 
        from testcases 
        where groupid = 'H200272'
        group by groupid, rxorderid
        having count(distinct dcc) > 1 
    ) a
    join testcases b
    on a.rxorderid = b.rxorderid
)
group by dcc, rxorderid, groupid
order by groupid, rxorderid, dcc
;
