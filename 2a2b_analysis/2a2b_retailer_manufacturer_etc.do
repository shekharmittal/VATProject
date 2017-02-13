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


collapse (firstnm) WardName (sum) RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)

gen dummy=1

gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gen AllCentral=0
replace AllCentral=1 if TurnoverGross==TurnoverCentral&TurnoverGross!=0

gen AllLocal=0
replace AllLocal=1 if TurnoverCentral==0&TurnoverGross!=0


/* All firms
list MoneyDeposited dummy PositiveContribution ZeroTurnover AllCentral AllLocal  TaxYear

     +-------------------------------------------------------------------------+
     | MoneyD~d    dummy   Positi~n   ZeroTu~r   AllCen~l   AllLocal   TaxYear |
     |-------------------------------------------------------------------------|
  1. | 106330.3   192664   .5088133    .071046   .0903334   .3126324   2010-11 |
  2. |   121783   205832    .487174   .0950532   .0771503   .3139696   2011-12 |
  3. | 136310.4   250805   .4756803   .1505233   .0593569    .316772   2012-13 |
  4. | 148579.1   262775   .4969537     .13679   .0570146   .3269261   2013-14 |
  5. | 158777.2   271090   .5360102   .1397506   .0600354   .3264304   2014-15 |
     +-------------------------------------------------------------------------+
*/

//keep if TotalCount==5

/* Always present firms

. list MoneyDeposited dummy PositiveContribution ZeroTurnover AllCentral AllLocal  TaxYear

     +-------------------------------------------------------------------------+
     | MoneyD~d    dummy   Positi~n   ZeroTu~r   AllCen~l   AllLocal   TaxYear |
     |-------------------------------------------------------------------------|
  1. | 102024.5   148434    .546007   .0250077    .069701   .3075508   2010-11 |
  2. | 116489.3   148434   .5408801   .0308689   .0595484   .3113774   2011-12 |
  3. | 128810.6   148434   .5719714   .0388321    .053384   .3060889   2012-13 |
  4. | 136801.3   148434    .575003    .053512   .0517941   .3045394   2013-14 |
  5. | 142092.1   148434   .6049221   .0849536   .0522118   .2974251   2014-15 |
     +-------------------------------------------------------------------------+

	 
*/


//collapse (mean) ZeroTurnover PositiveContribution AllCentral AllLocal (count) dummy (sum) RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxYear)






//collapse (sum) RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxQuarter)
/*
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
*/

gen Dummy=1

gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverLocal=log(TurnoverLocal)
gen lTurnoverCentral=log(TurnoverCentral)


gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))

gsort DealerTIN TaxYear
by DealerTIN: gen TotalCount=_N
by DealerTIN: gen YearCount=_n
gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

by DealerTIN: gen DeltaCredit=TaxCreditBeforeAdjustment - TaxCreditBeforeAdjustment[_n-1]
by DealerTIN: gen CreditGrowth=DeltaCredit/TaxCreditBeforeAdjustment[_n-1]

by DealerTIN: gen DeltaOutputTax=OutputTaxBeforeAdjustment - OutputTaxBeforeAdjustment[_n-1]
by DealerTIN: gen OutputGrowth=DeltaOutputTax/OutputTaxBeforeAdjustment[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.

gen CreditIncrease=0 if DeltaCredit!=.
replace CreditIncrease=1 if DeltaCredit>0&DeltaCredit!=.

gen OutputIncrease=0 if DeltaOutputTax!=.
replace OutputIncrease=1 if DeltaOutputTax>0&DeltaOutputTax!=.


//Lorenz Curve
drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover
glcurve MoneyDeposited if TaxYear==1,gl(gMoney) p(pMoney) nograph lorenz
glcurve TurnoverGross if TaxYear==1,gl(gTurnoverGross) p(pTurnoverGross) nograph lorenz
glcurve PositiveTurnover if TaxYear==1,gl(gPositiveTurnover) p(pPositiveTurnover) nograph lorenz
glcurve PositiveContribution if TaxYear==1,gl(gPositiveContribution) p(pPositiveContribution) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==1, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 1)")

drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover gTurnoverGross pTurnoverGross
glcurve MoneyDeposited if TaxYear==5,gl(gMoney) p(pMoney) nograph lorenz
glcurve TurnoverGross if TaxYear==5,gl(gTurnoverGross) p(pTurnoverGross) nograph lorenz
glcurve PositiveTurnover if TaxYear==5,gl(gPositiveTurnover) p(pPositiveTurnover) nograph lorenz
glcurve PositiveContribution if TaxYear==5,gl(gPositiveContribution) p(pPositiveContribution) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==5, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 5)")




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

/*
replace DummyInterStateSeller = 1 if(regexm(Nature, "Interstate Seller"))
replace DummyInterStateSeller = 1 if(regexm(Nature, "INTERSTATE PURCHASER AND SELLER"))
replace DummyInterStateSeller = 1 if(regexm(Nature, "INTERSTATE SALE/PURCHASE"))
replace DummyInterStateSeller = 1 if(regexm(Nature, "INTERSTATE SELLER AND PURCHASER"))
replace DummyInterStateSeller = 1 if(regexm(Nature, "INTERSTATE SELLER"))
replace DummyInterStateSeller = 1 if(regexm(Nature, "Inter State Seller"))

replace DummyInterStatePurchaser = 1 if(regexm(Nature, "Interstate Purchaser"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "INTERSTATE SALE/PURCHASE"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "INTERSTATE SELLER AND PURCHASER"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "INTERSTATE PURCHASER"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "INTERSTATE PURCHASER AND SELLER"))
replace DummyInterStatePurchaser = 1 if(regexm(Nature, "Inter State Purchaser"))



replace DummyWorkContractor = 1 if(regexm(Nature, "Work Contractor"))
replace DummyWorkContractor = 1 if(regexm(Nature, "WORK CONTRACTOR"))
replace DummyWorkContractor = 1 if(regexm(Nature, "WORKCONTRACT"))
replace DummyWorkContractor = 1 if(regexm(Nature, "WORK CONTRACT"))
replace DummyWorkContractor = 1 if(regexm(Nature, "CONTRACTOR"))
replace DummyWorkContractor = 1 if(regexm(Nature, "Contractor"))

replace DummyOther = 1 if(regexm(Nature, "Other"))
replace DummyOther = 1 if(regexm(Nature, "OTHER"))

replace DummyImporter = 1 if(regexm(Nature, "Importer"))
replace DummyImporter = 1 if(regexm(Nature, "IMPORTER/EXPORTER"))
replace DummyImporter = 1 if(regexm(Nature, "IMPORTER"))

replace DummyExporter = 1 if(regexm(Nature, "Exporter"))
replace DummyExporter = 1 if(regexm(Nature, "EXPORTER"))

replace DummyHotel = 1 if(regexm(Nature, "Restaurent"))
replace DummyHotel = 1 if(regexm(Nature, "RESTURANT"))
replace DummyHotel = 1 if(regexm(Nature, "HOTEL"))
replace DummyHotel = 1 if(regexm(Nature, "RESTAURENT"))
replace DummyHotel = 1 if(regexm(Nature, "RESTAURANT"))
replace DummyHotel = 1 if(regexm(Nature, "RESTURENT"))
replace DummyHotel = 1 if(regexm(Nature, "CATERING"))
replace DummyHotel = 1 if(regexm(Nature, "Restaurant"))
replace DummyHotel = 1 if(regexm(Nature, "HOTELS"))
replace DummyHotel = 1 if(regexm(Nature, "CANTEENS"))
replace DummyHotel = 1 if(regexm(Nature, "Banquet"))
replace DummyHotel = 1 if(regexm(Nature, "Catering"))
replace DummyHotel = 1 if(regexm(Nature, "BANQUET"))
replace DummyHotel = 1 if(regexm(Nature, "Banquet"))
replace DummyHotel = 1 if(regexm(Nature, "RESTURAENT"))
replace DummyHotel = 1 if(regexm(Nature, "COFFEE SHOP"))
replace DummyHotel = 1 if(regexm(Nature, "RESTURAENT"))
replace DummyHotel = 1 if(regexm(Nature, "hotel industry"))
replace DummyHotel = 1 if(regexm(Nature, "CATERERS"))

replace DummyECommerce = 1 if(regexm(Nature, "E COMMERCE"))
replace DummyECommerce = 1 if(regexm(Nature, "Online Seller"))
replace DummyECommerce = 1 if(regexm(Nature, "Online Trading"))
replace DummyECommerce = 1 if(regexm(Nature, "ONLINE TRADING"))
replace DummyECommerce = 1 if(regexm(Nature, "E Commerce"))
replace DummyECommerce = 1 if(regexm(Nature, "Ecommerce"))
replace DummyECommerce = 1 if(regexm(Nature, "Website Retailing"))
replace DummyECommerce = 1 if(regexm(Nature, "E Commerece"))
replace DummyECommerce = 1 if(regexm(Nature, "ECOMMERCE"))
replace DummyECommerce = 1 if(regexm(Nature, "ONLINE SHOPPING"))


gen DummyTelecom=0
replace DummyTelecom=1 if (regexm(Nature, "Telecom"))
replace DummyTelecom=1 if (regexm(Nature, "TELECOM"))
replace DummyTelecom=1 if (regexm(Nature, "DTH SERVICE"))
replace DummyTelecom=1 if (regexm(Nature, "Internet Service Provider"))



gen Government=.
replace Government=1 if Constitution=="Government Company"
replace Government=1 if Constitution=="Government Corporation"
replace Government=1 if Constitution=="Government Department"
replace Government=1 if Constitution=="Public Sector UnderTaking"


replace Government=0 if Constitution=="HUF"
replace Government=0 if Constitution=="Partnership"
replace Government=0 if Constitution=="Private Ltd. Company"
replace Government=0 if Constitution=="Proprietorship"

replace Government=2 if Constitution=="Public Ltd. Company"

*/
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

gen Treat=0 if DummyRetailer==1&DummyWholeSaler==0&DummyManufacturer==0
replace Treat=1 if DummyRetailer==0&DummyWholeSaler==1&DummyManufacturer==0
replace Treat=2 if DummyRetailer==0&DummyWholeSaler==0&DummyManufacturer==1



gen Treat=0 if DummyRetailer==1&DummyWholeSaler==0&DummyManufacturer==0
replace Treat=1 if DummyRetailer==0&DummyWholeSaler==0&DummyManufacturer==1


drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover gTurnoverGross pTurnoverGross
glcurve MoneyDeposited if TaxYear==5,gl(gMoney) p(pMoney) nograph lorenz
glcurve TurnoverGross if TaxYear==5,gl(gTurnoverGross) p(pTurnoverGross) nograph lorenz
glcurve PositiveTurnover if TaxYear==5,gl(gPositiveTurnover) p(pPositiveTurnover) nograph lorenz
glcurve PositiveContribution if TaxYear==5,gl(gPositiveContribution) p(pPositiveContribution) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==5, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 5)")

preserve
drop if TotalCount!=5
drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover gTurnoverGross pTurnoverGross
glcurve MoneyDeposited if TaxYear==5&Treat==1,gl(gMoney) p(pMoney) by(Treat) nograph lorenz
glcurve TurnoverGross if TaxYear==5&Treat==1,gl(gTurnoverGross) p(pTurnoverGross) by(Treat) nograph lorenz
glcurve PositiveTurnover if TaxYear==5&Treat==1,gl(gPositiveTurnover) p(pPositiveTurnover) by(Treat) nograph lorenz
glcurve PositiveContribution if TaxYear==5&Treat==1,gl(gPositiveContribution) p(pPositiveContribution) by(Treat) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==5&Treat==1, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 5)")
restore

preserve
drop if TotalCount!=5
drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover gTurnoverGross pTurnoverGross
glcurve MoneyDeposited if TaxYear==1&Treat==1,gl(gMoney) p(pMoney) by(Treat) nograph lorenz
glcurve TurnoverGross if TaxYear==1&Treat==1,gl(gTurnoverGross) p(pTurnoverGross) by(Treat) nograph lorenz
glcurve PositiveTurnover if TaxYear==1&Treat==1,gl(gPositiveTurnover) p(pPositiveTurnover) by(Treat) nograph lorenz
glcurve PositiveContribution if TaxYear==1&Treat==1,gl(gPositiveContribution) p(pPositiveContribution) by(Treat) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==1&Treat==1, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 1)")
restore


preserve
drop if TotalCount!=5
drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover gTurnoverGross pTurnoverGross
glcurve MoneyDeposited if TaxYear==5&Treat==0,gl(gMoney) p(pMoney) by(Treat) nograph lorenz
glcurve TurnoverGross if TaxYear==5&Treat==0,gl(gTurnoverGross) p(pTurnoverGross) by(Treat) nograph lorenz
glcurve PositiveTurnover if TaxYear==5&Treat==0,gl(gPositiveTurnover) p(pPositiveTurnover) by(Treat) nograph lorenz
glcurve PositiveContribution if TaxYear==5&Treat==0,gl(gPositiveContribution) p(pPositiveContribution) by(Treat) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==5&Treat==0, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 5) Retailers")
restore

preserve
drop if TotalCount!=5
drop gMoney gPositiveContribution gPositiveTurnover pMoney pPositiveContribution pPositiveTurnover gTurnoverGross pTurnoverGross
glcurve MoneyDeposited if TaxYear==1&Treat==0,gl(gMoney) p(pMoney) by(Treat) nograph lorenz
glcurve TurnoverGross if TaxYear==1&Treat==0,gl(gTurnoverGross) p(pTurnoverGross) by(Treat) nograph lorenz
glcurve PositiveTurnover if TaxYear==1&Treat==0,gl(gPositiveTurnover) p(pPositiveTurnover) by(Treat) nograph lorenz
glcurve PositiveContribution if TaxYear==1&Treat==0,gl(gPositiveContribution) p(pPositiveContribution) by(Treat) nograph lorenz
twoway (function y=x ,range(0 1))(line gMoney pMoney, sort lpattern(dash_3dot)) (line gTurnoverGross pTurnoverGross, sort lpattern(dash)) (line gPositiveContribution pPositiveContribution, sort lpattern(dash_dot)) if TaxYear==1&Treat==0, graphregion(color(white)) legend(order (1 "X=Y" 2 "MoneyDeposited" 3 "Turnover" 4 "Positive Contribution")) title("Lorenz Curve (Year 1) Retailers")
restore



preserve
keep if TotalCount==5
collapse (sum) MoneyDeposited (mean) AvgMoneyDeposited=MoneyDeposited (semean) SEMoneyDeposited=MoneyDeposited, by(TaxYear Treat)
gen LHS=AvgMoneyDeposited-1.96*SEMoneyDeposited
gen RHS=AvgMoneyDeposited+1.96*SEMoneyDeposited
twoway (connected AvgMoneyDeposited TaxYear if Treat==0) (connected LHS TaxYear if Treat==0) (connected RHS TaxYear if Treat==0) (connected AvgMoneyDeposited TaxYear if Treat==1) (connected LHS TaxYear if Treat==1) (connected RHS TaxYear if Treat==1), xline(2) legend (order(1 "Control Group" 4 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 140 and number of treatment firms is 362")
restore 

preserve
keep if TotalCount==5
collapse (mean) MoneyDeposited, by(TaxYear Treat)
twoway (connected MoneyDeposited TaxYear if Treat==0)  (connected MoneyDeposited TaxYear if Treat==1, lpattern(dash)), xline(2) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for PositiveContribution")  graphregion(color(white))
restore 


xtile group=CreditRatio, nq(200)
xtile CentralGroup=LocalCreditRatio, nq(200)


destring DealerTIN, replace
xtset DealerTIN TaxYear

*drop Post iPostTreat

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

gen iTreat1=Treat*iTaxYear1
gen iTreat2=Treat*iTaxYear2
gen iTreat3=Treat*iTaxYear3
gen iTreat4=Treat*iTaxYear4	
gen iTreat5=Treat*iTaxYear5

log using "F:\2a2b_analysis\RetailerVsWholeSaler\TimeDummyAnalysis.log"
xtreg MoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat2 iTreat3  iTreat4 iTreat5 if TotalCount==5, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat2 iTreat3  iTreat4 iTreat5 if TotalCount==5, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat2 iTreat3  iTreat4 iTreat5 if TotalCount==5, fe cluster(DealerTIN)
xtreg PositiveContribution iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat2 iTreat3  iTreat4 iTreat5 if TotalCount==5, fe cluster(DealerTIN)
log close

//Pretrend Analysis
{
gen iTreat1=Treat*iTaxYear1
gen iTreat2=Treat*iTaxYear2
gen iTreat3=Treat*iTaxYear3
gen iTreat4=Treat*iTaxYear4	
gen iTreat5=Treat*iTaxYear5

xtreg lMoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat1 iTreat2  iTreat4 iTreat5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Post",  tex append nocons  cttop(All firms)
xtreg lMoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat1 iTreat2  iTreat4 iTreat5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Post",  tex replace nocons cttop(Always present firms)

xtreg TaxCreditBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat* if TotalCount==5, fe cluster(DealerTIN)

xtreg OutputTaxBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat* if TotalCount==5, fe cluster(DealerTIN)

}

xtreg PositiveContribution Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg VatIncrease Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg ZeroTurnover Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg VatRatio Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg CreditRatio Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg TaxRatio Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)



xtreg PositiveContribution Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg VatIncrease Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg ZeroTurnover Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg VatRatio Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg CreditRatio Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg TaxRatio Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)



//TotalCount==5
//TreatAnalysis
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
//outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat",  tex replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
//outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
//outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat  iTaxYear3 iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
//outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear3 iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
//outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
//outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 

xtreg VatRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5&group!=200, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRatioRetailWholeSale_TotalCount5_Treat",  tex replace nocons keep(Post iPostTreat) addnote("dropping the 99.5% of CreditRatios")
xtreg CreditRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5&group!=200, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRatioRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5&group!=200, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRatioRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg LocalVatRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5&CentralGroup!=200, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRatioRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg LocalCreditRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5&CentralGroup!=200, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRatioRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg LocalTaxRatio Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5&CentralGroup!=200, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRatioRetailWholeSale_TotalCount5_Treat",  tex append nocons keep(Post iPostTreat) 


logout, save(F:\2a2b_analysis\RetailerVsWholeSaler\summary_total5_year1) tex replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TurnoverLocal TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio InterstateRatio if TaxYear==1&TotalCount==5, by(Treat)
logout, save(F:\2a2b_analysis\RetailerVsWholeSaler\summary_total5_year5) tex replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TurnoverLocal TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment VatRatio CreditRatio TaxRatio InterstateRatio if TaxYear==5&TotalCount==5, by(Treat)


graph bar (mean) CreditRatio TaxRatio VatRatio if TotalCount==5&Treat==1&group!=200, over(TaxYear)
graph bar (mean) CreditRatio TaxRatio VatRatio if TotalCount==5&Treat==0&group!=200, over(TaxYear)

graph bar (mean) TurnoverGross TurnoverLocal if TotalCount==5&Treat==1, over(TaxYear)
graph bar (mean) TurnoverGross TurnoverLocal if TotalCount==5&Treat==0, over(TaxYear)

graph bar (mean) TurnoverLocal if TotalCount==5&Treat==1, over(TaxYear)
graph bar (mean) TurnoverLocal if TotalCount==5&Treat==0, over(TaxYear)

graph bar (sum) MoneyDeposited TaxCreditBeforeAdjustment  OutputTaxBeforeAdjustment if TotalCount==5&Treat==1, over(TaxYear)

graph bar (sum) MoneyDeposited TaxCreditBeforeAdjustment  OutputTaxBeforeAdjustment if TotalCount==5&Treat==1, over(TaxYear) title ("Total for Wholesalers (in millions)") legend (order (1 "Vat Deposited" 2 "Credit Claimed" 3 "Output Tax Declared"))
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\Totals_WholeSalers.gph"
graph bar (sum) MoneyDeposited TaxCreditBeforeAdjustment  OutputTaxBeforeAdjustment if TotalCount==5&Treat==0, over(TaxYear) title ("Total for Retailers (in millions)") legend (order (1 "Vat Deposited" 2 "Credit Claimed" 3 "Output Tax Declared"))
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\Totals_Retailers.gph"
graph bar (sum) MoneyDeposited TaxCreditBeforeAdjustment  OutputTaxBeforeAdjustment if TotalCount==5&Treat==., over(TaxYear) title ("Total for Rest of the firms (in millions)") legend (order (1 "Vat Deposited" 2 "Credit Claimed" 3 "Output Tax Declared"))
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\Totals_OtherFirms.gph"


xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat_LOG",  tex replace nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat_LOG",  tex append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCount5_Treat_LOG",  tex append nocons keep(Post iPostTreat) 

log using "F:\2a2b_analysis\RetailerVsWholeSaler\QuantileRegressions_TotalCount5.log"
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.5)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.5)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.5)

qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.6)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.6)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.6)

qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.7)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.7)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.7)


qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.8)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.8)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.8)

qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.9)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.9)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.9)

qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.95)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.95)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 if TotalCount==5, q(.95)
log close


//All firms
//TreatAnalysis
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat",  tex replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat",  tex append nocons keep(Post iPostTreat) 


xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat_LOG",  tex replace nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat_LOG",  tex append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_ALL_Treat_LOG",  tex append nocons keep(Post iPostTreat) 

//TotalCount!=5
//TreatAnalysis
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount!=5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCountNOT5_Treat",  tex replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount!=5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCountNOT5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCountNOT5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCountNOT5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCountNOT5_Treat",  tex append nocons keep(Post iPostTreat) 
xtreg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount!=5, fe cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TotalCountNOT5_Treat",  tex append nocons keep(Post iPostTreat) 

save "Z:\2a2b_retailerwholesaler.dta"

use "Z:\2a2b_retailerwholesaler.dta", clear

drop if TotalCount!=5

collapse (mean)MoneyDeposited TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment TurnoverGross, by(TaxYear Treat)
/*
twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1) (connected MoneyDeposited TaxYear if Treat==2), legend(order (1 "Treatment Group" 2 "Control Group" 3 "Manufacturing")) xline(3) note("Control:solely retailer firms, Treatment:wholesaler firms. MoneyDeposited is in million rupees") 
graph save Graph "H:\2a2b_analysis\RetailerVsWholeSaler\MoneyDeposited_TotalCount5.gph"
twoway (connected TaxCreditBeforeAdjustment TaxYear if Treat==0) (connected TaxCreditBeforeAdjustment TaxYear if Treat==1)(connected TaxCreditBeforeAdjustment TaxYear if Treat==2), legend(order (1 "Treatment Group" 2 "Control Group" 3 "Manufacturing")) xline(3) note("Control:solely retailer firms, Treatment:wholesaler firms. TaxCredit is in million rupees") 
graph save Graph "H:\2a2b_analysis\RetailerVsWholeSaler\TaxCredit_TotalCount5.gph", replace
twoway (connected OutputTaxBeforeAdjustment TaxYear if Treat==0) (connected OutputTaxBeforeAdjustment TaxYear if Treat==1) (connected OutputTaxBeforeAdjustment TaxYear if Treat==2), legend(order (1 "Treatment Group" 2 "Control Group" 3 "Manufacturing")) xline(3) note("Control:solely retailer firms, Treatment:wholesaler firms. OutputTax is in million rupees") 
graph save Graph "H:\2a2b_analysis\RetailerVsWholeSaler\OutputTax_TotalCount5.gph", replace
*/

twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1), legend(order (2 "Treatment Group" 1 "Control Group")) xline(2) note("Control:solely retailer firms, Treatment:wholesaler firms. MoneyDeposited is in million rupees. Policy started after year 2") title("Average Money Deposited (in millions)") ytitle("")
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\MoneyDeposited_TotalCount5.gph", replace
twoway (connected TaxCreditBeforeAdjustment TaxYear if Treat==0) (connected TaxCreditBeforeAdjustment TaxYear if Treat==1), legend(order (2 "Treatment Group" 1 "Control Group")) xline(2) note("Control:solely retailer firms, Treatment:wholesaler firms. Tax Credit is in million rupees. Policy started after year 2") title("Average Credit Claimed (in millions)") ytitle("")
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\TaxCredit_TotalCount5.gph", replace
twoway (connected OutputTaxBeforeAdjustment TaxYear if Treat==0) (connected OutputTaxBeforeAdjustment TaxYear if Treat==1), legend(order (2 "Treatment Group" 1 "Control Group")) xline(2) note("Control:solely retailer firms, Treatment:wholesaler firms. Output Tax is in million rupees. Policy started after year 2") title("Average Output Tax Declared (in millions)") ytitle("")


preserve
collapse (sum)MoneyDeposited TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment TurnoverGross, by(TaxYear Treat)
twoway (connected MoneyDeposited TaxYear if Treat==1) (connected MoneyDeposited TaxYear if Treat==0), legend(order (1 "Treatment Group" 2 "Control Group" 3 "Manufacturing")) xline(3) note("Control:solely retailer firms, Treatment:wholesaler firms. MoneyDeposited is in million rupees") 
restore

graph save Graph "H:\2a2b_analysis\RetailerVsWholeSaler\MoneyDeposited_ALL.gph"
twoway (connected TaxCreditBeforeAdjustment TaxYear if Treat==0) (connected TaxCreditBeforeAdjustment TaxYear if Treat==1)(connected TaxCreditBeforeAdjustment TaxYear if Treat==2), legend(order (1 "Treatment Group" 2 "Control Group" 3 "Manufacturing")) xline(3) note("Control:solely retailer firms, Treatment:wholesaler firms. TaxCredit is in million rupees") 
graph save Graph "H:\2a2b_analysis\RetailerVsWholeSaler\TaxCredit_ALL.gph", replace
twoway (connected OutputTaxBeforeAdjustment TaxYear if Treat==0) (connected OutputTaxBeforeAdjustment TaxYear if Treat==1) (connected OutputTaxBeforeAdjustment TaxYear if Treat==2), legend(order (1 "Treatment Group" 2 "Control Group" 3 "Manufacturing")) xline(3) note("Control:solely retailer firms, Treatment:wholesaler firms. OutputTax is in million rupees") 
graph save Graph "H:\2a2b_analysis\RetailerVsWholeSaler\OutputTax_ALL.gph", replace



collapse AvgMatch (median) MidAvgMatch=AvgMatch, by(TaxQuarter Treat)
twoway (connected AvgMatch TaxQuarter if Treat==0)(connected AvgMatch TaxQuarter if Treat==1) (connected AvgMatch TaxQuarter if Treat==2), legend(on order(1 "Retailer" 2 "WholeSaler" 3 "Manufacturing")) title("Trends of Buyer and Seller Matches") note("Proportion calculated wrt purchases")

xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==0, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==1, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==0, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==1, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==0, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==1, fe cluster(DealerTIN)



local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  if TotalCount==5, q(.95)
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




/* Analysis of firms that exit vs firms that do not*/
gsort DealerTIN -TaxYear
gen Exit=1 if TaxYear!=5&Count==1
by DealerTIN: replace Exit=Exit[_n-1] if Exit>=.
replace Exit=0 if Exit==.

xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==1, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==0, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==1, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==0, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==1, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount!=5&Exit==0, fe cluster(DealerTIN)
