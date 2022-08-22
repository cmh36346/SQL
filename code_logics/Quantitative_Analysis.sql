-- Accounting for patients with at least two diagnoses?
HAVING COUNT(DISTINCT diag_date) >= 2

-- Example
-- Creating a table with the correct way to filter by more than one diagnosis
DROP TABLE pre_sales_db.CMH_PHARMA_3282
CREATE TABLE pre_sales_db.CMH_PHARMA_3282 AS
SELECT COUNT(distinct ptid) AS patients
FROM "market_clarity_panther_202105_v1_20210920_prod"."diag"
WHERE diag_date >= date '2007-01-01'
    AND diagnosis_cd LIKE '5790' OR diagnosis_cd LIKE 'K900'
GROUP BY ptid
    HAVING COUNT(DISTINCT diag_date) >= 2
;
