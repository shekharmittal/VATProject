merge m:1 TaxYear using "F:\2a2b_analysis\PriceIndexAnnual.dta", keepusing(cpi) generate(_merge_real)
drop _merge_real


gen RealMoneyDeposited=MoneyDeposited/cpi
gen RealTaxCreditBeforeAdjustment=TaxCreditBeforeAdjustment/cpi
gen RealOutputTaxBeforeAdjustment=OutputTaxBeforeAdjustment/cpi
gen RealDiff=Diff/cpi


#delimit ;
preserve;
keep if TotalCount==5;
collapse (sum) RealMoneyDeposited (mean) AvgMoneyDeposited=RealMoneyDeposited (semean) SEMoneyDeposited=RealMoneyDeposited, by(TaxYear Treat);
gen LHS=AvgMoneyDeposited-1.96*SEMoneyDeposited;
gen RHS=AvgMoneyDeposited+1.96*SEMoneyDeposited;
twoway (connected AvgMoneyDeposited TaxYear if Treat==0) 
	   (line LHS TaxYear if Treat==0, lpattern(dot) lcolor(navy)) (line RHS TaxYear if Treat==0, lpattern(dot) lcolor(navy)) 
       (connected AvgMoneyDeposited TaxYear if Treat==1, lpattern(dash) lcolor(red)) 
	   (line LHS TaxYear if Treat==1, lpattern(dot) lcolor(navy)) (line RHS TaxYear if Treat==1, lpattern(dot) lcolor(navy)), 
	   xline(2) 
	   legend(order(1 "Retailers" 4 " Wholesalers"))
	   graphregion(color(white))
	   title("Real Trends for VAT Deposited") 
	   note("Mean Vat deposited in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
restore; 


destring DealerTIN, replace
xtset DealerTIN TaxYear

*drop Post iPostTreat

gen Post=0
replace Post=1 if TaxYear>2

gen iPostTreat=Post*Treat
gen iTaxYear1=0
gen iTaxYear2=0
gen iTaxYear3=0
gen iTaxYear4=0
gen iTaxYear5=0

replace iTaxYear1=1 if TaxYear==1
replace iTaxYear2=1 if TaxYear==2
replace iTaxYear3=1 if TaxYear==3
replace iTaxYear4=1 if TaxYear==4
replace iTaxYear5=1 if TaxYear==5

gen iTreat1=Treat*iTaxYear1
gen iTreat2=Treat*iTaxYear2
gen iTreat3=Treat*iTaxYear3
gen iTreat4=Treat*iTaxYear4	
gen iTreat5=Treat*iTaxYear5


label variable iTreat1 "-2"
label variable iTreat2 "-1"
label variable iTreat3 "0"
label variable iTreat4 "+1"
label variable iTreat5 "+2"



matrix C = J(3,5,.)
matrix rownames C = mean ll95 ul95
matrix colnames C = iTreat1 iTreat2 iTreat3 iTreat4 iTreat5

matrix C[1,2]=0 
matrix C[2,2]=0 
matrix C[3,2]=0


# delimit;
areg PositiveContribution iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
test iTreat1=0;
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons Post iTaxYear2 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
	     graphregion(color(white))
		  xtitle("Years with respect to the introduction of the policy")
	     title("Coefficient for PositiveContribution") 
	     note( "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\PositiveContribution.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\PositiveContribution.pdf", as(pdf) replace;
		 
# delimit;
areg VatIncrease iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
test iTreat1=0;
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for VatIncrease")  
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\VatIncrease.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\VatIncrease.pdf", as(pdf) replace;

		 
		 
		 
# delimit;
areg RealMoneyDeposited iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3 iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
test iTreat1=0;
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for MoneyDeposited")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\MoneyDeposited_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\MoneyDeposited_Real.pdf", as(pdf) replace;

		 
# delimit;
areg RealTaxCreditBeforeAdjustment iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
test iTreat1=0;
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for TaxCredit")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\TaxCreditBeforeAdjustment_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\TaxCreditBeforeAdjustment_Real.pdf", as(pdf) replace;

		 
# delimit;
areg RealOutputTaxBeforeAdjustment iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
test iTreat1=0;
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for Output Tax")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\OutputTaxBeforeAdjustment_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\OutputTaxBeforeAdjustment_Real.pdf", as(pdf) replace;

		 		 		 
	# delimit;
	areg RealDiff iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5 iTreat1 iTreat3  iTreat4 iTreat5, absorb(DealerTIN) cluster(DealerTIN);
	test iTreat1=0;
forvalues i = 1(1)5 {;
	if(`i'!=2){;
	matrix C[1,`i']=_b[iTreat`i'];
	matrix C[2,`i']=_b[iTreat`i']-1.96*_se[iTreat`i'];
	matrix C[3,`i']=_b[iTreat`i']+1.96*_se[iTreat`i'];
	};
};
coefplot (matrix(C), ci((2 3))), drop(_cons iTaxYear2 iTaxYear3 iTaxYear4 iTaxYear5) vertical yline(0) xline(2.5)
         graphregion(color(white))
	     title("Coefficient for OutputTax-InputCredit ")
		 xtitle("Years with respect to the introduction of the policy")
	     note( "Coefficient in million rupees." "Number of retailers is 32979 and number of wholesalers is 19515");
graph save Graph "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\Diff_Real.gph";
graph export "F:\2a2b_analysis\RetailerVsWholeSaler\EventStudy\Annual\Diff_Real.pdf", as(pdf) replace;



areg PositiveContribution Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Treat_Real",  tex replace nocons keep(Post iPostTreat) 
areg VatIncrease Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5  if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Treat_Real",  tex append nocons keep(Post iPostTreat) 
areg RealMoneyDeposited Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Treat_Real",  tex append nocons keep(Post iPostTreat) 
areg RealTaxCreditBeforeAdjustment Post iPostTreat  iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Treat_Real",  tex append nocons keep(Post iPostTreat) 
areg RealOutputTaxBeforeAdjustment  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Treat_Real",  tex append nocons keep(Post iPostTreat) 
areg RealDiff  Post iPostTreat iTaxYear2 iTaxYear4 iTaxYear5 if TotalCount==5, absorb(DealerTIN) cluster(DealerTIN)
outreg2 using "F:\2a2b_analysis\RetailerVsWholeSaler\diffINdiff_MeanRetailWholeSale_Treat_Real",  tex append nocons keep(Post iPostTreat) 




#delimit ;
preserve;
keep if TotalCount==5;
collapse (mean) RealMoneyDeposited, by(TaxYear);
twoway (connected RealMoneyDeposited TaxYear), 
    title("Mean VAT Deposited (for always present firms)") 
	note("Amount in million rupees. Number of firms:148434. Matching started after year 2") 
	xline(2.5) 
	ytitle("VAT deposited (in million rupees)") 
	graphregion(color(white));
restore;
graph save Graph "F:\2a2b_analysis\PostAnalysis\MeanVATDeposited_TotalCount5_Real.gph"
graph export "F:\2a2b_analysis\PostAnalysis\MeanVATDeposited_TotalCount5_Real.pdf", as(pdf) replace


#delimit ;
preserve;
keep if TotalCount==5;
collapse (sum) RealMoneyDeposited, by(TaxYear);
replace RealMoneyDeposited=RealMoneyDeposited/1000;
twoway (connected RealMoneyDeposited TaxYear), 
    title("Total VAT Deposited (for always present firms)") 
	note("Amount in billion rupees, in real terms. Number of firms:148434. Matching started after year 2") 
	xline(2.5) 
	ytitle("VAT deposited (in billion rupees)") 
	graphregion(color(white));
restore;
graph save Graph "F:\2a2b_analysis\PostAnalysis\TotalVATDeposited_TotalCount5_Real.gph";
graph export "F:\2a2b_analysis\PostAnalysis\TotalVATDeposited_TotalCount5_Real.pdf", as(pdf) replace;

gen Dummy=1
#delimit ;
preserve;
collapse (mean) RealMoneyDeposited (count) Dummy , by(TaxYear);
replace Dummy=Dummy/1000;
twoway (connected RealMoneyDeposited TaxYear) (connected Dummy TaxYear, yaxis(2) lpattern(dash)) , 
	title("Mean VAT Deposited (for all firms)") 
	note("Amount in million rupees. Matching started after year 2") 
	xline(2.5) 
	ytitle("VAT deposited (in million rupees)")
	ytitle("Number of firms (in thousands)", axis(2))
	legend(order(1 "Mean VAT deposited" 2 "Number of firms")) 
	graphregion(color(white));
restore;
graph save Graph "F:\2a2b_analysis\PostAnalysis\MeanVATDeposited_ALL_Real.gph", replace;
graph export "F:\2a2b_analysis\PostAnalysis\MeanVATDeposited_ALL_Real.pdf", as(pdf) replace;

#delimit ;
preserve;
collapse (sum) RealMoneyDeposited (count) Dummy , by(TaxYear);
replace Dummy=Dummy/1000;
replace RealMoneyDeposited=RealMoneyDeposited/1000;
twoway (connected RealMoneyDeposited TaxYear) (connected Dummy TaxYear, yaxis(2) lpattern(dash)) , 
	title("Total VAT Deposited (for all firms)") 
	note("Amount in billion rupees. Matching started after year 2") 
	xline(2.5) 
	ytitle("VAT deposited (in billion rupees)")
	ytitle("Number of firms (in thousands)", axis(2))
	legend(order(1 "Total VAT deposited" 2 "Number of firms")) 
	graphregion(color(white));
restore;
graph save Graph "F:\2a2b_analysis\PostAnalysis\TotalVATDeposited_ALL_Real.gph", replace;
graph export "F:\2a2b_analysis\PostAnalysis\TotalVATDeposited_ALL_Real.pdf", as(pdf) replace;

		 		