import delimited F:\bogus_2013_SOLD_TO_Q1\Small_network\EDGE_LIST.csv
rename v2 DealerTIN
rename v1 FirstDegreeNodes
gen NetworkSize=="Small Network"

save "F:\sold_to_2013_q1_first_degree_nodes.dta"

import delimited F:\bogus_2013_SOLD_TO_Q1\Large_network\EDGE_LIST.csv, clear
rename v2 DealerTIN
rename v1 FirstDegreeNodes
append using "F:\sold_to_2013_q1_first_degree_nodes.dta"

rename DealerTIN BogusDealerTIN
rename FirstDegreeNodes DealerTIN
save "F:\sold_to_2013_q1_first_degree_nodes.dta", replace

use "H:\sold_to_2013_q1_first_degree_nodes.dta", clear

merge m:1 DealerTIN using "H:\sold_to_2013_q1_all_dealer_information.dta"
keep if _merge==3

merge m:1 DealerTIN using "H:\java_results_quarter\SOLD_TO_2013_Q1\returns_2013_q1.dta"
keep if _merge==3


log using "h:\summary_logs_govt_presentation on 02092016.log", replace
/* Summary statistics for one quarter - 2013 Q1, for GEM Presentaion on January 20, 2016*/
/* Here we compare First Degree dealers of both small and large soldto networks of bogus dealers*/

sum TurnoverGross AmountDepositedByDealer indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if NetworkSize=="Small Network", detail
sum TurnoverGross AmountDepositedByDealer indegree_gephi outdegree_gephi clusteringcoefficient betweennesscentrality closenesscentrality eccentricity eigenvectorcentrality if NetworkSize=="Large Network", detail

sum TurnoverGross AmountDepositedByDealer TotalValueAdded  if NetworkSize=="Small Network", detail
sum TurnoverGross AmountDepositedByDealer TotalValueAdded  if NetworkSize=="Large Network", detail

log close
