use "F:\data\TableCommodityCode.dta", clear

drop T771007 T771DF5 T771DF6 T771df7 T771DF8 T771DF9 T771DF1 T771DF3

merge m:1 id DealerTIN using "F:\data\returns\returns_cleaned_1104_neo4j.dta"
keep if _merge==3
drop T312002 RefundClaimedBoolean TaxPeriod PeriodBegin PeriodEnd CommodityCode1 CommodityCode2 CommodityCode3 TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable TDSCertificates BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase WardName TDSDetails Status ApprovalDate AcknowledgementNumber Year CommodityDescription1 CommodityDescription2 CommodityDescription3 PurchaseUnregisteredDealer ReturnType DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase SourceFile TaxYear TaxHalfyear TaxQuarter TaxMonth MoneyDeposited idNew _merge

replace CommodityCode = "425000" in 92734
replace CommodityCode = "426000" in 92735
replace CommodityCode = "113000" in 97668
replace CommodityCode = "203000" in 287020
replace CommodityCode = "524000" in 1735655
replace CommodityCode = "304500" in 1735656
replace CommodityCode = "825002" in 1735657
replace CommodityCode = "521000" in 2243435
replace CommodityCode = "306000" in 3749718

gsort id DealerTIN CommodityCode CommodityDescription
by id DealerTIN CommodityCode CommodityDescription:gen Count=_n
keep if Count==1
replace CommodityDescription=="missing" if CommodityDescription==""

egen idCommodity=group(id DealerTIN CommodityCode CommodityDescription)
label variable idCommodity "THis is the unique id for neo4j"


//We need to do this because we will use commoditycode file for building relationships return nodes and commodity code nodes
//For this to happen we need "commoditycode idNew" relationship entries.
merge m:1 id DealerTIN using "F:\data\returns\returns_cleaned_1104_neo4j.dta", keepusing(idNew)
keep if _merge==3
drop _merge
label variable idNew "This is the new unique id for returns, which is needed for neo4j"


save "F:\data\CommodityCode\commoditycode_returns_cleaned_1104_neo4j.dta", replace

 
