````markdown
# 🚀 AWS Data Lake Analytics Project: S3 → Glue → Athena → QuickSight  

## 📌 Project Overview  
This project demonstrates how to build a **serverless data analytics pipeline** using AWS services.  
The workflow covers **secure data ingestion, schema cataloging, partitioned querying, logging, and visualization**.  

The dataset used is an **orders dataset** (Superstore-style). The goal is to show how raw CSV files in Amazon S3 can be transformed into **business insights** with minimal infrastructure.  

---

## 🛠️ Services Used  
- **AWS IAM** → Created dedicated IAM user for secure workflow execution  
- **Amazon S3** → Storage layer for raw CSV data (partitioned manually month by month)  
- **AWS Glue** → Crawler + Data Catalog to infer schema and update partitions  
- **Amazon Athena** → Serverless SQL querying on partitioned S3 data  
- **Amazon QuickSight** → Dashboards for data visualization  
- **CloudWatch Logs** → Enabled query logs for Athena  

---

## 🚀 Architecture Workflow  
1. **IAM User** → Created with restricted permissions for security.  
2. **Amazon S3** → Raw CSV files uploaded and manually partitioned month by month.  
3. **AWS Glue Crawler** → Configured to scan data, register schema, and update catalog.  
   - Set filters to crawl **only new files** → avoids duplicates.  
   - Multiple datasets added incrementally.  
4. **Athena** → Queried Glue-cataloged data with **monthly partitions** for cost optimization.  
   - Example: filter by `order_month = '2025-07'`.  
   - Query logs captured for monitoring.  
5. **QuickSight** → Built dashboards using Athena queries to generate insights.  

![Architecture Diagram](screenshots/architecture_diagram.png)
<img width="685" height="268" alt="AWSWorkflow drawio" src="https://github.com/user-attachments/assets/429bbd8c-6dac-41a2-b786-6ca0df7f05e8" />
 

---

## 📊 Athena Queries  
Some example queries used in this project (full queries in [`/athena_queries`](athena_queries/)):  

```sql
-- Sales by category
SELECT category, SUM(sales) AS total_sales
FROM orders_partitioned
WHERE order_month = '2025-07'
GROUP BY category
ORDER BY total_sales DESC;

-- Monthly sales trend
SELECT order_month, SUM(sales) AS total_sales
FROM orders_partitioned
GROUP BY order_month
ORDER BY order_month;
````

---


This project did not use a Glue ETL script. Instead, we relied on a Glue Crawler, configured to:

Scan only new S3 files (incremental crawl).

Avoid duplicate crawls of existing datasets.

Update the Glue Data Catalog database db_aws-etl-demo.

Configuration is available in glue_scripts/crawler_config.json

---

## 📈 QuickSight Dashboard

The QuickSight dashboard was created with the following visuals:

* **Sales by Category (Bar Chart)**
* **Sales by Region (Pie Chart)**
* **Monthly Sales Trend (Line Chart)**
* **Top Products by Revenue (Table)**

Screenshots:
![Sales by Category](screenshots/quicksight_sales_by_category.png)
![Sales by Region](screenshots/quicksight_sales_profit_region.png)
![Monthly Trend](screenshots/quicksight_monthly_trend.png)
![Top Products](screenshots/quicksight_top_products.png)

---

## 🌟 Key Learnings

* How to build an **end-to-end serverless analytics pipeline** using AWS.
* Benefits of **partitioning Athena tables** for query cost and performance optimization.
* Importance of **query logging** for monitoring and auditing.
* Designing **interactive dashboards** in QuickSight.

---

## 🔮 Future Enhancements

* Automate partitioning with **Glue ETL jobs** instead of manual CSV splitting.
* Store curated datasets in **Parquet format** for faster Athena queries.
* Trigger crawlers automatically with **EventBridge** when new files land in S3.
* Extend pipeline into **Amazon Redshift** for enterprise-scale analytics.

---

## 📚 Resources

* [AWS Glue Documentation](https://docs.aws.amazon.com/glue/)
* [Amazon Athena Documentation](https://docs.aws.amazon.com/athena/)
* [Amazon QuickSight Documentation](https://docs.aws.amazon.com/quicksight/)

```
