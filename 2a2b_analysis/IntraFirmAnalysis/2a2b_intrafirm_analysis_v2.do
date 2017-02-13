use "Z:\monthly_2a2b_combined_quarterly.dta", clear
append using "Z:\quarterly_2a2b_combined.dta"
save "Z:\Combined2a2b_quarterly.dta", replace


use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
gen TypeDealer="Monthly"
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"
replace TypeDealer="Quarterly" if TypeDealer==""

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"
drop if _merge==2


merge 1:1 DealerTIN  TypeDealer TaxQuarter using "Z:\Combined2a2b_quarterly.dta", keepusing(TransActionCount SumAmount SumTaxAmount SumTotalAmount) generate(_merge_combine)
rename TransActionCount TransActionCount1 
rename SumAmount SumAmount1 
rename SumTaxAmount SumTaxAmount1
rename SumTotalAmount SumTotalAmount1
drop if _merge_combine==2



merge 1:1 DealerTIN TaxQuarter using "Z:\quarterly_dealers_2013.dta", keepusing(TransActionCount SumAmount SumTaxAmount SumTotalAmount) generate(_merge_combine2)
replace TransActionCount=TransActionCount1 if TransActionCount==.
replace SumAmount=SumAmount1 if SumAmount==.
replace SumTaxAmount=SumTaxAmount1 if SumTaxAmount==.
replace SumTotalAmount=SumTotalAmount1 if SumTotalAmount==.

rename TransActionCount TransActionCount2 
rename SumAmount SumAmount2
rename SumTaxAmount SumTaxAmount2
rename SumTotalAmount SumTotalAmount2
drop if _merge_combine2==2


merge 1:1 DealerTIN TaxQuarter using "Z:\quarterly_dealers_2014.dta", keepusing(TransActionCount SumAmount SumTaxAmount SumTotalAmount) generate(_merge_combine3)
drop if  _merge_combine3==2

replace TransActionCount=TransActionCount2 if TransActionCount==.
replace SumAmount=SumAmount2 if SumAmount==.
replace SumTaxAmount=SumTaxAmount2 if SumTaxAmount==.
replace SumTotalAmount=SumTotalAmount2 if SumTotalAmount==.

gen PurchaseRatio=TaxCreditBeforeAdjustment/SumTaxAmount

gen Dummy=.
replace Dummy=1 if PurchaseRatio!=.
gsort DealerTIN Dummy
by DealerTIN: replace Dummy=Dummy[_n-1] if Dummy>=.
replace Dummy=0 if Dummy==.


gen Dummy=0
replace Dummy=1 if PurchaseRatio!=.

drop if PurchaseRatio>100&PurchaseRatio!=.
replace TaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/1000000
replace SumTaxAmount=SumTaxAmount/1000000


bys TaxQuarter Dummy: sum TaxCreditBeforeAdjustment SumTaxAmount PurchaseRatio


preserve
collapse (mean) PurchaseRatio (sum) TaxCreditBeforeAdjustment SumTaxAmount, by(TaxQuarter Dummy)


twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)), legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)")
graph export "H:\2a2b_analysis\IntrafirmAnalysis\purchaseratio_trends_1.gph", as(pdf) replace


twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0)
twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) legend (order (1 "Taxcredit Annexure deposited"))

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


collapse (mean) PurchaseRatio (sum) TaxCreditBeforeAdjustment SumTaxAmount, by(TaxQuarter Government Dummy )

twoway (connected PurchaseRatio TaxQuarter if Government==0) (connected PurchaseRatio TaxQuarter if Government==1) (connected PurchaseRatio TaxQuarter if Government==2) if TaxQuarter>8, legend(order (1 "Private firms" 2 "Government firms" 3 "Public limited firms"))  
(connected SumTaxAmount TaxQuarter if Dummy==1) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)), legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)")



xtile MedianTurnover=TurnoverGross if TaxQuarter==1, nq(2)
xtile MedianMoney=MoneyDeposited if TaxQuarter==1, nq(2)
xtile QuantileCredit=TaxCreditBeforeAdjustment if TaxQuarter==1, nq(4)


gsort DealerTIN TaxQuarter
by DealerTIN: replace MedianTurnover=MedianTurnover[_n-1] if MedianTurnover>=.
by DealerTIN: replace MedianMoney=MedianMoney[_n-1] if MedianMoney>=.
by DealerTIN: replace QuantileCredit=QuantileCredit[_n-1] if QuantileCredit>=.


collapse (mean) PurchaseRatio (sum) TaxCreditBeforeAdjustment SumTaxAmount, by(TaxQuarter MedianTurnover Dummy)

collapse (mean) PurchaseRatio (sum) TaxCreditBeforeAdjustment SumTaxAmount, by(TaxQuarter MedianMoney Dummy)

collapse (mean) PurchaseRatio (sum) TaxCreditBeforeAdjustment SumTaxAmount, by(TaxQuarter QuantileCredit Dummy)


twoway (connected PurchaseRatio TaxQuarter if decile==1) (connected PurchaseRatio TaxQuarter if decile==2) (connected PurchaseRatio TaxQuarter if decile==3) (connected PurchaseRatio TaxQuarter if decile==4) (connected PurchaseRatio TaxQuarter if decile==5) (connected PurchaseRatio TaxQuarter if decile==6) (connected PurchaseRatio TaxQuarter if decile==7) (connected PurchaseRatio TaxQuarter if decile==8) (connected PurchaseRatio TaxQuarter if decile==9) (connected PurchaseRatio TaxQuarter if decile==10) if TaxQuarter>8, legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Private firms") ytitle("")

twoway (connected SumTaxAmount TaxQuarter if decile==1) (connected SumTaxAmount TaxQuarter if decile==2) (connected SumTaxAmount TaxQuarter if decile==3) (connected SumTaxAmount TaxQuarter if decile==4) (connected SumTaxAmount TaxQuarter if decile==5) (connected SumTaxAmount TaxQuarter if decile==6) (connected SumTaxAmount TaxQuarter if decile==7) (connected SumTaxAmount TaxQuarter if decile==8) (connected SumTaxAmount TaxQuarter if decile==9) (connected SumTaxAmount TaxQuarter if decile==10) if TaxQuarter>8&Dummy==1, legend(on order(1 "Decile 1" 2 "Decile 2" 3 "Decile 3" 4 "Decile 4" 5 "Decile 5" 6 "Decile 6" 7 "Decile 7" 8 "Decile 8" 9 "Decile 9" 10 "Decile 10")) note("Deciles by Turnover") title("Mean Positive Contribution for Private firms") ytitle("")



twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if decile==9, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)")

graph combine "H:\2a2b_analysis\IntrafirmAnalysis\MedianTurnover1.gph" "H:\2a2b_analysis\IntrafirmAnalysis\MedianTurnover2.gph", ycommon commonscheme


twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1&TaxQuarter>8) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if MedianMoney==1, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)") title("MoneyDeposited below median")
graph save "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoney1.gph", replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1&TaxQuarter>8) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if MedianMoney==2, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)") title("MoneyDeposited above median")
graph save "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoney2.gph"


graph combine "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoney1.gph" "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoney2.gph", ycommon commonscheme
graph save Graph "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoneyCrossSection.gph"
(file H:\2a2b_analysis\IntrafirmAnalysis\MedianMoneyTimeSeriesCombined.gph saved)



twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1&TaxQuarter>8) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if QuantileCredit==1, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)") title("Credit Quantile 1")
graph save "H:\2a2b_analysis\IntrafirmAnalysis\QuantileCredit1.gph", replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1&TaxQuarter>8) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if QuantileCredit==2, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)") title("Credit Quantile 2")
graph save "H:\2a2b_analysis\IntrafirmAnalysis\QuantileCredit2.gph", replace


twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1&TaxQuarter>8) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if QuantileCredit==3, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)") title("Credit Quantile 3")
graph save "H:\2a2b_analysis\IntrafirmAnalysis\QuantileCredit3.gph", replace

twoway (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==1) (connected SumTaxAmount TaxQuarter if Dummy==1&TaxQuarter>8) (connected TaxCreditBeforeAdjustment TaxQuarter if Dummy==0) (connected PurchaseRatio TaxQuarter if Dummy==1, yaxis(2)) if QuantileCredit==4, legend(order (1 "Taxcredit (consolidated returns)" 2 "Taxcredit (in annexures)" 3 "Taxcredit (without annexures)" 4 "Ratio of Consolidated and Annexure")) ytitle("Tax Credit (in million)") title("Credit Quantile 4")
graph save "H:\2a2b_analysis\IntrafirmAnalysis\QuantileCredit4.gph", replace

graph combine "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoney1.gph" "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoney2.gph", ycommon commonscheme
graph save Graph "H:\2a2b_analysis\IntrafirmAnalysis\MedianMoneyCrossSection.gph"
