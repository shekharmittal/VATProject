
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

//gen PositiveContribution=0
//replace PositiveContribution=1 if MoneyDeposited>0


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


collapse (firstnm) WardName (sum)AdjustCSTLiability RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxQuarter)
drop if TaxQuarter==0


gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N
by DealerTIN: gen YearCount=_n

keep if TotalCount==20

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
gen Diff=OutputTaxBeforeAdjustment-TaxCreditBeforeAdjustment



merge m:1 DealerTIN using "E:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax) 
keep if _merge==1|_merge==3


gen DummyRetailer = 0
gen DummyWholeSaler = 0 
gen DummyManufacturer = 0


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



replace DummyManufacturer = 1 if(regexm(Nature, "Manufacturer"))
replace DummyManufacturer = 1 if(regexm(Nature, "Manufecturer"))
replace DummyManufacturer = 1 if(regexm(Nature, "Manufacturing"))
replace DummyManufacturer = 1 if(regexm(Nature, "MANUFACTURER"))


gen Treat=0 if DummyRetailer==1&DummyWholeSaler==0&DummyManufacturer==0
replace Treat=1 if DummyRetailer==0&DummyWholeSaler==1&DummyManufacturer==0

xtile group1=MoneyDeposited if Treat==1&TaxQuarter==1 , nq(10) 
xtile group2=MoneyDeposited if Treat==1&TaxQuarter==2 , nq(10) 
xtile group3=MoneyDeposited if Treat==1&TaxQuarter==3 , nq(10) 
xtile group4=MoneyDeposited if Treat==1&TaxQuarter==4 , nq(10)
xtile group5=MoneyDeposited if Treat==1&TaxQuarter==5 , nq(10) 
xtile group6=MoneyDeposited if Treat==1&TaxQuarter==6 , nq(10) 
xtile group7=MoneyDeposited if Treat==1&TaxQuarter==7 , nq(10) 
xtile group8=MoneyDeposited if Treat==1&TaxQuarter==8 , nq(10) 
xtile group9=MoneyDeposited if Treat==1&TaxQuarter==9 , nq(10) 
xtile group10=MoneyDeposited if Treat==1&TaxQuarter==10 , nq(10) 
xtile group11=MoneyDeposited if Treat==1&TaxQuarter==11 , nq(10) 
xtile group12=MoneyDeposited if Treat==1&TaxQuarter==12 , nq(10) 
xtile group13=MoneyDeposited if Treat==1&TaxQuarter==13 , nq(10) 
xtile group14=MoneyDeposited if Treat==1&TaxQuarter==14 , nq(10) 
xtile group15=MoneyDeposited if Treat==1&TaxQuarter==15 , nq(10) 
xtile group16=MoneyDeposited if Treat==1&TaxQuarter==16 , nq(10) 
xtile group17=MoneyDeposited if Treat==1&TaxQuarter==17 , nq(10) 
xtile group18=MoneyDeposited if Treat==1&TaxQuarter==18 , nq(10) 
xtile group19=MoneyDeposited if Treat==1&TaxQuarter==19 , nq(10) 
xtile group20=MoneyDeposited if Treat==1&TaxQuarter==20 , nq(10) 


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

xtile group1=MoneyDeposited if Treat==0&TaxQuarter==1 , nq(10) 
xtile group2=MoneyDeposited if Treat==0&TaxQuarter==2 , nq(10) 
xtile group3=MoneyDeposited if Treat==0&TaxQuarter==3 , nq(10) 
xtile group4=MoneyDeposited if Treat==0&TaxQuarter==4 , nq(10)
xtile group5=MoneyDeposited if Treat==0&TaxQuarter==5 , nq(10) 
xtile group6=MoneyDeposited if Treat==0&TaxQuarter==6 , nq(10) 
xtile group7=MoneyDeposited if Treat==0&TaxQuarter==7 , nq(10) 
xtile group8=MoneyDeposited if Treat==0&TaxQuarter==8 , nq(10) 
xtile group9=MoneyDeposited if Treat==0&TaxQuarter==9 , nq(10) 
xtile group10=MoneyDeposited if Treat==0&TaxQuarter==10 , nq(10) 
xtile group11=MoneyDeposited if Treat==0&TaxQuarter==11 , nq(10) 
xtile group12=MoneyDeposited if Treat==0&TaxQuarter==12 , nq(10) 
xtile group13=MoneyDeposited if Treat==0&TaxQuarter==13 , nq(10) 
xtile group14=MoneyDeposited if Treat==0&TaxQuarter==14 , nq(10) 
xtile group15=MoneyDeposited if Treat==0&TaxQuarter==15 , nq(10) 
xtile group16=MoneyDeposited if Treat==0&TaxQuarter==16 , nq(10) 
xtile group17=MoneyDeposited if Treat==0&TaxQuarter==17 , nq(10) 
xtile group18=MoneyDeposited if Treat==0&TaxQuarter==18 , nq(10) 
xtile group19=MoneyDeposited if Treat==0&TaxQuarter==19 , nq(10) 
xtile group20=MoneyDeposited if Treat==0&TaxQuarter==20 , nq(10) 

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
//Regression of the bottom 80% of the firms
gen Treat2=1 if Treat==1&TreatGroup==10&TaxQuarter==1
replace Treat2=0 if Treat==0&ControlGroup==10&TaxQuarter==1

gsort DealerTIN TaxQuarter
by DealerTIN: replace Treat2=Treat2[_n-1] if Treat2>=.

keep if Treat2!=.

drop Treat 
rename Treat2 Treat


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

destring DealerTIN, replace
xtset DealerTIN TaxQuarter


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

label variable iTreatT1 "-8"
label variable iTreatT2 "-7"
label variable iTreatT3 "-6"
label variable iTreatT4 "-5"
label variable iTreatT5 "-4"
label variable iTreatT6 "-3"
label variable iTreatT7 "-2"
label variable iTreatT8 "-1"
label variable iTreatT9 "0"
label variable iTreatT10 "+1"
label variable iTreatT11 "+2"
label variable iTreatT12 "+3"
label variable iTreatT13 "+4"
label variable iTreatT14 "+5"
label variable iTreatT15 "+6"
label variable iTreatT16 "+7"
label variable iTreatT17 "+8"
label variable iTreatT18 "+9"
label variable iTreatT19 "+10"
label variable iTreatT20 "+11"


matrix C = J(3,20,.)
matrix rownames C = mean ll95 ul95
matrix colnames C = iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT8 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20

matrix C[1,8]=0 
matrix C[2,8]=0 
matrix C[3,8]=0 




#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg PositiveContribution `TaxQuarterDummy' `TreatDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		  xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for VAT Deposited>0") 
         note( "Number of retailers is 15337 and number of wholesalers is 11482.""Treatment is a continous variable, proportion of sales made to registered firms in the quarter in which the policy was introduced");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\PositiveContribution_TopDecile.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\PositiveContribution_TopDecile.pdf", as(pdf) replace;


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg MoneyDeposited `TaxQuarterDummy' `TreatDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		 xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for VAT Deposited") 
         note( "Number of retailers is 15337 and number of wholesalers is 11482.""Treatment is a continous variable, proportion of sales made to registered firms in the quarter in which the policy was introduced");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\VATDeposited_TopDecile.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\VATDeposited_TopDecile.pdf", as(pdf) replace;


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg TaxCreditBeforeAdjustment `TaxQuarterDummy' `TreatDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		 xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for TaxCredits") 
         note( "Number of retailers is 15337 and number of wholesalers is 11482.""Treatment is a continous variable, proportion of sales made to registered firms in the quarter in which the policy was introduced");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\TaxCreditBeforeAdjustment_TopDecile.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\TaxCreditBeforeAdjustment_TopDecile.pdf", as(pdf) replace;


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg OutputTaxBeforeAdjustment `TaxQuarterDummy' `TreatDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		 xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for OutputTax") 
         note( "Number of retailers is 15337 and number of wholesalers is 11482.""Treatment is a continous variable, proportion of sales made to registered firms in the quarter in which the policy was introduced");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\OutputTaxBeforeAdjustment_TopDecile.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\OutputTaxBeforeAdjustment_TopDecile.pdf", as(pdf) replace;



#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg Diff `TaxQuarterDummy' `TreatDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.645*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.645*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		 xtitle("Quarters with respect to the introduction of the policy")
title("Coefficient for OutputTax-InputCredit ")
         note( "Number of retailers is 15337 and number of wholesalers is 11482.""Treatment is a continous variable, proportion of sales made to registered firms in the quarter in which the policy was introduced");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\Diff_TopDecile.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\Diff_TopDecile.pdf", as(pdf) replace;
