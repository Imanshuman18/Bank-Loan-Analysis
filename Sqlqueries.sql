Create database bankloans;
use bankloans;
#total loan applications
select * from financial_loan;
select count(id)as Total_loan_Applications from financial_loan;
#loan pplications montht  to date basis
select count(id)as pmtd from financial_loan where MONTH(issue_date)=-02 AND YEAR(issue_date)=2021;
SELECT DATE_FORMAT(issue_date, '%Y-%m-%d') AS formatted_date FROM financial_loan;
#Total_amount_funded
Select sum(loan_amount) as Total_amount_funded from financial_loan;
Select sum(loan_amount) as MTD_Total_amount_funded from financial_loan where month(issue_date)=12 AND year(issue_date)=2021;
Select sum(loan_amount) as PMTD_Total_amount_funded from financial_loan where month(issue_date)=11 AND year(issue_date)=2021;
#TOtal_amount_received
Select sum(total_payment) from financial_loan;
Select round(avg(int_rate)*100,2)  from financial_loan;
Select round(avg(dti)*100,2) from financial_loan;
#percenage of good loan applicatiions
SELECT (count(case when loan_status='Fully paid' OR loan_status='current' then id End)*100)/count(id) as good_loan_percentage from financial_loan;
#No of good loan applications
Select count(id) from financial_loan where loan_status in ('Fully paid','Current');
#good_loan funded amount
Select SUM(loan_amount) from financial_loan where loan_status in ('Fully paid','Current');
#good_loan received amount
SELECT SUM(total_payment) from financial_loan where loan_status in('Fully paid','Current');
#Total percentage of badloans
Select (count(case when loan_status='Charged Off' then id END)*100)/count(id) as bad_loan_percentage from financial_loan;
#No of bad loans
select count(id) from financial_loan where loan_status='Charged Off';
#bad loan funded amount
Select SUM(loan_amount) as BAD_LOAN_FUNDED from financial_loan where loan_status ='Charged Off';
#bad loan received amount 
Select SUM(total_payment) as BAD_LOAN_RECIEVED from financial_loan where loan_status ='Charged Off';
#loanstatus grid view(Check the performance  of loan)
Select loan_status,count(id) as loan_count ,sum(loan_amount) as total_funded_amount,sum(total_payment)
as total_amount_received,avg(int_rate*100) as Int_rate,avg(dti*100) as avg_dti from financial_loan group by loan_status;
#Monthly trend by issue date
Select month(issue_date), monthname(issue_date),count(id) as Total_applications,sum(loan_amount) as
total_funded_amount,sum(total_payment) as total_received_amount from financial_loan group by 
monthname(issue_date),month(issue_date) order by month(issue_date);
#Regional analysis by state
select address_state,count(id) as total_applications,sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received from financial_loan group by address_state   order by address_state; 
#Loan term analysis
select term,count(id) as total_applications,sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received from financial_loan group by term  order by term;
#employement length analysis
select emp_length,count(id) as total_applications,sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received from financial_loan group by emp_length   order by count(id) DESC;
#Loan purpose breakdown
select purpose,count(id) as total_applications,sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received from financial_loan group by purpose   order by count(id) DESC; 
#home ownership analysis
select home_ownership,count(id) as total_applications,sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received from financial_loan group by home_ownership  order by COUNT(id) DESC; 
#filters
select home_ownership,count(id) as total_applications,sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received from financial_loan where address_state='CA' and grade='A'  group by home_ownership order by COUNT(id) DESC; 