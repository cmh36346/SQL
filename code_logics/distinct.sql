with testcases as (
    select * from (
        values 
            ('f_1', 'p_1'),
            ('f_2', 'p_2'),
            ('f_2', 'p_2.5'),
            ('f_3', 'p_3'),
            ('f_3', 'p_3')
    ) testcases (facilityid, providerid)
) select distinct(facilityid), providerid from testcases 
;
