-- Create sample data ----------------------------------------------------------------------------------------------------------------
SELECT * FROM (
  VALUES
  (1, date('2020-01-01'), 'HbA1C', 5),
  (2, date('2020-01-01'), 'HbA1C', 3),
  (2, date('2020-01-01'), 'HbA1C', 9),
  (3, date('2020-01-01'), 'HbA1C', 4.99),
  (3, date('2020-01-01'), 'HbA1C', 5500)
  )
  testcases (pid, dt, test, result)
;

-- value at least 5 ----------------------------------------------------------------------------------------------------------------
WITH testcases AS (
  SELECT * FROM (
    VALUES
      -- Should be returned
      (1, date('2020-01-01'), 'HbA1C', 5),
      -- Should not be returned
      (2, date('2007-01-01'), 'HbA1C', 3),
      -- Should be returned
      (2, date('2012-01-01'), 'HbA1C', 9),
      -- Should not be returned
      (3, date('2009-01-01'), 'HbA1C', 4.99),
      -- Should be returned
      (3, date('2018-01-01'), 'HbA1C', 5500)
    )
  testcases (pid, dt, lab, value)
  )
SELECT pid, dt, 'lab_at_least_5' AS concept
FROM testcases
WHERE value >= 5
;

-- First test result >= 5 ----------------------------------------------------------------------------------------------------------------
WITH testcases AS (
  SELECT * FROM (
    VALUES
      -- Should be returned
      (1, date('2015-01-01'), 'HbA1C', 5),
      (1, date('2020-01-01'), 'HbA1C', 9),

      -- Should be returned
      (1.5, date('2019-01-01'), 'HbA1C', 9),
      (1.5, date('2015-01-01'), 'HbA1C', 5),

      -- Should not be returned
      (2, date('2012-01-01'), 'HbA1C', 3),
      (2, date('2017-01-01'), 'HbA1C', 5),

      -- Should not be returned
      (3, date('2009-01-01'), 'HbA1C', 4),
      (3, date('2018-01-01'), 'HbA1C', 4)
    )
  testcases (pid, dt, lab, value)
  )
SELECT pid, dt, 'lab_at_least_5' AS concept
FROM testcases a
WHERE value >=5
  AND EXISTS (
    SELECT 1 FROM testcases b
    WHERE a.pid = b.pid
      AND date_diff('day', a.dt, b.dt) >= 360
    )
;
