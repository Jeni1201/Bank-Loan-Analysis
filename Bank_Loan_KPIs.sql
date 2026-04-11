use [Bank Loan DB];

select * from bank_loan_data;

-- DASHBOARD 1 requirements

-- 1. Total Loan Applications (total, Month-to-Date, Month-over-Month changes)

	-- Total loan applications
select COUNT(id) as total_loan_applications 
FROM bank_loan_data;

select COUNT(id) as MTD_loan_applications
FROM bank_loan_data
where month (issue_date) = 12 AND year(issue_date) = 2021;

	-- Month-to-Date loan applications , Month-over-Month changes
select 
	month(issue_date), 
	COUNT(id) as MTD_loan_applications,
	LAG(COUNT(id),1) OVER(ORDER BY month(issue_date)) PMTD_loan_applications,  --Previous month-to-date
	COUNT(id) - LAG(COUNT(id),1) OVER(ORDER BY month(issue_date)) MoM_change
from bank_loan_data
GROUP BY month(issue_date)
order by month(issue_date);

	-- Note: Dataset contains a single year, hence grouping by MONTH(issue_date). 
	-- For multi-year datasets, YEAR would be included to prevent aggregation overlap.

-- 2. Total Funded amount (total, Month-to-Date, Month-over-Month changes)

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

-- 3. Total Amount Received (total, Month-to-Date, Month-over-Month changes)

	-- total amount received
select SUM(total_payment) Total_Funded_amount
FROM bank_loan_data;

	-- MTD amount received, MoM changes
select 
	YEAR(issue_date) year_,
	MONTH(issue_date) month_name,
	SUM(total_payment) MTD_amount_received,
	LAG(SUM(total_payment), 1) OVER(ORDER BY YEAR(issue_date), MONTH(issue_date)) PMTD_amount_received,
	SUM(total_payment) - LAG(sum(total_payment)) OVER(ORDER BY YEAR(issue_date), MONTH(issue_date)) MoM_changes
FROM bank_loan_data
GROUP BY YEAR(issue_date), MONTH(issue_date) 
ORDER BY YEAR(issue_date), MONTH(issue_date) ;

-- 4. Average Interest rate (Average interest rate, Month-to-Date, Month-over-Month changes)

	-- Average Interest rate 
select ROUND( AVG(int_rate), 4) *100 avg_int_rate FROM bank_loan_data;

	-- MTD avg interest rate, MoM changes
select 
	YEAR(issue_date) year_,
	MONTH(issue_date) month_name,
	ROUND(AVG(int_rate),4) * 100  MTD_Avg_int_rate,
	LAG(ROUND(AVG(int_rate),4)*100) OVER( ORDER BY YEAR(issue_date), MONTH(issue_date) ) PMTD_Avg_int_rate,
	ROUND(AVG(int_rate)  -  LAG(AVG(int_rate)) OVER(ORDER BY YEAR(issue_date), MONTH(issue_date)) ,4)*100 MoM_changes
FROM bank_loan_data
GROUP BY 	YEAR(issue_date), MONTH(issue_date) 
ORDER BY 	YEAR(issue_date), MONTH(issue_date);

-- 5. Average Debt-to-Income ratio (Average dti, Month-to-Date, Month-over-Month changes)

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

--------------------------------------------------------------------------------------------------------------------

-- GOOD LOAN vs BAD LOAN KPIs

select loan_status, sum(loan_amount) 
FROM bank_loan_data
GROUP BY loan_status;

-- Loan segmenting 
select 
	CASE when loan_status IN ('Fully Paid', 'Current') then 'Good_loan' 
		when loan_status = 'Charged OFf' then 'Bad_loan' END  as Loan_category,
	SUM(loan_amount) total_funded_amt
FROM bank_loan_data
GROUP BY 
	CASE when loan_status IN ('Fully Paid', 'Current') then 'Good_loan' 
		when loan_status = 'Charged OFf' then 'Bad_loan' END;
	
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

-- BAD LOAN percentage
select 
	COUNT(CASE when loan_status IN('Charged Off') then 1 END ) * 100.0 / COUNT(id) bad_loan_percentage
FROM bank_loan_data;

-- BAD LOAN -	applications, Funded amount, Amount received
select 
	COUNT(id) bad_loan_applications,
	SUM(loan_amount) bad_loan_funded_amt,
	SUM(total_payment) bad_loan_amt_received
FROM bank_loan_data
where loan_status IN('Charged Off'); 

-------------------------------------------------------------------------------------------------------------

-- LOAN STATUS grid view
SELECT 
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_amount_Collected,
	AVG(int_rate * 100) AS Interest_rate,
	AVG(dti * 100) AS DTI_ratio 
FROM bank_loan_data
GROUP BY loan_status;

SELECT 
	loan_status,
	SUM(loan_amount) AS MTD_Funded_amount,
	SUM(total_payment) AS MTD_Total_amount_collected
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;