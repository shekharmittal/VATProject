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

gen Government=0
replace Government=1 if Constitution=="Government Company"
replace Government=1 if Constitution=="Government Corporation"
replace Government=1 if Constitution=="Government Department"
replace Government=1 if Constitution=="Public Sector UnderTaking"


gen lMoneyDeposited=log(MoneyDeposited)
gen lTotalTaxCredit=log(TotalTaxCredit)
gen lTotalOutputTax=log(TotalOutputTax)
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverLocal=log(TurnoverLocal)
gen lTotalValueAdded=log(TotalValueAdded)

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


histogram MoneyDeposited if TaxQuarter==1&MoneyDeposited>0&MoneyDeposited<50000000
&histogram lMoneyDeposited if TaxQuarter==1
histogram l2MoneyDeposited if TaxQuarter==1
histogram l2TotalTaxCredit if TaxQuarter==1
histogram l2TotalOutputTax if TaxQuarter==1

//Government level diff in diff analysis
destring DealerTIN, replace
xtset DealerTIN TaxQuarter

gen Post=0
replace Post=1 if TaxQuarter>8

drop Treat
gen Treat=0 if sdistance>0&sdistance<10
replace Treat=1 if sdistance==0

drop iPostTreat
gen iPostTreat=Post*Treat

tab Treat Government if TaxQuarter==1
tab sdistance Government if TaxQuarter==1
tab max_stat_min Government if TaxQuarter==1
tab median_stat_min Government if TaxQuarter==1


egen gid=group(Treat Government)
tab gid Government
logout, save(summary_sdistance_v2) excel replace: ttable2 MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax if TaxQuarter==1, by(gid)
logout, save(summary_sdistance_v2) excel replace: ttable2 MoneyDeposited TurnoverGross TotalTaxCredit TotalOutputTax if TaxQuarter==1, by(gid)
tab gid Government if TaxQuarter==1
tab Treat Government
xtreg MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)
xtreg TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)

xtreg lMoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg lMoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg lTotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg lTotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg lTotalOutputTax Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)
xtreg lTotalOutputTax Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)

log using "H:\2a2b_analysis\diffindiff_government_logs.log", replace
drop Treat
gen Treat=0 if sdistance>0&sdistance<10
replace Treat=1 if sdistance==0

drop iPostTreat
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


gen iNotGovernmentTaxQuarter1=0
gen iNotGovernmentTaxQuarter2=0
gen iNotGovernmentTaxQuarter3=0
gen iNotGovernmentTaxQuarter4=0
gen iNotGovernmentTaxQuarter5=0
gen iNotGovernmentTaxQuarter6=0
gen iNotGovernmentTaxQuarter7=0
gen iNotGovernmentTaxQuarter8=0
gen iNotGovernmentTaxQuarter9=0
gen iNotGovernmentTaxQuarter10=0
gen iNotGovernmentTaxQuarter11=0
gen iNotGovernmentTaxQuarter12=0
gen iNotGovernmentTaxQuarter13=0
gen iNotGovernmentTaxQuarter14=0
gen iNotGovernmentTaxQuarter15=0
gen iNotGovernmentTaxQuarter16=0
gen iNotGovernmentTaxQuarter17=0
gen iNotGovernmentTaxQuarter18=0
gen iNotGovernmentTaxQuarter19=0
gen iNotGovernmentTaxQuarter20=0

replace iNotGovernmentTaxQuarter1=1 if TaxQuarter==1&NotGovernment==1
replace iNotGovernmentTaxQuarter2=1 if TaxQuarter==2&NotGovernment==1
replace iNotGovernmentTaxQuarter3=1 if TaxQuarter==3&NotGovernment==1
replace iNotGovernmentTaxQuarter4=1 if TaxQuarter==4&NotGovernment==1
replace iNotGovernmentTaxQuarter5=1 if TaxQuarter==5&NotGovernment==1
replace iNotGovernmentTaxQuarter6=1 if TaxQuarter==6&NotGovernment==1
replace iNotGovernmentTaxQuarter7=1 if TaxQuarter==7&NotGovernment==1
replace iNotGovernmentTaxQuarter8=1 if TaxQuarter==8&NotGovernment==1
replace iNotGovernmentTaxQuarter9=1 if TaxQuarter==9&NotGovernment==1
replace iNotGovernmentTaxQuarter10=1 if TaxQuarter==10&NotGovernment==1
replace iNotGovernmentTaxQuarter11=1 if TaxQuarter==11&NotGovernment==1
replace iNotGovernmentTaxQuarter12=1 if TaxQuarter==12&NotGovernment==1
replace iNotGovernmentTaxQuarter13=1 if TaxQuarter==13&NotGovernment==1
replace iNotGovernmentTaxQuarter14=1 if TaxQuarter==14&NotGovernment==1
replace iNotGovernmentTaxQuarter15=1 if TaxQuarter==15&NotGovernment==1
replace iNotGovernmentTaxQuarter16=1 if TaxQuarter==16&NotGovernment==1
replace iNotGovernmentTaxQuarter17=1 if TaxQuarter==17&NotGovernment==1
replace iNotGovernmentTaxQuarter18=1 if TaxQuarter==18&NotGovernment==1
replace iNotGovernmentTaxQuarter19=1 if TaxQuarter==19&NotGovernment==1
replace iNotGovernmentTaxQuarter20=1 if TaxQuarter==20&NotGovernment==1


local iNotGovernmentTaxQuarterDummy "iNotGovernmentTaxQuarter2 iNotGovernmentTaxQuarter3 iNotGovernmentTaxQuarter4 iNotGovernmentTaxQuarter5 iNotGovernmentTaxQuarter6 iNotGovernmentTaxQuarter7 iNotGovernmentTaxQuarter8 iNotGovernmentTaxQuarter9 iNotGovernmentTaxQuarter10 iNotGovernmentTaxQuarter11 iNotGovernmentTaxQuarter12 iNotGovernmentTaxQuarter13 iNotGovernmentTaxQuarter14 iNotGovernmentTaxQuarter15 iNotGovernmentTaxQuarter16 iNotGovernmentTaxQuarter17 iNotGovernmentTaxQuarter18 iNotGovernmentTaxQuarter19"
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"

xtreg l2MoneyDeposited Post iPostTreat `TaxQuarterDummy' if Government==1, fe cluster(DealerTIN)


xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)


drop Treat
gen Treat=0 if sdistance==1
replace Treat=1 if sdistance==0

drop iPostTreat
gen iPostTreat=Post*Treat


xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)


drop Treat
gen Treat=0 if edistance>0&edistance<10
replace Treat=1 if edistance==0

drop iPostTreat
gen iPostTreat=Post*Treat

//End distance analysis
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

drop Treat
gen Treat=0 if edistance==1
replace Treat=1 if edistance==0

drop iPostTreat
gen iPostTreat=Post*Treat

//End distance analysis

//with replace Government=1 if Constitution=="Public Ltd. Company"
tab Constitution Treat
tab Constitution Government

xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN)

xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2ExportFromIndia Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2ExportFromIndia Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2ImportToIndia Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2ImportToIndia Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateSaleCD Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateSaleCD Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStatePurchaseCD Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCD Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateSaleCE1E2 Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateSaleCE1E2 Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStatePurchaseCE1E2 Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCE1E2 Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateExportsAgainstH Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstH Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateImportsAgainstH Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstH Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateExportsAgainstI Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstI Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateImportsAgainstI Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstI Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateExportsAgainstJ Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateExportsAgainstJ Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateImportsAgainstJ Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateImportsAgainstJ Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

log close

//Doing diffindiffindiff analysis on the same page with Government not including Public ltd companies

gen Post=0
replace Post=1 if TaxQuarter>8

{
replace Government=1 if Constitution=="Public Ltd. Company"
drop NotGovernment iPostNotGovernment
gen NotGovernment=0
replace NotGovernment=1 if Government==0
gen iPostNotGovernment=Post*NotGovernment

drop Treat
gen Treat=0 if sdistance>0&sdistance<10
replace Treat=1 if sdistance==0

drop iPostTreat iTreatNotGovernment iPostTreatNotGovernment
gen iPostTreat=Post*Treat
gen iTreatNotGovernment=Treat*NotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

xi:xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter*NotGovernment, fe cluster(DealerTIN)



log using "H:\2a2b_analysis\sdistance\diffINdiffINdiff_separatetimetrend_sdistance_government_comparison_group_bigsample_.log", replace

local iNotGovernmentTaxQuarterDummy "iNotGovernmentTaxQuarter2 iNotGovernmentTaxQuarter3 iNotGovernmentTaxQuarter4 iNotGovernmentTaxQuarter5 iNotGovernmentTaxQuarter6 iNotGovernmentTaxQuarter7 iNotGovernmentTaxQuarter8 iNotGovernmentTaxQuarter9 iNotGovernmentTaxQuarter10 iNotGovernmentTaxQuarter11 iNotGovernmentTaxQuarter12 iNotGovernmentTaxQuarter13 iNotGovernmentTaxQuarter14 iNotGovernmentTaxQuarter15 iNotGovernmentTaxQuarter16 iNotGovernmentTaxQuarter17 iNotGovernmentTaxQuarter18 iNotGovernmentTaxQuarter19"
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19"
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ExportFromIndia Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2ImportToIndia Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCD Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCD Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStateSaleCE1E2 Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCE1E2 Post iPostTreat iPostNotGovernment iPostTreatNotGovernment `TaxQuarterDummy' `iNotGovernmentTaxQuarterDummy', fe cluster(DealerTIN)

log close

xtreg l2ExportFromIndia Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2ExportFromIndia Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2ImportToIndia Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2ImportToIndia Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateSaleCD Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateSaleCD Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStatePurchaseCD Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCD Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStateSaleCE1E2 Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStateSaleCE1E2 Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)

xtreg l2InterStatePurchaseCE1E2 Post iPostTreat i.TaxQuarter if Government==1 , fe cluster(DealerTIN)
xtreg l2InterStatePurchaseCE1E2 Post iPostTreat i.TaxQuarter if Government==0 , fe cluster(DealerTIN)






set more off
cd H:\2a2b_analysis\sdistance
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, replace nocons keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample does not include public ltd company in government, and sdistance>0&sdistance<10 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 

drop Treat
gen Treat=0 if sdistance==1
replace Treat=1 if sdistance==0

drop iPostTreat
gen iPostTreat=Post*Treat
drop iTreatNotGovernment
gen iTreatNotGovernment=Treat*NotGovernment
drop iPostTreatNotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample does not include public ltd company in government, and sdistance==1 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 


//End analysis
drop Treat
gen Treat=0 if edistance>0&edistance<10
replace Treat=1 if edistance==0

drop iPostTreat iTreatNotGovernment iPostTreatNotGovernment
gen iPostTreat=Post*Treat
gen iTreatNotGovernment=Treat*NotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
cd H:\2a2b_analysis\edistance
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample does not include public ltd company in government, and edistance>0&edistance<10 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 


drop Treat
gen Treat=0 if edistance==1
replace Treat=1 if edistance==0

drop iPostTreat
gen iPostTreat=Post*Treat
drop iTreatNotGovernment
gen iTreatNotGovernment=Treat*NotGovernment
drop iPostTreatNotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample does not include public ltd company in government, and edistance==1 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
}


//
{
replace Government=1 if Constitution=="Public Ltd. Company"
drop NotGovernment iPostNotGovernment
gen NotGovernment=0
replace NotGovernment=1 if Government==0
gen iPostNotGovernment=Post*NotGovernment

drop Treat iPostTreat iTreatNotGovernment iPostTreatNotGovernment
gen Treat=0 if sdistance>0&sdistance<10
replace Treat=1 if sdistance==0

gen iPostTreat=Post*Treat
gen iTreatNotGovernment=Treat*NotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
cd H:\2a2b_analysis\sdistance
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample does not include public ltd company in government, and sdistance>0&sdistance<10 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 

drop Treat
gen Treat=0 if sdistance==1
replace Treat=1 if sdistance==0

drop iPostTreat
gen iPostTreat=Post*Treat
drop iTreatNotGovernment
gen iTreatNotGovernment=Treat*NotGovernment
drop iPostTreatNotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample includes public ltd company in government, and sdistance==1 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_sdistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 


//End analysis
drop Treat
gen Treat=0 if edistance>0&edistance<10
replace Treat=1 if edistance==0

drop iPostTreat iTreatNotGovernment iPostTreatNotGovernment
gen iPostTreat=Post*Treat
gen iTreatNotGovernment=Treat*NotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
cd H:\2a2b_analysis\edistance
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample includes public ltd company in government, and edistance>0&edistance<10 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_bigsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 


drop Treat
gen Treat=0 if edistance==1
replace Treat=1 if edistance==0

drop iPostTreat
gen iPostTreat=Post*Treat
drop iTreatNotGovernment
gen iTreatNotGovernment=Treat*NotGovernment
drop iPostTreatNotGovernment
gen iPostTreatNotGovernment=Treat*NotGovernment*Post

set more off
xtreg PositiveContribution Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, replace keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) addnote("This sample includes public ltd company in government, and edistance==1 is comparison")
xtreg l2MoneyDeposited Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalOutputTax Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverGross Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TurnoverLocal Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalValueAdded Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2PurchaseUnregisteredDealer Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditOtherGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2CreditCapitalGoods Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2AdjustmentTaxCredit Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalPurchases Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStateSale Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
xtreg l2TotalInterStatePurchase Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
outreg2 using diffINdiff_edistance_government_PLTD_comparison_group_smallsample.xls, append keep(Post iPostTreat iPostNotGovernment iPostTreatNotGovernment) 
}

{
log using "H:\2a2b_analysis\sdistance\diffINdiff_sdistance_government_comparison_group_bigsample.log", replace
xtreg PositiveContribution Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg PositiveContribution Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TurnoverGross Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TurnoverGross Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TurnoverLocal Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TurnoverLocal Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalValueAdded Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalValueAdded Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2PurchaseUnregisteredDealer Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2PurchaseUnregisteredDealer Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2CreditOtherGoods Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2CreditOtherGoods Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2CreditCapitalGoods Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2CreditCapitalGoods Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2AdjustmentTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2AdjustmentTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalInterStateSale Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalInterStateSale Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalInterStatePurchase Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalInterStatePurchase Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalPurchases Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalPurchases Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
log close
}

log using "H:\2a2b_analysis\edistance\diffINdiff_edistance_government_comparison_group_bigsample.log", replace
xtreg PositiveContribution Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg PositiveContribution Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2MoneyDeposited Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalOutputTax Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TurnoverGross Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TurnoverGross Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TurnoverLocal Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TurnoverLocal Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalValueAdded Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalValueAdded Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2PurchaseUnregisteredDealer Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2PurchaseUnregisteredDealer Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2CreditOtherGoods Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2CreditOtherGoods Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2CreditCapitalGoods Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2CreditCapitalGoods Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2AdjustmentTaxCredit Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2AdjustmentTaxCredit Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalInterStateSale Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalInterStateSale Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalInterStatePurchase Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalInterStatePurchase Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
xtreg l2TotalPurchases Post iPostTreat i.TaxQuarter if Government==1, fe cluster(DealerTIN) robust
xtreg l2TotalPurchases Post iPostTreat i.TaxQuarter if Government==0, fe cluster(DealerTIN) robust
log close
}



test Post+iPostTreat=0
test Post=iPostTreat
test iPostTreat=0
test iPostTreatNotGovernment+iPostTreat=0
test Post
xtreg l2TaxCreditBeforeAdjustment Post iPostTreat iPostNotGovernment iPostTreatNotGovernment i.TaxQuarter, fe cluster(DealerTIN)
test Post
test iPostNotGovernment+Post=0
test iPostTreat=0
test iPostTreat+iPostTreatNotGovernment=0
