/*
We want to ensure that all dealertins are included, (even those that have not filed dealer profiles
As a result we will merge both dealer profiles and returns
*/

use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta" 


drop ReturnCount

//Keep unique dealer tins
by DealerTIN: gen ReturnCount=_n
keep if ReturnCount==1

//Check if dealertins are unique
isid DealerTIN

//Drop all returns based columns
drop id RefundClaimedBoolean TaxPeriod PeriodBegin PeriodEnd DealerName DealerAddress DealerTelephone T312011 Frequency T312012 T312013 TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 T312020 T312021 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 T312028 T312029 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 T312043 T312044 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 T312051 T312052 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 T312057 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable TDSCertificates BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance AdjustCSTLiability BalanceBroughtForward RefundClaimed BalanceCarriedNextTaxPeriod AccountNumber AccountType MICR BankDetails InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 T312082 T312083 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia T312092 T312093 InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase T312104 T312105 Date Place Designation Name TurnoverAt20 OutputTaxAt20
drop ReturnCount groupid Days Time Tin SourceFile T312202 T312203 HighSeaPurchase HighSeaSale PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule OtherDealersGoodsReJobF OtherDealersGoodsTrJobF OwnGoodsReceivedAfterJobF OwnGoodsTransferredAfterJobF InwardStockTransferConsignmentF OutwardStockTransferConsignmentF InwardStockTransferBranchF OutwardStockTransferBranchF CSTAdjustmentVAT CarryForwardTaxCredit PurchaseCapitalNonCreditGood PurchaseDelhiFormH PurchaseIneligibleForITC WCLabourPurchase SaleDelhiFormH LandCharges LaborCharges T312178 PurchaseTaxFreeGoods PurchaseRetailInvoice PurchaseNonCreditableGoods PurchaseCompositionDealer Signatory DieselPurchase DieselSale T312DF8 T312DF7 T312DF6 T312DF5 T312DF4 T312DF3 T312DF2 T312DF1 T312170 ReturnType PurchaseUnregisteredDealer T312167 T312166 T312165 T312164 T312163 T312162 T312161 T312160 T312159 T312158 T312157 T312156 T312155 T312154 T312153 T312152 T312151 T312150 T312149 Year AcknowledgementNumber ApprovalDate Status TDSDetails T312142 T312141 T312140 T312139 T312138 T312137 TDSString T312134 T312133 T312132 T312131 T312130 T312129 T312128 T312127 T312126 T312125 T312124
drop T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123

merge m:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta"

tab ReturnCount
drop ReturnCount
rename _merge Merge
label variable Merge "1 available only in returns, 2 available only in dealer profiles, 3 available in both"


gen DateofRegistration=dofc(RegistrationDate)
format %td DateofRegistration //change it into date format

*gen CancellationYear2=dofc(T678DF3)
*format %td CancellationYear2 //change it into date format

gen RegistrationYear=yofd(DateofRegistration)
gen RegistrationMonth=mofd(DateofRegistration)

format %tm RegistrationMonth
format %ty RegistrationYear //Changing the format to appropriate year form

replace RegistrationMonth=RegistrationMonth-599

gen RegistrationQuarter=.
replace RegistrationQuarter=1 if RegistrationMonth>3&RegistrationMonth<=6
replace RegistrationQuarter=2 if RegistrationMonth>6&RegistrationMonth<=9
replace RegistrationQuarter=3 if RegistrationMonth>9&RegistrationMonth<=12
replace RegistrationQuarter=4 if RegistrationMonth>12&RegistrationMonth<=15
replace RegistrationQuarter=5 if RegistrationMonth>15&RegistrationMonth<=18
replace RegistrationQuarter=6 if RegistrationMonth>18&RegistrationMonth<=21
replace RegistrationQuarter=7 if RegistrationMonth>21&RegistrationMonth<=24
replace RegistrationQuarter=8 if RegistrationMonth>24&RegistrationMonth<=27
replace RegistrationQuarter=9 if RegistrationMonth>27&RegistrationMonth<=30
replace RegistrationQuarter=10 if RegistrationMonth>30&RegistrationMonth<=33
replace RegistrationQuarter=11 if RegistrationMonth>33&RegistrationMonth<=36
replace RegistrationQuarter=12 if RegistrationMonth>36&RegistrationMonth<=39
replace RegistrationQuarter=13 if RegistrationMonth>39&RegistrationMonth<=42
replace RegistrationQuarter=14 if RegistrationMonth>42&RegistrationMonth<=45
replace RegistrationQuarter=15 if RegistrationMonth>45&RegistrationMonth<=48
replace RegistrationQuarter=16 if RegistrationMonth>48&RegistrationMonth<=51
replace RegistrationQuarter=17 if RegistrationMonth>51&RegistrationMonth<=54
replace RegistrationQuarter=18 if RegistrationMonth>54&RegistrationMonth<=57
replace RegistrationQuarter=19 if RegistrationMonth>57&RegistrationMonth<=60
replace RegistrationQuarter=20 if RegistrationMonth>60&RegistrationMonth<=63
replace RegistrationQuarter=21 if RegistrationMonth>63&RegistrationMonth<=66
replace RegistrationQuarter=22 if RegistrationMonth>66&RegistrationMonth<=69

replace RegistrationMonth=RegistrationMonth+599

edit
set obs 373755
replace DealerTIN = "MD" in 373755
set obs 373756
replace DealerTIN = "UD" in 373756

save "F:\data\DealerTINs_from_returns.dta"

/*
help subinstr
help charlist
*/
replace DealerSecurity =subinstr(DealerSecurity, char(10), "",.)
export delimited using "C:\Users\Administrator\Desktop\dealerprofile_test.csv", delimiter("|") replace

export delimited using "F:\csv\DealerProfiles_from_bothfiles.csv", delimiter("|")

save "F:\data\DealerTINs_from_returns.dta", replace

