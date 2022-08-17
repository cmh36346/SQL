with table_1 as (
    select * from (
        values
            (1, 'diabetes'),
            (2, 'diabetes')
    ) table_1 (ptid, diag)
) ,table_2 as (
    select * from (
        values
            (1, 'breast cancer', 'cisplatin'),
            (2, 'breast cancer', 'cisplatin'),
            (3, 'breast cancer', 'cisplatin')
    ) table_2 (ptid, diag, rx)
) select ptid, diag, null as rx
from table_1
union
select ptid, diag, rx
from table_2
order by ptid
;
