# 🛒 Zepto Quick-Commerce Data Analytics & Inventory Optimization
The project demonstrates practical use of PostgreSQL, data cleaning, exploratory analysis, aggregation, conditional logic, and business-oriented SQL analysis.

# 🎯 Project Objective
The objective of this project is to analyze Zepto’s inventory data using SQL to understand product availability, pricing, discounts, inventory levels, and potential revenue loss. The analysis aims to turn raw inventory data into useful business insights for better inventory and pricing decisions.

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

## 🛠️ Tools Used

- **PostgreSQL** — database & query engine
- **pgAdmin 4** — GUI for schema creation and CSV import
- **SQL** — schema design, data cleaning, and analysis queries
