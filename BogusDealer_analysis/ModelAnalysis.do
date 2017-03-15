import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.csv, case(preserve) encoding(UTF-8) clear

use "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.dta", clear

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

save "E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.dta", replace


import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusCancellation.csv, case(preserve) clear

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

save "E:\Ofir\BogusFirmCatching\PredictionsBogusCancellation.dta", replace


//Comparing the Return Features of firms that have high prediction probability
tostring DealerTIN, replace
merge 1:1 DealerTIN TaxQuarter using "E:\data\PreliminaryAnalysis\BogusDealers\FeatureReturns.dta", generate(_merge_returns)
drop if _merge_returns!=3


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
