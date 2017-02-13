//Lets look at Sold To information for 2013 q1

//Import information regarding network numbers and save it.
import delimited F:\java_results_quarter\SOLD_TO_2013_Q1\DEGREES.csv, clear 
drop id
rename dealertin DealerTIN
tostring DealerTIN, replace
save "F:\java_results_quarter\SOLD_TO_2013_Q1\network_numbers_2013_q1.dta"


//Save tax returns for the appropriate quarter
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear 
tab TaxPeriod
keep if TaxPeriod=="First Quarter-2013"
isid DealerTIN
drop if TurnoverGross<0

drop groupid ReturnCount Time Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 Days T312178 Signatory


gen TaxYear=0
replace TaxYear=1 if TaxPeriod=="Annual-2010"
replace TaxYear=2 if TaxPeriod=="Annual-2011"
replace TaxYear=3 if TaxPeriod=="Annual-2012"

gen TaxHalfyear=0
replace TaxHalfyear=1 if TaxPeriod=="First Halfyear-2010"
replace TaxHalfyear=2 if TaxPeriod=="Second Halfyear-2010"
replace TaxHalfyear=3 if TaxPeriod=="First Halfyear-2011"
replace TaxHalfyear=4 if TaxPeriod=="Second Halfyear-2011"
replace TaxHalfyear=5 if TaxPeriod=="First Halfyear-2012"
replace TaxHalfyear=6 if TaxPeriod=="Second Halfyear-2012"

replace TaxYear=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="Second Halfyear-2010"
replace TaxYear=2 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
replace TaxYear=3 if TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"


gen TaxQuarter=0
replace TaxQuarter=1 if TaxPeriod=="First Quarter-2010"
replace TaxQuarter=2 if TaxPeriod=="Second Quarter-2010"
replace TaxQuarter=3 if TaxPeriod=="Third Quarter-2010"
replace TaxQuarter=4 if TaxPeriod=="Fourth Quarter-2010"
replace TaxQuarter=5 if TaxPeriod=="First Quarter-2011"
replace TaxQuarter=6 if TaxPeriod=="Second Quarter-2011"
replace TaxQuarter=7 if TaxPeriod=="Third Quarter-2011"
replace TaxQuarter=8 if TaxPeriod=="Fourth Quarter-2011"
replace TaxQuarter=9 if TaxPeriod=="First Quarter-2012"
replace TaxQuarter=10 if TaxPeriod=="Second Quarter-2012"
replace TaxQuarter=11 if TaxPeriod=="Third Quarter-2012"
replace TaxQuarter=12 if TaxPeriod=="Fourth Quarter-2012"
replace TaxQuarter=13 if TaxPeriod=="First Quarter-2013"
replace TaxQuarter=14 if TaxPeriod=="Second Quarter-2013"
replace TaxQuarter=15 if TaxPeriod=="Third Quarter-2013"
replace TaxQuarter=16 if TaxPeriod=="Fourth Quarter-2013"
replace TaxQuarter=17 if TaxPeriod=="First Quarter-2014"
replace TaxQuarter=18 if TaxPeriod=="Second Quarter-2014"
replace TaxQuarter=19 if TaxPeriod=="Third Quarter-2014"
replace TaxQuarter=20 if TaxPeriod=="Fourth Quarter-2014"


replace TaxYear=1 if TaxQuarter>0&TaxQuarter<=4
replace TaxYear=2 if TaxQuarter>4&TaxQuarter<=8
replace TaxYear=3 if TaxQuarter>8&TaxQuarter<=12
replace TaxYear=4 if TaxQuarter>12&TaxQuarter<=16
replace TaxYear=5 if TaxQuarter>16&TaxQuarter<=20

gen TaxMonth=0
replace TaxMonth=1 if TaxPeriod=="Apr-2010"
replace TaxMonth=2 if TaxPeriod=="May-2010"
replace TaxMonth=3 if TaxPeriod=="Jun-2010"
replace TaxMonth=4 if TaxPeriod=="Jul-2010"
replace TaxMonth=5 if TaxPeriod=="Aug-2010"
replace TaxMonth=6 if TaxPeriod=="Sep-2010"
replace TaxMonth=7 if TaxPeriod=="Oct-2010"
replace TaxMonth=8 if TaxPeriod=="Nov-2010"
replace TaxMonth=9 if TaxPeriod=="Dec-2010"
replace TaxMonth=10 if TaxPeriod=="Jan-2011"
replace TaxMonth=11 if TaxPeriod=="Feb-2011"
replace TaxMonth=12 if TaxPeriod=="Mar-2011"
replace TaxMonth=13 if TaxPeriod=="Apr-2011"
replace TaxMonth=14 if TaxPeriod=="May-2011"
replace TaxMonth=15 if TaxPeriod=="Jun-2011"
replace TaxMonth=16 if TaxPeriod=="Jul-2011"
replace TaxMonth=17 if TaxPeriod=="Aug-2011"
replace TaxMonth=18 if TaxPeriod=="Sep-2011"
replace TaxMonth=19 if TaxPeriod=="Oct-2011"
replace TaxMonth=20 if TaxPeriod=="Nov-2011"
replace TaxMonth=21 if TaxPeriod=="Dec-2011"
replace TaxMonth=22 if TaxPeriod=="Jan-2012"
replace TaxMonth=23 if TaxPeriod=="Feb-2012"
replace TaxMonth=24 if TaxPeriod=="Mar-2012"
replace TaxMonth=25 if TaxPeriod=="Apr-2012"
replace TaxMonth=26 if TaxPeriod=="May-2012"
replace TaxMonth=27 if TaxPeriod=="Jun-2012"
replace TaxMonth=28 if TaxPeriod=="Jul-2012"
replace TaxMonth=29 if TaxPeriod=="Aug-2012"
replace TaxMonth=30 if TaxPeriod=="Sep-2012"
replace TaxMonth=31 if TaxPeriod=="Oct-2012"
replace TaxMonth=32 if TaxPeriod=="Nov-2012"
replace TaxMonth=33 if TaxPeriod=="Dec-2012"
replace TaxMonth=34 if TaxPeriod=="Jan-2013"
replace TaxMonth=35 if TaxPeriod=="Feb-2013"
replace TaxMonth=36 if TaxPeriod=="Mar-2013"
replace TaxMonth=37 if TaxPeriod=="Apr-2013"
replace TaxMonth=38 if TaxPeriod=="May-2013"


replace TaxYear=1 if TaxMonth>0&TaxMonth<=12
replace TaxYear=2 if TaxMonth>12&TaxMonth<=24
replace TaxYear=3 if TaxMonth>24&TaxMonth<=36
replace TaxYear=4 if TaxMonth>36

replace TaxQuarter=1 if TaxMonth>0&TaxMonth<=3
replace TaxQuarter=2 if TaxMonth>3&TaxMonth<=6
replace TaxQuarter=3 if TaxMonth>6&TaxMonth<=9
replace TaxQuarter=4 if TaxMonth>9&TaxMonth<=12
replace TaxQuarter=5 if TaxMonth>12&TaxMonth<=15
replace TaxQuarter=6 if TaxMonth>15&TaxMonth<=18
replace TaxQuarter=7 if TaxMonth>18&TaxMonth<=21
replace TaxQuarter=8 if TaxMonth>21&TaxMonth<=24
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36
replace TaxQuarter=13 if TaxMonth>36&TaxMonth<=39

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

replace WardName="Ward 16" if WardName=="311301"
replace WardName="Ward 106" if WardName=="WARD 106"
replace WardName="Ward 30" if WardName=="WARD 30"
replace WardName="Ward 32" if WardName=="WARD 32"
replace WardName="Ward 52" if WardName=="WARD 52"
replace WardName="Ward 63" if WardName=="WARD 63"
replace WardName="Ward 64" if WardName=="WARD 64"
replace WardName="Ward 71" if WardName=="WARD 71"
replace WardName="Ward 75" if WardName=="WARD 75"
replace WardName="Ward 81" if WardName=="WARD 81"
replace WardName="Ward 82" if WardName=="WARD 82"
replace WardName="Ward 106" if WardName=="WARD-106"
replace WardName="Ward 30" if WardName=="WARD-30"
replace WardName="Ward 32" if WardName=="WARD-32"
replace WardName="Ward 52" if WardName=="WARD-52"
replace WardName="Ward 81" if WardName=="WARD-81"
replace WardName="Ward 0" if WardName=="Ward 0"
replace WardName="Ward 1" if WardName=="Ward 1"
replace WardName="Ward 10" if WardName=="Ward 10"
replace WardName="Ward 100" if WardName=="Ward 100"
replace WardName="Ward 101" if WardName=="Ward 101"
replace WardName="Ward 102" if WardName=="Ward 102"
replace WardName="Ward 103" if WardName=="Ward 103"
replace WardName="Ward 104" if WardName=="Ward 104"
replace WardName="Ward 105" if WardName=="Ward 105"
replace WardName="Ward 106" if WardName=="Ward 106"
replace WardName="Ward 107" if WardName=="Ward 107"
replace WardName="Ward 107" if WardName=="Ward 107 (SPECIAL ZONE)"
replace WardName="Ward 107" if WardName=="Ward 107(Special Zone)"
replace WardName="Ward 108" if WardName=="Ward 108"
replace WardName="Ward 108" if WardName=="Ward 108 (EXIM)"
replace WardName="Ward 108" if WardName=="Ward 108(Exim Cell)"
replace WardName="Ward 108" if WardName=="108(Export Import Cell)"
replace WardName="Ward 11" if WardName=="Ward 11"
replace WardName="Ward 12" if WardName=="Ward 12"
replace WardName="Ward 13" if WardName=="Ward 13"
replace WardName="Ward 14" if WardName=="Ward 14"
replace WardName="Ward 15" if WardName=="Ward 15"
replace WardName="Ward 16" if WardName=="Ward 16"
replace WardName="Ward 17" if WardName=="Ward 17"
replace WardName="Ward 18" if WardName=="Ward 18"
replace WardName="Ward 19" if WardName=="Ward 19"
replace WardName="Ward 2" if WardName=="Ward 2"
replace WardName="Ward 20" if WardName=="Ward 20"
replace WardName="Ward 201" if WardName=="Ward 201"
replace WardName="Ward 202" if WardName=="Ward 202"
replace WardName="Ward 203" if WardName=="Ward 203"
replace WardName="Ward 204" if WardName=="Ward 204"
replace WardName="Ward 205" if WardName=="Ward 205"
replace WardName="Ward 206" if WardName=="Ward 206"
replace WardName="Ward 207" if WardName=="Ward 207"
replace WardName="Ward 208" if WardName=="Ward 208"
replace WardName="Ward 21" if WardName=="Ward 21"
replace WardName="Ward 22" if WardName=="Ward 22"
replace WardName="Ward 23" if WardName=="Ward 23"
replace WardName="Ward 24" if WardName=="Ward 24"
replace WardName="Ward 25" if WardName=="Ward 25"
replace WardName="Ward 26" if WardName=="Ward 26"
replace WardName="Ward 27" if WardName=="Ward 27"
replace WardName="Ward 28" if WardName=="Ward 28"
replace WardName="Ward 29" if WardName=="Ward 29"
replace WardName="Ward 3" if WardName=="Ward 3"
replace WardName="Ward 30" if WardName=="Ward 30"
replace WardName="Ward 31" if WardName=="Ward 31"
replace WardName="Ward 32" if WardName=="Ward 32"
replace WardName="Ward 33" if WardName=="Ward 33"
replace WardName="Ward 34" if WardName=="Ward 34"
replace WardName="Ward 35" if WardName=="Ward 35"
replace WardName="Ward 36" if WardName=="Ward 36"
replace WardName="Ward 37" if WardName=="Ward 37"
replace WardName="Ward 38" if WardName=="Ward 38"
replace WardName="Ward 39" if WardName=="Ward 39"
replace WardName="Ward 4" if WardName=="Ward 4"
replace WardName="Ward 40" if WardName=="Ward 40"
replace WardName="Ward 41" if WardName=="Ward 41"
replace WardName="Ward 42" if WardName=="Ward 42"
replace WardName="Ward 42" if WardName=="Ward 42 (KDU)"
replace WardName="Ward 43" if WardName=="Ward 43"
replace WardName="Ward 44" if WardName=="Ward 44"
replace WardName="Ward 45" if WardName=="Ward 45"
replace WardName="Ward 46" if WardName=="Ward 46"
replace WardName="Ward 47" if WardName=="Ward 47"
replace WardName="Ward 48" if WardName=="Ward 48"
replace WardName="Ward 49" if WardName=="Ward 49"
replace WardName="Ward 5" if WardName=="Ward 5"
replace WardName="Ward 50" if WardName=="Ward 50"
replace WardName="Ward 51" if WardName=="Ward 51"
replace WardName="Ward 52" if WardName=="Ward 52"
replace WardName="Ward 53" if WardName=="Ward 53"
replace WardName="Ward 54" if WardName=="Ward 54"
replace WardName="Ward 55" if WardName=="Ward 55"
replace WardName="Ward 56" if WardName=="Ward 56"
replace WardName="Ward 57" if WardName=="Ward 57"
replace WardName="Ward 58" if WardName=="Ward 58"
replace WardName="Ward 59" if WardName=="Ward 59"
replace WardName="Ward 6" if WardName=="Ward 6"
replace WardName="Ward 60" if WardName=="Ward 60"
replace WardName="Ward 61" if WardName=="Ward 61"
replace WardName="Ward 62" if WardName=="Ward 62"
replace WardName="Ward 63" if WardName=="Ward 63"
replace WardName="Ward 64" if WardName=="Ward 64"
replace WardName="Ward 65" if WardName=="Ward 65"
replace WardName="Ward 66" if WardName=="Ward 66"
replace WardName="Ward 67" if WardName=="Ward 67"
replace WardName="Ward 68" if WardName=="Ward 68"
replace WardName="Ward 69" if WardName=="Ward 69"
replace WardName="Ward 7" if WardName=="Ward 7"
replace WardName="Ward 70" if WardName=="Ward 70"
replace WardName="Ward 71" if WardName=="Ward 71"
replace WardName="Ward 72" if WardName=="Ward 72"
replace WardName="Ward 73" if WardName=="Ward 73"
replace WardName="Ward 74" if WardName=="Ward 74"
replace WardName="Ward 75" if WardName=="Ward 75"
replace WardName="Ward 76" if WardName=="Ward 76"
replace WardName="Ward 77" if WardName=="Ward 77"
replace WardName="Ward 78" if WardName=="Ward 78"
replace WardName="Ward 79" if WardName=="Ward 79"
replace WardName="Ward 8" if WardName=="Ward 8"
replace WardName="Ward 80" if WardName=="Ward 80"
replace WardName="Ward 81" if WardName=="Ward 81"
replace WardName="Ward 82" if WardName=="Ward 82"
replace WardName="Ward 83" if WardName=="Ward 83"
replace WardName="Ward 84" if WardName=="Ward 84"
replace WardName="Ward 85" if WardName=="Ward 85"
replace WardName="Ward 86" if WardName=="Ward 86"
replace WardName="Ward 87" if WardName=="Ward 87"
replace WardName="Ward 88" if WardName=="Ward 88"
replace WardName="Ward 89" if WardName=="Ward 89"
replace WardName="Ward 9" if WardName=="Ward 9"
replace WardName="Ward 90" if WardName=="Ward 90"
replace WardName="Ward 91" if WardName=="Ward 91"
replace WardName="Ward 92" if WardName=="Ward 92"
replace WardName="Ward 93" if WardName=="Ward 93"
replace WardName="Ward 94" if WardName=="Ward 94"
replace WardName="Ward 95" if WardName=="Ward 95"
replace WardName="Ward 96" if WardName=="Ward 96"
replace WardName="Ward 97" if WardName=="Ward 97"
replace WardName="Ward 98" if WardName=="Ward 98"
replace WardName="Ward 99" if WardName=="Ward 99"
replace WardName="Ward 0" if WardName=="Ward0"
replace WardName="Ward 1" if WardName=="Ward1"
replace WardName="Ward 10" if WardName=="Ward10"
replace WardName="Ward 100" if WardName=="Ward100"
replace WardName="Ward 101" if WardName=="Ward101"
replace WardName="Ward 102" if WardName=="Ward102"
replace WardName="Ward 103" if WardName=="Ward103"
replace WardName="Ward 104" if WardName=="Ward104"
replace WardName="Ward 105" if WardName=="Ward105"
replace WardName="Ward 106" if WardName=="Ward106"
replace WardName="Ward 107" if WardName=="Ward107"
replace WardName="Ward 107" if WardName=="Ward107 (SPECIAL ZONE)"
replace WardName="Ward 108" if WardName=="Ward108"
replace WardName="Ward 11" if WardName=="Ward11"
replace WardName="Ward 12" if WardName=="Ward12"
replace WardName="Ward 13" if WardName=="Ward13"
replace WardName="Ward 14" if WardName=="Ward14"
replace WardName="Ward 15" if WardName=="Ward15"
replace WardName="Ward 16" if WardName=="Ward16"
replace WardName="Ward 17" if WardName=="Ward17"
replace WardName="Ward 18" if WardName=="Ward18"
replace WardName="Ward 19" if WardName=="Ward19"
replace WardName="Ward 2" if WardName=="Ward2"
replace WardName="Ward 20" if WardName=="Ward20"
replace WardName="Ward 201" if WardName=="Ward201"
replace WardName="Ward 202" if WardName=="Ward202"
replace WardName="Ward 203" if WardName=="Ward203"
replace WardName="Ward 204" if WardName=="Ward204"
replace WardName="Ward 205" if WardName=="Ward205"
replace WardName="Ward 206" if WardName=="Ward206"
replace WardName="Ward 21" if WardName=="Ward21"
replace WardName="Ward 22" if WardName=="Ward22"
replace WardName="Ward 23" if WardName=="Ward23"
replace WardName="Ward 24" if WardName=="Ward24"
replace WardName="Ward 25" if WardName=="Ward25"
replace WardName="Ward 26" if WardName=="Ward26"
replace WardName="Ward 27" if WardName=="Ward27"
replace WardName="Ward 28" if WardName=="Ward28"
replace WardName="Ward 29" if WardName=="Ward29"
replace WardName="Ward 3" if WardName=="Ward3"
replace WardName="Ward 30" if WardName=="Ward30"
replace WardName="Ward 31" if WardName=="Ward31"
replace WardName="Ward 32" if WardName=="Ward32"
replace WardName="Ward 33" if WardName=="Ward33"
replace WardName="Ward 34" if WardName=="Ward34"
replace WardName="Ward 35" if WardName=="Ward35"
replace WardName="Ward 36" if WardName=="Ward36"
replace WardName="Ward 37" if WardName=="Ward37"
replace WardName="Ward 38" if WardName=="Ward38"
replace WardName="Ward 39" if WardName=="Ward39"
replace WardName="Ward 4" if WardName=="Ward4"
replace WardName="Ward 40" if WardName=="Ward40"
replace WardName="Ward 41" if WardName=="Ward41"
replace WardName="Ward 42" if WardName=="Ward42"
replace WardName="Ward 43" if WardName=="Ward43"
replace WardName="Ward 44" if WardName=="Ward44"
replace WardName="Ward 45" if WardName=="Ward45"
replace WardName="Ward 46" if WardName=="Ward46"
replace WardName="Ward 47" if WardName=="Ward47"
replace WardName="Ward 48" if WardName=="Ward48"
replace WardName="Ward 49" if WardName=="Ward49"
replace WardName="Ward 5" if WardName=="Ward5"
replace WardName="Ward 50" if WardName=="Ward50"
replace WardName="Ward 51" if WardName=="Ward51"
replace WardName="Ward 52" if WardName=="Ward52"
replace WardName="Ward 53" if WardName=="Ward53"
replace WardName="Ward 54" if WardName=="Ward54"
replace WardName="Ward 55" if WardName=="Ward55"
replace WardName="Ward 56" if WardName=="Ward56"
replace WardName="Ward 57" if WardName=="Ward57"
replace WardName="Ward 58" if WardName=="Ward58"
replace WardName="Ward 59" if WardName=="Ward59"
replace WardName="Ward 6" if WardName=="Ward6"
replace WardName="Ward 60" if WardName=="Ward60"
replace WardName="Ward 61" if WardName=="Ward61"
replace WardName="Ward 62" if WardName=="Ward62"
replace WardName="Ward 63" if WardName=="Ward63"
replace WardName="Ward 64" if WardName=="Ward64"
replace WardName="Ward 65" if WardName=="Ward65"
replace WardName="Ward 66" if WardName=="Ward66"
replace WardName="Ward 67" if WardName=="Ward67"
replace WardName="Ward 68" if WardName=="Ward68"
replace WardName="Ward 69" if WardName=="Ward69"
replace WardName="Ward 7" if WardName=="Ward7"
replace WardName="Ward 70" if WardName=="Ward70"
replace WardName="Ward 71" if WardName=="Ward71"
replace WardName="Ward 72" if WardName=="Ward72"
replace WardName="Ward 73" if WardName=="Ward73"
replace WardName="Ward 74" if WardName=="Ward74"
replace WardName="Ward 75" if WardName=="Ward75"
replace WardName="Ward 76" if WardName=="Ward76"
replace WardName="Ward 77" if WardName=="Ward77"
replace WardName="Ward 78" if WardName=="Ward78"
replace WardName="Ward 79" if WardName=="Ward79"
replace WardName="Ward 8" if WardName=="Ward8"
replace WardName="Ward 80" if WardName=="Ward80"
replace WardName="Ward 81" if WardName=="Ward81"
replace WardName="Ward 82" if WardName=="Ward82"
replace WardName="Ward 83" if WardName=="Ward83"
replace WardName="Ward 84" if WardName=="Ward84"
replace WardName="Ward 85" if WardName=="Ward85"
replace WardName="Ward 86" if WardName=="Ward86"
replace WardName="Ward 87" if WardName=="Ward87"
replace WardName="Ward 88" if WardName=="Ward88"
replace WardName="Ward 89" if WardName=="Ward89"
replace WardName="Ward 9" if WardName=="Ward9"
replace WardName="Ward 90" if WardName=="Ward90"
replace WardName="Ward 91" if WardName=="Ward91"
replace WardName="Ward 92" if WardName=="Ward92"
replace WardName="Ward 93" if WardName=="Ward93"
replace WardName="Ward 94" if WardName=="Ward94"
replace WardName="Ward 95" if WardName=="Ward95"
replace WardName="Ward 96" if WardName=="Ward96"
replace WardName="Ward 97" if WardName=="Ward97"
replace WardName="Ward 98" if WardName=="Ward98"
replace WardName="Ward 99" if WardName=="Ward99"
replace WardName="Ward 102" if WardName=="Word 102"
replace WardName="Ward 30" if WardName=="Word 30"
replace WardName="Ward 88" if WardName=="Word 88"
replace WardName="Ward 100" if WardName=="ward 100"
replace WardName="Ward 101" if WardName=="ward 101"
replace WardName="Ward 102" if WardName=="ward 102"
replace WardName="Ward 103" if WardName=="ward 103"
replace WardName="Ward 104" if WardName=="ward 104"
replace WardName="Ward 106" if WardName=="ward 106"
replace WardName="Ward 15" if WardName=="ward 15"
replace WardName="Ward 17" if WardName=="ward 17"
replace WardName="Ward 20" if WardName=="ward 20"
replace WardName="Ward 23" if WardName=="ward 23"
replace WardName="Ward 24" if WardName=="ward 24"
replace WardName="Ward 26" if WardName=="ward 26"
replace WardName="Ward 31" if WardName=="ward 31"
replace WardName="Ward 32" if WardName=="ward 32"
replace WardName="Ward 4" if WardName=="ward 4"
replace WardName="Ward 5" if WardName=="ward 5"
replace WardName="Ward 52" if WardName=="ward 52"
replace WardName="Ward 53" if WardName=="ward 53"
replace WardName="Ward 54" if WardName=="ward 54"
replace WardName="Ward 55" if WardName=="ward 55"
replace WardName="Ward 56" if WardName=="ward 56"
replace WardName="Ward 57" if WardName=="ward 57"
replace WardName="Ward 58" if WardName=="ward 58"
replace WardName="Ward 6" if WardName=="ward 6"
replace WardName="Ward 60" if WardName=="ward 60"
replace WardName="Ward 61" if WardName=="ward 61"
replace WardName="Ward 62" if WardName=="ward 62"
replace WardName="Ward 63" if WardName=="ward 63"
replace WardName="Ward 64" if WardName=="ward 64"
replace WardName="Ward 67" if WardName=="ward 67"
replace WardName="Ward 68" if WardName=="ward 68"
replace WardName="Ward 71" if WardName=="ward 71"
replace WardName="Ward 73" if WardName=="ward 73"
replace WardName="Ward 78" if WardName=="ward 78"
replace WardName="Ward 79" if WardName=="ward 79"
replace WardName="Ward 83" if WardName=="ward 83"
replace WardName="Ward 84" if WardName=="ward 84"
replace WardName="Ward 86" if WardName=="ward 86"
replace WardName="Ward 88" if WardName=="ward 88"
replace WardName="Ward 89" if WardName=="ward 89"
replace WardName="Ward 90" if WardName=="ward 90"
replace WardName="Ward 91" if WardName=="ward 91"
replace WardName="Ward 93" if WardName=="ward 93"
replace WardName="Ward 94" if WardName=="ward 94"
replace WardName="Ward 97" if WardName=="ward 97"
replace WardName="Ward 99" if WardName=="ward 99"
replace WardName="Ward 30" if WardName=="WARD 30"
replace WardName="Ward 32" if WardName=="WARD 32"
replace WardName="Ward 52" if WardName=="WARD 52"
replace WardName="Ward 63" if WardName=="WARD 63"
replace WardName="Ward 64" if WardName=="WARD 64"
replace WardName="Ward 71" if WardName=="WARD 71"
replace WardName="Ward 75" if WardName=="WARD 75"
replace WardName="Ward 81" if WardName=="WARD 81"
replace WardName="Ward 82" if WardName=="WARD 82"
replace WardName="Ward 106" if WardName=="WARD-106"
replace WardName="Ward 30" if WardName=="WARD-30"
replace WardName="Ward 32" if WardName=="WARD-32"
replace WardName="Ward 52" if WardName=="WARD-52"
replace WardName="Ward 81" if WardName=="WARD-81"
replace WardName="Ward 108" if WardName=="Ward 108(Export Import Cell)"

replace WardName="" if WardName=="Sparkle infoways"
replace WardName="" if WardName=="Select"
replace WardName="" if WardName=="Super User Office"
replace WardName="" if WardName=="Ward 0"

replace WardName="Ward 31" if WardName=="313102"
replace WardName="Ward 57" if WardName=="315202"
replace WardName="Ward 61" if WardName=="315502"
replace WardName="Ward 63" if WardName=="316101"
replace WardName="Ward 65" if WardName=="316202"
replace WardName="Ward 83" if WardName=="317403"
replace WardName="Ward 84" if WardName=="317501"
replace WardName="Ward 93" if WardName=="318202"
replace WardName="Ward 96" if WardName=="319101"
replace WardName="Ward 45" if WardName=="Ward"


gsort DealerTIN -WardName
gen dum=WardName
br DealerTIN WardName dum
by DealerTIN: replace dum=dum[_n-1] if dum==""

replace WardName=dum
drop dum


//Creating other variables of interest
egen PurchaseNoCredit=rowtotal(PurchaseUnregisteredDealer DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood)
gen PercValueAdded=(TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen TotalValueAdded=(TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)
gen PercPurchaseUnregisteredDealer=PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen PercPurchaseNoCredit=PurchaseNoCredit/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)
gen TotalPurchases=PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit

label variable PurchaseNoCredit "R6.3 Total local purchases that are no eligible for credit of input tax"
label variable PercValueAdded "A measure of fraction of value added, definition is (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseUnregisteredDealer "A measure of amount purchased from unregistered dealers:PurchaseUnregisteredDealer/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)"
label variable PercPurchaseNoCredit "Percentage of total purchases that are not eligible for credit of input tax PurchaseNoCredit/(PurchaseCapitalGoods+PurchaseOtherGoods+PurchaseNoCredit)" 
label variable TotalValueAdded "Total value added, (TurnoverGross-PurchaseCapitalGoods-PurchaseOtherGoods-PurchaseNoCredit)"

merge 1:1 DealerTIN using "F:\sold_to_2013_q1_sale_unregistered_dealers.dta", keepusing(TurnoverUnregistered OutputTaxUnregistered TotalUnregistered) generate(_merge_unregistered)
drop if _merge_unregistered==2
replace TurnoverUnregistered=0 if TurnoverUnregistered==.
replace OutputTaxUnregistered=0 if OutputTaxUnregistered==.
replace TotalUnregistered=0 if TotalUnregistered==.
gen PercTurnoverUnregisteredLocal= TurnoverUnregistered/TurnoverLocal
gen PercTurnoverUnregisteredGross= TurnoverUnregistered/TurnoverGross

label variable TurnoverUnregistered "Local sale made to unregistered dealers in 2A-2B"
label variable OutputTaxUnregistered "Output tax collected from unregistered dealers, collected from 2A-2B"
label variable TotalUnregistered "Total sales and tax collected from unregistered dealer, created from 2A-2B"
label variable PercTurnoverUnregisteredLocal "TurnoverUnregistered/TurnoverLocal"
label variable PercTurnoverUnregisteredGross "TurnoverUnregistered/TurnoverGross"


save "F:\java_results_quarter\SOLD_TO_2013_Q1\returns_2013_q1.dta", replace


//We first import the gephi file.
//Then we merge it with bogus dealertins
//Then we merge it with appropriate returns of the quarter
//Then we merge it with network information created by Anant

import delimited "H:\java_results_quarter\SOLD_TO_2013_Q1\2013_q1_soldto [Nodes].csv", delimiter(";") clear
rename label DealerTIN
rename indegree indegree_gephi
rename outdegree outdegree_gephi

tostring DealerTIN, replace



//Who are the dealers who do have returns but do not find entry in 2A-2B?
// 1. Firms who do not have local stuff
//

//Who are the dealers who do not have returns but have entry in 2A-2B?
//Need to investigate

merge 1:1 DealerTIN using "H:\java_results_quarter\SOLD_TO_2013_Q1\returns_2013_q1.dta", generate(_merge_returns)
/*
(note: variable DealerTIN was str6, now str11 to accommodate using	data's
values)

Result                           # of obs.
-----------------------------------------
not matched                        66,306
from master                    10,459  (_merge_returns==1)
from using                     55,847  (_merge_returns==2)

matched                           184,142  (_merge_returns==3)
-----------------------------------------
*/

merge 1:1 DealerTIN using "H:\bogus_identified.dta", keepusing(Bogus) generate(_merge_bogus)

/*

	   tab _merge_bogus _merge_returns, missing

                      |               _merge_returns
         _merge_bogus | master on  using onl  matched (          . |     Total
----------------------+--------------------------------------------+----------
      master only (1) |    10,369     55,846    183,678          0 |   249,893 
       using only (2) |         0          0          0         73 |        73 
          matched (3) |        20         81        380          0 |       481 
----------------------+--------------------------------------------+----------
                Total |    10,389     55,927    184,058         73 |   250,447 


*/
drop if _merge_bogus==2
gen BogusDummy=0
replace BogusDummy=1 if Bogus=="YES"

label variable BogusDummy "0 - Dealer may or may not be Bogus, 1 - Identified Bogus Dealer"



merge 1:1 DealerTIN using "H:\java_results_quarter\SOLD_TO_2013_Q1\network_numbers_2013_q1.dta", generate(_merge_selfloop)
/*
.	merge 1:1 DealerTIN using "F:\java_results_quarter\SOLD_TO_2013_Q1\network
>	_numbers_2013_q1.dta", generate(_merge_selfloop)

	Result                           # of obs.
	-----------------------------------------
	not matched                        55,954
	from master                    55,954  (_merge_selfloop==1)
	from using                          0  (_merge_selfloop==2)

	matched                           194,494  (_merge_selfloop==3)
	-----------------------------------------

tab	_merge_selfloop _merge_returns

	_merge_returns
	_merge_selfloop  master on  using onl  matched (	Total
		
	master only (1)         73     55,800         81	55,954 
	matched (3)     10,386         47    184,061	194,494 
		
	Total     10,459     55,847    184,142	250,448 
	
*/


//Generating logs
gen lTurnoverGross=log(TurnoverGross)
gen lAmountDepositedByDealer=log(AmountDepositedByDealer)
gen lindegree=log(indegree_gephi)
gen loutdegree=log(outdegree_gephi)

merge 1:1 DealerTIN using "H:\sold_to_2013_q1_all_numbernodes.dta", keepusing(NumberNodes NetworkSize) generate(_merge_networksize)

tab network_number, sort


twoway (scatter lAmountDeposited indegree_gephi if _merge_returns==3), ytitle("Log of Amount Deposited by Dealer") xtitle("Indegree of Sold To relationship") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_indegree.gph", replace
twoway (scatter lTurnoverGross indegree_gephi if _merge_returns==3), ytitle("Log of Gross Turnover") xtitle("Indegree of Sold To relationship") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_indegree.gph", replace
graph combine F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_indegree.gph  F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_indegree.gph, col(2) title("Year 2013-14, Quarter 1")
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_vs_indegree.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_indegree.png", as(png) replace


twoway (scatter lAmountDeposited outdegree_gephi if _merge_returns==3), ytitle("Log of Amount Deposited by Dealer") xtitle("Outdegree of Sold To relationship") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_outdegree.gph", replace
twoway (scatter lTurnoverGross outdegree_gephi if _merge_returns==3), ytitle("Log of Gross Turnover") xtitle("Outdegree of Sold To relationship") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_outdegree.gph", replace
graph combine F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_outdegree.gph  F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_outdegree.gph, col(2) title("Year 2013-14, Quarter 1")
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_vs_outdegree.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_outdegree.png", as(png) replace


twoway (scatter lAmountDeposited betweenness if _merge_returns==3&betweenness<200000000), ytitle("Log of Amount Deposited by Dealer") xtitle("Betweenness Centrality of Sold To relationship") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_betweenness.gph", replace
twoway (scatter lTurnoverGross betweenness if _merge_returns==3&betweenness<200000000), ytitle("Log of Gross Turnover") xtitle("Betweenness Centrality Sold To relationship") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_betweenness.gph", replace
graph combine F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_betweenness.gph  F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_betweenness.gph, col(2) title("Year 2013-14, Quarter 1") note("Removed outliers (>2*10^8)")
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_betweenness.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_betweenness.png", as(png) replace

twoway (scatter lAmountDeposited clustering if _merge_returns==3), ytitle("Log of Amount Deposited by Dealer") xtitle("Clustering coefficient") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_clustering.gph", replace
twoway (scatter lTurnoverGross clustering if _merge_returns==3), ytitle("Log of Gross Turnover") xtitle("Clustering coefficient") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_clustering.gph", replace
graph combine F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_clustering.gph  F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_clustering.gph, col(2) title("Clustering Coefficient - Year 2013-14, Quarter 1")
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_clustering.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_clustering.png", as(png) replace


twoway (scatter lAmountDeposited eigenvector if _merge_returns==3), ytitle("Log of Amount Deposited by Dealer") xtitle("Eigenvector Centrality") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_eigen.gph", replace
twoway (scatter lTurnoverGross eigenvector if _merge_returns==3), ytitle("Log of Gross Turnover") xtitle("Eigenvector Centrality") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_eigen.gph", replace
graph combine F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_eigen.gph  F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_eigen.gph, col(2) title("Eigenvector Centrality - Year 2013-14, Quarter 1")
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_eigen.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_eigen.png", as(png) replace



twoway (scatter lAmountDeposited closenes if _merge_returns==3), by(BogusDummy) ytitle("Log of Amount Deposited by Dealer") xtitle("Closeness Centrality") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_closeness.gph", replace
twoway (scatter lTurnoverGross closeness if _merge_returns==3), by(BogusDummy) ytitle("Log of Gross Turnover") xtitle("Closeness Centrality") 
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_closeness.gph", replace
graph combine F:\java_results_quarter\SOLD_TO_2013_Q1\amount_deposited_vs_closeness.gph  F:\java_results_quarter\SOLD_TO_2013_Q1\grossturnover_vs_closeness.gph, row(2) title("Closeness Centrality - Year 2013-14, Quarter 1")
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_closeness.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\amount_turnover_vs_closeness.png", as(png) replace



log using "F:\summary_logs_gem_presentation on 01192016.smcl", append
/* Summary statistics for one quarter - 2013 Q1, for GEM Presentaion on January 20, 2016*/
tab Size BogusDummy, missing
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Micro", detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Small", detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Medium", detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Large", detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Zero", detail

sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Micro"&BogusDummy==1, detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Small"&BogusDummy==1, detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Medium"&BogusDummy==1, detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Large"&BogusDummy==1, detail
sum indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Size=="Zero"&BogusDummy==1, detail


sum TurnoverGross AmountDepositedByDealer if Size=="Micro"&BogusDummy==1, detail
sum TurnoverGross AmountDepositedByDealer if Size=="Small"&BogusDummy==1, detail
sum TurnoverGross AmountDepositedByDealer if Size=="Medium"&BogusDummy==1, detail
sum TurnoverGross AmountDepositedByDealer if Size=="Large"&BogusDummy==1, detail
log close

outreg2 using x.doc if Size=="Micro", replace sum(detail) keep(TurnoverGross) eqkeep(N mean p50 sd)

set more off
bysort BogusDummy: outreg2 using summary_stats_micro.xls if Size=="Micro"&_merge_returns==3, replace sum(detail) eqkeep(N mean sd p10 p25 p50 p75 p90 min max ) keep(indegree_gephi outdegree_gephi eccentricity closenesscentrality betweennesscentrality clusteringcoefficient eigenvectorcentrality TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable AmountDepositedByDealer BalancePayable AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase MoneyDeposited PurchaseNoCredit PercValueAdded PercPurchaseUnregisteredDealer TurnoverUnregistered OutputTaxUnregistered TotalUnregistered TotalValueAdded TotalPurchases PercTurnoverUnregisteredLocal PercTurnoverUnregisteredGross lTurnoverGross lAmountDepositedByDealer lindegree loutdegree NumberNodes ZeroTurnover ZeroAmountDeposited) title("Micro Sized firms")
bysort BogusDummy: outreg2 using summary_stats_small.xls if Size=="Small"&_merge_returns==3, replace sum(detail) eqkeep(N mean sd p10 p25 p50 p75 p90min max) keep(indegree_gephi outdegree_gephi eccentricity closenesscentrality betweennesscentrality clusteringcoefficient eigenvectorcentrality TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable AmountDepositedByDealer BalancePayable AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase MoneyDeposited PurchaseNoCredit PercValueAdded PercPurchaseUnregisteredDealer TurnoverUnregistered OutputTaxUnregistered TotalUnregistered TotalValueAdded TotalPurchases PercTurnoverUnregisteredLocal PercTurnoverUnregisteredGross lTurnoverGross lAmountDepositedByDealer lindegree loutdegree NumberNodes ZeroTurnover ZeroAmountDeposited) title("Small Sized firms")
bysort BogusDummy: outreg2 using summary_stats_medium.xls if Size=="Medium"&_merge_returns==3, replace sum(detail) eqkeep(N mean sd p10 p25 p50 p75 p90 min max) keep(indegree_gephi outdegree_gephi eccentricity closenesscentrality betweennesscentrality clusteringcoefficient eigenvectorcentrality TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable AmountDepositedByDealer BalancePayable AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase MoneyDeposited PurchaseNoCredit PercValueAdded PercPurchaseUnregisteredDealer TurnoverUnregistered OutputTaxUnregistered TotalUnregistered TotalValueAdded TotalPurchases PercTurnoverUnregisteredLocal PercTurnoverUnregisteredGross lTurnoverGross lAmountDepositedByDealer lindegree loutdegree NumberNodes ZeroTurnover ZeroAmountDeposited) title("Medium Sized firms")
bysort BogusDummy: outreg2 using summary_stats_large.xls if Size=="Large"&_merge_returns==3, replace sum(detail) eqkeep(N mean sd p10 p25 p50 p75 p90 min max) keep(indegree_gephi outdegree_gephi eccentricity closenesscentrality betweennesscentrality clusteringcoefficient eigenvectorcentrality TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable AmountDepositedByDealer BalancePayable AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase MoneyDeposited PurchaseNoCredit PercValueAdded PercPurchaseUnregisteredDealer TurnoverUnregistered OutputTaxUnregistered TotalUnregistered TotalValueAdded TotalPurchases PercTurnoverUnregisteredLocal PercTurnoverUnregisteredGross lTurnoverGross lAmountDepositedByDealer lindegree loutdegree NumberNodes ZeroTurnover ZeroAmountDeposited) title("Large Sized firms")

set more off
bysort BogusDummy: outreg2 using summary_stats_smallnetwork.xls if NetworkSize=="Small Network"&_merge_returns==3, replace sum(detail) eqkeep(N mean sd p10 p25 p50 p75 p90 min max ) keep(indegree_gephi outdegree_gephi eccentricity closenesscentrality betweennesscentrality clusteringcoefficient eigenvectorcentrality TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable AmountDepositedByDealer BalancePayable AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase MoneyDeposited PurchaseNoCredit PercValueAdded PercPurchaseUnregisteredDealer TurnoverUnregistered OutputTaxUnregistered TotalUnregistered TotalValueAdded TotalPurchases PercTurnoverUnregisteredLocal PercTurnoverUnregisteredGross lTurnoverGross lAmountDepositedByDealer lindegree loutdegree NumberNodes ZeroTurnover ZeroAmountDeposited) title("Small Sized networks")
bysort BogusDummy: outreg2 using summary_stats_largenetwork.xls if NetworkSize=="Large Network"&_merge_returns==3, replace sum(detail) eqkeep(N mean sd p10 p25 p50 p75 p90 min max ) keep(indegree_gephi outdegree_gephi eccentricity closenesscentrality betweennesscentrality clusteringcoefficient eigenvectorcentrality TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods PurchaseGoodsAt1 CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable AmountDepositedByDealer BalancePayable AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability RefundClaimed BalanceCarriedNextTaxPeriod InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase DieselSale DieselPurchase PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods LaborCharges LandCharges SaleDelhiFormH WCLabourPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT OutwardStockTransferBranchF InwardStockTransferBranchF OutwardStockTransferConsignmentF InwardStockTransferConsignmentF OwnGoodsTransferredAfterJobF OwnGoodsReceivedAfterJobF OtherDealersGoodsTrJobF OtherDealersGoodsReJobF SaleExemptedGoodsSchedule PurchaseExemptedGoodsSchedule SaleExemptedGoodsCST PurchaseExemptedGoodsCST HighSeaSale HighSeaPurchase MoneyDeposited PurchaseNoCredit PercValueAdded PercPurchaseUnregisteredDealer TurnoverUnregistered OutputTaxUnregistered TotalUnregistered TotalValueAdded TotalPurchases PercTurnoverUnregisteredLocal PercTurnoverUnregisteredGross lTurnoverGross lAmountDepositedByDealer lindegree loutdegree NumberNodes ZeroTurnover ZeroAmountDeposited) title("Large Sized networks")


 tab Size NetworkSize if _merge_returns==3&BogusDummy==1
/*
           |      NetworkSize
      Size | Large N..  Small N.. |     Total
-----------+----------------------+----------
     Large |        67         63 |       130 
    Medium |        53         89 |       142 
     Micro |        21          4 |        25 
     Small |        13         15 |        28 
      Zero |         5          0 |         5 
-----------+----------------------+----------
     Total |       159        171 |       330 

*/

. tab Size NetworkSize if _merge_returns==3&BogusDummy==0
/*
           |      NetworkSize
      Size | Large N..  Small N.. |     Total
-----------+----------------------+----------
     Large |     5,188        892 |     6,080 
    Medium |    25,972      4,105 |    30,077 
     Micro |    71,568     12,459 |    84,027 
     Small |    50,234      6,291 |    56,525 
      Zero |     6,628        435 |     7,063 
-----------+----------------------+----------
     Total |   159,590     24,182 |   183,772 

*/
graph bar (count), over(Size) over(NetworkSize) over(BogusDummy) percent
graph save Graph "H:\All_vs_bogus_size_sold_to_2013q1.gph"
graph export "H:\All_vs_bogus_size_sold_to_2013q1.pdf", as(pdf) replace

graph bar (count), over(NetworkSize) over(Selection)
graph save Graph "F:\bimodal_distribution_bogus_count_v2.gph"

graph bar, over(NetworkSize) by(BogusDummy)
graph save Graph "H:\All_vs_bogus_NetworkSize_sold_to_2013q1.gph"
graph export "H:\All_vs_bogus_NetworkSize_sold_to_2013q1.pdf", as(pdf) replace


graph bar, over(NetworkSize) by(BogusDummy)


sum TurnoverGross TotalOutputTax AdjustmentTaxCredit if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0, detail
br TurnoverGross AmountDepositedByDealer AdjustmentTaxCredit TotalOutputTax TotalTaxCredit if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0
br TurnoverGross AmountDepositedByDealer AdjustmentTaxCredit TotalOutputTax TotalTaxCredit CarryForwardTaxCredit if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0
br DealerTIN indegree outdegree TurnoverGross AmountDepositedByDealer AdjustmentTaxCredit TotalOutputTax TotalTaxCredit CarryForwardTaxCredit if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0
br DealerTIN indegree outdegree TurnoverGross TurnoverLocal  AmountDepositedByDealer AdjustmentTaxCredit TotalOutputTax TotalTaxCredit CarryForwardTaxCredit if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0
sum TaxCreditBeforeAdjustment if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0
sum TaxCreditBeforeAdjustment TotalOutputTax  if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0
sum TaxCreditBeforeAdjustment TotalOutputTax  if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0&TaxCreditBeforeAdjustment>0
sum TaxCreditBeforeAdjustment TotalOutputTax outdegree  if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0&TaxCreditBeforeAdjustment>0
br DealerTIN TaxCreditBeforeAdjustment TotalOutputTax outdegree  if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0&TaxCreditBeforeAdjustment>0


br DealerTIN TaxCreditBeforeAdjustment TotalOutputTax outdegree  if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0&TaxCreditBeforeAdjustment>0
br if TotalOutputTax<0
br OutputTaxBeforeAdjustment if TotalOutputTax<0

log using "H:/chain_beginners_govt_presentation_02092016.log", replace
sum TotalValueAdded TurnoverGross OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment TotalOutputTax outdegree  if indegree==0&outdegree>0&_merge_returns==3&AmountDepositedByDealer==0&TaxCreditBeforeAdjustment>0, detail
sum TotalValueAdded TurnoverGross OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment TotalOutputTax outdegree AmountDepositedByDealer if indegree==0&outdegree>0&_merge_returns==3, detail
log close

. br DealerTIN TaxPeriod TurnoverGross AmountDepositedByDealer NetTax TaxCreditBe
> foreAdjustment if TaxPeriod=="First Quarter-2013"&(DealerTIN=="403957"|DealerTI
> N=="117457"|DealerTIN=="79750"|DealerTIN=="501048")





