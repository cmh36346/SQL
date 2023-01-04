with testcases as (
    select * from (
        values 
            -- should not appear 
            ('P_1', date('2022-01-01'), 'Gleason', 1, 1), 
            
            -- should not appear 
            ('P_2', date('2022-01-01'), 'Gleason', 2, 3), 
            ('P_2', date('2022-02-02'), 'Gleason SCORE', 2, 2), 
            
            -- should appear 
            ('P_3', date('2022-01-01'), 'Gleason', 1, 1), 
            ('P_3', date('2022-01-01'), 'Gleason SCORE', 2, 2), 
            -- should not appear
            ('P_3', date('2022-03-01'), 'Gleason GRADE', 1, 1),
            
            -- should appear 
            ('P_4', date('2022-01-01'), 'Gleason', 1, 1), 
            ('P_4', date('2022-01-01'), 'Gleason', 2, 3),
            ('P_4', date('2022-01-01'), 'Gleason', 3, 4)
    ) testcases (ptid, encounterdate, system_name, grade_primary, grade_secondary)
) select *
from testcases a
inner join (
    select ptid, encounterdate
    from testcases 
    group by ptid, encounterdate
    having count(*) > 1 ) b
    on a.ptid = b.ptid and a.encounterdate = b.encounterdate
where upper(SYSTEM_NAME) like '%GLEASON%'
