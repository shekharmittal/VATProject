FOr our treatment and control group creation
We will only use dealers which filed returns in Q1 of 2010
First step is to save returns of dealers which did that
Then we will count the total number of returns filed by these dealers
Then we will create dummies for all the quarters in which they filed and did not file their returns

{
clear
gen TaxQuarter=1
edit
set obs 1
replace TaxQuarter = 1 in 1
set obs 2
replace TaxQuarter = 2 in 2
set obs 4
replace TaxQuarter = 4 in 4
replace TaxQuarter = 3 in 3
set obs 5
replace TaxQuarter = 5 in 5
set obs 6
replace TaxQuarter = 6 in 6
set obs 7
replace TaxQuarter = 7 in 7
set obs 8
replace TaxQuarter = 8 in 8
set obs 9
replace TaxQuarter = 9 in 9
set obs 10
replace TaxQuarter = 10 in 10
set obs 11
replace TaxQuarter = 11 in 11
set obs 12
replace TaxQuarter = 12 in 12
set obs 13
replace TaxQuarter = 13 in 13
set obs 14
replace TaxQuarter = 14 in 14
set obs 15
replace TaxQuarter = 1 in 15
replace TaxQuarter = 15 in 15
set obs 16
replace TaxQuarter = 16 in 16
set obs 17
replace TaxQuarter = 17 in 17
set obs 18
replace TaxQuarter = 18 in 18
set obs 19
replace TaxQuarter = 19 in 19
set obs 20
replace TaxQuarter = 20 in 20
save "H:\taxquarters.dta", replace


use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear
keep if TaxPeriod=="First Quarter-2010"
keep DealerTIN
cross using "H:\taxquarters.dta"
save "H:\taxquarters.dta", replace
}

{
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear
keep if TaxPeriod=="First Quarter-2010"
keep DealerTIN
save "D:\data\MediumTurnoverDealers2010_q1.dta", replace

clear
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear 
merge m:1 DealerTIN using "D:\data\MediumTurnoverDealers2010_q1.dta"
keep if _merge==3

drop if TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="May-2013"|TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"|TaxPeriod=="Apr-2013"|TaxPeriod=="Apr-2010"|TaxPeriod=="May-2010"|TaxPeriod=="Jun-2010"

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
drop SourceFile AcknowledgementNumber ApprovalDate Status TDSDetails WardName

collapse (mean)TaxYear (sum) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase, by(DealerTIN TaxQuarter)
//Creating other variables of interest
gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)

gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gen T1=.
replace T1=1 if TaxQuarter==1
by DealerTIN: replace T1=T1[_n-1] if T1>=.

merge 1:m DealerTIN TaxQuarter using "H:\taxquarters.dta"
gen Dummy=1 if _merge==3
replace Dummy=0 if _merge==2

gsort DealerTIN TaxQuarter
by DealerTIN: gen Dummy_prev=Dummy[_n-1]
gen SignChange=(Dummy_prev!=Dummy)&Dummy_prev!=.
by DealerTIN: egen NumSignChange=sum(SignChange)

keep if TaxQuarter==1
drop TaxYear PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited T1 Dummy_prev Dummy _merge
gen Source="Quarterly"
save "D:\data\MediumTurnoverDealers2010_SummaryAnalysis.dta", replace
}
{
clear
gen TaxQuarter=1
edit
set obs 1
replace TaxQuarter = 1 in 1
set obs 2
replace TaxQuarter = 2 in 2
set obs 4
replace TaxQuarter = 4 in 4
replace TaxQuarter = 3 in 3
set obs 5
replace TaxQuarter = 5 in 5
set obs 6
replace TaxQuarter = 6 in 6
set obs 7
replace TaxQuarter = 7 in 7
set obs 8
replace TaxQuarter = 8 in 8
set obs 9
replace TaxQuarter = 9 in 9
set obs 10
replace TaxQuarter = 10 in 10
set obs 11
replace TaxQuarter = 11 in 11
set obs 12
replace TaxQuarter = 12 in 12
set obs 13
replace TaxQuarter = 13 in 13
set obs 14
replace TaxQuarter = 14 in 14
set obs 15
replace TaxQuarter = 1 in 15
replace TaxQuarter = 15 in 15
set obs 16
replace TaxQuarter = 16 in 16
set obs 17
replace TaxQuarter = 17 in 17
set obs 18
replace TaxQuarter = 18 in 18
set obs 19
replace TaxQuarter = 19 in 19
set obs 20
replace TaxQuarter = 20 in 20
save "H:\taxquarters_monthly.dta", replace


//Now we will repeat the process for Monthly turnover dealers
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta", clear
keep if month==1|month==2|month==3
bys DealerTIN: gen TotalCount=_N
keep if TotalCount==3
keep if month==1
keep DealerTIN
cross using "H:\taxquarters_monthly.dta"
save "H:\taxquarters_monthly.dta", replace
}

{
//Now we will repeat the process for Monthly turnover dealers
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta", clear
keep if month==1|month==2|month==3
bys DealerTIN: gen TotalCount=_N
keep if TotalCount==3
keep if month==1
keep DealerTIN
gen Dummy=1
save "D:\data\HighTurnoverDealers2010_q1.dta", replace

use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear 
merge m:1 DealerTIN using "D:\data\HighTurnoverDealers2010_q1.dta"
keep if _merge==3

drop if TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="May-2013"|TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="Apr-2013"

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
drop SourceFile AcknowledgementNumber ApprovalDate Status TDSDetails WardName

collapse (mean)TaxYear (sum) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase, by(DealerTIN TaxQuarter)
//Creating other variables of interest
gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)

gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

merge 1:m DealerTIN TaxQuarter using "H:\taxquarters_monthly.dta"

gen Dummy=1 if _merge==3
replace Dummy=0 if _merge==2

gsort DealerTIN TaxQuarter

by DealerTIN: gen Dummy_prev=Dummy[_n-1]
gen SignChange=(Dummy_prev!=Dummy)&Dummy_prev!=.
by DealerTIN: egen NumSignChange=sum(SignChange)

keep if TaxQuarter==1
drop TaxYear PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited T1 Dummy_prev Dummy _merge
gen Source="Monthly"
save "D:\data\HighTurnoverDealers2010_SummaryAnalysis.dta", replace
}

{
use "D:\data\HighTurnoverDealers2010_SummaryAnalysis.dta", clear
append using "D:\data\MediumTurnoverDealers2010_SummaryAnalysis.dta"
bys DealerTIN: gen Count=_N
drop if Source=="Monthly"&Count==2
isid DealerTIN

merge 1:1 DealerTIN using "D:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)
keep if _merge==1|_merge==3

gen DummyRetailer = 0
gen DummyManufacturer = 0
gen DummyWholeSaler = 0 
gen DummyInterStateSeller = 0 
gen DummyInterStatePurchaser = 0
gen DummyWorkContractor = 0
gen DummyImporter = 0
gen DummyExporter = 0 
gen DummyOther = 0

replace DummyRetailer = 1 if(regexm(Nature, "Retail Trader"))
replace DummyManufacturer = 1 if(regexm(Nature, "Manufacturer"))
replace DummyWholeSaler = 1 if(regexm(Nature, "Wholesale Trader"))
replace DummyInterStateSeller = 1 if(regexm(Nature, "Interstate Seller"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "Interstate Purchaser"))
replace DummyWorkContractor = 1 if(regexm(Nature, "Work Contractor"))
replace DummyImporter = 1 if(regexm(Nature, "Importer"))
replace DummyExporter = 1 if(regexm(Nature, "Exporter"))
replace DummyOther = 1 if(regexm(Nature, "Other"))

replace DummyInterStateSeller = 1 if(regexm(Nature, "INTERSTATE SALE/PURCHASE"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "INTERSTATE SALE/PURCHASE"))

tabulate Constitution, generate(dConstitution)
tab Ward, generate(dWard)


// First we import the date from the registration date
gen RegistrationYear=dofc(RegistrationDate)
format %td RegistrationYear //change it into date format
//Import just the year inf
gen StartYear=yofd(RegistrationYear) 
gen StartMonth=mofd(RegistrationYear)
format %tm StartMonth
format %ty StartYear 
//Changing the format to appropriate year form

tab StartYear, generate(dStartYear)

reg TotalCount dWard* dStartYear* dConstitution* DummyOther DummyExporter DummyImporter DummyWorkContractor DummyInterStatePurchaser DummyInterStateSeller DummyWholeSaler DummyManufacturer DummyRetailer BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax
reg NumSignChange  dWard* dStartYear* dConstitution* DummyOther DummyExporter DummyImporter DummyWorkContractor DummyInterStatePurchaser DummyInterStateSeller DummyWholeSaler DummyManufacturer DummyRetailer BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax

log using "H:\2a2bAnalysis_2010q1Dealers_summary.log"
tab TotalCount
tab NumSignChange
reg TotalCount dWard* dStartYear* dConstitution* DummyOther DummyExporter DummyImporter DummyWorkContractor DummyInterStatePurchaser DummyInterStateSeller DummyWholeSaler DummyManufacturer DummyRetailer BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax
reg TotalCount dWard* dStartYear* dConstitution*  BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax
reg NumSignChange dWard* dStartYear* dConstitution* DummyOther DummyExporter DummyImporter DummyWorkContractor DummyInterStatePurchaser DummyInterStateSeller DummyWholeSaler DummyManufacturer DummyRetailer BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax
reg NumSignChange dWard* dStartYear* dConstitution*  BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax
log close
}
