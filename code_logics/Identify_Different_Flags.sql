with groupid_list_06 as (
    select * from (
        values
            (1, 'N'),
            (2, 'Y')
    ) groupid_list_06 (ptid, note_eligible_ind)
) ,groupid_list_05 as (
    select * from (
        values
            (1, 'Y'),
            (2, 'Y')
    ) groupid_list_05 (ptid, note_eligible_ind)
) select ptid 
from groupid_list_06 a
where exists (
    select 1 from groupid_list_05 b
    where a.ptid = b.ptid
        and a.note_eligible_ind != b.note_eligible_ind
)
;
