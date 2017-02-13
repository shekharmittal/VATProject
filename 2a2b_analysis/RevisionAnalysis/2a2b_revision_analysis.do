cd "E:\data"
use "form16_data_v3_0901.dta", clear


keep if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"


drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
drop if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"
drop if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"



drop Tin T312203 T312202 Frequency T312020 T312021 DealerName DealerAddress DealerTelephone T312028 T312029 T312043 T312044 T312051 T312052 T312057 T312082 T312083 AccountNumber AccountType MICR BankDetails T312092 T312093 T312137 T312138 T312139 T312140 T312141 T312142 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167
drop T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 Name Designation Place Date TDSString Receipt2A2B T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 T312178 Signatory


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

gen TaxYear=0
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

merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if _merge_bogus2==3


gsort DealerTIN TaxPeriod id
by DealerTIN TaxPeriod: gen RevisionCount=_n
by DealerTIN TaxPeriod: gen TotalRevisionCount=_N

keep if RevisionCount==1

collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxQuarter SecondBogusDummy)

twoway (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==0) (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==1), xline(9) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions Mean")
graph save "H:\2a2b_analysis\graphs\mean_TotalRevisions.gph"
twoway  (connected sd_TotalRevisionCount TaxQuarter if SecondBogusDummy==0, yaxis(2)) (connected sd_TotalRevisionCount TaxQuarter if SecondBogusDummy==1, yaxis(2)) , xline(9) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions SD")
graph save "H:\2a2b_analysis\graphs\sd_TotalRevisions.gph"
graph combine "H:\2a2b_analysis\graphs\mean_TotalRevisions.gph" "H:\2a2b_analysis\graphs\sd_TotalRevisions.gph", xcommon cols(1) title("Number of Revisions, quarterly returns") note(2A-2B introduced in Quarter 9) xsize(10) ysize(20)
graph export "H:\2a2b_analysis\graphs\TotalRevisions.pdf", as(pdf) replace


twoway (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==1) (connected max_TotalRevisionCount TaxQuarter if SecondBogusDummy==1,yaxis(2)), xline(9)


twoway  (connected sd_TotalRevisionCount TaxQuarter if SecondBogusDummy==0, yaxis(2)) (connected sd_TotalRevisionCount TaxQuarter if SecondBogusDummy==1, yaxis(2)) , xline(9) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms"))



collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxMonth SecondBogusDummy)

twoway (connected TotalRevisionCount TaxMonth if SecondBogusDummy==0) (connected TotalRevisionCount TaxMonth if SecondBogusDummy==1), xline(25) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions Mean")
graph save "H:\2a2b_analysis\graphs\mean_TotalRevisions.gph", replace
twoway  (connected sd_TotalRevisionCount TaxMonth if SecondBogusDummy==0, yaxis(2)) (connected sd_TotalRevisionCount TaxMonth if SecondBogusDummy==1, yaxis(2)) , xline(25) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions SD")
graph save "H:\2a2b_analysis\graphs\sd_TotalRevisions.gph", replace
graph combine "H:\2a2b_analysis\graphs\mean_TotalRevisions.gph" "H:\2a2b_analysis\graphs\sd_TotalRevisions.gph", xcommon cols(1) title("Number of Revisions, monthly returns") note(2A-2B introduced in Month 25) 
graph export "H:\2a2b_analysis\graphs\TotalRevisions_monthly.pdf", as(pdf) replace
