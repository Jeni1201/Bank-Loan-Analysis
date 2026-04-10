# Bank Loan Analysis
# End-to-End Analytics for Lending Operations & Risk Assessment

## Project Overview
A comprehensive analysis of 38,000+ bank loan records to monitor lending activities and risk. By integrating **SQL Server** for backend data integrity and **Power BI** for interactive storytelling, the dashboard identifies critical trends in loan volume, repayment performance, and risk distribution.

## Tech Stack
- **Database:** MS SQL Server.
- **Visualization:** Power BI Desktop.
- Language: DAX (Data Analytics Expressions)

- **Key Skills:** 
	- DAX (Time Intelligence), Field Parameters, Custom Grouping,
  - Data Modelling (Star Schema)
	- SQL Joins & Aggregations, Windows function. 

## Core KPI's 
We tracked 5 core metrics:
1. **Total Applications :-** (Including MTD and MoM growth).
2. **Total Funded Amount :-** Total disbursed capital.
3. **Total Amount Received :-** Total repayments from borrowers.
4. **Avg Interest Rate :-** Portfolio yield.
5. **Avg DTI :-** Risk assessment metric (Ideal range 30-35%).

## **Key Technical Highlights**

- **Data Reliability (SQL):** Conducted database creation, schema design, and query-based validation to ensure that Power BI KPIs exactly match the underlying source data.
    
- **Advanced Modeling (Power BI):** Developed a **Star Schema** with a custom **Date Table** to support complex **Time Intelligence** (MTD, PMTD, and MoM growth).
    
- **Visualisation:** Used **Field Parameters** to allow users to toggle between metrics like "Funded Amount" and "Total Applications" on a single chart, optimizing dashboard real estate.

## 💡 Key Insights 
- **86.2%** of the portfolio consists of "Good Loans" (Fully Paid/Current), representing **$370.2M** in funded capital.
- The bank has received **$435.8M** in payments from "Good Loans," already exceeding the funded amount and demonstrating a profitable lending cycle.
- **13.8%** of loans are "Charged Off," representing **$65.5M** in funded capital with only **$37.3M** recovered, highlighting a key area for risk mitigation.
- **Debt Consolidation** emerged as the primary loan purpose, accounting for **3.8K** applications in the analyzed segment.
- **Grade A** loans have lower interest rates (~7.5%) compared to the portfolio average of **12.0%**, reflecting risk-based pricing.

## Dashboards Preview
<img width="1280" height="719" alt="SUMMARY dashboard" src="https://github.com/user-attachments/assets/eb0b642e-6d06-4569-8a31-1fd4b80774a0" />
<img width="1276" height="717" alt="OVERVIEW dashboard" src="https://github.com/user-attachments/assets/a4013d1e-167f-49d4-8eea-17fab2c52e73" />
<img width="1275" height="716" alt="DETAILS dashboard" src="https://github.com/user-attachments/assets/04bb8fbe-dc69-4c52-ba33-d5c10850e44d" />

