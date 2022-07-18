
-- Num pts with an HbA1C at least 3 years before diabetes  --------------------------------------------------------------------------------------------------------
WITH testcases AS (
SELECT * FROM (
  VALUES
    -- Case 1: shoud NOT be reported
    (1, DATE('2005-01-01'), 'hba1c'),
    (1, DATE('2004-01-01'), 'diabetes'),
    -- Case 2: should be reported
    (2, DATE('2005-01-01'), 'hba1c'),
    (2, DATE('2015-01-01'), 'diabetes'),
    -- Case 3: should not be reported
    (3, DATE('2005-01-01'), 'HbA1C'),
    (3, DATE('2007-12-31'), 'diabetes')
  ) testcases (pid, dt, concept)
)
SELECT DISTINCT pid, 'hba1c_3yr_before_diabetes' AS concept
FROM testcases a
WHERE a.concept = 'hba1c'
AND EXISTS (
  SELECT 1 FROM testcases b
  WHERE a.pid = b.pid
  AND b.concept = 'diabetes'
  AND date_diff('year', a.dt, b.dt) >= 3
  GROUP BY pid, b.dt, b.concept
  )
;

-- Num pts with metformin after diabetes diag --------------------------------------------------------------------------------------------------------
WITH testcases AS (
  SELECT * FROM (
  VALUES
    -- case 1: should not be returned
    (1, date('2020-01-01'), 'diabetes'),
    (1, date('2020-01-01'), 'metformin'),
    -- case 2: should be returned
    (2, date('2020-01-01'), 'diabetes'),
    (2, date('2020-03-01'), 'metformin'),
    -- case 3: should not be returned
    (3, date('2020-01-01'), 'diabetes'),
    (3, date('2009-01-01'), 'metformin'),
    -- case 4: should not be returned
    (4, date('2020-01-01'), 'metformin'),
    (4, date('2021-01-01'), 'diabetes')
    )
    testcases (pid, dt, concept)
  )
SELECT DISTINCT pid, 'metformin_after_diabetes' AS concept
FROM testcases a
WHERE a.concept = 'diabetes'
AND EXISTS (
  SELECT 1 FROM testcases b
  WHERE a.pid = b.pid
  AND b.concept = 'metformin'
  AND b.dt > a.dt
  )
ORDER BY pid ASC
;

-- WITH FIRST EVENT LOGIC --------------------------------------------------------------------------------------------------------
WITH testcases AS (
    SELECT * FROM (
    VALUES
      -- case 1: should not be returned
      (1, date('2020-01-01'), 'diabetes'),
      (1, date('2020-01-01'), 'metformin'),
      -- case 2: should be returned
      (2, date('2020-01-01'), 'diabetes'),
      (2, date('2020-03-01'), 'metformin'),
      -- case 3: should not be returned
      (3, date('2020-01-01'), 'diabetes'),
      (3, date('2009-01-01'), 'metformin'),
      -- case 4: should not be returned
      (4, date('2020-01-01'), 'metformin'),
      (4, date('2021-01-01'), 'diabetes')
      )
      testcases (pid, dt, concept)
    )
    ,ix_diabetes as (
        select a.*, row_number() over (partition by pid order by pid, dt asc) as row_num
          from testcases a
          WHERE concept = 'diabetes'
      )
  SELECT DISTINCT pid, 'metformin_after_diabetes' AS concept
  FROM ix_diabetes a
  WHERE a.concept = 'diabetes'
  AND row_num = 1
  AND EXISTS (
    SELECT 1 FROM testcases b
    WHERE a.pid = b.pid
    AND b.concept = 'metformin'
    AND b.dt > a.dt
    )
  ORDER BY pid ASC
  ;
