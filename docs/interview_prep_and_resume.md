# Phase 13: Resume Bullets & Interview Preparation

## 1. Resume Bullets
*Add this to your portfolio projects section:*

**Customer Churn Analysis (SQL Server, Power BI)**
* Engineered an end-to-end analytics pipeline, extracting and enriching telecom data (~7,000 records) using advanced T-SQL (CTEs, Window Functions, dynamic CASE logic) to simulate behavioral telemetry.
* Designed a Kimball-compliant Star Schema data model and developed dynamic DAX measures to analyze a + Monthly Recurring Revenue (MRR) pipeline.
* Discovered a 4% negative divergence between customer and revenue churn, identifying a "breaking point" in support ticket volume that informed a proposed escalation protocol.

## 2. Interview Q&A Prep

**Q: Why did you use this dataset? It's very common.**
*Answer:* "I intentionally used a recognizable dataset so we wouldn't spend time discussing abstract data structures, but I built a custom SQL enrichment layer on top of it. I used SQL functions to simulate behavioral data like support tickets and acquisition channels. This allowed me to demonstrate real SQL engineering and behavioral segmentation, rather than just basic flat-file reporting."

**Q: How did you handle data quality issues?**
*Answer:* "I found 11 records where Total Charges was blank. Upon investigation via SQL, I noticed their tenure was 0—they were brand new signups. Instead of deleting them and artificially lowering our acquisition metrics, I used a CASE statement to cast the blanks to 0.00."

**Q: What is the difference between Customer Churn and Revenue Churn?**
*Answer:* "Customer churn counts heads; revenue churn counts dollars. In this project, customer churn was 26.5%, but revenue churn was 30.5%. This meant we were losing our premium, high-paying customers faster than our budget customers. You can't see that if you only look at customer volume."

**Q: Did lack of tech support cause people to leave?**
*Answer:* "We have to be careful with causation. The data shows a strong correlation—Fiber optic customers without tech support churned at nearly 50%, while those with it churned at 22%. It strongly suggests a technical onboarding issue, which is why my recommendation was to bundle tech support, but as an analyst, I ensure we state it as an observational hypothesis rather than absolute mathematical causation."
