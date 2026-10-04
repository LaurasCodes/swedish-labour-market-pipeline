# Swedish Labour Market Data Pipeline

An end-to-end data project analysing the Swedish job market. Job advertisements are collected from the public **JobTech JobSearch API** (Arbetsförmedlingen), cleaned and restructured with Python and pandas, and prepared for loading into a SQL Server data warehouse and a Power BI report.

**Status:** Stage 1 (extraction and preparation) is complete. The SQL Server star schema and Power BI reporting are in progress.

## Stage 1: Extraction and preparation (`01_extract_job.ipynb`)

**Extraction**
- Explored the API response structure (`hits`, `total`) on a small test request before scaling up
- Collected 500 job ads in batches of 100 using offset-based pagination, with `raise_for_status()` so a failed request stops the run
- Saved the untouched API response as a timestamped raw JSON file, so every later step can be traced back to the source

**Flattening nested JSON**
- Flattened each ad with `pd.json_normalize`, giving 90 columns
- Detected the 15 columns that still held lists or dictionaries and kept them out of the main staging table, leaving 75 flat columns

**Normalising requirements**
- Unpacked the nested `must_have` and `nice_to_have` fields (skills, languages, work experience, education, education level) into a separate long-format table: one row per job and requirement
- Result: 327 requirement records covering 171 job ads, each labelled by type and by level (Must Have / Nice to Have)

**Validation**
- Checked job IDs for duplicates: 500 records, 500 unique IDs
- Checked the requirements table for duplicate job–concept–type–level combinations: none found
- Profiled missing values (count and percentage per column) on the core job fields

**Outputs**
| File | Contents |
|---|---|
| `job_ads_source.csv` | One row per job ad (75 columns), the staging table for SQL Server |
| `job_requirements_source.csv` | One row per job requirement (327 rows), the source for a bridge table |
| `job_ads_raw_<timestamp>.json` | Untouched API response |

## Next stages (in progress)
- **SQL Server:** load the staging files and build a star schema with a job-ad fact table, dimensions (employer, occupation, location, date) and a job–requirement bridge table
- **Power BI:** report on demand by region, occupation and the most requested skills

## How to run

Requires Python 3.10+. No API key is needed; the JobTech JobSearch API is public.

```bash
pip install -r requirements.txt
jupyter notebook 01_extract_job.ipynb
```

The API returns the ads that are live when you run it, so a new run will collect a different set of 500 ads.

## Tools
Python · pandas · requests · Jupyter · JSON · SQL Server (in progress) · Power BI (planned)
