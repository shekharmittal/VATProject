use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

drop _merge

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"
drop if _merge==2


drop _merge
merge m:1 DealerTIN using "D:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)
keep if _merge==1|_merge==3


gen TotalLocalValueAdded=(TurnoverLocal-TotalPurchases)
label variable TotalLocalValueAdded "Total Local Value added, (TurnoverLocal - TotalPurchases)"

gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))
gen l2TotalTaxCredit=log(TotalTaxCredit+sqrt(TotalTaxCredit^2+1))
gen l2TotalOutputTax=log(TotalOutputTax+sqrt(TotalOutputTax^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
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
//gen l2OutwardStockTransferBranchF=log(OutwardStockTransferBranchF+sqrt(OutwardStockTransferBranchF^2+1))
//gen l2InwardStockTransferBranchF=log(InwardStockTransferBranchF+sqrt(InwardStockTransferBranchF^2+1))
//gen l2OutwardStockTransferConF=log(OutwardStockTransferConsignmentF+sqrt(OutwardStockTransferConsignmentF^2+1))
//gen l2InwardStockTransferConF=log(InwardStockTransferConsignmentF+sqrt(InwardStockTransferConsignmentF^2+1))
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

xtile decile=TurnoverGross if TaxQuarter==1, nq(10)
xtile decile2=MoneyDeposited if TaxQuarter==1, nq(10)

gsort DealerTIN TaxQuarter
by DealerTIN: replace decile=decile[_n-1] if decile>=.
by DealerTIN: replace decile2=decile2[_n-1] if decile2>=.


replace Fishy=1
replace Fishy=0 if MoneyDeposited>=0.05*TurnoverGross
gen ZeroMoneyDeposited=0
replace ZeroMoneyDeposited=1 if MoneyDeposited==0

bys decile2: sum TurnoverGross MoneyDeposited Fishy ZeroMoneyDeposited  if TaxQuarter==1

collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category decile TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if decile==1) (connected PositiveContribution TaxQuarter if decile==2) (connected PositiveContribution TaxQuarter if decile==3) (connected PositiveContribution TaxQuarter if decile==4) (connected PositiveContribution TaxQuarter if decile==5) (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_private_decile.pdf", as(pdf) replace

twoway (connected PositiveContribution TaxQuarter if decile==1) (connected PositiveContribution TaxQuarter if decile==2) (connected PositiveContribution TaxQuarter if decile==3) (connected PositiveContribution TaxQuarter if decile==4) (connected PositiveContribution TaxQuarter if decile==5) (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_public_decile.pdf", as(pdf) replace

twoway (connected PositiveContribution TaxQuarter if decile==1) (connected PositiveContribution TaxQuarter if decile==2) (connected PositiveContribution TaxQuarter if decile==3) (connected PositiveContribution TaxQuarter if decile==4) (connected PositiveContribution TaxQuarter if decile==5) (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_government_decile.pdf", as(pdf) replace


twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==2) (connected MoneyDeposited TaxQuarter if decile==3) (connected MoneyDeposited TaxQuarter if decile==4) (connected MoneyDeposited TaxQuarter if decile==5) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean MoneyDeposited for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_private_decile.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==2) (connected MoneyDeposited TaxQuarter if decile==3) (connected MoneyDeposited TaxQuarter if decile==4) (connected MoneyDeposited TaxQuarter if decile==5) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean MoneyDeposited for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_public_decile.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==2) (connected MoneyDeposited TaxQuarter if decile==3) (connected MoneyDeposited TaxQuarter if decile==4) (connected MoneyDeposited TaxQuarter if decile==5) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean MoneyDeposited for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_government_decile.pdf", as(pdf) replace


twoway (connected l2MoneyDeposited TaxQuarter if decile==1) (connected l2MoneyDeposited TaxQuarter if decile==2) (connected l2MoneyDeposited TaxQuarter if decile==3) (connected l2MoneyDeposited TaxQuarter if decile==4) (connected l2MoneyDeposited TaxQuarter if decile==5) (connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2MoneyDeposited for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_private_decile.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if decile==1) (connected l2MoneyDeposited TaxQuarter if decile==2) (connected l2MoneyDeposited TaxQuarter if decile==3) (connected l2MoneyDeposited TaxQuarter if decile==4) (connected l2MoneyDeposited TaxQuarter if decile==5) (connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2MoneyDeposited for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_public_decile.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if decile==1) (connected l2MoneyDeposited TaxQuarter if decile==2) (connected l2MoneyDeposited TaxQuarter if decile==3) (connected l2MoneyDeposited TaxQuarter if decile==4) (connected l2MoneyDeposited TaxQuarter if decile==5) (connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2MoneyDeposited for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_government_decile.pdf", as(pdf) replace



twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_government_decile.pdf", as(pdf) replace


twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TaxCreditBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TaxCreditBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2TaxCreditBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_government_decile.pdf", as(pdf) replace



twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_government_decile.pdf", as(pdf) replace


twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2OutputTaxBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2OutputTaxBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2OutputTaxBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_government_decile.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if decile==1) (connected TurnoverGross TaxQuarter if decile==2) (connected TurnoverGross TaxQuarter if decile==3) (connected TurnoverGross TaxQuarter if decile==4) (connected TurnoverGross TaxQuarter if decile==5)(connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverGross for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_private_decile.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if decile==1) (connected TurnoverGross TaxQuarter if decile==2) (connected TurnoverGross TaxQuarter if decile==3) (connected TurnoverGross TaxQuarter if decile==4) (connected TurnoverGross TaxQuarter if decile==5) (connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverGross for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_public_decile.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if decile==1) (connected TurnoverGross TaxQuarter if decile==2) (connected TurnoverGross TaxQuarter if decile==3) (connected TurnoverGross TaxQuarter if decile==4) (connected TurnoverGross TaxQuarter if decile==5) (connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverGross for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_government_decile.pdf", as(pdf) replace



twoway (connected l2TurnoverGross TaxQuarter if decile==1) (connected l2TurnoverGross TaxQuarter if decile==2) (connected l2TurnoverGross TaxQuarter if decile==3) (connected l2TurnoverGross TaxQuarter if decile==4) (connected l2TurnoverGross TaxQuarter if decile==5) (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverGross for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_private_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverGross TaxQuarter if decile==1) (connected l2TurnoverGross TaxQuarter if decile==2) (connected l2TurnoverGross TaxQuarter if decile==3) (connected l2TurnoverGross TaxQuarter if decile==4) (connected l2TurnoverGross TaxQuarter if decile==5) (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverGross for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_public_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverGross TaxQuarter if decile==1) (connected l2TurnoverGross TaxQuarter if decile==2) (connected l2TurnoverGross TaxQuarter if decile==3) (connected l2TurnoverGross TaxQuarter if decile==4) (connected l2TurnoverGross TaxQuarter if decile==5) (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2TurnoverGross for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_government_decile.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==2) (connected TurnoverLocal TaxQuarter if decile==3) (connected TurnoverLocal TaxQuarter if decile==4) (connected TurnoverLocal TaxQuarter if decile==5) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_private_decile.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==2) (connected TurnoverLocal TaxQuarter if decile==3) (connected TurnoverLocal TaxQuarter if decile==4) (connected TurnoverLocal TaxQuarter if decile==5) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_public_decile.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==2) (connected TurnoverLocal TaxQuarter if decile==3) (connected TurnoverLocal TaxQuarter if decile==4) (connected TurnoverLocal TaxQuarter if decile==5) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_government_decile.pdf", as(pdf) replace


twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==2) (connected l2TurnoverLocal TaxQuarter if decile==3) (connected l2TurnoverLocal TaxQuarter if decile==4) (connected l2TurnoverLocal TaxQuarter if decile==5) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverLocal for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_private_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==2) (connected l2TurnoverLocal TaxQuarter if decile==3) (connected l2TurnoverLocal TaxQuarter if decile==4) (connected l2TurnoverLocal TaxQuarter if decile==5) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverLocal for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_public_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==2) (connected l2TurnoverLocal TaxQuarter if decile==3) (connected l2TurnoverLocal TaxQuarter if decile==4) (connected l2TurnoverLocal TaxQuarter if decile==5) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2TurnoverLocal for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_government_decile.pdf", as(pdf) replace





//Deciles by MoneyDeposited

collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category decile2 TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if decile==1) (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1"  2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_private_decile.pdf", as(pdf) replace

twoway (connected PositiveContribution TaxQuarter if decile==1) (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1"  2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_public_decile.pdf", as(pdf) replace

twoway (connected PositiveContribution TaxQuarter if decile==1)  (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1"  2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_government_decile.pdf", as(pdf) replace


twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10" )) note("Deciles by Turnover, yaxis(2) for declie10") title("Mean MoneyDeposited for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_private_decile.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1"  2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) for decile10") title("Mean MoneyDeposited for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_public_decile.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1"  2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean MoneyDeposited for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_government_decile.pdf", as(pdf) replace


twoway (connected l2MoneyDeposited TaxQuarter if decile==1)  (connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2MoneyDeposited for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_private_decile.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if decile==1) (connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2MoneyDeposited for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_public_decile.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if decile==1)(connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2MoneyDeposited for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_government_decile.pdf", as(pdf) replace



twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1)  (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1)  (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1)  (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_government_decile.pdf", as(pdf) replace


twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1)  (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2TaxCreditBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2TaxCreditBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2TaxCreditBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_government_decile.pdf", as(pdf) replace



twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1)  (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_government_decile.pdf", as(pdf) replace


twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1)  (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10 10")) note("Deciles by Turnover") title("Mean l2OutputTaxBeforeAdjustment for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_private_decile.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10 10")) note("Deciles by Turnover") title("Mean l2OutputTaxBeforeAdjustment for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_public_decile.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1)  (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2OutputTaxBeforeAdjustment for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_government_decile.pdf", as(pdf) replace


twoway (connected TurnoverGross TaxQuarter if decile==1) (connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverGross for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_private_decile.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if decile==1) (connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverGross for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_public_decile.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if decile==1)  (connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverGross for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_government_decile.pdf", as(pdf) replace


twoway (connected l2TurnoverGross TaxQuarter if decile==1) (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverGross for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_private_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverGross TaxQuarter if decile==1)  (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverGross for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_public_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverGross TaxQuarter if decile==1)  (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2TurnoverGross for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_government_decile.pdf", as(pdf) replace


twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10, yaxis(2)) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_private_decile.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10, yaxis(2)) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_public_decile.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10, yaxis(2)) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_government_decile.pdf", as(pdf) replace


twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) if Category=="Private", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverLocal for Private firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_private_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) if Category=="Public", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverLocal for Public firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_public_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) if Category=="Government", xline(9) legend(on order(1 "Decile 1" 2 "Decile 6" 3 "Decile 7" 4 "Decile 8" 5 "Decile 9" 6 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean l2TurnoverLocal for Government firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_government_decile.pdf", as(pdf) replace



//Deciles by TurnoverGross
//Overall Analysis
collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category decile2 TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if decile==1) (connected PositiveContribution TaxQuarter if decile==2) (connected PositiveContribution TaxQuarter if decile==3) (connected PositiveContribution TaxQuarter if decile==4) (connected PositiveContribution TaxQuarter if decile==5) (connected PositiveContribution TaxQuarter if decile==6) (connected PositiveContribution TaxQuarter if decile==7) (connected PositiveContribution TaxQuarter if decile==8) (connected PositiveContribution TaxQuarter if decile==9) (connected PositiveContribution TaxQuarter if decile==10) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for All firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_all_decile.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if decile==1) (connected MoneyDeposited TaxQuarter if decile==2) (connected MoneyDeposited TaxQuarter if decile==3) (connected MoneyDeposited TaxQuarter if decile==4) (connected MoneyDeposited TaxQuarter if decile==5) (connected MoneyDeposited TaxQuarter if decile==6) (connected MoneyDeposited TaxQuarter if decile==7) (connected MoneyDeposited TaxQuarter if decile==8) (connected MoneyDeposited TaxQuarter if decile==9) (connected MoneyDeposited TaxQuarter if decile==10, yaxis(2)), xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean MoneyDeposited for All firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_all_decile.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if decile==1) (connected l2MoneyDeposited TaxQuarter if decile==2) (connected l2MoneyDeposited TaxQuarter if decile==3) (connected l2MoneyDeposited TaxQuarter if decile==4) (connected l2MoneyDeposited TaxQuarter if decile==5) (connected l2MoneyDeposited TaxQuarter if decile==6) (connected l2MoneyDeposited TaxQuarter if decile==7) (connected l2MoneyDeposited TaxQuarter if decile==8) (connected l2MoneyDeposited TaxQuarter if decile==9) (connected l2MoneyDeposited TaxQuarter if decile==10) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2MoneyDeposited for All firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_private_decile.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected TaxCreditBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TaxCreditBeforeAdjustment for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_all_decile.pdf", as(pdf) replace

twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==1) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==2) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==3) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==4) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==5) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==6) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==7) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==8) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==9) (connected l2TaxCreditBeforeAdjustment TaxQuarter if decile==10) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TaxCreditBeforeAdjustment for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_all_decile.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected OutputTaxBeforeAdjustment TaxQuarter if decile==10, yaxis(2)) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean OutputTaxBeforeAdjustment for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_all_decile.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==1) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==2) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==3) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==4) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==5) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==6) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==7) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==8) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==9) (connected l2OutputTaxBeforeAdjustment TaxQuarter if decile==10) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2OutputTaxBeforeAdjustment for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_all_decile.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if decile==1) (connected TurnoverGross TaxQuarter if decile==2) (connected TurnoverGross TaxQuarter if decile==3) (connected TurnoverGross TaxQuarter if decile==4) (connected TurnoverGross TaxQuarter if decile==5) (connected TurnoverGross TaxQuarter if decile==6) (connected TurnoverGross TaxQuarter if decile==7) (connected TurnoverGross TaxQuarter if decile==8) (connected TurnoverGross TaxQuarter if decile==9) (connected TurnoverGross TaxQuarter if decile==10, yaxis(2)) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean TurnoverGross for all firms, yaxis(2) is for decile 10") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_all_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverGross TaxQuarter if decile==1) (connected l2TurnoverGross TaxQuarter if decile==2) (connected l2TurnoverGross TaxQuarter if decile==3) (connected l2TurnoverGross TaxQuarter if decile==4) (connected l2TurnoverGross TaxQuarter if decile==5) (connected l2TurnoverGross TaxQuarter if decile==6) (connected l2TurnoverGross TaxQuarter if decile==7) (connected l2TurnoverGross TaxQuarter if decile==8) (connected l2TurnoverGross TaxQuarter if decile==9) (connected l2TurnoverGross TaxQuarter if decile==10) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverGross for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_all_decile.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter if decile==1) (connected TurnoverLocal TaxQuarter if decile==2) (connected TurnoverLocal TaxQuarter if decile==3) (connected TurnoverLocal TaxQuarter if decile==4) (connected TurnoverLocal TaxQuarter if decile==5) (connected TurnoverLocal TaxQuarter if decile==6) (connected TurnoverLocal TaxQuarter if decile==7) (connected TurnoverLocal TaxQuarter if decile==8) (connected TurnoverLocal TaxQuarter if decile==9) (connected TurnoverLocal TaxQuarter if decile==10, yaxis(2)) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover, yaxis(2) is for decile 10") title("Mean TurnoverLocal for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_all_decile.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if decile==1) (connected l2TurnoverLocal TaxQuarter if decile==2) (connected l2TurnoverLocal TaxQuarter if decile==3) (connected l2TurnoverLocal TaxQuarter if decile==4) (connected l2TurnoverLocal TaxQuarter if decile==5) (connected l2TurnoverLocal TaxQuarter if decile==6) (connected l2TurnoverLocal TaxQuarter if decile==7) (connected l2TurnoverLocal TaxQuarter if decile==8) (connected l2TurnoverLocal TaxQuarter if decile==9) (connected l2TurnoverLocal TaxQuarter if decile==10) , xline(9) legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean l2TurnoverLocal for all firms") ytitle("")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_all_decile.pdf", as(pdf) replace


log using "H:\2a2b_analysis\graphs\ByDecile_turnover_Overall\summary_tables.smcl"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==10
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==9
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==8
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==7
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==6
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==5
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==4
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==3
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==2
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==1
log close



log using "H:\2a2b_analysis\graphs\ByDecile_turnover\summary_tables.log"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==10&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==9&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==8&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==7&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==6&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==5&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==4&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==3&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==2&Category=="Private"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==1&Category=="Private"


bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==10&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==9&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==8&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==7&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==6&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==5&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==4&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==3&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==2&Category=="Public"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==1&Category=="Public"


bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==10&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==9&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==8&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==7&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==6&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==5&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==4&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==3&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==2&Category=="Government"
bys TaxQuarter: sum MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if decile==1&Category=="Government"
log close
