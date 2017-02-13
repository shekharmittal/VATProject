use "D:\data\HighTurnoverDealers2010_with_distances.dta", clear
append using "D:\data\MediumTurnoverDealers2010_with_distances.dta"

bys DealerTIN TaxQuarter: gen Count=_N
drop if Count==2

destring DealerTIN, replace
xtset DealerTIN TaxQuarter
gen Post=0
replace Post=1 if TaxQuarter>8

log using "H:\2a2b_analysis\quantile regression logs.log", replace

gen Treat=0 if edistance==1
replace Treat=1 if edistance==0
gen iPostTreat=Post*Treat

gen iPostStart=Post*Start
gen iPostEnd=Post*End

xi:qreg2 TurnoverLocal Post i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TurnoverGross Post i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 MoneyDeposited Post i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TotalTaxCredit Post i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TotalOutputTax Post i.TaxQuarter, cluster(DealerTIN)


xi:qreg2 TurnoverLocal Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TurnoverGross Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 MoneyDeposited Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TotalTaxCredit Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TotalOutputTax Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)


drop Treat
gen Treat=0 if sdistance==1
replace Treat=1 if sdistance==0

drop iPostTreat
gen iPostTreat=Post*Treat


xi:qreg2 TurnoverLocal Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TurnoverGross Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 MoneyDeposited Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TotalTaxCredit Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)
xi:qreg2 TotalOutputTax Post Treat iPostTreat i.TaxQuarter, cluster(DealerTIN)


log close

tab sdistance edistance
tab sdistance edistance if TaxQuarter==1
gen Start=0 if sdistance==1
replace Start=1 if sdistance==0
gen End=0 if edistance==1
replace End=1 if edistance==0
tab Start End if TaxQuarter==1
drop if Start==1&End==1
do "C:\Users\ADMINI~1\AppData\Local\Temp\2\STD00000000.tmp"
xtreg MoneyDeposited Post Start End iPostStart iPostEnd, cluster(DealerTIN)

xtreg MoneyDeposited Post Start End iPostStart iPostEnd, fe cluster(DealerTIN)
xtreg TotalTaxCredit Post Start End iPostStart iPostEnd, fe cluster(DealerTIN)
xtreg TotalOutputTax Post Start End iPostStart iPostEnd, fe cluster(DealerTIN)
