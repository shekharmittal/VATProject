cd "E:\data"

use "annexure_2A2B_quarterly_2013.dta", clear
use "annexure_2A2B_quarterly_2014.dta", clear

//Keep if sales and that too only local
keep if SaleOrPurchase=="BF"&SalePurchaseType=="LS"
keep if DealerGoodType=="RD"|DealerGoodType=="UD"


//Fix all the transaction type
replace TransactionType=trim(TransactionType)
replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gD"
replace TransactionType="GD" if TransactionType=="gd "
replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"

//Clean all the tax rates 
replace Rate=trim(Rate)
replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="05.00"
replace Rate="4" if Rate=="4.00"
replace Rate="12.5" if Rate=="12.00"
replace Rate="12.5" if Rate=="0.12"
replace Rate="1" if Rate=="0.01"
replace Rate="5" if Rate=="0.05"
replace Rate="20" if Rate=="0.20"
replace Rate="2" if Rate=="0.02"


//bys SourceFile TransactionType DealerTIN SellerBuyerTIN Rate Amount TaxAmount: gen Count=_n
//keep if Count==1
//drop Count

//Set TaxQuarters in which the transaction was made based on the SourceFile
gen TaxQuarter=0
replace TaxQuarter=17 if SourceFile=="t9854114"
replace TaxQuarter=18 if SourceFile=="t9854214"
replace TaxQuarter=19 if SourceFile=="t9854314"
replace TaxQuarter=20 if SourceFile=="t9854414"
replace TaxQuarter=13 if SourceFile=="t9854113"
replace TaxQuarter=14 if SourceFile=="t9854213"
replace TaxQuarter=15 if SourceFile=="t9854313"
replace TaxQuarter=16 if SourceFile=="t9854413"


bys TaxQuarter DealerTIN DealerGoodType:gen TransActionCount=_N
by TaxQuarter DealerTIN DealerGoodType:egen SumAmount=sum(Amount)
by TaxQuarter DealerTIN DealerGoodType:egen SumTaxAmount=sum(TaxAmount)
by TaxQuarter DealerTIN DealerGoodType:egen SumTotalAmount=sum(TotalAmount)
by TaxQuarter DealerTIN DealerGoodType:gen Count=_n
keep if Count==1

bys TaxQuarter DealerTIN: egen OverallTaxAmount=sum(SumTaxAmount)
gen TaxProp=SumTaxAmount/OverallTaxAmount

gen RegisteredSalesTax=SumTaxAmount if DealerGoodType=="RD"
bys TaxQuarter DealerTIN: replace RegisteredSalesTax=RegisteredSalesTax[_n-1] if RegisteredSalesTax>=.

gen UnregisteredSalesTax=SumTaxAmount if DealerGoodType=="UD"
gsort TaxQuarter DealerTIN -DealerGoodType
by TaxQuarter DealerTIN: replace UnregisteredSalesTax=UnregisteredSalesTax[_n-1] if UnregisteredSalesTax>=.

replace UnregisteredSalesTax=0 if UnregisteredSalesTax==.
replace RegisteredSalesTax=0 if RegisteredSalesTax==.

drop Count
bys TaxQuarter DealerTIN: gen Count=_n
keep if Count==1

drop SaleOrPurchase SalePurchaseType DealerGoodType TransactionType Rate Amount TaxAmount TotalAmount SellerBuyerTIN DealerName Month Year DateTime ReceiptId Date FormsStatus AEBoolean T985DF1 T985DF2 T985DF3 T985DF4 T985DF5 T985DF6 T985DF7 T985DF8 TransActionCount SumAmount SumTaxAmount SumTotalAmount Count 

save "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_2013.dta"


append using "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_2013.dta"
save "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_201314.dta"


//Repeating the process for the year 2012

use "E:\data\annexure_2A2B_monthly_201213.dta", clear

keep if SaleOrPurchase=="BF"
keep if SalePurchaseType=="LS"|SalePurchaseType==""

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
replace DealerGoodType=trim(DealerGoodType)

keep if DealerGoodType=="RD"|DealerGoodType=="OT"|DealerGoodType=="CG"|DealerGoodType=="UD"


replace Rate=trim(Rate)

replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="0.99"
replace Rate="1" if Rate=="1.00"
replace Rate="1" if Rate=="0.01"
replace Rate="1" if Rate=="1.000"
replace Rate="2" if Rate=="2.00"
replace Rate="2" if Rate=="0.02"
replace Rate="12.5" if Rate=="12.49"
replace Rate="12.5" if Rate=="12.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="12.5" if Rate=="125.00"
replace Rate="20" if Rate=="20.00"
replace Rate="20" if Rate=="20.0"
replace Rate="5" if Rate=="0.05"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="5" if Rate=="5.0000"
replace Rate="5" if Rate=="05.00"
replace Rate="5" if Rate=="4.99"
replace Rate="4" if Rate=="4.00"
replace Rate="4" if Rate=="0.04"
replace Rate="10" if Rate=="0.10"
replace Rate="10" if Rate=="10.00"
replace Rate="12.5" if Rate=="0.12"

drop if Rate=="3.00"
drop if Rate=="2.50"
drop if SellerBuyerTIN=="NA"|SellerBuyerTIN=="0"
drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4
drop if Rate==""
drop if Rate=="10"&DealerTIN=="88719"
drop if Rate=="10"&DealerTIN=="51456"

//bys SourceFile TransactionType DealerTIN SellerBuyerTIN Rate Amount TaxAmount: gen Count=_n
//keep if Count==1
//drop Count

drop if Rate!="5"&Rate!="4"&Rate!="12.5"&Rate!="1"&Rate!="0"&Rate!="2"&Rate!="20"&Rate!="0"

replace DealerGoodType="RD" if (DealerGoodType=="OT"|DealerGoodType=="CG")&SellerBuyerTIN!=""
replace DealerGoodType="UD" if (DealerGoodType=="OT"|DealerGoodType=="CG")&SellerBuyerTIN==""


gen TaxMonth=25 if Month==4
replace TaxMonth=26 if Month==5
replace TaxMonth=27 if Month==6
replace TaxMonth=28 if Month==7
replace TaxMonth=29 if Month==8
replace TaxMonth=30 if Month==9
replace TaxMonth=31 if Month==10
replace TaxMonth=32 if Month==11
replace TaxMonth=33 if Month==12
replace TaxMonth=34 if Month==1
replace TaxMonth=35 if Month==2
replace TaxMonth=36 if Month==3

gen TaxQuarter=0
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36

bys TaxQuarter DealerTIN DealerGoodType:gen TransActionCount=_N
by TaxQuarter DealerTIN DealerGoodType:egen SumAmount=sum(Amount)
by TaxQuarter DealerTIN DealerGoodType:egen SumTaxAmount=sum(TaxAmount)
by TaxQuarter DealerTIN DealerGoodType:egen SumTotalAmount=sum(TotalAmount)
by TaxQuarter DealerTIN DealerGoodType:gen Count=_n
keep if Count==1

bys TaxQuarter DealerTIN: egen OverallTaxAmount=sum(SumTaxAmount)

gen RegisteredSalesTax=SumTaxAmount if DealerGoodType=="RD"
bys TaxQuarter DealerTIN: replace RegisteredSalesTax=RegisteredSalesTax[_n-1] if RegisteredSalesTax>=.

gen UnregisteredSalesTax=SumTaxAmount if DealerGoodType=="UD"
gsort TaxQuarter DealerTIN -DealerGoodType
by TaxQuarter DealerTIN: replace UnregisteredSalesTax=UnregisteredSalesTax[_n-1] if UnregisteredSalesTax>=.

replace UnregisteredSalesTax=0 if UnregisteredSalesTax==.
replace RegisteredSalesTax=0 if RegisteredSalesTax==.

drop Count
bys TaxQuarter DealerTIN: gen Count=_n
keep if Count==1

drop SaleOrPurchase SalePurchaseType DealerGoodType TransactionType Rate Amount TaxAmount TotalAmount SellerBuyerTIN DealerName Month Year DateTime ReceiptId Date AEBoolean T985DF1 T985DF2 T985DF3 TransActionCount SumAmount SumTaxAmount SumTotalAmount Count 

save "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_2012.dta"

append using "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_201314.dta"
save "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_AllQuarters.dta"


//keep if TransactionType=="GD"|TransactionType=="WC"|TransactionType==""

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



gen Government=.
replace Government=1 if Constitution=="Government Company"
replace Government=1 if Constitution=="Government Corporation"
replace Government=1 if Constitution=="Government Department"
replace Government=1 if Constitution=="Public Sector UnderTaking"


replace Government=0 if Constitution=="HUF"
replace Government=0 if Constitution=="Partnership"
replace Government=0 if Constitution=="Private Ltd. Company"
replace Government=0 if Constitution=="Proprietorship"

replace Government=2 if Constitution=="Public Ltd. Company"

/*
replace MoneyDeposited =MoneyDeposited/1000000
replace OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/1000000
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/1000000
replace TurnoverGross=TurnoverGross/1000000
replace TurnoverCentral=TurnoverCentral/1000000
replace TurnoverLocal=TurnoverLocal/1000000
*/

//br if SourceFile=="t9854114"&DummyRetailer==1&DummyManufacturer==0&DummyWholeSaler==0&SaleOrPurchase=="BF"&_merge==3
keep if ((DummyRetailer==1&DummyManufacturer==0&DummyWholeSaler==0)|(DummyRetailer==0&DummyManufacturer==0&DummyWholeSaler==1))


bys TaxQuarter DummyWholeSaler: sum TaxProp if DealerGoodType=="RD", detail
bys TaxQuarter DummyWholeSaler: sum TaxProp if DealerGoodType=="UD", detail

