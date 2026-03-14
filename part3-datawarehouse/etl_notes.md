## ETL Decisions

While cleaning the `retail_transactions.csv` raw data for the star schema, the following three key transformation decisions were made to ensure data quality and reporting accuracy.

### Decision 1 — Date Standardization and Key Generation
**Problem:** The raw data contained dates in multiple inconsistent formats (e.g., "01/11/2023", "2023-Nov-01", and "11-01-2023"). Inconsistent date formats prevent the database from performing chronological sorting and time-series analysis.
**Resolution:** During the ETL process, all date strings were parsed and converted into a standardized SQL `DATE` format (YYYY-MM-DD). Additionally, a numeric `date_key` (e.g., 20231101) was generated to act as a surrogate key for the `dim_date` table, ensuring faster join operations.

### Decision 2 — Category Case Uniformity
**Problem:** The 'category' field suffered from inconsistent casing, with entries like "ELECTRONICS", "electronics", and "Electronics" referring to the same group. A standard SQL query would treat these as three distinct categories, leading to fragmented and incorrect sales reports.
**Resolution:** I applied a `Proper Case` transformation (Capitalizing the first letter) to all string values in the category column. This standardized the dimension data, ensuring that all related products are correctly grouped under a single category heading in analytical reports.

### Decision 3 — Handling NULL and Inconsistent Numeric Measures
**Problem:** Some transactional rows contained NULL values or non-numeric characters in the `quantity` and `unit_price` fields. Loading these directly into the `fact_sales` table would result in calculation errors (NaN) when computing total revenue.
**Resolution:** I implemented a validation rule to handle missing values. For rows with missing `unit_price`, the value was cross-referenced from the `dim_product` master data. For rows with missing `quantity` that could not be verified, the records were excluded from the load to maintain the financial integrity of the warehouse metrics.