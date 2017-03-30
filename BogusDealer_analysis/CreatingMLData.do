cd "E:\data\PreliminaryAnalysis\BogusDealers\"

use "FeatureDealerProfiles.dta", clear
destring DealerTIN, replace force
drop if DealerTIN==.
save "NumericFeatureDealerProfiles.dta", replace


use "SaleDiscrepancyAll.dta", clear
drop diff absdiff maxSalesTax OtherDeclarationCount MyDeclarationCount MatchDeclarationCount OtherDeclarationTax MyDeclarationTax MatchDeclarationTax
destring DealerTIN, replace force
drop if DealerTIN==.
bys DealerTIN TaxQuarter: gen Count=_N
drop if Count>1
drop Count
save "NumericSaleDiscrepancyAll.dta", replace


use "PurchaseDiscrepancyAll.dta", clear
destring DealerTIN, replace force
drop OtherDeclarationCount MyDeclarationCount MatchDeclarationCount OtherDeclarationTax MyDeclarationTax MatchDeclarationTax diff absdiff maxPurchaseTax
drop if DealerTIN==.
bys DealerTIN TaxQuarter: gen Count=_N
drop if Count>1
drop Count
save "NumericPurchaseDiscrepancyAll.dta", replace

use "FeatureDownStreamnessPurchases.dta", clear
destring DealerTIN, replace 
save "NumericFeatureDownStreamnessPurchases.dta", replace

use "FeatureDownStreamnessSales.dta", clear
destring DealerTIN, replace 
save "NumericFeatureDownStreamnessSales.dta", replace


*&E:\data\PreliminaryAnalysis\BogusDealers\
* Creating the code book. 


import delimited "NetworkFeaturesPurchases9.csv", case(preserve) clear
keep __id TaxQuarter pagerank triangle_count in_degree out_degree
rename __id DealerTIN
rename pagerank Purchases_pagerank
rename triangle_count Purchases_triangle_count
rename in_degree Purchases_in_degree
rename out_degree Purchases_out_degree
replace TaxQuarter=9 if TaxQuarter==.
destring DealerTIN, replace force
save "PurchaseNetworkQuarter.dta", replace


forvalues i=11/20{ //should have run it from 1 to 225 but there were errors which needed to be debugged in certain sheets.
*local myend=substr(r(range_`j'),4,1)
import delimited "NetworkFeaturesPurchases`i'.csv", case(preserve) clear
keep __id TaxQuarter pagerank triangle_count in_degree out_degree
rename __id DealerTIN
rename pagerank Purchases_pagerank
rename triangle_count Purchases_triangle_count
rename in_degree Purchases_in_degree
rename out_degree Purchases_out_degree
replace TaxQuarter=`i' if TaxQuarter==.
destring DealerTIN, replace force
append using "PurchaseNetworkQuarter.dta", force
save "PurchaseNetworkQuarter.dta", replace
clear
}

use "PurchaseNetworkQuarter.dta", clear
*destring DealerTIN, replace force
drop if DealerTIN==.
bys DealerTIN TaxQuarter: gen Count=_N
drop if Count>1
drop Count
save "PurchaseNetworkQuarter.dta", replace


import delimited "NetworkFeaturesSales9.csv", case(preserve) clear
keep __id TaxQuarter pagerank triangle_count in_degree out_degree
rename __id DealerTIN
rename pagerank Sales_pagerank
rename triangle_count Sales_triangle_count
rename in_degree Sales_in_degree
rename out_degree Sales_out_degree
replace TaxQuarter=9 if TaxQuarter==.
destring DealerTIN, replace force
save "SalesNetworkQuarter.dta", replace


forvalues i=10/20{ //should have run it from 1 to 225 but there were errors which needed to be debugged in certain sheets.
*local myend=substr(r(range_`j'),4,1)
import delimited "NetworkFeaturesSales`i'.csv", case(preserve) clear
keep __id TaxQuarter pagerank triangle_count in_degree out_degree
rename __id DealerTIN
rename pagerank Sales_pagerank
rename triangle_count Sales_triangle_count
rename in_degree Sales_in_degree
rename out_degree Sales_out_degree
replace TaxQuarter=`i' if TaxQuarter==.
destring DealerTIN, replace force
append using "SalesNetworkQuarter.dta", force
save "SalesNetworkQuarter.dta", replace
clear
}

use "SalesNetworkQuarter.dta", clear
drop if DealerTIN==.
bys DealerTIN TaxQuarter: gen Count=_N
drop if Count>1
drop Count
save "SalesNetworkQuarter.dta", replace


use "FeatureReturns.dta", clear
gen RefundClaimedBoolean=RefundClaimed>0

destring DealerTIN, replace 
destring TaxQuarter, replace

merge m:1 DealerTIN using "NumericFeatureDealerProfiles.dta", keep(master match) generate(profile_merge)

keep if TaxQuarter>8

merge m:1 DealerTIN TaxQuarter using "NumericSaleDiscrepancyAll.dta", keep(master match) generate(salesmatch_merge)

merge m:1 DealerTIN TaxQuarter using "NumericPurchaseDiscrepancyAll.dta", keep(master match) generate(purchasematch_merge)

merge m:1 DealerTIN TaxQuarter using "SalesNetworkQuarter.dta", keep(master match) generate(salesnetwork_merge)

merge m:1 DealerTIN TaxQuarter using "PurchaseNetworkQuarter.dta", keep(master match) generate(purchasenetwork_merge)

merge m:1 DealerTIN TaxQuarter using "NumericFeatureDownStreamnessSales.dta", keep(master match) generate(salesds_merge)

merge m:1 DealerTIN TaxQuarter using "NumericFeatureDownStreamnessPurchases.dta", keep(master match) generate(purchaseds_merge)


replace TurnoverGross=TurnoverGross/1000000
replace MoneyDeposited=MoneyDeposited/1000000
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/1000000
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/1000000



