-- One Event Type Flag
-- Create a flag to identify individuals with one type of event

WITH testcases as (
    SELECT * FROM (
      VALUES
      (1, 'breast'),
      (1, 'breast'),
      (2, 'breast'),
      (2, 'skin'),
      (3, 'skin')
      )
      testcases (ptid, neoplasm_class_type)
) ,one_cancer_flag as (
    SELECT a.*, 'Y' as one_cancer_flag
    FROM testcases a
    where ptid not in (select ptid from testcases b where a.neoplasm_class_type != b.neoplasm_class_type )
) select a.* from one_cancer_flag a
union
select b.*, 'N' as one_cancer_flag from testcases b
where b.ptid not in (select ptid from one_cancer_flag)
;
