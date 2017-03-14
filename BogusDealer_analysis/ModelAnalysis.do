import delimited E:\Ofir\BogusFirmCatching\PredictionsBogusOnline.csv, case(preserve) encoding(UTF-8) clear
br
drop v1
gsort -BogusOnlineModel1 -BogusOnlineModel2
br
gen Count=_n
tab bogus_cancellation if Count<500
tab bogus_online if Count<500
gsort -BogusOnlineModel7 -BogusOnlineModel5
drop Count
gen Count=_n
tab bogus_cancellation if Count<500
tab bogus_online if Count<500
tab bogus_cancellation if Count<800
tab bogus_cancellation bogus_online  if Count<800
tab TaxQuarter
gsort -BogusOnlineModel7
drop Count
gen Count=_n
tab bogus_cancellation if Count<500
tab bogus_online  if Count<500
gsort -BogusOnlineModel1
drop Count
gen Count=_n
tab bogus_online  if Count<500
tab bogus_cancellation if Count<500
br
rename Count RankModel1
sum BogusOnlineModel1 BogusOnlineMode2
sum BogusOnlineModel1 BogusOnlineModel2
sum BogusOnlineModel1 BogusOnlineModel2 bogus_online
sum BogusOnlineModel1 BogusOnlineModel2 BogusOnlineModel5
sum BogusOnlineModel1 BogusOnlineModel2 BogusOnlineModel5 BogusOnlineModel7
sum BogusOnlineModel*
gen ProbabilitySum=sum(BogusOnlineModel*)
gen ProbabilitySum=BogusOnlineModel1 +BogusOnlineModel2 +BogusOnlineModel3 +BogusOnlineModel4 + BogusOnlineModel5 + BogusOnlineModel6  + BogusOnlineModel7
gsort -ProbabilitySum
gen RankSum=_n
tab bogus_online if RankSum<501
tab bogus_online if RankSum<1000
tab bogus_cancellation  if RankSum<501
gsort DealerTIN -RankSum
tab bogus_online if RankSum<2000
tab bogus_cancellation if RankSum<2000
tab bogus_online if RankSum<100
tab bogus_cancellation if RankSum<100
tab bogus_online if RankModel1<100
tab bogus_cancellation if RankModel1<100
gsort -BogusOnlineModel5
gen RankModel5=_n
tab bogus_cancellation if RankModel5<100
tab bogus_online  if RankModel5<100
tab bogus_online  if RankModel1<100
gsort TaxQuarter -BogusOnlineModel5
by TaxQuarter: gen QuarterlyRankModel5=_n
tab bogus_online if QuarterlyRankModel5<500&TaxQuarter==17
tab bogus_online if TaxQuarter==17
tab bogus_online if TaxQuarter==13
tab bogus_online if TaxQuarter==13&QuarterlyRankModel5<500
tab bogus_cancellation  if TaxQuarter==13
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel5<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel1<500
gsort TaxQuarter -BogusOnlineModel1
by TaxQuarter: gen QuarterlyRankModel1=_n
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel5<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel1<500
tab bogus_online  if TaxQuarter==13&QuarterlyRankModel5<500
tab bogus_online  if TaxQuarter==13&QuarterlyRankModel1<500
gsort TaxQuarter -BogusOnlineModel7
by TaxQuarter: gen QuarterlyRankModel7=_n
tab bogus_online  if TaxQuarter==13&QuarterlyRankModel7<500
tab bogus_online  if TaxQuarter==13&QuarterlyRankModel1<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel7<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel1<500
gsort TaxQuarter -ProbabilitySum
by TaxQuarter: gen OverallRank=_n
by TaxQuarter: gen OverallQuarterlyRank=_n
tab bogus_cancellation  if TaxQuarter==13&OverallQuarterlyRank<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel1<500
tab bogus_online if TaxQuarter==13&QuarterlyRankModel1<500
tab bogus_online if TaxQuarter==13&OverallQuarterlyRank<500
tab bogus_cancellation  if TaxQuarter==13&QuarterlyRankModel1<100
tab bogus_cancellation  if TaxQuarter==13&OverallQuarterlyRank<100
tab bogus_online  if TaxQuarter==13&OverallQuarterlyRank<100
tab bogus_online  if TaxQuarter==13&QuarterlyRankModel1<100
tab TaxQuarter
