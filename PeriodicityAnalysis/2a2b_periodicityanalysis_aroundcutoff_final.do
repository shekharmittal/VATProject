cd "E:\data"
//use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
use "PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear

/*
merge m:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature IECCode Constitution OtherConstitution OptConstitution RegistrationType AnnualTurnoverCategory TurnoverPreviousYear ExpectedTurnover RegistrationDate OwnCapital BankLoan OtherLoan PlantAndMachinery LandAndBuilding OtherAssets TotalSecurity TypeOfSecurity ExpiryBankSecurity RegularDealerType Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)
keep if _merge==3
*/

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
label variable PercValueAdded "A measure of fraction of value added, definition is (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseUnregisteredDealer)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseUnregisteredDealer "A measure of amount purchased from unregistered dealers:PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisterdDealer)"
label variable TotalValueAdded "Total value added, (TurnoverGross-TotalPurchases)"
label variable TotalPurchases "Total purchases made: PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer"


/*gen AnnualDummy=1 if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"
gen SemiAnnualDummy=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="Second Halfyear-2011"
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2010"|TaxPeriod=="Apr-2011"|TaxPeriod=="Apr-2012"|TaxPeriod=="Aug-2010"|TaxPeriod=="Aug-2011"|TaxPeriod=="Aug-2012"|TaxPeriod=="Dec-2010"|TaxPeriod=="Dec-2011"|TaxPeriod=="Dec-2012"|TaxPeriod=="Feb-2011"|TaxPeriod=="Feb-2012"|TaxPeriod=="Feb-2013"|TaxPeriod=="Jan-2011"|TaxPeriod=="Jan-2012"|TaxPeriod=="Jan-2013"|TaxPeriod=="Jul-2010"|TaxPeriod=="Jul-2011"|TaxPeriod=="Jul-2012"|TaxPeriod=="Jun-2010"|TaxPeriod=="Jun-2011"|TaxPeriod=="Jun-2012"|TaxPeriod=="Mar-2011"|TaxPeriod=="Mar-2012"|TaxPeriod=="Mar-2013"|TaxPeriod=="May-2010"|TaxPeriod=="May-2011"|TaxPeriod=="May-2012"|TaxPeriod=="Nov-2010"|TaxPeriod=="Nov-2011"|TaxPeriod=="Nov-2012"|TaxPeriod=="Oct-2010"|TaxPeriod=="Oct-2011"|TaxPeriod=="Oct-2012"|TaxPeriod=="Sep-2010"|TaxPeriod=="Sep-2011"|TaxPeriod=="Sep-2012"


by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.

drop if AnnualDummy==1&SemiAnnualDummy==1
drop if AnnualDummy==1&QuarterlyDummy==1
drop if SemiAnnualDummy==1&QuarterlyDummy==1
drop if AnnualDummy==1&MonthlyDummy==1
drop if QuarterlyDummy==1&MonthlyDummy==1
drop if MonthlyDummy==1&SemiAnnualDummy==1
*/

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
drop MonthlyDummy QuarterlyDummy


//collapse (mean) AnnualDummy QuarterlyDummy SemiAnnualDummy MonthlyDummy (sum) MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)


collapse (sum) RefundClaimed MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)


replace TurnoverGross=TurnoverGross/1000000

/*preserve
collapse (mean) MoneyDeposited, by(TurnoverGross TaxYear)
two (line MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross<53&TurnoverGross>47)
restore
*/

histogram TurnoverGross if TaxYear==1&TurnoverGross<54&TurnoverGross>46, width(.1) fraction xtitle("Gross Turnover") note ("Turnover in million rupees") title("Distribution of firms based on Turnover (in Year1)")
graph export "F:\2a2b_analysis\AroundCutoff\Discontinuity_year1.pdf", as(pdf) replace

histogram TurnoverGross if TaxYear==4&TurnoverGross<54&TurnoverGross>46, width(.1) fraction xtitle("Gross Turnover") note ("Turnover in million rupees") title("Distribution of firms based on Turnover (in Year4)")
graph export "F:\2a2b_analysis\AroundCutoff\Discontinuity_year4.pdf", as(pdf) replace


sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>48000000&TurnoverGross<49000000&QuarterlyDummy==1
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>49000000&TurnoverGross<50000000&QuarterlyDummy==1
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>50000000&TurnoverGross<51000000&QuarterlyDummy==1
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>51000000&TurnoverGross<52000000&QuarterlyDummy==1


sum MoneyDeposited PositiveContribution if TaxYear==3&TurnoverGross>48000000&TurnoverGross<49000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==3&TurnoverGross>49000000&TurnoverGross<50000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==3&TurnoverGross>50000000&TurnoverGross<51000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==3&TurnoverGross>51000000&TurnoverGross<52000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==3&TurnoverGross>52000000&TurnoverGross<53000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==3&TurnoverGross>53000000&TurnoverGross<54000000&QuarterlyDummy==1


sum MoneyDeposited PositiveContribution if TaxYear==4&TurnoverGross>48000000&TurnoverGross<49000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==4&TurnoverGross>49000000&TurnoverGross<50000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==4&TurnoverGross>50000000&TurnoverGross<51000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==4&TurnoverGross>51000000&TurnoverGross<52000000&QuarterlyDummy==1

sum MoneyDeposited PositiveContribution if TaxYear==5&TurnoverGross>48000000&TurnoverGross<49000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==5&TurnoverGross>49000000&TurnoverGross<50000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==5&TurnoverGross>50000000&TurnoverGross<51000000&QuarterlyDummy==1
sum MoneyDeposited  PositiveContribution if TaxYear==5&TurnoverGross>51000000&TurnoverGross<52000000&QuarterlyDummy==1


//gen Treat=0 if TaxYear==1&TurnoverGross>50000000&TurnoverGross<51000000&QuarterlyDummy==1
//replace Treat=1 if TaxYear==1&TurnoverGross>49000000&TurnoverGross<50000000&QuarterlyDummy==1


gen Treat=0 if TaxYear==1&TurnoverGross>50&TurnoverGross<51
replace Treat=1 if TaxYear==1&TurnoverGross>49&TurnoverGross<50


keep if Treat!=.&TaxYear==1
keep DealerTIN Treat
save "F:\2a2b_analysis\AroundCutoff\TurnoverDealers.dta", replace


use "E:\data\HighTurnoverDealers2010.dta", clear
append using "E:\data\MediumTurnoverDealers2010.dta"

merge m:1 DealerTIN using "F:\2a2b_analysis\AroundCutoff\TurnoverDealers.dta"
keep if _merge==3


gen Cycle=mod(TaxQuarter,4)
gsort DealerTIN Cycle TaxQuarter
by DealerTIN Cycle: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.


replace MoneyDeposited =MoneyDeposited/1000000
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/1000000
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/1000000
replace TurnoverGross=TurnoverGross/1000000
replace TurnoverCentral=TurnoverCentral/1000000
replace TurnoverLocal=TurnoverLocal/1000000
	
gen VatRatio=MoneyDeposited/TurnoverGross
gen CreditRatio=TaxCreditBeforeAdjustment/TurnoverGross
gen TaxRatio=OutputTaxBeforeAdjustment/TurnoverGross
gen InterstateRatio=TurnoverCentral/TurnoverGross
gen LocalVatRatio=MoneyDeposited/TurnoverLocal
gen LocalCreditRatio=TaxCreditBeforeAdjustment/TurnoverLocal
gen LocalTaxRatio=OutputTaxBeforeAdjustment/TurnoverLocal

// Comparative Stats
{
collapse (mean)Treat PositiveContribution (sum) MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)
gen VatRatio=MoneyDeposited/TurnoverGross
gen CreditRatio=TaxCreditBeforeAdjustment/TurnoverGross
gen TaxRatio=OutputTaxBeforeAdjustment/TurnoverGross
gen InterstateRatio=TurnoverCentral/TurnoverGross
gen LocalVatRatio=MoneyDeposited/TurnoverLocal
gen LocalCreditRatio=TaxCreditBeforeAdjustment/TurnoverLocal
gen LocalTaxRatio=OutputTaxBeforeAdjustment/TurnoverLocal

gsort DealerTIN TaxYear
by DealerTIN: gen TotalCount=_N
by DealerTIN: gen YearCount=_n
gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.

logout, save(summary_aroundcutoff_total5_year1) tex replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio LocalVatRatio LocalCreditRatio LocalTaxRatio if TaxYear==1, by(Treat)
logout, save(summary_aroundcutoff_total5_year2) tex replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio LocalVatRatio LocalCreditRatio LocalTaxRatio if TaxYear==2, by(Treat)
logout, save(summary_aroundcutoff_total5_year3) tex replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio LocalVatRatio LocalCreditRatio LocalTaxRatio if TaxYear==3, by(Treat)
logout, save(summary_aroundcutoff_total5_year4) tex replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio LocalVatRatio LocalCreditRatio LocalTaxRatio if TaxYear==4, by(Treat)
logout, save(summary_aroundcutoff_total5_year5) tex replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio LocalVatRatio LocalCreditRatio LocalTaxRatio if TaxYear==5, by(Treat)

collapse (mean)MoneyDeposited , by(TaxQuarter Treat)

//replace MoneyDeposited=MoneyDeposited/1000
// ytitle("Mean VAT deposited, Treatment Group", axis(2))
twoway (connected MoneyDeposited TaxQuarter if Treat==0) (connected MoneyDeposited TaxQuarter if Treat==1), xline(8) ytitle("Mean VAT deposited, Control Group") legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in thousand rupees. No of control firms 92, Treatment firms 321")
graph export "H:\2a2b_analysis\AroundCutoff\VATDeposited_trends_AroundCutoff_quarterly.pdf", as(pdf) replace

collapse (mean)MoneyDeposited , by(TaxYear Treat)

//replace MoneyDeposited=MoneyDeposited/1000

twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1), xline(2) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 140 and number of treatment firms is 362")
graph save Graph "F:\2a2b_analysis\AroundCutoff\VATDeposited_v2.gph"
graph export "F:\2a2b_analysis\AroundCutoff\VATDeposited_trends_AroundCutoff.pdf", as(pdf) replace

}



//Yearly analysis

gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)

gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0



destring DealerTIN, replace
xtset DealerTIN TaxYear

gen Post=0
replace Post=1 if TaxYear>2


gen iPostTreat=Post*Treat
gen iTaxYear1=0
gen iTaxYear2=0
gen iTaxYear3=0
gen iTaxYear4=0
gen iTaxYear5=0

replace iTaxYear1=1 if TaxYear==1
replace iTaxYear2=1 if TaxYear==2
replace iTaxYear3=1 if TaxYear==3
replace iTaxYear4=1 if TaxYear==4
replace iTaxYear5=1 if TaxYear==5


//Pretrend Analysis
{
gen iTreat1=Treat*iTaxYear1
gen iTreat2=Treat*iTaxYear2
gen iTreat3=Treat*iTaxYear3
gen iTreat4=Treat*iTaxYear4	
gen iTreat5=Treat*iTaxYear5

log using "F:\2a2b_analysis\AroundCutoff\pretrends_analysis.log", replace
xtreg MoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat1 iTreat2  iTreat4 iTreat5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\Pretrends_analysis",  tex replace nocons 

xtreg TaxCreditBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\Pretrends_analysis",  tex append nocons  

xtreg OutputTaxBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\Pretrends_analysis",  tex append nocons 
log close
}

xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Mean_AroundCutoff_Treat",  tex replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Mean_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Mean_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Mean_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Mean_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Mean_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 

xtreg VatRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Ratio_AroundCutoff_Treat",  tex replace nocons keep(Post iPostTreat) 
xtreg CreditRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Ratio_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Ratio_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg LocalVatRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Ratio_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg LocalCreditRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Ratio_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg LocalTaxRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\AroundCutoff\diffINdiff_Ratio_AroundCutoff_Treat",  tex append nocons keep(Post iPostTreat) 



//Quarterly Analysis

destring DealerTIN, replace
xtset DealerTIN TaxQuarter
gen Post=0
replace Post=1 if TaxQuarter>8

gen iPostTreat=Post*Treat

gen iTaxQuarter1=0
gen iTaxQuarter2=0
gen iTaxQuarter3=0
gen iTaxQuarter4=0
gen iTaxQuarter5=0
gen iTaxQuarter6=0
gen iTaxQuarter7=0
gen iTaxQuarter8=0
gen iTaxQuarter9=0
gen iTaxQuarter10=0
gen iTaxQuarter11=0
gen iTaxQuarter12=0
gen iTaxQuarter13=0
gen iTaxQuarter14=0
gen iTaxQuarter15=0
gen iTaxQuarter16=0
gen iTaxQuarter17=0
gen iTaxQuarter18=0
gen iTaxQuarter19=0
gen iTaxQuarter20=0

replace iTaxQuarter1=1 if TaxQuarter==1
replace iTaxQuarter2=1 if TaxQuarter==2
replace iTaxQuarter3=1 if TaxQuarter==3
replace iTaxQuarter4=1 if TaxQuarter==4
replace iTaxQuarter5=1 if TaxQuarter==5
replace iTaxQuarter6=1 if TaxQuarter==6
replace iTaxQuarter7=1 if TaxQuarter==7
replace iTaxQuarter8=1 if TaxQuarter==8
replace iTaxQuarter9=1 if TaxQuarter==9
replace iTaxQuarter10=1 if TaxQuarter==10
replace iTaxQuarter11=1 if TaxQuarter==11
replace iTaxQuarter12=1 if TaxQuarter==12
replace iTaxQuarter13=1 if TaxQuarter==13
replace iTaxQuarter14=1 if TaxQuarter==14
replace iTaxQuarter15=1 if TaxQuarter==15
replace iTaxQuarter16=1 if TaxQuarter==16
replace iTaxQuarter17=1 if TaxQuarter==17
replace iTaxQuarter18=1 if TaxQuarter==18
replace iTaxQuarter19=1 if TaxQuarter==19
replace iTaxQuarter20=1 if TaxQuarter==20

//PreTrend Analysis
{
gen iTreatT1=Treat*iTaxQuarter1
gen iTreatT2=Treat*iTaxQuarter2
gen iTreatT3=Treat*iTaxQuarter3
gen iTreatT4=Treat*iTaxQuarter4
gen iTreatT5=Treat*iTaxQuarter5
gen iTreatT6=Treat*iTaxQuarter6
gen iTreatT7=Treat*iTaxQuarter7
gen iTreatT8=Treat*iTaxQuarter8
gen iTreatT9=Treat*iTaxQuarter9
gen iTreatT10=Treat*iTaxQuarter10
gen iTreatT11=Treat*iTaxQuarter11
gen iTreatT12=Treat*iTaxQuarter12
gen iTreatT13=Treat*iTaxQuarter13
gen iTreatT14=Treat*iTaxQuarter14
gen iTreatT15=Treat*iTaxQuarter15
gen iTreatT16=Treat*iTaxQuarter16
gen iTreatT17=Treat*iTaxQuarter17
gen iTreatT18=Treat*iTaxQuarter18
gen iTreatT19=Treat*iTaxQuarter19
gen iTreatT20=Treat*iTaxQuarter20

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
xtreg MoneyDeposited `TaxQuarterDummy' iTreat*, fe cluster(DealerTIN)
}
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 

xtreg lMoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 

xtreg VatRatio Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg CreditRatio Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg TaxRatio Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, replace nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.6")
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.7")
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.8")


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.6")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.7")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.8")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.6")
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.7")
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
outreg2 using diffINdiff_QuantileAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.8")
