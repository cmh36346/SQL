with testcases as (
    select * from (
        values 
            -- should not appear 
            ('P_1', date('2022-01-01'), 'Gleason', 1, 1), 
            
            -- should appear 
            ('P_2', date('2022-01-01'), 'Gleason', 2, 3), 
            ('P_2', date('2022-02-02'), 'Gleason SCORE', 2, 2), 
            
            -- should appear 
            ('P_3', date('2022-01-01'), 'Gleason', 1, 1), 
            ('P_3', date('2022-02-01'), 'Gleason SCORE', 1, 1), 
            ('P_3', date('2022-03-01'), 'Gleason GRADE', 1, 1),
            
            -- should not appear 
            ('P_4', date('2022-01-01'), 'Gleason', 1, 1), 
            ('P_4', date('2022-01-01'), 'Gleason', 1, 1)
    ) testcases (ptid, encounterdate, system_name, grade_primary, grade_secondary)
) select *
from testcases a
inner join (
    select ptid
    from testcases 
    group by ptid
    having count(distinct(encounterdate)) > 1 ) b
    on a.ptid = b.ptid 
where upper(SYSTEM_NAME) like '%GLEASON%'
