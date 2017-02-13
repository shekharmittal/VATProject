/*
In this file, we do analysis categorised on the proportion of transactions that are happening 
with already identified bogus firms.
We further focus on only those firms which themselves have not been identified as bogus.
*/

//Hypothesis 1: Firms that deal only with Fraud Dealers are definitely fraud
//Here we try to get hold of these firms and see their impact on moneydeposited 
use "D:\data\annexure_2A2B_quarterly_2013.dta", clear 

drop if SellerBuyerTIN==""
keep if (SaleOrPurchase=="BF"&SalePurchaseType=="LS")|(SaleOrPurchase=="AE")|(SaleOrPurchase=="AN")
drop if DealerGoodType=="PPD"|DealerGoodType=="PUR"|DealerGoodType=="PCD"|DealerGoodType=="PCGM"


//Merge Bogus information with seller/buyer tins
rename DealerTIN dealertin
rename SellerBuyerTIN DealerTIN
merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SellerBuyerBogus=0
replace SellerBuyerBogus=1 if _merge_bogus2==3
rename DealerTIN SellerBuyerTIN
rename dealertin DealerTIN
drop _merge_bogus2
rename Reasons SellerBuyerReasons
rename CancellationDate SellerBuyerCancellation


//Merge Bogus information with main DealerTins
merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen BogusDummy=0
replace BogusDummy=1 if _merge_bogus2==3
drop _merge_bogus2
rename Reasons BogusDealerReasons
rename CancellationDate BogusDealerCancellationDate

replace DealerGoodType="OT" if DealerGoodType==" OT"
replace DealerGoodType="OT" if DealerGoodType=="OT             "
replace DealerGoodType="OT" if DealerGoodType=="OT     "
replace DealerGoodType="OT" if DealerGoodType=="OT "
replace DealerGoodType="OT" if DealerGoodType=="OT  "
replace DealerGoodType="OT" if DealerGoodType=="Ot"
replace DealerGoodType="OT" if DealerGoodType=="ot"
replace DealerGoodType="OT" if DealerGoodType=="ot "
replace DealerGoodType="OT" if DealerGoodType=="OT  "

replace DealerGoodType="UD" if DealerGoodType=="uD"
replace DealerGoodType="UD" if DealerGoodType=="ud"


replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "

replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"


replace TransactionType=trim(TransactionType)

drop if SalePurchaseType=="EXG"
drop if SalePurchaseType=="SCPT"
drop if SalePurchaseType=="PAC"
drop if SalePurchaseType=="PEU"
drop if SalePurchaseType=="PTEG"
drop if SalePurchaseType=="IOI"|SalePurchaseType=="ISPC"|SalePurchaseType=="ISTF"
drop if SalePurchaseType=="ISPN"
drop if SalePurchaseType=="SBT"
drop if SalePurchaseType=="GD"&SellerBuyerTIN==""

drop if SalePurchaseType=="07280244855"|SalePurchaseType=="07310179216"|SalePurchaseType=="07370150570"|SalePurchaseType=="07510019252"|SalePurchaseType=="07660231163"|SalePurchaseType=="07750171507"|SalePurchaseType=="07760270005"|SalePurchaseType=="07780333820"|SalePurchaseType=="07830188341"|SalePurchaseType=="07840173446"|SalePurchaseType=="07900195626"
drop if SalePurchaseType=="07160215045"|SalePurchaseType=="07180250730"|SalePurchaseType=="07460365909"|SalePurchaseType=="07680150739"|SalePurchaseType=="07780312286"|SalePurchaseType=="07900312705"

drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

bys SourceFile DealerTIN:gen Count=_N
by SourceFile DealerTIN:egen TransactionWithBogus=sum(SellerBuyerBogus)
by SourceFile DealerTIN:gen TransactionCount=_n

gen ProportionTransactionWithBogus=TransactionWithBogus/Count

sum Count SellerBuyerBogus ProportionTransactionWithBogus if TransactionCount==1&BogusDummy==1
sum Count SellerBuyerBogus ProportionTransactionWithBogus if TransactionCount==1&BogusDummy==0

keep if ProportionTransactionWithBogus>0&TransactionCount==1

keep DealerTIN BogusDummy Count SourceFile ProportionTransactionWithBogus
gen TaxQuarter=0
replace TaxQuarter=13 if SourceFile=="t9854113"
replace TaxQuarter=14 if SourceFile=="t9854213"
replace TaxQuarter=15 if SourceFile=="t9854313"
replace TaxQuarter=16 if SourceFile=="t9854413"
save "H:\BogusDealer_analysis\FishyBogusDealers.dta", replace

//Now repeat the exercise with Year 5 of data
use "D:\data\annexure_2A2B_quarterly_2013.dta", clear 

drop if SellerBuyerTIN==""
keep if (SaleOrPurchase=="BF"&SalePurchaseType=="LS")|(SaleOrPurchase=="AE")|(SaleOrPurchase=="AN")
drop if DealerGoodType=="PPD"|DealerGoodType=="PUR"|DealerGoodType=="PCD"|DealerGoodType=="PCGM"


//Merge Bogus information with seller/buyer tins
rename DealerTIN dealertin
rename SellerBuyerTIN DealerTIN
merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SellerBuyerBogus=0
replace SellerBuyerBogus=1 if _merge_bogus2==3
rename DealerTIN SellerBuyerTIN
rename dealertin DealerTIN
drop _merge_bogus2
rename Reasons SellerBuyerReasons
rename CancellationDate SellerBuyerCancellation


//Merge Bogus information with main DealerTins
merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen BogusDummy=0
replace BogusDummy=1 if _merge_bogus2==3
drop _merge_bogus2
rename Reasons BogusDealerReasons
rename CancellationDate BogusDealerCancellationDate

replace DealerGoodType="OT" if DealerGoodType==" OT"
replace DealerGoodType="OT" if DealerGoodType=="OT             "
replace DealerGoodType="OT" if DealerGoodType=="OT     "
replace DealerGoodType="OT" if DealerGoodType=="OT "
replace DealerGoodType="OT" if DealerGoodType=="OT  "
replace DealerGoodType="OT" if DealerGoodType=="Ot"
replace DealerGoodType="OT" if DealerGoodType=="ot"
replace DealerGoodType="OT" if DealerGoodType=="ot "
replace DealerGoodType="OT" if DealerGoodType=="OT  "

replace DealerGoodType="UD" if DealerGoodType=="uD"
replace DealerGoodType="UD" if DealerGoodType=="ud"


replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "

replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"


replace TransactionType=trim(TransactionType)

drop if SalePurchaseType=="EXG"
drop if SalePurchaseType=="SCPT"
drop if SalePurchaseType=="PAC"
drop if SalePurchaseType=="PEU"
drop if SalePurchaseType=="PTEG"
drop if SalePurchaseType=="IOI"|SalePurchaseType=="ISPC"|SalePurchaseType=="ISTF"
drop if SalePurchaseType=="ISPN"
drop if SalePurchaseType=="SBT"
drop if SalePurchaseType=="GD"&SellerBuyerTIN==""

drop if SalePurchaseType=="07280244855"|SalePurchaseType=="07310179216"|SalePurchaseType=="07370150570"|SalePurchaseType=="07510019252"|SalePurchaseType=="07660231163"|SalePurchaseType=="07750171507"|SalePurchaseType=="07760270005"|SalePurchaseType=="07780333820"|SalePurchaseType=="07830188341"|SalePurchaseType=="07840173446"|SalePurchaseType=="07900195626"
drop if SalePurchaseType=="07160215045"|SalePurchaseType=="07180250730"|SalePurchaseType=="07460365909"|SalePurchaseType=="07680150739"|SalePurchaseType=="07780312286"|SalePurchaseType=="07900312705"

drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

bys SourceFile DealerTIN:gen Count=_N
by SourceFile DealerTIN:egen TransactionWithBogus=sum(SellerBuyerBogus)
by SourceFile DealerTIN:gen TransactionCount=_n

gen ProportionTransactionWithBogus=TransactionWithBogus/Count

keep if ProportionTransactionWithBogus>0&TransactionCount==1

keep DealerTIN BogusDummy Count SourceFile ProportionTransactionWithBogus
gen TaxQuarter=0
replace TaxQuarter=17 if SourceFile=="t9854114"
replace TaxQuarter=18 if SourceFile=="t9854214"
replace TaxQuarter=19 if SourceFile=="t9854314"
replace TaxQuarter=20 if SourceFile=="t9854414"
append "H:\BogusDealer_analysis\FishyBogusDealers.dta"

save "H:\BogusDealer_analysis\FishyBogusDealers.dta", replace

/*
tab Fishy BogusDummy if TransactionCount==1

           |      BogusDummy
     Fishy |         0          1 |     Total
-----------+----------------------+----------
         0 |   741,535     21,249 |   762,784 
         1 |     3,427        315 |     3,742 
-----------+----------------------+----------
     Total |   744,962     21,564 |   766,526 

	 
 sum Count SellerBuyerBogus ProportionTransactionWithBogus if TransactionCount==
> 1&BogusDummy==1

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
       Count |     21564    19.28413    77.47178          1       4960
SellerBuy~us |     21564    .1030885    .3040815          0          1
Proportion~s |     21564    .1035692     .196099          0          1

. sum Count SellerBuyerBogus ProportionTransactionWithBogus if TransactionCount==
> 1&BogusDummy==0

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
       Count |    744962    19.79346     74.1921          1      19816
SellerBuy~us |    744962    .0313466    .1742527          0          1
Proportion~s |    744962    .0311759    .1027849          0          1

*/


cd "D:\data"
use "PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear

drop groupid ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory


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


merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"
merge m:1 DealerTIN using "H:\MinDistanceFromStartEndNodes.dta", generate(_merge_distanceq13)


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

gen PositiveContribution=0
replace PositiveContribution=1 if MoneyDeposited>0


log using "H:\BogusDealer_analysis\ProportionAnalysis_logs.log"
sum ProportionTransactionWithBogus if TaxQuarter==14&SecondBogusDummy==0, detail
sum ProportionTransactionWithBogus if TaxQuarter==14&SecondBogusDummy==1, detail

sum ProportionTransactionWithBogus if TaxQuarter==16&SecondBogusDummy==0, detail
sum ProportionTransactionWithBogus if TaxQuarter==16&SecondBogusDummy==1, detail

sum ProportionTransactionWithBogus if TaxQuarter==18&SecondBogusDummy==0, detail
sum ProportionTransactionWithBogus if TaxQuarter==18&SecondBogusDummy==1, detail


//We compare firms which have been identified as bogus vs those that have not
//However both these type of firms are only interacting with identified bogus dealers
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==13&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==13&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==14&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==14&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==15&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==15&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==16&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==16&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==17&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==17&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==18&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==18&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==19&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==19&ProportionTransactionWithBogus==1&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==20&ProportionTransactionWithBogus==1&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution if _merge==3&TaxQuarter==20&ProportionTransactionWithBogus==1&SecondBogusDummy==1

//Now we compare firmst which have high transactions with bogus dealers with those that do not
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==13&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==13&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==14&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==14&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==15&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==15&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==16&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==16&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==17&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==17&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==18&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==18&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==19&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==19&ProportionTransactionWithBogus>0.5

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==20&ProportionTransactionWithBogus<0.5
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==20&ProportionTransactionWithBogus>0.5

//Now we compare firmst which have transactions with bogus dealers with those that do not
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==13&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==13&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==13&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==13&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==14&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==14&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==14&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==14&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==15&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==15&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==15&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==15&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==16&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==16&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==16&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==16&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==17&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==17&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==17&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==17&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==18&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==18&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==18&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==18&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==19&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==19&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==19&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==19&SecondBogusDummy==1

sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==20&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==1&TaxQuarter==20&SecondBogusDummy==1
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==20&SecondBogusDummy==0
sum TurnoverGross TurnoverCentral TurnoverLocal ExemptedSales PurchaseTaxFreeGoods OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment NetTax TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer MoneyDeposited TotalLocalValueAdded TotalValueAdded PositiveContribution ProportionTransactionWithBogus SecondBogusDummy if _merge==3&TaxQuarter==20&SecondBogusDummy==1

//Now we look at a network statistic
tab max_stat_min if _merge==3&TaxQuarter==14&SecondBogusDummy==0&Category=="Private"&ProportionTransactionWithBogus<0.5
tab max_stat_min if _merge==3&TaxQuarter==14&SecondBogusDummy==1&Category=="Private"&ProportionTransactionWithBogus>0.5
tab max_stat_min if _merge==3&TaxQuarter==14&SecondBogusDummy==0&Category=="Private"&ProportionTransactionWithBogus>0.5


tab max_stat_min if _merge==3&TaxQuarter==16&SecondBogusDummy==0&Category=="Private"&ProportionTransactionWithBogus<0.5
tab max_stat_min if _merge==3&TaxQuarter==16&SecondBogusDummy==1&Category=="Private"&ProportionTransactionWithBogus>0.5
tab max_stat_min if _merge==3&TaxQuarter==16&SecondBogusDummy==0&Category=="Private"&ProportionTransactionWithBogus>0.5


tab max_stat_min if _merge==3&TaxQuarter==18&SecondBogusDummy==0&Category=="Private"&ProportionTransactionWithBogus<0.5
tab max_stat_min if _merge==3&TaxQuarter==18&SecondBogusDummy==1&Category=="Private"&ProportionTransactionWithBogus>0.5
tab max_stat_min if _merge==3&TaxQuarter==18&SecondBogusDummy==0&Category=="Private"&ProportionTransactionWithBogus>0.5

log close

/*

 sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==13

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |       838     9074568    4.25e+07          0   8.00e+08
TaxCreditB~t |       838    335674.5     1818359          0   3.47e+07
OutputTaxB~t |       838    314574.9     1897921          0   3.94e+07
MoneyDepos~d |       838    22800.31    224472.7          0    4708081

. sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==14

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |       904     9677877    5.97e+07          0   1.48e+09
TaxCreditB~t |       904    258041.3     1450059          0   3.33e+07
OutputTaxB~t |       904    320635.6     2087928          0   4.30e+07
MoneyDepos~d |       904    63234.63     1443356          0   4.30e+07

. sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==15

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |       912    1.08e+07    6.35e+07          0   1.51e+09
TaxCreditB~t |       912    276169.5     1707835          0   2.36e+07
OutputTaxB~t |       912    228427.9     1526184          0   2.33e+07
MoneyDepos~d |       912     13717.5    122135.1          0    3094386

. sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==16

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |       872    1.05e+07    5.56e+07          0   1.08e+09
TaxCreditB~t |       872    199231.5    883077.9          0   1.14e+07
OutputTaxB~t |       872    234743.2     1120767          0   1.51e+07
MoneyDepos~d |       872    15935.95    101433.5          0    1867449

 sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==13&TurnoverGross>10000000

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |        86    7.93e+07    1.11e+08   1.03e+07   8.00e+08
TaxCreditB~t |        86     2892849     5008705          0   3.47e+07
OutputTaxB~t |        86     2871591     5296860          0   3.94e+07
MoneyDepos~d |        86    161413.7    682773.6          0    4708081

. sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==14&TurnoverGross>10000000

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |        96    8.09e+07    1.68e+08   1.00e+07   1.48e+09
TaxCreditB~t |        96     1990183     4047037          0   3.33e+07
OutputTaxB~t |        96     2789929     5871944          0   4.30e+07
MoneyDepos~d |        96    542811.7     4419952          0   4.30e+07

. sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==15&TurnoverGross>10000000

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |        99    9.17e+07    1.73e+08   1.01e+07   1.51e+09
TaxCreditB~t |        99     1917924     4253758          0   2.33e+07
OutputTaxB~t |        99     1927544     4282172          0   2.33e+07
MoneyDepos~d |        99    81101.61    355284.2          0    3094386

. sum TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment MoneyDepo
> sited if _merge==3&TaxQuarter==16&TurnoverGross>10000000

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |       111    7.50e+07    1.40e+08   1.01e+07   1.08e+09
TaxCreditB~t |       111     1316055     2161948          0   1.14e+07
OutputTaxB~t |       111     1619691     2768684          0   1.51e+07
MoneyDepos~d |       111    67815.72    250943.6          0    1867449

. 



*/
