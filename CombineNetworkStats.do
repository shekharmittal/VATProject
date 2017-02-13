use "H:\graphlab\sold_to_statistics.dta" , clear
gsort __id TaxQuarter
collapse (max) max_stat_min=stat_min max_stat_p10=stat_p10 max_stat_median=stat_median (median) median_stat_min=stat_min, by(__id)
save "H:\CombinedMinDistanceFromStartEndNodes.dta"

use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

drop _merge

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"
drop if _merge==2

drop Treat
gen Treat=0 if max_stat_min==2
replace Treat=1 if max_stat_min==1

gen Treat=0 if median_stat_min==1
replace Treat=1 if median_stat_min==0


log using "H:\2a2b_diff_in_diff_sdistance_v1.smcl", replace
set more off
xtreg PositiveContribution Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, replace nocons keep(iPostTreat Post) title("sdistance Diff in Diff")
xtreg MoneyDeposited Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TurnoverGross Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TurnoverLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TotalTaxCredit Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg TotalOutputTax Post iPostTreat i.TaxQuarter , fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post)
xtreg SalesRatio Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 
xtreg PercLocal Post iPostTreat i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using aggnetwork_diffINdiff_sdistance_v2.xls, append nocons keep(iPostTreat Post) 


ssc install ttable2 logout
logout, save(summary_sdistance_v2) excel replace: ttable2  TotalInterStateSale TotalInterStatePurchase PositiveContribution MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax SalesRatio PercLocal if TaxQuarter==1, by(Treat)

ttable2  TotalInterStateSale TotalInterStatePurchase PositiveContribution MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax SalesRatio PercLocal if TaxQuarter==1, by(max_stat_min)



collapse (mean) lTotalValueAdded lMoneyDeposited PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited TotalPurchases PercValueAdded TotalValueAdded PercPurchaseUnregisteredDealer (sd) sd_TurnoverGross= TurnoverGross sd_TurnoverCentral= TurnoverCentral sd_TurnoverLocal= TurnoverLocal sd_PurchaseOtherGoods=PurchaseOtherGoods sd_OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment sd_AdjustmentOutputTax=AdjustmentOutputTax sd_TotalOutputTax=TotalOutputTax sd_PurchaseCapitalGoods=PurchaseCapitalGoods sd_CreditCapitalGoods=CreditCapitalGoods sd_CreditOtherGoods=CreditOtherGoods sd_TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment sd_AdjustmentTaxCredit=AdjustmentTaxCredit sd_TotalTaxCredit=TotalTaxCredit sd_NetTax=NetTax sd_BalancePayable=BalancePayable sd_AmountDepositedByDealer=AmountDepositedByDealer sd_AggregateAmountPaid=AggregateAmountPaid sd_NetBalance=NetBalance sd_BalanceBroughtForward=BalanceBroughtForward sd_AdjustCSTLiability=AdjustCSTLiability sd_RefundClaimed=RefundClaimed sd_BalanceCarriedNextTaxPeriod=BalanceCarriedNextTaxPeriod sd_InterStateSaleCD=InterStateSaleCD sd_InterStatePurchaseCD=InterStatePurchaseCD sd_InterStateSaleCE1E2=InterStateSaleCE1E2 sd_InterStatePurchaseCE1E2=InterStatePurchaseCE1E2 sd_InterStateSaleOther=InterStateSaleOther sd_InterStatePurchaseOther=InterStatePurchaseOther sd_InterStateSaleCapital=InterStateSaleCapital sd_InterStatePurchaseCapital=InterStatePurchaseCapital sd_TotalInterStateSale=TotalInterStateSale sd_TotalInterStatePurchase=TotalInterStatePurchase sd_PurchaseUnregisteredDealer=PurchaseUnregisteredDealer sd_MoneyDeposited=MoneyDeposited sd_PercValueAdded=PercValueAdded sd_TotalValueAdded=TotalValueAdded sd_PercPurchaseUnregistered=PercPurchaseUnregisteredDealer sd_TotalPurchases=TotalPurchases, by (TaxQuarter Government Treat)

gen LogMoney=log(MoneyDeposited)
twoway (line LogMoney TaxQuarter if Treat==0&Government==1) (line LogMoney TaxQuarter if Treat==1&Government==1), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line LogMoney TaxQuarter if Treat==0&Government==0) (line LogMoney TaxQuarter if Treat==1&Government==0), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line TotalTaxCredit TaxQuarter if Treat==0&Government==0) (line TotalTaxCredit TaxQuarter if Treat==1&Government==0), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line TotalTaxCredit TaxQuarter if Treat==0&Government==0) (line TotalTaxCredit TaxQuarter if Treat==1&Government==0, yaxis(2)), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line TotalTaxCredit TaxQuarter if Treat==0&Government==1) (line TotalTaxCredit TaxQuarter if Treat==1&Government==1, yaxis(2)), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line TotalTaxCredit TaxQuarter if Treat==0&Government==1) (line TotalTaxCredit TaxQuarter if Treat==1&Government==1), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line TotalOutputTax TaxQuarter if Treat==0&Government==1) (line TotalOutputTax TaxQuarter if Treat==1&Government==1), xline(9) legend(order(1 "Middle" 2 "Starting"))
twoway (line TotalOutputTax TaxQuarter if Treat==0&Government==1) (line TotalOutputTax TaxQuarter if Treat==1&Government==1, yaxis(2)), xline(9) legend(order(1 "Middle" 2 "Starting"))
        
