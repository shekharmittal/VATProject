cd "E:\data"

//use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
use "PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear

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

//drop if TaxQuarter==0
//collapse (sum) RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)

collapse (sum) RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxQuarter)

gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gen AllCentral=0
replace AllCentral=1 if TurnoverGross==TurnoverCentral&TurnoverGross!=0

gen AllLocal=0
replace AllLocal=1 if TurnoverCentral==0&TurnoverGross!=0

order CarryForwardTaxCredit, before(BalanceCarriedNextTaxPeriod)

gen ZeroTax=(ExemptedSales==TurnoverLocal)&TurnoverLocal!=0

gen Diff=OutputTaxBeforeAdjustment-TaxCreditBeforeAdjustment


gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N
by DealerTIN: gen RunningCount=_n

/*
gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.
*/

merge m:1 DealerTIN using "E:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)
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
gen DummyHotel=0
gen DummyECommerce=0


replace DummyManufacturer = 1 if(regexm(Nature, "Manufacturer"))
replace DummyManufacturer = 1 if(regexm(Nature, "Manufecturer"))
replace DummyManufacturer = 1 if(regexm(Nature, "Manufacturing"))
replace DummyManufacturer = 1 if(regexm(Nature, "MANUFACTURER"))



replace DummyRetailer = 1 if(regexm(Nature, "Retail Trader"))
replace DummyRetailer = 1 if(regexm(Nature, "Retailer"))
replace DummyRetailer = 1 if(regexm(Nature, "RETAILER"))
replace DummyRetailer = 1 if(regexm(Nature, "RETAIL SALE"))
replace DummyRetailer = 1 if(regexm(Nature, "RETAIL TRADER"))


replace DummyWholeSaler = 1 if(regexm(Nature, "Wholesale Trader"))
replace DummyWholeSaler = 1 if(regexm(Nature, "Wholesaler"))
replace DummyWholeSaler = 1 if(regexm(Nature, "WHOLESALER"))
replace DummyWholeSaler = 1 if(regexm(Nature, "WHOLESALE DEALER"))
replace DummyWholeSaler = 1 if(regexm(Nature, "WHOLESELLER"))
replace DummyWholeSaler = 1 if(regexm(Nature, "wholeseller"))
replace DummyWholeSaler = 1 if(regexm(Nature, "wholesaler"))

gen Treat=0 if DummyRetailer==1&DummyWholeSaler==0&DummyManufacturer==0
replace Treat=1 if DummyRetailer==0&DummyWholeSaler==1&DummyManufacturer==0


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



gen Cycle=mod(TaxQuarter,4)
gsort DealerTIN Cycle TaxQuarter
by DealerTIN Cycle: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.

gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)

drop if TotalCount!=20
drop if Treat==.


destring DealerTIN, replace
xtset DealerTIN TaxQuarter

drop Post iPostTreat
gen Post=0
replace Post=1 if TaxQuarter>16

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
xtreg MoneyDeposited `TaxQuarterDummy' iTreat* if TotalCount==20, fe cluster(DealerTIN)
}



preserve
drop if TotalCount!=20
drop if Treat==.
collapse (sum) MoneyDeposited (mean) AvgMoneyDeposited=MoneyDeposited (semean) SEMoneyDeposited=MoneyDeposited, by(TaxQuarter Treat)
gen LHS=AvgMoneyDeposited-1.96*SEMoneyDeposited
gen RHS=AvgMoneyDeposited+1.96*SEMoneyDeposited
twoway (connected AvgMoneyDeposited TaxQuarter if Treat==0) (line LHS TaxQuarter if Treat==0, lpattern(dot)) (line RHS TaxQuarter if Treat==0, lpattern(dot)) (connected AvgMoneyDeposited TaxQuarter if Treat==1, lpattern(dash)) (line LHS TaxQuarter if Treat==1, lpattern(dash_3dot)) (line RHS TaxQuarter if Treat==1, lpattern(dash_3dot)), xline(8) legend (order(1 "Control Group" 4 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in million rupees.") graphregion(color(white))
restore 

preserve
collapse (sum) MoneyDeposited (mean) AvgMoneyDeposited=MoneyDeposited (semean) SEMoneyDeposited=MoneyDeposited, by(TaxQuarter Treat2)
gen LHS=AvgMoneyDeposited-1.96*SEMoneyDeposited
gen RHS=AvgMoneyDeposited+1.96*SEMoneyDeposited
twoway (connected AvgMoneyDeposited TaxQuarter if Treat2==0) (connected LHS TaxQuarter if Treat2==0) (connected RHS TaxQuarter if Treat2==0) (connected AvgMoneyDeposited TaxQuarter if Treat==1) (connected LHS TaxQuarter if Treat2==1) (connected RHS TaxQuarter if Treat2==1), xline(8) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 140 and number of treatment firms is 362")
restore 

log using "F:\2a2b_analysis\RetailerVsWholeSaler\QuarterlyRegressions_TotalCount5.log", replace
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Quarterly_TotalCount5_Treat",  tex replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Quarterly_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Quarterly_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Quarterly_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Quarterly_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 

xtreg lMoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
//outreg2 using diffINdiff_MeanAroundCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 

xtreg VatRatio Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg CreditRatio Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg TaxRatio Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
log close

//replace MoneyDeposited=MoneyDeposited/1000
keep if TotalCount==20
//collapse (mean)MoneyDeposited , by(TaxYear Treat)

twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1), xline(2) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 140 and number of treatment firms is 362")
graph save Graph "F:\2a2b_analysis\AroundCutoff\VATDeposited_v2.gph"
graph export "F:\2a2b_analysis\AroundCutoff\VATDeposited_trends_AroundCutoff.pdf", as(pdf) replace


xtile group1=MoneyDeposited if Treat==1&TaxQuarter==1 , nq(100) 
xtile group2=MoneyDeposited if Treat==1&TaxQuarter==2 , nq(100) 
xtile group3=MoneyDeposited if Treat==1&TaxQuarter==3 , nq(100) 
xtile group4=MoneyDeposited if Treat==1&TaxQuarter==4 , nq(100)
xtile group5=MoneyDeposited if Treat==1&TaxQuarter==5 , nq(100) 
xtile group6=MoneyDeposited if Treat==1&TaxQuarter==6 , nq(100) 
xtile group7=MoneyDeposited if Treat==1&TaxQuarter==7 , nq(100) 
xtile group8=MoneyDeposited if Treat==1&TaxQuarter==8 , nq(100) 
xtile group9=MoneyDeposited if Treat==1&TaxQuarter==9 , nq(100) 
xtile group10=MoneyDeposited if Treat==1&TaxQuarter==10 , nq(100) 
xtile group11=MoneyDeposited if Treat==1&TaxQuarter==11 , nq(100) 
xtile group12=MoneyDeposited if Treat==1&TaxQuarter==12 , nq(100) 
xtile group13=MoneyDeposited if Treat==1&TaxQuarter==13 , nq(100) 
xtile group14=MoneyDeposited if Treat==1&TaxQuarter==14 , nq(100) 
xtile group15=MoneyDeposited if Treat==1&TaxQuarter==15 , nq(100) 
xtile group16=MoneyDeposited if Treat==1&TaxQuarter==16 , nq(100) 
xtile group17=MoneyDeposited if Treat==1&TaxQuarter==17 , nq(100) 
xtile group18=MoneyDeposited if Treat==1&TaxQuarter==18 , nq(100) 
xtile group19=MoneyDeposited if Treat==1&TaxQuarter==19 , nq(100) 
xtile group20=MoneyDeposited if Treat==1&TaxQuarter==20 , nq(100) 


gen TreatGroup=group1
replace TreatGroup=group2 if TreatGroup==.
replace TreatGroup=group3 if TreatGroup==.
replace TreatGroup=group4 if TreatGroup==.
replace TreatGroup=group5 if TreatGroup==.
replace TreatGroup=group6 if TreatGroup==.
replace TreatGroup=group7 if TreatGroup==.
replace TreatGroup=group8 if TreatGroup==.
replace TreatGroup=group9 if TreatGroup==.
replace TreatGroup=group10 if TreatGroup==.
replace TreatGroup=group11 if TreatGroup==.
replace TreatGroup=group12 if TreatGroup==.
replace TreatGroup=group13 if TreatGroup==.
replace TreatGroup=group14 if TreatGroup==.
replace TreatGroup=group15 if TreatGroup==.
replace TreatGroup=group16 if TreatGroup==.
replace TreatGroup=group17 if TreatGroup==.
replace TreatGroup=group18 if TreatGroup==.
replace TreatGroup=group19 if TreatGroup==.
replace TreatGroup=group20 if TreatGroup==.


drop group*

xtile group1=MoneyDeposited if Treat==0&TaxQuarter==1 , nq(100) 
xtile group2=MoneyDeposited if Treat==0&TaxQuarter==2 , nq(100) 
xtile group3=MoneyDeposited if Treat==0&TaxQuarter==3 , nq(100) 
xtile group4=MoneyDeposited if Treat==0&TaxQuarter==4 , nq(100)
xtile group5=MoneyDeposited if Treat==0&TaxQuarter==5 , nq(100) 
xtile group6=MoneyDeposited if Treat==0&TaxQuarter==6 , nq(100) 
xtile group7=MoneyDeposited if Treat==0&TaxQuarter==7 , nq(100) 
xtile group8=MoneyDeposited if Treat==0&TaxQuarter==8 , nq(100) 
xtile group9=MoneyDeposited if Treat==0&TaxQuarter==9 , nq(100) 
xtile group10=MoneyDeposited if Treat==0&TaxQuarter==10 , nq(100) 
xtile group11=MoneyDeposited if Treat==0&TaxQuarter==11 , nq(100) 
xtile group12=MoneyDeposited if Treat==0&TaxQuarter==12 , nq(100) 
xtile group13=MoneyDeposited if Treat==0&TaxQuarter==13 , nq(100) 
xtile group14=MoneyDeposited if Treat==0&TaxQuarter==14 , nq(100) 
xtile group15=MoneyDeposited if Treat==0&TaxQuarter==15 , nq(100) 
xtile group16=MoneyDeposited if Treat==0&TaxQuarter==16 , nq(100) 
xtile group17=MoneyDeposited if Treat==0&TaxQuarter==17 , nq(100) 
xtile group18=MoneyDeposited if Treat==0&TaxQuarter==18 , nq(100) 
xtile group19=MoneyDeposited if Treat==0&TaxQuarter==19 , nq(100) 
xtile group20=MoneyDeposited if Treat==0&TaxQuarter==20 , nq(100) 

gen ControlGroup=group1
replace ControlGroup=group2 if ControlGroup==.
replace ControlGroup=group3 if ControlGroup==.
replace ControlGroup=group4 if ControlGroup==.
replace ControlGroup=group5 if ControlGroup==.
replace ControlGroup=group6 if ControlGroup==.
replace ControlGroup=group7 if ControlGroup==.
replace ControlGroup=group8 if ControlGroup==.
replace ControlGroup=group9 if ControlGroup==.
replace ControlGroup=group10 if ControlGroup==.
replace ControlGroup=group11 if ControlGroup==.
replace ControlGroup=group12 if ControlGroup==.
replace ControlGroup=group13 if ControlGroup==.
replace ControlGroup=group14 if ControlGroup==.
replace ControlGroup=group15 if ControlGroup==.
replace ControlGroup=group16 if ControlGroup==.
replace ControlGroup=group17 if ControlGroup==.
replace ControlGroup=group18 if ControlGroup==.
replace ControlGroup=group19 if ControlGroup==.
replace ControlGroup=group20 if ControlGroup==.

drop group*

//Matching on Tax Quarters TaxAmount Matching
merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatchingSalesAllQuarters.dta", generate(_merge_sales)
drop if _merge_sales==2
rename AvgMatch SalesAvgMatch


merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\TaxAmountMatchingPurchaseAllQuarters.dta", generate(_merge_purchases)
drop if _merge_purchases==2
rename AvgMatch PurchasesAvgMatch


//Matching on Tax Quarters Name Matching
merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\NameMatchingSalesAllQuarters.dta", generate(_merge_sales)
drop if _merge_sales==2
rename AvgMatch SalesAvgMatch


merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\OtherMatching\NameMatchingPurchaseAllQuarters.dta", generate(_merge_purchases)
drop if _merge_purchases==2
rename AvgMatch PurchasesAvgMatch


//Matching when we keep duplicates
merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\NoDuplicatesPurchaseAllQuarters.dta", keepusing(AvgMatch AvgMatch3 AvgNameMatch) generate(_merge_purchases)
drop if _merge_purchases==2
rename AvgMatch PurchasesAvgMatch
rename AvgMatch3 PurchasesAvgMatch3
rename AvgNameMatch PurchasesNameAvgMatch

merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\KeepDuplicate\NoDuplicatesSalesAllQuarters.dta", keepusing(AvgMatch AvgMatch3 AvgNameMatch) generate(_merge_sales)
drop if _merge_sales==2
rename AvgMatch SalesAvgMatch
rename AvgMatch3 SalesAvgMatch3
rename AvgNameMatch SalesNameAvgMatch


tostring DealerTIN, replace

merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\MatchSaleAllQuarters.dta", generate(_merge_sales)

drop if _merge_sales==2
rename AvgMatch SalesAvgMatch


tab Treat _merge_sales if TaxQuarter==17, row
/*
 tab Treat _merge_sales if TaxQuarter==17, row

+----------------+
| Key            |
|----------------|
|   frequency    |
| row percentage |
+----------------+

           |     _merge_sales
     Treat | master on  matched ( |     Total
-----------+----------------------+----------
         0 |     6,688      8,649 |    15,337 
           |     43.61      56.39 |    100.00 
-----------+----------------------+----------
         1 |     3,187      8,295 |    11,482 
           |     27.76      72.24 |    100.00 
-----------+----------------------+----------
     Total |     9,875     16,944 |    26,819 
           |     36.82      63.18 |    100.00 
*/


merge 1:1 TaxQuarter DealerTIN using "F:\2a2b_analysis\MatchAnalysis\MatchPurchaseAllQuarters.dta", generate(_merge_purchases)
drop if _merge_purchases==2
rename AvgMatch PurchasesAvgMatch

tab Treat _merge_purchases if TaxQuarter==17, row
/*
----------------+
| Key            |
|----------------|
|   frequency    |
| row percentage |
+----------------+

           |   _merge_purchases
     Treat | master on  matched ( |     Total
-----------+----------------------+----------
         0 |     3,270     12,067 |    15,337 
           |     21.32      78.68 |    100.00 
-----------+----------------------+----------
         1 |     3,804      7,678 |    11,482 
           |     33.13      66.87 |    100.00 
-----------+----------------------+----------
     Total |     7,074     19,745 |    26,819 
           |     26.38      73.62 |    100.00 

*/



merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\BogusIdentifiedFromOnlineGovernment.dta", generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if Bogus=="YES"

merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\Bogus_CancellationData_NotPresentInT20.dta", generate(_merge_bogus)
gen BogusDummy=0
replace BogusDummy=1 if _merge_bogus==3


merge 1:1 DealerTIN TaxQuarter using "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_AllQuarters.dta", keepusing(RegisteredSalesTax OverallTaxAmount UnregisteredSalesTax) generate(_merge_registeredsales)
drop if _merge_registeredsales==2

replace RegisteredSalesTax=RegisteredSalesTax/1000000
replace UnregisteredSalesTax=UnregisteredSalesTax/1000000
replace UnregisteredSalesTax=OutputTaxBeforeAdjustment if _merge_registeredsales==1&TaxQuarter>8
replace RegisteredSalesTax=0 if _merge_registeredsales==1&TaxQuarter>8
gen UnTaxProp=UnregisteredSalesTax/OutputTaxBeforeAdjustment
gen RTaxProp=RegisteredSalesTax/OutputTaxBeforeAdjustment


//Looking at Avg Match at the quantile level


#delimit ;
preserve;
collapse (mean) UnTaxProp RTaxProp, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected UnTaxProp TaxQuarter if TreatGroup==9) (connected UnTaxProp TaxQuarter if TreatGroup==10) 
       (connected UnTaxProp TaxQuarter if ControlGroup==9) (connected UnTaxProp TaxQuarter if ControlGroup==10) 
       if TaxQuarter>8, legend(order(1 "9th decile (wholesalers)" 2 "10th decile (wholesalers)" 3 "9th decile (retailers)" 4 "10th decile (retailers)"  ));
    restore;


#delimit ;
preserve;
collapse (sum) OutputTaxBeforeAdjustment RegisteredSalesTax UnregisteredSalesTax, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected OutputTaxBeforeAdjustment TaxQuarter if TreatGroup==100) (connected RegisteredSalesTax TaxQuarter if TreatGroup==100) (connected UnregisteredSalesTax TaxQuarter if TreatGroup==100); 
//       (connected OutputTaxBeforeAdjustment TaxQuarter if ControlGroup==100) (connected RegisteredSalesTax TaxQuarter if ControlGroup==100) (connected UnregisteredSalesTax TaxQuarter if ControlGroup==100);
    restore;	
	
	
	
#delimit ;
preserve;
collapse (mean) UnTaxProp RTaxProp, by (TaxQuarter Treat);
twoway (connected UnTaxProp TaxQuarter if Treat==1) (connected UnTaxProp TaxQuarter if Treat==0) 
       (connected RTaxProp TaxQuarter if Treat==1) (connected RTaxProp TaxQuarter if Treat==0)
       if TaxQuarter>8, legend(order(1 "Unregistered firms by wholesalers" 2 "Unregistered firms by retailers" 
	   3 "Registered firms by wholesalers" 4 "Registered firms by Retailers")) 
	   title("Proportion of sales by Retailers and Wholesalers");
    restore;

	
#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected PurchasesAvgMatch TaxQuarter if TreatGroup==9) (connected PurchasesAvgMatch TaxQuarter if TreatGroup==10) 
       (connected PurchasesAvgMatch TaxQuarter if ControlGroup==9) (connected PurchasesAvgMatch TaxQuarter if ControlGroup==10) 
       if TaxQuarter>8, legend(order(1 "9th decile (wholesalers)" 2 "10th decile (wholesalers)" 3 "9th decile (retailers)" 4 "10th decile (retailers)"  ));
    restore;

	
#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected SalesAvgMatch TaxQuarter if TreatGroup==9) (connected SalesAvgMatch TaxQuarter if TreatGroup==10) 
       (connected SalesAvgMatch TaxQuarter if ControlGroup==9) (connected SalesAvgMatch TaxQuarter if ControlGroup==10) 
       if TaxQuarter>8, legend(order(1 "9th decile (wholesalers)" 2 "10th decile (wholesalers)" 3 "9th decile (retailers)" 4 "10th decile (retailers)"  ));
    restore;
	

#delimit ;
preserve;
drop if RTaxProp>1000&RTaxProp!=.;
collapse (mean) UnTaxProp RTaxProp, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected RTaxProp TaxQuarter if TreatGroup==100) (connected RTaxProp TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected RTaxProp TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected RTaxProp TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Proportion of sales made to registered firms") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white));
    restore;	

#delimit ;
preserve;
drop if UnTaxProp>5&ControlGroup==100&TaxQuarter==16;	
collapse (mean) UnTaxProp RTaxProp, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected UnTaxProp TaxQuarter if TreatGroup==100) (connected UnTaxProp TaxQuarter if TreatGroup==90, lpattern(dash)) 
	   (connected UnTaxProp TaxQuarter if ControlGroup==100) (connected UnTaxProp TaxQuarter if ControlGroup==90) 
       if TaxQuarter>8, legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)"  ));
    restore;	

#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected PurchasesNameAvgMatch TaxQuarter if TreatGroup==100) (connected PurchasesNameAvgMatch TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected PurchasesNameAvgMatch TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected PurchasesNameAvgMatch TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Mean of purchases matching with sales") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white)) ytitle("");
restore;	


#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected PurchasesAvgMatch TaxQuarter if TreatGroup==100) (connected PurchasesAvgMatch TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected PurchasesAvgMatch TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected PurchasesAvgMatch TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Mean of purchases matching with sales") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white)) ytitle("")
	   note("Match is 1 if difference is less than 5 rupees");
restore;	


#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected PurchasesAvgMatch3 TaxQuarter if TreatGroup==100) (connected PurchasesAvgMatch3 TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected PurchasesAvgMatch3 TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected PurchasesAvgMatch3 TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Mean of purchases matching with sales") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white)) ytitle("")
	   note("Match is 1 if difference is less than 1%");
restore;	


#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected SalesNameAvgMatch TaxQuarter if TreatGroup==100) (connected SalesNameAvgMatch TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected SalesNameAvgMatch TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected SalesNameAvgMatch TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Mean of sales matching with purchases") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white)) ytitle("")
	   note("Match is 1 if firm-ids match");
restore;	



#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected SalesAvgMatch TaxQuarter if TreatGroup==100) (connected SalesAvgMatch TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected SalesAvgMatch TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected SalesAvgMatch TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Mean of sales matching with purchases") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white)) ytitle("")
	   note("Match is 1 if difference is less than 5 rupees");
restore;	



#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected SalesAvgMatch3 TaxQuarter if TreatGroup==100) (connected SalesAvgMatch3 TaxQuarter if TreatGroup==91, lpattern(dash)) 
	   (connected SalesAvgMatch3 TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected SalesAvgMatch3 TaxQuarter if ControlGroup==91, lpattern(dash_3dot)) 
       if TaxQuarter>8, title("Mean of sales matching with purchases") legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)" 3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white)) ytitle("")
	   note("Match is 1 if difference is less than 1 percent");
restore;	


#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch PurchasesAvgMatch3 SalesAvgMatch3 PurchasesNameAvgMatch SalesNameAvgMatch, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected PurchasesNameAvgMatch TaxQuarter if TreatGroup==100) (connected PurchasesAvgMatch3 TaxQuarter if TreatGroup==100, lpattern(dash)) (connected PurchasesAvgMatch TaxQuarter if TreatGroup==100, lpattern(dash)) 
	   (connected PurchasesNameAvgMatch TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected PurchasesAvgMatch3 TaxQuarter if ControlGroup==100, lpattern(dash_3dot)) (connected PurchasesAvgMatch TaxQuarter if ControlGroup==100, lpattern(dash_3dot))
       if TaxQuarter>8, title("Mean of purchases matching with sales (at the firm level)") graphregion(color(white)) ytitle("");
restore;	


#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch, by (TaxQuarter Treat);
twoway (connected PurchasesAvgMatch TaxQuarter if Treat==1) 
       (connected PurchasesAvgMatch TaxQuarter if Treat==0) if TaxQuarter>8,
	   legend(order(1 "WholeSalers" 2 "Retailers")) title("Matching Ratios on the Purchase side");
    restore;
	
	#delimit ;
preserve;
collapse (mean) PurchasesAvgMatch SalesAvgMatch, by (TaxQuarter Treat);
twoway (connected SalesAvgMatch TaxQuarter if Treat==1) 
       (connected SalesAvgMatch TaxQuarter if Treat==0) if TaxQuarter>8,
	   legend(order(1 "WholeSalers" 2 "Retailers")) title("Matching Ratios on the Sales side") 
	   note("Firm level proportion of sales entries matching with corresponding purchase entries") ytitle("");
    restore;

	
preserve
#delimit ;
collapse (mean) SalesAvgMatch PurchasesAvgMatch (p90) p90SalesAvgMatch=SalesAvgMatch p90PurchasesAvgMatch=PurchasesAvgMatch
    (p80) p80SalesAvgMatch=SalesAvgMatch p80PurchasesAvgMatch=PurchasesAvgMatch
	(p99) p99SalesAvgMatch=SalesAvgMatch p99PurchasesAvgMatch=PurchasesAvgMatch
	(p50) p50SalesAvgMatch=SalesAvgMatch p50PurchasesAvgMatch=PurchasesAvgMatch
    , by(TaxQuarter Treat);
twoway (connected p99SalesAvgMatch TaxQuarter if Treat==0) (connected p99SalesAvgMatch TaxQuarter if Treat==1) 
       (connected p99PurchasesAvgMatch TaxQuarter if Treat==0) (connected p99PurchasesAvgMatch TaxQuarter if Treat==1) 
        if TaxQuarter>8;
restore;


//Revisions analysis
merge 1:1 DealerTIN TaxQuarter using "F:\2a2b_analysis\RevisionAnalysis\QuarterlyRevisions.dta", keepusing(TotalRevisionCount) generate(_merge_revisions)
keep if _merge_revisions==3

#delimit ;
preserve;
collapse (mean) TotalRevisionCount, by (TaxQuarter TreatGroup ControlGroup);
twoway (connected TotalRevisionCount TaxQuarter if TreatGroup==100) (connected TotalRevisionCount TaxQuarter if TreatGroup==90, lpattern(dash))   
       (connected TotalRevisionCount TaxQuarter if ControlGroup==100, lpattern(dash_dot)) (connected TotalRevisionCount TaxQuarter if ControlGroup==90, lpattern(dash_3dot)), 
	   legend(order(1 "99th percentile (wholesalers)" 2 "90th percentile (wholesalers)"  3 "99th percentile (retailers)" 4 "90th percentile (retailers)" )) graphregion(color(white));
  restore;


graph bar (mean) RTaxProp if TreatGroup==200, by(TaxQuarter)
graph bar (mean) RTaxProp if TreatGroup==200, over(TaxQuarter)
graph bar (mean) RTaxProp if TreatGroup==200, over(TaxQuarter) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup==200&TaxQuarter>8, over(TaxQuarter) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup==200&TaxQuarter>8, over(TaxQuarter, label(nolabel)) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup==200&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup==190&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup==180&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup==160&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup>198&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup>198&TreatGroup!=.&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if ControlGroup>198&ControlGroup!=.&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if ControlGroup<198&ControlGroup!=.&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if ControlGroup>198&ControlGroup!=.&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup>198&TreatGroup!=.&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup<198&TreatGroup!=.&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup<198&TreatGroup>180&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) RTaxProp if TreatGroup<181&TreatGroup>160&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) SalesAvgMatch (mean) PurchasesAvgMatch if TreatGroup<181&TreatGroup>160&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) SalesAvgMatch (mean) PurchasesAvgMatch if TreatGroup<201&TreatGroup>198&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) SalesAvgMatch (mean) PurchasesAvgMatch if TreatGroup<199&TreatGroup>180&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
graph bar (mean) SalesAvgMatch (mean) PurchasesAvgMatch if TreatGroup<181&TreatGroup>160&TaxQuarter>8, over(TaxQuarter, label(angle(vertical))) blabel(bar)
  
  

//Audit Notice analysis
merge 1:1 DealerTIN TaxQuarter using "F:\2a2b_analysis\AuditNoticesQuarterly.dta", keepusing(AuditDate) generate(_merge_audit)


/*
. tab TaxQuarter TreatGroup if _merge_audit==3&Treat==1, row

+----------------+
| Key            |
|----------------|
|   frequency    |
| row percentage |
+----------------+

            |                       TreatGroup
 TaxQuarter |         1          7          8          9         10 |     Total
------------+-------------------------------------------------------+----------
Q2, 2013-14 |     1,002         28        105        187        147 |     1,469 
            |     68.21       1.91       7.15      12.73      10.01 |    100.00 
------------+-------------------------------------------------------+----------
Q3, 2013-14 |        74          3         12         19         19 |       127 
            |     58.27       2.36       9.45      14.96      14.96 |    100.00 
------------+-------------------------------------------------------+----------
Q4, 2013-14 |        13          4          5          5         21 |        48 
            |     27.08       8.33      10.42      10.42      43.75 |    100.00 
------------+-------------------------------------------------------+----------
Q1, 2014-15 |        19          3          3          4          5 |        34 
            |     55.88       8.82       8.82      11.76      14.71 |    100.00 
------------+-------------------------------------------------------+----------
Q2, 2014-15 |        37          0          5          6         16 |        64 
            |     57.81       0.00       7.81       9.38      25.00 |    100.00 
------------+-------------------------------------------------------+----------
Q3, 2014-15 |        41          2          7          6         14 |        70 
            |     58.57       2.86      10.00       8.57      20.00 |    100.00 
------------+-------------------------------------------------------+----------
Q4, 2014-15 |         1          0          0          3          3 |         7 
            |     14.29       0.00       0.00      42.86      42.86 |    100.00 
------------+-------------------------------------------------------+----------
      Total |     1,187         40        137        230        225 |     1,819 
            |     65.26       2.20       7.53      12.64      12.37 |    100.00 


. tab TaxQuarter ControlGroup if _merge_audit==3&Treat==0, row

+----------------+
| Key            |
|----------------|
|   frequency    |
| row percentage |
+----------------+

            |                           ControlGroup
 TaxQuarter |         1          6          7          8          9         10 |     Total
------------+------------------------------------------------------------------+----------
Q2, 2013-14 |     1,423          0         55         97        257        323 |     2,155 
            |     66.03       0.00       2.55       4.50      11.93      14.99 |    100.00 
------------+------------------------------------------------------------------+----------
Q3, 2013-14 |       156          0          2         15         38         40 |       251 
            |     62.15       0.00       0.80       5.98      15.14      15.94 |    100.00 
------------+------------------------------------------------------------------+----------
Q4, 2013-14 |        50          1          7         13         20         25 |       116 
            |     43.10       0.86       6.03      11.21      17.24      21.55 |    100.00 
------------+------------------------------------------------------------------+----------
Q1, 2014-15 |        12          0          3          3          5          9 |        32 
            |     37.50       0.00       9.38       9.38      15.63      28.13 |    100.00 
------------+------------------------------------------------------------------+----------
Q2, 2014-15 |        68          0          1          4         10         26 |       109 
            |     62.39       0.00       0.92       3.67       9.17      23.85 |    100.00 
------------+------------------------------------------------------------------+----------
Q3, 2014-15 |        16          1          0          3          2         14 |        36 
            |     44.44       2.78       0.00       8.33       5.56      38.89 |    100.00 
------------+------------------------------------------------------------------+----------
Q4, 2014-15 |         8          0          0          0          1          5 |        14 
            |     57.14       0.00       0.00       0.00       7.14      35.71 |    100.00 
------------+------------------------------------------------------------------+----------
      Total |     1,733          2         68        135        333        442 |     2,713 
            |     63.88       0.07       2.51       4.98      12.27      16.29 |    100.00 

*/
	
	
