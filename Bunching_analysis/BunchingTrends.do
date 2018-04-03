gen Turnover=0
gen B=0
gen Year=0

edit
set obs 1
replace Turnover = 1000000 in 1
replace Year = 1 in 1
set obs 2
replace Turnover = 1000000 in 2
replace Year = 2 in 2
set obs 3
replace Turnover = 5000000 in 3
replace Year = 1 in 3
set obs 4
replace Turnover = 5000000 in 4
replace Year = 2 in 4
set obs 5
replace Turnover = 50000000 in 5
replace Year = 1 in 5
set obs 6
replace Turnover = 50000000 in 6
replace Year = 2 in 6
set obs 7
replace Turnover = 50000000 in 7
replace Year = 3 in 7
replace B = 0.5 in 1
replace B = 0.28 in 2
replace B = 0.34 in 3
replace B = 0.43 in 4
replace B = 2.6 in 5
replace B = 2.98 in 6
replace B = 1.87 in 7
gen lTurnover=log(Turnover)

#delimit ;
twoway (scatter B lTurnover if Year==1) 
	   (scatter B lTurnover if Year==2) 
	   (scatter B lTurnover if Year==3), 
	   graphregion(color(white))
	   legend(order(1 "Year 1" 2 "Year 2" 3 "Year 3"))
	   xtitle("Turnover in Logs")
	   title("Bunching Estimates");
graph save Graph "F:\Bunching_analysis\BunchingEstimates_Logs.gph";   
graph export "F:\Bunching_analysis\BunchingEstimates_Logs.pdf", as(pdf) replace;


replace Turnover=Turnover/1000000

#delimit ;
twoway (scatter B Turnover if Year==1) 
	   (scatter B Turnover if Year==2) 
	   (scatter B Turnover if Year==3), 
	   graphregion(color(white))
	   legend(order(1 "Year 1" 2 "Year 2" 3 "Year 3"))
	   xtitle("Turnover (in million INR)")
	   title("Bunching Estimates");
graph save Graph "F:\Bunching_analysis\BunchingEstimates.gph";   
graph export "F:\Bunching_analysis\BunchingEstimates.pdf", as(pdf) replace;
