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


collapse (firstnm) WardName (sum) RefundClaimed TDSCertificates NetTax BalanceBroughtForward CarryForwardTaxCredit BalanceCarriedNextTaxPeriod MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit ExemptedSales TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)


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
by DealerTIN: gen YearCount=_n
gsort DealerTIN TaxYear
by DealerTIN: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen GrowthRate=DeltaMoneyDeposited/MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.


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

keep if TotalCount==5

xtile group1=MoneyDeposited if Treat==1&TaxYear==1 , nq(100) 
xtile group2=MoneyDeposited if Treat==1&TaxYear==2 , nq(100) 
xtile group3=MoneyDeposited if Treat==1&TaxYear==3 , nq(100) 
xtile group4=MoneyDeposited if Treat==1&TaxYear==4 , nq(100)
xtile group5=MoneyDeposited if Treat==1&TaxYear==5 , nq(100) 

gen TreatGroup=group1
replace TreatGroup=group2 if TreatGroup==.
replace TreatGroup=group3 if TreatGroup==.
replace TreatGroup=group4 if TreatGroup==.
replace TreatGroup=group5 if TreatGroup==.

drop group*

xtile group1=MoneyDeposited if Treat==0&TaxYear==1 , nq(100) 
xtile group2=MoneyDeposited if Treat==0&TaxYear==2 , nq(100) 
xtile group3=MoneyDeposited if Treat==0&TaxYear==3 , nq(100) 
xtile group4=MoneyDeposited if Treat==0&TaxYear==4 , nq(100)
xtile group5=MoneyDeposited if Treat==0&TaxYear==5 , nq(100) 

gen ControlGroup=group1
replace ControlGroup=group2 if ControlGroup==.
replace ControlGroup=group3 if ControlGroup==.
replace ControlGroup=group4 if ControlGroup==.
replace ControlGroup=group5 if ControlGroup==.

drop group*



//Trying to do the analysis on frims which belong to KCS
gen SpecialTeam=0 if TaxYear>3
replace SpecialTeam=1 if (WardName=="Ward 201"|WardName=="Ward 202"|WardName=="Ward 203"|WardName=="Ward 204"|WardName=="Ward 205"|WardName=="Ward 206"|WardName=="Ward 207"|WardName=="Ward 208")&TaxYear>3
by DealerTIN: replace SpecialTeam=SpecialTeam[_n-1] if SpecialTeam>=.
collapse (sum) MoneyDeposited, by (TaxYear Treat SpecialTeam)


histogram MoneyDeposited if MoneyDeposited>2&TaxYear==1&MoneyDeposited<12, width(.1) fraction

destring DealerTIN, replace
xtset DealerTIN TaxYear

gen Post=0
replace Post=1 if TaxYear>2


//Regression of the bottom 80% of the firms
gen Treat2=1 if Treat==1&TreatGroup<=80&TaxYear==1
replace Treat2=0 if Treat==0&ControlGroup<=80&TaxYear==1


//Regression of the bottom 90% of the firms
gen Treat2=1 if Treat==1&TreatGroup<=90&TaxYear==1
replace Treat2=0 if Treat==0&ControlGroup<=90&TaxYear==1


//Regression of the top 10%tile of the firms
gen Treat2=1 if Treat==1&TreatGroup>90&TreatGroup<101&TaxYear==1
replace Treat2=0 if Treat==0&ControlGroup>90&ControlGroup<101&TaxYear==1

gen ZeroTaxCredit=0 if TaxYear==1
replace ZeroTaxCredit=1 if TaxYear==1&TaxCreditBeforeAdjustment==0&TurnoverGross>0

gsort DealerTIN TaxYear
by DealerTIN: replace Treat2=Treat2[_n-1] if Treat2>=.
by DealerTIN: replace ZeroTaxCredit=ZeroTaxCredit[_n-1] if ZeroTaxCredit>=.

gen Treat2=1 if Treat==1&TreatGroup==100
replace Treat2=0 if Treat==1&TreatGroup<100
gen Control2=1 if Treat==0&ControlGroup==100
replace Control2=0 if Treat==0&ControlGroup<100


gen Treat2=1 if Treat==1&TreatGroup==100&TaxYear==1
replace Treat2=0 if Treat==1&TreatGroup<100&TaxYear==1
gen Control2=1 if Treat==0&ControlGroup==100&TaxYear==1
replace Control2=0 if Treat==0&ControlGroup<100&TaxYear==1


gsort DealerTIN TaxYear
by DealerTIN: replace Treat2=Treat2[_n-1] if Treat2>=.
by DealerTIN: replace Control2=Control2[_n-1] if Control2>=.


gen Treat2=0 if ControlGroup==100
replace Treat2=1 if TreatGroup==100
replace Treat2=3 if ControlGroup<100
replace Treat2=4 if TreatGroup<100

preserve
collapse (sum) MoneyDeposited, by(TaxYear Treat2)
twoway (connected MoneyDeposited TaxYear if Treat2==1) (connected MoneyDeposited TaxYear if Treat2==0, lpattern(dash)) 
restore


preserve
collapse (sum) MoneyDeposited (sum) AvgMoneyDeposited=MoneyDeposited (semean) SEMoneyDeposited=MoneyDeposited, by(TaxYear Treat2 Control2)
twoway (connected AvgMoneyDeposited TaxYear if Treat2==1) (connected AvgMoneyDeposited TaxYear if Treat2==0, lpattern(dash)) (connected AvgMoneyDeposited TaxYear if Control2==1,lpattern(dash_dot)) (connected AvgMoneyDeposited TaxYear if Control2==0, lpattern(dash_3dot)), xline(2) legend (order(1 "Wholesalers top 1%" 2 "Wholesalers bottom 99%" 3 "Retailers top 1%" 4 "Retailers bottom 99%")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 3297 and number of treatment firms is 1951") graphregion(color(white))
restore 


preserve
collapse (sum) MoneyDeposited (sum) AvgMoneyDeposited=MoneyDeposited (semean) SEMoneyDeposited=MoneyDeposited, by(TaxYear Treat2 Control2)
twoway (connected AvgMoneyDeposited TaxYear if Treat2==1, lpattern(dash)) (connected AvgMoneyDeposited TaxYear if Control2==1, lpattern(dash_3dot)), xline(2) legend (order(1 "Wholesalers top 1%" 2 "Wholesalers bottom 99%" 3 "Retailers top 1%" 4 "Retailers bottom 99%")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 3297 and number of treatment firms is 1951") graphregion(color(white))
restore 


preserve
collapse (mean) MoneyDeposited OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment, by(TaxYear Treat ZeroTaxCredit)
twoway (connected TaxCreditBeforeAdjustment TaxYear if Treat==1&ZeroTaxCredit==0) (connected TaxCreditBeforeAdjustment TaxYear if Treat==1&ZeroTaxCredit==1, lpattern(dash)) (connected TaxCreditBeforeAdjustment TaxYear if Treat==0&ZeroTaxCredit==0, lpattern(dash_dot)) (connected TaxCreditBeforeAdjustment TaxYear if Treat==0&ZeroTaxCredit==1, lpattern(dash_3dot))

restore 




preserve
collapse (sum) MoneyDeposited (mean) AvgMoneyDeposited=MoneyDeposited (semean) SEMoneyDeposited=MoneyDeposited, by(TaxYear Treat2)
gen LHS=AvgMoneyDeposited-1.96*SEMoneyDeposited
gen RHS=AvgMoneyDeposited+1.96*SEMoneyDeposited
twoway (connected AvgMoneyDeposited TaxYear if Treat2==0, lpattern(dash)) (connected LHS TaxYear if Treat2==0, lpattern(dot)) (connected RHS TaxYear if Treat2==0,lpattern(dot)) (connected AvgMoneyDeposited TaxYear if Treat==1) (connected LHS TaxYear if Treat2==1, lpattern(dot)) (connected RHS TaxYear if Treat2==1, lpattern(dot)), xline(2) legend (order(1 "Control Group" 4 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in million rupees. Number of control firms is 3297 and number of treatment firms is 1951") graphregion(color(white))
restore 


gen iPostTreat=Post*Treat2
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
gen iTreat1=Treat2*iTaxYear1
gen iTreat2=Treat2*iTaxYear2
gen iTreat3=Treat2*iTaxYear3
gen iTreat4=Treat2*iTaxYear4	
gen iTreat5=Treat2*iTaxYear5

xtreg MoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5  iTreat1 iTreat2  iTreat4 iTreat5, fe cluster(DealerTIN)
}


areg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TopDecile_TotalCount5_Treat_areg",  tex replace nocons keep(Post iPostTreat) 
areg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TopDecile_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TopDecile_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TopDecile_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TopDecile_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_TopDecile_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 


//For bottom 90%, it seems to be the growth story
areg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom90_TotalCount5_Treat_areg",  tex replace nocons keep(Post iPostTreat) 
areg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom90_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom90_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom90_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom90_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom90_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 


//For bottom 80%, it seems to be the growth story
areg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom80_TotalCount5_Treat_areg",  tex replace nocons keep(Post iPostTreat) 
areg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom80_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom80_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom80_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg OutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom80_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 
areg ZeroTurnover Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, cluster(DealerTIN) absorb(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Bottom80_TotalCount5_Treat_areg",  tex append nocons keep(Post iPostTreat) 



xtreg CreditIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)
xtreg OutputIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, fe cluster(DealerTIN)

xtreg lMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
xtreg lTaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)
xtreg lOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, fe cluster(DealerTIN)




graph bar (sum) MoneyDeposited TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TreatGroup>198&TreatGroup<201, over(TaxYear) blabel(bar)
graph bar (sum) MoneyDeposited TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if ControlGroup>198&ControlGroup<201, over(TaxYear) blabel(bar)


graph bar (sum) MoneyDeposited if TreatGroup>198&TreatGroup<201, over(TaxYear) blabel(bar)
graph bar (sum) MoneyDeposited if TreatGroup>180&TreatGroup<199, over(TaxYear) blabel(bar)



graph bar (sum) MoneyDeposited if TreatGroup>50&TreatGroup<53, over(TaxYear) blabel(bar)



graph bar (sum) MoneyDeposited if ControlGroup>198&ControlGroup!=., over(TaxYear) blabel(bar)
graph bar (sum) MoneyDeposited if ControlGroup<198&ControlGroup!=., over(TaxYear) blabel(bar)


#delimit ;
preserve;
collapse (mean) MoneyDeposited (median) MedMoneyDeposited=MoneyDeposited (p90) p90MoneyDeposited=MoneyDeposited
    (p91) p91MoneyDeposited=MoneyDeposited (p92) p92MoneyDeposited=MoneyDeposited (p70) p70MoneyDeposited=MoneyDeposited
	(p5) p5MoneyDeposited=MoneyDeposited (p10) p10MoneyDeposited=MoneyDeposited
	(p95) p95MoneyDeposited=MoneyDeposited (p93) p93MoneyDeposited=MoneyDeposited
	(p94) p94MoneyDeposited=MoneyDeposited (p96) p96MoneyDeposited=MoneyDeposited
	(p97) p97MoneyDeposited=MoneyDeposited (p98) p98MoneyDeposited=MoneyDeposited
	(max) maxMoneyDeposited=MoneyDeposited (p99) p99MoneyDeposited=MoneyDeposited
	(sum) TotalMoneyDeposited=MoneyDeposited (p80) p80MoneyDeposited=MoneyDeposited (p85) p85MoneyDeposited=MoneyDeposited
    , by(TaxYear Treat); 
twoway (connected p70MoneyDeposited TaxYear if Treat==0) (connected p70MoneyDeposited TaxYear if Treat==1);
restore;


//As discussed, when we run the mean regression on always present not good guys, then also the mean regressions work.
preserve
drop if TotalCount==5&lMoneyDeposited!=.&lTaxCreditBeforeAdjustment!=.&lOutputTaxBeforeAdjustment!=.&Treat2!=.
gsort DealerTIN TaxYear
bys DealerTIN: gen Count2=_N
keep if Count2==5
tab TaxYear Treat2
xtreg OutputTaxBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5, fe cluster(DealerTIN)
restore 

log close

twoway (connected MoneyDeposited TaxYear if Treat==0)

twoway (connected MoneyDeposited TaxYear if Treat==0) (scatter MedMoneyDeposited TaxYear)
twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MedMoneyDeposited TaxYear)
twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MedMoneyDeposited TaxYear if Treat==0)
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (scatter p90MoneyDeposited TaxYear)
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p90MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) (connected p10MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) (connected p10MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p95MoneyDeposited TaxYear) (connected p10MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p95MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) if Treat==0
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) if Treat==1
twoway (connected MoneyDeposited TaxYear) (connected MedMoneyDeposited TaxYear if Treat==0) (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) (connected p10MoneyDeposited TaxYear) if Treat==1

twoway (connected MoneyDeposited TaxYear)  (connected p90MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) (connected p98MoneyDeposited TaxYear) if Treat==1

twoway (connected maxMoneyDeposited TaxYear if Treat==0) (connected maxMoneyDeposited TaxYear if Treat==1)


twoway (connected p91MoneyDeposited TaxYear) (connected p90MoneyDeposited TaxYear) (connected MoneyDeposited TaxYear) (connected p92MoneyDeposited TaxYear) (connected p93MoneyDeposited TaxYear) (connected p94MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) (connected p96MoneyDeposited TaxYear) (connected p97MoneyDeposited TaxYear) (connected p98MoneyDeposited TaxYear) (connected p99MoneyDeposited TaxYear) if Treat==1


twoway (connected p91MoneyDeposited TaxYear) (connected p90MoneyDeposited TaxYear) (connected MoneyDeposited TaxYear) (connected p92MoneyDeposited TaxYear) (connected p93MoneyDeposited TaxYear) (connected p94MoneyDeposited TaxYear) (connected p95MoneyDeposited TaxYear) (connected p96MoneyDeposited TaxYear) (connected p97MoneyDeposited TaxYear) (connected p98MoneyDeposited TaxYear) (connected p99MoneyDeposited TaxYear) if Treat==0
