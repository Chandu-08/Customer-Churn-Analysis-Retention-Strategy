# Phase 9: Power BI Dashboard Design Rules & Layout

## Global Design Rules
- **Color Palette:** Professional & Accessible. 
  - Neutral Base: Dark Grey/Navy for text and axes.
  - Primary Highlight: Corporate Blue (for retained/total).
  - Alert/Warning: Muted Red/Orange (strictly reserved for Churn metrics).
- **Navigation:** Left-side collapsible navigation pane or top-tab navigation using Buttons + Bookmarks.
- **Interactivity:** All charts must cross-filter each other. 

## Page 1: Executive Overview (The 'What')
*Audience: C-Suite / VPs*
* **Top Row (KPI Cards):** Total Customers, Churn Rate %, Total MRR, Lost MRR.
* **Middle Left (Line Chart):** Churn Rate by Tenure Band (shows the "Danger Zone" in year 1).
* **Middle Right (Donut Chart):** Churn Volume by Contract Type.
* **Bottom (Matrix Table):** High-level summary by Acquisition Channel (Total Cust, Churned, Churn Rate, Lost MRR).

## Page 2: Driver Analysis (The 'Why')
*Audience: Product & Customer Success Managers*
* **Top Filter Slicers:** Internet Service, Contract Type.
* **Top Left (Clustered Bar Chart):** Churn Rate by Support Tickets (Shows the 100% churn at 5+ tickets).
* **Top Right (100% Stacked Bar):** Fiber Optic Churn: With Tech Support vs Without Tech Support.
* **Bottom (Ribbon Chart or Waterfall):** Primary Churn Reasons (Categorized by Competitor/Pricing vs Support/Service).

## Page 3: Revenue & Segment Focus (The 'Cost')
*Audience: Finance & Marketing*
* **Top Row:** Revenue Churn % vs Customer Churn % (Highlighting the 4% gap).
* **Main Visual (Scatter Plot):** Monthly Charges (X-axis) vs Tenure (Y-axis) with Churn as Legend (Red/Blue). Shows clusters of high-value early churners.
* **Right Side (Tornado Chart / Bar Chart):** Churn Rate by Value Quartile (Q1 to Q4).
