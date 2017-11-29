********************************
/* 
	1. Revenue Bunching
	Costa Rica Tax elasticity Project
	Author: Pierre Bachas  
	Date: January 2014

	GOAL: Estimate bunching and fit polynomial. 
	
	DATA: distribution_margins_Inflation_adjusted.xlsx 
	--> Inflation adjusted bins: year 2011 has size 1/2 M bins
	Source: 1.Key Analysis2_100615.txt

*/ 
********************************
********************************
/*

(1) Threshold 1: 
	(1.1) Buncher estimation
	(1.2) Correct for change in elasticity above threshold
	(1.3) Akaike Criteria test
	(1.4) Bootstrap test 
(2) Threshold 2
	(2.1) Buncher estimation
	(2.2) Correct for change in elasticity above threshold

*/
********************************

*******************************
// (1) Threshold 1
*******************************

clear all
set more off
capture log close

import excel "$data/Margin.xlsx", firstrow clear

// Data preparation
destring bin_ref1 bin_ref2, replace
drop if bin_ref2!=. 
drop bin_ref2

rename bin_ref1 ref

gen CRC = .
replace CRC = 49969000 + ref*575000 if ref!=. 

gen crc= CRC/1000000

save "$proc/Bunching_T1.xlsx", replace

********************************
// (1.1) Buncher estimation
********************************

set more off 
use "$proc/Bunching_T1.xlsx", clear

// Simple density graph
twoway (connected density crc if ref>=-40 & ref<=60, msize(small)) , ///
ytitle(Number of firms, size(med) margin(small)) xtitle(Revenue (Million crc), size(med)) title(Firm Density: All firms (2008-2014), size(medlarge) margin(medium)) /// 
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(500)3200, labsize(small)) xline(49.6, lcolor(red))
graph save "$graphs/Allfirms_T1_W1_densityonly.gph", replace
graph export "$graphs/Allfirms_T1_W1_densityonly.pdf", replace 

// Generate the higher order terms: Polynomial of degree 5
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5

// Last bunchers position
local ymax = 23 
// Number of bins of excluded zone 
local excluded = 8

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_1-crc_5 dummy_1-dummy_`ymax' if ref>=-40 & ref<=60
predict counterfactual // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)5	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4 + crc_hat_5 if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded')-300000)/1000000
disp `zupper'
local zupper = round(10*`zupper')/10
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

gen weights = extra_density/`B'
gen ratio_c = counterfactual*weights

sum ratio_c if below_threshold==1
local h_0=`r(mean)'*`r(N)'
drop ratio_c weights

// Locals to show in box
local b=`B'/`h_0'
local b = round(100*`b')/100
disp `b'

local zu = round(`zupper'*10)/10
disp `zu'

local dy = `zu' - round(`umbral'*10)/10
disp `dy' 

// Graph 
twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) (line counterfactual crc if ref >= -40 & ref <= 60, color(green)), ///
title("Revenue Bunching, 1st threshold", size(medlarge) margin(medium)) ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 43 "y_l") text(600 62 "y_u") 
graph save "$graphs/Allfirms_T1_W1.gph", replace
graph export "$graphs/Allfirms_T1_W1.eps", replace 

// Graph with elasticity in results box
twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) (line counterfactual crc if ref >= -40 & ref <= 60, color(green)), ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) title(Bunching, size(med) margin(medium)) ///
plotregion(color(white)) graphregion(fcolor(white)) legend(off) xlabel( , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " "y_u = `zupper'", box margin(l+1 t+1 b+1) fcolor(none)) text(600 41.5 "z_l") text(600 61 "z_u") 

keep ref crc density counterfactual 
save "$waste/bunching_T1_not_adjusted.dta" , replace 

***********************************************************
// (1.2) Correct for change in elasticity above threshold
***********************************************************

// Note: this is roughly correct - and consistent produce a graph that shows the intensive margin change past the threshold. 

set more off 
use "$proc/Bunching_T1.xlsx", clear

// Last bunchers position
local ymax = 23
// Number of bins of excluded zone 
local excluded = 8
// Elasticity estimate
local ey = 0.34

// Gen the adjustment term
gen dy = `ey'*0.111*crc
gen crc_adj = crc
replace crc_adj = crc + dy if ref >= `ymax' - `excluded' 

// Generate the higher order terms: Polynomial of degree 5
gen crc_adj_1=crc_adj
gen crc_adj_2=crc_adj^2
gen crc_adj_3=crc_adj^3
gen crc_adj_4=crc_adj^4
gen crc_adj_5=crc_adj^5

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_adj_1-crc_adj_5 dummy_1-dummy_`ymax' if ref>=-40 & ref<=60
predict counterfactual_a // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)5	{
	local polycoeff`i' = _b[crc_adj_`i']
	disp `polycoeff`i''
	gen crc_adj_hat_`i'=`polycoeff`i'' * crc_adj_`i'
}

replace counterfactual_a = `constant' + crc_adj_hat_1 + crc_adj_hat_2 + crc_adj_hat_3 + crc_adj_hat_4 + crc_adj_hat_5 if ref>=-`excluded' & ref< `ymax'-`excluded'

// Locals 
local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded')-300000)/1000000
disp `zupper'
local zupper = round(10*`zupper')/10
disp `zupper'

local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual_a

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

gen weights = extra_density/`B'
gen ratio_c = counterfactual*weights

sum ratio_c if below_threshold==1
local h_0=`r(mean)'*`r(N)'
drop ratio_c weights

local b=`B'/`h_0'
local b = round(10*`b')/10
disp `b'

// Graph 
twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) (line counterfactual_a crc_adj if ref >= -40 & ref <= 60, color(green)), ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) title("Panel A: First threshold", size(medlarge) margin(medium)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel(30(10)85 , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(med))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin)) ///
text(2250 78 " B  = `b' " "y_u = 58.3", box margin(r+1 l+1 t+1 b+1) fcolor(none)) text(600 43 "y_l") text(600 60.5 "y_u") 
graph save "$graphs/Allfirms_T1_W1_correction.gph", replace 
graph export "$graphs/Allfirms_T1_W1_correction.eps", replace 

// Same Graph with Shaded areas 
twoway (scatteri 3200 45.5 3200 49.5 500 49.5 500 45.5, bcolor(gs9) recast(area)) (scatteri 3200 58.5 3200 49.5 500 49.5 500 58.5, bcolor(gs12) recast(area)) ///
(scatteri 3200 40.5 3200 45.5 500 45.5 500 40.5, bcolor(gs6) recast(area)) /// 
(pcarrowi 3200 45.5 500 45.5, color(black) mcolor(black) lw(thin) lp(dash) msize(zero) legend(off)) (pcarrowi 3200 40.5 500 40.5, color(black) lw(thin) lp(dash) mcolor(black) msize(zero) legend(off)) ///
(pcarrowi 3200 49.5 500 49.5, lcolor(red) mcolor(black) msize(zero) legend(off)) (pcarrowi 3200 58.5 500 58.5, lcolor(black) lp(dash) lw(thin) mcolor(black) msize(zero) legend(off)) ///
(connected density crc if ref >= -35 & ref <= 40, msize(small) color(navy)) (line counterfactual_a crc_adj if ref >= -35 & ref <= 40, color(green)), ///
ytitle("") xtitle("") ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel(30(5)72 , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
text(600 43 "Control", size(medsmall) color(blue)) text(600 47.5 "Bunch", size(medsmall) color(red))  text(600 54 "Hole", size(medsmall) color(green)) 
graph export "$graphs/bunching_zones.eps" , replace

// Add the box around it
/*
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 42 "y_l") text(600 64.5 "y_u") 
graph save "$graphs/Allfirms_T1_W1_adj.gph", replace
graph export "$graphs/Allfirms_T1_W1_adj.eps", replace 
*/ 

***************************************
// Merge Adjusted and Not adjusted
***************************************
// GRAPH TO SHOW FOR INTENSIVE MARGIN ADJUSTMENT
// This will be for an Appendix

use "$waste/bunching_T1_not_adjusted.dta" , replace
merge 1:1 ref using "$waste/bunching_T1_adjusted.dta" , nogenerate

twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) ///
(line counterfactual crc if ref >= -40 & ref <= 60, color(brown)) ///
(line counterfactual_a crc_adj if ref >= -40 & ref <= 60, color(green)) 
graph export "$graphs/bunching_T1_adjusted.eps" , replace

********************************
//	(1.3) Akaike Criteria test
********************************
// Ok so this should really be a two step process:
// Find the ymax for each polynomial and then find akaike criteria

***********************
// Degree 4: AIC = 697
***********************

// STEP 1
set more off
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms 
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4

// Last bunchers position
local ymax = 36
// Number of bins of excluded zone 
local excluded = 10

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_1-crc_4 dummy_1-dummy_`ymax' if ref>=-40 & ref<=60
estat ic 
predict counterfactual

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)4	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4  if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(100*`b')/100
disp `b'

local zu = round(`zupper'*10)/10
disp `zu'

local dy = `zu' - round(`umbral'*10)/10
disp `dy' 

// Graph 
twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) (line counterfactual crc if ref >= -40 & ref <= 60, color(green)), ///
title("Revenue Bunching, 1st threshold", size(medlarge) margin(medium)) ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 42 "y_l") text(600 64.5 "y_u") 

// STEP 2
set more off
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms 
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4

// Last bunchers position
local ymax = 36
// Number of bins of excluded zone 
local excluded = 10

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
drop if `counter' == ref
}

reg density crc_1-crc_4 if ref>=-40 & ref<=60
estat ic 

***********************
// Degree 5: AIC = 1092
***********************

set more off
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms 
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5

// Last bunchers position
local ymax = 33 
// Number of bins of excluded zone 
local excluded = 10

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_1-crc_5 dummy_1-dummy_`ymax' if ref>=-40 & ref<=60
estat ic 
predict counterfactual

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)5	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4 + crc_hat_5 if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual if below_threshold==1
local h_0=`r(mean)'

// STEP 2
set more off
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms 
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5

// Last bunchers position
local ymax = 33 
// Number of bins of excluded zone 
local excluded = 10

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
drop if `counter' == ref
}

reg density crc_1-crc_5 if ref>=-40 & ref<=60
estat ic 

***********************
// Degree 6: AIC = 1108
***********************
set more off
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms 
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5
gen crc_6=crc^6

// Last bunchers position
local ymax = 28
// Number of bins of excluded zone 
local excluded = 8

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_1-crc_6 dummy_1-dummy_`ymax' if ref>=-40 & ref<=50
estat ic // Not sure this is correct to estimate AIC I need to drop the dummies (those are not df's!)
predict counterfactual

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)6	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4 + crc_hat_5 + crc_hat_6 if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(100*`b')/100
disp `b'

local zu = round(`zupper'*10)/10
disp `zu'

local dy = `zu' - round(`umbral'*10)/10
disp `dy' 

// Graph 
twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) (line counterfactual crc if ref >= -40 & ref <= 60, color(green)), ///
title("Revenue Bunching, 1st threshold", size(medlarge) margin(medium)) ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 42 "y_l") text(600 64.5 "y_u") 

// Step 2

// STEP 2
set more off
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms 
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5
gen crc_6=crc^6

// Last bunchers position
local ymax = 33
// Number of bins of excluded zone 
local excluded = 10

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
drop if `counter' == ref
}

reg density crc_1-crc_6 if ref>=-40 & ref<=60
estat ic 

**************************************************
// (1.4) Bootstrap test 
**************************************************

set more off 
use "$proc/Bunching_T1.xlsx", clear

// Generate the higher order terms: Polynomial of degree 5
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5

// Last bunchers position
local ymax = 31 
// Number of bins of excluded zone 
local excluded = 10

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

keep if ref>=-40 & ref<=60

reg density crc_1-crc_5 dummy_1-dummy_`ymax' if ref>=-40 & ref<=60
predict res_predicted, residuals // Ok Question if its correct to bootstrap out of residuals?
keep residuals  

predict counterfactual // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)5	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4 + crc_hat_5 if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(100*`b')/100
disp `b'

local zu = round(`zupper'*10)/10
disp `zu'

local dy = `zu' - round(`umbral'*10)/10
disp `dy' 

// Graph 
twoway (connected density crc if ref >= -40 & ref <= 60, msize(small)) (line counterfactual crc if ref >= -40 & ref <= 60, color(green)), ///
title("Revenue Bunching, 1st threshold", size(medlarge) margin(medium)) ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(500)3200, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 42 "y_l") text(600 64.5 "y_u") 

**************************************************
**************************************************
// (2) Threshold 2
//	(1.1) Buncher estimation
**************************************************
**************************************************

clear all
set more off
capture log close

import excel "$data/Margin.xlsx", firstrow clear

// Data preparation
destring bin_ref1 bin_ref2, replace
drop if bin_ref1!=. 
drop bin_ref1

rename bin_ref2 ref

gen CRC = .
replace CRC = 100513000 + ref*575000 if ref!=. 

gen crc= CRC/1000000

save "$proc/Bunching_T2.xlsx", replace

*********************************************

set more off 
use "$proc/Bunching_T2.xlsx", clear

// Simple density graph small width
twoway (connected density crc if ref>=-40 & ref<=60, msize(small)) , ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million CRC), size(medsmall)) title(First threshold: All firms (2008-2014), size(medlarge) margin(medium)) /// 
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(300(100)1000, labsize(small)) xline(49.6, lcolor(red))
graph save "$graphs/Allfirms_T2_W1.gph", replace
graph export "$graphs/Allfirms_T2_W1.eps", replace 

// Regroup together two bins
gen ref2 = floor(ref/2)
bysort ref2: egen tdensity = total(density)
egen tag = tag(ref2)
keep if tag == 1
drop tag density ref
rename tdensity density
rename ref2 ref

// Simple density graph double width
twoway (connected density crc if ref>=-20 & ref<=30, msize(small)) , ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million CRC), size(medsmall)) title(First threshold: All firms (2008-2014), size(medlarge) margin(medium)) /// 
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(250)1850, labsize(small)) xline(49.6, lcolor(red))

// Generate the higher order terms: Polynomial of degree 5
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4
gen crc_5=crc^5

// Last bunchers position
local ymax = 13 
// Number of bins of excluded zone 
local excluded = 4

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_1-crc_5 dummy_1-dummy_`ymax' if ref>=-20 & ref<=30
predict counterfactual // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)5	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4 + crc_hat_5 if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral2_2014 + 1150000*(`ymax'-`excluded'-1)-600000)/1000000
disp `zupper'
local zlower=($umbral2_2014 + 1150000*(-`excluded')-600000)/1000000
disp `zlower'
local umbral=($umbral2_2014-600000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(100*`b')/100
disp `b'

local zu = round(`zupper'*10)/10
disp `zu'

local dy = `zu' - round(`umbral'*10)/10
disp `dy' 

// Graph 
twoway (connected density crc if ref >= -20 & ref <= 30, msize(small)) (line counterfactual crc if ref >= -20 & ref <= 30, color(green)), ///
title("Revenue Bunching, 1st threshold", size(medlarge) margin(medium)) ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(250)1850, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 42 "y_l") text(600 64.5 "y_u") 
graph save "$graphs/Allfirms_T2_W2.gph", replace
graph export "$graphs/Allfirms_T2_W2.eps", replace 

keep ref crc density counterfactual 
save "$waste/bunching_T2_not_adjusted.dta" , replace 

***********************************************************
// (2.2) Correct for change in elasticity above threshold
***********************************************************

// Note: this is roughly correct - and consistent produce a graph that shows the intensive margin change past the threshold. 

set more off 
use "$proc/Bunching_T2.xlsx", clear

// Regroup together two bins
gen ref2 = floor(ref/2)
bysort ref2: egen tdensity = total(density)
egen tag = tag(ref2)
keep if tag == 1
drop tag density ref
rename tdensity density
rename ref2 ref

// Last bunchers position
local ymax = 12 
// Number of bins of excluded zone 
local excluded = 4
// Elasticity estimate
local ey = 0.09

// Gen the adjustment term
gen dy = `ey'*0.125*crc
gen crc_adj = crc
replace crc_adj = crc + dy if ref >= `ymax' - `excluded' 

// Generate the higher order terms: Polynomial of degree 5
gen crc_adj_1=crc_adj
gen crc_adj_2=crc_adj^2
gen crc_adj_3=crc_adj^3
gen crc_adj_4=crc_adj^4
gen crc_adj_5=crc_adj^5

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_adj_1-crc_adj_5 dummy_1-dummy_`ymax' if ref>=-20 & ref<=35
predict counterfactual_a // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)5	{
	local polycoeff`i' = _b[crc_adj_`i']
	disp `polycoeff`i''
	gen crc_adj_hat_`i'=`polycoeff`i'' * crc_adj_`i'
}

replace counterfactual_a = `constant' + crc_adj_hat_1 + crc_adj_hat_2 + crc_adj_hat_3 + crc_adj_hat_4 + crc_adj_hat_5 if ref>=-`excluded' & ref< `ymax'-`excluded'


/*
local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'
*/ 

// Measure the extra density
gen extra_density = density - counterfactual_a

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual_a if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(10*`b')/10
disp `b'

keep ref crc_adj counterfactual_a 
save "$waste/bunching_T2_adjusted.dta" , replace 

***************************************
// Merge Adjusted and Not adjusted
***************************************
// GRAPH TO SHOW FOR INTENSIVE MARGIN ADJUSTMENT

use "$waste/bunching_T2_not_adjusted.dta" , replace
merge 1:1 ref using "$waste/bunching_T2_adjusted.dta" , nogenerate

twoway (connected density crc if ref >= -20 & ref <= 30, msize(small)) ///
(line counterfactual crc if ref >= -20 & ref <= 30, color(dkblue)) ///
(line counterfactual_a crc_adj if ref >= -20 & ref <= 30, color(dkgreen)) 

****************************************
// Same as above: Polynomial of Degree 4
****************************************

set more off 
use "$proc/Bunching_T2.xlsx", clear

// Simple density graph small width
twoway (connected density crc if ref>=-40 & ref<=60, msize(small)) , ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million CRC), size(medsmall)) title(First threshold: All firms (2008-2014), size(medlarge) margin(medium)) /// 
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(300(100)1000, labsize(small)) xline(49.6, lcolor(red))
graph save "$graphs/Allfirms_T2_W1.gph", replace
graph export "$graphs/Allfirms_T2_W1.eps", replace 

// Regroup together two bins
gen ref2 = floor(ref/2)
bysort ref2: egen tdensity = total(density)
egen tag = tag(ref2)
keep if tag == 1
drop tag density ref
rename tdensity density
rename ref2 ref

// Simple density graph double width
twoway (connected density crc if ref>=-20 & ref<=30, msize(small)) , ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million CRC), size(medsmall)) title(First threshold: All firms (2008-2014), size(medlarge) margin(medium)) /// 
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(250)1850, labsize(small)) xline(49.6, lcolor(red))

// Generate the higher order terms: Polynomial of degree 5
gen crc_1=crc
gen crc_2=crc^2
gen crc_3=crc^3
gen crc_4=crc^4

// Last bunchers position
local ymax = 15 
// Number of bins of excluded zone 
local excluded = 4

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_1-crc_4 dummy_1-dummy_`ymax' if ref>=-20 & ref<=30
predict counterfactual // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)4	{
	local polycoeff`i' = _b[crc_`i']
	disp `polycoeff`i''
	gen crc_hat_`i'=`polycoeff`i'' * crc_`i'
}

replace counterfactual = `constant' + crc_hat_1 + crc_hat_2 + crc_hat_3 + crc_hat_4  if ref>=-`excluded' & ref< `ymax'-`excluded'

local zupper=($umbral2_2014 + 1150000*(`ymax'-`excluded'-1)-600000)/1000000
disp `zupper'
local zlower=($umbral2_2014 + 1150000*(-`excluded')-600000)/1000000
disp `zlower'
local umbral=($umbral2_2014-600000)/1000000
disp `umbral'

// Measure the extra density
gen extra_density = density - counterfactual

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(100*`b')/100
disp `b'

local zu = round(`zupper'*10)/10
disp `zu'

local dy = `zu' - round(`umbral'*10)/10
disp `dy' 

// Graph 
twoway (connected density crc if ref >= -20 & ref <= 30, msize(small)) (line counterfactual crc if ref >= -20 & ref <= 30, color(green)), ///
title("Revenue Bunching, 1st threshold", size(medlarge) margin(medium)) ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) ///
plotregion(color(white)) graphregion(color(white)) legend(off) xlabel( , labsize(small)) ylabel(500(250)1850, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(thin))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin))  ///
text(2250 72 " B  = `b' " " yu = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(600 42 "y_l") text(600 64.5 "y_u") 
graph save "$graphs/Allfirms_T2_W2.gph", replace
graph export "$graphs/Allfirms_T2_W2.eps", replace 

keep ref crc density counterfactual 
save "$waste/bunching_T2_not_adjusted.dta" , replace 

***********************************************************
// (2.2) Correct for change in elasticity above threshold
***********************************************************

// Note: this is roughly correct - and consistent produce a graph that shows the intensive margin change past the threshold. 

set more off 
use "$proc/Bunching_T2.xlsx", clear

// Regroup together two bins
gen ref2 = floor(ref/2)
bysort ref2: egen tdensity = total(density)
egen tag = tag(ref2)
keep if tag == 1
drop tag density ref
rename tdensity density
rename ref2 ref

// Last bunchers position
local ymax = 12 
// Number of bins of excluded zone 
local excluded = 4
// Elasticity estimate
local ey = 0.09

local zupper=($umbral2_2014 + 1150000*(`ymax'-`excluded')-500000)/1000000
disp `zupper'
local zlower=($umbral2_2014 + 1150000*(-`excluded')-600000)/1000000
disp `zlower'
local umbral=($umbral2_2014-600000)/1000000
disp `umbral'

// Gen the adjustment term
gen dy = `ey'*0.125*crc
gen crc_adj = crc
replace crc_adj = crc + dy if ref >= `ymax' - `excluded' 

// Generate the higher order terms: Polynomial of degree 5
gen crc_adj_1=crc_adj
gen crc_adj_2=crc_adj^2
gen crc_adj_3=crc_adj^3
gen crc_adj_4=crc_adj^4

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_adj_1-crc_adj_4 dummy_1-dummy_`ymax' if ref>=-20 & ref<=29
predict counterfactual_a // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)4	{
	local polycoeff`i' = _b[crc_adj_`i']
	disp `polycoeff`i''
	gen crc_adj_hat_`i'=`polycoeff`i'' * crc_adj_`i'
}

replace counterfactual_a = `constant' + crc_adj_hat_1 + crc_adj_hat_2 + crc_adj_hat_3 + crc_adj_hat_4 if ref>=-`excluded' & ref< `ymax'-`excluded'

/*
local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'
*/ 

// Measure the extra density
gen extra_density = density - counterfactual_a

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual_a if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(10*`b')/10
disp `b'

local zu = round(`zupper'*10)/10 - 0.6
disp `zu'

// Graph 
twoway (connected density crc if ref >= -20 & ref <= 29, msize(small)) (line counterfactual_a crc_adj if ref >= -20 & ref <= 29, color(green)) , ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) title("Panel B: Second threshold", size(medlarge) margin(medium)) ///
legend(off) xlabel(80(10)130 , labsize(small)) ylabel(600(200)1800, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(medium))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin)) plotregion(color(white)) graphregion(color(white))  ///
text(1350 127 " B  = `b' " " y_u = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(650 93.7 "y_l") text(650 113 "y_u") 
graph save "$graphs/Allfirms_T2_W2_correction.gph", replace
graph export "$graphs/Allfirms_T2_W2_correction.eps", replace 

keep ref crc_adj counterfactual_a 
save "$waste/bunching_T2_adjusted.dta" , replace 

*********************************************
// DO Half Million CRC bins
*********************************************

set more off 
use "$proc/Bunching_T2.xlsx", clear

// Last bunchers position
local ymax = 21 
// Number of bins of excluded zone 
local excluded = 7
// Elasticity estimate
local ey = 0.09

local zupper=($umbral2_2014 + 575000*(`ymax'-`excluded')-300000)/1000000
disp `zupper'
local zlower=($umbral2_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral2_2014-300000)/1000000
disp `umbral'

// Gen the adjustment term
gen dy = `ey'*0.125*crc
gen crc_adj = crc
replace crc_adj = crc + dy if ref >= `ymax' - `excluded' 

// Generate the higher order terms: Polynomial of degree 5
gen crc_adj_1=crc_adj
gen crc_adj_2=crc_adj^2
gen crc_adj_3=crc_adj^3
gen crc_adj_4=crc_adj^4

// gen dummy for excluded zone 
forvalues i=1(1)`ymax' {
local counter= `i'- `excluded'-1
gen dummy_`i' = 0
replace dummy_`i'=1 if `counter' == ref
}

reg density crc_adj_1-crc_adj_4 dummy_1-dummy_`ymax' if ref>=-40 & ref<=58
predict counterfactual_a // Generate predicted values for the excluded zone

local constant = _b[_cons] // This saves the coefficients of the polynomial

forvalues i =1(1)4	{
	local polycoeff`i' = _b[crc_adj_`i']
	disp `polycoeff`i''
	gen crc_adj_hat_`i'=`polycoeff`i'' * crc_adj_`i'
}

replace counterfactual_a = `constant' + crc_adj_hat_1 + crc_adj_hat_2 + crc_adj_hat_3 + crc_adj_hat_4 if ref>=-`excluded' & ref< `ymax'-`excluded'

/*
local zupper=($umbral1_2014 + 575000*(`ymax'-`excluded'-1)-300000)/1000000
disp `zupper'
local zlower=($umbral1_2014 + 575000*(-`excluded')-300000)/1000000
disp `zlower'
local umbral=($umbral1_2014-300000)/1000000
disp `umbral'
*/ 

// Measure the extra density
gen extra_density = density - counterfactual_a

gen below_threshold=.
replace below_threshold=1 if ref < 0 & ref >= - `excluded'
replace below_threshold=0 if ref >= 0 & ref < `ymax'- `excluded'

egen Total_extra_density=total(extra_density), by(below_threshold)
tab Total_extra_density

sum Total_extra_density if below_threshold==1
local B=`r(mean)'

sum counterfactual_a if below_threshold==1
local h_0=`r(mean)'

// Locals to show in box
local b=`B'/`h_0'
local b = round(10*`b')/10
disp `b'

local zu = round(`zupper'*10)/10 - 0.6
disp `zu'

// Graph 
twoway (connected density crc if ref >= -40 & ref <= 58, msize(small)) (line counterfactual_a crc_adj if ref >= -40 & ref <= 58, color(green)) , ///
ytitle(Number of firms, size(medsmall)) xtitle(Revenue (Million crc), size(medsmall)) title("Panel B: Second threshold", size(medlarge) margin(medium)) ///
legend(off) xlabel(80(10)130 , labsize(small)) ylabel(300(100)900, labsize(small)) ///
xline(`zlower', lcolor(black) lpattern(dash) lwidth(thin)) xline(`umbral', lcolor(red) lwidth(medium))  ///
xline(`zupper', lcolor(black) lpattern(dash) lwidth(thin)) plotregion(color(white)) graphregion(color(white))  ///
text(680 125 " B  =   `b' " " y_u = `zu' ", box margin(l+1 t+1 b+1) fcolor(none)) text(320 93.7 "y_l") text(320 111 "y_u") 
graph save "$graphs/Allfirms_T2_W2_correction.gph", replace
graph export "$graphs/Allfirms_T2_W2_correction.eps", replace 

/*
***************************************
// Merge Adjusted and Not adjusted
***************************************
// GRAPH TO SHOW FOR INTENSIVE MARGIN ADJUSTMENT

use "$waste/bunching_T2_not_adjusted.dta" , replace
merge 1:1 ref using "$waste/bunching_T2_adjusted.dta" , nogenerate

twoway (connected density crc if ref >= -20 & ref <= 30, msize(small)) ///
(line counterfactual crc if ref >= -20 & ref <= 30, color(dkblue)) ///
(line counterfactual_a crc_adj if ref >= -20 & ref <= 30, color(dkgreen)) 
*/ 
***************************************
// Combined Graphs of Threshold 1 and 2
***************************************
graph combine "$graphs/Allfirms_T1_W1_correction.gph" "$graphs/Allfirms_T2_W2_correction.gph" , ///
col(1) plotregion(color(white)) graphregion(color(white)) xsize(8) ysize(11) ///
plotregion(color(white)) graphregion(color(white) margin(zero)) imargin(5 5 5 5)
graph save "$graphs/Revenue_bunching.gph", replace
graph export "$graphs/Revenue_bunching.eps", replace



