use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

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



gen NonLocalSales=TurnoverGross-TurnoverLocal
gen SalesRatio=TurnoverLocal/NonLocalSales
gen PercLocal=TurnoverLocal/TurnoverGross
//gen Category=1 if sdistance>100
//replace Category=2 if sdistance<2
//replace Category=3 if sdistance>=2&sdistance<10
//tab sdistance Category if TaxQuarter==12


gen Government=.
//replace Government=1 if Constitution=="Government Company"
//replace Government=1 if Constitution=="Government Corporation"
//replace Government=1 if Constitution=="Government Department"
//replace Government=1 if Constitution=="Public Sector UnderTaking"
replace Government=1 if Constitution=="Public Ltd. Company"

replace Government=0 if Constitution=="HUF"
replace Government=0 if Constitution=="Partnership"
replace Government=0 if Constitution=="Private Ltd. Company"
replace Government=0 if Constitution=="Proprietorship"

//drop Treat
gen Treat=0 if Government==1
replace Treat=1 if Government==0

gen Cycle=mod(TaxQuarter,4)
gsort DealerTIN Cycle TaxQuarter
by DealerTIN Cycle: gen DeltaMoneyDeposited=MoneyDeposited-MoneyDeposited[_n-1]

gen VatIncrease=0 if DeltaMoneyDeposited!=.
replace VatIncrease=1 if DeltaMoneyDeposited>0&DeltaMoneyDeposited!=.


// Comparative Stats
{
collapse (mean)Treat PositiveContribution VatIncrease (sum) MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment, by(DealerTIN TaxYear)
logout, save(summary_publicvsprivate_total5_year1) excel replace: ttable2 PositiveContribution MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==1, by(Treat)
logout, save(summary_publicvsprivate_total5_year2) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==2, by(Treat)
logout, save(summary_publicvsprivate_total5_year3) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==3, by(Treat)
logout, save(summary_publicvsprivate_total5_year4) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==4, by(Treat)
logout, save(summary_publicvsprivate_total5_year5) excel replace: ttable2 PositiveContribution VatIncrease MoneyDeposited TurnoverGross TaxCreditBeforeAdjustment OutputTaxBeforeAdjustment if TaxYear==5, by(Treat)

collapse (mean)MoneyDeposited , by(TaxQuarter Treat)

replace MoneyDeposited=MoneyDeposited/1000

twoway (connected MoneyDeposited TaxQuarter if Treat==0) (connected MoneyDeposited TaxQuarter if Treat==1, yaxis(2)), xline(9) ytitle("Mean VAT deposited, Control Group") ytitle("Mean VAT deposited, Treatment Group", axis(2)) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in thousand rupees. No of control firms 1438, Treatment firms 65213 ")
//twoway (connected MoneyDeposited TaxYear if Treat==0) (connected MoneyDeposited TaxYear if Treat==1, yaxis(2)), xline(3) ytitle("Mean VAT deposited, Control Group") ytitle("Mean VAT deposited, Treatment Group", axis(2)) legend (order(1 "Control Group" 2 " Treatment Group")) title("Trends for VAT Deposited") note("Vat deposited in thousand rupees. No of control firms 1438, Treatment firms 65213 ")
graph export "H:\2a2b_analysis\PrivateVsPublic\VATDeposited_trends_publicvsprivate.pdf", as(pdf) replace

}

gen Post=0
replace Post=1 if TaxQuarter>8

destring DealerTIN, replace
xtset DealerTIN TaxQuarter


//drop iPostTreat
gen iPostTreat=Post*Treat

gen iTaxQuarter1=0
gen iTaxQuarter2=0
gen iTaxQuarter3=0
gen iTaxQuarter4=0
gen iTaxQuarter5=0
gen iTaxQuarter6=0
gen iTaxQuarter7=0
gen iTaxQuarter8=0
gen iTaxQuarter9=0
gen iTaxQuarter10=0
gen iTaxQuarter11=0
gen iTaxQuarter12=0
gen iTaxQuarter13=0
gen iTaxQuarter14=0
gen iTaxQuarter15=0
gen iTaxQuarter16=0
gen iTaxQuarter17=0
gen iTaxQuarter18=0
gen iTaxQuarter19=0
gen iTaxQuarter20=0

replace iTaxQuarter1=1 if TaxQuarter==1
replace iTaxQuarter2=1 if TaxQuarter==2
replace iTaxQuarter3=1 if TaxQuarter==3
replace iTaxQuarter4=1 if TaxQuarter==4
replace iTaxQuarter5=1 if TaxQuarter==5
replace iTaxQuarter6=1 if TaxQuarter==6
replace iTaxQuarter7=1 if TaxQuarter==7
replace iTaxQuarter8=1 if TaxQuarter==8
replace iTaxQuarter9=1 if TaxQuarter==9
replace iTaxQuarter10=1 if TaxQuarter==10
replace iTaxQuarter11=1 if TaxQuarter==11
replace iTaxQuarter12=1 if TaxQuarter==12
replace iTaxQuarter13=1 if TaxQuarter==13
replace iTaxQuarter14=1 if TaxQuarter==14
replace iTaxQuarter15=1 if TaxQuarter==15
replace iTaxQuarter16=1 if TaxQuarter==16
replace iTaxQuarter17=1 if TaxQuarter==17
replace iTaxQuarter18=1 if TaxQuarter==18
replace iTaxQuarter19=1 if TaxQuarter==19
replace iTaxQuarter20=1 if TaxQuarter==20

//PreTrend Analysis
{
gen iTreatT1=Treat*iTaxQuarter1
gen iTreatT2=Treat*iTaxQuarter2
gen iTreatT3=Treat*iTaxQuarter3
gen iTreatT4=Treat*iTaxQuarter4
gen iTreatT5=Treat*iTaxQuarter5
gen iTreatT6=Treat*iTaxQuarter6
gen iTreatT7=Treat*iTaxQuarter7
gen iTreatT8=Treat*iTaxQuarter8
gen iTreatT9=Treat*iTaxQuarter9
gen iTreatT10=Treat*iTaxQuarter10
gen iTreatT11=Treat*iTaxQuarter11
gen iTreatT12=Treat*iTaxQuarter12
gen iTreatT13=Treat*iTaxQuarter13
gen iTreatT14=Treat*iTaxQuarter14
gen iTreatT15=Treat*iTaxQuarter15
gen iTreatT16=Treat*iTaxQuarter16
gen iTreatT17=Treat*iTaxQuarter17
gen iTreatT18=Treat*iTaxQuarter18
gen iTreatT19=Treat*iTaxQuarter19
gen iTreatT20=Treat*iTaxQuarter20

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg MoneyDeposited `TaxQuarterDummy' iTreat*, fe cluster(DealerTIN)
}



gen lMoneyDeposited=log(MoneyDeposited)
gen lTotalTaxCredit=log(TotalTaxCredit)
gen lTotalOutputTax=log(TotalOutputTax)
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverLocal=log(TurnoverLocal)
gen lTotalValueAdded=log(TotalValueAdded)
gen lTaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment)
gen lOutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment)

gen l2MoneyDeposited=log(MoneyDeposited+sqrt(MoneyDeposited^2+1))
gen l2TotalTaxCredit=log(TotalTaxCredit+sqrt(TotalTaxCredit^2+1))
gen l2TotalOutputTax=log(TotalOutputTax+sqrt(TotalOutputTax^2+1))
gen l2TurnoverGross=log(TurnoverGross+sqrt(TurnoverGross^2+1))
gen l2TurnoverLocal=log(TurnoverLocal+sqrt(TurnoverLocal^2+1))
gen l2TotalValueAdded=log(TotalValueAdded+sqrt(TotalValueAdded^2+1))
gen l2PurchaseUnregisteredDealer=log(PurchaseUnregisteredDealer+sqrt(PurchaseUnregisteredDealer^2+1))
gen l2CreditOtherGoods=log(CreditOtherGoods+sqrt(CreditOtherGoods^2+1))
gen l2CreditCapitalGoods=log(CreditCapitalGoods+sqrt(CreditCapitalGoods^2+1))
gen l2TaxCreditBeforeAdjustment=log(TaxCreditBeforeAdjustment+sqrt(TaxCreditBeforeAdjustment^2+1))
gen l2OutputTaxBeforeAdjustment=log(OutputTaxBeforeAdjustment+sqrt(OutputTaxBeforeAdjustment^2+1))
gen l2AdjustmentTaxCredit=log(AdjustmentTaxCredit+sqrt(AdjustmentTaxCredit^2+1))
gen l2TotalPurchases=log(TotalPurchases+sqrt(TotalPurchases^2+1))
gen l2TotalInterStateSale=log(TotalInterStateSale+sqrt(TotalInterStateSale^2+1))
gen l2TotalInterStatePurchase=log(TotalInterStatePurchase+sqrt(TotalInterStatePurchase^2+1))
gen l2ExportFromIndia=log(ExportFromIndia+sqrt(ExportFromIndia^2+1))
gen l2ImportToIndia=log(ImportToIndia+sqrt(ImportToIndia^2+1))
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


//ssc install moremata
//local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
//qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)
//qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)
//	qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)


local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, replace nocons keep(Post iPostTreat) 
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 

xtreg lMoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 
xtreg lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
outreg2 using diffINdiff_MeanPrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) 


qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, replace nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.6")
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.7")
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("VatDeposit, Q=0.8")


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.6")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.7")
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("Credit, Q=0.8")

qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.6")
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.7")
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
outreg2 using diffINdiff_QuantilePrivatevsPublic_TotalCount5_Treat.xls, append nocons keep(Post iPostTreat) ctitle("OutputTax, Q=0.8")







log using "H:\2a2b_PLTDvsPVT_regressions.log", replace
tab Constitution Treat
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post `TaxQuarterDummy', cluster(DealerTIN) fe
xtreg VatIncrease Post `TaxQuarterDummy', cluster(DealerTIN) fe

qreg MoneyDeposited  Post `TaxQuarterDummy', q(.5)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.6)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.7)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.8)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.9)
qreg MoneyDeposited  Post `TaxQuarterDummy', q(.95)

qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.5)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.6)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.7)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.8)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.9)
qreg lMoneyDeposited  Post `TaxQuarterDummy', q(.95)

qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.5)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.6)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.7)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.8)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.9)
qreg l2MoneyDeposited  Post `TaxQuarterDummy', q(.95)

qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.95)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg lTaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg l2TaxCreditBeforeAdjustment  Post `TaxQuarterDummy', q(.95)


qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg lOutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.5)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.6)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.7)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.8)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.9)
qreg l2OutputTaxBeforeAdjustment  Post `TaxQuarterDummy', q(.95)


tobit MoneyDeposited Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post  `TaxQuarterDummy', ll(0) cluster(DealerTIN)

qregpd MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)


//qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lMoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
//qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2MoneyDeposited  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lTaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2TaxCreditBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg lOutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.5)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.6)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.7)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.8)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.9)
qreg l2OutputTaxBeforeAdjustment  Post Treat iPostTreat `TaxQuarterDummy', q(.95)


tobit MoneyDeposited Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2MoneyDeposited Post Treat iPostTreat `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit TaxCreditBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2TaxCreditBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit OutputTaxBeforeAdjustment Post Treat iPostTreat  `TaxQuarterDummy', ll(0) cluster(DealerTIN)
tobit l2OutputTaxBeforeAdjustment Post Treat iPostTreat `TaxQuarterDummy', ll(0) cluster(DealerTIN)


local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lMoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lMoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lTaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 


qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd lOutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd lOutputTaxBeforeAdjustment Post  iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

qregpd l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.75) 
qregpd l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', identifier(DealerTIN) fix(TaxYear) q(.9) 

log close









tab Cycle, gen(cycle)
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

xtreg PositiveContribution Post iPostTreat cycle*, fe cluster(DealerTIN)
xtreg VatIncrease Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)


local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
qregpd PositiveContribution Post iPostTreat `TaxQuarterDummy' , identifier(DealerTIN) fix(TaxQuarter)


destring DealerTIN, replace
xtset DealerTIN TaxQuarter

log using "H:\2a2b_analysis\diffINdiff_government w PLTD as control_0930.log", replace
tab Constitution Treat
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg l2OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg OutputTaxBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)

log close

xtreg l2TurnoverGross Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverLocal Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalValueAdded Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2PurchaseUnregisteredDealer Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditOtherGoods Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditCapitalGoods Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2AdjustmentTaxCredit Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalPurchases Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStateSale Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStatePurchase Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ExportFromIndia Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ImportToIndia Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCD Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCD Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCE1E2 Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCE1E2 Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstH Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstH Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstI Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstI Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstJ Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstJ Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
log close


drop Treat
gen Treat=0 if Constitution=="Public Ltd. Company"
replace Treat=1 if Government==0

drop iPostTreat
gen iPostTreat=Post*Treat

log using "H:\2a2b_analysis\diffINdiff_PLTD as control.log", replace
tab Constitution Government
tab Constitution Treat
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverGross Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverLocal Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalValueAdded Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2PurchaseUnregisteredDealer Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditOtherGoods Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditCapitalGoods Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2AdjustmentTaxCredit Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalPurchases Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStateSale Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStatePurchase Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ExportFromIndia Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ImportToIndia Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCD Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCD Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCE1E2 Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCE1E2 Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstH Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstH Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstI Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstI Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstJ Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstJ Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
log close


replace Government=0 if Constitution=="Public Ltd. Company"
drop Treat
gen Treat=0 if Government==1
replace Treat=1 if Government==0

drop iPostTreat
gen iPostTreat=Post*Treat

log using "H:\2a2b_analysis\diffINdiff_government as control.log", replace
tab Constitution Government
tab Constitution Treat
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverGross Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverLocal Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalValueAdded Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2PurchaseUnregisteredDealer Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditOtherGoods Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditCapitalGoods Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2AdjustmentTaxCredit Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalPurchases Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStateSale Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStatePurchase Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ExportFromIndia Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ImportToIndia Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCD Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCD Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCE1E2 Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCE1E2 Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstH Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstH Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstI Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstI Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstJ Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstJ Post iPostTreat `TaxQuarterDummy', fe cluster(DealerTIN)
log close
