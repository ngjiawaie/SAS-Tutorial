/*
data work.sales4;
infile "&path/sales3inv.csv" dlm=',';
input Employee_ID First $ Last $
Job_Title $ Salary Country $;
run;

proc print data=work.sales4;
run;
*/
/*
data work.contacts;
length Name $ 20 Phone Mobile $ 14;
infile "&path/phone2.csv" dsd;
input Name $ Phone $ Mobile $;
run;

proc print data=work.contacts noobs;
run;
*/
/*
data work.contacts2;
length Name $ 20 Phone Mobile $ 14;
infile "&path/phone.csv" dlm=',' missover;
input Name $ Phone $ Mobile $;
run;

proc print data=work.contacts2 noobs;
run;
*/
/*
data  work.donations;
infile "&path/donation.csv" dsd missover;
input EmpID Q1 Q2 Q3 Q4;
run;

proc print data=work.donations noobs;
run;
*/
/*
data work.prices;
infile "&path/prices.dat" dlm='*' missover;
input ProductID StartDate:date. EndDate:date. UnitCostPrice:dollar. UnitSalesPrice:dollar.;
format StartDate EndDate mmddyy10. UnitCostPrice UnitSalesPrice 8.2;
label ProductID	='Product ID' StartDate='Start of Date Range' EndDate ='End of Date Range' UnitCostPrice = 'Cost Price per Unit' UnitSalesPrice	= 'Sales Price per Unit';
run;

proc print data=work.prices;
run;
*/
/*
data work.comp;
set orion.sales;
Bonus=500;
Compensation=sum(Salary, Bonus);
BonusMonth=month(Hire_Date);
run;

proc print data=work.comp;
var Employee_ID First_Name Last_Name Salary Bonus Compensation BonusMonth;
run;
*/

/*
data work.increase;
	set orion.staff;
	Increase = Salary*0.1;
	NewSalary = Salary + Increase;
	BdayQtr = qtr(Birth_Date);
	keep Employee_ID Salary Increase NewSalary Birth_Date BdayQtr;
	retain Employee_ID Salary Increase NewSalary Birth_Date BdayQtr;
	format Salary Increase NewSalary comma.;
run;

proc print data=work.increase;
run;

*/
/*
data work.birthday;
	set orion.customer;
	Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
	BdayDOW2012 = weekday(Bday2012);
	Age2012 = (Bday2012 - Birth_Date)/(365.25);
	keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
	format Bday2012 date9. Age2012 3.;
run;


proc print data=work.birthday;
run;
*/
/*
data work.employees;
	set orion.sales;
	FullName = catx(' ', First_Name, Last_Name);
	Yrs2012 = intck('Year', Hire_Date,'01JAN2012'd);
	format Birth_Date Hire_Date ddmmyy10. Salary dollar.;
	label Yrs2012 = 'Years of Employment in 2012';
	
run;

proc print data=work.employees;
run;
*/
/*
data work.comp;
	set orion.sales;
	*Bonus = 0;
	if Job_Title = 'Sales Rep. IV' or Job_Title = 'Sales Rep. III' then Bonus = 1000;
	else if Job_Title = 'Sales Manager' then Bonus = 1500;
	else if Job_Title = 'Senior Sales Manager' then Bonus = 2000;
	else if Job_Title = 'Chief Sales Officer' then Bonus = 2500;
	else Bonus = 500;

run;

proc print data=work.comp;
	var Last_Name Job_Title Bonus;
run;
*/
/*
data work.bonus;
	set orion.sales;
	if Country = 'US' then Bonus = 500;
	else Bonus = 300;
run;

proc print data=work.bonus;
	var Last_Name Job_Title Country Bonus;
run;
*/
/*
data work.bonus;
   set orion.nonsales;
   *if Country in ('US','us','Us','uS') then Bonus=500;
   if upcase(Country)='US' then Bonus=500;
   else Bonus=300;
run;

proc print data=work.bonus;
run;
*/
/*
data work.bonus;
   set orion.sales;
   length Freq $12;
   if Country='US' then 
      do;
         Bonus=500;
         Freq='Once a Year';
      end;
   else 
      do;
          Bonus=300;
          Freq='Twice a Year';
      end;
run;

proc print data=work.bonus;
   var First_Name Last_Name Country 
       Bonus Freq;
run;
*/
/*
data work.region;
   	set orion.supplier;
   	length Region $ 20;
   	if upcase(Country) ='CA' or upcase(Country) ='US' then
   	do;
   		Discount=0.1;
   		DiscountType='Required';
   		Region='North America';
   	end;
   	else
   	do;
   		Discount=0.05;
   		DiscountType='Optional';
   		Region='Not North America';
   	end;
   	keep Supplier_Name Country Discount DiscountType  Region;
run;

proc print data=work.region;
run;
*/
/*
data work.season;
length Promo $ 20 Promo2 $ 20;
	set orion.customer_dim;
	if qtr(Customer_BirthDate) = 1 then Promo = 'Winter'; 
	else if qtr(Customer_BirthDate) = 2 then Promo = 'Spring'; 
	else if qtr(Customer_BirthDate) = 3 then Promo = 'Summer'; 
	else if qtr(Customer_BirthDate) = 4 then Promo = 'Fall'; 
	
	if Customer_Age>=18 and Customer_Age <=25 then Promo2 = 'YA';
	else if Customer_Age>=65 then Promo2 = 'Senior';
	else Promo2 =' ';
	keep Customer_FirstName Customer_LastName Customer_BirthDate Customer_Age Promo Promo2;
run;

proc print data=work.season;
run;
*/

data work.gifts;
	length Gift1 $ 20 Gift2 $ 20;
	set orion.nonsales;
	select(Gender);
		when ('F')
			do;
				Gift1 = 'Scarf';
				Gift2 = 'Pedometer';
			end;
		when ('M')
			do;
				Gift1 = 'Gloves';
				Gift2 = 'Money Clip';
			end;
		otherwise
			do;
				Gift1 = 'Coffee';
				Gift2 = 'Calander';
			end;
	end;
	keep Employee_ID First Last Gender Gift1 Gift2;
run;

proc print data=work.gifts;
run;