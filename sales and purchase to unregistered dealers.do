/*January 22, 2016
Author: Shekhar Mittal
One of the tasks that we decided to do was to calculate percentage of sales and purchases made to unregistered dealers
So for all dealers, from their 2A-2B information, we will calculate sales made to unregistered dealers
we will then merge that information with the actual returns
then we will divide that information with total sales to get percentage sales to unregistered details
*/
use "F:\data\2a2b\sold_to_2013_q1_v2.dta", clear

keep if DealerGoodType=="UD"

drop SaleOrPurchase DealerGoodType Year DateTime ReceiptId Month DealerName SellerBuyerTIN AEBoolean T985DF1 T985DF2 T985DF3 dummy SalePurchaseType TransActionCount

bys DealerTIN:gen count=_N
br if count>1
by DealerTIN:egen SumAmount_v2=sum(SumAmount)
by DealerTIN: egen SumTaxAmount_v2=sum(SumTaxAmount)
by DealerTIN: egen SumTotalAmount_v2=sum(SumTotalAmount)


keep if count==1

drop TransactionType Rate END_ID count Date START_ID
rename SumAmount TurnoverUnregistered
rename SumTaxAmount OutputTaxUnregistered
rename SumTotalAmount TotalUnregistered


save "F:\sold_to_2013_q1_sale_unregistered_dealers.dta", replace


//Then in the merged file we do this

merge 1:1 DealerTIN using "F:\sold_to_2013_q1_sale_unregistered_dealers.dta", keepusing(TurnoverUnregistered OutputTaxUnregistered TotalUnregistered) generate(_merge_unregistered)
replace TurnoverUnregistered=0 if TurnoverUnregistered==.
replace OutputTaxUnregistered=0 if OutputTaxUnregistered==.
replace TotalUnregistered=0 if TotalUnregistered==.
gen PercTurnoverUnregistered= TurnoverUnregistered/TurnoverLocal
sum PercTurnoverUnregistered if _merge_returns==3&_merge_unregistered!=2, detail

//rough
br DealerTIN TurnoverUnregistered TurnoverGross TurnoverLocal TurnoverCentral PercTurnoverUnregistered if PercTurnoverUnregistered>1
br DealerTIN TurnoverUnregistered TurnoverGross TurnoverLocal TurnoverCentral PercTurnoverUnregistered if PercTurnoverUnregistered>1&PercTurnoverUnregistered!=.
