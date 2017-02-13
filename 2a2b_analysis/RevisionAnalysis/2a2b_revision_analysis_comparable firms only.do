//We are worried that monthly firms are different from quarterly firms. 
//As a result, it seems better to do revision analysis of these firms separately

cd "E:\data"
use "PreliminaryAnalysis\returns\form16_data_v4_01122017.dta", clear
//use "E:\data\PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear
keep if TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2013"|TaxPeriod=="Fourth Quarter-2014"
gsort DealerTIN TaxPeriod
by DealerTIN: gen Count=_n
keep if Count==1
keep DealerTIN
save "E:\data\MediumTurnoverDealers.dta", replace


cd "E:\data"
use "form16_data_v3_0901.dta", clear

merge m:1 DealerTIN using "E:\data\MediumTurnoverDealers.dta"
keep if _merge==3


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


/*merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if _merge_bogus2==3
*/

destring id, replace 


gsort DealerTIN TaxPeriod -id
by DealerTIN TaxPeriod: gen RevisionCount=_n
by DealerTIN TaxPeriod: gen TotalRevisionCount=_N

keep if RevisionCount==1

order ApprovalDate, first

replace TotalRevisionCount=TotalRevisionCount-1
//sum TotalRevisionCount if TaxQuarter==17&SecondBogusDummy==0, detail

collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(DealerTIN TaxQuarter)
save "H:\2a2b_analysis\RevisionAnalysis\quarterly_revisions.dta", replace


//Now focussing on monthly firms
cd "E:\data"
use "form16_data_v3_0901.dta", clear

drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
drop if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"
drop if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"
drop if TaxPeriod=="Apr-2013"|TaxPeriod=="May-2013"

gsort DealerTIN TaxPeriod
by DealerTIN: gen Count=_n
keep if Count==1
keep DealerTIN

save "E:\data\HighTurnoverDealers2010_all.dta", replace

cd "E:\data"
use "form16_data_v3_0901.dta", clear

merge m:1 DealerTIN using "E:\data\HighTurnoverDealers2010_all.dta"
keep if _merge==3


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


drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
drop if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"
drop if TaxQuarter==13&TaxMonth!=0
drop if (TaxQuarter==1|TaxQuarter==2|TaxQuarter==3|TaxQuarter==4|TaxQuarter==5|TaxQuarter==6|TaxQuarter==7|TaxQuarter==8|TaxQuarter==9|TaxQuarter==10|TaxQuarter==11|TaxQuarter==12)&TaxMonth==0

gsort DealerTIN TaxPeriod id
by DealerTIN TaxPeriod: gen RevisionCount=_n
by DealerTIN TaxPeriod: gen TotalRevisionCount=_N

keep if RevisionCount==1

bys DealerTIN TaxQuarter:egen meanTotalRevisionCount=mean(TotalRevisionCount) 

by DealerTIN TaxQuarter: gen MonthRevisionCount=_n
keep if MonthRevisionCount==1

collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(DealerTIN TaxQuarter)

replace TotalRevisionCount=TotalRevisionCount-1


append using "E:\data\PreliminaryAnalysis\BogusDealers\quarterly_revisions.dta"


merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\BogusIdentifiedFromOnlineGovernment.dta", generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if Bogus=="YES"

merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\Bogus_CancellationData_NotPresentInT20.dta", generate(_merge_bogus)
gen BogusDummy=0
replace BogusDummy=1 if _merge_bogus==3

preserve
collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxQuarter SecondBogusDummy)	
twoway (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==0) (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==1), xline(9) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions Mean")
restore


preserve
collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxQuarter BogusDummy)	
twoway (connected TotalRevisionCount TaxQuarter if BogusDummy==0) (connected TotalRevisionCount TaxQuarter if BogusDummy==1), xline(9) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions Mean")
restore



merge m:1 DealerTIN using "D:\data\DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature Constitution RegistrationType RegistrationDate SubmissionDate Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 BooleanThirdPartyStorage BooleanSurveyFilled GTONil201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)
keep if _merge==1|_merge==3


gen Government=.
replace Government=1 if Constitution=="Government Company"
replace Government=1 if Constitution=="Government Corporation"
replace Government=1 if Constitution=="Government Department"
replace Government=1 if Constitution=="Public Sector UnderTaking"


replace Government=0 if Constitution=="HUF"
replace Government=0 if Constitution=="Partnership"
replace Government=0 if Constitution=="Private Ltd. Company"
replace Government=0 if Constitution=="Proprietorship"

replace Government=2 if Constitution=="Public Ltd. Company"


collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxQuarter Government)	
twoway (connected TotalRevisionCount TaxQuarter if Government==0) (connected TotalRevisionCount TaxQuarter if Government==1) (connected TotalRevisionCount TaxQuarter if Government==2) , xline(9) title("Total Revisions (Mean)") note("Limiting to firms with monthly and quarterly returns") legend(order (1 "Private firms" 2 "Government firms" 3 "Public limited firms"))
graph export "H:\2a2b_analysis\RevisionAnalysis\TotalRevisions_byfirms.pdf", as(pdf) replace



merge m:1 DealerTIN using "H:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if _merge_bogus2==3

collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxQuarter Government SecondBogusDummy)	

twoway (connected TotalRevisionCount TaxQuarter if Government==0) (connected TotalRevisionCount TaxQuarter if Government==1) (connected TotalRevisionCount TaxQuarter if Government==2) if SecondBogusDummy==0, xline(9) title("Total Revisions (Mean)") note("Limiting to firms with monthly and quarterly returns") legend(order (1 "Private firms" 2 "Government firms" 3 "Public limited firms"))



collapse (max)max_TotalRevisionCount=TotalRevisionCount (min)min_TotalRevisionCount=TotalRevisionCount (median) median_TotalRevisionCount=TotalRevisionCount (sd) sd_TotalRevisionCount=TotalRevisionCount (mean) TotalRevisionCount, by(TaxQuarter)	

//twoway (connected TotalRevisionCount TaxQuarter) (connected max_TotalRevisionCount TaxQuarter, yaxis(2)) (connected min_TotalRevisionCount TaxQuarter), xline(9) legend(on order(1 "Mean" 2 "Max" 3 "Min")) title("Total Revisions (Mean)") note("Limiting to firms with monthly and quarterly returns")

twoway (connected TotalRevisionCount TaxQuarter) , xline(9) title("Total Revisions (Mean)") note("Limiting to firms with monthly and quarterly returns")
graph export "H:\2a2b_analysis\RevisionAnalysis\TotalRevisions_1009.pdf", as(pdf) replace


twoway (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==0) (connected TotalRevisionCount TaxQuarter if SecondBogusDummy==1), xline(9) legend(on order(1 "Non Bogus Firms" 2 "Bogus Firms")) title("Total Revisions (Mean)") note("Limiting to firms with monthly and quarterly returns")
graph export "H:\2a2b_analysis\RevisionAnalysis\TotalRevisions_1008.pdf", as(pdf) replace
