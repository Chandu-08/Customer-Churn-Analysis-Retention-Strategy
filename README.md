# Customer Churn Analysis & Retention Strategy

## Project Overview
An end-to-end Data Analytics portfolio project demonstrating the ability to extract, clean, model, and visualize data to solve a real-world business problem: **Customer Churn**. 

Instead of relying solely on a flat Kaggle dataset, this project features a **custom SQL-based enrichment layer**, engineered to simulate behavioral telemetry (support tickets, acquisition channels) and demonstrate advanced data modeling.

## 🛠️ Tech Stack
- **Database:** SQL Server (T-SQL, Views, Window Functions, CTEs)
- **Data Visualization:** Power BI (Star Schema, DAX, Interactive Dashboard)
- **Languages:** SQL, Python (for data processing simulation)

## 📂 Repository Structure
- /data/ - Raw and enriched CSV files.
- /sql/ - All T-SQL scripts (DDL, Data Quality, Feature Engineering, Star Schema).
- /dax/ - Power BI DAX measures.
- /docs/ - Business insights, dashboard layouts, and data dictionary.
- Customer_Churn_Dashboard.pbix - (Note: Download the file to view locally).

## 📊 Key Business Insights
1. **The Revenue Disconnect:** Customer churn is 26.5%, but **Revenue Churn is 30.5%**. We are disproportionately losing high-paying customers.
2. **The Ticket Breaking Point:** Customers logging 5+ support tickets churn at a rate of 100%. 
3. **The Fiber Optic Trap:** Premium Fiber internet without bundled Tech Support suffers a ~50% churn rate. Bundling support cuts churn in half (22%).

## 💡 Strategic Recommendations
- **Ticket #3 Escalation:** Automate routing to a specialized retention team on a customer's 3rd support ticket to prevent them from reaching the breaking point.
- **Fiber/Support Bundling:** Offer Tech Support free for the first 6 months on all Fiber Optic plans to bridge the technical onboarding gap.
