use "F:\annexure_2A2B_quarterly_2014.dta", clear

use "F:\annexure_2A2B_monthly_201213.dta", clear

/**************************
//Sold TO
***************************/
keep if SourceFile=="t985313"

//Keeping observations for local sales
keep if SaleOrPurchase=="BF"
keep if SalePurchaseType=="LS"

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

keep if DealerGoodType=="RD"|DealerGoodType=="UD"
drop if TransactionType=="None"
keep if TransactionType=="GD"|TransactionType=="WC"

replace Rate=trim(Rate)

replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="0" if Rate=="00.00"
replace Rate="1" if Rate=="1.00"
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


drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

gen TaxMonth=36
gen TaxYear=3

drop SourceFile

gen dummy=1

gen START_ID=DealerTIN
gen END_ID=SellerBuyerTIN
gen type="SOLD_TO"
order START_ID, first

replace SellerBuyerTIN="UD" if DealerGoodType=="UD"&SellerBuyerTIN==""
replace END_ID="UD" if DealerGoodType=="UD"

replace END_ID="MD" if DealerGoodType=="RD"&SellerBuyerTIN==""

gsort START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType Rate Amount
by START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType Rate Amount:gen count=_n
keep if count==1
drop count

by START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType:gen count=_n
by START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType:egen TransActionCount=sum(dummy)
by START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType:egen SumAmount=sum(Amount)
by START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType:egen SumTaxAmount=sum(TaxAmount)
by START_ID END_ID SaleOrPurchase SalePurchaseType DealerGoodType TransactionType:egen SumTotalAmount=sum(TotalAmount)

keep if count==1

drop Amount TaxAmount TotalAmount count TaxRate

order END_ID type, last

save "F:\sold_to_2012_m12.dta", replace
export delimited using "F:\csv\sold_to_2012_m12.csv", delimiter("|") replace


save "F:\sold_to_2013_q4.dta"
export delimited using "F:\csv\sold_to_2013_q4.csv", delimiter("|") replace


/**************************
//Purchased From
***************************/
use "F:\annexure_2A2B_quarterly_2013.dta", clear
*use "F:\annexure_2A2B_monthly_201213.dta", clear
keep if SourceFile=="t9854313"
*keep if SourceFile=="t985313"

//Keeping observations for local Purchases
keep if SaleOrPurchase=="AE"
drop if SellerBuyerTIN==""

keep if SalePurchaseType=="CG"|SalePurchaseType=="OT"|DealerGoodType=="CG"|DealerGoodType=="OT"

drop if SalePurchaseType=="EXG"
drop if SalePurchaseType=="SCPT"
drop if SalePurchaseType=="PUC"
drop if SalePurchaseType=="PAC"
drop if SalePurchaseType=="PEU"
drop if SalePurchaseType=="PTEG"
drop if SalePurchaseType=="IOI"|SalePurchaseType=="ISPC"|SalePurchaseType=="ISTF"
drop if SalePurchaseType=="ISPN"
drop if SalePurchaseType=="SBT"
drop if SalePurchaseType=="GD"
drop if SalePurchaseType=="LS"
drop if SalePurchaseType=="WC"
drop if SalePurchaseType=="GD"&SellerBuyerTIN==""

drop if SalePurchaseType=="07280244855"|SalePurchaseType=="07310179216"|SalePurchaseType=="07370150570"|SalePurchaseType=="07510019252"|SalePurchaseType=="07660231163"|SalePurchaseType=="07750171507"|SalePurchaseType=="07760270005"|SalePurchaseType=="07780333820"|SalePurchaseType=="07830188341"|SalePurchaseType=="07840173446"|SalePurchaseType=="07900195626"
drop if SalePurchaseType=="07160215045"|SalePurchaseType=="07180250730"|SalePurchaseType=="07460365909"|SalePurchaseType=="07680150739"|SalePurchaseType=="07780312286"|SalePurchaseType=="07900312705"

drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

gen TaxMonth=36
gen TaxQuarter=15
gen TaxYear=4

drop SourceFile

gen dummy=1

gen START_ID=DealerTIN
gen END_ID=SellerBuyerTIN
gen type="PURCHASED_FROM"
order START_ID, first

gsort START_ID END_ID Amount
by START_ID END_ID Amount:gen count=_n
keep if count==1
drop count

by START_ID END_ID:gen count=_n
by START_ID END_ID:egen TransActionCount=sum(dummy)
by START_ID END_ID:egen SumAmount=sum(Amount)
by START_ID END_ID:egen SumTaxAmount=sum(TaxAmount)
by START_ID END_ID:egen SumTotalAmount=sum(TotalAmount)

keep if count==1

drop if SumAmount==0&SumTaxAmount==0&SumTotalAmount==0&SellerBuyerTIN==""
replace END_ID="MD" if SellerBuyerTIN==""

drop Amount TaxAmount TotalAmount count TaxRate

order END_ID type, last


replace TransactionType="GD" if TransactionType=="GD "
replace TransactionType="GD" if TransactionType=="GD  "
replace TransactionType="GD" if TransactionType=="GD    "
replace TransactionType="GD" if TransactionType=="GD     "
replace TransactionType="GD" if TransactionType=="GD             "
replace TransactionType="GD" if TransactionType=="Gd"
replace TransactionType="GD" if TransactionType=="gd"
replace TransactionType="GD" if TransactionType=="gd "
replace TransactionType="GD" if TransactionType=="gD"


replace TransactionType="WC" if TransactionType=="wc"
replace TransactionType="WC" if TransactionType=="Wc"

replace TransactionType=trim(TransactionType)

save "F:\data\2a2b\purchased_from_2013_q3.dta", replace
export delimited using "F:\csv\2a2b\purchased_from_2013_q3.csv", delimiter("|") replace





replace Rate=trim(Rate)

replace Rate="0" if Rate=="0.0"
replace Rate="0" if Rate=="0.00"
replace Rate="1" if Rate=="1.00"
replace Rate="12.5" if Rate=="12.50"
replace Rate="12.5" if Rate=="12.500"
replace Rate="12.5" if Rate=="12.5000"
replace Rate="20" if Rate=="20.00"
replace Rate="5" if Rate=="5.0"
replace Rate="5" if Rate=="5.00"
replace Rate="5" if Rate=="5.000"
replace Rate="4" if Rate=="4.00"

replace SalePurchaseType=DealerGoodType if SalePurchaseType==""

		
drop T985DF5 T985DF6 T985DF7 T985DF8 FormsStatus T985DF4

keep if (DealerTIN=="115267"&SellerBuyerTIN=="07026306205")|(DealerTIN=="07026306205"&SellerBuyerTIN=="115267")

