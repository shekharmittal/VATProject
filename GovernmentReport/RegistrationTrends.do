cd "E:\data"

use "E:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", clear

//This ended up being an analysis of registration pattern in the last 5 years

// First we import the date from the registration date
gen RegistrationYear=dofc(RegistrationDate)
format %td RegistrationYear //change it into date format
//Import just the year inf
gen StartYear=yofd(RegistrationYear)
gen StartMonth=mofd(RegistrationYear)
//Changing the format to appropriate year form

format %tm StartMonth
format %ty StartYear 

/* Begin analysis for number of registrations between 2010 and 2015*/
gen month=StartMonth
gen year=1 if month>602&month<=614
replace year=2 if month>614&month<=626
replace year=3 if month>626&month<=638
replace year=4 if month>638&month<=650
replace year=5 if month>650&month<=662
replace year=6 if month>662&month<=674
//In this definition month=1 is January 2010
//replace month=month-599 
//In this definition month=1 is April 2010
replace month=month-602 
gen dummy=1


merge 1:1 DealerTIN using "F:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate)
drop if _merge==2
gen Bogus=0
replace Bogus=1 if _merge==3


preserve
collapse (count) dummy (mean) year StartYear StartMonth, by(month Bogus)
twoway (connected dummy month if year!=.&month<66&Bogus==0) (connected dummy month if year!=.&month<66&Bogus==1, yaxis(2)), xline(25) xline(29) xline(37) note("25 - start of 2A2B. 29 - removal of security requirement. 37- increase of threshold to 2 million") 
restore
