# Layoff-trend-forecasting
I cleaned and analyzed companies layoffs dataset in SQL. I deduplicated records, fixed text errors, formated dates and inserted missing industry values by self-joins. Then, I ran EDA using window functions and CTEs to track rolling monthly totals, total startup liquidations, and top company layoffs per year.

Detailed review :

This project demonstrates end-to-end data processing and exploratory analysis workflow in MySQL with a dataset of global tech layoffs. The objective was to clean a messy raw dataset with duplicate entries, missing values and formatting errors to a neat and trustworthy data structure to attain meaningful business insights on workforce reductions worldwide.

The project started with a staging strategy. I created a duplicate working table (layoffs_staging) instead of running transformation steps on the primary source tables. This step ensured all cleaning actions were safely isolated, preserving the original raw records so that raw values could be referenced or restored at any point.

After deduplication, I did text standardization and categorical cleaning. I cleaned up company names by removing trailing and leading whitespace, fixing misspelled location names and typos (e.g. “Unites States”), and correcting text encoding errors. I also normalized category variants, e.g., merging different “Crypto” entries into a single industry classification.

Since the raw date values were stored as plain text strings, I parsed & formatted them with SQL date conversion functions (STR_TO_DATE) and I also permanently changed the column data type to a native SQL DATE format. This allowed full time-series features such as filtering and grouping records by month or year.I then addressed missing data by converting blank string values to standard NULL values, imputing missing industry values by joining companies against themselves where populated records existed, and dropping unusable records where both layoff counts and percentages were missing.

Finally, I performed an exploratory data analysis to assess macroeconomic impact. I aggregated layoff volumes by industry, country, and stage of company. I also found some startup liquidations where 100% of the staff were let go, created a cumulative month over month running total using rolling window aggregations, and used Common Table Expressions (CTE’s) with ranking functions (DENSE_RANK()) to find the top 3 companies with the largest workforce reductions for each calendar year.
