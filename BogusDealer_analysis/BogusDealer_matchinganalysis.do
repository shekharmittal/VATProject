use "F:\2a2b_analysis\MatchAnalysis\purchases_2a2b_matchdata_2012.dta", clear
append using "F:\2a2b_analysis\MatchAnalysis\purchases_2a2b_matchdata_all.dta"
keep if RunningCount==1
drop _merge_bogus2 SecondBogusDummy

merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\BogusIdentifiedFromOnlineGovernment.dta", generate(_merge_bogus2)
drop if _merge_bogus==2
gen BogusDummy=0
replace BogusDummy=1 if Bogus=="YES"



merge m:1 DealerTIN using "F:\Bogus_CancellationData.dta", keepusing(Reasons CancellationDate) generate(_merge_bogus2)
drop if _merge_bogus2==2
gen SecondBogusDummy=0
replace SecondBogusDummy=1 if _merge_bogus2==3


tab BogusDummy
collapse AvgMatch (median) MidAvgMatch=AvgMatch, by(TaxQuarter SecondBogusDummy)
twoway (connected AvgMatch TaxQuarter if SecondBogusDummy==0) (connected AvgMatch TaxQuarter if SecondBogusDummy==1) 



tab BogusDummy
collapse AvgMatch (median) MidAvgMatch=AvgMatch, by(TaxQuarter BogusDummy)
twoway (connected AvgMatch TaxQuarter if BogusDummy==0) (connected AvgMatch TaxQuarter if BogusDummy==1) 
graph save Graph "F:\2a2b_analysis\MatchAnalysis\AvgMatch_trend_BogusFirms.gph"


//Rough
replace TurnoverGross=TurnoverGross/1000000
replace MoneyDeposited=MoneyDeposited/1000000
replace TurnoverCentral=TurnoverCentral/1000000
replace TurnoverLocal=TurnoverLocal/1000000

gen VatRatio=MoneyDeposited/TurnoverGross
gen InterStateRatio=TurnoverCentral/TurnoverGross
gen LocalVatRatio=MoneyDeposited/TurnoverLocal
