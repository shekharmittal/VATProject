merge m:1 TaxQuarter using "F:\2a2b_analysis\PriceIndexQuarterly.dta", keepusing(cpi) generate(_merge_real)
drop _merge_real



gen RealMoneyDeposited=MoneyDeposited/cpi
gen RealTaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/cpi
gen RealOutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/cpi
gen RealDiff=Diff/cpi

# delimit;
preserve;
drop if TotalCount!=20;
drop if Treat==.;
collapse (sum) RealMoneyDeposited (mean) AvgMoneyDeposited=RealMoneyDeposited (semean) SEMoneyDeposited=RealMoneyDeposited, by(TaxQuarter Treat);
gen LHS=AvgMoneyDeposited-1.96*SEMoneyDeposited;
gen RHS=AvgMoneyDeposited+1.96*SEMoneyDeposited;
twoway (connected AvgMoneyDeposited TaxQuarter if Treat==0) 
       (line LHS TaxQuarter if Treat==0, lpattern(dot) lcolor(navy)) 
	   (line RHS TaxQuarter if Treat==0, lpattern(dot) lcolor(navy)) 
	   (connected AvgMoneyDeposited TaxQuarter if Treat==1, lpattern(dash)) 
	   (line LHS TaxQuarter if Treat==1, lpattern(dot) lcolor(red)) 
	   (line RHS TaxQuarter if Treat==1, lpattern(dot) lcolor(red)), 
	   xline(8.5) legend (order(1 "Retailers" 4 " Wholesalers")) title("Real Trends for VAT Deposited") 
	   note("Vat deposited in million rupees.") graphregion(color(white));
restore;
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\MeanMoneyDeposited_quarterly_with_confidenceintervals_Real.gph"
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\MeanMoneyDeposited_quarterly_with_confidenceintervals_Real.pdf", as(pdf) replace


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatQuarterDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg RealMoneyDeposited `TaxQuarterDummy' `TreatQuarterDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		  xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for MoneyDeposited") 
         note( "Coefficient in million rupees." "Number of retailers is 15337 and number of wholesalers is 11482");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\MoneyDeposited_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\MoneyDeposited_Real.pdf", as(pdf) replace;


//Testing pre-trends formally
test iTreatT1=iTreatT2=0=iTreatT3=iTreatT4=iTreatT5=iTreatT6=iTreatT7


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatQuarterDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg RealTaxCreditBeforeAdjustment `TaxQuarterDummy' `TreatQuarterDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		  xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for TaxCredit") 
         note( "Coefficient in million rupees." "Number of retailers is 15337 and number of wholesalers is 11482");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\TaxCreditBeforeAdjustment_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\TaxCreditBeforeAdjustment_Real.pdf", as(pdf) replace;

//Testing pre-trends formally
test iTreatT1=iTreatT2=0=iTreatT3=iTreatT4=iTreatT5=iTreatT6=iTreatT7


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatQuarterDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg RealOutputTaxBeforeAdjustment `TaxQuarterDummy' `TreatQuarterDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		  xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for Output Tax") 
         note( "Coefficient in million rupees." "Number of retailers is 15337 and number of wholesalers is 11482");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\OutputTax_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\OutputTax_Real.pdf", as(pdf) replace;
	
//Testing pre-trends formally
test iTreatT1=iTreatT2=0=iTreatT3=iTreatT4=iTreatT5=iTreatT6=iTreatT7


#delimit;
local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter9 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20" ;
local TreatQuarterDummy "iTreatT1 iTreatT2 iTreatT3 iTreatT4 iTreatT5 iTreatT6 iTreatT7 iTreatT9 iTreatT10 iTreatT11 iTreatT12 iTreatT13 iTreatT14 iTreatT15 iTreatT16 iTreatT17 iTreatT18 iTreatT19 iTreatT20";
areg RealDiff `TaxQuarterDummy' `TreatQuarterDummy', absorb(DealerTIN) cluster(DealerTIN);
forvalues i = 1(1)20 {;
	if(`i'!=8){;
	matrix C[1,`i']=_b[iTreatT`i'];
	matrix C[2,`i']=_b[iTreatT`i']-1.96*_se[iTreatT`i'];
	matrix C[3,`i']=_b[iTreatT`i']+1.96*_se[iTreatT`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons `TaxQuarterDummy') vertical yline(0) xline(8.5)
	     graphregion(color(white))
		  xtitle("Quarters with respect to the introduction of the policy")
	     title("Coefficient for OutputTax-InputCredit ")
         note( "Coefficient in million rupees." "Number of retailers is 15337 and number of wholesalers is 11482");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\Diff_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\Diff_Real.pdf", as(pdf) replace;
	
//Testing pre-trends formally
test iTreatT1=iTreatT2=0=iTreatT3=iTreatT4=iTreatT5=iTreatT6=iTreatT7



drop if Treat==.
gen Pre=0
replace Pre=1 if TaxQuarter<=8&TaxQuarter>=7

gen PreWholesaler=0
replace PreWholesaler=1 if TaxQuarter<=8&TaxQuarter>=7&Treat==1

label variable iPostTreat "Post*Wholesaler"
label variable Post "Post"
label variable PreWholesaler "PrePolicy*Wholesaler"
label variable Pre "PrePolicy"

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
areg PositiveContribution Post  iPostTreat Pre PreWholesaler   `TaxQuarterDummy', absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\diffINdiff_MeanRetailWholeSale_falsification_Real",  tex replace nocons keep(Post iPostTreat Pre PreWholesaler) label

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
areg VatIncrease Post iPostTreat   Pre PreWholesaler `TaxQuarterDummy', absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\diffINdiff_MeanRetailWholeSale_falsification_Real",  tex append nocons keep(Post iPostTreat Pre PreWholesaler) label

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
areg RealMoneyDeposited Post iPostTreat Pre PreWholesaler `TaxQuarterDummy', absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\diffINdiff_MeanRetailWholeSale_falsification_Real",  tex append nocons keep(Post iPostTreat Pre PreWholesaler) label

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
areg RealTaxCreditBeforeAdjustment Post iPostTreat Pre PreWholesaler `TaxQuarterDummy', absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\diffINdiff_MeanRetailWholeSale_falsification_Real",  tex append nocons keep(Post iPostTreat Pre PreWholesaler) label

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
areg RealOutputTaxBeforeAdjustment Post iPostTreat Pre PreWholesaler `TaxQuarterDummy', absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\diffINdiff_MeanRetailWholeSale_falsification_Real",  tex append nocons keep(Post iPostTreat Pre PreWholesaler) label

local TaxQuarterDummy "iTaxQuarter2 iTaxQuarter3 iTaxQuarter4 iTaxQuarter5 iTaxQuarter6 iTaxQuarter7 iTaxQuarter8 iTaxQuarter10 iTaxQuarter11 iTaxQuarter12 iTaxQuarter13 iTaxQuarter14 iTaxQuarter15 iTaxQuarter16 iTaxQuarter17 iTaxQuarter18 iTaxQuarter19 iTaxQuarter20"
areg RealDiff Post iPostTreat Pre PreWholesaler `TaxQuarterDummy', absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Quarter\diffINdiff_MeanRetailWholeSale_falsification_Real",  tex append nocons keep(Post iPostTreat Pre PreWholesaler) label

