/* Date: November 28, 2017 */
/* Author: Shekhar Mittal */
/* In this file, we focus on plotting the graphs for bunching visualisation */
/* We are going to focus on 3 thresholds */
/* 1. 50 million */
/* 2. 5 million  */
/* 3. 1 million */
/* We are going to do this over 3 bin sizes */


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


collapse (firstnm) WardName (sum)AdjustCSTLiability RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gsort DealerTIN TaxYear
by DealerTIN: gen TotalCount=_N
by DealerTIN: gen YearCount=_n
gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]


gen AllCentral=0
replace AllCentral=1 if TurnoverGross==TurnoverCentral&TurnoverGross>0

gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0

drop if ZeroTurnover==1


replace TurnoverGross=TurnoverGross/100000
replace MoneyDeposited=MoneyDeposited/100000
gen VR=MoneyDeposited/TurnoverGross

egen bin1=cut(TurnoverGross), at(0(1)2000)
egen bin2=cut(TurnoverGross), at(0(2)2000)
egen bin3=cut(TurnoverGross), at(0(3)2000)


bys TaxYear bin1: gen Count=_N
by TaxYear bin1: gen SerialCount=_n
by TaxYear bin1: egen VatRatio=mean(VR)
by TaxYear bin1: egen PC=mean(PositiveContribution)
by TaxYear bin1: egen MeanMoneyDeposited=mean(MoneyDeposited)


bys TaxYear bin2: gen Count2=_N
by TaxYear bin2: gen SerialCount2=_n
by TaxYear bin2: egen VatRatio2=mean(VR)
by TaxYear bin2: egen PC2=mean(PositiveContribution)
by TaxYear bin2: egen MeanMoneyDeposited2=mean(MoneyDeposited)


bys TaxYear bin3: gen Count3=_N
by TaxYear bin3: gen SerialCount3=_n
by TaxYear bin3: egen VatRatio3=mean(VR)
by TaxYear bin3: egen PC3=mean(PositiveContribution)
by TaxYear bin3: egen MeanMoneyDeposited3=mean(MoneyDeposited)



//Bunching at 50 Million
{
//Bunching in year 1
#delimit ;
twoway (connected Count bin1 if TaxYear==1&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==1&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) title("Bunching in Year 1 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49.5 and 50.5 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count2 bin2 if TaxYear==1&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit Count2 bin2 if TaxYear==1&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 1 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_2lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected Count3 bin3 if TaxYear==1&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit Count3 bin3 if TaxYear==1&bin3>400&bin3<600&(bin3<475|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(475, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 1 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 47.5 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_3lac.pdf", as(pdf) replace;

	   
#delimit ;
twoway (connected PC bin1 if TaxYear==1&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit PC bin1 if TaxYear==1&bin1>400&bin1<600&(bin1<495|bin1>505)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49.5 and 50.5 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_PositiveC.pdf", as(pdf) replace;


#delimit ;
twoway (connected PC2 bin2 if TaxYear==1&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==1&bin2>400&bin2<600&(bin1<490|bin1>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_PositiveC_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_PositiveC_2lac.pdf", as(pdf) replace;

#delimit ;
twoway (connected PC3 bin3 if TaxYear==1&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit PC3 bin3 if TaxYear==1&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_PositiveC_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_PositiveC_3lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected MeanMoneyDeposited bin1 if TaxYear==1&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit MeanMoneyDeposited bin1 if TaxYear==1&bin1>400&bin1<600&(bin1<495|bin1>505)&SerialCount==1, estopts(degree(4))), 
	   xline(500) title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .1 million rupees)")
	   note("Dropping mass between 49.5 and 50.5 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_MeanTax.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_MeanTax_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_MeanTax_2lac.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited3 bin3 if TaxYear==1&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit MeanMoneyDeposited3 bin3 if TaxYear==1&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_MeanTax_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear1_50Million_Degree4_MeanTax_3lac.pdf", as(pdf) replace;


//Bunching in year 2

#delimit ;
twoway (connected Count bin1 if TaxYear==2&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==2&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 2 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count2 bin2 if TaxYear==2&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit Count2 bin2 if TaxYear==2&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_2lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected Count3 bin3 if TaxYear==2&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit Count3 bin3 if TaxYear==2&bin3>400&bin3<600&(bin3<480|bin3>540)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(480, lpattern(dash) lcolor(maroon)) xline(540, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 2 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 48 and 54 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_3lac.pdf", as(pdf) replace;

	   
	   
#delimit ;
twoway (connected PC bin1 if TaxYear==2&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit PC bin1 if TaxYear==2&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49.5 and 50.5 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_PositiveC.pdf", as(pdf) replace;


#delimit ;
twoway (connected PC2 bin2 if TaxYear==2&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==2&bin2>400&bin2<600&(bin1<490|bin1>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_PositiveC_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_PositiveC_2lac.pdf", as(pdf) replace;

#delimit ;
twoway (connected PC3 bin3 if TaxYear==2&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit PC3 bin3 if TaxYear==2&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_PositiveC_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_PositiveC_3lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected MeanMoneyDeposited bin1 if TaxYear==2&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit MeanMoneyDeposited bin1 if TaxYear==2&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_MeanTax.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==2&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==2&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_MeanTax_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_MeanTax_2lac.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited3 bin3 if TaxYear==2&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit MeanMoneyDeposited3 bin3 if TaxYear==2&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_MeanTax_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear2_50Million_Degree4_MeanTax_3lac.pdf", as(pdf) replace;

//Bunching in year 3

#delimit ;
twoway (connected Count bin1 if TaxYear==3&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==3&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 3 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count2 bin2 if TaxYear==3&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit Count2 bin2 if TaxYear==3&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_2lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected Count3 bin3 if TaxYear==3&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit Count3 bin3 if TaxYear==3&bin3>400&bin3<600&(bin3<475|bin3>540)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(475, lpattern(dash) lcolor(maroon)) xline(540, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 3 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 47.5 and 54 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_3lac.pdf", as(pdf) replace;

	   
	   
#delimit ;
twoway (connected PC bin1 if TaxYear==3&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit PC bin1 if TaxYear==3&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_PositiveC.pdf", as(pdf) replace;


#delimit ;
twoway (connected PC2 bin2 if TaxYear==3&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==3&bin2>400&bin2<600&(bin1<490|bin1>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_PositiveC_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_PositiveC_2lac.pdf", as(pdf) replace;

#delimit ;
twoway (connected PC3 bin3 if TaxYear==3&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit PC3 bin3 if TaxYear==3&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_PositiveC_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_PositiveC_3lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected MeanMoneyDeposited bin1 if TaxYear==3&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit MeanMoneyDeposited bin1 if TaxYear==3&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_MeanTax.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_MeanTax_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_MeanTax_2lac.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited3 bin3 if TaxYear==3&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit MeanMoneyDeposited3 bin3 if TaxYear==3&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_MeanTax_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear3_50Million_Degree4_MeanTax_3lac.pdf", as(pdf) replace;


//Bunching in year 4

#delimit ;
twoway (connected Count bin1 if TaxYear==4&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==4&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 4 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count2 bin2 if TaxYear==4&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit Count2 bin2 if TaxYear==4&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_2lac.pdf", as(pdf) replace;


//&(bin3<490|bin3>530) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
#delimit ;
twoway (connected Count3 bin3 if TaxYear==4&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit Count3 bin3 if TaxYear==4&bin3>400&bin3<600&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  
	   title("Bunching in Year 4 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_3lac.pdf", as(pdf) replace;

	   
/*	   
#delimit ;
twoway (connected PC bin1 if TaxYear==4&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit PC bin1 if TaxYear==4&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_PositiveC.pdf", as(pdf) replace;


#delimit ;
twoway (connected PC2 bin2 if TaxYear==4&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==4&bin2>400&bin2<600&(bin1<490|bin1>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_PositiveC_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_PositiveC_2lac.pdf", as(pdf) replace;

#delimit ;
twoway (connected PC3 bin3 if TaxYear==4&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit PC3 bin3 if TaxYear==4&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_PositiveC_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_PositiveC_3lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected MeanMoneyDeposited bin1 if TaxYear==4&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit MeanMoneyDeposited bin1 if TaxYear==4&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_MeanTax.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==4&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==4&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_MeanTax_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_MeanTax_2lac.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited3 bin3 if TaxYear==4&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit MeanMoneyDeposited3 bin3 if TaxYear==4&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_MeanTax_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear4_50Million_Degree4_MeanTax_3lac.pdf", as(pdf) replace;
*/

//Bunching in year 5

#delimit ;
twoway (connected Count bin1 if TaxYear==5&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==5&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Bunching in Year 5 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count2 bin2 if TaxYear==5&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit Count2 bin2 if TaxYear==5&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 5 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_2lac.pdf", as(pdf) replace;


// /xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  (bin3<490|bin3>530)

#delimit ;
twoway (connected Count3 bin3 if TaxYear==5&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit Count3 bin3 if TaxYear==5&bin3>400&bin3<600&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  
	   title("Bunching in Year 5 at 50 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_3lac.pdf", as(pdf) replace;

	   
/*	   
#delimit ;
twoway (connected PC bin1 if TaxYear==5&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit PC bin1 if TaxYear==5&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_PositiveC.pdf", as(pdf) replace;


#delimit ;
twoway (connected PC2 bin2 if TaxYear==5&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==5&bin2>400&bin2<600&(bin1<490|bin1>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_PositiveC_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_PositiveC_2lac.pdf", as(pdf) replace;

#delimit ;
twoway (connected PC3 bin3 if TaxYear==5&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit PC3 bin3 if TaxYear==5&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Proportion of Firms making a Positive Contribution ") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_PositiveC_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_PositiveC_3lac.pdf", as(pdf) replace;



#delimit ;
twoway (connected MeanMoneyDeposited bin1 if TaxYear==5&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit MeanMoneyDeposited bin1 if TaxYear==5&bin1>400&bin1<600&(bin1<490|bin1>530)&SerialCount==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon)) 
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .1 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_MeanTax.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==5&bin2>400&bin2<600&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==5&bin2>400&bin2<600&(bin2<490|bin2>530)&SerialCount2==1, estopts(degree(4))), 
	   xline(500) xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .2 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_MeanTax_2lac.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_MeanTax_2lac.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited3 bin3 if TaxYear==5&bin3>400&bin3<600&SerialCount3==1, sort) 
       (fpfit MeanMoneyDeposited3 bin3 if TaxYear==5&bin3>400&bin3<600&(bin3<490|bin3>530)&SerialCount3==1, estopts(degree(4))), 
	   xline(500)  xline(490, lpattern(dash) lcolor(maroon)) xline(530, lpattern(dash) lcolor(maroon))  
	   title("Mean Tax Remitted") 
	   graphregion(color(white)) 
	   xtitle("Tax collection (in .3 million rupees)")
	   note("Dropping mass between 49 and 53 million. 4th Degree polynomial");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_MeanTax_3lac.gph";
graph export "F:\Bunching_analysis\BunchingYear5_50Million_Degree4_MeanTax_3lac.pdf", as(pdf) replace;

*/
}	   


	   
//Bunching at 5 million
{

drop bin1 bin2 bin3
drop Count Count2 Count3
drop SerialCount SerialCount2 SerialCount3
drop VatRatio VatRatio2 VatRatio3
drop PC PC2 PC3
drop MeanMoneyDeposited MeanMoneyDeposited2 MeanMoneyDeposited3


egen bin1=cut(TurnoverGross), at(0(.1)200)
egen bin2=cut(TurnoverGross), at(0(.2)200)
egen bin3=cut(TurnoverGross), at(0(.3)200)


bys TaxYear bin1: gen Count=_N
by TaxYear bin1: gen SerialCount=_n
by TaxYear bin1: egen VatRatio=mean(VR)
by TaxYear bin1: egen PC=mean(PositiveContribution)
by TaxYear bin1: egen MeanMoneyDeposited=mean(MoneyDeposited)


bys TaxYear bin2: gen Count2=_N
by TaxYear bin2: gen SerialCount2=_n
by TaxYear bin2: egen VatRatio2=mean(VR)
by TaxYear bin2: egen PC2=mean(PositiveContribution)
by TaxYear bin2: egen MeanMoneyDeposited2=mean(MoneyDeposited)


bys TaxYear bin3: gen Count3=_N
by TaxYear bin3: gen SerialCount3=_n
by TaxYear bin3: egen VatRatio3=mean(VR)
by TaxYear bin3: egen PC3=mean(PositiveContribution)
by TaxYear bin3: egen MeanMoneyDeposited3=mean(MoneyDeposited)




//Bunching in year 1

#delimit ;
twoway (connected Count bin1 if TaxYear==1&bin1>40&bin1<60&SerialCount==1&Count<120, sort) 
       (fpfit Count bin1 if TaxYear==1&bin1>40&bin1<60&(bin1<49|bin1>53)&SerialCount==1&Count<120, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 1 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial. Unexplained mass at 4.55");
graph save Graph "F:\Bunching_analysis\BunchingYear1_5Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear1_5Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==1&bin2>40&bin2<60&SerialCount2==1&Count2<230, sort)
       (fpfit Count2 bin2 if TaxYear==1&bin2>40&bin2<60&(bin2<49|bin2>53)&SerialCount2==1&Count2<230, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 1 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial. Unexplained mass at 4.55");
graph save Graph "F:\Bunching_analysis\BunchingYear1_5Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear1_5Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
local year=1;
local lb=49;
local ub=51.5;
twoway (connected Count3 bin3 if TaxYear==`year'&bin3>40&bin3<60&SerialCount3==1&Count3<600, sort)
       (fpfit Count3 bin3 if TaxYear==`year'&bin3>40&bin3<60&(bin3<`lb'|bin3>`ub')&SerialCount3==1&Count3<600, estopts(degree(4))), 
	   xline(50) xline(`lb', lpattern(dash) lcolor(maroon)) xline(`ub', lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year `year' at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between `lb' and `ub' million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear`year'_5Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear`year'_5Million_Degree4_30000.pdf", as(pdf) replace;


/*
#delimit ;
twoway (connected PC2 bin2 if TaxYear==1&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==1&bin1>45&bin1<55&(bin1<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Proportion of Firms making a Positive Contribution (Year1)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear1_5Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear1_5Million_Degree4_PositiveC.pdf", as(pdf) replace;


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>45&bin2<55&(bin2<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Mean Tax Remitted (Year 1)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear1_5Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear1_5Million_Degree4_MeanTax.pdf", as(pdf) replace;
*/

//Bunching in year 2


#delimit ;
twoway (connected Count bin1 if TaxYear==2&bin1>40&bin1<60&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==2&bin1>40&bin1<60&(bin1<49|bin1>53)&SerialCount==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear2_5Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear2_5Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==2&bin2>40&bin2<60&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==2&bin2>40&bin2<60&(bin2<49|bin2>53)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==1&bin3>40&bin3<60&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==1&bin3>40&bin3<60&(bin3<49|bin3>52.7)&SerialCount3==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(52.7, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between 4.9 and 5.27 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_30000.pdf", as(pdf) replace;

/*

#delimit ;
twoway (connected PC2 bin2 if TaxYear==2&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==2&bin1>45&bin1<55&(bin1<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Proportion of Firms making a Positive Contribution (Year 2) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>45&bin2<55&(bin2<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Mean Tax Remitted (Year 2)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear2_5Million_Degree4_MeanTax.pdf", as(pdf);

*/

//Bunching in year 3



#delimit ;
twoway (connected Count bin1 if TaxYear==3&bin1>40&bin1<60&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==3&bin1>40&bin1<60&(bin1<49|bin1>53)&SerialCount==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear3_5Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear3_5Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==3&bin2>40&bin2<60&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==3&bin2>40&bin2<60&(bin2<49|bin2>53)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==3&bin3>40&bin3<60&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==3&bin3>40&bin3<60&(bin3<49|bin3>53)&SerialCount3==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_30000.pdf", as(pdf) replace;


/*#delimit ;
twoway (connected PC2 bin2 if TaxYear==3&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==3&bin1>45&bin1<55&(bin1<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Proportion of Firms making a Positive Contribution (Year 3) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>45&bin2<55&(bin2<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Mean Tax Remitted (Year 3)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear3_5Million_Degree4_MeanTax.pdf", as(pdf);
*/


//Bunching in year 4


#delimit ;
twoway (connected Count bin1 if TaxYear==4&bin1>40&bin1<60&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==4&bin1>40&bin1<60&(bin1<49|bin1>53)&SerialCount==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear4_5Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear4_5Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==4&bin2>40&bin2<60&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==4&bin2>40&bin2<60&(bin2<49|bin2>53)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==4&bin3>40&bin3<60&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==4&bin3>40&bin3<60&(bin3<49|bin3>53)&SerialCount3==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_30000.pdf", as(pdf) replace;

/*


#delimit ;
twoway (connected PC2 bin2 if TaxYear==4&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==4&bin1>45&bin1<55&(bin1<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Proportion of Firms making a Positive Contribution (Year 4) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==4&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==4&bin2>45&bin2<55&(bin2<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Mean Tax Remitted (Year 4)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear4_5Million_Degree4_MeanTax.pdf", as(pdf);
*/

//Bunching in year 5


#delimit ;
twoway (connected Count bin1 if TaxYear==5&bin1>40&bin1<60&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==5&bin1>40&bin1<60&(bin1<49|bin1>53)&SerialCount==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 5 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear5_5Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear5_5Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==5&bin2>40&bin2<60&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==5&bin2>40&bin2<60&(bin2<49|bin2>53)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 5 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==5&bin3>40&bin3<60&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==5&bin3>40&bin3<60&(bin3<49|bin3>53)&SerialCount3==1, estopts(degree(4))), 
	   xline(50) xline(49, lpattern(dash) lcolor(maroon)) xline(53, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 5 at 5 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between 4.9 and 5.3 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_30000.pdf", as(pdf) replace;

/*
#delimit ;
twoway (connected PC2 bin2 if TaxYear==3&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==3&bin1>45&bin1<55&(bin1<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Proportion of Firms making a Positive Contribution (Year 5) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>45&bin2<55&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>45&bin2<55&(bin2<49.5|bin2>50.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(50) title("Mean Tax Remitted (Year 5)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 4.95 and 5.05 million. 4th Degree polynomial. Unexplained mass at 4.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear5_5Million_Degree4_MeanTax.pdf", as(pdf);
*/  
}   

* Bunching at 1 million

{

drop bin1 bin2 bin3
drop Count Count2 Count3
drop SerialCount SerialCount2 SerialCount3
drop VatRatio VatRatio2 VatRatio3
drop PC PC2 PC3
drop MeanMoneyDeposited MeanMoneyDeposited2 MeanMoneyDeposited3


egen bin1=cut(TurnoverGross), at(0(.1)200)
egen bin2=cut(TurnoverGross), at(0(.2)200)
egen bin3=cut(TurnoverGross), at(0(.3)200)


bys TaxYear bin1: gen Count=_N
by TaxYear bin1: gen SerialCount=_n
by TaxYear bin1: egen VatRatio=mean(VR)
by TaxYear bin1: egen PC=mean(PositiveContribution)
by TaxYear bin1: egen MeanMoneyDeposited=mean(MoneyDeposited)


bys TaxYear bin2: gen Count2=_N
by TaxYear bin2: gen SerialCount2=_n
by TaxYear bin2: egen VatRatio2=mean(VR)
by TaxYear bin2: egen PC2=mean(PositiveContribution)
by TaxYear bin2: egen MeanMoneyDeposited2=mean(MoneyDeposited)


bys TaxYear bin3: gen Count3=_N
by TaxYear bin3: gen SerialCount3=_n
by TaxYear bin3: egen VatRatio3=mean(VR)
by TaxYear bin3: egen PC3=mean(PositiveContribution)
by TaxYear bin3: egen MeanMoneyDeposited3=mean(MoneyDeposited)

*&Count<120
*&Count<120
//Bunching at Year 1
#delimit ;
twoway (connected Count bin1 if TaxYear==1&bin1>5&bin1<15&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==1&bin1>5&bin1<15&(bin1<9|bin1>11)&SerialCount==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 1 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear1_1Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear1_1Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==1&bin2>5&bin2<15&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==1&bin2>5&bin2<15&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 1 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==1&bin3>5&bin3<15&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==1&bin3>5&bin3<15&(bin3<9|bin3>13)&SerialCount3==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(13, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 1 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between .9 and 1.2 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_30000.pdf", as(pdf) replace;




#delimit ;
twoway (connected PC2 bin2 if TaxYear==1&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==1&bin2>5&bin2<15&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash))
	   title("Proportion of Firms making a Positive Contribution (Year 1)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial.");
	   graph save Graph "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_PositiveC.pdf", as(pdf) replace;

/*
#delimit ;
twoway (connected MeanMoneyDeposited bin1 if TaxYear==1&bin1>5&bin1<15&SerialCount==1, sort) 
       (fpfit MeanMoneyDeposited2 bin1 if TaxYear==1&bin1>5&bin1<15&(bin1<9|bin1>11)&SerialCount==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash))
	   title("Mean Tax Remitted (Year 1)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between 0.9 and 1.1 million. 4th Degree polynomial.");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_MeanTax.pdf", as(pdf) replace;
*/


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==1&bin2>5&bin2<15&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash))
	   title("Mean Tax Remitted (Year 1)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between 0.9 and 1.1 million. 4th Degree polynomial.");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear1_1Million_Degree4_MeanTax.pdf", as(pdf) replace;

//Bunching at Year 2
#delimit ;
twoway (connected Count bin1 if TaxYear==2&bin1>5&bin1<15&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==2&bin1>5&bin1<15&(bin1<9|bin1>11)&SerialCount==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear2_1Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear2_1Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==2&bin2>5&bin2<15&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==2&bin2>5&bin2<15&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==2&bin3>5&bin3<15&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==2&bin3>5&bin3<15&(bin3<9|bin3>11)&SerialCount3==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 2 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_30000.pdf", as(pdf) replace;

/*
#delimit ;
twoway (connected PC2 bin2 if TaxYear==2&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==2&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Proportion of Firms making a Positive Contribution (Year 2) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==2&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==2&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Mean Tax Remitted (Year 2)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear2_1Million_Degree4_MeanTax.pdf", as(pdf);
*/


//Bunching at Year 3
#delimit ;
twoway (connected Count bin1 if TaxYear==3&bin1>5&bin1<15&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==3&bin1>5&bin1<15&(bin1<9|bin1>11)&SerialCount==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear3_1Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear3_1Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==3&bin2>5&bin2<15&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==3&bin2>5&bin2<15&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==3&bin3>5&bin3<15&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==3&bin3>5&bin3<15&(bin3<9|bin3>11)&SerialCount3==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 3 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_30000.pdf", as(pdf) replace;


/*
#delimit ;
twoway (connected PC2 bin2 if TaxYear==3&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==3&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Proportion of Firms making a Positive Contribution (Year 3) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==3&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Mean Tax Remitted (Year 3)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear3_1Million_Degree4_MeanTax.pdf", as(pdf);
*/

//Bunching at Year 4
#delimit ;
twoway (connected Count bin1 if TaxYear==4&bin1>5&bin1<15&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==4&bin1>5&bin1<15&(bin1<9|bin1>11)&SerialCount==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear4_1Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear4_1Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==4&bin2>5&bin2<15&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==4&bin2>5&bin2<15&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==4&bin3>4&bin3<16&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==4&bin3>4&bin3<16&(bin3<9|bin3>11)&SerialCount3==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_30000.pdf", as(pdf) replace;
/*
#delimit ;
twoway (connected PC2 bin2 if TaxYear==4&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==4&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Proportion of Firms making a Positive Contribution (Year 4) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   graph save Graph "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==4&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==4&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Mean Tax Remitted (Year 4)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear4_1Million_Degree4_MeanTax.pdf", as(pdf);
*/

//Bunching at Year 5
#delimit ;
twoway (connected Count bin1 if TaxYear==5&bin1>4&bin1<16&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==5&bin1>4&bin1<16&(bin1<9|bin1>11)&SerialCount==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 5 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 10,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear5_1Million_Degree4.gph";
graph export "F:\Bunching_analysis\BunchingYear5_1Million_Degree4.pdf", as(pdf) replace;

#delimit ;
twoway (connected Count2 bin2 if TaxYear==5&bin2>4&bin2<16&SerialCount2==1, sort)
       (fpfit Count2 bin2 if TaxYear==5&bin2>4&bin2<16&(bin2<9|bin2>11)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 4 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 20,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_20000.gph";
graph export "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_20000.pdf", as(pdf) replace;


#delimit ;
twoway (connected Count3 bin3 if TaxYear==5&bin3>4&bin3<16&SerialCount3==1, sort)
       (fpfit Count3 bin3 if TaxYear==5&bin3>4&bin3<16&(bin3<9|bin3>11)&SerialCount3==1, estopts(degree(4))), 
	   xline(10) xline(9, lpattern(dash) lcolor(maroon)) xline(11, lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year 5 at 1 Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between .9 and 1.1 million. 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_30000.pdf", as(pdf) replace;
/*


#delimit ;
twoway (connected PC2 bin2 if TaxYear==5&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit PC2 bin2 if TaxYear==5&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Proportion of Firms making a Positive Contribution (Year 5) ") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial.");
	   graph save Graph "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_PositiveC.gph";
graph export "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_PositiveC.pdf", as(pdf);


#delimit ;
twoway (connected MeanMoneyDeposited2 bin2 if TaxYear==5&bin2>5&bin2<15&SerialCount2==1, sort) 
       (fpfit MeanMoneyDeposited2 bin2 if TaxYear==5&bin2>5&bin2<15&(bin2<9.5|bin2>10.5)&SerialCount2==1, estopts(degree(4))), 
	   xline(10) title("Mean Tax Remitted (Year 5)") 
	   graphregion(color(white)) 
       xtitle("Revenue (in 100,000 rupees)")
	   note("Dropping mass between 0.95 and 1.05 million. 4th Degree polynomial. Unexplained mass at 1.55");
	   	   graph save Graph "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_MeanTax.gph";
graph export "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_MeanTax.pdf", as(pdf);
  

}
*/
//Dynamic analysis at Threshold 3
// a.	Graphic comparisons: 
//e.g. year 1 turnover on the x-axis, and year 4 turnover on the y-axis, marking the thresholds using vertical lines on the x axis
gsort DealerTIN TaxYear

by DealerTIN: gen TurnoverTaxYear4=TurnoverGross if TaxYear==4
by DealerTIN: gen TurnoverTaxYear5=TurnoverGross if TaxYear==5
by DealerTIN: gen TurnoverTaxYear1=TurnoverGross if TaxYear==1
by DealerTIN: gen TurnoverTaxYear2=TurnoverGross if TaxYear==2
by DealerTIN: gen TurnoverTaxYear3=TurnoverGross if TaxYear==3

by DealerTIN: replace TurnoverTaxYear4=TurnoverTaxYear4[_n-1] if TurnoverTaxYear4>=.
by DealerTIN: replace TurnoverTaxYear5=TurnoverTaxYear5[_n-1] if TurnoverTaxYear5>=.
by DealerTIN: replace TurnoverTaxYear1=TurnoverTaxYear1[_n-1] if TurnoverTaxYear1>=.
by DealerTIN: replace TurnoverTaxYear2=TurnoverTaxYear2[_n-1] if TurnoverTaxYear2>=.
by DealerTIN: replace TurnoverTaxYear3=TurnoverTaxYear3[_n-1] if TurnoverTaxYear3>=.

gsort DealerTIN -TaxYear
by DealerTIN: replace TurnoverTaxYear4=TurnoverTaxYear4[_n-1] if TurnoverTaxYear4>=.
by DealerTIN: replace TurnoverTaxYear5=TurnoverTaxYear5[_n-1] if TurnoverTaxYear5>=.
by DealerTIN: replace TurnoverTaxYear1=TurnoverTaxYear1[_n-1] if TurnoverTaxYear1>=.
by DealerTIN: replace TurnoverTaxYear2=TurnoverTaxYear2[_n-1] if TurnoverTaxYear2>=.
by DealerTIN: replace TurnoverTaxYear3=TurnoverTaxYear3[_n-1] if TurnoverTaxYear3>=.

# delimit;
twoway (scatter TurnoverTaxYear5 TurnoverTaxYear1 if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear5<4000), 
       xline(500) graphregion(color(white)) yline(500)
	   note("if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear5<4000");
graph save Graph "C:\Users\shekh\Dropbox (Personal)\VAT in Developing Countries\Analysis\Graphs\Dynamic Analysis\50 Million\Turnover5vsTurnover1.gph";
graph export "C:\Users\shekh\Dropbox (Personal)\VAT in Developing Countries\Analysis\Graphs\Dynamic Analysis\50 Million\Turnover5vsTurnover1.pdf", as(pdf) replace;
	   
# delimit;
twoway (scatter TurnoverTaxYear4 TurnoverTaxYear1 if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear4<4000), 
       xline(500) graphregion(color(white)) yline(500)
	   note("if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear4<4000");
graph save Graph "C:\Users\shekh\Dropbox (Personal)\VAT in Developing Countries\Analysis\Graphs\Dynamic Analysis\50 Million\Turnover4vsTurnover1.gph";
graph export "C:\Users\shekh\Dropbox (Personal)\VAT in Developing Countries\Analysis\Graphs\Dynamic Analysis\50 Million\Turnover4vsTurnover1.pdf", as(pdf) replace;  
	   

# delimit;
twoway (scatter TurnoverTaxYear2 TurnoverTaxYear1 if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear2<4000), 
       xline(500) graphregion(color(white)) yline(500)
	   note("if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear2<4000");
graph save Graph "C:\Users\shekh\Dropbox (Personal)\VAT in Developing Countries\Analysis\Graphs\Dynamic Analysis\50 Million\Turnover2vsTurnover1.gph";
graph export "C:\Users\shekh\Dropbox (Personal)\VAT in Developing Countries\Analysis\Graphs\Dynamic Analysis\50 Million\Turnover2vsTurnover1.pdf", as(pdf) replace  ; 

	
# delimit;
twoway (scatter TurnoverTaxYear5 TurnoverTaxYear4 if TaxYear==4&TurnoverTaxYear4<600&TurnoverTaxYear5<1000&TurnoverTaxYear4>400)
 (function y=x,  range(400 600)), 
       xline(500) graphregion(color(white)) yline(500)
	   xtitle("TaxYear 4") ytitle("TaxYear 5") legend(off) title("Threshold at 50 Million")
	   note("if  TaxYear==4&TurnoverTaxYear4<600&TurnoverTaxYear5<1000&TurnoverTaxYear4>400");
//graph save Graph "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_30000.gph";
//graph export "F:\Bunching_analysis\BunchingYear5_1Million_Degree4_30000.pdf", as(pdf) replace;


# delimit;
twoway (scatter TurnoverTaxYear4 TurnoverTaxYear3 if TaxYear==3&TurnoverTaxYear3<600&TurnoverTaxYear4<1000&TurnoverTaxYear3>400)
 (function y=x,  range(400 600)), 
       xline(500) graphregion(color(white)) yline(500)
	   xtitle("TaxYear 4") ytitle("TaxYear 4") legend(off) title("Threshold at 50 Million")
	   note("if  TaxYear==3&TurnoverTaxYear4<600&TurnoverTaxYear5<1000&TurnoverTaxYear4>400");

	
	
# delimit;
twoway (scatter TurnoverTaxYear4 TurnoverTaxYear3 if TaxYear==3&TurnoverTaxYear3<600&TurnoverTaxYear4<2000&TurnoverTaxYear3>400), 
       xline(500) graphregion(color(white)) yline(500)
	   note("if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear2<4000");
	   
	
# delimit;
twoway (scatter TurnoverTaxYear3 TurnoverTaxYear2 if TaxYear==2&TurnoverTaxYear2<600&TurnoverTaxYear3<2000&TurnoverTaxYear2>400), 
       xline(500) graphregion(color(white)) yline(500)
	   note("if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear2<4000");
	   
	
# delimit;
twoway (scatter TurnoverTaxYear2 TurnoverTaxYear1 if TaxYear==1&TurnoverTaxYear1<600&TurnoverTaxYear2<2000&TurnoverTaxYear1>400), 
       xline(500) graphregion(color(white)) yline(500)
	   note("if TaxYear==1&bin1>490&bin1<510&TurnoverTaxYear2<4000");
	
	
	   #delimit ;
twoway (connected Count bin1 if TaxYear==3&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==3&bin1>400&bin1<600&(bin1<495|bin1>505&SerialCount==1), estopts(degree(4)))
	   , xline(500);

	   #delimit ;
twoway (connected Count bin1 if TaxYear==4&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==4&bin1>400&bin1<600&(bin1<495|bin1>505&SerialCount==1), estopts(degree(4)))
	   , xline(500);
	   
	   
	   #delimit ;
twoway (connected Count bin1 if TaxYear==5&bin1>400&bin1<600&SerialCount==1, sort) 
       (fpfit Count bin1 if TaxYear==5&bin1>400&bin1<600&(bin1<495|bin1>505&SerialCount==1), estopts(degree(4)))
	   , xline(500);

	   
	   * (connected Count bin1 if TaxYear==4&bin1>400&bin1<600, sort) 
*	   (fpfit Count bin1 if TaxYear==4&bin1>400&bin1<600&(bin1<495|bin1>505), estopts(degree(4)))
	   
#delimit ;
twoway (connected Count bin1 if TaxYear==1&bin1<60, sort) 
       (fpfit Count bin1 if TaxYear==1&bin1<60&((bin1<49|bin1>51)|(bin1<9|bin1>11)), estopts(degree(4)))
	   , xline(10) xline(50);
	   

	   #delimit ;
twoway (connected Count bin1 if TaxYear==2&bin1<60, sort) 
       (fpfit Count bin1 if TaxYear==2&bin1<60&((bin1<49|bin1>51)|(bin1<9|bin1>11)), estopts(degree(4)))
	   , xline(10) xline(50);

	   

	   
#delimit ;
twoway (connected Count bin1 if TaxYear==1&bin1<20, sort) 
       (fpfit Count bin1 if TaxYear==1&bin1<20&((bin1<9|bin1>11)), estopts(degree(4)))
	   , xline(10) xline(50);
	   

#delimit ;
twoway (connected Count bin1 if TaxYear==2&bin1<20, sort) 
       (fpfit Count bin1 if TaxYear==2&bin1<20&((bin1<9|bin1>11)), estopts(degree(4)))
	   , xline(10) xline(50);


	   #delimit ;
twoway (connected Count bin1 if TaxYear==2&bin1>400&bin1<600, sort) 
       (fpfit Count bin1 if TaxYear==2&bin1>400&bin1<600&((bin1<495|bin1>505)), estopts(degree(4)))
	   , xline(500);


	   
	   #delimit ;
twoway (connected Count bin1 if TaxYear==1&bin1>400&bin1<600, sort) 
       (fpfit Count bin1 if TaxYear==1&bin1>400&bin1<600&((bin1<495|bin1>505)), estopts(degree(4)))
	   , xline(500);
	   
	   #delimit ;
twoway (connected Count bin1 if TaxYear==3&bin1>400&bin1<600, sort) 
       (fpfit Count bin1 if TaxYear==3&bin1>400&bin1<600&((bin1<495|bin1>505)), estopts(degree(4)))
	   , xline(499.5);
	   

	   	   #delimit ;
twoway (connected Count bin1 if TaxYear==4&bin1>400&bin1<600, sort) 
       (fpfit Count bin1 if TaxYear==4&bin1>400&bin1<600&((bin1<495|bin1>505)), estopts(degree(4)))
	   , xline(499.5);

	   
twoway fpfit Count bin1 if TaxYear==1
twoway fpfit Count bin1 if TaxYear==1&bin1<30
help binscatter
binscatter Count bin1 if TaxYear==1
binscatter Count bin1 if TaxYear==1&bin1<30
tab bin1 if TaxYear==1&bin1<30
tab bin1
tab bin1 if bin1<30
*/
