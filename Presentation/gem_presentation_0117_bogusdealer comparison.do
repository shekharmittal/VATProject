use "F:\sold_to_2013_q1_bogus_numbernodes.dta" 
gen Size="Small Network"
replace Size="Large Network" if NumberNodes>50
rename BogusDummy Selection
gen Selection="Bogus"

edit
replace Selection="Random" if Selection==""
gen Size="Small Network" if NumberNodes<=50&Selection=="Random"
replace Size="Small Network" if NumberNodes<=50&Selection=="Random"

tostring DealerTIN, replace

gsort DealerTIN
by DealerTIN: gen DealerCount=_n
br if DealerCount==2
drop if (DealerTIN=="53829"|DealerTIN=="80830")&Selection=="Random"
drop DealerCount
rename Size NetworkSize

save "F:\sold_to_2013_q1_bogus_numbernodes.dta", replace

histogram NumberNodes, fraction by(Selection)
graph save Graph "F:\java_results_quarter\SOLD_TO_2013_Q1\histogram_number of nodes.gph", replace
graph export "F:\java_results_quarter\SOLD_TO_2013_Q1\histogram_number of nodes.png", as(png) replace


log using "F:\summary_logs_gem_presentation on 01192016.smcl", append
/* Summary statistics for one quarter - 2013 Q1, for GEM Presentaion on January 20, 2016*/
/* Here we compare bogus and random sample in small and large soldto network*/

tab Size Selection if NetworkSize=="Large Network"
tab Size Selection if NetworkSize=="Small Network"
tab Size NetworkSize if Selection=="Bogus"

sum TurnoverGross AmountDepositedByDealer indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Selection=="Bogus"&NetworkSize=="Small Network", detail
sum TurnoverGross AmountDepositedByDealer indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Selection=="Bogus"&NetworkSize=="Large Network", detail
sum TurnoverGross AmountDepositedByDealer indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Selection=="Random"&NetworkSize=="Small Network", detail
sum TurnoverGross AmountDepositedByDealer indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if Selection=="Random"&NetworkSize=="Large Network", detail

log close

graph bar (count), over(Size) over(NetworkSize) over(Selection)
graph save Graph "F:\random_vs_bogus_size_sold_to_2013q1.gph"
graph export "F:\random_vs_bogus_size_sold_to_2013q1.pdf", as(pdf) replace

graph bar (count), over(NetworkSize) over(Selection)
graph save Graph "F:\bimodal_distribution_bogus_count_v2.gph"
