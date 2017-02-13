* We first combine the files which calculated the minimum distance from the start nodes and end nodes in 2013q1
* We will then merge these files with returns information
use "H:\graphlab\2013_q1\PurchasedFrom\DistanceFromEndNode_min_final.dta", clear
merge 1:1 DealerTIN using "H:\graphlab\2013_q1\SoldTo\DistanceFromStartNodes_min_final.dta"
tostring DealerTIN, replace

/*
   Result                           # of obs.
    -----------------------------------------
    not matched                         9,994
        from master                       474  (_merge==1)
        from using                      9,520  (_merge==2)

    matched                           240,876  (_merge==3)
    -----------------------------------------
*/

rename dmin sdistance
rename _merge _merge_distance
label variable edistance "min distance from any of the end nodes"
save "H:\MinDistanceFromStartEndNodes.dta

/* 	
For the returns information, there are two types of firms which we plan to begin with
1. Filing monthly returns in 2010
2. Filing quarterly returns in 2010
We restrict our sample to firms which have returns for all the quarters.
For firms with monthly returns pre-2012, we add their returns to make the numbers at the quarterly level
*/

/*First lets create the quarterly firm data*/
//Save tax returns for the appropriate quarter
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear
tab TaxPeriod

drop if TurnoverGross<0

drop groupid ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory


gen TaxQuarter=0
replace TaxQuarter=1 if TaxPeriod=="First Quarter-2010"
replace TaxQuarter=2 if TaxPeriod=="Second Quarter-2010"
replace TaxQuarter=3 if TaxPeriod=="Third Quarter-2010"
replace TaxQuarter=4 if TaxPeriod=="Fourth Quarter-2010"
replace TaxQuarter=5 if TaxPeriod=="First Quarter-2011"
replace TaxQuarter=6 if TaxPeriod=="Second Quarter-2011"
replace TaxQuarter=7 if TaxPeriod=="Third Quarter-2011"
replace TaxQuarter=8 if TaxPeriod=="Fourth Quarter-2011"
replace TaxQuarter=9 if TaxPeriod=="First Quarter-2012"
replace TaxQuarter=10 if TaxPeriod=="Second Quarter-2012"
replace TaxQuarter=11 if TaxPeriod=="Third Quarter-2012"
replace TaxQuarter=12 if TaxPeriod=="Fourth Quarter-2012"
replace TaxQuarter=13 if TaxPeriod=="First Quarter-2013"
replace TaxQuarter=14 if TaxPeriod=="Second Quarter-2013"
replace TaxQuarter=15 if TaxPeriod=="Third Quarter-2013"
replace TaxQuarter=16 if TaxPeriod=="Fourth Quarter-2013"
replace TaxQuarter=17 if TaxPeriod=="First Quarter-2014"
replace TaxQuarter=18 if TaxPeriod=="Second Quarter-2014"
replace TaxQuarter=19 if TaxPeriod=="Third Quarter-2014"
replace TaxQuarter=20 if TaxPeriod=="Fourth Quarter-2014"


gen TaxYear=0
replace TaxYear=1 if TaxQuarter>0&TaxQuarter<=4
replace TaxYear=2 if TaxQuarter>4&TaxQuarter<=8
replace TaxYear=3 if TaxQuarter>8&TaxQuarter<=12
replace TaxYear=4 if TaxQuarter>12&TaxQuarter<=16
replace TaxYear=5 if TaxQuarter>16&TaxQuarter<=20


label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"

label values TaxQuarter quarter
label values TaxYear year	

//Keeping only those dealers which filed returns in all the quarters
gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N
keep if TotalCount==20


rename T312011 CommodityCode1
rename T312012 CommodityCode2
rename T312013 CommodityCode3

rename T312149 CommodityDescription1
rename T312150 CommodityDescription2
rename T312151 CommodityDescription3

label variable CommodityCode1 "Contains commodity code for returns in the first 3 years"
label variable CommodityCode2 "Contains commodity code for returns in the first 3 years"
label variable CommodityCode3 "Contains commodity code for returns in the first 3 years"

label variable CommodityDescription1 "Contains commodity description for returns in the first 3 years"
label variable CommodityDescription2 "Contains commodity description for returns in the first 3 years"
label variable CommodityDescription3 "Contains commodity description for returns in the first 3 years"

//For 2A 2B analysis we need variables which exist both pre and post 2012
//These variables do not exist in the pre. So we can use them for network analysis post but can not during pre period.
drop  DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood
drop T312002 RefundClaimedBoolean PeriodBegin PeriodEnd CommodityCode1 CommodityCode2 CommodityCode3 TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 InterestPayable PenaltyPayable TDSCertificates
drop HighSeaPurchase HighSeaSale PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule OtherDealersGoodsReJobF OtherDealersGoodsTrJobF OwnGoodsReceivedAfterJobF OwnGoodsTransferredAfterJobF InwardStockTransferConsignmentF OutwardStockTransferConsignmentF InwardStockTransferBranchF OutwardStockTransferBranchF CSTAdjustmentVAT CarryForwardTaxCredit SaleDelhiFormH LandCharges LaborCharges DieselSale ReturnType CommodityDescription3 CommodityDescription2 CommodityDescription1


collapse (sum) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase, by(DealerTIN TaxQuarter)

//Creating other variables of interest
gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)
gen TotalPurchases=PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer
gen PercValueAdded=(TurnoverGross-TotalPurchases)/(TotalPurchases)
gen TotalValueAdded=(TurnoverGross-TotalPurchases)
gen PercPurchaseUnregisteredDealer=PurchaseUnregisteredDealer/(TotalPurchases)

*label variable PurchaseNoCredit "R6.3 Total local purchases that are no eligible for credit of input tax"
label variable PercValueAdded "A measure of fraction of value added, definition is (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseUnregisteredDealer)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseUnregisteredDealer "A measure of amount purchased from unregistered dealers:PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisterdDealer)"
label variable TotalValueAdded "Total value added, (TurnoverGross-TotalPurchases)"
label variable TotalPurchases "Total purchases made: PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer"

merge m:1 DealerTIN using "H:\MinDistanceFromStartEndNodes.dta"
drop if _merge==2

//Now we will save these numbers and combine them with high turnover dealers
save "D:\data\MediumTurnoverDealers2010_with_distances.dta"


//Now we will repeat the process for Monthly turnover dealers
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta", clear
gsort DealerTIN month
drop if month==37|month==38
by DealerTIN: gen TotalCount=_N
tab TaxPeriod if TotalCount==36
tab month if TotalCount==36
keep if month==1&TotalCount==36
keep DealerTIN
gen monthly=1
save "D:\data\HighTurnoverDealers2010.dta"

gen Dummy=1
save "D:\data\HighTurnoverDealers2010_q1.dta", replace


clear
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear 
merge m:1 DealerTIN using "D:\data\HighTurnoverDealers2010.dta"
keep if _merge==3

tab TaxPeriod
drop if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="May-2013"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Annual-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="Apr-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"

drop if TurnoverGross<0

drop groupid ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory


gen TaxQuarter=0
replace TaxQuarter=1 if TaxPeriod=="First Quarter-2010"
replace TaxQuarter=2 if TaxPeriod=="Second Quarter-2010"
replace TaxQuarter=3 if TaxPeriod=="Third Quarter-2010"
replace TaxQuarter=4 if TaxPeriod=="Fourth Quarter-2010"
replace TaxQuarter=5 if TaxPeriod=="First Quarter-2011"
replace TaxQuarter=6 if TaxPeriod=="Second Quarter-2011"
replace TaxQuarter=7 if TaxPeriod=="Third Quarter-2011"
replace TaxQuarter=8 if TaxPeriod=="Fourth Quarter-2011"
replace TaxQuarter=9 if TaxPeriod=="First Quarter-2012"
replace TaxQuarter=10 if TaxPeriod=="Second Quarter-2012"
replace TaxQuarter=11 if TaxPeriod=="Third Quarter-2012"
replace TaxQuarter=12 if TaxPeriod=="Fourth Quarter-2012"
replace TaxQuarter=13 if TaxPeriod=="First Quarter-2013"
replace TaxQuarter=14 if TaxPeriod=="Second Quarter-2013"
replace TaxQuarter=15 if TaxPeriod=="Third Quarter-2013"
replace TaxQuarter=16 if TaxPeriod=="Fourth Quarter-2013"
replace TaxQuarter=17 if TaxPeriod=="First Quarter-2014"
replace TaxQuarter=18 if TaxPeriod=="Second Quarter-2014"
replace TaxQuarter=19 if TaxPeriod=="Third Quarter-2014"
replace TaxQuarter=20 if TaxPeriod=="Fourth Quarter-2014"


gen TaxYear=0
replace TaxYear=1 if TaxQuarter>0&TaxQuarter<=4
replace TaxYear=2 if TaxQuarter>4&TaxQuarter<=8
replace TaxYear=3 if TaxQuarter>8&TaxQuarter<=12
replace TaxYear=4 if TaxQuarter>12&TaxQuarter<=16
replace TaxYear=5 if TaxQuarter>16&TaxQuarter<=20

gen TaxMonth=0
replace TaxMonth=1 if TaxPeriod=="Apr-2010"
replace TaxMonth=2 if TaxPeriod=="May-2010"
replace TaxMonth=3 if TaxPeriod=="Jun-2010"
replace TaxMonth=4 if TaxPeriod=="Jul-2010"
replace TaxMonth=5 if TaxPeriod=="Aug-2010"
replace TaxMonth=6 if TaxPeriod=="Sep-2010"
replace TaxMonth=7 if TaxPeriod=="Oct-2010"
replace TaxMonth=8 if TaxPeriod=="Nov-2010"
replace TaxMonth=9 if TaxPeriod=="Dec-2010"
replace TaxMonth=10 if TaxPeriod=="Jan-2011"
replace TaxMonth=11 if TaxPeriod=="Feb-2011"
replace TaxMonth=12 if TaxPeriod=="Mar-2011"
replace TaxMonth=13 if TaxPeriod=="Apr-2011"
replace TaxMonth=14 if TaxPeriod=="May-2011"
replace TaxMonth=15 if TaxPeriod=="Jun-2011"
replace TaxMonth=16 if TaxPeriod=="Jul-2011"
replace TaxMonth=17 if TaxPeriod=="Aug-2011"
replace TaxMonth=18 if TaxPeriod=="Sep-2011"
replace TaxMonth=19 if TaxPeriod=="Oct-2011"
replace TaxMonth=20 if TaxPeriod=="Nov-2011"
replace TaxMonth=21 if TaxPeriod=="Dec-2011"
replace TaxMonth=22 if TaxPeriod=="Jan-2012"
replace TaxMonth=23 if TaxPeriod=="Feb-2012"
replace TaxMonth=24 if TaxPeriod=="Mar-2012"
replace TaxMonth=25 if TaxPeriod=="Apr-2012"
replace TaxMonth=26 if TaxPeriod=="May-2012"
replace TaxMonth=27 if TaxPeriod=="Jun-2012"
replace TaxMonth=28 if TaxPeriod=="Jul-2012"
replace TaxMonth=29 if TaxPeriod=="Aug-2012"
replace TaxMonth=30 if TaxPeriod=="Sep-2012"
replace TaxMonth=31 if TaxPeriod=="Oct-2012"
replace TaxMonth=32 if TaxPeriod=="Nov-2012"
replace TaxMonth=33 if TaxPeriod=="Dec-2012"
replace TaxMonth=34 if TaxPeriod=="Jan-2013"
replace TaxMonth=35 if TaxPeriod=="Feb-2013"
replace TaxMonth=36 if TaxPeriod=="Mar-2013"
replace TaxMonth=37 if TaxPeriod=="Apr-2013"
replace TaxMonth=38 if TaxPeriod=="May-2013"


replace TaxYear=1 if TaxMonth>0&TaxMonth<=12
replace TaxYear=2 if TaxMonth>12&TaxMonth<=24
replace TaxYear=3 if TaxMonth>24&TaxMonth<=36
replace TaxYear=4 if TaxMonth>36

replace TaxQuarter=1 if TaxMonth>0&TaxMonth<=3
replace TaxQuarter=2 if TaxMonth>3&TaxMonth<=6
replace TaxQuarter=3 if TaxMonth>6&TaxMonth<=9
replace TaxQuarter=4 if TaxMonth>9&TaxMonth<=12
replace TaxQuarter=5 if TaxMonth>12&TaxMonth<=15
replace TaxQuarter=6 if TaxMonth>15&TaxMonth<=18
replace TaxQuarter=7 if TaxMonth>18&TaxMonth<=21
replace TaxQuarter=8 if TaxMonth>21&TaxMonth<=24
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36
replace TaxQuarter=13 if TaxMonth>36&TaxMonth<=39

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"

label values TaxQuarter quarter
label values TaxYear year	

rename T312011 CommodityCode1
rename T312012 CommodityCode2
rename T312013 CommodityCode3

rename T312149 CommodityDescription1
rename T312150 CommodityDescription2
rename T312151 CommodityDescription3

label variable CommodityCode1 "Contains commodity code for returns in the first 3 years"
label variable CommodityCode2 "Contains commodity code for returns in the first 3 years"
label variable CommodityCode3 "Contains commodity code for returns in the first 3 years"

label variable CommodityDescription1 "Contains commodity description for returns in the first 3 years"
label variable CommodityDescription2 "Contains commodity description for returns in the first 3 years"
label variable CommodityDescription3 "Contains commodity description for returns in the first 3 years"


//For 2A 2B analysis we need variables which exist both pre and post 2012
//These variables do not exist in the pre. So we can use them for network analysis post but can not during pre period.
drop  DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood
drop T312002 RefundClaimedBoolean PeriodBegin PeriodEnd CommodityCode1 CommodityCode2 CommodityCode3 TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 InterestPayable PenaltyPayable TDSCertificates
drop HighSeaPurchase HighSeaSale PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule OtherDealersGoodsReJobF OtherDealersGoodsTrJobF OwnGoodsReceivedAfterJobF OwnGoodsTransferredAfterJobF InwardStockTransferConsignmentF OutwardStockTransferConsignmentF InwardStockTransferBranchF OutwardStockTransferBranchF CSTAdjustmentVAT CarryForwardTaxCredit SaleDelhiFormH LandCharges LaborCharges DieselSale ReturnType CommodityDescription3 CommodityDescription2 CommodityDescription1

preserve
collapse (sum) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase, by(DealerTIN TaxQuarter)
//Creating other variables of interest
gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)
gen TotalPurchases=PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer
gen PercValueAdded=(TurnoverGross-TotalPurchases)/(TotalPurchases)
gen TotalValueAdded=(TurnoverGross-TotalPurchases)
gen PercPurchaseUnregisteredDealer=PurchaseUnregisteredDealer/(TotalPurchases)

*label variable PurchaseNoCredit "R6.3 Total local purchases that are no eligible for credit of input tax"
label variable PercValueAdded "A measure of fraction of value added, definition is (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseUnregisteredDealer)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseUnregisteredDealer "A measure of amount purchased from unregistered dealers:PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisterdDealer)"
label variable TotalValueAdded "Total value added, (TurnoverGross-TotalPurchases)"
label variable TotalPurchases "Total purchases made: PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer"

//Keeping only those dealers which filed returns in all the quarters
gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N
keep if TotalCount==20

merge m:1 DealerTIN using "H:\MinDistanceFromStartEndNodes.dta"
drop if _merge==2

save "D:\data\HighTurnoverDealers2010_with_distances.dta"

use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2
/*
tab sdistance if TaxQuarter==1

   distance |
from any of |
  the start |
      nodes |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      4,137        6.04        6.04
          1 |     20,137       29.39       35.43
          2 |     29,138       42.53       77.97
          3 |      7,083       10.34       88.31
          4 |        965        1.41       89.71
          5 |        128        0.19       89.90
          6 |         18        0.03       89.93
          7 |          5        0.01       89.94
          8 |          2        0.00       89.94
   1.00e+30 |      6,893       10.06      100.00
------------+-----------------------------------
      Total |     68,506      100.00

. tab edistance if TaxQuarter==1

        min |
   distance |
from any of |
    the end |
      nodes |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     13,858       20.23       20.23
          1 |     31,503       45.99       66.21
          2 |     11,715       17.10       83.32
          3 |      1,977        2.89       86.20
          4 |        269        0.39       86.59
          5 |         41        0.06       86.65
          6 |          9        0.01       86.67
   1.00e+30 |      9,134       13.33      100.00
------------+-----------------------------------
      Total |     68,506      100.00

*/

gen Category=1 if sdistance>100
replace Category=2 if sdistance<2
replace Category=3 if sdistance>=2&sdistance<10
tab sdistance Category if TaxQuarter==12

preserve
gen Category=1 if sdistance>100
replace Category=2 if sdistance==0
replace Category=3 if sdistance>0&sdistance<10
tab sdistance Category if TaxQuarter==12


preserve
gen Category=1 if sdistance>100
replace Category=2 if sdistance==0
replace Category=3 if sdistance==1
tab sdistance Category if TaxQuarter==12


gen Category=1 if edistance>100
replace Category=2 if edistance==0
replace Category=3 if edistance>0&edistance<10
tab edistance Category if TaxQuarter==12


gen Category=1 if edistance>100
replace Category=2 if edistance==0
replace Category=3 if edistance==1
tab edistance Category if TaxQuarter==12



gen Category=1 if edistance>100
replace Category=2 if sdistance==0&edistance!=0
replace Category=3 if edistance==0&sdistance!=0
tab sdistance Category if TaxQuarter==12

/*

 tab sdistance edistance if TaxQuarter==1

  distance |
  from any |
    of the |
     start |                         min distance from any of the end nodes
     nodes |         0          1          2          3          4          5          6   1.00e+30 |     Total
-----------+----------------------------------------------------------------------------------------+----------
         0 |        11      2,165      1,386        230         30          3          1        311 |     4,137 
         1 |     4,276     11,730      3,142        479         56          3          2        449 |    20,137 
         2 |     7,346     14,187      5,395        893        125         19          4      1,169 |    29,138 
         3 |     1,844      2,842      1,482        300         39         12          1        563 |     7,083 
         4 |       263        371        195         42          8          3          0         83 |       965 
         5 |        34         52         27          7          1          1          0          6 |       128 
         6 |         3          9          2          1          1          0          1          1 |        18 
         7 |         0          1          2          2          0          0          0          0 |         5 
         8 |         0          1          1          0          0          0          0          0 |         2 
  1.00e+30 |        81        145         83         23          9          0          0      6,552 |     6,893 
-----------+----------------------------------------------------------------------------------------+----------
     Total |    13,858     31,503     11,715      1,977        269         41          9      9,134 |    68,506 

*/

	collapse (mean) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited TotalPurchases PercValueAdded TotalValueAdded PercPurchaseUnregisteredDealer (sd) sd_TurnoverGross= TurnoverGross sd_TurnoverCentral= TurnoverCentral sd_TurnoverLocal= TurnoverLocal sd_PurchaseOtherGoods=PurchaseOtherGoods sd_OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment sd_AdjustmentOutputTax=AdjustmentOutputTax sd_TotalOutputTax=TotalOutputTax sd_PurchaseCapitalGoods=PurchaseCapitalGoods sd_CreditCapitalGoods=CreditCapitalGoods sd_CreditOtherGoods=CreditOtherGoods sd_TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment sd_AdjustmentTaxCredit=AdjustmentTaxCredit sd_TotalTaxCredit=TotalTaxCredit sd_NetTax=NetTax sd_BalancePayable=BalancePayable sd_AmountDepositedByDealer=AmountDepositedByDealer sd_AggregateAmountPaid=AggregateAmountPaid sd_NetBalance=NetBalance sd_BalanceBroughtForward=BalanceBroughtForward sd_AdjustCSTLiability=AdjustCSTLiability sd_RefundClaimed=RefundClaimed sd_BalanceCarriedNextTaxPeriod=BalanceCarriedNextTaxPeriod sd_InterStateSaleCD=InterStateSaleCD sd_InterStatePurchaseCD=InterStatePurchaseCD sd_InterStateSaleCE1E2=InterStateSaleCE1E2 sd_InterStatePurchaseCE1E2=InterStatePurchaseCE1E2 sd_InterStateSaleOther=InterStateSaleOther sd_InterStatePurchaseOther=InterStatePurchaseOther sd_InterStateSaleCapital=InterStateSaleCapital sd_InterStatePurchaseCapital=InterStatePurchaseCapital sd_TotalInterStateSale=TotalInterStateSale sd_TotalInterStatePurchase=TotalInterStatePurchase sd_PurchaseUnregisteredDealer=PurchaseUnregisteredDealer sd_MoneyDeposited=MoneyDeposited sd_PercValueAdded=PercValueAdded sd_TotalValueAdded=TotalValueAdded sd_PercPurchaseUnregistered=PercPurchaseUnregisteredDealer sd_TotalPurchases=TotalPurchases, by (TaxQuarter Category)

	replace sd_TurnoverGross=sd_TurnoverGross/TurnoverGross 
	replace sd_TurnoverCentral=sd_TurnoverCentral/TurnoverCentral
	replace sd_TurnoverLocal=sd_TurnoverLocal/TurnoverLocal 
	replace sd_PurchaseOtherGoods=sd_PurchaseOtherGoods/PurchaseOtherGoods
	replace sd_OutputTaxBeforeAdjustment=sd_OutputTaxBeforeAdjustment/OutputTaxBeforeAdjustment 
	replace sd_AdjustmentOutputTax=sd_AdjustmentOutputTax/AdjustmentOutputTax 
	replace sd_TotalOutputTax=sd_TotalOutputTax/TotalOutputTax 
	replace sd_PurchaseCapitalGoods=sd_PurchaseCapitalGoods/PurchaseCapitalGoods 
	replace sd_CreditCapitalGoods=sd_CreditCapitalGoods/CreditCapitalGoods 
	replace sd_CreditOtherGoods=sd_CreditOtherGoods/CreditOtherGoods 
	replace sd_TaxCreditBeforeAdjustment=sd_TaxCreditBeforeAdjustment/TaxCreditBeforeAdjustment 
	replace sd_AdjustmentTaxCredit=sd_AdjustmentTaxCredit/AdjustmentTaxCredit 
	replace sd_TotalTaxCredit=sd_TotalTaxCredit/TotalTaxCredit 
	replace sd_NetTax=sd_NetTax/NetTax 
	replace sd_BalancePayable=sd_BalancePayable/BalancePayable 
	replace sd_AmountDepositedByDealer=sd_AmountDepositedByDealer/AmountDepositedByDealer 
	replace sd_AggregateAmountPaid=sd_AggregateAmountPaid/AggregateAmountPaid 
	replace sd_NetBalance=sd_NetBalance/NetBalance 
	replace sd_BalanceBroughtForward=sd_BalanceBroughtForward/BalanceBroughtForward 
	replace sd_AdjustCSTLiability=sd_AdjustCSTLiability/AdjustCSTLiability 
	replace sd_RefundClaimed=sd_RefundClaimed/RefundClaimed 
	replace sd_BalanceCarriedNextTaxPeriod=sd_BalanceCarriedNextTaxPeriod/BalanceCarriedNextTaxPeriod 
	replace sd_InterStateSaleCD=sd_InterStateSaleCD/InterStateSaleCD 
	replace sd_InterStatePurchaseCD=sd_InterStatePurchaseCD/InterStatePurchaseCD 
	replace sd_InterStateSaleCE1E2=sd_InterStateSaleCE1E2/InterStateSaleCE1E2 
	replace sd_InterStatePurchaseCE1E2=sd_InterStatePurchaseCE1E2/InterStatePurchaseCE1E2 
	replace sd_InterStateSaleOther=sd_InterStateSaleOther/InterStateSaleOther 
	replace sd_InterStatePurchaseOther=sd_InterStatePurchaseOther/InterStatePurchaseOther 
	replace sd_InterStateSaleCapital=sd_InterStateSaleCapital/InterStateSaleCapital 
	replace sd_InterStatePurchaseCapital=sd_InterStatePurchaseCapital/InterStatePurchaseCapital 
	replace sd_TotalInterStateSale=sd_TotalInterStateSale/TotalInterStateSale 
	replace sd_TotalInterStatePurchase=sd_TotalInterStatePurchase/TotalInterStatePurchase 
	replace sd_PurchaseUnregisteredDealer=sd_PurchaseUnregisteredDealer/PurchaseUnregisteredDealer 
	replace sd_MoneyDeposited=sd_MoneyDeposited/MoneyDeposited 
	replace sd_PercValueAdded=sd_PercValueAdded/PercValueAdded 
	replace sd_TotalValueAdded=sd_TotalValueAdded/TotalValueAdded 
	replace sd_PercPurchaseUnregistered=sd_PercPurchaseUnregistered/PercPurchaseUnregisteredDealer 
	replace sd_TotalPurchases=sd_TotalPurchases/TotalPurchases

//Comparing starting nodes with non-starting nodes
//Total Tax Credit - Something interesting going on, seems like a downward trend
//Sd of total tax credit goes down for edistance non starting nodes
twoway (connected TotalTaxCredit TaxQuarter if Category==2) (connected TotalTaxCredit TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line TotalTaxCredit TaxQuarter if Category==2) (line TotalTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalTaxCredit TaxQuarter if Category==2) (line sd_TotalTaxCredit TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalTaxCredit TaxQuarter if Category==2) (line sd_TotalTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Sd of total tax credit goes down for edistance non starting nodes
twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Category==2) (connected TaxCreditBeforeAdjustment TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Category==2) (connected TaxCreditBeforeAdjustment TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category==2) (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category==2) (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected AdjustmentTaxCredit TaxQuarter if Category==2) (connected AdjustmentTaxCredit TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected AdjustmentTaxCredit TaxQuarter if Category==2) (connected AdjustmentTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_AdjustmentTaxCredit TaxQuarter if Category==2) (connected sd_AdjustmentTaxCredit TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_AdjustmentTaxCredit TaxQuarter if Category==2) (connected sd_AdjustmentTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


//Total Value Added - change in slope for starting guys
twoway (line TotalValueAdded TaxQuarter if Category==2) (line TotalValueAdded TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line TotalValueAdded TaxQuarter if Category==2) (line TotalValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalValueAdded TaxQuarter if Category==2) (line sd_TotalValueAdded TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalValueAdded TaxQuarter if Category==2) (line sd_TotalValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//TurnoverGross - change in slope for starting guys
twoway (line TurnoverGross TaxQuarter if Category==2) (line TurnoverGross TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line TurnoverGross TaxQuarter if Category==2) (line TurnoverGross TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TurnoverGross TaxQuarter if Category==2) (line sd_TurnoverGross TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TurnoverGross TaxQuarter if Category==2) (line sd_TurnoverGross TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (line TurnoverLocal TaxQuarter if Category==2) (line TurnoverLocal TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line TurnoverLocal TaxQuarter if Category==2) (line TurnoverLocal TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TurnoverLocal TaxQuarter if Category==2) (line sd_TurnoverLocal TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TurnoverLocal TaxQuarter if Category==2) (line sd_TurnoverLocal TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (line TotalPurchases TaxQuarter if Category==2) (line TotalPurchases TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line TotalPurchases TaxQuarter if Category==2) (line TotalPurchases TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalPurchases TaxQuarter if Category==2) (line sd_TotalPurchases TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalPurchases TaxQuarter if Category==2) (line sd_TotalPurchases TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Documenting a fact
twoway (connected PercValueAdded TaxQuarter if Category==2) (connected PercValueAdded TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected PercValueAdded TaxQuarter if Category==2) (connected PercValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_PercValueAdded TaxQuarter if Category==2) (line sd_PercValueAdded TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_PercValueAdded TaxQuarter if Category==2) (line sd_PercValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected PurchaseUnregisteredDealer TaxQuarter if Category==2) (connected PurchaseUnregisteredDealer TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected PurchaseUnregisteredDealer TaxQuarter if Category==2) (connected PurchaseUnregisteredDealer TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_PurchaseUnregisteredDealer TaxQuarter if Category==2) (connected sd_PurchaseUnregisteredDealer TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_PurchaseUnregisteredDealer TaxQuarter if Category==2) (connected sd_PurchaseUnregisteredDealer TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected PercPurchaseUnregisteredDealer TaxQuarter if Category==2) (connected PercPurchaseUnregisteredDealer TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected PercPurchaseUnregisteredDealer TaxQuarter if Category==2) (connected PercPurchaseUnregisteredDealer TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_PercPurchaseUnregistered TaxQuarter if Category==2) (connected sd_PercPurchaseUnregistered TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_PercPurchaseUnregistered TaxQuarter if Category==2) (connected sd_PercPurchaseUnregistered TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope - for edistance - documenting a fact?
twoway (connected MoneyDeposited TaxQuarter if Category==2) (connected MoneyDeposited TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected MoneyDeposited TaxQuarter if Category==2) (connected MoneyDeposited TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_MoneyDeposited TaxQuarter if Category==2) (connected sd_MoneyDeposited TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_MoneyDeposited TaxQuarter if Category==2) (connected sd_MoneyDeposited TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope - for edistance
twoway (line TotalOutputTax TaxQuarter if Category==2) (line TotalOutputTax TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line TotalOutputTax TaxQuarter if Category==2) (line TotalOutputTax TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalOutputTax TaxQuarter if Category==2) (line sd_TotalOutputTax TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_TotalOutputTax TaxQuarter if Category==2) (line sd_TotalOutputTax TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (line PurchaseCapitalGoods TaxQuarter if Category==2) (line PurchaseCapitalGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line PurchaseCapitalGoods TaxQuarter if Category==2) (line PurchaseCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_PurchaseCapitalGoods TaxQuarter if Category==2) (line sd_PurchaseCapitalGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_PurchaseCapitalGoods TaxQuarter if Category==2) (line sd_PurchaseCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (line PurchaseOtherGoods TaxQuarter if Category==2) (line PurchaseOtherGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line PurchaseOtherGoods TaxQuarter if Category==2) (line PurchaseOtherGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_PurchaseOtherGoods TaxQuarter if Category==2) (line sd_PurchaseOtherGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (line sd_PurchaseOtherGoods TaxQuarter if Category==2) (line sd_PurchaseOtherGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))



twoway (connected CreditCapitalGoods TaxQuarter if Category==2) (connected CreditCapitalGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected CreditCapitalGoods TaxQuarter if Category==2) (connected CreditCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_CreditCapitalGoods TaxQuarter if Category==2) (connected sd_CreditCapitalGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_CreditCapitalGoods TaxQuarter if Category==2) (connected sd_CreditCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//There is a change -- **
twoway (connected CreditOtherGoods TaxQuarter if Category==2) (connected CreditOtherGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected CreditOtherGoods TaxQuarter if Category==2) (connected CreditOtherGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_CreditOtherGoods TaxQuarter if Category==2) (connected sd_CreditOtherGoods TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_CreditOtherGoods TaxQuarter if Category==2) (connected sd_CreditOtherGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//There is a chnage
twoway (connected NetTax TaxQuarter if Category==2) (connected NetTax TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected NetTax TaxQuarter if Category==2) (connected NetTax TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_NetTax TaxQuarter if Category==2) (connected sd_NetTax TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_NetTax TaxQuarter if Category==2) (connected sd_NetTax TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected BalancePayable TaxQuarter if Category==2) (connected BalancePayable TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected BalancePayable TaxQuarter if Category==2) (connected BalancePayable TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_BalancePayable TaxQuarter if Category==2) (connected sd_BalancePayable TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_BalancePayable TaxQuarter if Category==2) (connected sd_BalancePayable TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

          
//Net Balance should be negative
twoway (connected NetBalance TaxQuarter if Category==2) (connected NetBalance TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected NetBalance TaxQuarter if Category==2) (connected NetBalance TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_NetBalance TaxQuarter if Category==2) (connected sd_NetBalance TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_NetBalance TaxQuarter if Category==2) (connected sd_NetBalance TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected BalanceBroughtForward TaxQuarter if Category==2) (connected BalanceBroughtForward TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected BalanceBroughtForward TaxQuarter if Category==2) (connected BalanceBroughtForward TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_BalanceBroughtForward TaxQuarter if Category==2) (connected sd_BalanceBroughtForward TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_BalanceBroughtForward TaxQuarter if Category==2) (connected sd_BalanceBroughtForward TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected AdjustCSTLiability TaxQuarter if Category==2) (connected AdjustCSTLiability TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected AdjustCSTLiability TaxQuarter if Category==2) (connected AdjustCSTLiability TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_AdjustCSTLiability TaxQuarter if Category==2) (connected sd_AdjustCSTLiability TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_AdjustCSTLiability TaxQuarter if Category==2) (connected sd_AdjustCSTLiability TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected RefundClaimed TaxQuarter if Category==2) (connected RefundClaimed TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected RefundClaimed TaxQuarter if Category==2) (connected RefundClaimed TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_RefundClaimed TaxQuarter if Category==2) (connected sd_RefundClaimed TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_RefundClaimed TaxQuarter if Category==2) (connected sd_RefundClaimed TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected BalanceCarriedNextTaxPeriod TaxQuarter if Category==2) (connected BalanceCarriedNextTaxPeriod TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected BalanceCarriedNextTaxPeriod TaxQuarter if Category==2) (connected BalanceCarriedNextTaxPeriod TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_BalanceCarriedNextTaxPeriod TaxQuarter if Category==2) (connected sd_BalanceCarriedNextTaxPeriod TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_BalanceCarriedNextTaxPeriod TaxQuarter if Category==2) (connected sd_BalanceCarriedNextTaxPeriod TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected InterStateSaleCD TaxQuarter if Category==2) (connected InterStateSaleCD TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateSaleCD TaxQuarter if Category==2) (connected InterStateSaleCD TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleCD TaxQuarter if Category==2) (connected sd_InterStateSaleCD TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleCD TaxQuarter if Category==2) (connected sd_InterStateSaleCD TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope - for both the cases
twoway (connected InterStatePurchaseCD TaxQuarter if Category==2) (connected InterStatePurchaseCD TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStatePurchaseCD TaxQuarter if Category==2) (connected InterStatePurchaseCD TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseCD TaxQuarter if Category==2) (connected sd_InterStatePurchaseCD TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseCD TaxQuarter if Category==2) (connected sd_InterStatePurchaseCD TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope - for sdistance
twoway (connected InterStateSaleCE1E2 TaxQuarter if Category==2) (connected InterStateSaleCE1E2 TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateSaleCE1E2 TaxQuarter if Category==2) (connected InterStateSaleCE1E2 TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleCE1E2 TaxQuarter if Category==2) (connected sd_InterStateSaleCE1E2 TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleCE1E2 TaxQuarter if Category==2) (connected sd_InterStateSaleCE1E2 TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Need to investigate
twoway (connected InterStatePurchaseCE1E2 TaxQuarter if Category==2) (connected InterStatePurchaseCE1E2 TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStatePurchaseCE1E2 TaxQuarter if Category==2) (connected InterStatePurchaseCE1E2 TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseCE1E2 TaxQuarter if Category==2) (connected sd_InterStatePurchaseCE1E2 TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseCE1E2 TaxQuarter if Category==2) (connected sd_InterStatePurchaseCE1E2 TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope
twoway (connected InterStateExportsAgainstH TaxQuarter if Category==2) (connected InterStateExportsAgainstH TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateExportsAgainstH TaxQuarter if Category==2) (connected InterStateExportsAgainstH TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateExportsAgainstH TaxQuarter if Category==2) (connected sd_InterStateExportsAgainstH TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateExportsAgainstH TaxQuarter if Category==2) (connected sd_InterStateExportsAgainstH TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected InterStateImportsAgainstH TaxQuarter if Category==2) (connected InterStateImportsAgainstH TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateImportsAgainstH TaxQuarter if Category==2) (connected InterStateImportsAgainstH TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateImportsAgainstH TaxQuarter if Category==2) (connected sd_InterStateImportsAgainstH TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateImportsAgainstH TaxQuarter if Category==2) (connected sd_InterStateImportsAgainstH TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope
twoway (connected InterStateExportsAgainstI TaxQuarter if Category==2) (connected InterStateExportsAgainstI TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateExportsAgainstI TaxQuarter if Category==2) (connected InterStateExportsAgainstI TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateExportsAgainstI TaxQuarter if Category==2) (connected sd_InterStateExportsAgainstI TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateExportsAgainstI TaxQuarter if Category==2) (connected sd_InterStateExportsAgainstI TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected  InterStateImportsAgainstI TaxQuarter if Category==2) (connected  InterStateImportsAgainstI TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected  InterStateImportsAgainstI TaxQuarter if Category==2) (connected  InterStateImportsAgainstI TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateImportsAgainstI TaxQuarter if Category==2) (connected sd_InterStateImportsAgainstI TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateImportsAgainstI TaxQuarter if Category==2) (connected sd_InterStateImportsAgainstI TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected  InterStateExportsAgainstJ TaxQuarter if Category==2) (connected  InterStateExportsAgainstJ TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected  InterStateExportsAgainstJ TaxQuarter if Category==2) (connected  InterStateExportsAgainstJ TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateExportsAgainstJ TaxQuarter if Category==2) (connected sd_ InterStateExportsAgainstJ TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateExportsAgainstJ TaxQuarter if Category==2) (connected sd_ InterStateExportsAgainstJ TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))


twoway (connected InterStateImportsAgainstJ TaxQuarter if Category==2) (connected InterStateImportsAgainstJ TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateImportsAgainstJ TaxQuarter if Category==2) (connected InterStateImportsAgainstJ TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateImportsAgainstJ TaxQuarter if Category==2) (connected sd_InterStateImportsAgainstJ TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateImportsAgainstJ TaxQuarter if Category==2) (connected sd_InterStateImportsAgainstJ TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

    

//No change
twoway (connected ExportFromIndia TaxQuarter if Category==2) (connected ExportFromIndia TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected ExportFromIndia TaxQuarter if Category==2) (connected ExportFromIndia TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_ExportFromIndia TaxQuarter if Category==2) (connected sd_ExportFromIndia TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_ExportFromIndia TaxQuarter if Category==2) (connected sd_ExportFromIndia TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//No change
twoway (connected ImportToIndia TaxQuarter if Category==2) (connected ImportToIndia TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected ImportToIndia TaxQuarter if Category==2) (connected ImportToIndia TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_ImportToIndia TaxQuarter if Category==2) (connected sd_ImportToIndia TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_ImportToIndia TaxQuarter if Category==2) (connected sd_ImportToIndia TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected InterStateSaleOther TaxQuarter if Category==2) (connected InterStateSaleOther TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateSaleOther TaxQuarter if Category==2) (connected InterStateSaleOther TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleOther TaxQuarter if Category==2) (connected sd_InterStateSaleOther TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleOther TaxQuarter if Category==2) (connected sd_InterStateSaleOther TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope - fpr both
twoway (connected InterStatePurchaseOther TaxQuarter if Category==2) (connected InterStatePurchaseOther TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStatePurchaseOther TaxQuarter if Category==2) (connected InterStatePurchaseOther TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseOther TaxQuarter if Category==2) (connected sd_InterStatePurchaseOther TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseOther TaxQuarter if Category==2) (connected sd_InterStatePurchaseOther TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope
twoway (connected InterStateSaleCapital TaxQuarter if Category==2) (connected InterStateSaleCapital TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStateSaleCapital TaxQuarter if Category==2) (connected InterStateSaleCapital TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleCapital TaxQuarter if Category==2) (connected sd_InterStateSaleCapital TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStateSaleCapital TaxQuarter if Category==2) (connected sd_InterStateSaleCapital TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//No change
twoway (connected InterStatePurchaseCapital TaxQuarter if Category==2) (connected InterStatePurchaseCapital TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected InterStatePurchaseCapital TaxQuarter if Category==2) (connected InterStatePurchaseCapital TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseCapital TaxQuarter if Category==2) (connected sd_InterStatePurchaseCapital TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_InterStatePurchaseCapital TaxQuarter if Category==2) (connected sd_InterStatePurchaseCapital TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope
twoway (connected TotalInterStateSale TaxQuarter if Category==2) (connected TotalInterStateSale TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected TotalInterStateSale TaxQuarter if Category==2) (connected TotalInterStateSale TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_TotalInterStateSale TaxQuarter if Category==2) (connected sd_TotalInterStateSale TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_TotalInterStateSale TaxQuarter if Category==2) (connected sd_TotalInterStateSale TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))

//Change in slope
twoway (connected TotalInterStatePurchase TaxQuarter if Category==2) (connected TotalInterStatePurchase TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected TotalInterStatePurchase TaxQuarter if Category==2) (connected TotalInterStatePurchase TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_TotalInterStatePurchase TaxQuarter if Category==2) (connected sd_TotalInterStatePurchase TaxQuarter if Category==3, yaxis(2)), xline(9) legend(order(1 "Starting" 2 "Not starting"))
twoway (connected sd_TotalInterStatePurchase TaxQuarter if Category==2) (connected sd_TotalInterStatePurchase TaxQuarter if Category==3), xline(9) legend(order(1 "Starting" 2 "Not starting"))





























twoway (line TurnoverGross TaxQuarter if Category==2) (line TurnoverGross TaxQuarter if Category==3),xline(9) legend(order(1 "Starting" 2 "Not starting"))

twoway (connected TurnoverGross TaxQuarter if Category==1) (line TurnoverGross TaxQuarter if Category==2) (line TurnoverGross TaxQuarter if Category==3),xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TurnoverGross TaxQuarter if Category==1) (connected sd_TurnoverGross TaxQuarter if Category==2) (connected sd_TurnoverGross TaxQuarter if Category==3),xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected ExportFromIndia TaxQuarter if Category==1)(connected ExportFromIndia TaxQuarter if Category==2) (connected ExportFromIndia TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected ImportToIndia TaxQuarter if Category==1)(connected ImportToIndia TaxQuarter if Category==2) (connected ImportToIndia TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))


twoway (connected TotalValueAdded TaxQuarter if Category==1) (line TotalValueAdded TaxQuarter if Category==2) (line TotalValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalValueAdded TaxQuarter if Category==1) (line sd_TotalValueAdded TaxQuarter if Category==2) (line sd_TotalValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TurnoverLocal TaxQuarter if Category==1) (line TurnoverLocal TaxQuarter if Category==2) (line TurnoverLocal TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TurnoverLocal TaxQuarter if Category==1) (line sd_TurnoverLocal TaxQuarter if Category==2) (line sd_TurnoverLocal TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TotalPurchases TaxQuarter if Category==1) (line TotalPurchases TaxQuarter if Category==2) (line TotalPurchases TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalPurchases TaxQuarter if Category==1) (line sd_TotalPurchases TaxQuarter if Category==2) (line sd_TotalPurchases TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected PercValueAdded TaxQuarter if Category==1) (line PercValueAdded TaxQuarter if Category==2) (line PercValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_PercValueAdded TaxQuarter if Category==1) (line sd_PercValueAdded TaxQuarter if Category==2) (line sd_PercValueAdded TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected PurchaseUnregisteredDealer TaxQuarter if Category==1) (line PurchaseUnregisteredDealer TaxQuarter if Category==2) (line PurchaseUnregisteredDealer TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_PurchaseUnregisteredDealer TaxQuarter if Category==1) (line sd_PurchaseUnregisteredDealer TaxQuarter if Category==2) (line sd_PurchaseUnregisteredDealer TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected PercPurchaseUnregisteredDealer TaxQuarter if Category==1) (line PercPurchaseUnregisteredDealer TaxQuarter if Category==2) (line PercPurchaseUnregisteredDealer TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_PercPurchaseUnregistered TaxQuarter if Category==1) (line sd_PercPurchaseUnregistered TaxQuarter if Category==2) (line sd_PercPurchaseUnregistered TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TotalPurchases TaxQuarter if Category==1) (line TotalPurchases TaxQuarter if Category==2) (line TotalPurchases TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalPurchases TaxQuarter if Category==1) (line sd_TotalPurchases TaxQuarter if Category==2) (line sd_TotalPurchases TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected PercPurchaseNoCredit TaxQuarter if Category==1) (line PercPurchaseNoCredit TaxQuarter if Category==2) (line PercPurchaseNoCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_PercPurchaseNoCredit TaxQuarter if Category==1) (line sd_PercPurchaseNoCredit TaxQuarter if Category==2) (line sd_PercPurchaseNoCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected MoneyDeposited TaxQuarter if Category==1) (line MoneyDeposited TaxQuarter if Category==2) (line MoneyDeposited TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_MoneyDeposited TaxQuarter if Category==1) (line sd_MoneyDeposited TaxQuarter if Category==2) (line sd_MoneyDeposited TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected AggregateAmountPaid TaxQuarter if Category==1) (line AggregateAmountPaid TaxQuarter if Category==2) (line AggregateAmountPaid TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_AggregateAmountPaid TaxQuarter if Category==1) (line sd_AggregateAmountPaid TaxQuarter if Category==2) (line sd_AggregateAmountPaid TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TotalTaxCredit TaxQuarter if Category==1) (line TotalTaxCredit TaxQuarter if Category==2) (line TotalTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalTaxCredit TaxQuarter if Category==1) (line sd_TotalTaxCredit TaxQuarter if Category==2) (line sd_TotalTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Category==1) (line TaxCreditBeforeAdjustment TaxQuarter if Category==2) (line TaxCreditBeforeAdjustment TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category==1) (line sd_TaxCreditBeforeAdjustment TaxQuarter if Category==2) (line sd_TaxCreditBeforeAdjustment TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected CreditOtherGoods TaxQuarter if Category==1) (line CreditOtherGoods TaxQuarter if Category==2) (line CreditOtherGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_CreditOtherGoods TaxQuarter if Category==1) (line sd_CreditOtherGoods TaxQuarter if Category==2) (line sd_CreditOtherGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected AdjustmentTaxCredit TaxQuarter if Category==1) (line AdjustmentTaxCredit TaxQuarter if Category==2) (line AdjustmentTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_AdjustmentTaxCredit TaxQuarter if Category==1) (line sd_AdjustmentTaxCredit TaxQuarter if Category==2) (line sd_AdjustmentTaxCredit TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TotalOutputTax TaxQuarter if Category==1) (line TotalOutputTax TaxQuarter if Category==2) (line TotalOutputTax TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalOutputTax TaxQuarter if Category==1) (line sd_TotalOutputTax TaxQuarter if Category==2) (line sd_TotalOutputTax TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected PurchaseCapitalGoods TaxQuarter if Category==1) (line PurchaseCapitalGoods TaxQuarter if Category==2) (line PurchaseCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_PurchaseCapitalGoods TaxQuarter if Category==1) (line sd_PurchaseCapitalGoods TaxQuarter if Category==2) (line sd_PurchaseCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected CreditCapitalGoods TaxQuarter if Category==1) (line CreditCapitalGoods TaxQuarter if Category==2) (line CreditCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_CreditCapitalGoods TaxQuarter if Category==1) (line sd_CreditCapitalGoods TaxQuarter if Category==2) (line sd_CreditCapitalGoods TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TotalInterStateSale TaxQuarter if Category==1) (line TotalInterStateSale TaxQuarter if Category==2) (line TotalInterStateSale TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalInterStateSale TaxQuarter if Category==1) (line sd_TotalInterStateSale TaxQuarter if Category==2) (line sd_TotalInterStateSale TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))

twoway (connected TotalInterStatePurchase TaxQuarter if Category==1) (line TotalInterStatePurchase TaxQuarter if Category==2) (line TotalInterStatePurchase TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))
twoway (connected sd_TotalInterStatePurchase TaxQuarter if Category==1) (line sd_TotalInterStatePurchase TaxQuarter if Category==2) (line sd_TotalInterStatePurchase TaxQuarter if Category==3), xline(9) legend(order(1 "Not connected" 2 "Starting" 3 "Not starting"))






drop T312002 RefundClaimedBoolean PeriodBegin PeriodEnd CommodityCode1 CommodityCode2 CommodityCode3 TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 InterestPayable PenaltyPayable TDSCertificates InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia TDSDetails Status ApprovalDate AcknowledgementNumber Year CommodityDescription1 CommodityDescription2 CommodityDescription3 ReturnType DieselSale DieselPurchase LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase InwardStockTransferConsignmentF OutwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule OtherDealersGoodsReJobF OtherDealersGoodsTrJobF PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase



//Start the analysis from here


gen Category=1 if sdistance>100
replace Category=2 if sdistance==0
replace Category=3 if sdistance!=0&sdistance<10
tab sdistance Category if TaxQuarter==12


