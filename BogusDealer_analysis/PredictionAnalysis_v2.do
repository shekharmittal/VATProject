/*
Date: July 23, 2017
Author: Shekhar Mittal

Working on the presentation for IAS training at Berkeley
1. Take the latest predictions that Ofir has generated, calculate the avg_means and then resort
2. From the sorted list, create 2 graphs:
a. One describes the success metric
b. Other describels the tax collection implications
*/

import delimited "E:\data\PreliminaryAnalysis\BogusDealers\firm_period_predictions.csv", clear

drop v1
gsort dealertin taxquarter
by dealertin: egen avg_score=mean(model_score_bogus_online)
gsort dealertin -taxquarter
by dealertin: gen count=_n
keep if count==1

gsort -avg_score
gen Rank=_n


drop count model_score_bogus_online taxquarter
rename dealertin DealerTIN


save "E:\Ofir\BogusFirmCatching\BogusOnline_AvgScore.dta"


cd "E:\data\PreliminaryAnalysis\BogusDealers\"
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


replace TurnoverGross=TurnoverGross/10000000
replace MoneyDeposited=MoneyDeposited/10000000
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/10000000
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/10000000

merge m:1 DealerTIN using "E:\Ofir\BogusFirmCatching\BogusOnline_AvgScore.dta", keepusing(bogus_online avg_score Rank ) generate(merge_validation)


*label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values TaxQuarter quarter
label define prediction 1 "1-400" 2 "401-800" 3 "801-1200" 4 "1201-2500" 5 "2501-Rest" 

gen dummy=1
gen prediction=0
replace prediction=1 if Rank<=400
replace prediction=2 if Rank<=800&Rank>400
replace prediction=3 if Rank<=1200&Rank>800
replace prediction=4 if Rank<=2500&Rank>1200
replace prediction=5 if Rank>2500

replace prediction=. if Rank==.
replace prediction=6 if prediction==0

label values prediction prediction


#delimit ;
graph bar (mean) bogus_online 
          if prediction>0, 
		  over(prediction) graphregion(color(white)) 
		  legend(order(1 "From bogus data"))
		  title("Fraction Bogus Firms") blabel(bar)
		  ytitle("")
		  note("Based on simulation data, if we inspect companies the proportion that is definitely bogus.""Lower bound, others could be bogus as well");

graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\PredictionResults_AvgScore.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\PredictionResults_AvgScore.pdf", as(pdf) replace


#delimit ;
preserve;
keep if prediction==1;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter bogus_online);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if bogus_online==1, ylabel(#5) ytitle("Rupees (in crores)") 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   title("Bogus firms, online data, all features")
	   graphregion(color(white))
	   note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15");
	   restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_AvgScore.gph", replace
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_AvgScore.pdf", as(pdf) replace



/*
#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel7.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel7.pdf", as(pdf) replace
*/
