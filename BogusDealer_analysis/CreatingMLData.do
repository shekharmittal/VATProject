cd "E:\data\PreliminaryAnalysis\BogusDealers\"

//Code to make the files
//Need to run it only once
{
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
}



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

replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment*4
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment*4


//Creating size of the problem for online bogus data, model 5 and model 7
// Model 5: All features, except the dealer profile related features
// Model 7: All features, including the dealer profile features
{
merge 1:1 TaxQuarter DealerTIN using "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.dta", keepusing(BogusOnlineModel* OnlineRankModel* OnlineQuarterlyRankModel*) generate(merge_validation)


label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values TaxQuarter quarter
label define prediction 1 "1-400" 2 "401-800" 3 "801-1200" 4 "1201-1600" 5 "1601-2500" 6 "Rest"



gen dummy=1
gen prediction=0
replace prediction=1 if OnlineQuarterlyRankModel7<=50
replace prediction=2 if OnlineQuarterlyRankModel7<=100&OnlineQuarterlyRankModel7>50
replace prediction=3 if OnlineQuarterlyRankModel7<=150&OnlineQuarterlyRankModel7>100
replace prediction=4 if OnlineQuarterlyRankModel7<=200&OnlineQuarterlyRankModel7>150
replace prediction=5 if OnlineQuarterlyRankModel7<=300&OnlineQuarterlyRankModel7>200

label values prediction prediction
*xlabel(, valuelabel)

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


#delimit ;
graph bar (mean) bogus_online (mean) bogus_cancellation (mean) bogus_any 
          if prediction>0&TaxQuarter<17, 
		  over(prediction) graphregion(color(white)) 
		  legend(order(1 "From bogus data" 2 "From cancellation records" 3 "Combined set"))
		  title("Definite success rate") blabel(bar)
		  note("Based on simulation data, if we inspect companies the proportion that is definitely bogus. Lower bound, others could be bogus as well");

graph bar (sum) bogus_online (sum) bogus_cancellation (sum) bogus_any (sum) dummy if prediction>0&TaxQuarter<17, over(prediction)



drop prediction

gen prediction=0
replace prediction=1 if OnlineQuarterlyRankModel5<=50
replace prediction=2 if OnlineQuarterlyRankModel5<=100&OnlineQuarterlyRankModel5>50
replace prediction=3 if OnlineQuarterlyRankModel5<=150&OnlineQuarterlyRankModel5>100
replace prediction=4 if OnlineQuarterlyRankModel5<=200&OnlineQuarterlyRankModel5>150
replace prediction=5 if OnlineQuarterlyRankModel5<=300&OnlineQuarterlyRankModel5>200


*gen prediction2=0
*replace prediction2=1 if prediction==0
label values prediction prediction


#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, no dealer features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel5.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel5.pdf", as(pdf) replace



//Doing expected probability (controlling for size) calculations
keep if merge_validation==3

gen ExpectedProbability=BogusOnlineModel7*TaxCreditBeforeAdjustment
gsort TaxQuarter -ExpectedProbability
by TaxQuarter: gen QuarterlyExpectedRankModel7=_n

gen prediction=0
replace prediction=1 if QuarterlyExpectedRankModel7<=50
replace prediction=2 if QuarterlyExpectedRankModel7<=100&QuarterlyExpectedRankModel7>50
replace prediction=3 if QuarterlyExpectedRankModel7<=150&QuarterlyExpectedRankModel7>100
replace prediction=4 if QuarterlyExpectedRankModel7<=200&QuarterlyExpectedRankModel7>150
replace prediction=5 if QuarterlyExpectedRankModel7<=300&QuarterlyExpectedRankModel7>200


label values prediction prediction

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Ranking=prediction probability*TaxCredit. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel7_ExpectedRanking.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel7_ExpectedRanking.pdf", as(pdf) replace


}




//Creating size of the problem for cancellation bogus data, model 7
// Model 5: All features, except the dealer profile related features
// Model 7: All features, including the dealer profile features
{
merge 1:1 TaxQuarter DealerTIN using "E:\Ofir\BogusFirmCatching\PredictionsBogusCancellation.dta", keepusing(BogusCancellationModel* CancellationRankModel* CancellationQuarterlyRankModel*) generate(merge_validation)


//label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values TaxQuarter quarter
label define prediction 1 "1-400" 2 "401-800" 3 "801-1200" 4 "1201-1600" 5 "1601-2500"


gen prediction=0
replace prediction=1 if CancellationQuarterlyRankModel7<=50
replace prediction=2 if CancellationQuarterlyRankModel7<=100&CancellationQuarterlyRankModel7>50
replace prediction=3 if CancellationQuarterlyRankModel7<=150&CancellationQuarterlyRankModel7>100
replace prediction=4 if CancellationQuarterlyRankModel7<=200&CancellationQuarterlyRankModel7>150
replace prediction=5 if CancellationQuarterlyRankModel7<=300&CancellationQuarterlyRankModel7>200

label values prediction prediction

*xlabel(, valuelabel)

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#3) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, cancellation data, all features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusCancellationModel7.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusCancellationModel7.pdf", as(pdf) replace
}





//Now merging the weighted models
//Weights: Turnover
//Weights: Output Tax
//Weights: Tax Credit
{

merge 1:1 TaxQuarter DealerTIN using "E:\Ofir\BogusFirmCatching\PredictionsBogusDifferentModels.dta", keepusing(RFModel* RankModel* QuarterlyRankModel*) generate(merge_validation)


label values TaxQuarter quarter
label define prediction 1 "1-400" 2 "401-800" 3 "801-1200" 4 "1201-1600" 5 "1601-2500"


gen prediction=0
replace prediction=1 if QuarterlyRankModelTurnover<=50
replace prediction=2 if QuarterlyRankModelTurnover<=100&QuarterlyRankModelTurnover>50
replace prediction=3 if QuarterlyRankModelTurnover<=150&QuarterlyRankModelTurnover>100
replace prediction=4 if QuarterlyRankModelTurnover<=200&QuarterlyRankModelTurnover>150
replace prediction=5 if QuarterlyRankModelTurnover<=300&QuarterlyRankModelTurnover>200

label values prediction prediction

*xlabel(, valuelabel)

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features (weighted by turnover)"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineTurnoverModel.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineTurnoverModel.pdf", as(pdf) replace


drop prediction

gen prediction=0
replace prediction=1 if QuarterlyRankModelOutputTax<=50
replace prediction=2 if QuarterlyRankModelOutputTax<=100&QuarterlyRankModelOutputTax>50
replace prediction=3 if QuarterlyRankModelOutputTax<=150&QuarterlyRankModelOutputTax>100
replace prediction=4 if QuarterlyRankModelOutputTax<=200&QuarterlyRankModelOutputTax>150
replace prediction=5 if QuarterlyRankModelOutputTax<=300&QuarterlyRankModelOutputTax>200

label values prediction prediction

*xlabel(, valuelabel)

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features (weighted by output tax)"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineOutputTaxModel.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineOutputTaxModel.pdf", as(pdf) replace

drop prediction

gen prediction=0
replace prediction=1 if QuarterlyRankModelTaxCredit<=50
replace prediction=2 if QuarterlyRankModelTaxCredit<=100&QuarterlyRankModelTaxCredit>50
replace prediction=3 if QuarterlyRankModelTaxCredit<=150&QuarterlyRankModelTaxCredit>100
replace prediction=4 if QuarterlyRankModelTaxCredit<=200&QuarterlyRankModelTaxCredit>150
replace prediction=5 if QuarterlyRankModelTaxCredit<=300&QuarterlyRankModelTaxCredit>200

label values prediction prediction


#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features (weighted by tax credit)"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineTaxCreditModel.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineTaxCreditModel.pdf", as(pdf) replace
}




//Bogus Online data minus y5
{
merge 1:1 TaxQuarter DealerTIN using "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline_MinusY5.dta", keepusing(BogusOnlineModel* OnlineRankModel* OnlineQuarterlyRankModel*) generate(merge_validation)


label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values TaxQuarter quarter
label define prediction 1 "1-400" 2 "401-800" 3 "801-1200" 4 "1201-1600" 5 "1601-2500"


gen prediction=0
replace prediction=1 if OnlineQuarterlyRankModel7<=50
replace prediction=2 if OnlineQuarterlyRankModel7<=100&OnlineQuarterlyRankModel7>50
replace prediction=3 if OnlineQuarterlyRankModel7<=150&OnlineQuarterlyRankModel7>100
replace prediction=4 if OnlineQuarterlyRankModel7<=200&OnlineQuarterlyRankModel7>150
replace prediction=5 if OnlineQuarterlyRankModel7<=300&OnlineQuarterlyRankModel7>200

label values prediction prediction

*xlabel(, valuelabel)

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter)(connected OutputTaxBeforeAdjustment TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#4) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15. Not trained on last year")) 
	   legend(order(1 "Tax Credit" 2 "Output Tax") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;
graph save Graph "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel7_MinusY5.gph"
graph export "E:\data\PreliminaryAnalysis\BogusDealers\TaxCredits_predictions_BogusOnlineModel7_MinusY5.pdf", as(pdf) replace
}



#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected UnTaxProp TaxQuarter) 
	   if prediction>0&prediction<6, ylabel(#5) ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Proportion sales to unregistered firms") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction);
restore;

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction2);
twoway (connected UnTaxProp TaxQuarter), 
	    ytitle("Rupees (in crores)") by(, note("Graphs by prediction rankings. Amount in crores. From Q1,2012-13 to Q4, 2014-15")) 
	   legend(order(1 "Proportion sales to unregistered firms") region(lcolor(none))) 
	   by(, title("Bogus firms, online data, all features"))
	   by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
	   by(prediction2);
restore;


#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter if prediction==1) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==1)
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==2, lpattern(dash)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==2, lpattern(dash))
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==3, lpattern(dot)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==3, lpattern(dot))
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==4, lpattern(dash_dot)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==4, lpattern(dash_dot))
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==5, lpattern(dash_3dot)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==5, lpattern(dash_3dot)),
	ytitle("Input credit and Output Tax") graphregion(color(white)) title("Bogus firms") note("Amounts in crores") 
	legend(order(1 "Tax Credit (1-400)" 2 "Output Tax (1-400)" 3 "Tax Credit (401-800)" 4 "Output Tax (401-800)" 5 
	"Tax Credit (801-1200)" 6 "Output Tax (801-1200)" 7 "Tax Credit (1201-1600)" 8 "Output Tax (1201-1600)" 9 "Tax Credit (1601-2500)" 10 "Output Tax (1601-2500)" ));
restore;

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected UnTaxProp TaxQuarter if prediction==1) 
	(connected UnTaxProp TaxQuarter if prediction==2, lpattern(dash))
	(connected UnTaxProp TaxQuarter if prediction==3, lpattern(dot)) 
	(connected UnTaxProp TaxQuarter if prediction==4, lpattern(dash_dot))
	(connected UnTaxProp TaxQuarter if prediction==5, lpattern(dash_3dot)) 
	graphregion(color(white)) title("Bogus firms, Proportion sales to unregistered firms")  
	legend(order(1 "Prediction Rank 1-400" 2 "Prediction Rank 401-800" 3 
	"Prediction Rank 801-1200" 4 "Prediction Rank 1201-1600" 5 "Prediction Rank 1601-2500"));
restore;





merge 1:1 TaxQuarter DealerTIN using "E:\Ofir\BogusFirmCatching\PredictionsBogusCancellation.dta", keepusing(BogusCancellationModel* CancellationRankModel* CancellationQuarterlyRankModel*) generate(merge_validation)

gen prediction=0
replace prediction=1 if CancellationQuarterlyRankModel7<=50
replace prediction=2 if CancellationQuarterlyRankModel7<=100&CancellationQuarterlyRankModel7>50
replace prediction=3 if CancellationQuarterlyRankModel7<=150&CancellationQuarterlyRankModel7>100
replace prediction=4 if CancellationQuarterlyRankModel7<=200&CancellationQuarterlyRankModel7>150
replace prediction=5 if CancellationQuarterlyRankModel7<=300&CancellationQuarterlyRankModel7>200

drop prediction

gen prediction=0
replace prediction=1 if CancellationQuarterlyRankModel5<=50
replace prediction=2 if CancellationQuarterlyRankModel5<=100&CancellationQuarterlyRankModel5>50
replace prediction=3 if CancellationQuarterlyRankModel5<=150&CancellationQuarterlyRankModel5>100
replace prediction=4 if CancellationQuarterlyRankModel5<=200&CancellationQuarterlyRankModel5>150
replace prediction=5 if CancellationQuarterlyRankModel5<=300&CancellationQuarterlyRankModel5>200



#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter prediction);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter if prediction==1) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==1)
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==2, lpattern(dash)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==2, lpattern(dash))
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==3, lpattern(dot)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==3, lpattern(dot))
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==4, lpattern(dash_dot)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==4, lpattern(dash_dot))
	(connected TaxCreditBeforeAdjustment TaxQuarter if prediction==5, lpattern(dash_3dot)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter if prediction==5, lpattern(dash_3dot)),
	ytitle("Input credit and Output Tax") graphregion(color(white)) title("Bogus firms") note("Amounts in crores") 
	legend(order(1 "Tax Credit (1-400)" 2 "Output Tax (1-400)" 3 "Tax Credit (401-800)" 4 "Output Tax (401-800)" 5 
	"Tax Credit (801-1200)" 6 "Output Tax (801-1200)" 7 "Tax Credit (1201-1600)" 8 "Output Tax (1201-1600)" 9 "Tax Credit (1601-2500)" 10 "Output Tax (1601-2500)" ));
restore;













#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter bogus_online);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter, lpattern(dash)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter, lpattern(dash_dot)) 
	(connected UnTaxProp TaxQuarter, lpattern(dash_3dot) yaxis(2)) 
	if bogus_online==1, ytitle("Input credit and Output Tax") graphregion(color(white)) title("Bogus firms (from online data)") note("Amounts in crores") 
	legend(order(1 "Tax Credit" 2 "Output Tax" 3 "Proportion sales made to unregistered firms"));
restore;

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDeposited, by(TaxQuarter bogus_online);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter, lpattern(dash)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter, lpattern(dash_dot)) 
	(connected UnTaxProp TaxQuarter, lpattern(dash_3dot) yaxis(2)) 
	if bogus_online==0, ytitle("Input Credit and Output Tax") graphregion(color(white)) title("Non Bogus firms)") note("Amounts in crores") 
	legend(order(1 "Tax Credit" 2 "Output Tax" 3 "Proportion sales to unregistered firms"));
restore;

#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter bogus_cancellation);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter, lpattern(dash)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter, lpattern(dash_dot)) 
	if bogus_cancellation==1, ytitle("Input credit and Output Tax") graphregion(color(white)) title("Bogus firms (from cancellation data)") note("Amounts in crores") 
	legend(order(1 "Tax Credit" 2 "Output Tax" ));
restore;





#delimit ;
preserve;
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter bogus_online);
twoway (connected TaxCreditBeforeAdjustment TaxQuarter, lpattern(dash)) 
	(connected OutputTaxBeforeAdjustment TaxQuarter, lpattern(dash_dot)) 
	(connected UnTaxProp TaxQuarter, lpattern(dash_3dot) yaxis(2)) 
	if bogus_online==1, ytitle("Input credit and Output Tax") graphregion(color(white)) title("Bogus firms") note("Amounts in crores") 
	legend(order(1 "Tax Credit" 2 "Output Tax" 3 "Proportion sales made to unregistered firms"));
restore;



preserve
collapse (mean) UnTaxProp (sum) TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter bogus_cancellation)
twoway (connected TaxCreditBeforeAdjustment TaxQuarter, lpattern(dash)) (connected OutputTaxBeforeAdjustment TaxQuarter, lpattern(dash_dot)) (connected UnTaxProp TaxQuarter, lpattern(dash_3dot) yaxis(2)) if bogus_cancellation==1
restore

