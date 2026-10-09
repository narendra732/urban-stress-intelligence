# Urban Stress Intelligence

**A multi-source environmental analytics project for detecting unusual conditions, identifying contributing signals, and measuring anomaly persistence across cities.**

## Overview

Urban Stress Intelligence analyses daily environmental observations for Delhi, Tokyo, and New York during 2024. It brings together weather measurements, PM2.5 observations, and satellite fire thermal-anomaly detections to examine when environmental conditions depart from their expected patterns.

The project follows an analytics workflow from data collection and preparation through SQL analysis and Power BI reporting. The goal is to make environmental patterns easier to compare and investigate, while showing data coverage and methodological limitations alongside the results.

This is a portfolio analytics project, not an operational early-warning service. Its anomaly flags should be interpreted as signals for further investigation, not as proof of cause, a confirmed fire report, or a public-health assessment.

## Project Question

> Where are environmental conditions unusually abnormal, what signals contribute to those anomalies, and how persistent are they?

## Objectives

- Combine daily environmental observations into a consistent city-level analytical dataset.
- Clean and validate data, while distinguishing unavailable observations from true zero values.
- Use SQL to aggregate, compare, and investigate environmental patterns.
- Calculate standardized anomaly indicators and a combined anomaly score using project-defined rules.
- Explore city differences, anomaly frequency, contributing drivers, and persistence in Power BI.
- Make data completeness and interpretation limits visible to report users.

## Technology Stack

- **Python:** data collection, transformation, validation, and analysis
- **Pandas and NumPy:** tabular data manipulation and numerical calculations
- **SQL / MySQL:** data storage, joins, aggregations, window calculations, quality checks, and reporting views
- **Power BI Desktop:** interactive dashboards and analytical reporting
- **CSV and related data files:** data exchange between workflow stages

Use the actual notebooks, scripts, SQL files, and dependency list included in this repository when reproducing the workflow. The names of files may differ from the example folder structure below.

## Repository Structure

A clear repository layout is recommended so readers can find the code, data, SQL, and dashboards quickly.

```text
urban-stress-intelligence/
├── README.md
├── requirements.txt                 # Python dependencies, if provided
├── notebooks/                       # Jupyter notebooks, if used
├── src/                             # Python scripts, if used
├── sql/                             # SQL schema, analysis, and views
├── data/
│   ├── raw/                         # Original source files, where redistribution is permitted
│   └── processed/                   # Cleaned or final analytical datasets
└── powerbi/
    ├── 01_global_environmental_overview.pbix
    ├── 02_city_intelligence.pbix
    ├── 03_anomaly_detection.pbix
    ├── 04_driver_analysis.pbix
    ├── 05_data_quality.pbix
    └── screenshots/                 # PNG/JPG dashboard previews
```

This is a suggested structure. Rename your files or update the paths above to match what you actually upload. Keep credentials, API keys, passwords, and private configuration files out of the repository.

## Data and Analytical Model

The final analytical table is named `fact_environmental_anomaly` in the MySQL database `urban_stress_intelligence`. A city dimension, `dim_city`, holds city-level metadata. The Power BI model also uses a disconnected `Driver` table for driver-level summaries.

The analytical dataset contains **1,098 daily city records**: 366 dates in leap-year 2024 for each of three cities.

| City | Country | Period |
|---|---|---|
| Delhi | India | 2024 |
| Tokyo | Japan | 2024 |
| New York | United States | 2024 |

Fields in the final fact table include environmental measurements such as temperature, precipitation, wind speed, pressure, PM2.5, fire-detection counts and fire radiative power, alongside data-quality indicators, standardized anomaly values, driver flags, a compound score, anomaly level, and persistence measures. The exact fields depend on the final schema in the SQL files.

### Data quality considerations

- PM2.5 observations are missing for 7 records in the current dataset snapshot.
- Precipitation observations are missing for 14 records. Missing precipitation is not treated as zero rainfall.
- The nearest-fire-distance field is unavailable for many dates because a satellite detection may not be present. This should not automatically be interpreted as a data collection failure.
- Satellite thermal-anomaly detections are not equivalent to confirmed fires or a direct measurement of fire size. Detections may also be affected by satellite coverage and cloud conditions.
- Environmental source coverage and measurement availability can vary by city and date.

These figures describe the current project snapshot and may change if the data is refreshed or processing rules are revised.

## Methodology

1. **Collect and combine data.** Bring environmental measurements and satellite fire-detection records into a common daily, city-level analytical workflow.
2. **Clean and validate.** Review data types, dates, missing values, duplicate records, and coverage before analysis.
3. **Store and query.** Load the prepared data into MySQL and use SQL for joins, aggregations, time-based analysis, data-quality checks, and Power BI-ready views.
4. **Calculate anomaly signals.** Use standardized indicators and project-defined threshold rules for heat, PM2.5, wind, and fire-related signals.
5. **Build the compound score.** Combine qualifying signals into a daily score and assign an anomaly category. The result depends on the baseline, thresholds, and scoring rules used in this project.
6. **Analyse persistence.** Examine how many days an anomaly pattern continues and compare results across cities and drivers.
7. **Report findings.** Use Power BI to compare cities, investigate anomaly events, examine driver contributions, and communicate data-quality caveats.

The anomaly rules are analytical choices for this project; they should not be treated as a formally validated scientific or regulatory standard.

## Key Findings from the Current Dataset

- The dataset contains **1,098 records** across three cities for 2024.
- **129 city-days** are classified as anomaly days under the project's current rules.
- Anomaly-day counts are **44 for Tokyo**, **43 for Delhi**, and **42 for New York**.
- Delhi has the highest average PM2.5 value in this dataset snapshot, at approximately **102.07**, compared with **8.94 for Tokyo** and **7.71 for New York**. Interpret these values using the measurement units and source definitions recorded in the data documentation.
- Driver contribution counts are **51 PM2.5**, **47 wind**, **20 heat**, and **14 fire** days. Driver counts can overlap when multiple signals contribute on the same date; they should not be added together as a unique-day total.
- The maximum observed compound score is **2**, the longest observed persistence is **4 days**, and **3 days** are classified as multi-factor anomaly days. No days meet the project's current high-severity threshold of a compound score of 3 or more.

These are descriptive results from the current dataset and current anomaly definitions. They are not evidence that one environmental factor caused another.

## Power BI Reports

The project contains five Power BI report files, maintained separately. They represent five modules of the same analytical project; they are not merged into a single PBIX file.

| Report | Purpose |
|---|---|
| Global Environmental Overview | Summarises monitored cities, anomaly activity, driver counts, persistence, and selected data-quality indicators. |
| City Intelligence | Compares environmental profiles and anomaly activity across cities. |
| Anomaly Detection | Supports review of anomaly dates, scores, levels, drivers, and persistence. |
| Driver Analysis | Compares the contribution of PM2.5, wind, heat, and fire-related signals. |
| Data Quality | Presents source coverage, completeness, and interpretation notes. |

GitHub can store the `.pbix` files for download, but it does not render Power BI reports as interactive dashboards directly on the repository page. Include clear screenshots in `powerbi/screenshots/` so visitors can preview the work without downloading the files. To interact with a report, a reader can download the corresponding PBIX file and open it in Power BI Desktop. Data-source credentials or local database connection settings may need to be configured before refreshing.

## Reproducing the Project

The exact run order depends on the files included in this repository. A typical workflow is:

1. Clone or download the repository.
2. Install the Python dependencies listed in `requirements.txt`, if that file is included.
3. Configure local API and database credentials outside version control. Do not place keys or passwords directly in committed notebooks or scripts.
4. Run the data-collection and preparation notebooks or scripts in their documented order.
5. Create the MySQL database and tables using the supplied SQL files, then load the prepared data.
6. Run the analysis SQL and create any reporting views required by the Power BI reports.
7. Open the relevant PBIX file in Power BI Desktop and update its data-source settings if necessary.

For example, if a `requirements.txt` file is present, dependencies can usually be installed with:

```bash
python -m pip install -r requirements.txt
```

Do not run this command until the dependency file exists. If setup instructions or filenames are different in the repository, follow the instructions in the code files.

## Limitations and Responsible Interpretation

- The results describe three cities over one year and should not be generalised to all urban areas or other periods without further testing.
- Data coverage is not uniform across environmental sources, cities, and dates.
- Satellite fire detections indicate thermal anomalies and do not independently confirm a fire, its cause, or its size.
- Anomaly labels depend on the chosen baseline, standardisation method, thresholds, and compound-scoring approach. Different design choices may produce different results.
- The project identifies associations and unusual patterns; it does not establish causation.
- The dashboards are analytical and educational outputs. They are not a substitute for official monitoring, emergency systems, or public-health guidance.

## Future Improvements

- Document source names, API endpoints, retrieval dates, units, and licensing information in a dedicated data dictionary.
- Add automated data validation and logging for each refresh.
- Test anomaly thresholds against a longer historical baseline and perform sensitivity analysis.
- Expand geographic coverage and evaluate seasonal effects.
- Add reproducible environment configuration and a single, documented execution pipeline.
- Publish dashboard screenshots and, where appropriate, a view-only Power BI link in addition to the downloadable PBIX files.

## Author

Developed as a portfolio project demonstrating practical skills in data collection, data cleaning, Python, Pandas, NumPy, SQL, MySQL, anomaly analysis, data-quality assessment, and Power BI reporting.

## Disclaimer

This project is for learning, demonstration, and analytical exploration. The findings depend on the data available and the methodology implemented. No environmental, safety, health, or causal conclusions should be drawn beyond what the data and documented methods support.
