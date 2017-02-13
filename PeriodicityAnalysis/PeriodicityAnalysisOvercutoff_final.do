/*
Overall Analysis: We also overall annual analysis in this file

Treatment group = Firms with turnover between 10,00,000 and 50,00,000 but continue to file annual returns in year 2
Control group = Firms with turnover between 10,00,000 and 50,00,000 but change their filing frequency appropriately next year


*/

cd "D:\data"
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

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

gsort DealerTIN Treat TaxYear
by DealerTIN Treat: gen Count=_n


replace Treat=. if Count==1&TotalCount==5&TaxYear==2&Treat!=.
replace Treat=. if Count==2&TotalCount==5&TaxYear==3&Treat!=.
replace Treat=. if Count==3&TotalCount==5&TaxYear==4&Treat!=.
replace Treat=. if Count==4&TotalCount==5&TaxYear==5&Treat!=.



logout, save(summary_overcutoff_total5_year1) excel replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==1&TotalCount==5, by(Treat)
logout, save(summary_overcutoff_total5_year2) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==2&TotalCount==5, by(Treat)
logout, save(summary_overcutoff_total5_year3) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==3&TotalCount==5, by(Treat)
logout, save(summary_overcutoff_total5_year4) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==4&TotalCount==5, by(Treat)
logout, save(summary_overcutoff_total5_year5) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==5&TotalCount==5, by(Treat)

collapse (mean)MoneyDeposited , by(TaxYear Treat)

replace MoneyDeposited=MoneyDeposited/1000

twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1), xline(3) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in thousand rupees")
graph export "H:\2a2b_analysis\OverCutoff\VATDeposited_trends_OverCutoff.pdf", as(pdf) replace


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
xtreg MoneyDeposited iTaxYear1 iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat*, fe cluster(DealerTIN)
}

//TotalCount==5
//Post Analysis
xtreg PositiveContribution Post  iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, replace nocons keep(Post) 
xtreg VatIncrease Post  iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 
xtreg MoneyDeposited Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 
xtreg TaxCreditBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 
xtreg OutputTaxBeforeAdjustment  Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 

xtreg lMoneyDeposited Post iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 
xtreg lTaxCreditBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 
xtreg lOutputTaxBeforeAdjustment  Post iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) 


qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, replace nocons keep(Post) ctitle("VatDeposit, Q=0.6")
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("VatDeposit, Q=0.7")
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("VatDeposit, Q=0.8")


qreg TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("Credit, Q=0.6")
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("Credit, Q=0.7")
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("Credit, Q=0.8")

qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("OutputTax, Q=0.6")
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("OutputTax, Q=0.7")
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Post.xls, append nocons keep(Post) ctitle("OutputTax, Q=0.8")


//TreatAnalysis
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 

xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 


qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 if TotalCount==5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, replace nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.6")
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.7")
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.8")

qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.6")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.7")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.8")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.6")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.7")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  if TotalCount==5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.8")


//All firms
//Post Analysis
xtreg PositiveContribution Post  iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, replace nocons keep(Post) 
xtreg VatIncrease Post  iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 
xtreg MoneyDeposited Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 
xtreg TaxCreditBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 
xtreg OutputTaxBeforeAdjustment  Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 

xtreg lMoneyDeposited Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 
xtreg lTaxCreditBeforeAdjustment Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 
xtreg lOutputTaxBeforeAdjustment  Post iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Post.xls, append nocons keep(Post) 


qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, replace nocons keep(Post) ctitle("VatDeposit, Q=0.6")
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("VatDeposit, Q=0.7")
qreg MoneyDeposited  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("VatDeposit, Q=0.8")


qreg TaxCreditBeforeAdjustment Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("Credit, Q=0.6")
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("Credit, Q=0.7")
qreg TaxCreditBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("Credit, Q=0.8")

qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("OutputTax, Q=0.6")
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("OutputTax, Q=0.7")
qreg OutputTaxBeforeAdjustment  Post iTaxYear4 iTaxYear2 iTaxYear5, q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_All_Post.xls, append nocons keep(Post) ctitle("OutputTax, Q=0.8")


//TreatAnalysis
xtreg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 

xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) 


qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5 , q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, replace nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.6")
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.7")
qreg MoneyDeposited  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.8")

qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.6")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.7")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.8")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.6)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.6")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.7)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.7")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat iTaxYear4 iTaxYear2 iTaxYear5  , q(.8)
outreg2 using diffINdiff_QuantileOverCutoff_All_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.8")


gen Dummy=1
collapse (mean) Treat PositiveContribution (sum) Dummy MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxYear)

replace TurnoverGross=TurnoverGross/1000000000
replace MoneyDeposited =MoneyDeposited /1000000000
replace OutputTaxBeforeAdjustment =OutputTaxBeforeAdjustment/1000000000
replace TaxCreditBeforeAdjustment  =TaxCreditBeforeAdjustment  /1000000000
replace Dummy=Dummy/1000
twoway (connected PositiveContribution TaxYear) (connected Dummy TaxYear, yaxis(2)), ytitle(Mean of VAT>0) ytitle(Total number of firms filing returns (in thousands), axis(2)) xline(3) title(Mean of Firms with VAT>0 (for always present firms)) note("Number of firms is in thousands, Third party matching started in Year 3", span)  legend(order(1 "Mean {VAT>0}" 2 "Number of firms filing returns"))
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\PositiveContribution_all_sum.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxYear) (connected Dummy TaxYear, yaxis(2)), ytitle(Total Gross Turnover (In Billion rupees)) ytitle(Total number of firms filing returns (in thousands), axis(2)) xline(3) title(Total Turnover) note("Turnover in Billion rupees and Number of firms in thousands, Third party matching started in Year 3", span) legend(order(1 "Total Turnover" 2 "Number of firms filing returns"))
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\TurnoverGross_all_sum.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxYear) (connected Dummy TaxYear, yaxis(2)), ytitle(Total VAT Deposited (In Billion rupees)) ytitle(Total number of firms filing returns (in thousands), axis(2)) xline(3) title(Total VAT Deposited) note("Vat Deposited in Billion rupees and Number of firms in thousands, Third party matching started in Year 3", span) legend(order(1 "VAT deposited" 2 "Number of firms filing returns"))
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\VATDeposited_all_sum.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxYear) (connected Dummy TaxYear, yaxis(2)), ytitle(Total VAT Credit Claimed (In Billion rupees)) ytitle(Total number of firms filing returns (in thousands), axis(2)) xline(3) title(Total VAT Credit) note("Vat credit claimed is in in Billion rupees and Number of firms in thousands, Third party matching started in Year 3", span) legend(order(1 "VAT Credit Claimed" 2 "Number of firms filing returns"))
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\VATCredit_all_sum.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxYear) (connected Dummy TaxYear, yaxis(2)), ytitle(Total Output Tax(In Billion rupees)) ytitle(Total number of firms filing returns (in thousands), axis(2)) xline(3) title(Total Output Tax) note("Output tax declared is in in Billion rupees and Number of firms in thousands, Third party matching started in Year 3", span) legend(order(1 "Output Tax Declared" 2 "Number of firms filing returns"))
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\VATOutputTax_all_sum.pdf", as(pdf) replace

gen Dummy=1
collapse (mean) Treat PositiveContribution (sum) Dummy MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxYear TotalCount)

replace TurnoverGross=TurnoverGross/1000000000
replace MoneyDeposited =MoneyDeposited /1000000000
replace OutputTaxBeforeAdjustment =OutputTaxBeforeAdjustment/1000000000
replace TaxCreditBeforeAdjustment  =TaxCreditBeforeAdjustment/1000000000

twoway (connected PositiveContribution TaxYear)  if TotalCount==5, ytitle(Mean of VAT>0) xline(3) title(Mean of Firms with VAT>0 (for always present firms)) note("Number of firms is 148435, Third party matching started in Year 3", span) 
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\PositiveContribution_totalcount5_sum.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxYear)  if TotalCount==5, ytitle(Total Gross Turnover (In Billion rupees)) xline(3) title(Total Turnover (for always present firms)) note("Turnover in Billion rupees and Number of firms is 148435, Third party matching started in Year 3", span) 
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\TurnoverGross_totalcount5_sum.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxYear) if TotalCount==5, ytitle(Total VAT Deposited (In Billion rupees)) xline(3) title(Total VAT Deposited (for always present firms)) note("Vat Deposited in Billion rupees and Number of firms is 148435, Third party matching started in Year 3", span) 
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\VATDeposited_totalcount5_sum.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxYear) if TotalCount==5, ytitle(Total VAT Credit Claimed (In Billion rupees)) xline(3) title(Total VAT Credit (for always present firms)) note("Credit claimed is in in Billion rupees and Number of firms is 148435, Third party matching started in Year 3", span) 
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\VATCredit_totalcount5_sum.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxYear) if TotalCount==5, ytitle(Total Output Tax(In Billion rupees)) xline(3) title(Total Output Tax (for always present firms)) note("Tax declared is in in Billion rupees and Number of firms is 148435, Third party matching started in Year 3", span)
graph export "H:\2a2b_analysis\graphs\Overall_Analysis\VATOutputTax_totalcount5_sum.pdf", as(pdf) replace

