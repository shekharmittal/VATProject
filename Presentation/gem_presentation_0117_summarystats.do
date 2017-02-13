//Creating summary stats from the returns filed for 2013 q1
use "H:\java_results_quarter\SOLD_TO_2013_Q1\returns_2013_q1.dta", clear

gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0

gen ZeroAmountDeposited=0
replace ZeroAmountDeposited=1 if AmountDepositedByDealer==0


gen LargeSize=0
replace LargeSize=1 if TurnoverGross>50000000&TurnoverGross!=.
gen MediumSize=0
replace MediumSize=1 if TurnoverGross<50000000&TurnoverGross>=5000000
gen SmallSize=0
replace SmallSize=1 if TurnoverGross<5000000&TurnoverGross>=1000000
gen MicroSize=0
replace MicroSize=1 if TurnoverGross>0&TurnoverGross<1000000


gen Size="Micro"
replace Size="Small" if SmallSize==1
replace Size="Medium" if MediumSize==1
replace Size="Large" if LargeSize==1
replace Size="Zero" if ZeroTurnover==1

log using "h:\summary_logs_gem_presentation on 02092016.log"
/* Summary statistics for one quarter - 2013 Q1, for GEM Presentaion on January 20, 2016*/
tab ZeroTurnover
tab ZeroAmountDeposited
tab Size ZeroAmountDeposited
sum TurnoverGross AmountDepositedByDealer TotalValueAdded TurnoverUnregistered PurchaseUnregisteredDealer if Size=="Micro", detail
sum TurnoverGross AmountDepositedByDealer TotalValueAdded TurnoverUnregistered PurchaseUnregisteredDealer if Size=="Small", detail
sum TurnoverGross AmountDepositedByDealer TotalValueAdded TurnoverUnregistered PurchaseUnregisteredDealer if Size=="Medium", detail
sum TurnoverGross AmountDepositedByDealer TotalValueAdded TurnoverUnregistered PurchaseUnregisteredDealer if Size=="Large", detail
log close
