cd "E:\data"
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

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

//drop if AnnualDummy==1&SemiAnnualDummy==1
//drop if AnnualDummy==1&QuarterlyDummy==1
//drop if SemiAnnualDummy==1&QuarterlyDummy==1
//drop if AnnualDummy==1&MonthlyDummy==1
//drop if QuarterlyDummy==1&MonthlyDummy==1
//drop if MonthlyDummy==1&SemiAnnualDummy==1

//collapse (mean) AnnualDummy QuarterlyDummy SemiAnnualDummy MonthlyDummy (sum) TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)


collapse (sum) TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)


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


gen Dummy=1

gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)

gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))

gsort DealerTIN TaxYear
by DealerTIN: gen TotalCount=_N

gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.


gen ZeroTaxCredit=0
replace ZeroTaxCredit=1 if TaxCreditBeforeAdjustment==0
gen Treat=0 if TaxYear==1
replace Treat=1 if TaxYear==1&ZeroTaxCredit==1
gsort DealerTIN TaxYear
by DealerTIN: replace Treat=Treat[_n-1] if Treat>=.

/*gen ZeroTaxCredit=0 if ZeroTurnover==0
replace ZeroTaxCredit=1 if TaxCreditBeforeAdjustment==0&ZeroTurnover==0
gen Treat=0 if TaxYear==1&ZeroTurnover==0
replace Treat=1 if TaxYear==1&ZeroTaxCredit==1&ZeroTurnover==0
gsort DealerTIN TaxYear
by DealerTIN: replace Treat=Treat[_n-1] if Treat>=.


gen ZeroTaxCredit=0 if ZeroTurnover==0
replace ZeroTaxCredit=1 if TaxCreditBeforeAdjustment==0&ZeroTurnover==0
gen Treat=0 if ZeroTurnover==0
replace Treat=1 if ZeroTaxCredit==1&ZeroTurnover==0
*/

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
xtreg MoneyDeposited iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat1 iTreat2 iTreat3 iTreat4 iTreat5, fe cluster(DealerTIN)
xtreg MoneyDeposited iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat* if TotalCount==5, fe cluster(DealerTIN)


xtreg TaxCreditBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat* if TotalCount==5, fe cluster(DealerTIN)

xtreg OutputTaxBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat* if TotalCount==5, fe cluster(DealerTIN)

}





//TreatAnalysis
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_Treat", tex replace
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_Treat", tex append
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_Treat", tex append
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_Treat", tex append
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_Treat", tex append
xtreg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_Treat", tex append


xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_LOGTreat", tex replace
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_LOGTreat", tex append
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_TotalCount5_LOGTreat", tex append



//TreatAnalysis For all firms
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_Treat", tex replace
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_Treat", tex append
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_Treat", tex append
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_Treat", tex append
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_Treat", tex append
xtreg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_Treat", tex append


xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_LOGTreat", tex replace
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_LOGTreat", tex append
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using "H:\2a2b_analysis\ZeroTaxCredit\diffINdiff_MeanZeroTaxCredit_ALL_LOGTreat", tex append


collapse (mean)MoneyDeposited TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment , by(TaxYear Treat)

replace MoneyDeposited =MoneyDeposited /1000000
replace OutputTaxBeforeAdjustment =OutputTaxBeforeAdjustment/1000000
replace TaxCreditBeforeAdjustment  =TaxCreditBeforeAdjustment/1000000


twoway (connected OutputTaxBeforeAdjustment TaxYear if Treat==0) (connected OutputTaxBeforeAdjustment TaxYear if Treat==1), legend(order (1 "Control Group" 2 "Treatment Group")) note("Treatment group is firms with Tax Credit=0 in year 1. Output Tax is in million rupees") 
graph save Graph "H:\2a2b_analysis\ZeroTaxCredit\OutputTaxBeforeAdjustment.gph"
twoway (connected TaxCreditBeforeAdjustment TaxYear if Treat==0) (connected TaxCreditBeforeAdjustment TaxYear if Treat==1), legend(order (1 "Control Group" 2 "Treatment Group")) note("Treatment group is firms with Tax Credit=0 in year 1. TaxCredit is in million rupees") 
graph save Graph "H:\2a2b_analysis\ZeroTaxCredit\TaxCreditBeforeAdjustment.gph", replace
twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1), legend(order (1 "Control Group" 2 "Treatment Group")) note("Treatment group is firms with Tax Credit=0 in year 1. MoneyDeposited is in million rupees") 
graph save Graph "H:\2a2b_analysis\ZeroTaxCredit\MoneyDeposited.gph", replace
