WITH six as (
select * from (
    values
        ('a'),
        ('b'),
        ('c')
    ) six (groupid)
) ,five as (
    select * from (
        values 
            ('b'),
            ('d')
    ) five (groupid)
) select groupid from five
where groupid not in (select groupid from six)
;
