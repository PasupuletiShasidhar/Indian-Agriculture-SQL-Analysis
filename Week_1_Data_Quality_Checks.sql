/*
Indian Agriculture Crop Production & Yield Analysis
Week 1 - Data Acquisition, Cleaning & Preliminary Quality Checks

Database: Indian_Crop_Analysis
Raw table: crop_production_raw

Dataset source:
Kaggle - Indian Agriculture Crop Production and Yield
https://www.kaggle.com/datasets/arjunyadav99/indian-agriculture-crop-production-and-yield

Note:
The raw table is preserved. These queries perform profiling and
quality checks without deleting the original records.
*/

USE Indian_Crop_Analysis;
GO

/* 1. VERIFY TABLE STRUCTURE */
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'crop_production_raw'
ORDER BY ORDINAL_POSITION;
GO

/* 2. DATASET PROFILE */
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT State_Name) AS Distinct_States_UTs,
    COUNT(DISTINCT District_Name) AS Distinct_Districts,
    COUNT(DISTINCT Crop) AS Distinct_Crops,
    COUNT(DISTINCT Season) AS Distinct_Seasons,
    MIN(Crop_Year) AS Min_Crop_Year,
    MAX(Crop_Year) AS Max_Crop_Year
FROM crop_production_raw;
GO

/* 3. NULL / MISSING VALUE CHECK */
SELECT
    SUM(CASE WHEN State_Name IS NULL THEN 1 ELSE 0 END) AS Null_State,
    SUM(CASE WHEN District_Name IS NULL THEN 1 ELSE 0 END) AS Null_District,
    SUM(CASE WHEN Crop_Year IS NULL THEN 1 ELSE 0 END) AS Null_Crop_Year,
    SUM(CASE WHEN Season IS NULL THEN 1 ELSE 0 END) AS Null_Season,
    SUM(CASE WHEN Crop IS NULL THEN 1 ELSE 0 END) AS Null_Crop,
    SUM(CASE WHEN Area IS NULL THEN 1 ELSE 0 END) AS Null_Area,
    SUM(CASE WHEN Production IS NULL THEN 1 ELSE 0 END) AS Null_Production,
    SUM(CASE WHEN Yield IS NULL THEN 1 ELSE 0 END) AS Null_Yield
FROM crop_production_raw;
GO

/* 4. DUPLICATE CHECK */
SELECT
    State_Name,
    District_Name,
    Crop_Year,
    Season,
    Crop,
    Area,
    Production,
    Yield,
    COUNT(*) AS Duplicate_Count
FROM crop_production_raw
GROUP BY
    State_Name,
    District_Name,
    Crop_Year,
    Season,
    Crop,
    Area,
    Production,
    Yield
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;
GO

/* 5. WHITESPACE CHECK - STATE */
SELECT *
FROM crop_production_raw
WHERE State_Name <> LTRIM(RTRIM(State_Name));
GO

/* 6. WHITESPACE CHECK - TEXT COLUMNS */
SELECT *
FROM crop_production_raw
WHERE District_Name <> LTRIM(RTRIM(District_Name))
   OR Season <> LTRIM(RTRIM(Season))
   OR Crop <> LTRIM(RTRIM(Crop));
GO

/* 7. NEGATIVE VALUE CHECK */
SELECT *
FROM crop_production_raw
WHERE Area < 0
   OR Production < 0
   OR Yield < 0;
GO

/* 8. ZERO AND NEGATIVE VALUE SUMMARY */
SELECT
    SUM(CASE WHEN Production = 0 THEN 1 ELSE 0 END) AS Zero_Production,
    SUM(CASE WHEN Production < 0 THEN 1 ELSE 0 END) AS Negative_Production,
    SUM(CASE WHEN Yield = 0 THEN 1 ELSE 0 END) AS Zero_Yield,
    SUM(CASE WHEN Yield < 0 THEN 1 ELSE 0 END) AS Negative_Yield
FROM crop_production_raw;
GO

/* 9. NUMERICAL RANGE CHECK */
SELECT
    MIN(Crop_Year) AS Min_Crop_Year,
    MAX(Crop_Year) AS Max_Crop_Year,
    MIN(Area) AS Min_Area,
    MAX(Area) AS Max_Area,
    MIN(Production) AS Min_Production,
    MAX(Production) AS Max_Production,
    MIN(Yield) AS Min_Yield,
    MAX(Yield) AS Max_Yield
FROM crop_production_raw;
GO

/* 10. YIELD CONSISTENCY CHECK */
SELECT TOP 20
    State_Name,
    District_Name,
    Crop,
    Area,
    Production,
    Yield,
    Production / NULLIF(Area, 0) AS Calculated_Yield
FROM crop_production_raw
ORDER BY ABS(Yield - Production / NULLIF(Area, 0)) DESC;
GO

/* 11. DISTINCT STATES / UNION TERRITORIES */
SELECT DISTINCT State_Name
FROM crop_production_raw
ORDER BY State_Name;
GO

/* 12. DISTINCT SEASONS */
SELECT DISTINCT Season
FROM crop_production_raw
ORDER BY Season;
GO

/* 13. DISTINCT CROPS */
SELECT DISTINCT Crop
FROM crop_production_raw
ORDER BY Crop;
GO

/* 14. DISTINCT DISTRICTS */
SELECT DISTINCT District_Name
FROM crop_production_raw
ORDER BY District_Name;
GO

/*
WEEK 1 CLEANING DECISION

Results:
- Total records: 575,879
- NULL values: 0 across all columns
- Duplicate groups: none identified
- Leading/trailing whitespace: none identified
- Negative Area/Production/Yield: none identified
- Zero Production: 3,634 records
- Zero Yield: 3,634 records

Zero-production and zero-yield records were NOT deleted because
they may have business meaning and should be investigated during EDA.

The raw table is intentionally preserved for traceability.
*/
