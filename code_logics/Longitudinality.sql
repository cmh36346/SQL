WITH testcases AS (
    SELECT * FROM (
        VALUES
        -- should be reported
        (1, date('2020-01-01'), 'diabetes')
        -- Should not be reported
        ,(1, date('2020-03-01'), 'diabetes')
        -- should not be reported
        ,(2, date('2020-01-01'), 'diabetes')
        -- should not be reported
        ,(3, date('2015-01-01'), 'diabetes')
    )
    testcases (pid, dt, diag)
)
    ,ix_diabetes AS (
        SELECT a.*
            ,row_number() OVER (PARTITION BY pid ORDER BY pid, dt ASC) as row_num
        FROM testcases a
        WHERE diag = 'diabetes'
    )
    ,enrollment AS (
        SELECT * FROM (
            VALUES
            (1, date('2010-01-01'), date('2021-01-01'))
            ,(2, date('2010-01-01'), date('2020-01-01'))
            ,(3, date('2014-09-01'), date('2021-01-01'))
        )
    t0 (pid, ce_st, ce_en)
)
SELECT pid, dt
    ,'ce_gte_6m_bf_and_aft_diag' AS event
FROM ix_diabetes a
WHERE row_num = 1
AND EXISTS (
    SELECT 1 from enrollment b
    WHERE a.pid = b.pid
        AND date_diff('day', ce_st, a.dt) >=180
        AND date_diff('day', a.dt, ce_en) >= 180
)
ORDER BY pid ASC
;
