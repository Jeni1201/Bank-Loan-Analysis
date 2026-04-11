use [Bank Loan DB];

select * from bank_loan_data;

-- DASHBOARD 2 : charts requirements
-- charts impacted by 3 metrics : total_loan_applications, total_funded_amount, total_amount_received

-- Monthly trends
select 
	MONTH(issue_date) mth_no,
	DATENAME(MONTH, issue_date) as Month_name,
	COUNT(id) total_loan_Applications,
	SUM(loan_amount) total_Funded_amount,
	SUM(total_payment) total_Amount_received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- Regional analysis
SELECT 
	address_state,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_amount,
	SUM(total_payment) as Total_Amount_Received
FROM bank_loan_data
GROUP BY  address_state 
ORDER BY  Total_Loan_Applications DESC ;

-- Loan Term analysis
SELECT 
	term,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_amount,
	SUM(total_payment) as Total_Amount_Received
FROM bank_loan_data
GROUP BY term 
ORDER BY term;

-- Employee Length analysis (employment duration) 
SELECT 
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_data
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC;

-- Loan purpose
SELECT 
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- Home Ownership analysis
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;


-- apply Filters : grade, purpose, state
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_amount,
	SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_data
WHERE grade = 'A' AND address_state= 'CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;