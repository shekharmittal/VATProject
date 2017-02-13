cd "D:\data"
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

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
*drop AnnualDummy SemiAnnualDummy MonthlyDummy QuarterlyDummy
*drop Mean*
*gen AnnualDummy=0
*gen SemiAnnualDummy=0
*gen QuarterlyDummy=0
*gen MonthlyDummy=0

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

gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))
gen l2TotalTaxCredit=log(TotalTaxCredit+sqrt(TotalTaxCredit^2+1))
gen l2TotalOutputTax=log(TotalOutputTax+sqrt(TotalOutputTax^2+1))
gen l2TurnoverGross=log(TurnoverGross+sqrt(TurnoverGross^2+1))
gen l2TurnoverLocal=log(TurnoverLocal+sqrt(TurnoverLocal^2+1))
gen l2TotalValueAdded=log(TotalValueAdded+sqrt(TotalValueAdded^2+1))
gen l2PurchaseUnregisteredDealer=log(PurchaseUnregisteredDealer+sqrt(PurchaseUnregisteredDealer^2+1))
gen l2CreditOtherGoods=log(CreditOtherGoods+sqrt(CreditOtherGoods^2+1))
gen l2CreditCapitalGoods=log(CreditCapitalGoods+sqrt(CreditCapitalGoods^2+1))
gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
gen l2AdjustmentTaxCredit=log(AdjustmentTaxCredit+sqrt(AdjustmentTaxCredit^2+1))
gen l2TotalPurchases=log(TotalPurchases+sqrt(TotalPurchases^2+1))
gen l2TotalInterStateSale=log(TotalInterStateSale+sqrt(TotalInterStateSale^2+1))
gen l2TotalInterStatePurchase=log(TotalInterStatePurchase+sqrt(TotalInterStatePurchase^2+1))
gen l2ExportFromIndia=log(ExportFromIndia+sqrt(ExportFromIndia^2+1))
gen l2ImportToIndia=log(ImportToIndia+sqrt(ImportToIndia^2+1))
gen l2InterStateSaleCD=log(InterStateSaleCD+sqrt(InterStateSaleCD^2+1))
gen l2InterStatePurchaseCD=log(InterStatePurchaseCD+sqrt(InterStatePurchaseCD^2+1))
gen l2InterStatePurchaseCE1E2=log(InterStatePurchaseCE1E2+sqrt(InterStatePurchaseCE1E2^2+1))
gen l2InterStateSaleCE1E2=log(InterStateSaleCE1E2+sqrt(InterStateSaleCE1E2^2+1))
gen l2InterStateExportsAgainstH=log(InterStateExportsAgainstH+sqrt(InterStateExportsAgainstH^2+1))
gen l2InterStateImportsAgainstH=log(InterStateImportsAgainstH+sqrt(InterStateImportsAgainstH^2+1))
gen l2InterStateExportsAgainstI=log(InterStateExportsAgainstI+sqrt(InterStateExportsAgainstI^2+1))
gen l2InterStateImportsAgainstI=log(InterStateImportsAgainstI+sqrt(InterStateImportsAgainstI^2+1))
gen l2InterStateExportsAgainstJ=log(InterStateExportsAgainstJ+sqrt(InterStateExportsAgainstJ^2+1))
gen l2InterStateImportsAgainstJ=log(InterStateImportsAgainstJ+sqrt(InterStateImportsAgainstJ^2+1))

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0


gen AnnualDummy=1 if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"
gen SemiAnnualDummy=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="Second Halfyear-2011"
gen QuarterlyDummy=1 if TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"
gen MonthlyDummy=1 if TaxPeriod=="Apr-2010"|TaxPeriod=="Apr-2011"|TaxPeriod=="Apr-2012"|TaxPeriod=="Aug-2010"|TaxPeriod=="Aug-2011"|TaxPeriod=="Aug-2012"|TaxPeriod=="Dec-2010"|TaxPeriod=="Dec-2011"|TaxPeriod=="Dec-2012"|TaxPeriod=="Feb-2011"|TaxPeriod=="Feb-2012"|TaxPeriod=="Feb-2013"|TaxPeriod=="Jan-2011"|TaxPeriod=="Jan-2012"|TaxPeriod=="Jan-2013"|TaxPeriod=="Jul-2010"|TaxPeriod=="Jul-2011"|TaxPeriod=="Jul-2012"|TaxPeriod=="Jun-2010"|TaxPeriod=="Jun-2011"|TaxPeriod=="Jun-2012"|TaxPeriod=="Mar-2011"|TaxPeriod=="Mar-2012"|TaxPeriod=="Mar-2013"|TaxPeriod=="May-2010"|TaxPeriod=="May-2011"|TaxPeriod=="May-2012"|TaxPeriod=="Nov-2010"|TaxPeriod=="Nov-2011"|TaxPeriod=="Nov-2012"|TaxPeriod=="Oct-2010"|TaxPeriod=="Oct-2011"|TaxPeriod=="Oct-2012"|TaxPeriod=="Sep-2010"|TaxPeriod=="Sep-2011"|TaxPeriod=="Sep-2012"


by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.


gsort DealerTIN -TaxYear -TaxHalfyear -TaxQuarter -TaxMonth

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

collapse (mean) AnnualDummy QuarterlyDummy SemiAnnualDummy MonthlyDummy (sum) MoneyDeposited l2MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)

//Annual Discontinuity
histogram TurnoverGross if TaxYear==1&TurnoverGross<1500000&TurnoverGross>500000, width(10000) frequency
histogram TurnoverGross if TaxYear==1&TurnoverGross<1300000&TurnoverGross>700000&AnnualDummy==1, width(10000) frequency



//Quarterly discontinuity
histogram TurnoverGross if TaxYear==1&TurnoverGross<5500000&TurnoverGross>4500000&SemiAnnualDummy==1, width(100000) frequency



//Monthly Discontinuity
histogram TurnoverGross if TaxYear==1&TurnoverGross<52000000&TurnoverGross>48000000&QuarterlyDummy==1, width(100000) frequency
histogram TurnoverGross if TaxYear==3&TurnoverGross<55000000&TurnoverGross>45000000, width(100000) frequency
histogram TurnoverGross if TaxYear==4&TurnoverGross<55000000&TurnoverGross>45000000, width(100000) frequency


sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>800000&TurnoverGross<900000&AnnualDummy==1, detail
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>900000&TurnoverGross<1000000&AnnualDummy==1, detail
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>1000000&TurnoverGross<1100000&AnnualDummy==1, detail
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>1100000&TurnoverGross<1200000&AnnualDummy==1, detail


sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>4800000&TurnoverGross<4900000&SemiAnnualDummy==1
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>4900000&TurnoverGross<5000000&SemiAnnualDummy==1
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>5000000&TurnoverGross<5100000&SemiAnnualDummy==1
sum MoneyDeposited TurnoverGross if TaxYear==1&TurnoverGross>5100000&TurnoverGross<5200000&SemiAnnualDummy==1


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

//PeriodicityAnalysis

//Annual firm analysis





//2A-2B analysis
keep if TaxYear==1&TurnoverGross>49000000&TurnoverGross<51000000&QuarterlyDummy==1
gen Treat=1 if TurnoverGross<50000000
replace Treat=0 if Treat==.
keep DealerTIN Treat
save "H:\TurnoverDealers.dta"

use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

drop _merge

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

merge m:1 DealerTIN using "H:\TurnoverDealers.dta"
drop if _merge!=3

gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)

gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))
gen l2TotalTaxCredit=log(TotalTaxCredit+sqrt(TotalTaxCredit^2+1))
gen l2TotalOutputTax=log(TotalOutputTax+sqrt(TotalOutputTax^2+1))
gen l2TurnoverGross=log(TurnoverGross+sqrt(TurnoverGross^2+1))
gen l2TurnoverLocal=log(TurnoverLocal+sqrt(TurnoverLocal^2+1))
gen l2TotalValueAdded=log(TotalValueAdded+sqrt(TotalValueAdded^2+1))
gen l2PurchaseUnregisteredDealer=log(PurchaseUnregisteredDealer+sqrt(PurchaseUnregisteredDealer^2+1))
gen l2CreditOtherGoods=log(CreditOtherGoods+sqrt(CreditOtherGoods^2+1))
gen l2CreditCapitalGoods=log(CreditCapitalGoods+sqrt(CreditCapitalGoods^2+1))
gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
gen l2AdjustmentTaxCredit=log(AdjustmentTaxCredit+sqrt(AdjustmentTaxCredit^2+1))
gen l2TotalPurchases=log(TotalPurchases+sqrt(TotalPurchases^2+1))
gen l2TotalInterStateSale=log(TotalInterStateSale+sqrt(TotalInterStateSale^2+1))
gen l2TotalInterStatePurchase=log(TotalInterStatePurchase+sqrt(TotalInterStatePurchase^2+1))
gen l2ExportFromIndia=log(ExportFromIndia+sqrt(ExportFromIndia^2+1))
gen l2ImportToIndia=log(ImportToIndia+sqrt(ImportToIndia^2+1))
gen l2InterStateSaleCD=log(InterStateSaleCD+sqrt(InterStateSaleCD^2+1))
gen l2InterStatePurchaseCD=log(InterStatePurchaseCD+sqrt(InterStatePurchaseCD^2+1))
gen l2InterStatePurchaseCE1E2=log(InterStatePurchaseCE1E2+sqrt(InterStatePurchaseCE1E2^2+1))
gen l2InterStateSaleCE1E2=log(InterStateSaleCE1E2+sqrt(InterStateSaleCE1E2^2+1))
gen l2InterStateExportsAgainstH=log(InterStateExportsAgainstH+sqrt(InterStateExportsAgainstH^2+1))
gen l2InterStateImportsAgainstH=log(InterStateImportsAgainstH+sqrt(InterStateImportsAgainstH^2+1))
gen l2InterStateExportsAgainstI=log(InterStateExportsAgainstI+sqrt(InterStateExportsAgainstI^2+1))
gen l2InterStateImportsAgainstI=log(InterStateImportsAgainstI+sqrt(InterStateImportsAgainstI^2+1))
gen l2InterStateExportsAgainstJ=log(InterStateExportsAgainstJ+sqrt(InterStateExportsAgainstJ^2+1))
gen l2InterStateImportsAgainstJ=log(InterStateImportsAgainstJ+sqrt(InterStateImportsAgainstJ^2+1))

gen Cycle=mod(TaxQuarter,4)
gsort DealerTIN Cycle TaxQuarter
by DealerTIN Cycle: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.


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

gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N

log using "H:\PeriodicityAnalysis_aroundcutoff_regressions_omnipresent.log", replace
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post `TaxQuarterDummy' if TotalCount==20, cluster(DealerTIN) fe
xtreg VatIncrease Post `TaxQuarterDummy' if TotalCount==20, cluster(DealerTIN) fe

qreg MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.95)

qreg lMoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg lMoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg lMoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg lMoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg lMoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg lMoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.95)

qreg l2MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg l2MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg l2MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg l2MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg l2MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg l2MoneyDeposited  Post `TaxQuarterDummy' if TotalCount==20, q(.95)

qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.95)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.95)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.95)


qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.9)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.95)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.5)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.6)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.7)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy' if TotalCount==20, q(.8)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)


tobit MoneyDeposited Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)

qregpd MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)


//qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
//qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


tobit MoneyDeposited Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post Treat iPostTreat `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post Treat iPostTreat `TaxQuarterDummy', ll(0) cluster(DealerTIN)


qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post  iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

log close


log using "H:\PeriodicityAnalysis_aroundcutoff_regressions.log", replace
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post `TaxQuarterDummy', cluster(DealerTIN) fe
xtreg VatIncrease Post `TaxQuarterDummy', cluster(DealerTIN) fe

qreg MoneyDeposited  Post `TaxQuarterDummy', q(.5)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.6)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.7)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.8)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.9)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.95)

qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.5)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.6)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.7)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.8)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.9)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.95)

qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.5)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.6)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.7)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.8)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.9)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.95)

qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.95)


qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)


tobit MoneyDeposited Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)

qregpd MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)


//qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
//qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


tobit MoneyDeposited Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post Treat iPostTreat `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post Treat iPostTreat `TaxQuarterDummy', ll(0) cluster(DealerTIN)


qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post  iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

log close











qreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', q(.75) 
qreg TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy' Dealer1* Dealer2* Dealer3* Dealer4*

qreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy' Dealer1* Dealer2* Dealer3* Dealer4*

mata: mata mlib index
ssc install moremata
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)
qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)
qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)


local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg lMoneyDeposited Post iPostTreat `TaxQuarterDummy' if MoneyDeposited>0, fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat `TaxQuarterDummy' if MoneyDeposited>0, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

ssc install ttable2 logout
logout, save(summary_sdistance) excel replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax SalesRatio PercLocal if TaxQuarter==1, by(Treat)

collapse (mean) PositiveContribution TurnoverGross TurnoverCentral TurnoverLocal OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited l2MoneyDeposited TotalPurchases PercValueAdded TotalValueAdded PercPurchaseUnregisteredDealer (sd) sd_TurnoverGross= TurnoverGross sd_TurnoverCentral= TurnoverCentral sd_TurnoverLocal= TurnoverLocal sd_PurchaseOtherGoods=PurchaseOtherGoods sd_OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment sd_AdjustmentOutputTax=AdjustmentOutputTax sd_TotalOutputTax=TotalOutputTax sd_PurchaseCapitalGoods=PurchaseCapitalGoods sd_CreditCapitalGoods=CreditCapitalGoods sd_CreditOtherGoods=CreditOtherGoods sd_TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment sd_AdjustmentTaxCredit=AdjustmentTaxCredit sd_TotalTaxCredit=TotalTaxCredit sd_NetTax=NetTax sd_BalancePayable=BalancePayable sd_AmountDepositedByDealer=AmountDepositedByDealer sd_AggregateAmountPaid=AggregateAmountPaid sd_NetBalance=NetBalance sd_BalanceBroughtForward=BalanceBroughtForward sd_AdjustCSTLiability=AdjustCSTLiability sd_RefundClaimed=RefundClaimed sd_BalanceCarriedNextTaxPeriod=BalanceCarriedNextTaxPeriod sd_InterStateSaleCD=InterStateSaleCD sd_InterStatePurchaseCD=InterStatePurchaseCD sd_InterStateSaleCE1E2=InterStateSaleCE1E2 sd_InterStatePurchaseCE1E2=InterStatePurchaseCE1E2 sd_InterStateSaleOther=InterStateSaleOther sd_InterStatePurchaseOther=InterStatePurchaseOther sd_InterStateSaleCapital=InterStateSaleCapital sd_InterStatePurchaseCapital=InterStatePurchaseCapital sd_TotalInterStateSale=TotalInterStateSale sd_TotalInterStatePurchase=TotalInterStatePurchase sd_PurchaseUnregisteredDealer=PurchaseUnregisteredDealer sd_MoneyDeposited=MoneyDeposited sd_PercValueAdded=PercValueAdded sd_TotalValueAdded=TotalValueAdded sd_PercPurchaseUnregistered=PercPurchaseUnregisteredDealer sd_TotalPurchases=TotalPurchases, by (TaxQuarter Treat)

twoway (connected PositiveContribution TaxQuarter if Treat==1)(connected PositiveContribution TaxQuarter if Treat==0), xline(9) title("Money Deposited")


twoway (connected TurnoverGross TaxQuarter if Treat==1)(connected TurnoverGross TaxQuarter if Treat==0), xline(9) title("Money Deposited")

twoway (connected MoneyDeposited TaxQuarter if Treat==1)(connected MoneyDeposited TaxQuarter if Treat==0,yaxis(2)), xline(9) title("Money Deposited")
twoway (connected l2MoneyDeposited TaxQuarter if Treat==1)(connected l2MoneyDeposited TaxQuarter if Treat==0), xline(9) title("l2 Money Deposited")

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if Treat==1)(connected OutputTaxBeforeAdjustment TaxQuarter if Treat==0), xline(9) title("Output Tax Before Adjustment")
twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if Treat==1)(connected l2OutputTaxBeforeAdjustment TaxQuarter if Treat==0), xline(9) title("l2 Output Tax Before Adjustment")

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Treat==1)(connected TaxCreditBeforeAdjustment TaxQuarter if Treat==0), xline(9) title("TaxCredit Before Adjustment")
twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if Treat==1)(connected l2TaxCreditBeforeAdjustment TaxQuarter if Treat==0), xline(9) title("l2 TaxCredit Before Adjustment")
