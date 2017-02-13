use "E:\data\form37_data_auditnotice.dta", clear

gen AuditDate=dofc(DateActualNotice)
drop if DealerTIN==""
format %td AuditDate
gen AuditYear=yofd(AuditDate)
gen AuditMonth=mofd(AuditDate)
format %ty AuditYear  
format %tm AuditMonth

gen month=AuditMonth
gen TaxYear=1 if month>602&month<=614
gen TaxYear=2 if month>614&month<=626
replace TaxYear=2 if month>614&month<=626
replace TaxYear=3 if month>626&month<=638
replace TaxYear=4 if month>638&month<=650
replace TaxYear=5 if month>650&month<=662
replace TaxYear=6 if month>662&month<=674

drop if DateActualNotice==.
gsort DealerTIN DateActualNotice
by DealerTIN DateActualNotice:gen Count=_n
by DealerTIN DateActualNotice: gen TotalCount=_N
tab TotalCount if Count==1
drop if Count>1

rename month TaxMonth
gen TaxQuarter=0
replace TaxQuarter=1 if TaxMonth>0&TaxMonth<=3
replace TaxQuarter=2 if TaxMonth>3&TaxMonth<=6
replace TaxQuarter=3 if TaxMonth>6&TaxMonth<=9
replace TaxQuarter=4 if TaxMonth>9&TaxMonth<=12
replace TaxQuarter=5 if TaxMonth>12&TaxMonth<=15
replace TaxQuarter=6 if TaxMonth>15&TaxMonth<=18
replace TaxQuarter=7 if TaxMonth>18&TaxMonth<=21
replace TaxQuarter=8 if TaxMonth>21&TaxMonth<=24
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36
replace TaxQuarter=13 if TaxMonth>36&TaxMonth<=39
replace TaxQuarter=14 if TaxMonth>39&TaxMonth<=42
replace TaxQuarter=15 if TaxMonth>42&TaxMonth<=45
replace TaxQuarter=16 if TaxMonth>45&TaxMonth<=48
replace TaxQuarter=17 if TaxMonth>48&TaxMonth<=51
replace TaxQuarter=18 if TaxMonth>51&TaxMonth<=54
replace TaxQuarter=19 if TaxMonth>54&TaxMonth<=57
replace TaxQuarter=20 if TaxMonth>57&TaxMonth<=60
replace TaxQuarter=21 if TaxMonth>60&TaxMonth<=63
replace TaxQuarter=22 if TaxMonth>63&TaxMonth<=66


drop Count TotalCount
gsort DealerTIN TaxQuarter
by DealerTIN TaxQuarter: gen Count=_n
by DealerTIN TaxQuarter: gen TotalCount=_N
tab TotalCount if Count==1
drop if Count!=1

drop NotInUse ReasonDirectEntry TeamId DateOfAssignment TeamAssignedBy PlaceAudit NoticeGeneratedBy Status LastActionStatus LastActionDate ParentNoticeId Remarks Name Action DateReschedule T678DF1 T678DF2 T678DF3 T678DF4 T678DF5 T678DF6 T678df7 T678DF8 T678DF9 T678020 T678D10 Count TotalCount

save "F:\2a2b_analysis\AuditNoticesQuarterly.dta"
