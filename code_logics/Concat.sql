WITH testcases as (
select * from (
    values
        ('a', '01'),
        ('b', '11'),
        ('c', '00')
    ) testcases (id, num)
)
SELECT id
    ,case
        when num like '0%' then concat('"',num)
        else num
    end as num
FROM testcases
;
