import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusOnline_v2_2012_OnlyY3.csv, case(preserve) encoding(UTF-8) clear

import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusOnline_v2.csv, case(preserve) encoding(UTF-8) clear

import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.csv, case(preserve) encoding(UTF-8) clear

use "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.dta", clear

drop v1
gsort -BogusOnlineModel1 -BogusOnlineModel2
gen Count=_n
tab bogus_cancellation if Count<500
tab bogus_online if Count<500

gen ProbabilitySum=BogusOnlineModel1+BogusOnlineModel2+BogusOnlineModel3+BogusOnlineModel4+BogusOnlineModel5+BogusOnlineModel6+BogusOnlineModel7

sum BogusOnlineModel*


gsort -BogusOnlineModel1
gen RankModel1=_n

gsort -BogusOnlineModel2
gen RankModel2=_n

gsort -BogusOnlineModel3
gen RankModel3=_n

gsort -BogusOnlineModel4
gen RankModel4=_n

gsort -BogusOnlineModel5
gen RankModel5=_n

gsort -BogusOnlineModel6
gen RankModel6=_n

gsort -BogusOnlineModel7
gen RankModel7=_n

gsort -ProbabilitySum
gen RankModelAll=_n

gsort TaxQuarter -BogusOnlineModel1
by TaxQuarter: gen QuarterlyRankModel1=_n

gsort TaxQuarter -BogusOnlineModel2
by TaxQuarter: gen QuarterlyRankModel2=_n

gsort TaxQuarter -BogusOnlineModel3
by TaxQuarter: gen QuarterlyRankModel3=_n

gsort TaxQuarter -BogusOnlineModel4
by TaxQuarter: gen QuarterlyRankModel4=_n

gsort TaxQuarter -BogusOnlineModel5
by TaxQuarter: gen QuarterlyRankModel5=_n

gsort TaxQuarter -BogusOnlineModel6
by TaxQuarter: gen QuarterlyRankModel6=_n

gsort TaxQuarter -BogusOnlineModel7
by TaxQuarter: gen QuarterlyRankModel7=_n

gsort TaxQuarter -ProbabilitySum
by TaxQuarter: gen QuarterlyRankModelAll=_n

tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModelAll<100
tab bogus_online  if TaxQuarter==13&QuarterlyRankModelAll<100


rename RankModel1 OnlineRankModel1
rename RankModel2 OnlineRankModel2
rename RankModel3 OnlineRankModel3
rename RankModel4 OnlineRankModel4
rename RankModel5 OnlineRankModel5
rename RankModel6 OnlineRankModel6
rename RankModel7 OnlineRankModel7
rename RankModelAll OnlineRankModelAll
rename QuarterlyRankModel1 OnlineQuarterlyRankModel1
rename QuarterlyRankModel2 OnlineQuarterlyRankModel2
rename QuarterlyRankModel3 OnlineQuarterlyRankModel3
rename QuarterlyRankModel4 OnlineQuarterlyRankModel4
rename QuarterlyRankModel5 OnlineQuarterlyRankModel5
rename QuarterlyRankModel6 OnlineQuarterlyRankModel6
rename QuarterlyRankModel7 OnlineQuarterlyRankModel7
rename QuarterlyRankModelAll OnlineQuarterRankModelAll

save "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline_v2_2013.dta", replace


import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusCancellation_v2.csv, case(preserve) clear
drop v1 v9
gen ProbabilitySum=BogusCancellationModel1+BogusCancellationModel2+BogusCancellationModel3+BogusCancellationModel4+BogusCancellationModel5+BogusCancellationModel6+BogusCancellationModel7

sum BogusCancellationModel*

gsort -BogusCancellationModel1
gen RankModel1=_n

gsort -BogusCancellationModel2
gen RankModel2=_n

gsort -BogusCancellationModel3
gen RankModel3=_n

gsort -BogusCancellationModel4
gen RankModel4=_n

gsort -BogusCancellationModel5
gen RankModel5=_n

gsort -BogusCancellationModel6
gen RankModel6=_n

gsort -BogusCancellationModel7
gen RankModel7=_n

gsort -ProbabilitySum
gen RankModelAll=_n

gsort TaxQuarter -BogusCancellationModel1
by TaxQuarter: gen QuarterlyRankModel1=_n

gsort TaxQuarter -BogusCancellationModel2
by TaxQuarter: gen QuarterlyRankModel2=_n

gsort TaxQuarter -BogusCancellationModel3
by TaxQuarter: gen QuarterlyRankModel3=_n

gsort TaxQuarter -BogusCancellationModel4
by TaxQuarter: gen QuarterlyRankModel4=_n

gsort TaxQuarter -BogusCancellationModel5
by TaxQuarter: gen QuarterlyRankModel5=_n

gsort TaxQuarter -BogusCancellationModel6
by TaxQuarter: gen QuarterlyRankModel6=_n

gsort TaxQuarter -BogusCancellationModel7
by TaxQuarter: gen QuarterlyRankModel7=_n

gsort TaxQuarter -ProbabilitySum
by TaxQuarter: gen QuarterlyRankModelAll=_n

tab bogus_cancellation  if RankModelAll<500
tab bogus_online  if RankModelAll<500


tab bogus_cancellation  if QuarterlyRankModelAll<100
tab bogus_online  if QuarterlyRankModelAll<100

rename RankModel1 CancellationRankModel1
rename RankModel2 CancellationRankModel2
rename RankModel3 CancellationRankModel3
rename RankModel4 CancellationRankModel4
rename RankModel5 CancellationRankModel5
rename RankModel6 CancellationRankModel6
rename RankModel7 CancellationRankModel7
rename RankModelAll CancellationRankModelAll
rename QuarterlyRankModel1 CancellationQuarterlyRankModel1
rename QuarterlyRankModel2 CancellationQuarterlyRankModel2
rename QuarterlyRankModel3 CancellationQuarterlyRankModel3
rename QuarterlyRankModel4 CancellationQuarterlyRankModel4
rename QuarterlyRankModel5 CancellationQuarterlyRankModel5
rename QuarterlyRankModel6 CancellationQuarterlyRankModel6
rename QuarterlyRankModel7 CancellationQuarterlyRankModel7
rename QuarterlyRankModelAll CancellationQuarterRankModelAll

save "E:\Ofir\BogusFirmCatching\PredictionsBogusCancellation.dta", replace


merge 1:1 DealerTIN TaxQuarter using "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.dta", keepusing(BogusOnlineModel1 BogusOnlineModel2 BogusOnlineModel3 BogusOnlineModel4 BogusOnlineModel5 BogusOnlineModel6 BogusOnlineModel7 OnlineRankModel1 OnlineRankModel2 OnlineRankModel3 OnlineRankModel4 OnlineRankModel5 OnlineRankModel6 OnlineRankModel7 OnlineQuarterlyRankModel1 OnlineRankModelAll OnlineQuarterlyRankModel2 OnlineQuarterlyRankModel3 OnlineQuarterlyRankModel4 OnlineQuarterlyRankModel5 OnlineQuarterlyRankModel6 OnlineQuarterlyRankModel7 OnlineQuarterRankModelAll)



//Comparing the Return Features of firms that have high prediction probability
tostring DealerTIN, replace
merge 1:1 DealerTIN TaxQuarter using "E:\data\PreliminaryAnalysis\BogusDealers\FeatureReturns.dta", generate(_merge_returns)
drop if _merge_returns!=3

merge m:1 DealerTIN using "E:\data\PreliminaryAnalysis\BogusDealers\FeatureDealerProfiles.dta", generate(_merge_profiles)


sum TurnoverGross MoneyDeposited if RankModelAll<500
sum TurnoverGross MoneyDeposited if RankModelAll>500
sum TurnoverGross MoneyDeposited TurnoverCentral AllCentral AllLocal ZeroTurnover if QuarterlyRankModelAll<100
sum TurnoverGross MoneyDeposited TurnoverCentral AllCentral AllLocal ZeroTurnover if QuarterlyRankModelAll>100


//Comparing the difference in ranking of firms
gsort DealerTIN TaxQuarter
by DealerTIN: egen MaxRank=max(RankModelAll)
by DealerTIN: egen MinRank=min(RankModelAll)
by DealerTIN: egen MeanRank=mean(RankModelAll)
by DealerTIN: gen DealerCount=_n
//by DealerTIN: egen sdRank=(RankModelAll)

sum MaxRank MinRank MeanRank if DealerCount==1
gen Diff=MaxRank-MeanRank
sum Diff if DealerCount==1
sum Diff if DealerCount==1,detail
br if Diff>100000
