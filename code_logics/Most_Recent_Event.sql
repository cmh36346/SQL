-- Most Recent Event
-- Pulling the most recent lab result with specific result 

WITH test_lab AS (
    SELECT * FROM (
      VALUES
        -- case 1: should be returned
        (1, 'PSA', date('2020-01-01'), 9),
        -- case 2: should be returned
        (2, 'PSA', date('2007-01-01'), 5),
        -- case 3: Should not be returned
        (3, 'PSA', date('2002-01-01'), 3),
        -- case 3: Should be returned
        (4, 'PSA', date('2009-01-01'), 3)
      )
      test_lab (pid, test_name, dt, test_result)
    )
  SELECT A.pid
    ,dt
    ,CASE
        WHEN test_result >= 5 THEN 'PSA GE 5'
        WHEN test_result < 5 THEN 'PSA LT 5'
    END as event
  FROM test_lab A
  INNER JOIN (SELECT pid
        ,MAX(dt) AS dt_max
    FROM test_lab
    WHERE dt >= date('2007-01-01')
        AND test_name = 'PSA'
        GROUP BY 1 ) B
  ON A.pid = B.pid
    AND A.dt = B.dt_max
  WHERE A.test_name = 'PSA'
  ORDER BY pid
  ;
