/*In this file we use the cancellation form data to identify firms that have been classified as fraudulent.
We do this by looking at the reason for cancellation. A lot of the times, the reason for cancellation
is "Firm not found" or the likes. 
*/

use "E:\data\CancellationForm.dta", clear
drop if DealerTIN==""
gsort DealerTIN idCancellation

gen dNotFunctioning=0
gen dReturnDefaulter=0


replace dNotFunctioning = 1 if(regexm(lower(Reasons), "(.*no.*function.*)"))
replace dReturnDefaulter=1 if (regexm(lower(Reasons),".*(return).*(file).*"))
gen dFunction=1 if (regexm(lower(Reasons), "(.*function.*)"))

edit if dFunction==1&dNotFunctioning==0

replace dNotFunctioning = 1 in 643
replace dNotFunctioning = 1 in 8074
replace dNotFunctioning = 1 in 16828
replace dNotFunctioning = 1 in 21068
replace dNotFunctioning = 1 in 26390
replace dNotFunctioning = 1 in 26783
replace dNotFunctioning = 1 in 277313
replace dNotFunctioning = 1 in 276892
replace dNotFunctioning = 1 in 270917
replace dNotFunctioning = 1 in 270557
replace dNotFunctioning = 1 in 270426
replace dNotFunctioning = 1 in 267505
replace dNotFunctioning = 1 in 261350
replace dNotFunctioning = 1 in 258272
replace dNotFunctioning = 1 in 255687
replace dNotFunctioning = 1 in 252034
replace dNotFunctioning = 1 in 246405
replace dNotFunctioning = 1 in 242578
replace dNotFunctioning = 1 in 242373
replace dNotFunctioning = 1 in 231165
replace dNotFunctioning = 1 in 218056
replace dNotFunctioning = 1 in 211000
replace dNotFunctioning = 1 in 208260
replace dNotFunctioning = 1 in 207379
replace dNotFunctioning = 1 in 201764
replace dNotFunctioning = 1 in 201736
replace dNotFunctioning = 1 in 189605
replace dNotFunctioning = 1 in 189011
replace dNotFunctioning = 1 in 176637
replace dNotFunctioning = 1 in 173738
replace dNotFunctioning = 1 in 173733
replace dNotFunctioning = 1 in 171202
replace dNotFunctioning = 1 in 165390
replace dNotFunctioning = 1 in 164790
replace dNotFunctioning = 1 in 164583
replace dNotFunctioning = 1 in 164577
replace dNotFunctioning = 1 in 162065
replace dNotFunctioning = 1 in 161655
replace dNotFunctioning = 1 in 158829
replace dNotFunctioning = 1 in 157985
replace dNotFunctioning = 1 in 155242
replace dNotFunctioning = 1 in 149489
replace dNotFunctioning = 1 in 146291
replace dNotFunctioning = 1 in 145972
replace dNotFunctioning = 1 in 143625
replace dNotFunctioning = 1 in 140341
replace dNotFunctioning = 1 in 140261
replace dNotFunctioning = 1 in 140029
replace dNotFunctioning = 1 in 122008
replace dNotFunctioning = 1 in 106798
replace dNotFunctioning = 1 in 103431
replace dNotFunctioning = 1 in 97374
replace dNotFunctioning = 1 in 95840
replace dNotFunctioning = 1 in 92564
replace dNotFunctioning = 1 in 87484
replace dNotFunctioning = 1 in 86995
replace dNotFunctioning = 1 in 67087
replace dNotFunctioning = 1 in 66475
replace dNotFunctioning = 1 in 61585
replace dNotFunctioning = 1 in 64581
replace dNotFunctioning = 0 in 64581
replace dNotFunctioning = 1 in 60594
replace dNotFunctioning = 1 in 48395
replace dNotFunctioning = 1 in 46777
replace dNotFunctioning = 1 in 30280
replace dNotFunctioning = 1 in 23609
replace dNotFunctioning = 1 in 20170

replace dNotFunctioning=. if dNotFunctioning==0


// First we import the date from the Effective date
gen EffectiveYear=dofc(DateEffective)
format %td EffectiveYear //change it into date format
//Import just the year inf
gen EndYearEffective=yofd(EffectiveYear)
gen EndMonthEffective=mofd(EffectiveYear)
//Changing the format to appropriate year form

format %tm EndMonthEffective
format %ty EndYearEffective 

/* Begin analysis for number of registrations between 2010 and 2015*/
gen month=EndMonthEffective
gen year=1 if month>602&month<=614
replace year=2 if month>614&month<=626
replace year=3 if month>626&month<=638
replace year=4 if month>638&month<=650
replace year=5 if month>650&month<=662
replace year=6 if month>662&month<=674
//In this definition month=1 is January 2010
//replace month=month-599 
//In this definition month=1 is April 2010
replace month=month-602 

rename month EffectiveMonth
rename year EffectiveYearTax

label variable EffectiveYearTax "Year of the effective date based on tax financial years"
keep if EffectiveYearTax!=.


* fill the missing values
gsort DealerTIN idCancellation
by DealerTIN: replace dNotFunctioning=dNotFunctioning[_n-1] if dNotFunctioning>=.
gsort DealerTIN -idCancellation
by DealerTIN: replace dNotFunctioning=dNotFunctioning[_n-1] if dNotFunctioning>=.

  
// First we import the date from the Cancellation date
gen CancellationYear=dofc(CancellationDate)
format %td CancellationYear //change it into date format
//Import just the year inf
gen EndYear=yofd(CancellationYear)
gen EndMonth=mofd(CancellationYear)
//Changing the format to appropriate year form

format %tm EndMonth
format %ty EndYear 

/* Begin analysis for number of registrations between 2010 and 2015*/
gen month=EndMonth
gen year=1 if month>602&month<=614
replace year=2 if month>614&month<=626
replace year=3 if month>626&month<=638
replace year=4 if month>638&month<=650
replace year=5 if month>650&month<=662
replace year=6 if month>662&month<=674
//In this definition month=1 is January 2010
//replace month=month-599 
//In this definition month=1 is April 2010
replace month=month-602 

rename month CancellationMonth
rename year EndYearTax

label variable EndYearTax "Year of the cancellation date based on tax financial years"


keep if dNotFunctioning==1
//keep if dNotFunctioning==1&Count==1
gsort DealerTIN -idCancellation
by DealerTIN: gen Count=_n
by DealerTIN: gen ReturnCount=_N
keep if Count==1

keep DealerTIN CancellationDate Reasons DateEffective CancellationMonth EndYearTax EndMonthEffective EffectiveMonth EffectiveYearTax CancellationYear
label data "list of Bogus Dealers that are identified from Cancellation records and cancelled in our year"
save "E:\data\PreliminaryAnalysis\BogusDealers\Bogus_CancellationData.dta", replace


use "E:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear 
merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\Bogus_CancellationData.dta", keepusing(EffectiveMonth EffectiveYearTax)


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


drop if _merge==2
keep if TaxQuarter==20&_merge==3
keep DealerTIN

save "E:\data\PreliminaryAnalysis\BogusDealers\T20PresentFirms.dta", replace
export excel using "E:\data\PreliminaryAnalysis\BogusDealers\ExistingPotentialFirms.xls"
