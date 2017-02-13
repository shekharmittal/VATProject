{
use "E:\data\PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear
keep if TaxPeriod=="First Quarter-2010"
keep DealerTIN
save "E:\data\MediumTurnoverDealers2010_q1.dta", replace

use "E:\data\PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear
merge m:1 DealerTIN using "E:\data\MediumTurnoverDealers2010_q1.dta"
keep if _merge==3

drop ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory

drop if TaxPeriod=="Annual-2012"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Apr-2013"|TaxPeriod=="May-2013"

gen TaxYear=0
replace TaxYear=1 if TaxPeriod=="Annual-2010"
replace TaxYear=2 if TaxPeriod=="Annual-2011"
replace TaxYear=3 if TaxPeriod=="Annual-2012"

gen TaxHalfyear=0
replace TaxHalfyear=1 if TaxPeriod=="First Halfyear-2010"
replace TaxHalfyear=2 if TaxPeriod=="Second Halfyear-2010"
replace TaxHalfyear=3 if TaxPeriod=="First Halfyear-2011"
replace TaxHalfyear=4 if TaxPeriod=="Second Halfyear-2011"
replace TaxHalfyear=5 if TaxPeriod=="First Halfyear-2012"
replace TaxHalfyear=6 if TaxPeriod=="Second Halfyear-2012"

replace TaxYear=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="Second Halfyear-2010"
replace TaxYear=2 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
replace TaxYear=3 if TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"


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

gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth

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

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0


gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth
gen AnnualDummy=1 if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"
gen SemiAnnualDummy=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="Second Halfyear-2011"
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2010"|TaxPeriod=="Apr-2011"|TaxPeriod=="Apr-2012"|TaxPeriod=="Aug-2010"|TaxPeriod=="Aug-2011"|TaxPeriod=="Aug-2012"|TaxPeriod=="Dec-2010"|TaxPeriod=="Dec-2011"|TaxPeriod=="Dec-2012"|TaxPeriod=="Feb-2011"|TaxPeriod=="Feb-2012"|TaxPeriod=="Feb-2013"|TaxPeriod=="Jan-2011"|TaxPeriod=="Jan-2012"|TaxPeriod=="Jan-2013"|TaxPeriod=="Jul-2010"|TaxPeriod=="Jul-2011"|TaxPeriod=="Jul-2012"|TaxPeriod=="Jun-2010"|TaxPeriod=="Jun-2011"|TaxPeriod=="Jun-2012"|TaxPeriod=="Mar-2011"|TaxPeriod=="Mar-2012"|TaxPeriod=="Mar-2013"|TaxPeriod=="May-2010"|TaxPeriod=="May-2011"|TaxPeriod=="May-2012"|TaxPeriod=="Nov-2010"|TaxPeriod=="Nov-2011"|TaxPeriod=="Nov-2012"|TaxPeriod=="Oct-2010"|TaxPeriod=="Oct-2011"|TaxPeriod=="Oct-2012"|TaxPeriod=="Sep-2010"|TaxPeriod=="Sep-2011"|TaxPeriod=="Sep-2012"


by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.


drop if AnnualDummy==1&SemiAnnualDummy==1&TaxYear==1
drop if AnnualDummy==1&QuarterlyDummy==1&TaxYear==1
drop if AnnualDummy==1&MonthlyDummy==1&TaxYear==1
drop if SemiAnnualDummy==1&QuarterlyDummy==1&TaxYear==1
drop if SemiAnnualDummy==1&MonthlyDummy==1&TaxYear==1
drop if QuarterlyDummy==1&MonthlyDummy==1&TaxYear==1
drop AnnualDummy SemiAnnualDummy MonthlyDummy QuarterlyDummy


gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth
gen AnnualDummy=1 if TaxPeriod=="Annual-2011"
gen SemiAnnualDummy=1 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Fourth Quarter-2011"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2011"|TaxPeriod=="Aug-2011"|TaxPeriod=="Dec-2011"|TaxPeriod=="Feb-2012"|TaxPeriod=="Jan-2012"|TaxPeriod=="Jul-2011"|TaxPeriod=="Jun-2011"|TaxPeriod=="Mar-2012"|TaxPeriod=="May-2011"|TaxPeriod=="Nov-2011"|TaxPeriod=="Oct-2011"|TaxPeriod=="Sep-2011"

by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.

drop if AnnualDummy==1&SemiAnnualDummy==1&TaxYear==2
drop if AnnualDummy==1&QuarterlyDummy==1&TaxYear==2
drop if AnnualDummy==1&MonthlyDummy==1&TaxYear==2
drop if SemiAnnualDummy==1&QuarterlyDummy==1&TaxYear==2
drop if SemiAnnualDummy==1&MonthlyDummy==1&TaxYear==2
drop if QuarterlyDummy==1&MonthlyDummy==1&TaxYear==2
drop AnnualDummy SemiAnnualDummy MonthlyDummy QuarterlyDummy


gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2012"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Fourth Quarter-2012"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2012"|TaxPeriod=="Aug-2012"|TaxPeriod=="Dec-2012"|TaxPeriod=="Feb-2013"|TaxPeriod=="Jan-2013"|TaxPeriod=="Jul-2012"|TaxPeriod=="Jun-2012"|TaxPeriod=="Mar-2013"|TaxPeriod=="May-2012"|TaxPeriod=="Nov-2012"|TaxPeriod=="Oct-2012"|TaxPeriod=="Sep-2012"


by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.
drop if QuarterlyDummy==1&MonthlyDummy==1&TaxYear==3


//drop if TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="May-2013"|TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"|TaxPeriod=="Apr-2013"|TaxPeriod=="Apr-2010"|TaxPeriod=="May-2010"|TaxPeriod=="Jun-2010"

drop if TurnoverGross<0

drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"

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
drop SourceFile AcknowledgementNumber ApprovalDate Status TDSDetails WardName

collapse (mean)TaxYear (sum) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase, by(DealerTIN TaxQuarter)
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

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

//merge m:1 DealerTIN using "F:\MinDistanceFromStartEndNodes.dta"
//drop if _merge==2

save "E:\data\MediumTurnoverDealers2010.dta", replace
}


{
//Now we will repeat the process for Monthly turnover dealers
use "E:\data\PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear
keep if TaxPeriod=="Apr-2010"|TaxPeriod=="May-2010"|TaxPeriod=="Jun-2010"
bys DealerTIN: gen TotalCount=_N
keep if TotalCount==3
keep if TaxPeriod=="Apr-2010"
keep DealerTIN
save "E:\data\HighTurnoverDealers2010_q1.dta", replace


use "E:\data\PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear
merge m:1 DealerTIN using "E:\data\HighTurnoverDealers2010_q1.dta"
keep if _merge==3


drop ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory

drop if TaxPeriod=="Annual-2012"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Apr-2013"|TaxPeriod=="May-2013"

gen TaxYear=0
replace TaxYear=1 if TaxPeriod=="Annual-2010"
replace TaxYear=2 if TaxPeriod=="Annual-2011"
replace TaxYear=3 if TaxPeriod=="Annual-2012"

gen TaxHalfyear=0
replace TaxHalfyear=1 if TaxPeriod=="First Halfyear-2010"
replace TaxHalfyear=2 if TaxPeriod=="Second Halfyear-2010"
replace TaxHalfyear=3 if TaxPeriod=="First Halfyear-2011"
replace TaxHalfyear=4 if TaxPeriod=="Second Halfyear-2011"
replace TaxHalfyear=5 if TaxPeriod=="First Halfyear-2012"
replace TaxHalfyear=6 if TaxPeriod=="Second Halfyear-2012"

replace TaxYear=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="Second Halfyear-2010"
replace TaxYear=2 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
replace TaxYear=3 if TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"


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

gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth

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

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0


gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth
gen AnnualDummy=1 if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"
gen SemiAnnualDummy=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="Second Halfyear-2011"
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2010"|TaxPeriod=="Apr-2011"|TaxPeriod=="Apr-2012"|TaxPeriod=="Aug-2010"|TaxPeriod=="Aug-2011"|TaxPeriod=="Aug-2012"|TaxPeriod=="Dec-2010"|TaxPeriod=="Dec-2011"|TaxPeriod=="Dec-2012"|TaxPeriod=="Feb-2011"|TaxPeriod=="Feb-2012"|TaxPeriod=="Feb-2013"|TaxPeriod=="Jan-2011"|TaxPeriod=="Jan-2012"|TaxPeriod=="Jan-2013"|TaxPeriod=="Jul-2010"|TaxPeriod=="Jul-2011"|TaxPeriod=="Jul-2012"|TaxPeriod=="Jun-2010"|TaxPeriod=="Jun-2011"|TaxPeriod=="Jun-2012"|TaxPeriod=="Mar-2011"|TaxPeriod=="Mar-2012"|TaxPeriod=="Mar-2013"|TaxPeriod=="May-2010"|TaxPeriod=="May-2011"|TaxPeriod=="May-2012"|TaxPeriod=="Nov-2010"|TaxPeriod=="Nov-2011"|TaxPeriod=="Nov-2012"|TaxPeriod=="Oct-2010"|TaxPeriod=="Oct-2011"|TaxPeriod=="Oct-2012"|TaxPeriod=="Sep-2010"|TaxPeriod=="Sep-2011"|TaxPeriod=="Sep-2012"


by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.


drop if AnnualDummy==1&SemiAnnualDummy==1&TaxYear==1
drop if AnnualDummy==1&QuarterlyDummy==1&TaxYear==1
drop if AnnualDummy==1&MonthlyDummy==1&TaxYear==1
drop if SemiAnnualDummy==1&QuarterlyDummy==1&TaxYear==1
drop if SemiAnnualDummy==1&MonthlyDummy==1&TaxYear==1
drop if QuarterlyDummy==1&MonthlyDummy==1&TaxYear==1
drop AnnualDummy SemiAnnualDummy MonthlyDummy QuarterlyDummy


gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth
gen AnnualDummy=1 if TaxPeriod=="Annual-2011"
gen SemiAnnualDummy=1 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Fourth Quarter-2011"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2011"|TaxPeriod=="Aug-2011"|TaxPeriod=="Dec-2011"|TaxPeriod=="Feb-2012"|TaxPeriod=="Jan-2012"|TaxPeriod=="Jul-2011"|TaxPeriod=="Jun-2011"|TaxPeriod=="Mar-2012"|TaxPeriod=="May-2011"|TaxPeriod=="Nov-2011"|TaxPeriod=="Oct-2011"|TaxPeriod=="Sep-2011"

by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.

drop if AnnualDummy==1&SemiAnnualDummy==1&TaxYear==2
drop if AnnualDummy==1&QuarterlyDummy==1&TaxYear==2
drop if AnnualDummy==1&MonthlyDummy==1&TaxYear==2
drop if SemiAnnualDummy==1&QuarterlyDummy==1&TaxYear==2
drop if SemiAnnualDummy==1&MonthlyDummy==1&TaxYear==2
drop if QuarterlyDummy==1&MonthlyDummy==1&TaxYear==2
drop AnnualDummy SemiAnnualDummy MonthlyDummy QuarterlyDummy


gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2012"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Fourth Quarter-2012"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2012"|TaxPeriod=="Aug-2012"|TaxPeriod=="Dec-2012"|TaxPeriod=="Feb-2013"|TaxPeriod=="Jan-2013"|TaxPeriod=="Jul-2012"|TaxPeriod=="Jun-2012"|TaxPeriod=="Mar-2013"|TaxPeriod=="May-2012"|TaxPeriod=="Nov-2012"|TaxPeriod=="Oct-2012"|TaxPeriod=="Sep-2012"


by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.
drop if QuarterlyDummy==1&MonthlyDummy==1&TaxYear==3


//drop if TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="May-2013"|TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"|TaxPeriod=="Apr-2013"|TaxPeriod=="Apr-2010"|TaxPeriod=="May-2010"|TaxPeriod=="Jun-2010"

drop if TurnoverGross<0
drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"

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
drop SourceFile AcknowledgementNumber ApprovalDate Status TDSDetails WardName

collapse (mean)TaxYear (sum) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase, by(DealerTIN TaxQuarter)
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

gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N
keep if TotalCount==20

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

save "E:\data\HighTurnoverDealers2010.dta", replace
}

use "E:\data\HighTurnoverDealers2010.dta", clear
append using "E:\data\MediumTurnoverDealers2010.dta"

bys DealerTIN TaxQuarter: gen Count=_N

gen NonLocalSales=TurnoverGross-TurnoverLocal
gen SalesRatio=TurnoverLocal/NonLocalSales
gen PercLocal=TurnoverLocal/TurnoverGross
//gen Category=1 if sdistance>100
//replace Category=2 if sdistance<2
//replace Category=3 if sdistance>=2&sdistance<10
//tab sdistance Category if TaxQuarter==12

preserve
gen Category=1 if sdistance>100
replace Category=2 if sdistance==0
replace Category=3 if sdistance==1
tab sdistance Category if TaxQuarter==12

replace Category=3 if sdistance>0&sdistance<10


gen Category=1 if edistance>100
replace Category=2 if edistance==0
replace Category=3 if edistance>0&edistance<10
tab edistance Category if TaxQuarter==12

gen Category=1 if edistance>100
replace Category=2 if sdistance==0&edistance!=0
replace Category=3 if edistance==0&sdistance!=0
tab sdistance Category if TaxQuarter==12



destring DealerTIN, replace
xtset DealerTIN TaxQuarter
gen Post=0
replace Post=1 if TaxQuarter>8

drop Treat
gen Treat=0 if edistance==1
replace Treat=1 if edistance==0

gen eTreat0=0
gen eTreat1=0
gen eTreat2=0
gen eTreat3=0
replace eTreat0=1 if edistance==0
replace eTreat1=1 if edistance==1
replace eTreat2=1 if edistance>1&edistance<10
replace eTreat3=1 if edistance>100

label variable eTreat0 "edistance==0"
label variable eTreat1 "edistance==1"
label variable eTreat2 "edistance>1&edistance<10"
label variable eTreat3 "edistance>100"

drop iPostTreat
gen iPostTreat=Post*Treat
gen iPosteTreat0=Post*eTreat0
gen iPosteTreat1=Post*eTreat1
gen iPosteTreat2=Post*eTreat2
gen iPosteTreat3=Post*eTreat3


gen lMoneyDeposited=log(MoneyDeposited)
gen lTotalTaxCredit=log(TotalTaxCredit)
gen lTotalOutputTax=log(TotalOutputTax)
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverLocal=log(TurnoverLocal)
gen lTotalValueAdded=log(TotalValueAdded)
gen lSalesRatio=log(SalesRatio)
gen lPercLocal=log(PercLocal)


logout, save(summary_edistance) excel replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax SalesRatio PercLocal if TaxQuarter==1, by(Treat)


foreach ques of varlist PositiveContribution MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax{
	//egen std_`ques'=std(`ques')
	sum `ques'
	gen std_`ques'=(`ques'-r(mean))/r(sd)
}
xtreg std_PositiveContribution Post iPostTreat, fe cluster(DealerTIN)
xtreg std_MoneyDeposited Post iPostTreat, fe cluster(DealerTIN)
xtreg std_TurnoverGross Post iPostTreat, fe cluster(DealerTIN)
xtreg std_TotalTaxCredit Post iPostTreat, fe cluster(DealerTIN)
xtreg std_TotalOutputTax Post iPostTreat, fe cluster(DealerTIN)


xtreg PositiveContribution Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, replace nocons keep(iPostTreat Post) title("edistance Diff in Diff")
xtreg MoneyDeposited Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TurnoverGross Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TurnoverLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TotalTaxCredit Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TotalOutputTax Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg SalesRatio Post iPostTreat i.TaxQuarter,  fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg PercLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 



xtreg lMoneyDeposited Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, replace nocons keep(iPostTreat Post) 
xtreg lTurnoverGross Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lTurnoverLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lTotalTaxCredit Post iPostTreat i.TaxQuarter , fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lTotalOutputTax Post iPostTreat i.TaxQuarter , fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lSalesRatio Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lPercLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_edistance_v2.xls, append nocons keep(iPostTreat Post) 




xtreg PositiveContribution Post iPosteTreat*, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance.xls, append keep(iPosteTreat1 iPosteTreat2 iPosteTreat3)  
xtreg MoneyDeposited Post iPosteTreat* i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance.xls, append keep(iPosteTreat1 iPosteTreat2 iPosteTreat3)  
xtreg TurnoverGross Post iPosteTreat* i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance.xls, append keep(iPosteTreat1 iPosteTreat2 iPosteTreat3)  
xtreg TotalTaxCredit Post iPosteTreat* i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance.xls, append keep(iPosteTreat1 iPosteTreat2 iPosteTreat3)  
xtreg TotalOutputTax Post iPosteTreat* i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance.xls, append keep(iPosteTreat1 iPosteTreat2 iPosteTreat3)  




drop Treat
gen Treat=0 if sdistance==1
replace Treat=1 if sdistance==0

gen sTreat0=0
gen sTreat1=0
gen sTreat2=0
gen sTreat3=0
gen sTreat4=0
replace sTreat0=1 if sdistance==0
replace sTreat1=1 if sdistance==1
replace sTreat2=1 if sdistance==2
replace sTreat3=1 if sdistance>2&sdistance<10
replace sTreat4=1 if sdistance>10

label variable sTreat0 "sdistance==0"
label variable sTreat1 "sdistance==1"
label variable sTreat2 "edistance==2"
label variable sTreat3 "sdistance>2&sdistance<100"
label variable sTreat4 "sdistance>100"



drop iPostTreat
gen iPostTreat=Post*Treat
gen iPostsTreat0=Post*sTreat0
gen iPostsTreat1=Post*sTreat1
gen iPostsTreat2=Post*sTreat2
gen iPostsTreat3=Post*sTreat3
gen iPostsTreat4=Post*sTreat4


log using "H:\2a2b_diff_in_diff_sdistance_v1.smcl", replace
xtreg PositiveContribution Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, replace nocons keep(iPostTreat Post) title("sdistance Diff in Diff")
xtreg MoneyDeposited Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TurnoverGross Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TurnoverLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TotalTaxCredit Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TotalOutputTax Post iPostTreat i.TaxQuarter , fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post)
xtreg SalesRatio Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg PercLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 


xtreg lMoneyDeposited Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, replace nocons keep(iPostTreat Post) 
xtreg lTurnoverGross Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lTurnoverLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lTotalTaxCredit Post iPostTreat i.TaxQuarter , fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lTotalOutputTax Post iPostTreat i.TaxQuarter , fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lSalesRatio Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg lPercLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using log_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post)




xtreg PositiveContribution Post iPostsTreat*, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance.xls, append keep(iPostsTreat0 iPostsTreat1 iPostsTreat2 iPostsTreat3 iPostsTreat4) 
xtreg MoneyDeposited Post iPostsTreat* , fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance.xls, append keep(iPostsTreat0 iPostsTreat1 iPostsTreat2 iPostsTreat3 iPostsTreat4) 
xtreg TurnoverGross Post iPostsTreat* , fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance.xls, append keep(iPostsTreat0 iPostsTreat1 iPostsTreat2 iPostsTreat3 iPostsTreat4) 
xtreg TotalTaxCredit Post iPostsTreat* , fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance.xls, append keep(iPostsTreat0 iPostsTreat1 iPostsTreat2 iPostsTreat3 iPostsTreat4) 
xtreg TotalOutputTax Post iPostsTreat* , fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance.xls, append keep(iPostsTreat0 iPostsTreat1 iPostsTreat2 iPostsTreat3 iPostsTreat4) 

log close


ssc install ttable2 logout
logout, save(summary_sdistance) excel replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax SalesRatio PercLocal if TaxQuarter==1, by(Treat)

xi:xtreg PositiveContribution Post iPosteTreat* i.TaxQuarter*eTreat0 i.TaxQuarter*eTreat1 i.TaxQuarter*eTreat2 i.TaxQuarter*eTreat3 , fe cluster(DealerTIN)





tab edistance
do "C:\Users\ADMINI~1\AppData\Local\Temp\2\STD00000000.tmp"
help xtreg
xtreg PositiveContribution Post Treat i.TaxQuarter
xtreg PositiveContribution Post Treat i.TaxQuarter if Category!=1, fe
xtreg PositiveContribution Post Treat iPostTreat i.TaxQuarter if Category!=1, fe
xtreg PositiveContribution Post Treat iPostTreat i.TaxQuarter TurnoverGross TotalInterStateSale TotalInterStatePurchase if Category!=1, fe cluster(DealerTIN)
xtreg PositiveContribution Post Treat iPostTreat TurnoverGross TotalInterStateSale TotalInterStatePurchase if Category!=1, fe cluster(DealerTIN)
help xi
xtreg MoneyDeposited Post Treat iPostTreat TurnoverGross TotalInterStateSale TotalInterStatePurchase if Category!=1, fe cluster(DealerTIN)


xtreg PositiveContribution Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, replace nocons keep(Post) 
xtreg MoneyDeposited  Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
xtreg TotalTaxCredit Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
xtreg TotalOutputTax Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
xtreg TurnoverGross Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
xtreg TaxCreditBeforeAdjustment Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls , append nocons keep(Post) 
xtreg NonLocalSales Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
xtreg SalesRatio Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
xtreg PercLocal Post i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_post_v2.xls, append nocons keep(Post) 
