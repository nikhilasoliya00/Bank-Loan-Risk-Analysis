create database bank_loan_analysis;
use bank_loan_analysis;
SELECT * from financial_loan;
select count(id) as Total_Applications from financial_loan;
UPDATE bank_loan_analysis.financial_loan
SET 
issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y'),
last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y'),
last_payment_date = STR_TO_DATE(last_payment_date, '%d-%m-%Y'),
next_payment_date = STR_TO_DATE(next_payment_date, '%d-%m-%Y');
ALTER TABLE bank_loan_analysis.financial_loan
MODIFY issue_date DATE,
MODIFY last_credit_pull_date DATE,
MODIFY last_payment_date DATE,
MODIFY next_payment_date DATE;
select count(id) as MTD_Total_Applications from financial_loan where month(issue_date) = 12 and year(issue_date)=2021;
select count(id) as PMTD_Total_Applications from financial_loan where month(issue_date) = 11 and year(issue_date)=2021;

select sum(loan_amount) as Total_Funded_Amount from financial_loan;
select sum(loan_amount) as MTD_Total_Funded_Amount from financial_loan where month(issue_date)=12;
select sum(loan_amount) as PMTD_Total_Funded_Amount from financial_loan where month(issue_date)=11;

select sum(total_payment) as Total_Amount_Collected from financial_loan;
select sum(total_payment) as MTD_Total_Amount_Collected from financial_loan where month(issue_date)=12;
select sum(total_payment) as PMTD_Total_Amount_Collected from financial_loan where month(issue_date)=11;

select avg(int_rate)*100 as Avg_Int_Rate from financial_loan;
select avg(int_rate)*100 as MTD_Avg_Int_Rate from financial_loan where month(issue_date)=12;
select avg(int_rate)*100 as PMTD_Avg_Int_Rate from financial_loan where month(issue_date)=11;

select avg(dti)*100 as Avg_DTI from financial_loan;
select avg(dti)*100 as Avg_DTI from financial_loan where month(issue_date)=12;
select avg(dti)*100 as Avg_DTI from financial_loan where month(issue_date)=11;

select
count(case when loan_status = "Fully Paid" or loan_status = "Current" then id end)*100/count(id) as Good_Loan_Percentage
from financial_loan;
select count(id) as Good_Loan_Applications from financial_loan where loan_status = "Fully Paid" OR loan_status = "Current";
select sum(loan_amount)as Good_Loan_Amount_Funded from financial_loan where loan_status = "Fully Paid" OR loan_status = "Current";
select sum(total_payment)as Good_Loan_Amount_Received from financial_loan where loan_status = "Fully Paid" OR loan_status = "Current";

select
count(case when loan_status = "Charged Off" then id end)*100/count(id) as Bad_Loan_Percentage
from financial_loan;
select count(id) as Bad_Loan_Applications from financial_loan where loan_status = "Charged Off";
select sum(loan_amount)as Bad_Loan_Amount_Funded from financial_loan where loan_status = "Charged Off";
select sum(total_payment)as Bad_Loan_Amount_Received from financial_loan where loan_status = "Charged Off";

select 
loan_status,
count(id) as Loan_Count,
sum(loan_amount) as Total_Amount_Funded,
sum(total_payment) as Total_Amount_Received,
avg(int_rate)*100 as Interest_Rate,
avg(dti)*100 as DTI 
from financial_loan
group by loan_status;

select
loan_status,
sum(total_payment) AS MTD_Total_Amount_Received,
sum(loan_amount) AS MTD_Total_Amount_Funded
from financial_loan
where month(issue_date) = 12
group by loan_status;

select
month(issue_date) as Month_Munber,
monthname(issue_date) as Month_name,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan
group by month(issue_date), monthname(issue_date)
order by month(issue_date);

select
address_state as State,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan
group by address_state
order by address_state;

select
term as Term,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan
group by term
order by term;

select
emp_length as Employee_Length,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan
group by emp_length
order by emp_length;

select
purpose as Purpose,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan
group by purpose
order by purpose;

select
home_ownership as Home_Ownership,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan
group by home_ownership
order by home_ownership