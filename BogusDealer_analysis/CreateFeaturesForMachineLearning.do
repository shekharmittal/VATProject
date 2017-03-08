//Creating variables for sale and purchase discrepancies
{
use "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseTaxAmount20121314.dta", clear

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 TaxQuarter DealerTIN SellerBuyerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\SalesTaxAmount20121314.dta"

replace SalesTaxAmount=0 if SalesTaxAmount==.&_merge==1
replace PurchaseTaxAmount=0 if PurchaseTaxAmount==.&_merge==2

gen DiffTaxAmount=SalesTaxAmount-PurchaseTaxAmount
gen absDiffTaxAmount=abs(DiffTaxAmount)
gen maxSalesTaxAmount=max(SalesTaxAmount,PurchaseTaxAmount)


//Sales
drop if _merge==1

bys TaxQuarter DealerTIN: egen diff=sum(DiffTaxAmount)
bys TaxQuarter DealerTIN: egen absdiff=sum(absDiffTaxAmount)
bys TaxQuarter DealerTIN: egen maxSalesTax=sum(maxSalesTaxAmount)
bys TaxQuarter DealerTIN: gen Count=_n

gen SaleDiscrepancy=diff/maxSalesTax
gen absSaleDiscrepancy=absdiff/maxSalesTax
keep if Count==1

drop SellerBuyerTIN maxSalesTaxAmount absDiffTaxAmount DiffTaxAmount TotalSalesAmount SalesTaxAmount TotalCountSaleTransactions TotalPurchaseAmount PurchaseTaxAmount TotalCountPurchaseTransactions

save "E:\data\PreliminaryAnalysis\BogusDealers\SaleDiscrepancy.dta"


//Purchase
drop if _merge==2

bys TaxQuarter SellerBuyerTIN: egen diff=sum(DiffTaxAmount)
bys TaxQuarter SellerBuyerTIN: egen absdiff=sum(absDiffTaxAmount)
bys TaxQuarter SellerBuyerTIN: egen maxPurchaseTax=sum(maxSalesTaxAmount)
bys TaxQuarter SellerBuyerTIN: gen Count=_n

gen PurchaseDiscrepancy=diff/maxPurchaseTax
gen absPurchaseDiscrepancy=absdiff/maxPurchaseTax
keep if Count==1

drop Count DealerTIN maxSalesTaxAmount absDiffTaxAmount DiffTaxAmount TotalSalesAmount SalesTaxAmount TotalCountSaleTransactions TotalPurchaseAmount PurchaseTaxAmount TotalCountPurchaseTransactions
replace PurchaseDiscrepancy=0 if PurchaseDiscrepancy==.
replace absPurchaseDiscrepancy=0 if absPurchaseDiscrepancy==.

rename SellerBuyerTIN DealerTIN

save "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseDiscrepancy.dta"
}


{
use "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseTaxAmount20121314.dta", clear

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 TaxQuarter DealerTIN SellerBuyerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\SalesTaxAmount20121314.dta"

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

bys TaxQuarter DealerTIN _merge: gen TotalCount=_N
bys TaxQuarter DealerTIN _merge: gen Count=_n
bys TaxQuarter DealerTIN _merge: egen TotalPurchaseTaxAmount=sum(PurchaseTaxAmount)
bys TaxQuarter DealerTIN _merge: egen TotalSalesTaxAmount=sum(SalesTaxAmount)

replace TotalSalesTaxAmount=0 if TotalSalesTaxAmount==.&_merge==1
replace TotalPurchaseTaxAmount=0 if TotalPurchaseTaxAmount==.&_merge==2

keep if Count==1

bys TaxQuarter DealerTIN: gen OtherDeclarationCount=TotalCount if _merge==2
bys TaxQuarter DealerTIN: gen MyDeclarationCount=TotalCount if _merge==1
bys TaxQuarter DealerTIN: gen MatchDeclarationCount=TotalCount if _merge==3

bys TaxQuarter DealerTIN: gen OtherDeclarationTax=TotalSalesTaxAmount if _merge==2
bys TaxQuarter DealerTIN: gen MyDeclarationTax=TotalPurchaseTaxAmount if _merge==1
bys TaxQuarter DealerTIN: gen MatchDeclarationTax=TotalPurchaseTaxAmount if _merge==3

gsort TaxQuarter DealerTIN _merge
by TaxQuarter DealerTIN: replace OtherDeclarationCount=OtherDeclarationCount[_n-1] if OtherDeclarationCount>=.
by TaxQuarter DealerTIN: replace MyDeclarationCount=MyDeclarationCount[_n-1] if MyDeclarationCount>=.
by TaxQuarter DealerTIN: replace MatchDeclarationCount=MatchDeclarationCount[_n-1] if MatchDeclarationCount>=.
by TaxQuarter DealerTIN: replace OtherDeclarationTax=OtherDeclarationTax[_n-1] if OtherDeclarationTax>=.
by TaxQuarter DealerTIN: replace MyDeclarationTax=MyDeclarationTax[_n-1] if MyDeclarationTax>=.
by TaxQuarter DealerTIN: replace MatchDeclarationTax=MatchDeclarationTax[_n-1] if MatchDeclarationTax>=.


gsort TaxQuarter DealerTIN -_merge
by TaxQuarter DealerTIN: replace OtherDeclarationCount=OtherDeclarationCount[_n-1] if OtherDeclarationCount>=.
by TaxQuarter DealerTIN: replace MyDeclarationCount=MyDeclarationCount[_n-1] if MyDeclarationCount>=.
by TaxQuarter DealerTIN: replace MatchDeclarationCount=MatchDeclarationCount[_n-1] if MatchDeclarationCount>=.
by TaxQuarter DealerTIN: replace OtherDeclarationTax=OtherDeclarationTax[_n-1] if OtherDeclarationTax>=.
by TaxQuarter DealerTIN: replace MyDeclarationTax=MyDeclarationTax[_n-1] if MyDeclarationTax>=.
by TaxQuarter DealerTIN: replace MatchDeclarationTax=MatchDeclarationTax[_n-1] if MatchDeclarationTax>=.

drop Count

replace OtherDeclarationCount=0 if OtherDeclarationCount==.
replace MyDeclarationCount=0 if MyDeclarationCount==.
replace MatchDeclarationCount=0 if MatchDeclarationCount==.
replace OtherDeclarationTax=0 if OtherDeclarationTax==.
replace MyDeclarationTax=0 if MyDeclarationTax==.
replace MatchDeclarationTax=0 if MatchDeclarationTax==.

by TaxQuarter DealerTIN: gen Count=_n
by TaxQuarter DealerTIN: gen Count2=_N

keep if Count==1

gen PurchaseMyCountDiscrepancy=MyDeclarationCount/(OtherDeclarationCount+MyDeclarationCount+MatchDeclarationCount)
gen PurchaseOtherCountDiscrepancy=OtherDeclarationCount/(OtherDeclarationCount+MyDeclarationCount+MatchDeclarationCount)
gen PurchaseMyTaxDiscrepancy=MyDeclarationTax/(MyDeclarationTax+OtherDeclarationTax+MatchDeclarationTax)
gen PurchaseOtherTaxDiscrepancy=OtherDeclarationTax/(MyDeclarationTax+OtherDeclarationTax+MatchDeclarationTax)

isid TaxQuarter DealerTIN

drop SellerBuyerTIN TotalCountPurchaseTransactions PurchaseTaxAmount TotalPurchaseAmount TotalCountSaleTransactions SalesTaxAmount TotalSalesAmount _merge TotalCount TotalPurchaseTaxAmount TotalSalesTaxAmount Count Count2

replace PurchaseMyTaxDiscrepancy=0 if PurchaseMyTaxDiscrepancy==.
replace PurchaseOtherTaxDiscrepancy=0 if PurchaseOtherTaxDiscrepancy==.

save "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseDiscrepancyCounts.dta"

}

merge 1:1 TaxQuarter DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseDiscrepancyCounts.dta", generate(_merge_disc)


{
use "E:\data\PreliminaryAnalysis\BogusDealers\SalesTaxAmount20121314.dta", clear

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

merge 1:1 TaxQuarter DealerTIN SellerBuyerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\PurchaseTaxAmount20121314.dta"

rename DealerTIN x
rename SellerBuyerTIN DealerTIN
rename x SellerBuyerTIN

bys TaxQuarter DealerTIN _merge: gen TotalCount=_N
by TaxQuarter DealerTIN _merge: gen Count=_n
by TaxQuarter DealerTIN _merge: egen TotalPurchaseTaxAmount=sum(PurchaseTaxAmount)
by TaxQuarter DealerTIN _merge: egen TotalSalesTaxAmount=sum(SalesTaxAmount)

replace TotalSalesTaxAmount=0 if TotalSalesTaxAmount==.&_merge==2
replace TotalPurchaseTaxAmount=0 if TotalPurchaseTaxAmount==.&_merge==1

keep if Count==1

bys TaxQuarter DealerTIN: gen OtherDeclarationCount=TotalCount if _merge==2
bys TaxQuarter DealerTIN: gen MyDeclarationCount=TotalCount if _merge==1
bys TaxQuarter DealerTIN: gen MatchDeclarationCount=TotalCount if _merge==3

bys TaxQuarter DealerTIN: gen OtherDeclarationTax=TotalPurchaseTaxAmount if _merge==2
bys TaxQuarter DealerTIN: gen MyDeclarationTax=TotalSalesTaxAmount if _merge==1
bys TaxQuarter DealerTIN: gen MatchDeclarationTax=TotalSalesTaxAmount if _merge==3

gsort TaxQuarter DealerTIN _merge
by TaxQuarter DealerTIN: replace OtherDeclarationCount=OtherDeclarationCount[_n-1] if OtherDeclarationCount>=.
by TaxQuarter DealerTIN: replace MyDeclarationCount=MyDeclarationCount[_n-1] if MyDeclarationCount>=.
by TaxQuarter DealerTIN: replace MatchDeclarationCount=MatchDeclarationCount[_n-1] if MatchDeclarationCount>=.
by TaxQuarter DealerTIN: replace OtherDeclarationTax=OtherDeclarationTax[_n-1] if OtherDeclarationTax>=.
by TaxQuarter DealerTIN: replace MyDeclarationTax=MyDeclarationTax[_n-1] if MyDeclarationTax>=.
by TaxQuarter DealerTIN: replace MatchDeclarationTax=MatchDeclarationTax[_n-1] if MatchDeclarationTax>=.


gsort TaxQuarter DealerTIN -_merge
by TaxQuarter DealerTIN: replace OtherDeclarationCount=OtherDeclarationCount[_n-1] if OtherDeclarationCount>=.
by TaxQuarter DealerTIN: replace MyDeclarationCount=MyDeclarationCount[_n-1] if MyDeclarationCount>=.
by TaxQuarter DealerTIN: replace MatchDeclarationCount=MatchDeclarationCount[_n-1] if MatchDeclarationCount>=.
by TaxQuarter DealerTIN: replace OtherDeclarationTax=OtherDeclarationTax[_n-1] if OtherDeclarationTax>=.
by TaxQuarter DealerTIN: replace MyDeclarationTax=MyDeclarationTax[_n-1] if MyDeclarationTax>=.
by TaxQuarter DealerTIN: replace MatchDeclarationTax=MatchDeclarationTax[_n-1] if MatchDeclarationTax>=.

drop Count

replace OtherDeclarationCount=0 if OtherDeclarationCount==.
replace MyDeclarationCount=0 if MyDeclarationCount==.
replace MatchDeclarationCount=0 if MatchDeclarationCount==.
replace OtherDeclarationTax=0 if OtherDeclarationTax==.
replace MyDeclarationTax=0 if MyDeclarationTax==.
replace MatchDeclarationTax=0 if MatchDeclarationTax==.

by TaxQuarter DealerTIN: gen Count=_n
by TaxQuarter DealerTIN: gen Count2=_N

keep if Count==1

gen SaleMyCountDiscrepancy=MyDeclarationCount/(OtherDeclarationCount+MyDeclarationCount+MatchDeclarationCount)
gen SaleOtherCountDiscrepancy=OtherDeclarationCount/(OtherDeclarationCount+MyDeclarationCount+MatchDeclarationCount)
gen SaleMyTaxDiscrepancy=MyDeclarationTax/(MyDeclarationTax+OtherDeclarationTax+MatchDeclarationTax)
gen SaleOtherTaxDiscrepancy=OtherDeclarationTax/(MyDeclarationTax+OtherDeclarationTax+MatchDeclarationTax)

isid TaxQuarter DealerTIN

replace SaleMyTaxDiscrepancy=0 if SaleMyTaxDiscrepancy==.
replace SaleOtherTaxDiscrepancy=0 if SaleOtherTaxDiscrepancy==.

drop SellerBuyerTIN TotalCountPurchaseTransactions PurchaseTaxAmount TotalPurchaseAmount TotalCountSaleTransactions SalesTaxAmount TotalSalesAmount _merge TotalCount TotalPurchaseTaxAmount TotalSalesTaxAmount Count Count2

save "E:\data\PreliminaryAnalysis\BogusDealers\SaleDiscrepancyCounts.dta"
}

