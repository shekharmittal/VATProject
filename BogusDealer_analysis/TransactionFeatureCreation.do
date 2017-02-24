use "F:\2a2b_analysis\RegisteredSalesAnalysis\RegisteredSales_AllQuarters.dta", clear
drop Quarter TaxProp TaxMonth TaxRate SourceFile
save "E:\data\PreliminaryAnalysis\BogusDealers\FeatureTransactions.dta", replace


