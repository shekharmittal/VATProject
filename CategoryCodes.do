//Had to edit one of the categories in the categories file
use "H:\CommodityCategories.dta", clear
tab Category
replace Category="Other" if Category=="Stickers"
save "H:\CommodityCategories.dta", replace



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
merge m:1 id DealerTIN using "H:\java_results_quarter\SOLD_TO_2013_Q1\returns_2013_q1.dta"

/*
 merge m:1 id DealerTIN using "H:\java_results_quarter\SOLD_TO_2013_Q1\returns_2
> 013_q1.dta"
(label _merge already defined)

    Result                           # of obs.
    -----------------------------------------
    not matched                     7,350,706
        from master                 7,343,462  (_merge==1)
        from using                      7,244  (_merge==2)

    matched                           313,948  (_merge==3)
    -----------------------------------------

*/ 



* What do we do with those guys who do not merge with the commodity? No commodity information?
//Keep only 2013 q1 observations
drop if _merge==1

replace CommodityCode="" if CommodityCode=="-1"


//Calculate number of dealertins with 1 commodity
gsort DealerTIN CommodityCode
by DealerTIN: gen RunningCommodityCount=_n
by DealerTIN: gen TotalCommodityCount=_N

tab TotalCommodityCount if RunningCommodityCount==1&CommodityCode!="", sort

/*
TotalCommod |
   ityCount |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    173,029       74.58       74.58
          2 |     41,955       18.08       92.67
          3 |     14,396        6.21       98.87
          4 |      1,673        0.72       99.60
          5 |        464        0.20       99.80
          6 |        162        0.07       99.87
          7 |        130        0.06       99.92
          8 |         67        0.03       99.95
          9 |         28        0.01       99.96
         10 |         30        0.01       99.98
         11 |         17        0.01       99.98
         12 |         10        0.00       99.99
         13 |          4        0.00       99.99
         14 |          5        0.00       99.99
         15 |          5        0.00       99.99
         16 |          8        0.00      100.00
         17 |          1        0.00      100.00
         20 |          2        0.00      100.00
         23 |          1        0.00      100.00
         30 |          2        0.00      100.00
         31 |          1        0.00      100.00
------------+-----------------------------------
      Total |    231,990      100.00
*/
	
gsort DealerTIN Category CommodityCode
by DealerTIN Category: gen RunningCommodityCount2=_n
by DealerTIN Category: gen TotalCommodityCount2=_N

drop if RunningCommodityCount2!=1

by DealerTIN: gen RunningCategoryCount=_n if RunningCommodityCount2==1&CommodityCode!=""
by DealerTIN: gen TotalCategoryCount=_N if RunningCommodityCount2==1&CommodityCode!=""

tab TotalCategoryCount if RunningCategoryCount==1&CommodityCode!=""

// There are issues with this method. Check it here. Return after the break
br DealerTIN CommodityCode CommodityDescription Category RunningCategoryCount TotalCategoryCount RunningCommodityCount RunningCommodityCount2 if DealerTIN=="100070"

tab Category if TotalCategoryCount==1
tab Category if TotalCategoryCount==1, missing
tab Category if TotalCategoryCount==1&CommodityCode!="", missing sort


keep if TotalCategoryCount==1
save "H:\java_results_quarter\SOLD_TO_2013_Q1\returns_2013_q1_with_unique_category.dta"

//Now we will look at the distributions of network size by category
merge 1:1 DealerTIN using "H:\sold_to_2013_q1_all_numbernodes.dta", keepusing(NumberNodes NetworkSize) generate(_merge_networksize)
/*
.	merge 1:1 DealerTIN using "H:\sold_to_2013_q1_all_numbernodes.dta", keepusing(N
>	umberNodes NetworkSize) generate(_merge_networksize)

	Result                           # of obs.
	-----------------------------------------
	not matched                        93,608
	from master                    44,006  (_merge_networksize==1)
	from using                     49,602  (_merge_networksize==2)

	matched                           144,892  (_merge_networksize==3)
	
	 tab Category NetworkSize, missing

                      |           NetworkSize
             Category |            Large N..  Small N.. |     Total
----------------------+---------------------------------+----------
                      |         0     45,647      3,955 |    49,602 
    Agriculture Tools |       157        152         32 |       341 
          Animal Feed |        79         69         28 |       176 
   Arms & Ammunitions |        68         32         20 |       120 
          Automobiles |     1,255      7,138        687 |     9,080 
Bituminous Packing .. |         1          5          4 |        10 
              Cameras |       560      1,716        319 |     2,595 
              Carpets |        73         94         24 |       191 
              Cartons |       188      1,584        109 |     1,881 
              Cereals |       856      1,228        291 |     2,375 
            Chemicals |       107        444        113 |       664 
               Clocks |        36        291         36 |       363 
      Coir/Jute Items |        63        177         41 |       281 
     Colouring Agents |       305      1,321        123 |     1,749 
Commercial Electric.. |     1,603      6,743        658 |     9,004 
            Computers |     1,029      3,861        179 |     5,069 
        Confectionery |       344        922        148 |     1,414 
         Construction |     2,131      4,441        774 |     7,346 
            Cosmetics |       425      1,310        218 |     1,953 
Disability Instrume.. |        14         12          5 |        31 
Domestic Electrical.. |       423      1,717         90 |     2,230 
Earthenware and Han.. |       415        343        144 |       902 
Electronic Appliances |     1,324      4,488        502 |     6,314 
Empty Bottles & Corks |        31         75         41 |       147 
 Empty Tins & Barrels |        24         58         15 |        97 
   Fabrics & Garments |     5,675      8,120      2,940 |    16,735 
           Fibreglass |        25         92         31 |       148 
                 Foam |        41        159         44 |       244 
             Footware |       961      2,448        555 |     3,964 
Fruits and Vegetables |        73         31          8 |       112 
            Furniture |       843      2,871        352 |     4,066 
            GI Sheets |        21         48          5 |        74 
           Gift Items |       210        449         79 |       738 
                Glass |       157        512         89 |       758 
        Hides & Skins |       244        416        202 |       862 
   Horticulture Tools |        63         65         15 |       143 
                  ICE |         4         14          3 |        21 
            Jewellery |     1,292      3,856        480 |     5,628 
         Kirana Items |       742      2,667        458 |     3,867 
               Liquor |        29        136         37 |       202 
                Locks |       135        387         55 |       577 
            Machinery |     1,860      7,302        839 |    10,001 
           Mattresses |        61        152         46 |       259 
                Meat  |        76         60         27 |       163 
   Medical Equipments |       592      1,927        240 |     2,759 
            Medicines |       675      3,246        523 |     4,444 
               Metals |     2,448     10,060      2,032 |    14,540 
Milk and Dairy Prod.. |       163        351         99 |       613 
  Musical Instruments |        29         60         13 |       102 
Non Edible Kirana I.. |       151        287         44 |       482 
 Non-Alcoholic Drinks |       111        190         23 |       324 
     Office Equipment |        72        251         31 |       354 
            Oil & Gas |       134        569         14 |       717 
            Oil Seeds |        11         21          2 |        34 
         Oil and Ghee |       113        281         67 |       461 
        Optical Goods |        76        566         86 |       728 
                Other |     8,522     13,673      2,538 |    24,733 
Other Packing Mater.. |       238      1,451        219 |     1,908 
            PVC Goods |       114        456        107 |       677 
        Paper & Board |       785      3,340        592 |     4,717 
   Petroleum Products |     1,428      3,947      1,202 |     6,577 
        Plastic Goods |       307      1,479        210 |     1,996 
Polythene Packing M.. |       101        747        105 |       953 
      Processed Foods |       321        878        159 |     1,358 
         Rubber Goods |       132        519        125 |       776 
             Services |       641      1,097         52 |     1,790 
   Soaps & Detergents |        76        190         28 |       294 
          Sport Goods |       111        245         32 |       388 
           Stationery |       665      3,528        148 |     4,341 
               Strips |        27         70         12 |       109 
                Sugar |        69         25         17 |       111 
            Suitcases |       113        641         87 |       841 
              Telecom |       495      1,355         99 |     1,949 
               Timber |       350      1,093        338 |     1,781 
     Tobacco Products |        96        131         29 |       256 
                 Toys |       133        651        149 |       933 
             Utensils |       341      1,676        202 |     2,219 
Weather Protecting .. |        12         32         17 |        61 
  Welding Instruments |        55        337         37 |       429 
         Wooden Boxes |        36         96         33 |       165 
         Yarn & Fibre |       240        653        190 |     1,083 
----------------------+---------------------------------+----------
                Total |    44,006    169,772     24,722 |   238,500 

 
*/

log using "H:\automobile_dealers_2013_q1.log"
set more off
list DealerTIN if Category=="Automobiles"
log close
log using "H:\jewellery_dealers_2013_q1.log"
set more off
list DealerTIN if Category=="Jewellery"
log close
log using "H:\petroleum_dealers_2013_q1.log"
list DealerTIN if Category=="Petroleum Products"
log close
log using "H:\medicines_dealers_2013_q1.log"
list DealerTIN if Category=="Medicines"
log close


log using "H:\automobile_dealers_2013_q1_superset.log"
set more off
preserve
keep if Category=="Automobiles"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
list DealerTIN if Category=="Automobiles"
restore 
log close

log using "H:\jewellery_dealers_2013_q1_superset.log"
set more off
preserve
keep if Category=="Jewellery"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
list DealerTIN if Category=="Jewellery"
restore
log close

log using "H:\liquor_dealers_2013_q1_superset.log"
preserve
keep if Category=="Liquor"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
list DealerTIN if Category=="Liquor"
restore
log close

log using "H:\medicines_dealers_2013_q1_superset.log"
preserve
keep if Category=="Medicines"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
list DealerTIN if Category=="Medicines"
restore
log close

log using "H:\Oil_dealers_2013_q1_superset.log"
preserve
keep if Category=="Oil & Gas"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
list DealerTIN if Category=="Oil & Gas"
restore
log close

log using "H:\Machinery_dealers_2013_q1_superset.log"
preserve
keep if Category=="Machinery"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
list DealerTIN if Category=="Machinery"
restore
log close


// Trying to find upper bounds for each commodity
log using "H:\CollectionsCommodityWise_upperbound.log", append
preserve
keep if Category=="Oil & Gas"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
sum TurnoverGross AmountDepositedByDealer TotalValueAdded
isid DealerTIN
restore

preserve
keep if Category=="Jewellery"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
sum TurnoverGross AmountDepositedByDealer TotalValueAdded
isid DealerTIN
restore

preserve
keep if Category=="Automobiles"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
sum TurnoverGross AmountDepositedByDealer TotalValueAdded
isid DealerTIN
restore


preserve
keep if Category=="Medicines"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
sum TurnoverGross AmountDepositedByDealer TotalValueAdded
isid DealerTIN
restore

preserve
keep if Category=="Machinery"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
sum TurnoverGross AmountDepositedByDealer TotalValueAdded
isid DealerTIN
restore

preserve
keep if Category=="Liquor"
bys DealerTIN: gen RunningCount=_n
tab RunningCount
keep if RunningCount==1
sum TurnoverGross AmountDepositedByDealer TotalValueAdded
isid DealerTIN
restore
log close
