/*
data work.sales1;
	length First_Name $ 12 Last_Name $ 18 
          Gender $ 1 Job_Title $ 25 
          Country $ 2;
	infile "&path/sales.csv" dlm=',';
	input Employee_ID First_Name $ 
	Last_Name $ Gender $ Salary
	Job_Title $ Country $;
run;

proc contents data=work.sales1 varnum;
run;

proc print data=work.sales1 ;
run;

*/

/*
data work.newemployees;
length First $ 12 Last $ 18 Title $ 18 Salary 8;
infile "&path/newemps.csv" dlm=',';
input First $  Last $  Title $  Salary;
run;

proc print data=work.newemployees;
run;
*/
/*
data work.qtrdonation;
length IDNum $ 6 Qtr1 8 Qtr2 8 Qtr3 8 Qtr4 8 ;
infile"&path/donation.dat" dlm=' ';
input IDNum $  Qtr1 Qtr2 Qtr3 Qtr4;
run;


proc print data=work.qtrdonation;
run;
*/
/*
data work.sales2;
	infile "&path/sales.csv" dlm=',';
	input Employee_ID First_Name :$12. 
	Last_Name :$18. Gender :$1. Salary
	Job_Title :$25. Country :$2.
	Birth_Date :date. Hire_Date:mmddyy.;
	if Country='AU';
	keep First_Name Last_Name Salary 
        Job_Title Hire_Date;
    label Job_Title='Sales Title'
         Hire_Date='Date Hired';
    format Salary dollar12. Hire_Date monyy7.;
run;
run;

proc print data=work.sales2 label;
run;
*/

/*
data work.newemps2;
   infile datalines dlm=',';
   input First_Name $ Last_Name $
         Job_Title $ Salary :dollar8.;
   datalines;
Steven,Worton,Auditor,$40450
Merle,Hieds,Trainee,$24025
Marta,Bamberger,Manager,$32000
;

proc print data=work.newemps2;
run;
*/

/*
data work.canada_customers;
length First Last :$20  Gender $1 
        AgeGroup $ 12;
infile "&path/custca.csv" dlm=',';
input First $ Last $ ID Gender $ 
         BirthDate :mmddyy. Age AgeGroup $;
format BirthDate monyy7.;
drop ID Age;
run;

proc print data=work.canada_customers;
run;
*/

/*
data work.prices;
infile "&path/pricing.dat" dlm='*';
input ProductID StartDate:date. EndDate:date. Cost:dollar. SalesPrice:dollar.;
format StartDate EndDate mmddyy10. cost SalesPrice 8.2;
run;

title '2011 Pricing';
proc print data=work.prices;
run;
title;
*/

data work.managers;
infile datalines dlm='/';
input ID First:$12. Last:$12. Gender $ Salary:comma. Title:$25. HireDate :date.;
	datalines;
120102/Tom/Zhou/M/108,255/Sales Manager/01Jun1993
120103/Wilson/Dawes/M/87,975/Sales Manager/01Jan1978
120261/Harry/Highpoint/M/243,190/Chief Sales Officer/01Aug1991
121143/Louis/Favaron/M/95,090/Senior Sales Manager/01Jul2001
121144/Renee/Capachietti/F/83,505/Sales Manager/01Nov1995
121145/Dennis/Lansberry/M/84,260/Sales Manager/01Apr1980
;

title 'Orion Star Management Team';
proc print data=work.managers noobs;
   format HireDate mmddyy10.;
run;
title;
