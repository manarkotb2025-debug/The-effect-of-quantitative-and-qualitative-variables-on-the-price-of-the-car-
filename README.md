# The Effect of Quantitative and Qualitative Variables on Car Prices

---

## 1. Project Overview
Understanding the drivers behind automobile pricing is essential for manufacturers, distributors, and buyers alike. This project performs an in-depth statistical and exploratory data analysis (EDA) to investigate **how quantitative features** (such as engine size, horsepower, and mileage) and **qualitative variables** (such as fuel type, body style, and brand reputation) influence the market price of cars.

By building a robust data processing pipeline, this project uncovers hidden correlations, evaluates statistical significance, and prepares the dataset for predictive modeling.

**Tools & Technologies Used:**
* **Python** – Main programming language for analysis
* **Pandas & NumPy** – Advanced data manipulation, feature engineering, and data cleaning
* **Matplotlib & Seaborn** – Data visualization and distribution plotting
* **SciPy / Statsmodels** – Statistical validation and hypothesis testing

---

## 2. Project Objectives
The primary goal of this analysis is to slice through raw automotive data to extract meaningful pricing insights. Key objectives include:
* **Quantify Feature Impact:** Determine which numerical and categorical variables have the strongest statistical relationship with car prices.
* **Data Sanitization:** Handle missing values, resolve structural inconsistencies, and engineer clean datasets.
* **Outlier Detection & Management:** Identify and manage data anomalies (e.g., extreme pricing or abnormal mileage) using statistical boundaries.
* **Deliver Actionable Insights:** Present trends that can aid strategic decision-making in automotive sales and pricing strategies.

---

## 3. Data Analytics Pipeline
The analytical workflow is structured through a clean, multi-step pipeline to ensure reproducibility:

```mermaid
flowchart LR
    A[Raw Car Dataset] --> B[Data Inspection & Profiling]
    B --> C[Handling Missing Values & Typos]
    C --> D[Outlier Detection & Filtering]
    D --> E[Feature Engineering & Transformation]
    E --> F[Exploratory Data Analysis - EDA]
    F --> G[Statistical Validation & Correlation]
    G --> H[Final Insights & Reporting]
git clone [https://github.com/manarkotb2025-debug/The-effect-of-quantitative-and-qualitative-variables-on-the-price-of-the-car-.git](https://github.com/manarkotb2025-debug/The-effect-of-quantitative-and-qualitative-variables-on-the-price-of-the-car-.git)
   cd The-effect-of-quantitative-and-qualitative-variables-on-the-price-of-the-car-
pip install pandas numpy matplotlib seaborn scipy
