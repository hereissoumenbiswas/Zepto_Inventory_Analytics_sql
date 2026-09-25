# 🛒 Zepto Quick-Commerce Data Analytics & Inventory Optimization
The project demonstrates practical use of PostgreSQL, data cleaning, exploratory analysis, aggregation, conditional logic, and business-oriented SQL analysis.

# 🎯 Project Objective
The objective of this project is to analyze Zepto’s inventory data using SQL to understand product availability, pricing, discounts, inventory levels, and potential revenue loss. The analysis aims to turn raw inventory data into useful business insights for better inventory and pricing decisions.

## 🛠️ Tools Used

- **PostgreSQL** — database & query engine
- **pgAdmin 4** — GUI for schema creation and CSV import
- **SQL** — schema design, data cleaning, and analysis queries

## 🛠️ Data Pipeline & Technical Architecture

### 1. Database Schema Design
The project uses PostgreSQL with explicit data types mapped to quick-commerce operational requirements:
* Primary keys assigned via auto-incrementing `SERIAL` constraints.
* Monetary columns (`mrp`, `discountedsellingprice`) structured using `NUMERIC(8,2)` to avoid floating-point rounding errors.
* Boolean flags (`outofstock`) for efficient availability filtration.

### 2. Data Cleaning & Preprocessing
* **Price Unit Standardisation:** Converted currency columns (`mrp` and `discountedsellingprice`) from paise values to rupees by dividing by $100.0$.
* **Invalid Record Removal:** Identified and removed corrupted rows where pricing was equal to $0$
* **Integrity Checks:** Verified zero duplicate records across primary attributes and confirmed zero critical `NULL` key fields.

## 📊 Executive KPIs

| KPI Metric | Verified Value | Business Impact |
| :--- | :--- | :--- |
| **Total Inventory Capital** | **₹22,43,092.00** | Total working capital currently tied up in physical dark store stock evaluated at actual selling prices. |
| **Out-of-Stock (OOS) Rate** | **12.14%** | Percentage of unique catalog SKUs currently unavailable for immediate fulfillment. |
| **In-Stock Rate** | **87.86%** | Active catalog availability for immediate order placement. |
| **Average Catalog Discount** | **17.62%** | Storewide promotional markdown depth across all listed products. |
| **Total Physical Stock Units** | **14,959 units** | Count of physical units available across all shelves in the dark store. |

## 🔍 Key Findings & Analysis Results

* **High-Value Lost Revenue Recovery:** Out-of-stock items create a lost revenue risk of **₹11,102.50** across **12.14%** of catalog SKUs.
* **Category Capital Distribution:** Total inventory capital is **₹22,43,092.00**. Capital is concentrated in **Fruits & Vegetables**, **Munchies & Snacks**, and **Dairy, Bread & Eggs**. **Beauty, Hygiene & Cleaning**.
* **High-Value Margin Drivers:** Products priced above **₹500.00** carrying discount markdowns below **10.00%** account for primary store gross margins.
* **Logistical Weight Bucket Distribution:** **14,959 total available quantity** across all SKUs, segmented into three weight categories:
  * **Low Weight ($\le 500\text{g}$):** **12,902 units** (**86.25%**)
  * **Medium Weight ($501\text{g} - 1000\text{g}$):** **1,446 units** (**9.67%**)
  * **High Weight ($> 1000\text{g}$):** **611 units** (**4.08%**)
 
## 🔗 Connect

**Author:** Soumen Biswas
*(https://www.linkedin.com/in/hereissoumenbiswas/)*

*A practice project to strengthen SQL skills - schema design, data cleaning, and business-question analysis.*
