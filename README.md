# Indian Agriculture SQL Analysis

## Project Overview

This project analyzes Indian agricultural crop production and yield data using SQL Server. 
The project focuses on understanding agricultural production patterns across states, districts, crops, seasons, and years.

The project is being developed as part of a SQL Data Analyst – Agribusiness virtual internship.

## Dataset

The dataset contains district-level agricultural information from India covering crop production and yield.

### Dataset Details

- **Records:** 575,879
- **States/UTs:** 36
- **Districts:** 730
- **Crops:** 127
- **Seasons:** 6
- **Year Range:** 1997–2020

### Columns

| Column | Description |
|---|---|
| State_Name | State or Union Territory |
| District_Name | District name |
| Crop_Year | Agricultural year |
| Season | Crop season |
| Crop | Crop name |
| Area | Cultivated area |
| Production | Crop production |
| Yield | Crop yield |

## Data Source

The dataset was obtained from the publicly available Indian Agriculture Crop Production and Yield dataset on Kaggle.

Source:  
https://www.kaggle.com/datasets/arjunyadav99/indian-agriculture-crop-production-and-yield

The underlying agricultural data is based on publicly available Indian agricultural statistics.

## Tools Used

- **SQL Server**
- **SQL Server Management Studio (SSMS)**
- **GitHub**
- **Microsoft Word**

## Project Workflow

The project follows a structured data analytics workflow:

1. Dataset selection
2. Data acquisition and import
3. Database and table setup
4. Data profiling
5. Data quality checks
6. Missing-value analysis
7. Duplicate detection
8. Whitespace validation
9. Negative-value validation
10. Numerical range checks
11. Yield consistency validation
12. Preliminary data transformation
13. Exploratory Data Analysis (EDA)
14. Business insights and conclusions

## Week 1 – Data Acquisition & Cleaning

The first phase of the project focused on acquiring the dataset, importing it into SQL Server, and evaluating its initial quality.

### Data Quality Findings

The following checks were performed:

- **NULL values:** None found across the dataset columns.
- **Duplicate records:** No duplicate groups identified.
- **Leading/trailing whitespace:** No issues identified.
- **Negative values:** No negative Area, Production, or Yield values identified.
- **Zero Production:** 3,634 records.
- **Zero Yield:** 3,634 records.

Zero-production and zero-yield records were retained because they may have meaningful business or data-collection explanations. 
They will be investigated further during the EDA phase rather than being removed without evidence.

## SQL Analysis

The SQL scripts contain queries used for:

- Dataset profiling
- Schema verification
- NULL checks
- Duplicate checks
- Whitespace checks
- Negative-value checks
- Zero-value analysis
- Numerical range validation
- Yield consistency checks
- Distinct category analysis

## Repository Contents

```text
Indian-Agriculture-SQL-Analysis/
│
├── Week_1_Data_Quality_Checks.sql
│
└── Week_1_Indian_Crop_Data_Acquisition_and_Cleaning_Report.docx
