# Phases 10 & 11: Business Insights, Recommendations, and Limitations

## 1. Top Business Insights
1. **The Premium Service Trap:** Fiber Optic internet has a 42% churn rate. However, when customers have Fiber Optic *without* Tech Support, churn hits 49%. When Tech Support is included, churn drops to 22%.
2. **The Ticket Breaking Point:** Customers logging 1-2 support tickets are stable. At 3-4 tickets, churn hits 39%. At 5+ tickets, churn is 100%. Five tickets is the definitive point of no return.
3. **The Revenue Disconnect:** Our overall churn rate is 26.5%, but our Revenue Churn is 30.5%. We are bleeding our high-paying customers (Q1 and Q2 quartiles) significantly faster than our budget customers (Q4).

## 2. Strategic Recommendations
| Problem Identified | Recommended Action | Expected Objective | KPI to Monitor |
|---|---|---|---|
| Fiber Optic instability | **Bundle Tech Support with Fiber.** Offer Tech Support free for the first 6 months on all Fiber plans. | Reduce early-tenure Fiber churn by masking the technical friction. | Fiber Optic Churn Rate (Target: < 30%) |
| Support Ticket fatigue | **Implement 'Ticket 3' Escalation.** Any customer logging their 3rd ticket in 6 months gets automatically routed to a senior retention specialist. | Intercept customers before they hit the 100% churn breaking point. | Churn rate of customers with 3-4 tickets |
| High M2M Churn | **Targeted Annual Upgrades.** For M2M customers surviving past month 9, offer a 10% MRR discount to lock into a 1-year contract. | Move customers out of the high-risk M2M pool once their initial value is proven. | % of M2M converting to Annual |

## 3. Data Limitations (Interview Defense)
*   **Correlation vs. Causation:** This is an observational dataset. We know that lack of Tech Support correlates with Fiber churn, but we cannot mathematically prove causation without an A/B test.
*   **Enrichment Caveat:** Metrics like support_tickets and cquisition_channel were dynamically simulated via SQL for portfolio demonstration purposes to show behavioral segmentation skills. 
