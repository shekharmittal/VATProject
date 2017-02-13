import delimited "H:\java_results_quarter\SOLD_TO_2013_Q1\2013_q1_soldto_with_returns [Nodes].csv", delimiter(";") clear
rename label DealerTIN
rename indegree indegree_gephi
rename outdegree outdegree_gephi

tostring DealerTIN, replace
