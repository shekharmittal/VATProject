use "H:\neo4j_network_stats.dta", clear

log using "H:\anovaanalysis_summary.log", replace
loneway INDEGREE DealerTIN
loneway OUTDEGREE DealerTIN
loneway INDEGREE DealerTIN if INDEGREE!=0|OUTDEGREE!=0
loneway OUTDEGREE DealerTIN if INDEGREE!=0|OUTDEGREE!=0
log close


//to check if INDEGREE actually stays at zero
gsort DealerTIN TaxQuarter
gen Dummy=1 if INDEGREE==0&TaxQuarter==13&OUTDEGREE>0
by DealerTIN: replace Dummy=Dummy[_n-1] if Dummy>=.
keep if Dummy==1

gsort DealerTIN TaxQuarter
br

tostring DealerTIN, replace
merge m:1 DealerTIN using "D:\data\MediumTurnoverDealers2010_q1.dta"
merge m:1 DealerTIN using "D:\data\HighTurnoverDealers2010_q1.dta"

gsort DealerTIN TaxQuarter
by DealerTIN: gen TotalCount=_N
keep if TotalCount==20

tab TaxQuarter
keep if TaxQuarter==1
keep DealerTIN
save "D:\data\2a2b_analysis_dealertins.dta"

merge m:1 DealerTIN using "D:\data\2a2b_analysis_dealertins.dta"
keep if _merge==3

log using "H:\2a2b_analysis\indegree_distribution_starting_nodes(sold to).smcl"
bys TaxQuarter: tab INDEGREE
log close
