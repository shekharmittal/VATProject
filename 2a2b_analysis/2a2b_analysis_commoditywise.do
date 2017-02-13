use "D:\data\TableCommodityCodeforDealerProfile.dta", clear
drop R438005 R438006 R438007 R438008 R438DF1 R438DF2 R438DF3 R438DF4 R438DF5 R438DF6 R438DF7 R438DF8 R438DF9 R438D10

merge m:1 CommodityCode using "H:\CommodityCategories.dta", keepusing(Category CategoryCount CommodityCode3Digit) generate(_merge_category)
drop if _merge_category==1

merge m:1 DealerTIN using "D:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)

gsort DealerTIN CommodityCode
by DealerTIN: gen RunningCommodityCount=_n
by DealerTIN: gen TotalCommodityCount=_N


gsort DealerTIN Category CommodityCode
by DealerTIN Category: gen RunningCommodityCount2=_n
by DealerTIN Category: gen TotalCommodityCount2=_N

keep if TotalCommodityCount2==1&RunningCommodityCount2==1

gsort DealerTIN Category

by DealerTIN: gen RunningCategoryCount=_n
by DealerTIN: gen TotalCategoryCount=_N
keep if TotalCategoryCount==1&RunningCategoryCount==1

save "D:\data\DealerProfile_uniqueCategory.dta", replace


use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

drop _merge

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

merge m:1 DealerTIN using "H:\CombinedMinDistanceFromStartEndNodes.dta"
drop if _merge==2

merge m:1 DealerTIN using "D:\data\DealerProfile_uniqueCategory.dta", keepusing(Category) generate(_merge_category)

