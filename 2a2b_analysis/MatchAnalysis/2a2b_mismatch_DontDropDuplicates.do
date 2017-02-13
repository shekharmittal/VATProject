use "E:\data\annexure_2A2B_monthly_201213.dta", clear

keep if SaleOrPurchase=="BF"
keep if SalePurchaseType=="LS"|SalePurchaseType==""

replace DealerGoodType="OT" if DealerGoodType==" OT"
replace DealerGoodType="OT" if DealerGoodType=="OT             "
replace DealerGoodType="OT" if DealerGoodType=="OT     "
replace DealerGoodType="OT" if DealerGoodType=="OT "
replace DealerGoodType="OT" if DealerGoodType=="OT  "
replace DealerGoodType="OT" if DealerGoodType=="Ot"
replace DealerGoodType="OT" if DealerGoodType=="ot"
replace DealerGoodType="OT" if DealerGoodType=="ot "
replace DealerGoodType="OT" if DealerGoodType=="OT  "

replace DealerGoodType="UD" if DealerGoodType=="uD"
replace DealerGoodType="UD" if DealerGoodType=="ud"

replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "

replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"


replace TransactionType=trim(TransactionType)
replace DealerGoodType=trim(DealerGoodType)

keep if DealerGoodType=="RD"|DealerGoodType=="OT"|DealerGoodType=="CG"

keep if TransactionType=="GD"|TransactionType=="WC"
drop if SellerBuyerTIN==""

replace Rate=trim(Rate)

replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="0.99"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="0.01"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="2" if Rate=="0.02"
replace Rate="12.5" if Rate=="12.49"
replace Rate="12.5" if Rate=="12.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="12.5" if Rate=="125.00"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="0.05"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="5.0000"
replace Rate="5" if Rate=="05.00"
replace Rate="5" if Rate=="4.99"
replace Rate="4" if Rate=="4.00"
replace Rate="4" if Rate=="0.04"
replace Rate="10" if Rate=="0.10"
replace Rate="10" if Rate=="10.00"
replace Rate="12.5" if Rate=="0.12"

drop if Rate=="3.00"
drop if Rate=="2.50"
drop if SellerBuyerTIN=="NA"|SellerBuyerTIN=="0"
drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4
drop if Rate==""


drop if SellerBuyerTIN==""

bys SourceFile DealerTIN SellerBuyerTIN Rate: gen TotalCount2=_N
by SourceFile DealerTIN SellerBuyerTIN Rate: egen TotalTaxAmount= sum(TaxAmount)
by SourceFile DealerTIN SellerBuyerTIN Rate: gen Count2=_n
keep if Count2==1


isid SourceFile DealerTIN SellerBuyerTIN Rate

drop TransactionType DealerGoodType SalePurchaseType  Count2 T985DF3 T985DF2 T985DF1 AEBoolean TaxRate Date ReceiptId DateTime Year DealerName TotalAmount TaxAmount Month Amount

rename TotalTaxAmount SalesTaxAmount

save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_2012_taxamount.dta", replace


use "E:\data\annexure_2A2B_monthly_201213.dta", clear
keep if SaleOrPurchase=="AE"
replace SalePurchaseType="OT" if SalePurchaseType=="ot"
keep if SalePurchaseType=="CG"|SalePurchaseType=="OT"|SalePurchaseType==""

keep if DealerGoodType==""|DealerGoodType=="OT"|DealerGoodType=="CG"

drop if SellerBuyerTIN==""

replace Rate=trim(Rate)
replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="0.99"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="0.01"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="2" if Rate=="0.02"
replace Rate="12.5" if Rate=="12.49"
replace Rate="12.5" if Rate=="12.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="12.5" if Rate=="125.00"
replace Rate="12.5" if Rate==".12"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="0.05"
replace Rate="5" if Rate==".05"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="5.0000"
replace Rate="5" if Rate=="05.00"
replace Rate="5" if Rate=="4.99"
replace Rate="4" if Rate=="4.00"
replace Rate="4" if Rate=="0.04"
replace Rate="10" if Rate=="0.10"
replace Rate="10" if Rate=="10.00"
replace Rate="12.5" if Rate=="0.12"

gen dRate=Rate
destring dRate, replace
replace dRate=Amount if Rate!="5"&Rate!="4"&Rate!="12.5"&Rate!="1"&Rate!="0"&Rate!="2"&Rate!="20"&Rate!="0"&Rate!=""

gen d2Rate=Rate
destring d2Rate, replace
replace Amount=d2Rate if Rate!="5"&Rate!="4"&Rate!="12.5"&Rate!="1"&Rate!="0"&Rate!="2"&Rate!="20"&Rate!="0"&Rate!=""

tostring dRate, replace
replace Rate=dRate if Rate!="5"&Rate!="4"&Rate!="12.5"&Rate!="1"&Rate!="0"&Rate!="2"&Rate!="20"&Rate!="0"&Rate!=""

drop if Rate==""
drop dRate d2Rate

replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="0.99"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="0.01"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="2" if Rate=="0.02"
replace Rate="12.5" if Rate=="12.49"
replace Rate="12.5" if Rate=="12.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="12.5" if Rate=="125.00"
replace Rate="12.5" if Rate==".12"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="0.05"
replace Rate="5" if Rate==".05"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="5.0000"
replace Rate="5" if Rate=="05.00"
replace Rate="5" if Rate=="4.99"
replace Rate="4" if Rate=="4.00"
replace Rate="4" if Rate=="0.04"
replace Rate="10" if Rate=="0.10"
replace Rate="10" if Rate=="10.00"
replace Rate="12.5" if Rate=="0.12"

keep if Rate=="5"|Rate=="4"|Rate=="12.5"|Rate=="1"|Rate=="0"|Rate=="2"|Rate=="20"|Rate=="0"

replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "

replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"

replace TransactionType=trim(TransactionType)

drop if TransactionType==""


bys SourceFile DealerTIN SellerBuyerTIN Rate: gen TotalCount2=_N
by SourceFile DealerTIN SellerBuyerTIN Rate: egen TotalTaxAmount= sum(TaxAmount)
by SourceFile DealerTIN SellerBuyerTIN Rate: gen Count2=_n
keep if Count2==1


isid SourceFile DealerTIN SellerBuyerTIN Rate

drop TransactionType DealerGoodType SalePurchaseType  Count2 T985DF3 T985DF2 T985DF1 AEBoolean TaxRate Date ReceiptId DateTime Year DealerName TotalAmount TaxAmount Month Amount
drop FormsStatus T985DF4 T985DF5 T985DF6 T985DF7 T985DF8	
rename TotalTaxAmount PurchaseTaxAmount
save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_2012_taxamount.dta"


use "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_2012_taxamount.dta", clear

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 SourceFile DealerTIN SellerBuyerTIN Rate using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_2012_taxamount.dta"

replace SalesTaxAmount=0 if SalesTaxAmount==.&_merge==1
replace PurchaseTaxAmount=0 if PurchaseTaxAmount==.&_merge==2

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

gen TaxQuarter=0
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36

gen DiffTaxAmount=PurchaseTaxAmount-SalesTaxAmount
gen PropDiff=DiffTaxAmount/PurchaseTaxAmount



//Purchases
drop if _merge==2


/*
bys TaxQuarter SellerBuyerTIN: egen TotalPurchaseTaxAmount=sum(PurchaseTaxAmount)
bys TaxQuarter SellerBuyerTIN: egen TotalSalesTaxAmount=sum(SalesTaxAmount)
by TaxQuarter SellerBuyerTIN: gen RunningCount=_n
keep if RunningCount==1


drop PurchaseTaxAmount SalesTaxAmount

rename TotalPurchaseTaxAmount PurchaseTaxAmount
rename TotalSalesTaxAmount SalesTaxAmount
*/

gen Match=0
replace Match=1 if abs(DiffTaxAmount)<=5

//gen Match2=0
//replace Match2=1 if abs(DiffTaxAmount)<.005*PurchaseTaxAmount

gen Match3=0
replace Match3=1 if abs(DiffTaxAmount)<.01*PurchaseTaxAmount


//gen Match4=0
//replace Match4=1 if abs(DiffTaxAmount)<.05*PurchaseTaxAmount


gen NameMatch=0
replace NameMatch=1 if _merge==3

//gen OrMatch=Match|Match2

//gen lSalesTaxAmount=log(1+SalesTaxAmount)
//gen lPurchaseTaxAmount=log(1+PurchaseTaxAmount)


//Purchases
//bys TaxQuarter SellerBuyerTIN: egen TotalMatch=sum(Match)
bys TaxQuarter SellerBuyerTIN: egen AvgMatch=mean(Match)
by TaxQuarter SellerBuyerTIN: gen TotalMatch=sum(Match)

bys TaxQuarter SellerBuyerTIN: egen AvgMatch3=mean(Match3)
by TaxQuarter SellerBuyerTIN: gen TotalMatch3=sum(Match3)

bys TaxQuarter SellerBuyerTIN: egen AvgNameMatch=mean(NameMatch)
by TaxQuarter SellerBuyerTIN: gen TotalNameMatch=sum(NameMatch)

by TaxQuarter SellerBuyerTIN: gen RunningCount=_n
by TaxQuarter SellerBuyerTIN: gen TotalCount=_N

#delimit ;
preserve;
keep if RunningCount==1;
bys TaxQuarter: sum AvgMatch AvgMatch3 AvgNameMatch;
restore;

keep if RunningCount==1

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_matchdata_2012.dta"


//Sales
drop if _merge==1


gen Match=0
replace Match=1 if abs(DiffTaxAmount)<=5&_merge==3

//gen Match2=0
//replace Match2=1 if abs(DiffTaxAmount)<.005*PurchaseTaxAmount

gen Match3=0
replace Match3=1 if abs(DiffTaxAmount)<.01*SalesTaxAmount&_merge==3


//gen Match4=0
//replace Match4=1 if abs(DiffTaxAmount)<.05*PurchaseTaxAmount


gen NameMatch=0
replace NameMatch=1 if _merge==3



//Sales
//bys TaxQuarter SellerBuyerTIN: egen TotalMatch=sum(Match)
bys TaxQuarter DealerTIN: egen AvgMatch=mean(Match)
by TaxQuarter DealerTIN: gen TotalMatch=sum(Match)

bys TaxQuarter DealerTIN: egen AvgMatch3=mean(Match3)
by TaxQuarter DealerTIN: gen TotalMatch3=sum(Match3)

bys TaxQuarter DealerTIN: egen AvgNameMatch=mean(NameMatch)
by TaxQuarter DealerTIN: gen TotalNameMatch=sum(NameMatch)

by TaxQuarter DealerTIN: gen RunningCount=_n
by TaxQuarter DealerTIN: gen TotalCount=_N


keep if RunningCount==1

save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_matchdata_2012.dta", replace



#delimit ;
preserve;
keep if RunningCount==1;
collapse (mean)AvgMatch AvgMatch2 AvgNameMatch AvgOrMatch AvgMatch3 AvgMatch4, by(TaxMonth);
twoway (connected AvgMatch TaxMonth) (connected AvgMatch3 TaxMonth) (connected AvgMatch4 TaxMonth) (connected AvgNameMatch TaxMonth),
	   title("Matching Ratios on the Purchase side") 
	   note("Firm level proportion of purchase entries matching with corresponding sale entries (on tax amount)") ytitle("");
    restore;


cd "E:\data"

use "annexure_2A2B_quarterly_2013.dta", clear
use "annexure_2A2B_quarterly_2014.dta", clear


keep if SaleOrPurchase=="BF"
keep if SalePurchaseType=="LS"


replace DealerGoodType="OT" if DealerGoodType==" OT"
replace DealerGoodType="OT" if DealerGoodType=="OT             "
replace DealerGoodType="OT" if DealerGoodType=="OT     "
replace DealerGoodType="OT" if DealerGoodType=="OT "
replace DealerGoodType="OT" if DealerGoodType=="OT  "
replace DealerGoodType="OT" if DealerGoodType=="Ot"
replace DealerGoodType="OT" if DealerGoodType=="ot"
replace DealerGoodType="OT" if DealerGoodType=="ot "
replace DealerGoodType="OT" if DealerGoodType=="OT  "

replace DealerGoodType="UD" if DealerGoodType=="uD"
replace DealerGoodType="UD" if DealerGoodType=="ud"

replace TransactionType=trim(TransactionType)
replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "

replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"


replace TransactionType=trim(TransactionType)
keep if DealerGoodType=="RD"

replace Rate=trim(Rate)

replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="05.00"
replace Rate="5" if Rate=="4.99"
replace Rate="4" if Rate=="4.00"

drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

drop if SellerBuyerTIN==""

bys SourceFile DealerTIN SellerBuyerTIN Rate: gen TotalCount2=_N
by SourceFile DealerTIN SellerBuyerTIN Rate: egen TotalTaxAmount= sum(TaxAmount)
by SourceFile DealerTIN SellerBuyerTIN Rate: gen Count2=_n
keep if Count2==1

isid SourceFile DealerTIN SellerBuyerTIN Rate
drop TransactionType DealerGoodType SalePurchaseType  Count2 T985DF3 T985DF2 T985DF1 AEBoolean TaxRate Date ReceiptId DateTime Year DealerName TotalAmount TaxAmount Month Amount

rename TotalTaxAmount SalesTaxAmount

save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_2013_taxamount.dta", replace

append using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_2013_taxamount.dta"
save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_201314_taxamount.dta", replace


/**************************
//Purchased From
***************************/
use "annexure_2A2B_quarterly_2013.dta", clear
use "annexure_2A2B_quarterly_2014.dta", clear


keep if SaleOrPurchase=="AE"

keep if SalePurchaseType=="CG"|SalePurchaseType=="OT"|DealerGoodType=="CG"|DealerGoodType=="OT"
drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

replace TransactionType=trim(TransactionType)
replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "
replace TransactionType="GD" if TransactionType=="gD"

replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"

replace Rate=trim(Rate)
replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="05.00"
replace Rate="4" if Rate=="4.00"

drop if Rate=="13.13"|Rate=="14"
drop if SellerBuyerTIN==""


gen dummy=1
bys SourceFile DealerTIN SellerBuyerTIN Rate:egen TransActionCount=sum(dummy)
*by SourceFile DealerTIN SellerBuyerTIN:egen SumAmount=sum(Amount)
by SourceFile DealerTIN SellerBuyerTIN Rate:egen TotalTaxAmount=sum(TaxAmount)
by SourceFile DealerTIN SellerBuyerTIN Rate:gen Count2=_n

keep if Count2==1

isid SourceFile DealerTIN SellerBuyerTIN Rate
drop TransactionType DealerGoodType SalePurchaseType dummy  Count2 T985DF3 T985DF2 T985DF1 AEBoolean TaxRate Date ReceiptId DateTime Year DealerName TotalAmount TaxAmount Month Amount

rename TotalTaxAmount PurchaseTaxAmount
save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_2013_taxamount.dta", replace

append using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_2013_taxamount.dta"
save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_201314_taxamount.dta"


use "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_201314_taxamount.dta", clear


rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 SourceFile DealerTIN SellerBuyerTIN Rate using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_201314_taxamount.dta"


gen TaxQuarter=13 if SourceFile=="t9854113"
replace TaxQuarter=14 if SourceFile=="t9854213"
replace TaxQuarter=15 if SourceFile=="t9854313"
replace TaxQuarter=16 if SourceFile=="t9854413"
replace TaxQuarter=17 if SourceFile=="t9854114"
replace TaxQuarter=18 if SourceFile=="t9854214"
replace TaxQuarter=19 if SourceFile=="t9854314"
replace TaxQuarter=20 if SourceFile=="t9854414"

replace SalesTaxAmount=0 if SalesTaxAmount==.&_merge==1
replace PurchaseTaxAmount=0 if PurchaseTaxAmount==.&_merge==2
gen DiffTaxAmount=PurchaseTaxAmount-SalesTaxAmount
gen PropDiff=DiffTaxAmount/PurchaseTaxAmount



//Purchases
drop if _merge==2

gen Match=0
replace Match=1 if abs(DiffTaxAmount)<=5

//gen Match2=0
//replace Match2=1 if abs(DiffTaxAmount)<.005*PurchaseTaxAmount

gen Match3=0
replace Match3=1 if abs(DiffTaxAmount)<.01*PurchaseTaxAmount

//gen Match4=0
//replace Match4=1 if abs(DiffTaxAmount)<.05*PurchaseTaxAmount

gen NameMatch=0
replace NameMatch=1 if _merge==3

//gen OrMatch=Match|Match2

//gen lSalesTaxAmount=log(1+SalesTaxAmount)
//gen lPurchaseTaxAmount=log(1+PurchaseTaxAmount)


//Purchases
//bys TaxQuarter SellerBuyerTIN: egen TotalMatch=sum(Match)
bys TaxQuarter SellerBuyerTIN: egen AvgMatch=mean(Match)
bys TaxQuarter SellerBuyerTIN: egen TotalMatch=sum(Match)

bys TaxQuarter SellerBuyerTIN: egen AvgMatch3=mean(Match3)
bys TaxQuarter SellerBuyerTIN: egen TotalMatch3=sum(Match3)


bys TaxQuarter SellerBuyerTIN: egen AvgNameMatch=mean(NameMatch)
bys TaxQuarter SellerBuyerTIN: egen TotalNameMatch=sum(NameMatch)

by TaxQuarter SellerBuyerTIN: gen RunningCount=_n
by TaxQuarter SellerBuyerTIN: gen TotalCount=_N

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

keep if RunningCount==1

save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_matchdata_201314.dta", replace




//Sales
drop if _merge==1

gen Match=0
replace Match=1 if abs(DiffTaxAmount)<=5&_merge==3

//gen Match2=0
//replace Match2=1 if abs(DiffTaxAmount)<.005*PurchaseTaxAmount

gen Match3=0
replace Match3=1 if abs(DiffTaxAmount)<.01*SalesTaxAmount&_merge==3


//gen Match4=0
//replace Match4=1 if abs(DiffTaxAmount)<.05*PurchaseTaxAmount

gen NameMatch=0
replace NameMatch=1 if _merge==3



//bys TaxQuarter SellerBuyerTIN: egen TotalMatch=sum(Match)
bys TaxQuarter DealerTIN: egen AvgMatch=mean(Match)
bys TaxQuarter DealerTIN: egen TotalMatch=sum(Match)

bys TaxQuarter DealerTIN: egen AvgMatch3=mean(Match3)
bys TaxQuarter DealerTIN: egen TotalMatch3=sum(Match3)


bys TaxQuarter DealerTIN: egen AvgNameMatch=mean(NameMatch)
bys TaxQuarter DealerTIN: egen TotalNameMatch=sum(NameMatch)

by TaxQuarter DealerTIN: gen RunningCount=_n
by TaxQuarter DealerTIN: gen TotalCount=_N

keep if RunningCount==1

save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_matchdata_201314.dta"
use "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_matchdata_201314.dta", clear
append using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_matchdata_2012.dta"
drop Match Match3 DiffTaxAmount PropDiff SellerBuyerTIN Rate RunningCount TaxMonth NameMatch
save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\sales_2a2b_matchdata_all.dta"



use "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_matchdata_201314.dta", clear
append using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_matchdata_2012.dta"
drop Match Match3 DiffTaxAmount PropDiff SellerBuyerTIN Rate RunningCount TaxMonth NameMatch
save "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\purchases_2a2b_matchdata_all.dta"

twoway (scatter lSalesTaxAmount lPurchaseTaxAmount if TaxQuarter==17&Match2==0)

bys SourceFile: sum DiffTaxAmount, detail
tab SourceFile Match
tab SourceFile Match, missing row
tab SourceFile Match, missing row
tab SourceFile Match if _merge==3, missing row
tab SourceFile

twoway (scatter lSalesTaxAmount lPurchaseTaxAmount if SourceFile=="t9854113")
twoway (scatter lSalesTaxAmount lPurchaseTaxAmount if SourceFile=="t9854113"&Match==1)
twoway (scatter lSalesTaxAmount lPurchaseTaxAmount if SourceFile=="t9854113"&Match==0)


#delimit ;
preserve;
collapse (mean)AvgMatch AvgNameMatch AvgMatch3, by(TaxQuarter);
twoway (connected AvgMatch TaxQuarter) (connected AvgMatch3 TaxQuarter, lpattern(dash)) (connected AvgNameMatch TaxQuarter, lpattern(dash_dot)),
	   title("Matching Ratios on the purchase side") graphregion(color(white))
	   note("Firm level proportion of purchase entries matching with corresponding sale entries") ytitle("") legend(order(1 "Diff less than 5 rupees" 2 "Diff less than 1 percent" 3 "Matching on firm ids"));
    restore;

	
	
#delimit ;
preserve;
collapse (mean)AvgMatch AvgNameMatch AvgMatch3, by(TaxQuarter);
twoway (connected AvgMatch TaxQuarter) (connected AvgMatch3 TaxQuarter, lpattern(dash)) (connected AvgNameMatch TaxQuarter, lpattern(dash_dot)),
	   title("Matching ratios on the sales side") graphregion(color(white))
	   note("Firm level proportion of sales entries matching with corresponding purchase entries") ytitle("") legend(order(1 "Diff less than 5 rupees" 2 "Diff less than 1 percent" 3 "Matching on firm ids"));
    restore;
