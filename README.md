The Effect of Quantitative and Qualitative Variables on the Price of the Car
1. Project Overview
The automotive market is influenced by a complex interplay of quantitative metrics (e.g., horsepower, engine size) and qualitative features (e.g., brand prestige, fuel type).

This project analyzes a comprehensive car dataset (CarPrice_Assignment.csv) to understand how these different variables impact vehicle pricing. It builds a complete data analytics pipeline using R and an interactive Power BI dashboard to visualize these insights.

Tools Used:

R (tidyverse, dplyr) – Data cleaning, brand text correction, and feature engineering.

Excel – Initial data exploration and data dictionary verification.

Power BI – Data modeling (Star/Galaxy Schema), DAX calculations, and interactive dashboarding.

2. Project Objective
The primary objective is to build an interactive pricing intelligence system that enables auto manufacturers, dealerships, and analysts to:

Evaluate how quantitative variables (mileage, engine specs) correlate with car prices.

Measure the impact of qualitative variables (body style, fuel type, brand) on market value.

Segment the market into luxury vs. budget categories based on statistical features.

Provide an interactive tool for stakeholders to predict pricing trends based on vehicle specifications.

3. Key Stakeholders
The system is designed for:

Car Dealership Managers – To optimize pricing strategies for inventory.

Automotive Market Analysts – To track consumer trends and feature valuations.

Product Managers (Auto Industry) – To understand which specifications justify premium pricing.

4. Key Performance Indicators (KPIs)
The dashboard calculates and tracks:

Average Vehicle Price

Total Car Models Analyzed

Price Premium by Brand (Prestige Factor)

Horsepower-to-Price Efficiency

Depreciation Impact (Mileage vs. Price Rate)

Fuel Efficiency Metrics (City vs. Highway MPG correlations)

5. System Architecture
The project follows a multi-layer analytics pipeline:

flowchart LR
    A[Raw Car Dataset] --> B[R Scripts Exploration]
    B --> C[R Data Cleaning & Typo Fixes]
    C --> D[Processed Star-Schema Datasets]
    D --> E[Power BI Data Model]
    E --> F[DAX Pricing Measures]
    F --> G[Interactive Dashboard]
    G --> H[Pricing Insights]

Architecture Layers1. Data Source LayerRaw dataset containing technical specs, categorical features, and historical market prices of vehicles.2. Data Processing LayerR Scripts used to fix spelling mistakes in car brands (e.g., correcting maxda to mazda, vokswagen to volkswagen) and split categorical specifications from numerical indicators.3. Analytics LayerStar/Galaxy schema modeling within Power BI, defining relationships between facts and dimensional categories.4. Visualization LayerDynamic dashboards displaying price distribution, scatter plots for numerical correlations, and bar charts for categorical feature weights.6. System Analysis6.1 Input Data StructureAttributeDescriptionTypecar_IDUnique identifier for each vehicle recordQuantitativeCarNameFull name of the car (Brand + Model)QualitativefueltypeFuel used (Gas vs. Diesel)QualitativecarbodyBody style (Sedan, SUV, Hatchback, Convertible)QualitativedrivewheelDrive type (FWD, RWD, 4WD)Qualitativewheelbase / carlengthPhysical dimensions of the carQuantitativeenginesizeEngine displacement capacityQuantitativehorsepowerTotal engine power outputQuantitativecitympg / highwaympgFuel economy metricsQuantitativepriceTarget variable: Final market price of the carQuantitative6.2 System ProcessingThe pipeline automates:Extracting the core Car Brand from the raw CarName string using R.Handling typo fixes for global brands to avoid duplicate categories in R.Normalizing numerical variables to evaluate their direct correlation coefficients against price.Dividing data into explicit dimension tables (DIM_CAR_CATALOG, DIM_ENGINE_SPECS) and fact tables (FACT_CAR_PRICING).6.3 System Outputs (Dashboard Layout)The final Power BI dashboard delivers:Executive Pricing Overview: High-level cards for Average Price, Max Price, and Brand Counts.Technical Performance Analysis: Scatter plots showing how horsepower and enginesize affect price.Categorical Feature Impact: Visual breakdown of price variations across carbody styles and fueltype.Efficiency vs Luxury Matrix: Cross-analyzing fuel economy (MPG) against total vehicle cost.6.4 Data Model (Galaxy Schema)Code snippeterDiagram

FACT_CAR_PRICING {
    int car_ID
    int Catalog_ID
    int Engine_SpecID
    int symboling
    float price
    int curbweight
}

FACT_ENGINE_PERFORMANCE {
    int car_ID
    int enginesize
    int horsepower
    int peakrpm
    float citympg
}

DIM_CAR_CATALOG {
    int Catalog_ID
    string Car_Brand
    string carbody
    string drivewheel
}

DIM_ENGINE_SPECS {
    int Engine_SpecID
    string fueltype
    string enginetype
    string cylindernumber
}

DIM_CAR_CATALOG ||--o{ FACT_CAR_PRICING : categorizes
DIM_ENGINE_SPECS ||--o{ FACT_CAR_PRICING : configures
FACT_CAR_PRICING ||--|| FACT_ENGINE_PERFORMANCE : analyzes
7. Key DAX MeasuresAverage Car PriceCode snippetAverage Price = AVERAGE(FACT_CAR_PRICING[price])
Total Models TestedCode snippetTotal Vehicles = COUNT(FACT_CAR_PRICING[car_ID])
High-End Premium ThresholdCode snippetPremium Vehicle Count = 
CALCULATE(
    COUNT(FACT_CAR_PRICING[car_ID]), 
    FACT_CAR_PRICING[price] > 20000
)
Horsepower to Price RatioCode snippetPrice Per HP = DIVIDE(SUM(FACT_CAR_PRICING[price]), SUM(FACT_ENGINE_PERFORMANCE[horsepower]), 0)
8. Repository Structurecar-price-variables-analysis

├── data
│   ├── CarPrice_Assignment.csv
│   └── powerbi_tables/
│       ├── dim_car_catalog.csv
│       ├── dim_engine_specs.csv
│       ├── fact_car_pricing.csv
│       └── fact_engine_performance.csv
│
├── R
│   └── data_cleaning.R
│
├── powerbi
│   └── car_price_analytics.pbix
│
└── README.md
9. Expected InsightsThe dashboard effectively answers the following strategic questions:Engine Size & Power: Engine size and horsepower show the strongest positive correlation with a car's price.Brand Premium: Brands like BMW, Porsche, and Jaguar retain a structural price premium regardless of minor changes in standard features.Body Style Trends: Hardtop and convertibles average higher baseline prices compared to standard sedans and hatchbacks.Fuel Efficiency vs Price: Highly fuel-efficient vehicles (high MPG) generally occupy the budget segment, while low-efficiency vehicles dominate the performance and luxury high-priced sectors.
