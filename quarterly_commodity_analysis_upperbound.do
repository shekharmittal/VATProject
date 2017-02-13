set more off
use "H:\data\TableCommodityCode.dta", clear

drop T771007 T771DF5 T771DF6 T771df7 T771DF8 T771DF9 T771DF1 T771DF3
edit CommodityCode CommodityDescription if CommodityCode==""&CommodityDescription!="Select"
replace CommodityCode = "306000" in 20722
replace CommodityCode = "521000" in 73209
replace CommodityCode = "524000" in 110396
replace CommodityCode = "304500" in 110397
replace CommodityCode = "825002" in 110398
replace CommodityCode = "426000" in 136473
replace CommodityCode = "425000" in 136472
replace CommodityCode = "113000" in 144345
replace CommodityCode = "203000" in 232203
replace CommodityCode = "203000" in 410857
replace CommodityCode = "521000" in 1918435
replace CommodityCode = "524000" in 2100916
replace CommodityCode = "304500" in 2100917
replace CommodityCode = "825002" in 2100918
replace CommodityCode = "521000" in 3575270
replace CommodityCode = "524000" in 4651350
replace CommodityCode = "304500" in 4651351
replace CommodityCode = "825002" in 4651352
replace CommodityCode = "306000" in 5747163

  
merge m:1 CommodityCode using "H:\CommodityCategories.dta", keepusing(Category CategoryCount CommodityCode3Digit) generate(_merge_category)

/*

    Result                           # of obs.
    -----------------------------------------
    not matched                         1,185
        from master                     1,185  (_merge_category==1)
        from using                          0  (_merge_category==2)

    matched                         7,656,225  (_merge_category==3)
				  
*/				  

drop if _merge_category==1


merge m:1 id DealerTIN using "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta"

keep if _merge==3
drop if TaxPeriod=="Fourth Quarter-2012"
drop if TaxPeriod=="Second Quarter-2012"


gen TaxQuarter=0
replace TaxQuarter=13 if TaxPeriod=="First Quarter-2013"
replace TaxQuarter=14 if TaxPeriod=="Second Quarter-2013"
replace TaxQuarter=15 if TaxPeriod=="Third Quarter-2013"
replace TaxQuarter=16 if TaxPeriod=="Fourth Quarter-2013"
replace TaxQuarter=17 if TaxPeriod=="First Quarter-2014"
replace TaxQuarter=18 if TaxPeriod=="Second Quarter-2014"
replace TaxQuarter=19 if TaxPeriod=="Third Quarter-2014"
replace TaxQuarter=20 if TaxPeriod=="Fourth Quarter-2014"


gen TaxYear=4 if TaxQuarter>12&TaxQuarter<=16
replace TaxYear=5 if TaxQuarter>16&TaxQuarter<=20

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"

label values TaxQuarter quarter
label values TaxYear year	


rename T312011 CommodityCode1
rename T312012 CommodityCode2
rename T312013 CommodityCode3

rename T312149 CommodityDescription1
rename T312150 CommodityDescription2
rename T312151 CommodityDescription3

label variable CommodityCode1 "Contains commodity code for returns in the first 3 years"
label variable CommodityCode2 "Contains commodity code for returns in the first 3 years"
label variable CommodityCode3 "Contains commodity code for returns in the first 3 years"

label variable CommodityDescription1 "Contains commodity description for returns in the first 3 years"
label variable CommodityDescription2 "Contains commodity description for returns in the first 3 years"
label variable CommodityDescription3 "Contains commodity description for returns in the first 3 years"


gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)


//Creating other variables of interest
egen PurchaseNoCredit=rowtotal(PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood)
gen PercValueAdded=(TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen TotalValueAdded=(TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)
gen PercPurchaseUnregisteredDealer=PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen PercPurchaseNoCredit=PurchaseNoCredit/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen TotalPurchases=PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit
gen TotalValueAddedLocal=(TurnoverLocal-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)
gen PercValueAddedLocal=(TurnoverLocal-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen RealTaxRateLocal=MoneyDeposited/TotalValueAddedLocal*100
gen RealTaxRate=MoneyDeposited/TotalValueAdded*100


label variable PurchaseNoCredit "R6.3 Total local purchases that are no eligible for credit of input tax"
label variable PercValueAdded "A measure of fraction of value added, definition is (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercValueAddedLocal "A measure of fraction of value added, definition is (TurnoverLocal-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseUnregisteredDealer "A measure of amount purchased from unregistered dealers:PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseNoCredit "Percentage of total purchases that are not eligible for credit of input tax PurchaseNoCredit/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)" 
label variable TotalValueAdded "Total value added, (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)"
label variable TotalValueAddedLocal "Total value added, (TurnoverLocal-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)"
label variable RealTaxRateLocal "MoneyDeposited/TotalValueAddedLocal*100"
label variable RealTaxRate "MoneyDeposited/TotalValueAdded*100"

drop DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood
drop T312002 RefundClaimedBoolean PeriodBegin PeriodEnd CommodityCode1 CommodityCode2 CommodityCode3 TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 InterestPayable PenaltyPayable TDSCertificates
drop HighSeaPurchase HighSeaSale PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule OtherDealersGoodsReJobF OtherDealersGoodsTrJobF OwnGoodsReceivedAfterJobF OwnGoodsTransferredAfterJobF InwardStockTransferConsignmentF OutwardStockTransferConsignmentF InwardStockTransferBranchF OutwardStockTransferBranchF CSTAdjustmentVAT CarryForwardTaxCredit SaleDelhiFormH LandCharges LaborCharges DieselSale ReturnType CommodityDescription3 CommodityDescription2 CommodityDescription1
drop SourceFile AcknowledgementNumber ApprovalDate Status TDSDetails WardName


//Calculate number of dealertins with 1 commodity
//gsort TaxQuarter DealerTIN CommodityCode
//by TaxQuarter DealerTIN: gen RunningCommodityCount=_n
//by TaxQuarter DealerTIN: gen TotalCommodityCount=_N

//by TaxQuarter: tab TotalCommodityCount if RunningCommodityCount==1&CommodityCode!="", sort

gsort TaxQuarter DealerTIN Category CommodityCode
by TaxQuarter DealerTIN Category: gen RunningCommodityCount2=_n
by TaxQuarter DealerTIN Category: gen TotalCommodityCount2=_N

drop if RunningCommodityCount2!=1

by TaxQuarter DealerTIN: gen RunningCategoryCount=_n if RunningCommodityCount2==1&CommodityCode!=""
by TaxQuarter DealerTIN: gen TotalCategoryCount=_N if RunningCommodityCount2==1&CommodityCode!=""


replace Category="Agriculture_Tools" if Category=="Agriculture Tools"
replace Category="Cereals" if Category=="Cereals"
replace Category="Fruits_and_Vegetables" if Category=="Fruits and Vegetables"
replace Category="Oil_Seeds" if Category=="Oil Seeds"
replace Category="Meat" if Category=="Meat "
replace Category="Milk_and_Dairy_Products" if Category=="Milk and Dairy Products"
replace Category="Oil_and_Ghee" if Category=="Oil and Ghee"
replace Category="Kirana_Items" if Category=="Kirana Items"
replace Category="Sugar" if Category=="Sugar"
replace Category="Non-Alcoholic_Drinks" if Category=="Non-Alcoholic Drinks"
replace Category="Liquor" if Category=="Liquor"
replace Category="Narcotics" if Category=="Narcotics"
replace Category="Confectionery" if Category=="Confectionery"
replace Category="Processed_Foods" if Category=="Processed Foods"
replace Category="Tobacco_Products" if Category=="Tobacco Products"
replace Category="Soaps_&_Detergents" if Category=="Soaps & Detergents"
replace Category="Electronic_Appliances" if Category=="Electronic Appliances"
replace Category="Cosmetics" if Category=="Cosmetics"
replace Category="Non_Edible_Kirana_Items" if Category=="Non Edible Kirana Items"
replace Category="Carpets" if Category=="Carpets"
replace Category="Coir_Jute_Items" if Category=="Coir/Jute Items"
replace Category="Mattresses" if Category=="Mattresses"
replace Category="Utensils" if Category=="Utensils"
replace Category="Fabrics_&_Garments" if Category=="Fabrics & Garments"
replace Category="Earthenware_and_Handicrafts" if Category=="Earthenware and Handicrafts"
replace Category="Clocks" if Category=="Clocks"
replace Category="Locks" if Category=="Locks"
replace Category="Suitcases" if Category=="Suitcases"
replace Category="GI_Sheets" if Category=="GI Sheets"
replace Category="Weather_Protecting_Goods" if Category=="Weather Protecting Goods"
replace Category="Footware" if Category=="Footware"
replace Category="Hides_&_Skins" if Category=="Hides & Skins"
replace Category="Domestic_Electrical_Appliances" if Category=="Domestic Electrical Appliances"
replace Category="Electronic_Appliances" if Category=="Electronic Appliances"
replace Category="Commercial_Electrical_Appliances" if Category=="Commercial Electrical Appliances"
replace Category="Welding_Instruments" if Category=="Welding Instruments"
replace Category="Electronic_Appliances" if Category=="Electronic Appliances"
replace Category="Computers" if Category=="Computers"
replace Category="Telecom" if Category=="Telecom"
replace Category="Jewellery" if Category=="Jewellery"
replace Category="Gift_Items" if Category=="Gift Items"
replace Category="Arms_&_Ammunitions" if Category=="Arms & Ammunitions"
replace Category="Toys" if Category=="Toys"
replace Category="Optical_Goods" if Category=="Optical Goods"
replace Category="Glass" if Category=="Glass"
replace Category="Sport_Goods" if Category=="Sport Goods"
replace Category="Oil" if Category=="Oil"
replace Category="Gas" if Category=="Gas"
replace Category="Petroleum_Products" if Category=="Petroleum Products"
replace Category="Chemicals" if Category=="Chemicals"
replace Category="ICE" if Category=="ICE"
replace Category="Automobiles" if Category=="Automobiles"
replace Category="Machinery" if Category=="Machinery"
replace Category="Metals" if Category=="Metals"
replace Category="Colouring_Agents" if Category=="Colouring Agents"
replace Category="Plastic_Goods" if Category=="Plastic Goods"
replace Category="Rubber_Goods" if Category=="Rubber Goods"
replace Category="PVC_Goods" if Category=="PVC Goods"
replace Category="Foam" if Category=="Foam"
replace Category="Fibreglass" if Category=="Fibreglass"
replace Category="Yarn_&_Fibre" if Category=="Yarn & Fibre"
replace Category="Paper_&_Board" if Category=="Paper & Board"
replace Category="Stationery" if Category=="Stationery"
replace Category="Medicines" if Category=="Medicines"
replace Category="Medical_Equipments" if Category=="Medical Equipments"
replace Category="Disability_Instruments" if Category=="Disability Instruments"
replace Category="Agriculture_Tools" if Category=="Agriculture Tools"
replace Category="Animal_Feed" if Category=="Animal Feed"
replace Category="Horticulture_Tools" if Category=="Horticulture Tools"
replace Category="Construction" if Category=="Construction"
replace Category="Timber" if Category=="Timber"
replace Category="Furniture" if Category=="Furniture"
replace Category="Cameras" if Category=="Cameras"
replace Category="Musical_Instruments" if Category=="Musical Instruments"
replace Category="Lottery" if Category=="Lottery"
replace Category="Office_Equipment" if Category=="Office Equipment"
replace Category="Empty_Tins_&_Barrels" if Category=="Empty Tins & Barrels"
replace Category="Wooden_Boxes" if Category=="Wooden Boxes"
replace Category="Empty_Bottles_&_Corks" if Category=="Empty Bottles & Corks"
replace Category="Polythene_Packing_Materials" if Category=="Polythene Packing Materials"
replace Category="Cartons" if Category=="Cartons"
replace Category="Bituminous_Packing_Materials" if Category=="Bituminous Packing Materials"
replace Category="Strips" if Category=="Strips"
replace Category="Other_Packing_Material" if Category=="Other Packing Material"
replace Category="Coir_Jute_Items" if Category=="Coir/Jute Items"
replace Category="Other_Packing_Material" if Category=="Other Packing Material"
replace Category="Services" if Category=="Services"
replace Category="Stickers" if Category=="Stickers"
/*
//local Category "Cereals Fruits_and_Vegetables Oil_Seeds Milk_and_Dairy_Products Oil_and_Ghee Kirana_Items Sugar Non-Alcoholic_Drinks Liquor Confectionery Tobacco_Products Soaps_&_Detergents Electronic_Appliances Cosmetics Non_Edible_Kirana_Items Carpets Coir_Jute_Items Mattresses Utensils Fabrics_&_Garments Earthenware_and_Handicrafts Clocks Locks Suitcases GI_Sheets Weather_Protecting_Goods Footware Hides_&_Skins Domestic_Electrical_Appliances Commercial_Electrical_Appliances Welding_Instruments Electronic_Appliances Computers Telecom Jewellery Gift_Items Arms_&_Ammunitions Toys Optical_Goods Glass Sport_Goods Oil_&_Gas Machinery Metals Colouring_Agents Plastic_Goods Rubber_Goods PVC_Goods Foam Fibreglass Yarn_&_Fibre Paper_&_Board Stationery Medicines Medical_Equipments Disability_Instruments Agriculture_Tools Animal_Feed Horticulture_Tools Construction Timber Furniture Cameras Musical_Instruments Office_Equipment Empty_Tins_&_Barrels Wooden_Boxes Empty_Bottles_&_Corks Polythene_Packing_Materials Cartons Bituminous_Packing_Materials Strips Other_Packing_Material Coir_Jute_Items Other_Packing_Material Services"
foreach quest in `Category'	{
preserve
keep if Category=="`quest'"
bys TaxQuarter DealerTIN: gen RunningCount=_n
keep if RunningCount==1
bysort TaxQuarter: outreg2 using `quest'_upperbound.xls if Category=="`quest'", replace sum(log) eqkeep(N mean) keep(TurnoverGross MoneyDeposited TotalValueAdded CreditOtherGoods TotalTaxCredit TotalOutputTax) cttop(`quest')
restore 
}*/

save "upperbound_intermediate.dta", replace

preserve
keep if Category=="Petroleum_Products"
bys TaxQuarter DealerTIN: gen RunningCount=_n
keep if RunningCount==1
gen Dummy=1
collapse (mean) RealTaxRateLocal RealTaxRate (sum) Dummy TurnoverGross TurnoverLocal MoneyDeposited TotalValueAdded TotalValueAddedLocal PercValueAdded PercValueAddedLocal CreditOtherGoods TotalOutputTax TotalTaxCredit, by (TaxQuarter Category)
replace TurnoverGross=TurnoverGross/10000000
replace TurnoverLocal=TurnoverLocal/10000000
replace MoneyDeposited=MoneyDeposited/10000000
replace TotalValueAdded =TotalValueAdded/10000000
replace TotalValueAddedLocal=TotalValueAddedLocal/10000000
replace PercValueAdded=PercValueAdded/10000000
replace PercValueAddedLocal=PercValueAddedLocal/10000000
replace CreditOtherGoods=CreditOtherGoods/10000000
replace TotalOutputTax=TotalOutputTax/10000000
replace TotalTaxCredit=TotalTaxCredit/10000000
gen RealTaxRateLocalAgg=MoneyDeposited/TotalValueAddedLocal*100
gen RealTaxRateAgg=MoneyDeposited/TotalValueAdded*100
//save `quest'_upperbound.dta
//append CategoryWiseAnalysisUpperBound.dta
save CategoryWiseAnalysisUpperBound.dta, replace 
restore

local Category "Automobiles Other Processed_Foods Chemicals ICE Cereals Fruits_and_Vegetables Oil_Seeds Milk_and_Dairy_Products Oil_and_Ghee Kirana_Items Sugar Non-Alcoholic_Drinks Liquor Confectionery Tobacco_Products Soaps_&_Detergents Electronic_Appliances Cosmetics Non_Edible_Kirana_Items Carpets Coir_Jute_Items Mattresses Utensils Fabrics_&_Garments Earthenware_and_Handicrafts Clocks Locks Suitcases GI_Sheets Weather_Protecting_Goods Footware Hides_&_Skins Domestic_Electrical_Appliances Commercial_Electrical_Appliances Welding_Instruments Computers Telecom Jewellery Gift_Items Arms_&_Ammunitions Toys Optical_Goods Glass Sport_Goods Oil Gas Machinery Metals Colouring_Agents Plastic_Goods Rubber_Goods PVC_Goods Foam Fibreglass Yarn_&_Fibre Paper_&_Board Stationery Medicines Medical_Equipments Disability_Instruments Agriculture_Tools Animal_Feed Horticulture_Tools Construction Timber Furniture Cameras Musical_Instruments Office_Equipment Empty_Tins_&_Barrels Wooden_Boxes Empty_Bottles_&_Corks Polythene_Packing_Materials Cartons Bituminous_Packing_Materials Strips Other_Packing_Material  Services"
foreach quest in `Category'	{
preserve
keep if Category=="`quest'"
gsort TaxQuarter DealerTIN
by TaxQuarter DealerTIN: gen RunningCount=_n
keep if RunningCount==1
gen Dummy=1
collapse (mean) RealTaxRateLocal RealTaxRate (sum) Dummy TurnoverGross TurnoverLocal MoneyDeposited TotalValueAdded TotalValueAddedLocal PercValueAdded PercValueAddedLocal CreditOtherGoods TotalOutputTax TotalTaxCredit, by (TaxQuarter Category)
replace TurnoverGross=TurnoverGross/10000000
replace TurnoverLocal=TurnoverLocal/10000000
replace MoneyDeposited=MoneyDeposited/10000000
replace TotalValueAdded =TotalValueAdded/10000000
replace TotalValueAddedLocal=TotalValueAddedLocal/10000000
replace PercValueAdded=PercValueAdded/10000000
replace PercValueAddedLocal=PercValueAddedLocal/10000000
replace CreditOtherGoods=CreditOtherGoods/10000000
replace TotalOutputTax=TotalOutputTax/10000000
replace TotalTaxCredit=TotalTaxCredit/10000000
gen RealTaxRateLocalAgg=MoneyDeposited/TotalValueAddedLocal*100
gen RealTaxRateAgg=MoneyDeposited/TotalValueAdded*100
//save `quest'_upperbound.dta
append using "CategoryWiseAnalysisUpperBound.dta"
save CategoryWiseAnalysisUpperBound.dta, replace 
restore 
}
