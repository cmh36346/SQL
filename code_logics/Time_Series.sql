WITH testcases AS (
  SELECT * FROM (
    VALUES
    (1, date('2009-01-01'), 'prostate_cancer'),
    (2, date('2010-03-01'), 'prostate_cancer'),
    (2, date('2011-01-01'), 'diabetes'),
    (3, date('2010-01-01'), 'prostate_cancer'),
    (3, date('2012-01-01'), 'prostate_cancer')
    )
  testcases (pid, dt, concept)
  )
SELECT EXTRACT(YEAR FROM dt), COUNT(DISTINCT pid) as patients
FROM testcases
WHERE concept = 'prostate_cancer'
GROUP BY EXTRACT(YEAR FROM dt)
ORDER by EXTRACT(YEAR FROM dt)
;
