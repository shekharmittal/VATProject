
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


//For Threshold 3
egen bin1=cut(TurnoverGross), at(0(1)2000)
egen bin2=cut(TurnoverGross), at(0(2)2000)
egen bin3=cut(TurnoverGross), at(0(3)2000)



bys TaxYear bin1: gen Count=_N
by TaxYear bin1: gen SerialCount=_n
by TaxYear bin1: gen VatRatio=MoneyDeposited/TurnoverGross
by TaxYear bin1: egen PC=mean(PositiveContribution)
by TaxYear bin1: egen MeanMoneyDeposited=mean(MoneyDeposited)


bys TaxYear bin2: gen Count2=_N
by TaxYear bin2: gen SerialCount2=_n
by TaxYear bin2: gen VatRatio2=MoneyDeposited/TurnoverGross
by TaxYear bin2: egen PC2=mean(PositiveContribution)
by TaxYear bin2: egen MeanMoneyDeposited2=mean(MoneyDeposited)


bys TaxYear bin3: gen Count3=_N
by TaxYear bin3: gen SerialCount3=_n
by TaxYear bin3: gen VatRatio3=MoneyDeposited/TurnoverGross
by TaxYear bin3: egen PC3=mean(PositiveContribution)
by TaxYear bin3: egen MeanMoneyDeposited3=mean(MoneyDeposited)


//For Thresholds 1 and 2 



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
by TaxYear bin1: gen VatRatio=MoneyDeposited/TurnoverGross
by TaxYear bin1: egen PC=mean(PositiveContribution)
by TaxYear bin1: egen MeanMoneyDeposited=mean(MoneyDeposited)


bys TaxYear bin2: gen Count2=_N
by TaxYear bin2: gen SerialCount2=_n
by TaxYear bin2: gen VatRatio2=MoneyDeposited/TurnoverGross
by TaxYear bin2: egen PC2=mean(PositiveContribution)
by TaxYear bin2: egen MeanMoneyDeposited2=mean(MoneyDeposited)


bys TaxYear bin3: gen Count3=_N
by TaxYear bin3: gen SerialCount3=_n
by TaxYear bin3: gen VatRatio3=MoneyDeposited/TurnoverGross
by TaxYear bin3: egen PC3=mean(PositiveContribution)
by TaxYear bin3: egen MeanMoneyDeposited3=mean(MoneyDeposited)


* for year 1 

# delimit ;
local year=1;
local lb=49;
local ub=51.5;

preserve;
keep if SerialCount3==1;
keep if TaxYear==`year'; 

rename bin3 Bin3_1;
gen Bin3_2=Bin3_1^2;
gen Bin3_3=Bin3_1^3;
gen Bin3_4=Bin3_1^4;

reg Count3 Bin3_1 Bin3_2 Bin3_3 Bin3_4 if Bin3_1>40&Bin3_1<60&(Bin3_1<`lb'|Bin3_1>`ub')&Count3<330;
predict counterfactual;

local constant = _b[_cons]; // This saves the coefficients of the polynomial
display `constant';

forvalues i =1(1)4	{;
	local polycoeff`i' = _b[Bin3_`i'];
	disp `polycoeff`i'';
	gen Bin3_hat_`i'=`polycoeff`i'' * Bin3_`i';
};

local constant = _b[_cons]; // This saves the coefficients of the polynomial
display `constant';
replace counterfactual=Bin3_hat_1+Bin3_hat_2+Bin3_hat_3+Bin3_hat_4+`constant' if Bin3_1>`lb'&Bin3_1<`ub';

gen extra_density = Count3 - counterfactual;

gen below_threshold=.;
replace below_threshold=1 if Bin3_1<50&Bin3_1>=`lb';
replace below_threshold=0 if Bin3_1>=50&Bin3_1<`ub';

egen Total_extra_density=total(extra_density), by(below_threshold);
tab Total_extra_density below_threshold;

sum Total_extra_density if below_threshold==1;
local B=`r(mean)';

gen weights = extra_density/`B';
gen ratio_c = counterfactual*weights;

sum ratio_c if below_threshold==1;
local h_0=`r(mean)'*`r(N)';
drop ratio_c weights;

// Locals to show in box
local b=`B'/`h_0';
local b = round(100*`b')/100;
disp "Bunching estimate for 5 Million Threshold, in year `year', is `b'";
restore; 



//Bunching at 1 million
# delimit ;
local year=2;
local lb=9.4;
local ub=12;
local l_cutoff=5;
local u_cutoff=15;
local Exception=2000;

preserve;
keep if SerialCount3==1;
keep if TaxYear==`year';

rename bin3 Bin3_1;
gen Bin3_2=Bin3_1^2;
gen Bin3_3=Bin3_1^3;
gen Bin3_4=Bin3_1^4;

// for year 1 &Count3<330
# delimit ;
reg Count3 Bin3_1 Bin3_2 Bin3_3 Bin3_4 if Bin3_1>`l_cutoff'&Bin3_1<`u_cutoff'&(Bin3_1<`lb'|Bin3_1>`ub');
predict counterfactual;

local constant = _b[_cons]; // This saves the coefficients of the polynomial
display `constant';

forvalues i =1(1)4	{;
	local polycoeff`i' = _b[Bin3_`i'];
	disp `polycoeff`i'';
	gen Bin3_hat_`i'=`polycoeff`i'' * Bin3_`i';
};

local constant = _b[_cons]; // This saves the coefficients of the polynomial
display `constant';
replace counterfactual=Bin3_hat_1+Bin3_hat_2+Bin3_hat_3+Bin3_hat_4+`constant' if Bin3_1>=`lb'&Bin3_1<`ub';

# delimit ;
gen extra_density = Count3 - counterfactual;

gen below_threshold=.;
replace below_threshold=1 if Bin3_1<10&Bin3_1>=`lb';
replace below_threshold=0 if Bin3_1>=10&Bin3_1<`ub';

egen Total_extra_density=total(extra_density), by(below_threshold);
tab Total_extra_density below_threshold;

sum Total_extra_density if below_threshold==1;
local B=`r(mean)';

gen weights = extra_density/`B';
gen ratio_c = counterfactual*weights;

sum ratio_c if below_threshold==1;
local h_0=`r(mean)'*`r(N)';
drop ratio_c weights;

// Locals to show in box
local b=`B'/`h_0';
local b = round(100*`b')/100;
disp "Bunching estimate for 1 Million Threshold, in year `year', is `b'";
restore; 



// Values of thresholds
// When doing 1 Million = 1
// When doing 5 Million = 5
// When doing 50 Million = 50


#delimit ;
local year=3;
local lb=475;
local ub=540;
local cutoff=500;
local l_cutoff=400;
local u_cutoff=600;
local Exception=2000;

local Threshold=50;

twoway (connected Count3 bin3 if TaxYear==`year'&bin3>`l_cutoff'&bin3<`u_cutoff'&SerialCount3==1&Count3<`Exception', sort)
       (fpfit Count3 bin3 if TaxYear==`year'&bin3>`l_cutoff'&bin3<`u_cutoff'&(bin3<`lb'|bin3>`ub')&SerialCount3==1&Count3<`Exception', estopts(degree(4))), 
	   xline(`cutoff') xline(`lb', lpattern(dash) lcolor(maroon)) xline(`ub', lpattern(dash) lcolor(maroon)) 
	   title("Bunching in Year `year' at `Threshold' Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("Dropping mass between `lb' and `ub' lacs(100,000). 4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear`year'_`Threshold'Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear`year'_`Threshold'Million_Degree4_30000.pdf", as(pdf) replace;


//Printing graphs without the bunching


#delimit ;
local year=5;
local cutoff=500;
local l_cutoff=400;
local u_cutoff=600;
local Exception=2000;

local Threshold=50;

twoway (connected Count3 bin3 if TaxYear==`year'&bin3>`l_cutoff'&bin3<`u_cutoff'&SerialCount3==1&Count3<`Exception', sort)
       (fpfit Count3 bin3 if TaxYear==`year'&bin3>`l_cutoff'&bin3<`u_cutoff'&SerialCount3==1&Count3<`Exception', estopts(degree(4))), 
	   xline(`cutoff')
	   title("Bunching in Year `year' at `Threshold' Million cutoff") 
	   graphregion(color(white)) 
	   xtitle("Revenue (in 30,000 rupees)")
	   note("4th Degree polynomial.");
graph save Graph "F:\Bunching_analysis\BunchingYear`year'_`Threshold'Million_Degree4_30000.gph";
graph export "F:\Bunching_analysis\BunchingYear`year'_`Threshold'Million_Degree4_30000.pdf", as(pdf) replace;


//Revenue Losses
#delimit ;
local year=2;
local lb=9.4;
local ub=12.5;

local cutoff=10;

egen LowerAverage=mean(MoneyDeposited) if bin3>`lb'&bin3<`cutoff'&TaxYear==`year';
egen AboveAverage=mean(MoneyDeposited) if bin3>`cutoff'&bin3<`ub'&TaxYear==`year';

sum LowerAverage if TaxYear==`year';
*local LMean=`r(mean)';

sum AboveAverage if TaxYear==`year';
*local AMean=`r(mean)';






