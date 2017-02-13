/* The goal is to do a preliminary feature vector analysis to find the important
features which can help us identify fraudulent dealers.
1. The first step is to create a dataset of annual firm level information.
2. We will repeat the analysis at the quarterly firm level as well

1. If tax contribution is positive repeatedly or not
   1. At the annual level
   2. At the quarterly level
1. Repeated interactions with the same purchasers, who are not depositing money as well
2. Inconsistent filers of returns
   1. At the quarterly level
1. If Turnover too high without any contribution
   1. At annual level
   2. At quarter level
1. More towards the beginning of the VAT chain than towards the end
   1. Merge sdistance and edistance information
1. Too much variance in output tax
   1. At the annual level
   2. At the quarterly level
1. Too much variance in input credits
   1. At the annual level
   2. At the quarterly level
1. High purchases consistently but no sales
2. More central sales
3. Tax declines 
4. Recent registration but high turnover
5. Are sellers to the firm depositing taxes?
   1. Upto what level?
1. Are most sales to registered firms?
1. What is the proportion of sales that is being made to fraud firms?
2. Is SOLD_TO and PURCHASED_FROM network data matching?
3. Is the refund being claimed?
   1. What is the refund to collection ratio
1. Industry norms on
   1. Refund levels
1. Create table 9.1 of markup ranges
2. Consistently low markups
3. Reverse transactions
4. Coterie of firms dealing with each other with little final goods
5. Firms with zero turnover
6. Number of mismatch reports generated

*/
cd "D:\data"

//First we use the annual returns
use "PreliminaryAnalysis\returns\form16_data_v3_0901_annual filings.dta", clear
use "PreliminaryAnalysis\returns\form16_data_v3_0901_halfyearly filings.dta", clear
use "PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear
use "PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta", clear

drop groupid ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory


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

gen TaxYear=0
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

gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)
gen TotalPurchases=PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer
gen PercValueAdded=(TurnoverGross-TotalPurchases)/(TotalPurchases)
gen TotalValueAdded=(TurnoverGross-TotalPurchases)
gen TotalLocalValueAdded=(TurnoverLocal-TotalPurchases)
gen PercPurchaseUnregisteredDealer=PurchaseUnregisteredDealer/(TotalPurchases)

*label variable PurchaseNoCredit "R6.3 Total local purchases that are no eligible for credit of input tax"
label variable PercValueAdded "A measure of fraction of value added, definition is (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseUnregisteredDealer)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseUnregisteredDealer "A measure of amount purchased from unregistered dealers:PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisterdDealer)"
label variable TotalValueAdded "Total value added, (TurnoverGross-TotalPurchases)"
label variable TotalPurchases "Total purchases made: PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseUnregisteredDealer"
label variable TotalLocalValueAdded "Total Local Value added, (TurnoverLocal - TotalPurchases)"

isid DealerTIN TaxMonth
collapse (sum) OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(DealerTIN TaxYear) fast

gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))
gen l2TotalTaxCredit=log(TotalTaxCredit+sqrt(TotalTaxCredit^2+1))
gen l2TotalOutputTax=log(TotalOutputTax+sqrt(TotalOutputTax^2+1))
gen l2TurnoverGross=log(TurnoverGross+sqrt(TurnoverGross^2+1))
gen l2TurnoverLocal=log(TurnoverLocal+sqrt(TurnoverLocal^2+1))
gen l2TotalValueAdded=log(TotalValueAdded+sqrt(TotalValueAdded^2+1))
gen l2TotalLocalValueAdded=log(TotalLocalValueAdded+sqrt(TotalLocalValueAdded^2+1))
gen l2PurchaseUnregisteredDealer=log(PurchaseUnregisteredDealer+sqrt(PurchaseUnregisteredDealer^2+1))
gen l2CreditOtherGoods=log(CreditOtherGoods+sqrt(CreditOtherGoods^2+1))
gen l2CreditCapitalGoods=log(CreditCapitalGoods+sqrt(CreditCapitalGoods^2+1))
gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2AdjustmentTaxCredit=log(AdjustmentTaxCredit+sqrt(AdjustmentTaxCredit^2+1))
gen l2TotalPurchases=log(TotalPurchases+sqrt(TotalPurchases^2+1))
gen l2TotalInterStateSale=log(TotalInterStateSale+sqrt(TotalInterStateSale^2+1))
gen l2TotalInterStatePurchase=log(TotalInterStatePurchase+sqrt(TotalInterStatePurchase^2+1))
gen l2OutwardStockTransferBranchF=log(OutwardStockTransferBranchF+sqrt(OutwardStockTransferBranchF^2+1))
gen l2InwardStockTransferBranchF=log(InwardStockTransferBranchF+sqrt(InwardStockTransferBranchF^2+1))
gen l2OutwardStockTransferConF=log(OutwardStockTransferConsignmentF+sqrt(OutwardStockTransferConsignmentF^2+1))
gen l2InwardStockTransferConF=log(InwardStockTransferConsignmentF+sqrt(InwardStockTransferConsignmentF^2+1))
gen l2InterStateSaleCD=log(InterStateSaleCD+sqrt(InterStateSaleCD^2+1))
gen l2InterStatePurchaseCD=log(InterStatePurchaseCD+sqrt(InterStatePurchaseCD^2+1))
gen l2InterStatePurchaseCE1E2=log(InterStatePurchaseCE1E2+sqrt(InterStatePurchaseCE1E2^2+1))
gen l2InterStateSaleCE1E2=log(InterStateSaleCE1E2+sqrt(InterStateSaleCE1E2^2+1))
gen l2InterStateExportsAgainstH=log(InterStateExportsAgainstH+sqrt(InterStateExportsAgainstH^2+1))
gen l2InterStateImportsAgainstH=log(InterStateImportsAgainstH+sqrt(InterStateImportsAgainstH^2+1))
gen l2InterStateExportsAgainstI=log(InterStateExportsAgainstI+sqrt(InterStateExportsAgainstI^2+1))
gen l2InterStateImportsAgainstI=log(InterStateImportsAgainstI+sqrt(InterStateImportsAgainstI^2+1))
gen l2InterStateExportsAgainstJ=log(InterStateExportsAgainstJ+sqrt(InterStateExportsAgainstJ^2+1))
gen l2InterStateImportsAgainstJ=log(InterStateImportsAgainstJ+sqrt(InterStateImportsAgainstJ^2+1))


gen Sourcefile="Annual"
save __temp_annual.dta

gen Sourcefile="SemiAnnual"
save __temp_semiannual.dta

gen Sourcefile="Quarter"
save __temp_quarter.dta

gen Sourcefile="Month"
save __temp_month.dta, replace

use "D:\data\__temp_month.dta", clear
append using "D:\data\__temp_annual.dta" "D:\data\__temp_quarter.dta" "D:\data\__temp_semiannual.dta"

//Dropping sequences that should not exist
//No annual and semi-annual returns in year 3, no monthly returns in year 5 
drop if Sourcefile=="Annual"&TaxYear==3
drop if Sourcefile=="SemiAnnual"&TaxYear==3
drop if Sourcefile=="Month"&TaxYear==4

gsort DealerTIN TaxYear
by DealerTIN TaxYear:gen Count=_N
by DealerTIN TaxYear:gen RunningCount=_n

//For now drop all the duplicate entries
keep if Count==1
//(4496 observations deleted)

merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"
merge m:1 DealerTIN using "H:\MinDistanceFromStartEndNodes.dta", generate(_merge_distanceq13)

/*
 merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"

    Result                           # of obs.
    -----------------------------------------
    not matched                        69,430
        from master                    60,837  (_merge==1)
        from using                      8,593  (_merge==2)

    matched                         1,120,082  (_merge==3)
    -----------------------------------------
*/
drop if _merge==2
drop if _merge_distanceq13==2


merge m:1 DealerTIN using "H:\bogus_identified.dta", keepusing(Bogus) generate(_merge_bogus)
drop if _merge_bogus==2
gen BogusDummy=0
replace BogusDummy=1 if Bogus=="YES"

merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if _merge_bogus2==3

merge m:1 DealerTIN using "D:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax) generate(_merge_dp)
keep if _merge_dp==1|_merge_dp==3

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




/*
HIGH SEA PURCHASER AND SELLER
HIGH SEA SALES
Right to Use/Lease
JOB WORK
Trader
TRADING
GARMENT
Garment
REAL ESTATE DEVELOPERS
Construction
CONSTRUCTION
CIVIL CONTRACTOR
Civil Contractor
Leasing
LEASING
Fabricator
PRINTING PRESS
PRINTING
Printing
SOFTWARE
Software
*/

tabulate Constitution, generate(dConstitution)
tab Ward, generate(dWard)


// First we import the date from the registration date
gen RegistrationYear=dofc(RegistrationDate)
format %td RegistrationYear //change it into date format
//Import just the year inf
gen StartYear=yofd(RegistrationYear) 
gen StartMonth=mofd(RegistrationYear)
format %tm StartMonth
format %ty StartYear 
//Changing the format to appropriate year form

tab StartYear, generate(dStartYear)

gen Government=0
replace Government=1 if Constitution=="Government Company"
replace Government=1 if Constitution=="Government Corporation"
replace Government=1 if Constitution=="Government Department"
replace Government=1 if Constitution=="Public Sector UnderTaking"


gen Category=""
replace Category="Government" if Constitution=="Government Company"
replace Category="Government" if Constitution=="Government Corporation"
replace Category="Government" if Constitution=="Government Department"
replace Category="Government" if Constitution=="Public Sector UnderTaking"

replace Category="Public" if Constitution=="Public Ltd. Company"

replace Category="Private" if Constitution=="HUF"
replace Category="Private" if Constitution=="Partnership"
replace Category="Private" if Constitution=="Private Ltd. Company"
replace Category="Private" if Constitution=="Proprietorship"

gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0
gsort DealerTIN TaxYear ZeroTurnover

by DealerTIN: gen ReturnCount=_N
by DealerTIN: egen ZeroCount=sum(ZeroTurnover)

histogram l2MoneyDeposited, by(SecondBogusDummy)
histogram l2TurnoverGross, by(SecondBogusDummy)


cd "H:\BogusDealer_analysis"
ssc install ttable2 logout
logout, save(summary_SecondBogusDummy_Allyear) excel replace: ttable2 l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2OutwardStockTransferBranchF l2InwardStockTransferBranchF l2OutwardStockTransferConF l2InwardStockTransferConF l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited TurnoverLocal TurnoverCentral TurnoverGross TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit, by(SecondBogusDummy)
logout, save(summary_SecondBogusDummy_YEAR1) excel replace: ttable2 l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2OutwardStockTransferBranchF l2InwardStockTransferBranchF l2OutwardStockTransferConF l2InwardStockTransferConF l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited TurnoverLocal TurnoverCentral TurnoverGross TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit if TaxYear==1, by(SecondBogusDummy)
logout, save(summary_SecondBogusDummy_YEAR2) excel replace: ttable2 l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2OutwardStockTransferBranchF l2InwardStockTransferBranchF l2OutwardStockTransferConF l2InwardStockTransferConF l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited TurnoverLocal TurnoverCentral TurnoverGross TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit if TaxYear==2, by(SecondBogusDummy)
logout, save(summary_SecondBogusDummy_YEAR3) excel replace: ttable2 l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2OutwardStockTransferBranchF l2InwardStockTransferBranchF l2OutwardStockTransferConF l2InwardStockTransferConF l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited TurnoverLocal TurnoverCentral TurnoverGross TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit if TaxYear==3, by(SecondBogusDummy)
logout, save(summary_SecondBogusDummy_YEAR4) excel replace: ttable2 l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2OutwardStockTransferBranchF l2InwardStockTransferBranchF l2OutwardStockTransferConF l2InwardStockTransferConF l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited TurnoverLocal TurnoverCentral TurnoverGross TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit if TaxYear==4, by(SecondBogusDummy)
logout, save(summary_SecondBogusDummy_YEAR5) excel replace: ttable2 l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2OutwardStockTransferBranchF l2InwardStockTransferBranchF l2OutwardStockTransferConF l2InwardStockTransferConF l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ TotalLocalValueAdded TotalValueAdded TotalPurchases MoneyDeposited TurnoverLocal TurnoverCentral TurnoverGross TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit if TaxYear==5, by(SecondBogusDummy)

drop Count
by DealerTIN: gen Count=_n
tab ReturnCount ZeroCount if Count==1

gsort DealerTIN TaxYear
//Now we are ready to do annual feature vector analysis
// First analysis is on zero turnover
by DealerTIN: gen ZeroTurnover_prev=ZeroTurnover[_n-1]
gen SignChange=(ZeroTurnover_prev!=ZeroTurnover)&ZeroTurnover_prev!=.
by DealerTIN: egen NumSignChange=sum(SignChange)


log using "H:\BogusDealer_analysis\interesting_logs.log", append
tab ReturnCount ZeroCount if Count==1&SecondBogusDummy==1
tab ReturnCount ZeroCount if Count==1&SecondBogusDummy==0

tab DummyRetailer SecondBogusDummy if Count==1
tab DummyRetailer SecondBogusDummy if Count==1, missing
tab DummyManufacturer SecondBogusDummy if Count==1, missing
tab DummyWholeSaler SecondBogusDummy if Count==1, missing
tab DummyInterStateSeller SecondBogusDummy if Count==1, missing
tab DummyInterStatePurchaser SecondBogusDummy if Count==1, missing
tab DummyWorkContractor SecondBogusDummy if Count==1, missing
tab DummyImporter SecondBogusDummy if Count==1, missing
tab DummyExporter SecondBogusDummy if Count==1, missing
tab DummyOther SecondBogusDummy if Count==1, missing

tab NumSignChange if Count==1&SecondBogusDummy==1
tab ReturnCount NumSignChange if Count==1&SecondBogusDummy==0
tab ReturnCount NumSignChange if Count==1&SecondBogusDummy==1

. sum SignChange

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
  SignChange |   1179499     .055811    .2295564          0          1

. corr SignChange Count
(obs=1179499)

             | SignCh~e    Count
-------------+------------------
  SignChange |   1.0000
       Count |   0.0542   1.0000


. corr SignChange ReturnCount
(obs=1179499)

             | SignCh~e Return~t
-------------+------------------
  SignChange |   1.0000
 ReturnCount |  -0.1006   1.0000



//Now need to merge this with Bogus Dealer Info

erase __temp_month.dta
erase __temp_quarter.dta
erase __temp_annual.dta
erase __temp_semiannual.dta


//Bogus firms more likely to not have filed DP1
//Amongst those that filed DP1, more likely to be Proprietorships
tab Constitution SecondBogusDummy if Count==1, missing
tab _merge_dp SecondBogusDummy if Count==1

//Need to fix this: do regex matching
tab Nature BogusDummy if Count==1, missing

//Less likely to be registered for 
//1. Import export
//2. Central Excise
//3. Service Tax
//Not true if we use _merge_bogus2
tab BooleanRegisteredIEC SecondBogusDummy if Count==1, missing
tab BooleanRegisteredCE SecondBogusDummy if Count==1, missing
tab BooleanServiceTax  SecondBogusDummy if Count==1, missing
tab BooleanInterState   SecondBogusDummy if Count==1, missing

//Most Bogus firms established recently
//But this is not informative as registration highest in 2012
//if use _merge_bogus2, most thigns start in 2007, presumably after CRC
tab StartYear BogusDummy if Count==1, missing

use "H:\data\BogusDealerAnalysisAnnual_06282016.dta", clear


//Need to analyze this further
tab max_stat_min SecondBogusDummy if Count==1,missing
tab max_stat_p10 SecondBogusDummy if Count==1,missing
tab median_stat_min SecondBogusDummy if Count==1, missing
tab sdistance SecondBogusDummy if Count==1, missing
tab edistance SecondBogusDummy if Count==1, missing


gen PositiveValue=0
replace PositiveValue=TotalValueAdded>0
tab PositiveValue SecondBogusDummy
tab PositiveValue SecondBogusDummy if TurnoverGross>5000000
tab PositiveValue SecondBogusDummy if TurnoverGross>50000000
tab PositiveValue SecondBogusDummy if TurnoverGross>100000000
tab PositiveValue SecondBogusDummy if TurnoverGross>200000000

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0
tab PositiveContribution SecondBogusDummy if TurnoverGross>200000000

tab PositiveContribution if TurnoverLocal>50000000

drop AwesomeDealer
gen AwesomeDealer=0
gen TestMoneyDeposited=0
replace TestMoneyDeposited=0.04*TotalValueAdded if TotalValueAdded>0
replace AwesomeDealer=1 if TestMoneyDeposited<=MoneyDeposited
tab SecondBogusDummy AwesomeDealer

gen AwesomeDealer2=0
replace AwesomeDealer2=1 if TotalLocalValueAdded>0
tab SecondBogusDummy AwesomeDealer2
tab AwesomeDealer2 if SecondBogusDummy==0
tab AwesomeDealer2 if SecondBogusDummy==1

replace TestMoneyDeposited=0
replace TestMoneyDeposited=0.04*TotalLocalValueAdded if TotalLocalValueAdded>0
replace AwesomeDealer=1 if TestMoneyDeposited<MoneyDeposited&TotalLocalValueAdded>0

gen AwesomeDealer3=0
replace AwesomeDealer3=1 if TotalLocalValueAdded>.1*TurnoverLocal
tab SecondBogusDummy AwesomeDealer3
tab AwesomeDealer3 if SecondBogusDummy==0
tab AwesomeDealer3 if SecondBogusDummy==1

gen AwesomeDealer4=0
replace AwesomeDealer4=1 if AwesomeDealer2==1&AwesomeDealer3==1

tab AwesomeDealer4 SecondBogusDummy
tab AwesomeDealer4 if SecondBogusDummy==0
tab AwesomeDealer4 if SecondBogusDummy==1


tab Constitution AwesomeDealer3
tab Constitution AwesomeDealer2
tab Constitution AwesomeDealer
tab Constitution AwesomeDealer4
log close
/*

. tab AwesomeDealer3 BogusDummy

AwesomeDea |      BogusDummy
      ler3 |         0          1 |     Total
-----------+----------------------+----------
         0 |   984,284      1,468 |   985,752 
         1 |   195,105         62 |   195,167 
-----------+----------------------+----------
     Total | 1,179,389      1,530 | 1,180,919 



. tab AwesomeDealer3 if TurnoverGross>5000000&BogusDummy==0

AwesomeDeal |
        er3 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    366,173       81.40       81.40
          1 |     83,683       18.60      100.00
------------+-----------------------------------
      Total |    449,856      100.00

. tab AwesomeDealer3 if TurnoverGross>5000000&BogusDummy==1

AwesomeDeal |
        er3 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |        980       97.90       97.90
          1 |         21        2.10      100.00
------------+-----------------------------------
      Total |      1,001      100.00


*/
br TotalValueAdded TurnoverLocal MoneyDeposited DealerTIN TaxYear AwesomeDealer BogusDummy if AwesomeDealer2==1
tab AwesomeDealer2 BogusDummy


gen Fishy=0
replace Fishy=1 if TotalPurchases>TurnoverGross
by DealerTIN:egen CountFishy=sum(Fishy)
by DealerTIN:egen SuperTotalPurchases=sum(TotalPurchases)
by DealerTIN:egen SuperTurnoverGross=sum(TurnoverGross)
by DealerTIN:egen SuperTurnoverLocal=sum(TurnoverLocal)
by DealerTIN:egen SuperMoneyDeposited=sum(MoneyDeposited)
by DealerTIN:egen SuperTotalLocalValueAdded=sum(TotalLocalValueAdded)
by DealerTIN:egen SuperTotalValueAdded=sum(TotalValueAdded)


gen Fishy2=0
replace Fishy2=SuperTotalPurchases>SuperTurnoverGross
/*
tab ReturnCount Fishy2 if Count==1&BogusDummy==0

ReturnCoun |        Fishy2
         t |         0          1 |     Total
-----------+----------------------+----------
         1 |    40,804     11,847 |    52,651 
         2 |    37,596     10,258 |    47,854 
         3 |    42,510     14,206 |    56,716 
         4 |    28,887      2,931 |    31,818 
         5 |   143,266      3,456 |   146,722 
-----------+----------------------+----------
     Total |   293,063     42,698 |   335,761 


. tab ReturnCount Fishy2 if Count==1&BogusDummy==1

ReturnCoun |        Fishy2
         t |         0          1 |     Total
-----------+----------------------+----------
         1 |         8          6 |        14 
         2 |       113         32 |       145 
         3 |       147         36 |       183 
         4 |        75         13 |        88 
         5 |        63          2 |        65 
-----------+----------------------+----------
     Total |       406         89 |       495 

*/
gen Fishy3=0
replace Fishy3=SuperTotalPurchases>SuperTurnoverLocal

gen Fishy4=0
replace Fishy4=SuperMoneyDeposited==0

/*
. tab ReturnCount Fishy3 if Count==1&BogusDummy==1

ReturnCoun |        Fishy3
         t |         0          1 |     Total
-----------+----------------------+----------
         1 |         7          7 |        14 
         2 |        85         60 |       145 
         3 |       117         66 |       183 
         4 |        58         30 |        88 
         5 |        57          8 |        65 
-----------+----------------------+----------
     Total |       324        171 |       495 


. tab ReturnCount Fishy3 if Count==1&BogusDummy==0

ReturnCoun |        Fishy3
         t |         0          1 |     Total
-----------+----------------------+----------
         1 |    35,503     17,148 |    52,651 
         2 |    30,042     17,812 |    47,854 
         3 |    29,826     26,890 |    56,716 
         4 |    21,483     10,335 |    31,818 
         5 |   103,593     43,129 |   146,722 
-----------+----------------------+----------
     Total |   220,447    115,314 |   335,761 

*/

log using "H:\BogusDealer_analysis\interesting_logs.log", append
//replace Fishy=1 if TotalPurchases>TurnoverGross
tab Fishy SecondBogusDummy
tab CountFishy SecondBogusDummy if Count==1
//replace Fishy2=SuperTotalPurchases>SuperTurnoverGross
tab Fishy2 SecondBogusDummy if Count==1
tab Fishy2 if SecondBogusDummy==0&Count==1
tab Fishy2 if SecondBogusDummy==1&Count==1
//replace Fishy3=SuperTotalPurchases>SuperTurnoverLocal
tab Fishy3 SecondBogusDummy if Count==1
tab Fishy3 if SecondBogusDummy==0&Count==1
tab Fishy3 if SecondBogusDummy==1&Count==1
//replace Fishy4=SuperMoneyDeposited==0
tab Fishy4 SecondBogusDummy if Count==1
tab Fishy4 if SecondBogusDummy==0&Count==1
tab Fishy4 if SecondBogusDummy==1&Count==1

sum Super* if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1
sum Super* if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1
log close



	tab CountFishy BogusDummy if Count==1

sum SuperTotalValueAdded if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1
sum SuperTotalValueAdded if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1
sum Super* if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1&SuperTurnoverGross>10000000
sum Super* if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1&SuperTurnoverGross>10000000
sum Super* if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1&SuperTurnoverLocal>10000000
sum Super* if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1&SuperTurnoverLocal>10000000
sum SuperTurnoverLocal if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1
sum SuperTurnoverLocal if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==, detail
sum SuperTurnoverLocal if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1, detail
sum SuperTurnoverLocal if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1, detail
sum SuperTotalValueAdded if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1, detail
sum SuperTotalValueAdded if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1, detail
tab ReturnCount if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1
tab ReturnCount if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1
sum SuperTotalValueAdded if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum SuperTotalValueAdded if SecondBogusDummy=10&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum SuperTotalValueAdded if SecondBogusDummy=1&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum SuperTotalValueAdded if SecondBogusDummy=1&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum SuperTotalValueAdded if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum SuperTotalValueAdded if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum Super* if SecondBogusDummy==1&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail
sum Super* if SecondBogusDummy==0&Constitution=="Proprietorship"&Count==1&ReturnCount==5, detail


histogram SuperTurnoverLocal if Count==1&ReturnCount==5&SuperTurnoverLocal>0, by(SecondBogusDummy)
histogram SuperTurnoverLocal if Count==1&ReturnCount==5&SuperTurnoverLocal>2000000, by(SecondBogusDummy)
