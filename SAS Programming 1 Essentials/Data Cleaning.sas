data work.subset1;
	set orion.sales;
	where Country = 'AU' and Job_Title like '%Rep%' 
	and Hire_Date< '01jan2000'd;
	bonus = (Salary*.10);
	run;

proc print data=work.subset1 noobs;
   var First_name Last_Name Salary 
       Job_Title Bonus Hire_Date;
   format Hire_Date date9.;
run;


 data work.subset1;
 
	set orion.sales;
	where Country = 'AU' and Job_Title like '%Rep%';
	bonus = (Salary*.10);
	*drop Employee_ID Gender Country Birth_Date;
	*keep First_Name Last_Name Salary Job_Title Hire_Date Bonus;
	run;

proc print data=work.subset1 noobs;
   var First_name Last_Name Salary 
       Job_Title Bonus Hire_Date;
   format Hire_Date date9.;
run;


data work.auemps;
set orion.sales;
where Country = 'AU';
Bonus = Salary*.10;
if Bonus >=3000;
run;


proc print data=work.auemps noobs;
   var First_name Last_Name Salary 
       Job_Title Bonus Hire_Date;
   format Hire_Date date9.;
run;




data work.subset1;
 
	set orion.sales;
	where Country = 'AU' and Job_Title like '%Rep%';
	bonus = (Salary*.10);
	drop Employee_ID Gender Country Birth_Date;
	*keep First_Name Last_Name Salary Job_Title Hire_Date Bonus;
	label Job_Title = 'Sales Title' Hire_Date ='Date Hired';
	format Salary Bonus dollar12. Hire_Date ddmmyy10.;
	run;

proc contents data=work.subset1 ;
   format Hire_Date date9.;
run;



proc print data=work.subset1 label;
run;




proc format;
	value $ctryfmt 'AU'='Australia' 
	'US'='United State' 
	other='miscoded';
run;

proc print data=orion.sales label;
	var Employee_ID Job_Title Salary 
	Country Birth_Date Hire_Date;
	label Employee_ID = 'Sales ID'
	Salary = 'Annual Salary'
	Birth_Date = 'Date of Birth'
	Hire_Date = 'Date of Hire';
	format Salary dollar10.
	Birth_Date Hire_Date monyy7.
	Country $ctryfmt.;
run;


proc print data=orion.sales label noobs;
   where Country='AU' and 
         Job_Title contains 'Rep';
   label Job_Title='Sales Title'
         Hire_Date='Date Hired';
   format Hire_Date mmddyy10. Salary dollar8.;
   var Last_Name First_Name Country Job_Title
       Salary Hire_Date;
run;


proc format;
	value tiers low-<50000='Tier 1'
	50000-100000 = 'Tier 2'
	100000<-high = 'Tier 3';
run;

proc print data=orion.sales;
	var Employee_ID Job_Title Salary 
	Country Birth_Date Hire_Date;
	format Birth_Date Hire_Date monyy7. Salary tiers.;
run;




/*data q1birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;
*/
proc format;
	value $GENDER 'F'='Female'
	'M' = 'Male'
	other = 'Invalid code';
	*value MNAME 1='January'
	2='February'
	3='March';
	value salrange 20000-<100000=
                 'Below $100,000'
         100000-500000='$100,000 or more'
         .='Missing salary'
         other='Invalid salary';
run;

title 'Employees with Birthdays in Q1';
proc print data=orion.nonsales;
	var  Gender Salary;
	format Gender $GENDER.  Salary salrange.;
run;
title;



data work.tony;
set orion.customer_dim;
where Customer_FirstName =*'Tony';
run;

proc print data=work.tony;
var Customer_FirstName Customer_LastName;
run;


data work.assistant;
	set orion.staff;
	where Job_Title like '%Assistant%' and 
	Salary <26000;
	Increase = Salary*0.10;
	New_Salary = Salary + Increase;
run;

proc print data = work.assistant;
	id  Employee_ID;
run;


data work.youngadult;
	set orion.customer_dim;
	where Customer_Gender = 'F' and 
	18<Customer_Age<35 and 
	Customer_Group like '%Gold%';
	Discount=.25;
run;

proc print data=work.youngadult;
	id Customer_ID;
run;


/*
data work.increase;
	set orion.staff;
	where Emp_Hire_Date>='01JUL2010'd;
	Increase=Salary*0.10;
	NewSalary=Salary+Increase;

	if Increase >3000;
	keep Employee_ID Emp_Hire_Date Salary Increase NewSalary;
	label Emp_Hire_Date='Hire Date' Employee_ID='Employee ID' 
		NewSalary='New Annual Salary' Salary='Annual Salary';
	format Salary NewSalary dollar10.2 Increase comma5.;
run;

proc print data=work.increase label;
run;
*/

/*

data work.delay;
	set orion.orders;
	Order_Month = month(Order_Date);
	if (Delivery_Date -Order_Date) >4 and Employee_ID =99999999 and Order_Month =8;
	drop Order_ID	Order_Type;
	label Order_Date = 'Date Ordered' Order_Month='Month Ordered' Employee_ID = 'Employee ID' Delivery_Date='Date Delivered' Customer_ID='Customer ID'; 
	format Order_Date Delivery_Date mmddyy10.;
run;

proc contents data=work.delay;
run;


proc print data=work.delay;

run;

*/

data work.bigdonations;
	set orion.employee_donations;
	Total = sum(Qtr1,Qtr2,Qtr3,Qtr4);
	NumQtrs = N(Qtr1,Qtr2,Qtr3,Qtr4);
	drop Recipients	Paid_By;
	if Total<50 or NumQtrs<4 then delete;
	label Qtr1='First Quarter'
         Qtr2='Second Quarter'
         Qtr3='Third Quarter'
         Qtr4='Fourth Quarter';
     
run;

proc contents data=work.bigdonations;
run;

proc print data=work.bigdonations noobs;

run;