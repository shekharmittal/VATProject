use "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseTaxAmount20121314.dta", clear
drop TotalCountPurchaseTransactions TotalPurchaseAmount

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge m:1 TaxQuarter DealerTIN  using "E:\data\PreliminaryAnalysis\BogusDealers\FeatureReturns.dta", keepusing(UnTaxProp CreditRatio VatRatio) generate(returns_merge)  keep(master match) 


rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

replace UnTaxProp=0 if UnTaxProp==.
replace CreditRatio=0 if CreditRatio==.
replace VatRatio=0 if VatRatio==.

gen WUnTaxProp=PurchaseTaxAmount*UnTaxProp
gen WCreditRatio=PurchaseTaxAmount*CreditRatio
gen WVatRatio=PurchaseTaxAmount*VatRatio

gsort TaxQuarter DealerTIN
by TaxQuarter DealerTIN: gen TotalSellers=_N
by TaxQuarter DealerTIN: egen MaxPurchaseTaxAmount=max(PurchaseTaxAmount)
by TaxQuarter DealerTIN: egen TotalPurchaseTaxAmount=sum(PurchaseTaxAmount)
by TaxQuarter DealerTIN: egen SumWUnTaxProp=sum(WUnTaxProp)
by TaxQuarter DealerTIN: egen SumWCreditRatio=sum(WCreditRatio)
by TaxQuarter DealerTIN: egen SumWVatRatio=sum(WVatRatio)
by TaxQuarter DealerTIN: gen Count=_n

keep if Count==1

gen MaxPurchaseProp=MaxPurchaseTaxAmount/TotalPurchaseTaxAmount
gen PurchaseDSUnTaxProp=SumWUnTaxProp/TotalPurchaseTaxAmount
gen PurchaseDSCreditRatio=SumWCreditRatio/TotalPurchaseTaxAmount
gen PurchaseDSVatRatio=SumWVatRatio/TotalPurchaseTaxAmount

gen Missing_PurchaseDSUnTaxProp=0
gen Missing_PurchaseDSCreditRatio=0
gen Missing_PurchaseDSVatRatio=0
gen Missing_MaxPurchaseProp=0

replace Missing_PurchaseDSUnTaxProp=1 if PurchaseDSUnTaxProp==.
replace Missing_PurchaseDSCreditRatio=1 if PurchaseDSCreditRatio==.
replace Missing_PurchaseDSVatRatio=1 if PurchaseDSVatRatio==.
replace Missing_MaxPurchaseProp=1 if MaxPurchaseProp==.

replace PurchaseDSUnTaxProp=0 if PurchaseDSUnTaxProp==.
replace PurchaseDSCreditRatio=0 if PurchaseDSCreditRatio==.
replace PurchaseDSVatRatio=0 if PurchaseDSVatRatio==.
replace MaxPurchaseProp=0 if MaxPurchaseProp==.


drop VatRatio CreditRatio SellerBuyerTIN UnTaxProp returns_merge WUnTaxProp WCreditRatio WVatRatio SumWUnTaxProp TotalPurchaseTaxAmount SumWCreditRatio SumWVatRatio Count PurchaseTaxAmount MaxPurchaseTaxAmount

save "E:\data\PreliminaryAnalysis\BogusDealers\FeatureDownStreamnessPurchases.dta"

use "E:\data\PreliminaryAnalysis\BogusDealers\SalesTaxAmount20121314.dta", clear

drop TotalCountSaleTransactions TotalSalesAmount

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge m:1 TaxQuarter DealerTIN  using "E:\data\PreliminaryAnalysis\BogusDealers\FeatureReturns.dta", keepusing(UnTaxProp CreditRatio VatRatio) generate(returns_merge)  keep(master match) 


rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

replace UnTaxProp=0 if UnTaxProp==.
replace CreditRatio=0 if CreditRatio==.
replace VatRatio=0 if VatRatio==.

gen WUnTaxProp=SalesTaxAmount*UnTaxProp
gen WCreditRatio=SalesTaxAmount*CreditRatio
gen WVatRatio=SalesTaxAmount*VatRatio

gsort TaxQuarter DealerTIN
by TaxQuarter DealerTIN: gen TotalBuyers=_N
by TaxQuarter DealerTIN: egen TotalSalesTaxAmount=sum(SalesTaxAmount)
by TaxQuarter DealerTIN: egen MaxSalesTaxAmount=max(SalesTaxAmount)
by TaxQuarter DealerTIN: egen SumWUnTaxProp=sum(WUnTaxProp)
by TaxQuarter DealerTIN: egen SumWCreditRatio=sum(WCreditRatio)
by TaxQuarter DealerTIN: egen SumWVatRatio=sum(WVatRatio)
by TaxQuarter DealerTIN: gen Count=_n


keep if Count==1

gen MaxSalesProp=MaxSalesTaxAmount/TotalSalesTaxAmount
gen SalesDSUnTaxProp=SumWUnTaxProp/TotalSalesTaxAmount
gen SalesDSCreditRatio=SumWCreditRatio/TotalSalesTaxAmount
gen SalesDSVatRatio=SumWVatRatio/TotalSalesTaxAmount

gen Missing_SalesDSUnTaxProp=0
gen Missing_SalesDSCreditRatio=0
gen Missing_SalesDSVatRatio=0
gen Missing_MaxSalesProp=0

replace Missing_SalesDSUnTaxProp=1 if SalesDSUnTaxProp==.
replace Missing_SalesDSCreditRatio=1 if SalesDSCreditRatio==.
replace Missing_SalesDSVatRatio=1 if SalesDSVatRatio==.
replace Missing_MaxSalesProp=1 if MaxSalesProp==.

replace SalesDSUnTaxProp=0 if SalesDSUnTaxProp==.
replace SalesDSCreditRatio=0 if SalesDSCreditRatio==.
replace SalesDSVatRatio=0 if SalesDSVatRatio==.
replace MaxSalesProp=0 if MaxSalesProp==.

drop VatRatio CreditRatio SellerBuyerTIN UnTaxProp returns_merge WUnTaxProp WCreditRatio WVatRatio SumWUnTaxProp TotalSalesTaxAmount SumWCreditRatio SumWVatRatio Count SalesTaxAmount MaxSalesTaxAmount

save "E:\data\PreliminaryAnalysis\BogusDealers\FeatureDownStreamnessSales.dta", replace


use "E:\data\PreliminaryAnalysis\BogusDealers\FeatureReturns.dta", clear
merge 1:1 DealerTIN TaxQuarter using "E:\data\PreliminaryAnalysis\BogusDealers\FeatureDownStreamnessSales.dta", keep(master match) generate(ds_purchase_merge)
tab TaxQuarter ds_purchase_merge
sum TotalSellers PurchaseDSCreditRatio PurchaseDSUnTaxProp PurchaseDSVatRatio if ds_purchase_merge==3&bogus_online==0
sum TotalSellers PurchaseDSCreditRatio PurchaseDSUnTaxProp PurchaseDSVatRatio if ds_purchase_merge==3&bogus_online==1

sum TotalSellers PurchaseDSCreditRatio PurchaseDSUnTaxProp PurchaseDSVatRatio Missing_PurchaseDS* if ds_purchase_merge==3&bogus_online==1
sum TotalSellers PurchaseDSCreditRatio PurchaseDSUnTaxProp PurchaseDSVatRatio Missing_PurchaseDS* if ds_purchase_merge==3&bogus_online==0

sum TotalBuyers SalesDSUnTaxProp SalesDSCreditRatio SalesDSVatRatio Missing_SalesDSUnTaxProp Missing_SalesDS* if ds_purchase_merge==3&bogus_online==1
sum TotalBuyers SalesDSUnTaxProp SalesDSCreditRatio SalesDSVatRatio Missing_SalesDSUnTaxProp Missing_SalesDS* if ds_purchase_merge==3&bogus_online==0

tab Missing_PurchaseDS*
tab Missing_PurchaseDSCreditRatio
tab Missing_PurchaseDSUnTaxProp
tab Missing_PurchaseDSVatRatio
tab Missing_PurchaseDSUnTaxProp bogus_online

