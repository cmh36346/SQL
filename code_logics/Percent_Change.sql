-- Percent Change 
-- Determine the percent change from version 04 to version 05
WITH testcases as (
    SELECT * FROM (
      VALUES
      ('group1', 'icd9', 5, 5),
      ('group1', 'icd10', 2, 2),
      ('group1', 'unknown', 2, 1),
      ('group1', 'snowmed', 1, 2),
      ('group2', 'icd9', 5, 5),
      ('group2', 'icd10', 5, 5),
      ('group2', 'unknown', 5, 5),
      ('group2', 'snowmed', 5, 5)
      )
      testcases (groupid, codetype, count_05, count_04)
)
, total as (
select groupid, cast(sum(count_05)as double) as tot_05, cast(sum(count_04) as double) as tot_04
from testcases
group by groupid
)
, pct as (
select a.groupid, a.codetype, 100.00*(a.ct_05/b.tot_05) as pct_05, 100.00*(a.ct_04/b.tot_04) as pct_04
from testcases a
join
total b
on a.groupid = b.groupid
)
, pct_chg as (
select groupid, codetype, pct_05, pct_04, ((pct_05-pct_04)/pct_04)*100 as pct_chg
from pct
)
SELECT * from pct_chg
order by groupid, codetype
;
