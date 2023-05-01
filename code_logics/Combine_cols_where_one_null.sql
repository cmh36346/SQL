WITH testcases as (
select * from (
    values
        ('a', '01'),
        ('b', '11'),
        ('c', '00'),
        (NULL, '000'),
        ('d', NULL)
    ) testcases (stage_prefix, stage_val)
)
SELECT coalesce(stage_prefix, '') || '*' || coalesce(stage_val, '')
FROM testcases
