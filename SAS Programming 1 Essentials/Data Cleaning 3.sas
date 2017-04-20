


/*
data empsall2;
	set empscn(rename=(First=Fname)) 
	empsjp(rename=(First=Fname Region=Country));
run;

proc print data=empsall2;
run;

*/
/*
data work.thirdqtr;
	set  orion.mnth7_2011 
	orion.mnth8_2011 
	orion.mnth9_2011;
run;	

proc print data=work.thirdqtr;
run;
*/

/*
data work.allemployees;
	set orion.sales orion.nonsales(rename=(First=First_Name Last=Last_Name));
	keep Employee_ID First_Name Last_Name Job_Title Salary;
run;

proc print data=work.allemployees;
run;
*/
/*
proc contents data=orion.charities;
run;

proc contents data=orion.us_suppliers;
run;

proc contents data=orion.consultants;
run;
*/
/*
data work.contacts;
	set orion.charities orion.us_suppliers;
run;

proc contents data=work.contacts;
run;
*/
/*
data work.contacts2;
	set orion.us_suppliers orion.charities;
run;
proc contents data=work.contacts2;
run;
*/
/*
data work.contacts3;
	set orion.us_suppliers orion.consultants;
run;

proc contents data=orion.consultants;
run;

proc contents data=orion.us_suppliers;
run;
*/
/*

data empsauh;
	merge empsau phoneh;
	by EmpID;
run;

proc print data=empsauh;
run;
*/
/*
proc sort data=orion.employee_payroll
          out=work.payroll;
   by Employee_ID;
run;

proc sort data=orion.employee_addresses
          out=work.addresses;
   by Employee_ID;
run;

data work.payadd;
	merge  work.payroll 
	work.addresses ;
	by Employee_ID;
	format Birth_Date weekdate.;
run;

proc print data=work.payadd;
	
run;
*/

/*
********** Create Data **********;
data empsau;
   input First $ Gender $ EmpID;
   datalines;
Togar   M   121150
Kylie   F   121151
Birin   M   121152
;

data phones;
   input EmpID Type $ Phone $15.;
   datalines;
121150 Home +61(2)5555-1793
121150 Work +61(2)5555-1794
121151 Home +61(2)5555-1849
121152 Work +61(2)5555-1850
121152 Home +61(2)5555-1665
121152 Cell +61(2)5555-1666
;

********** One-to-Many Merge **********;
data empphones;
   merge  phones empsau;
   by EmpID;
run;

proc print data=empphones;
run;
*/
/*
proc contents data=orion.orders;
run;

proc contents data=orion.order_item;
run;

data work.allorders ;
merge orion.orders orion.order_item;
by Order_ID;
keep Order_ID Order_Item_Num Order_Type 
Order_Date Quantity Total_Retail_Price; 
run;

proc print data=work.allorders;
where (qtr(Order_Date)=4) & (year(Order_Date)=2011);
run;
*/
/*
proc sort data=orion.product_list out=work.product_list_sort;
	by Product_Level;
run;

data work.listlevel;
merge work.product_list_sort orion.product_level;
by Product_Level;
keep Product_ID Product_Name Product_Level Product_Level_Name;
run;

proc print data=work.listlevel;
where Product_Level=3;
run;
*/
/*
data empsau;
   input First $ Gender $ EmpID;
   datalines;
Togar   M   121150
Kylie   F   121151
Birin   M   121152
;
run;

data phonec;
   input EmpID Phone $15.;
   datalines;
121150 +61(2)5555-1795
121152 +61(2)5555-1667
121153 +61(2)5555-1348
;
run;

********** Match-Merge with Non-Matches**********;
data empsauc2;
   merge empsau (in=Emps)
   phonec (in=Cell);
   by EmpID;
   if Emps=0 and Cell=1;
run;

proc print data=empsauc2;
run;
*/
/*
proc sort data=orion.product_list
          out=work.product;
   	by Supplier_ID;
run;

data work.prodsup;
	merge work.product(in=a) orion.supplier(in=b);
	by Supplier_ID;
	if a and not b;
run;

proc print data=work.prodsup;
	var Product_ID Product_Name Supplier_ID 
       Supplier_Name;
run;
*/
/*
proc sort data=orion.customer out= work.customer_sort;
	by Country ;
run;

data work.allcustomer;
	merge work.customer_sort (in=a)
	orion.lookup_country(rename=(Start = Country Label = Country_Name) in=b);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if a and b;
	
run;

proc print data=work.allcustomer;
run;
*/
/*
data empscn;
	input First $ Gender $ Country $;
	datalines;
Chang   M   China
Li      M   China
Ming    F   China
;
run;

data empsjp;
	input First $ Gender $ Region $;
	datalines;
Cho     F   Japan
Tomi    M   Japan
;
run;

data empsau;
   	input First $ Gender $ EmpID;
   	datalines;
	Togar   M   121150
	Kylie   F   121151
	Birin   M   121152
	;
run;

data phoneh;
	input EmpID Phone $15.;
	datalines;
	121150 +61(2)5555-1793
	121151 +61(2)5555-1849
	121152 +61(2)5555-1665
	;
run;


proc sort data=orion.orders out=work.orders_sort;
	by Employee_ID;
run;

data work.allorders;
	merge orion.staff(in=a)  work.orders_sort(in=b);
	by Employee_ID;
	keep Employee_ID Job_Title Gender Order_ID Order_Type Order_Date;
	if b;
run; 

data work.noorders;
	merge orion.staff(in=a)  work.orders_sort(in=b);
	by Employee_ID;
	if a and not b;
	keep Employee_ID Job_Title Gender Order_ID Order_Type Order_Date;
run; 

proc print data = work.allorders;
run;
proc print data = work.noorders;
run;
*/