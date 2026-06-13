# The Effect of Quantitative and Qualitative Variables on the Price of the Car

---

## 1. **Project Overview**

The automotive market is influenced by a complex interplay of quantitative metrics (e.g., horsepower, engine size) and qualitative features (e.g., brand prestige, fuel type).  

This project analyzes a comprehensive car dataset (`CarPrice_Assignment.csv`) to understand how these different variables impact vehicle pricing. It builds a complete **data analytics pipeline** and an interactive **Power BI dashboard** to visualize these insights.  

**Tools Used:**

* **R (tidyverse, dplyr)** – Data cleaning, brand text correction, and feature engineering  
* **Excel** – Initial exploration and validation  
* **Power BI** – Data modeling, DAX calculations, interactive dashboards  

---

## 2. **Project Objective**

The main goal is to build a **data-driven pricing intelligence system** for car market analysis that enables stakeholders to:

* Monitor **car price distributions and market trends** * Track the impact of **quantitative variables** (horsepower, engine size, mileage) on price  
* Evaluate **qualitative features** (body style, fuel type, drive wheel) on vehicle valuation  
* Analyze **brand premium factors** across different manufacturers  
* Enable **interactive exploration** of automotive specifications  

---

## 3. **Key Stakeholders**

The system is designed for:

* **Car Dealership Managers** – Optimize pricing strategies and inventory management  
* **Automotive Market Analysts** – Track consumer trends and vehicle feature valuations  
* **Product Managers (Auto Industry)** – Understand which technical specifications justify premium pricing  
* **Business Analysts** – Generate insights and competitive reports  

---

## 4. **Key Performance Indicators (KPIs)**

The dashboard calculates and tracks:

* **Average Vehicle Price** * **Total Car Models Analyzed** * **Price Premium by Brand** (Prestige Factor)  
* **Horsepower-to-Price Efficiency** * **Depreciation & Mileage Impact** * **Fuel Efficiency Metrics** (City vs Highway MPG)  

---

## 5. **System Architecture**

The project follows a **multi-layer analytics pipeline**:

```mermaid
flowchart LR
    A[Raw Car Dataset] --> B[R Scripts Exploration]
    B --> C[R Data Cleaning & Typo Fixes]
    C --> D[Processed Star-Schema Datasets]
    D --> E[Power BI Data Model]
    E --> F[DAX Pricing Measures]
    F --> G[Interactive Dashboard]
    G --> H[Pricing Insights]
