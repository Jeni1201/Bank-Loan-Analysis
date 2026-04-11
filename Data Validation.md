# Data Validation  

## SQL Highlights

_KPI 1 : Total Loan Applications_
```sql
	-- Total loan applications
select COUNT(id) as total_loan_applications 
FROM bank_loan_data;

	-- Month-to-Date loan applications , Month-over-Month changes
select 
	month(issue_date) month_no,
	DATENAME(month, issue_date) Month_Name,
	COUNT(id) as MTD_loan_applications,
	LAG(COUNT(id),1) OVER(ORDER BY month(issue_date)) PMTD_loan_applications,  --Previous month-to-date
	COUNT(id) - LAG(COUNT(id),1) OVER(ORDER BY month(issue_date)) MoM_change
from bank_loan_data
GROUP BY month(issue_date),DATENAME(month, issue_date)
order by month(issue_date);
```
<img width="493" height="300" alt="image" src="https://github.com/user-attachments/assets/dd3b38c0-e0f9-46d3-a8e0-eb42b3339c7c" />
<img width="205" height="127" alt="image" src="https://github.com/user-attachments/assets/7b7e64ce-203f-4372-92d0-5b6875c5947b" />

MoM_change_% = MoM_change / PMTD         
December = 279 / 4035 = 0.069144 or 6.9%

---
_KPI 2 : Total Funded amount_
```sql
	-- total funded amount
select SUM(loan_amount) Total_Funded_amount
FROM bank_loan_data;

	--MTD funded amount , MoM changes
select 
	YEAR(issue_date) year_,
	MONTH(issue_date) month_name, 
	SUM(loan_amount) MTD_Funded_amount,
	LAG(SUM(loan_amount), 1) OVER(ORDER BY month(issue_date)) as PMTD_Funded_amount,
	SUM(loan_amount) - LAG(SUM(loan_amount), 1) OVER(ORDER BY year(issue_date), month(issue_date)) MoM_changes
FROM bank_loan_data
GROUP BY YEAR(issue_date), MONTH(issue_date)
ORDER BY YEAR(issue_date), MONTH(issue_date);
```
<img width="465" height="304" alt="image" src="https://github.com/user-attachments/assets/819bedea-2f85-4002-b54d-eaad9a95139a" />
<img width="203" height="126" alt="image" src="https://github.com/user-attachments/assets/9c5bd348-597b-406a-981a-c7c81f08caf4" />

MoM_change_% = MoM_change / PMTD         
December = 6226600 / 47754825 = 0.130387 or 13.0%

---
_KPI 3 : Average DTI (Debt-to-Income)_
```sql
	-- Average dti
select Round(AVG(dti), 4) *100 avg_dti  FROM bank_loan_data;

	-- MTD avg interest rate, MoM changes
 select 
	YEAR(issue_date) year_,
	MONTH(issue_date) month_name,
	ROUND(AVG(dti),4) * 100  MTD_Avg_DTI,
	LAG(ROUND(AVG(dti),4)*100) OVER( ORDER BY YEAR(issue_date), MONTH(issue_date) ) PMTD_Avg_DTI,
	ROUND(AVG(dti)  -  LAG(AVG(dti)) OVER(ORDER BY YEAR(issue_date), MONTH(issue_date)) ,4)*100 MoM_changes
FROM bank_loan_data
GROUP BY 	YEAR(issue_date), MONTH(issue_date) 
ORDER BY 	YEAR(issue_date), MONTH(issue_date);
```
<img width="397" height="297" alt="image" src="https://github.com/user-attachments/assets/dcdbae16-0f9c-4658-8c29-4fa4af4dd895" />
<img width="202" height="124" alt="image" src="https://github.com/user-attachments/assets/c337afce-76bf-414e-90ce-40552a9e4de7" />

MoM_change_% = MoM_change / PMTD         
December = 0.36 / 13.3 = 0.027067 or 2.7%

---
_Loan Segmenting_
```sql
select 
	CASE when loan_status IN ('Fully Paid', 'Current') then 'Good_loan' 
		when loan_status = 'Charged OFf' then 'Bad_loan' END  as Loan_category,
	SUM(loan_amount) total_funded_amt
FROM bank_loan_data
GROUP BY 
	CASE when loan_status IN ('Fully Paid', 'Current') then 'Good_loan' 
		when loan_status = 'Charged OFf' then 'Bad_loan' END;
```
<img width="191" height="61" alt="image" src="https://github.com/user-attachments/assets/8b14e91e-8551-48f2-ade5-2a9167f79a11" />

---
_GOOD LOAN KPI's_
```sql
-- GOOD LOAN percentage
select 
	COUNT(CASE when loan_status IN('Fully Paid', 'Current') then 1 END ) * 100.0 / COUNT(id) good_loan_percentage
FROM bank_loan_data;

-- GOOD LOAN -	applications, Funded amount, Amount received
select 
	COUNT(id) good_loan_applications,
	SUM(loan_amount) good_loan_funded_amt,
	SUM(total_payment) good_loan_amt_received
FROM bank_loan_data
where loan_status IN('Fully Paid', 'Current');
```
<img width="401" height="97" alt="image" src="https://github.com/user-attachments/assets/b02e8c8e-d013-43f1-939d-3a49becf644d" />
<img width="529" height="269" alt="image" src="https://github.com/user-attachments/assets/010ee9ab-8672-4050-99d5-4d5fe3974808" />

---
_Loan purpose analysis_
```sql
SELECT 
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;
```
<img width="502" height="290" alt="image" src="https://github.com/user-attachments/assets/721889d3-779f-4c73-a769-a5a0528c5830" />
<img width="407" height="283" alt="image" src="https://github.com/user-attachments/assets/5210b7b4-6f30-4eb2-97fe-73054647d000" />

---
_Home Ownership analysis_
```sql
-- Home Ownership analysis
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
```
<img width="492" height="121" alt="image" src="https://github.com/user-attachments/assets/b7956191-83bc-4fef-914c-ea52c84257f8" />
<img width="302" height="280" alt="image" src="https://github.com/user-attachments/assets/d3382236-bbd2-4ffd-90d8-4198789092f3" />

