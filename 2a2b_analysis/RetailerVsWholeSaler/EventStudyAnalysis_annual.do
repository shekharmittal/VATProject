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


collapse (firstnm) WardName (sum) TurnoverAt20 TurnoverAt125 TurnoverAt5 TurnoverAt1 PurchaseGoodsAt1 PurchaseGoodsAt5 PurchaseGoodsAt125 PurchaseGoodsAt20 AdjustCSTLiability RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0

gsort DealerTIN TaxYear
by DealerTIN: gen TotalCount=_N
by DealerTIN: gen YearCount=_n
gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

keep if TotalCount==5

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.

gen VatDecrease=0 if DeltaMoneyDeposited!=.
replace VatDecrease=1 if DeltaMoneyDeposited<0&DeltaMoneyDeposited

replace MoneyDeposited =MoneyDeposited/1000000
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/1000000
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/1000000
replace TurnoverGross=TurnoverGross/1000000
replace TurnoverCentral=TurnoverCentral/1000000
replace TurnoverLocal=TurnoverLocal/1000000
replace DeltaMoneyDeposited =DeltaMoneyDeposited/1000000

replace TurnoverAt1=TurnoverAt1/1000000
replace TurnoverAt125=TurnoverAt125/1000000
replace TurnoverAt20=TurnoverAt20/1000000
replace TurnoverAt5=TurnoverAt5/1000000
replace PurchaseGoodsAt1=PurchaseGoodsAt1/1000000
replace PurchaseGoodsAt125=PurchaseGoodsAt125/1000000
replace PurchaseGoodsAt20=PurchaseGoodsAt20/1000000
replace PurchaseGoodsAt5=PurchaseGoodsAt5/1000000

        
gen VatRatio=MoneyDeposited/TurnoverGross
gen CreditRatio=TaxCreditBeforeAdjustment/TurnoverGross
gen TaxRatio=OutputTaxBeforeAdjustment/TurnoverGross
gen InterstateRatio=TurnoverCentral/TurnoverGross
gen LocalVatRatio=MoneyDeposited/TurnoverLocal
gen LocalCreditRatio=TaxCreditBeforeAdjustment/TurnoverLocal
gen LocalTaxRatio=OutputTaxBeforeAdjustment/TurnoverLocal
gen Diff=OutputTaxBeforeAdjustment-TaxCreditBeforeAdjustment

gen PurchaseGoodsAt1Ratio=PurchaseGoodsAt1/TurnoverGross
gen PurchaseGoodsAt125Ratio=PurchaseGoodsAt125/TurnoverGross
gen PurchaseGoodsAt20Ratio=PurchaseGoodsAt20/TurnoverGross
gen PurchaseGoodsAt5Ratio=PurchaseGoodsAt5/TurnoverGross

gen TurnoverAt1Ratio=TurnoverAt1/TurnoverGross
gen TurnoverAt125Ratio=TurnoverAt125/TurnoverGross
gen TurnoverAt20Ratio=TurnoverAt20/TurnoverGross
gen TurnoverAt5Ratio=TurnoverAt5/TurnoverGross




gen lMoneyDeposited=log(MoneyDeposited)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)


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


label variable iTreat1 "-2"
label variable iTreat2 "-1"
label variable iTreat3 "0"
label variable iTreat4 "+1"
label variable iTreat5 "+2"



matrix C = J(3,5,.)
matrix rownames C = mean ll95 ul95
matrix colnames C = iTreat1 iTreat2 iTreat3 iTreat4 iTreat5

matrix C[1,2]=0 
matrix C[2,2]=0 
matrix C[3,2]=0 



# delimit;
areg PositiveContribution iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons Post iTaxYear2 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
	     graphregion(color(white))
		  xtitle("Years with respect to the introduction of the policy")
	     title("Coefficient for PositiveContribution") 
	     note( "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\PositiveContribution.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\PositiveContribution.pdf", as(pdf) replace;
		 
# delimit;
areg VatIncrease iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for VatIncrease")  
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\VatIncrease.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\VatIncrease.pdf", as(pdf) replace;

		 
		 
		 
# delimit;
areg MoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for MoneyDeposited")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\MoneyDeposited.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\MoneyDeposited.pdf", as(pdf) replace;

		 
# delimit;
areg TaxCreditBeforeAdjustment iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for TaxCredit")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\TaxCreditBeforeAdjustment.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\TaxCreditBeforeAdjustment.pdf", as(pdf) replace;

		 
# delimit;
areg OutputTaxBeforeAdjustment iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for Output Tax")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\OutputTaxBeforeAdjustment.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\OutputTaxBeforeAdjustment.pdf", as(pdf) replace;

		 		 		 
	# delimit;
	areg Diff iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for OutputTax-InputCredit ")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\Diff.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\Diff.pdf", as(pdf) replace;

		 		 		 
# delimit;
areg InterstateRatio iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for Central Turnover/Total Turnover ")
		 xtitle("Years with respect to the introduction of the policy")
	     note("Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\InterstateRatio.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\InterstateRatio.pdf", as(pdf) replace;

		 
gen lDiff=log(Diff+1)
gen Diff2=-Diff
replace lDiff=-log(Diff2+1) if lDiff==.

# delimit;
areg lDiff iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for Log(OutputTax-InputCredit)")
		 xtitle("Years with respect to the introduction of the policy")
	     note("Number of retailers is 32979 and number of wholesalers is 19515" "If the difference is negative, we do -(log(abs(diff)))");

graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\LogDiff.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\LogDiff.pdf", as(pdf) replace;
