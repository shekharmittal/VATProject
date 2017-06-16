import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter19SaleOnlySuspicious.csv, varnames(1) case(preserve) clear

tostring DealerTIN, replace

foreach var of var d*{
	replace `var'=. if `var'>100000
	sum `var', detail
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\SalesQ19OnlySuspicious.dta", replace


import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter19SaleOnlyAll.csv, varnames(1) case(preserve) clear


foreach var of var d*{
	replace `var'=. if `var'>100000
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\SalesQ19OnlySuspiciousAll.dta"



import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter19PurchaseOnlySuspicious.csv, varnames(1) case(preserve) clear

foreach var of var d*{
	replace `var'=. if `var'>100000
	sum `var', detail
}


save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\PurchaseQ19OnlySuspicious.dta", replace


import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter19PurchaseOnlyAll.csv, varnames(1) case(preserve) clear

foreach var of var d*{
	replace `var'=. if `var'>100000
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\PurchaseQ19All.dta", replace

import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter11SaleOnlySuspicious.csv, varnames(1) case(preserve) clear

foreach var of var d*{
	replace `var'=. if `var'>100000
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\SalesQ11OnlySuspicious.dta", replace

import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter11SaleOnlyAll.csv, varnames(1) case(preserve) clear


foreach var of var d*{
	replace `var'=. if `var'>100000
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\SalesQ11All.dta"

import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter11PurchaseOnlyAll.csv, varnames(1) case(preserve) clear

foreach var of var d*{
	replace `var'=. if `var'>100000
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\PurchaseQ11All.dta"



import delimited E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\DistanceFromSuspiciousQuarter11PurchaseOnlySuspicious.csv, varnames(1) case(preserve) clear

foreach var of var d*{
	replace `var'=. if `var'>100000
}

save "E:\data\PreliminaryAnalysis\BogusDealers\RandomizationAnalysis\PurchaseQ11OnlySuspicious.dta"
