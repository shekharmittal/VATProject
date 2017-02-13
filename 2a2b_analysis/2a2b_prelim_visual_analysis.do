//In this file we will create simple graphs to try and model the effects of 2a2bPolicy

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

gen dummy=1
preserve

/*
/* Need to analyse why there is an upward trend in means but a decline is means of logs
One possible explanation is that dispersion between firms is going up
So necessary condition is that SD should be going up
And growth rates should be almost evenly distributed around zero. we see both are going on.*/

collapse (sd) sd_MoneyDeposited=MoneyDeposited sd_TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment sd_OutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment, by(Category TaxQuarter) 

twoway (connected sd_MoneyDeposited TaxQuarter if Category=="Government")
twoway (connected sd_MoneyDeposited TaxQuarter if Category=="Public")
twoway (connected sd_MoneyDeposited TaxQuarter if Category=="Private")

twoway (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category=="Government")
twoway (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category=="Public")
twoway (connected sd_TaxCreditBeforeAdjustment TaxQuarter if Category=="Private")

twoway (connected sd_OutputTaxBeforeAdjustment TaxQuarter if Category=="Government")
twoway (connected sd_OutputTaxBeforeAdjustment TaxQuarter if Category=="Public")
twoway (connected sd_OutputTaxBeforeAdjustment TaxQuarter if Category=="Private")

//Also another thing we need to do is compare growth rates for corresponding tax quarters
gsort DealerTIN TaxQuarter
keep if TaxQuarter==1|TaxQuarter==5|TaxQuarter==9|TaxQuarter==13|TaxQuarter==17

by DealerTIN: gen delta_MD=MoneyDeposited-MoneyDeposited[_n-1]
by DealerTIN: gen delta_TC=TaxCreditBeforeAdjustment-TaxCreditBeforeAdjustment[_n-1]
by DealerTIN: gen delta_OT=OutputTaxBeforeAdjustment-OutputTaxBeforeAdjustment[_n-1]

by DealerTIN: gen rdelta_MD=delta_MD/MoneyDeposited[_n-1]
by DealerTIN: gen rdelta_TC=delta_TC/TaxCreditBeforeAdjustment[_n-1]
by DealerTIN: gen rdelta_OT=delta_OT/OutputTaxBeforeAdjustment[_n-1]

sum rdelta_MD if TaxQuarter==9, detail
sum rdelta_TC if TaxQuarter==9, detail
sum rdelta_OT if TaxQuarter==9, detail

// End of the analysis for explaining decrease in log trends
*/

collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if Category=="Government")(connected PositiveContribution TaxQuarter if Category=="Public") (connected PositiveContribution TaxQuarter if Category=="Private", yaxis(2)), xline(9) title("Proportion of firms making a positive contribution")
graph export "H:\2a2b_analysis\graphs\PositiveContribution.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="Public", title("Money Deposited by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_public.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="Private", title("Money Deposited by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_private.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="Government", title("Money Deposited by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_government.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="", title("Money Deposited by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_noncategorised.pdf", as(pdf) replace


twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Public", title("TaxCredit by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_public.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Private", title("TaxCredit by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_private.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Government", title("TaxCredit Deposited by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_government.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="", title("TaxCredit by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_noncategorised.pdf", as(pdf) replace


twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Public", title("OutputTaxBeforeAdjustment by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_public.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Private", title("OutputTaxBeforeAdjustment by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_private.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Government", title("OutputTaxBeforeAdjustment Deposited by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_government.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="", title("OutputTaxBeforeAdjustment by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_noncategorised.pdf", as(pdf) replace


twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="Public", title("Gross Turnover by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverGross_public.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="Private", title("Gross Turnover by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverGross_private.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="Government", title("Gross Turnover by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverGross_government.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="", title("Gross Turnover by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverGross_noncategorised.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="Public", title("Local Turnover by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_public.pdf", as(pdf) replace
twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="Private", title("Local Turnover by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_private.pdf", as(pdf) replace
twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="Government", title("Local Turnover by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_government.pdf", as(pdf) replace
twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="", title("Local Turnover by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_noncategorised.pdf", as(pdf) replace


collapse (median)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if Category=="Government")(connected PositiveContribution TaxQuarter if Category=="Public") (connected PositiveContribution TaxQuarter if Category=="Private", yaxis(2)), xline(9) title("Proportion of firms making a positive contribution")
graph export "H:\2a2b_analysis\graphs\PositiveContribution.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="Public", title("Money Deposited by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_public_median.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="Private", title("Money Deposited by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_private_median.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="Government", title("Money Deposited by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_government_median.pdf", as(pdf) replace
twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)) if Category=="", title("Money Deposited by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_noncategorised_median.pdf", as(pdf) replace


twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Public", title("TaxCredit by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_public_median.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Private", title("TaxCredit by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_private_median.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Government", title("TaxCredit by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_government_median.pdf", as(pdf) replace
twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="", title("TaxCredit by non categorised firms") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_noncategorised_median.pdf", as(pdf) replace


twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Public", title("OutputTaxBeforeAdjustment by Public Limited Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_public.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Private", title("OutputTaxBeforeAdjustment by Private Companies/Propertiorships") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_private_median.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="Government", title("OutputTaxBeforeAdjustment Deposited by Government owned Companies") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_government_median.pdf", as(pdf) replace
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)) if Category=="", title("OutputTaxBeforeAdjustment by non categorised firms") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_noncategorised_median.pdf", as(pdf) replace


twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="Public", title("Median Gross Turnover by Public Limited Companies") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_public_median.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="Private", title("Gross Turnover by Private Companies/Propertiorships") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_private_median.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="Government", title("Median Gross Turnover by Government owned Companies") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_government_median.pdf", as(pdf) replace
twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)) if Category=="", title("Median Gross Turnover by non categorised firms") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_noncategorised.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="Public", title("Median Local Turnover by Public Limited Companies") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_public_median.pdf", as(pdf) replace
twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="Private", title("Median Local Turnover by Private Companies/Propertiorships") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_private_median.pdf", as(pdf) replace
twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="Government", title("Median Local Turnover by Government owned Companies") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_government_median.pdf", as(pdf) replace
twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)) if Category=="", title("Median Local Turnover by non categorised firms") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_noncategorised_median.pdf", as(pdf) replace



collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter), xline(9) title("Proportion of firms making a positive contribution (ALL)")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_mean_all.pdf", as(pdf) replace


twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)), title("Money Deposited by all firms") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_all_mean.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)), title("TaxCredit  all firms") xline(9)
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_all_mean.pdf", as(pdf) replace


twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)), title("OutputTaxBeforeAdjustment for all firms") xline(9)
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_all_mean.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)), title("Gross Turnover (all firms)") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverGross_all_mean.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)), title("Local Turnover (all firms)") xline(9)
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_all_mean.pdf", as(pdf) replace


collapse (median)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter), xline(9) title("Proportion of firms making a positive contribution (ALL-median)")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_median_all.pdf", as(pdf) replace


twoway (connected MoneyDeposited TaxQuarter) (connected l2MoneyDeposited TaxQuarter, yaxis(2)), title("Money Deposited by all firms") xline(9)
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_all_median.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter) (connected l2TaxCreditBeforeAdjustment TaxQuarter, yaxis(2)), title("TaxCredit  all firms (median)") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_all_median.pdf", as(pdf) replace


twoway (connected OutputTaxBeforeAdjustment TaxQuarter) (connected l2OutputTaxBeforeAdjustment TaxQuarter, yaxis(2)), title("OutputTaxBeforeAdjustment for all firms (median)") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_all_median.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter) (connected l2TurnoverGross TaxQuarter, yaxis(2)), title("Gross Turnover (all firms - median)") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_all_median.pdf", as(pdf) replace

twoway (connected TurnoverLocal TaxQuarter) (connected l2TurnoverLocal TaxQuarter, yaxis(2)), title("Local Turnover (all firms - median)") xline(9) ytitle("")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_all_median.pdf", as(pdf) replace



gen Dummy2=0 if TaxQuarter==1
replace Dummy2=1 if TotalLocalValueAdded>0.1*TurnoverLocal&TaxQuarter==1

gsort DealerTIN -Dummy2
by DealerTIN: replace Dummy2=Dummy2[_n-1] if Dummy2>=.

gen Dummy=0 if TaxQuarter==1
replace Dummy=1 if TaxQuarter==1&MoneyDeposited>0

gsort DealerTIN -Dummy
by DealerTIN: replace Dummy=Dummy[_n-1] if Dummy>=.

keep if Category=="Private"


collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category Dummy2 TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if Dummy2==0&Category=="Private")(connected PositiveContribution TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("Proportion of firms making a positive contribution")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if Dummy2==0&Category=="Private")(connected MoneyDeposited TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("Money Deposited")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if Dummy2==0&Category=="Private")(connected l2MoneyDeposited TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("Money Deposited")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if Dummy2==0&Category=="Private")(connected OutputTaxBeforeAdjustment TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("OutputTax Before Adjustment (For private firms)")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if Dummy2==0&Category=="Private")(connected l2OutputTaxBeforeAdjustment TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("OutputTax Before Adjustment (For private firms)")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy2==0&Category=="Private")(connected TaxCreditBeforeAdjustment TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("TaxCredit Before Adjustment (For private firms)")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_mean_local_valueadd.pdf", as(pdf) replace
twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if Dummy2==0&Category=="Private")(connected l2TaxCreditBeforeAdjustment TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("TaxCredit Before Adjustment (For private firms)")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if Dummy2==0&Category=="Private")(connected TurnoverGross TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverGross (For private firms)")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_mean_local_valueadd.pdf", as(pdf) replace
twoway (connected l2TurnoverGross TaxQuarter if Dummy2==0&Category=="Private")(connected l2TurnoverGross TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverGross (For private firms)")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_mean_local_valueadd.pdf", as(pdf) replace


twoway (connected TurnoverLocal TaxQuarter if Dummy2==0&Category=="Private")(connected TurnoverLocal TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverLocal (For private firms)")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_mean_local_valueadd.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if Dummy2==0&Category=="Private")(connected l2TurnoverLocal TaxQuarter if Dummy2==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverLocal (For private firms)")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_mean_local_valueadd.pdf", as(pdf) replace


gen Treat=1 if max_stat_min<10
replace Treat=0 if max_stat_min>9

collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category Treat TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if Treat==0&Category=="Private")(connected PositiveContribution TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("Proportion of firms making a positive contribution") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_network.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if Treat==0&Category=="Private")(connected MoneyDeposited TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("Money Deposited") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_network.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if Treat==0&Category=="Private")(connected l2MoneyDeposited TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2Money Deposited") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_network.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected OutputTaxBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("OutputTax Before Adjustment (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_network.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected l2OutputTaxBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2OutputTax Before Adjustment (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_network.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected TaxCreditBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("TaxCredit Before Adjustment (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_network.pdf", as(pdf) replace
twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected l2TaxCreditBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2TaxCredit Before Adjustment (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_network.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if Treat==0&Category=="Private")(connected TurnoverGross TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverGross (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_network.pdf", as(pdf) replace
twoway (connected l2TurnoverGross TaxQuarter if Treat==0&Category=="Private")(connected l2TurnoverGross TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2TurnoverGross (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_network.pdf", as(pdf) replace


twoway (connected TurnoverLocal TaxQuarter if Treat==0&Category=="Private")(connected TurnoverLocal TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverLocal (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_network.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if Treat==0&Category=="Private")(connected l2TurnoverLocal TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2TurnoverLocal (For private firms)") note("Treat=0 implies not reachable in the network, Treat=1 implies max_stat_min<10")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_network.pdf", as(pdf) replace


gen Treat=1 if max_stat_min==0
replace Treat=0 if max_stat_min==1

collapse (mean)TurnoverLocal l2TurnoverLocal TurnoverGross l2TurnoverGross l2MoneyDeposited MoneyDeposited PositiveContribution l2TaxCreditBeforeAdjustment TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment OutputTaxBeforeAdjustment, by(Category Treat TaxQuarter) 

twoway (connected PositiveContribution TaxQuarter if Treat==0&Category=="Private")(connected PositiveContribution TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("Proportion of firms making a positive contribution") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\PositiveContribution_network_start.pdf", as(pdf) replace

twoway (connected MoneyDeposited TaxQuarter if Treat==0&Category=="Private")(connected MoneyDeposited TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("Money Deposited") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\MoneyDeposited_network_start.pdf", as(pdf) replace

twoway (connected l2MoneyDeposited TaxQuarter if Treat==0&Category=="Private")(connected l2MoneyDeposited TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2Money Deposited") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\l2MoneyDeposited_network_start.pdf", as(pdf) replace

twoway (connected OutputTaxBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected OutputTaxBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("OutputTax Before Adjustment (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\OutputTaxBeforeAdjustment_network_start.pdf", as(pdf) replace

twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected l2OutputTaxBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2OutputTax Before Adjustment (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\l2OutputTaxBeforeAdjustment_network_start.pdf", as(pdf) replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected TaxCreditBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("TaxCredit Before Adjustment (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\TaxCreditBeforeAdjustment_network_start.pdf", as(pdf) replace
twoway (connected l2TaxCreditBeforeAdjustment TaxQuarter if Treat==0&Category=="Private")(connected l2TaxCreditBeforeAdjustment TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2TaxCredit Before Adjustment (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\l2TaxCreditBeforeAdjustment_network_start.pdf", as(pdf) replace

twoway (connected TurnoverGross TaxQuarter if Treat==0&Category=="Private")(connected TurnoverGross TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverGross (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\TurnoverGross_network_start.pdf", as(pdf) replace
twoway (connected l2TurnoverGross TaxQuarter if Treat==0&Category=="Private")(connected l2TurnoverGross TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2TurnoverGross (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\l2TurnoverGross_network_start.pdf", as(pdf) replace


twoway (connected TurnoverLocal TaxQuarter if Treat==0&Category=="Private")(connected TurnoverLocal TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("TurnoverLocal (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\TurnoverLocal_network_start.pdf", as(pdf) replace

twoway (connected l2TurnoverLocal TaxQuarter if Treat==0&Category=="Private")(connected l2TurnoverLocal TaxQuarter if Treat==1&Category=="Private", yaxis(2)), xline(9) title("l2TurnoverLocal (For private firms)") note("Treat=0 implies max_stat_min==1, Treat=1 implies max_stat_min==0")
graph export "H:\2a2b_analysis\graphs\l2TurnoverLocal_network_start.pdf", as(pdf) replace





//Rough
collapse (mean)TaxQuarter (sum) Count=dummy (mean) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited TotalPurchases PercValueAdded TotalValueAdded PercPurchaseUnregisteredDealer PositiveContribution TotalLocalValueAdded l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ, by(Category TaxQuarter)collapse (mean)TaxQuarter (sum) Count=dummy (mean) PurchaseUnregisteredDealer TurnoverGross TurnoverCentral TurnoverLocal PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase MoneyDeposited TotalPurchases PercValueAdded TotalValueAdded PercPurchaseUnregisteredDealer PositiveContribution TotalLocalValueAdded l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TurnoverLocal l2TotalValueAdded l2TotalLocalValueAdded l2PurchaseUnregisteredDealer l2CreditOtherGoods l2CreditCapitalGoods l2TaxCreditBeforeAdjustment l2AdjustmentTaxCredit l2TotalPurchases l2TotalInterStateSale l2TotalInterStatePurchase l2InterStateSaleCD l2InterStatePurchaseCD l2InterStatePurchaseCE1E2 l2InterStateSaleCE1E2 l2InterStateExportsAgainstH l2InterStateImportsAgainstH l2InterStateExportsAgainstI l2InterStateImportsAgainstI l2InterStateExportsAgainstJ l2InterStateImportsAgainstJ, by(Category TaxQuarter) fast

gsort Category TaxQuarter
preserve

collapse (mean) l2MoneyDeposited l2TotalTaxCredit l2TotalOutputTax l2TurnoverGross l2TotalValueAdded l2TaxCreditBeforeAdjustment l2OutputTaxBeforeAdjustment TurnoverGross MoneyDeposited CreditOtherGoods TotalTaxCredit TotalOutputTax OutputTaxBeforeAdjustment, by(Category TaxQuarter)
 


twoway (connected CreditOtherGoods TaxQuarter) if Category=="Private"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Public"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Government"
twoway (connected TotalTaxCredit TaxQuarter) if Category=="Private"
twoway (connected TotalTaxCredit TaxQuarter) if Category=="Public"
twoway (connected TotalTaxCredit TaxQuarter) if Category=="Government"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Public"


twoway (scatter CreditOtherGoods TaxQuarter) if Category=="Private"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Private"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Public"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Government"
twoway (connected TotalTaxCredit TaxQuarter) if Category=="Private"
twoway (connected TotalTaxCredit TaxQuarter) if Category=="Public"
twoway (connected TotalTaxCredit TaxQuarter) if Category=="Government"
twoway (connected CreditOtherGoods TaxQuarter) if Category=="Public"
twoway (connected MoneyDeposited TaxQuarter) if Category=="Public"
twoway (connected MoneyDeposited TaxQuarter) if Category=="Private"
twoway (connected MoneyDeposited TaxQuarter) if Category=="Government"
twoway (connected OutputTaxBeforeAdjustment  TaxQuarter) if Category=="Government"
twoway (connected TurnoverGross  TaxQuarter) if Category=="Public"
twoway (connected TurnoverGross  TaxQuarter) if Category=="Private"
twoway (connected TurnoverGross  TaxQuarter) if Category=="Government"
twoway (connected TotalOutputTax TaxQuarter) if Category=="Private"

twoway (connected OutputTaxBeforeAdjustment TaxQuarter) if Category=="Government"
twoway (connected OutputTaxBeforeAdjustment TaxQuarter) if Category=="Private"
twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter) if Category=="Private"
twoway (connected l2OutputTaxBeforeAdjustment TaxQuarter) if Category=="Public"
