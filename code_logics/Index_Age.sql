with testcases as (
    select * from (
        values
            (1, date('2020-01-01'), 'Breast', '1990'),
            (1, date('2021-01-01'), 'Breast', '1990'),

            (2, date('2010-01-01'), 'Breast', '2000'),
            (2, date('2020-01-01'), 'Lung', '1992'),

            (3, date('2020-01-01'), 'Breast', '1932 and Earlier')
    ) testcases (ptid, dt, neoplasm, birth_yr)
) ,first_diag as (
select ptid, neoplasm, min(dt) as first_diag, birth_yr
from testcases
group by ptid, neoplasm, birth_yr
) ,years as (
select ptid, neoplasm, cast(extract(year from first_diag ) as int) as diag_yr, try_cast(substr(birth_yr, 1,4) as int) as birth_yr
from first_diag
)
select ptid, neoplasm, (diag_yr - birth_yr) as age
from years
order by ptid
;
