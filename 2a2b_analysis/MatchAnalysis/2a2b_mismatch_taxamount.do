
use "F:\2a2b_analysis\MatchAnalysis\purchases_2a2b.dta", clear
drop Count2
bys SourceFile DealerTIN SellerBuyerTIN: gen Count2=_n
bys SourceFile DealerTIN SellerBuyerTIN: egen SumTaxAmount=sum(TaxAmount)
keep if Count2==1
isid SourceFile DealerTIN SellerBuyerTIN SumTaxAmount
drop SalePurchaseType DealerGoodType TransactionType Rate Amount TotalAmount DealerName Month DateTime ReceiptId Date TaxRate AEBoolean T985DF1 T985DF2 T985DF3
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\purchases_2a2b_taxes_201314.dta"


use "F:\2a2b_analysis\MatchAnalysis\sales_2a2b.dta", clear
drop Count2
bys SourceFile DealerTIN SellerBuyerTIN: gen Count2=_n
by SourceFile DealerTIN SellerBuyerTIN: egen SumTaxAmount=sum(TaxAmount)
keep if Count2==1
isid SourceFile DealerTIN SellerBuyerTIN SumTaxAmount
drop SalePurchaseType DealerGoodType TransactionType Rate Amount TotalAmount DealerName Month DateTime ReceiptId Date TaxRate AEBoolean T985DF1 T985DF2 T985DF3
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\sales_2a2b_taxes_201314.dta" 


use "F:\2a2b_analysis\MatchAnalysis\OtherMatching\purchases_2a2b_taxes_201314.dta", clear
rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 SourceFile DealerTIN SellerBuyerTIN SumTaxAmount using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\sales_2a2b_taxes_201314.dta", keepusing(Quarter)

gen TaxQuarter=13 if SourceFile=="t9854113"
replace TaxQuarter=14 if SourceFile=="t9854213"
replace TaxQuarter=15 if SourceFile=="t9854313"
replace TaxQuarter=16 if SourceFile=="t9854413"
replace TaxQuarter=17 if SourceFile=="t9854114"
replace TaxQuarter=18 if SourceFile=="t9854214"
replace TaxQuarter=19 if SourceFile=="t9854314"
replace TaxQuarter=20 if SourceFile=="t9854414"


gen Match=0
replace Match=1 if _merge==3


//Purchases
drop if _merge==2
bys TaxQuarter SellerBuyerTIN: egen TotalMatch=sum(Match)
by TaxQuarter SellerBuyerTIN: egen AvgMatch=mean(Match)
by TaxQuarter SellerBuyerTIN: gen RunningCount=_n
by TaxQuarter SellerBuyerTIN: gen TotalCount=_N

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN
keep if RunningCount==1

save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_purchases_201314.dta", replace



//Sales

drop if _merge==1
bys TaxQuarter DealerTIN: egen TotalMatch=sum(Match)
by TaxQuarter DealerTIN: egen AvgMatch=mean(Match)
by TaxQuarter DealerTIN: gen RunningCount=_n
by TaxQuarter DealerTIN: gen TotalCount=_N

keep if RunningCount==1

save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_sales_201314.dta"





use "F:\2a2b_analysis\MatchAnalysis\purchases_2a2b_2012.dta", replace
drop Count TotalCount

bys SourceFile DealerTIN SellerBuyerTIN: gen Count=_n
by SourceFile DealerTIN SellerBuyerTIN: gen TotalCount=_N
by SourceFile DealerTIN SellerBuyerTIN: egen SumTaxAmount=sum(TaxAmount)
keep if Count==1
drop Count TotalCount
isid SourceFile DealerTIN SellerBuyerTIN
drop SalePurchaseType DealerGoodType TransactionType Rate Amount TotalAmount DealerName Month DateTime ReceiptId Date TaxRate AEBoolean T985DF1 T985DF2 T985DF3 FormsStatus T985DF4 T985DF5 T985DF6 T985DF7 T985DF8
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\purchases_2a2b_taxes_2012.dta", replace


use "F:\2a2b_analysis\MatchAnalysis\sales_2a2b_2012.dta", clear
drop Count TotalCount
bys SourceFile DealerTIN SellerBuyerTIN: gen Count2=_n
by SourceFile DealerTIN SellerBuyerTIN: egen SumTaxAmount=sum(TaxAmount)
keep if Count2==1
isid SourceFile DealerTIN SellerBuyerTIN

drop SalePurchaseType DealerGoodType TransactionType Rate Amount TotalAmount DealerName Month DateTime ReceiptId Date TaxRate AEBoolean T985DF1 T985DF2 T985DF3 
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\sales_2a2b_taxes_2012.dta", replace




use "F:\2a2b_analysis\MatchAnalysis\OtherMatching\purchases_2a2b_taxes_2012.dta", clear
rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 SourceFile DealerTIN SellerBuyerTIN SumTaxAmount using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\sales_2a2b_taxes_2012.dta"


gen TaxMonth=25 if SourceFile=="t985412"
replace TaxMonth=26 if SourceFile=="t985512"
replace TaxMonth=27 if SourceFile=="t985612"
replace TaxMonth=28 if SourceFile=="t985712"
replace TaxMonth=29 if SourceFile=="t985812"
replace TaxMonth=30 if SourceFile=="t985912"
replace TaxMonth=31 if SourceFile=="t9851012"
replace TaxMonth=32 if SourceFile=="t9851112"
replace TaxMonth=33 if SourceFile=="t9851212"
replace TaxMonth=34 if SourceFile=="t985113"
replace TaxMonth=35 if SourceFile=="t985213"
replace TaxMonth=36 if SourceFile=="t985313"

gen Match=0
replace Match=1 if _merge==3


gen TaxQuarter=0
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36


//Purchases
drop if _merge==2

bys TaxMonth SellerBuyerTIN: egen TotalMatch=sum(Match)
by TaxMonth SellerBuyerTIN: egen AvgMatch=mean(Match)
by TaxMonth SellerBuyerTIN: gen RunningCount=_n
by TaxMonth SellerBuyerTIN: gen TotalCount=_N

keep if RunningCount==1
drop RunningCount TotalCount

rename SumTaxAmount TaxAmount

bys TaxQuarter SellerBuyerTIN: egen QAvgMatch=mean(AvgMatch)
by TaxQuarter SellerBuyerTIN: gen RunningCount=_n
by TaxQuarter SellerBuyerTIN: egen SumTaxAmount=sum(TaxAmount)

keep if RunningCount==1
rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN
replace AvgMatch=QAvgMatch
drop QAvgMatch
//drop _merge Count2 TaxMonth RunningCount 
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_purchases_2012.dta", replace


//Sales
drop if _merge==1

bys TaxMonth DealerTIN: egen TotalMatch=sum(Match)
by TaxMonth DealerTIN: egen AvgMatch=mean(Match)
by TaxMonth DealerTIN: gen RunningCount=_n
by TaxMonth DealerTIN: gen TotalCount=_N

keep if RunningCount==1
drop RunningCount TotalCount TaxAmount
rename SumTaxAmount TaxAmount

bys TaxQuarter DealerTIN: egen QAvgMatch=mean(AvgMatch)
by TaxQuarter DealerTIN: gen RunningCount=_n
by TaxQuarter DealerTIN: egen SumTaxAmount=sum(TaxAmount)

keep if RunningCount==1
replace AvgMatch=QAvgMatch
drop QAvgMatch

save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_sales_2012.dta"


use "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_purchases_2012.dta", clear
append using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_purchases_201314.dta"
drop SellerBuyerTIN _merge RunningCount Count2
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatchingPurchaseAllQuarters.dta",


#delimit ;
preserve;
collapse (mean) AvgMatch, by (TaxQuarter);
twoway (connected AvgMatch TaxQuarter),
	   title("Matching Ratios on the Purchase side") 
	   note("Firm level proportion of purchase entries matching with corresponding sale entries (on tax amount)") ytitle("");
    restore;

use "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_sales_2012.dta", clear
append using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatching_sales_201314.dta"
drop SellerBuyerTIN _merge RunningCount Count2
save "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatchingSalesAllQuarters.dta",
	

#delimit ;
preserve;
collapse (mean) AvgMatch, by (TaxQuarter);
twoway (connected AvgMatch TaxQuarter),
	   title("Matching Ratios on the Sales side") 
	   note("Firm level proportion of sales entries matching with corresponding purchase entries (on tax amount)") ytitle("");
    restore;

	
	