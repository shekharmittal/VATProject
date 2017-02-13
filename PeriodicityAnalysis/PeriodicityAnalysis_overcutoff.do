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



/*gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))
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
gen l2InterStateImportsAgainstJ=log(InterStateImportsAgainstJ+sqrt(InterStateImportsAgainstJ^2+1))*/

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gen AnnualDummy=1 if TaxPeriod=="Annual-2010"&TurnoverGross>1000000
by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.

gen NextSemi=1 if AnnualDummy==1&TaxPeriod=="Annual-2010"&TurnoverGross<5000000
by DealerTIN: replace NextSemi=NextSemi[_n-1] if NextSemi>=.

gen NextQuarter=1 if AnnualDummy==1&TaxPeriod=="Annual-2010"&TurnoverGross<50000000&TurnoverGross>5000000
by DealerTIN: replace NextQuarter=NextQuarter[_n-1] if NextQuarter>=.

gen NextMonthly=1 if AnnualDummy==1&TaxPeriod=="Annual-2010"&TurnoverGross>50000000
by DealerTIN: replace NextMonthly=NextMonthly[_n-1] if NextQuarter>=.


gen Treat=1 if NextSemi==1&TaxPeriod=="Annual-2011"&TaxYear==2
replace Treat=0 if NextSemi==1&(TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011")&TaxYear==2

by DealerTIN: replace Treat=Treat[_n-1] if Treat>=.

gsort DealerTIN -TaxYear

by DealerTIN: replace Treat=Treat[_n-1] if Treat>=.&TaxPeriod=="Annual-2010"


bys DealerTIN TaxYear: egen Dummy=mean(Treat)
by DealerTIN: replace Dummy=Dummy[_n-1] if Dummy>=.
gsort DealerTIN -TaxYear
by DealerTIN: replace Dummy=Dummy[_n-1] if Dummy>=.
drop if Dummy!=0&Dummy!=1&Dummy!=.




collapse (mean) Treat PositiveContribution (sum) MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)

gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)

gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))


gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.


gsort DealerTIN TaxYear
by DealerTIN: gen TotalCount=_N

gsort DealerTIN Treat TaxYear
by DealerTIN Treat: gen Count=_n


replace Treat=. if Count==1&TotalCount==5&TaxYear==2&Treat!=.
replace Treat=. if Count==2&TotalCount==5&TaxYear==3&Treat!=.
replace Treat=. if Count==3&TotalCount==5&TaxYear==4&Treat!=.
replace Treat=. if Count==4&TotalCount==5&TaxYear==5&Treat!=.

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

gen iTreatTaxYear1=Treat*iTaxYear1
gen iTreatTaxYear2=Treat*iTaxYear2
gen iTreatTaxYear3=Treat*iTaxYear3
gen iTreatTaxYear4=Treat*iTaxYear4
gen iTreatTaxYear5=Treat*iTaxYear5


xttobit PositiveContribution Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5
xttobit MoneyDeposited Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5

qreg MoneyDeposited  Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg GrowthRate Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)


qreg MoneyDeposited  Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.75)
qreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.75)
qreg OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.75)
qreg GrowthRate Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.75)


qreg MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 iTaxYear1 iTaxYear3 
qreg MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 iTaxYear1 iTaxYear3 if TotalCount==5, q(.75) 
qreg MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 iTaxYear1 iTaxYear3, q(.90) 
qreg MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 iTaxYear1 iTaxYear3, q(.99)

qreg MoneyDeposited  Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5
qreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5
qreg OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5
qreg GrowthRate Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5

xtreg PositiveContribution Post iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)

xtreg MoneyDeposited Post iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment  Post iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, fe cluster(DealerTIN)

xtreg PositiveContribution Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat iTaxYear1  iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg lMoneyDeposited Post iPostTreat iTaxYear1  iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear1  iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear1  iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment Post iPostTreat iTaxYear1  iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg lOutputTaxBeforeAdjustment Post iPostTreat iTaxYear1  iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)


tobit MoneyDeposited Post Treat iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5 if TotalCount==5, ll(0)


collapse (mean) VatIncrease PositiveContribution (sum) MoneyDeposited l2MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment, by(TaxYear)

replace MoneyDeposited=MoneyDeposited/1000000000
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/1000000000
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/1000000000

twoway (connected TaxCreditBeforeAdjustment TaxYear) (connected MoneyDeposited TaxYear, yaxis(2)) (connected OutputTaxBeforeAdjustment TaxYear)

tobit MoneyDeposited Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, ll(0)
tobit l2MoneyDeposited Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5, ll(0)
tobit MoneyDeposited Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5 if TotalCount==5, ll(0)
tobit l2MoneyDeposited Post iPostTreat iTaxYear1 iTaxYear4 iTaxYear2 iTaxYear3 iTaxYear5 if TotalCount==5, ll(0)



tab NextMonthly
by DealerTIN: replace NextQuarter=NextQuarter[_n-1] if NextQuarter>=.
by DealerTIN: replace NextMonthly=NextMonthly[_n-1] if NextMonthly>=.
tab TaxPeriod if NextMonthly==1&TaxYear==2
tab TaxPeriod if NextSemi==1&TaxYear==2
gen Treat=1 if NexSemi==1&TaxPeriod=="Annual-2011"&TaxYear==2
tab Treat
by DealerTIN: replace Treat=Treat[_n-1] if Treat>=.
tab Treat
tab TaxPeriod Treat
collapse (mean) AnnualDummy QuarterlyDummy SemiAnnualDummy MonthlyDummy (sum) MoneyDeposited l2MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment, by(DealerTIN TaxYear Treat)
collapse (mean) Treat PositiveContribution (sum) MoneyDeposited l2MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)
bys TaxYear Treat: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment
bys TaxYear Treat: sum PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment
bys TaxYear Treat: sum PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment
bys TaxYear Treat: sum PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if Treat==0|Treat==1
bys TaxYear Treat: sum PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if (Treat==0|Treat==1)&Treat!=.
collapse (mean) Treat PositiveContribution (sum) MoneyDeposited l2MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)
keep if Treat!=.
keep if Treat==0|Treat==1
tab Treat, missing
collapse (mean) PositiveContribution (sum) MoneyDeposited l2MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment l2TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment l2OutputTaxBeforeAdjustment, by(Treat)
tab Treat PositiveContribution
tab MoneyDeposited Treat

log using "H:\PeriodicityAnalysis_overcutoff_regressions.log", replace

xtreg PositiveContribution Post iTaxYear2 iTaxYear4 iTaxYear5, cluster(DealerTIN) fe
xtreg VatIncrease Post iTaxYear2 iTaxYear4 iTaxYear5, cluster(DealerTIN) fe

qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)

qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)

qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)

qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)


qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.95)


tobit MoneyDeposited Post  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)

qregpd MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 



xtreg PositiveContribution Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) fe
xtreg VatIncrease Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) fe

qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)

qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg lMoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)

qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg l2MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)

qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg lTaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg l2TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)


qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg lOutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg l2OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)

tobit MoneyDeposited Post  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)

qregpd MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 



xtreg PositiveContribution Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, fe cluster(DealerTIN)


qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)


qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.5)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.9)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, q(.95)


tobit MoneyDeposited Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, ll(0) cluster(DealerTIN)


qregpd MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post  iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5, identifier(DealerTIN) fix(TaxYear) q(.9) 



xtreg PositiveContribution Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)


qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg lMoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
//This command is not running
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg l2MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)


qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.5)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.9)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.95)


tobit MoneyDeposited Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post Treat iPostTreat  iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, ll(0) cluster(DealerTIN)


qregpd MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post  iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, identifier(DealerTIN) fix(TaxYear) q(.9) 

log close


distplot TurnoverGross if TaxYear==1, by(Treat)
distplot connected TurnoverGross if TaxYear==1, by(Treat)
distplot connected TurnoverGross if TaxYear==1&Treat!=., by(Treat)
distplot line TurnoverGross if TaxYear==1&Treat!=., by(Treat)
distplot line TurnoverGross if TaxYear==1&Treat!=&TurnoverGross<5000000, by(Treat)
distplot line TurnoverGross if TaxYear==1&Treat!=.&TurnoverGross<5000000, by(Treat)
distplot line TurnoverGross if TaxYear==1&Treat==1&TurnoverGross<5000000
dotplot TurnoverGross
dotplot TurnoverGross if TaxYear==1
dotplot TurnoverGross if TaxYear==1&Treat!=.
tab Treat if TaxYear==1, missing
bys Treat: sum TurnoverGross if Treat!=.&TaxYea==1
quantile TurnoverGross if TaxYear==1&Treat==1, recast(line)
quantile TurnoverGross if TaxYear==1&Treat==1, recast(line) name(test, replace)
quantile TurnoverGross if TaxYear==1&Treat==0, recast(line) name(test)
quantile TurnoverGross if TaxYear==1&Treat==0, recast(line)
quantile TurnoverGross if TaxYear==1&Treat==0, recast(line) yscale(alt)
help cumul
cumul TurnoverGross if TaxYear==1&Treat==0, gen(cdfControlTurnover)
cumul TurnoverGross if TaxYear==1&Treat==1, gen(cdfTreatTurnover)
twoway (line cdfControlTurnover TurnoverGross if Treat==0, sort ) (line cdfTreatTurnover TurnoverGross if Treat==1, sort lpattern(dash))
twoway (line cdfControlTurnover TurnoverGross if Treat==0, sort ) (line cdfTreatTurnover TurnoverGross if Treat==1, sort lpattern(dash)) if TurnoverGross<20000000
(line cdfControlTurnover TurnoverGross if Treat==0, sort
line cdfControlTurnover TurnoverGross if Treat==0, sort
line cdfControlTurnover TurnoverGross if Treat==0&TurnoverGross<20000000, sort
line cdfControlTurnover TurnoverGross if Treat==1&TurnoverGross<20000000, sort
line cdfTreatTurnover TurnoverGross if Treat==1&TurnoverGross<20000000, sort
sum cdfTreatTurnover if Treat==1&TurnoverGross<20000000, detail
sum TurnoverGross if cdfTreatTurnover>0.2&cdfTreatTurnover<0.8&Treat==1&TurnoverGross<20000000, detail
br if TurnoverGross==1518940&cdfTreatTurnover>0.2&cdfTreatTurnover<0.8&Treat==1&TurnoverGross<20000000
tab cdfControlTurnover, missing
cumul TurnoverGross if TaxYear==2&Treat==0, gen(cdfControlTurnover)
cumul TurnoverGross if TaxYear==2&Treat==0, replace(cdfControlTurnover)
cumul TurnoverGross if TaxYear==2&Treat==0, gen(cdfControlTurnover2)
cumul TurnoverGross if TaxYear==2&Treat==1, gen(cdfTreatTurnover2)
twoway (line cdfControlTurnover2 TurnoverGross if Treat==0, sort ) (line cdfTreatTurnover2 TurnoverGross if Treat==1, sort lpattern(dash)) if TurnoverGross<20000000
cumul MoneyDeposited if TaxYear==1&Treat==0, gen(cdfControlMoney)
cumul MoneyDeposited if TaxYear==1&Treat==1, gen(cdfTreatMoney)
twoway (line cdfControlMoney MoneyDeposited if Treat==0, sort ) (line cdfTreatMoney MoneyDepositedif Treat==1, sort lpattern(dash))
twoway (line cdfControlMoney MoneyDeposited if Treat==0, sort ) (line cdfTreatMoney MoneyDeposited if Treat==1, sort lpattern(dash))
twoway (line cdfControlMoney MoneyDeposited if Treat==0, sort ) (line cdfTreatMoney MoneyDeposited if Treat==1, sort lpattern(dash)) if MoneyDeposited<50000000
twoway (line cdfControlMoney MoneyDeposited if Treat==0, sort ) (line cdfTreatMoney MoneyDeposited if Treat==1, sort lpattern(dash)) if MoneyDeposited<5000000
twoway (line cdfControlMoney MoneyDeposited if Treat==0, sort ) (line cdfTreatMoney MoneyDeposited if Treat==1, sort lpattern(dash)) if MoneyDeposited<1000000
twoway (line cdfControlMoney MoneyDeposited if Treat==0, sort ) (line cdfTreatMoney MoneyDeposited if Treat==1, sort lpattern(dash)) if MoneyDeposited<600000
