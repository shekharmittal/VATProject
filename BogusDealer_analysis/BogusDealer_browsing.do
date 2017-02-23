// In this file I save the code that I used to try and understand the behavior of Fraud firms

br if SecondBogusDummy==1&TaxCreditBeforeAdjustment>2500000
br if SecondBogusDummy==1&TaxCreditBeforeAdjustment>2500000&TaxQuarter>15
br if DealerTIN=="113752"


sum MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal NetTax OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment if SecondBogusDummy==0&TaxCreditBeforeAdjustment>2500000&TaxQuarter>15
sum MoneyDeposited TurnoverGross TurnoverCentral TurnoverLocal NetTax OutputTaxBeforeAdjustment TaxCreditBeforeAdjustment if SecondBogusDummy==1&TaxCreditBeforeAdjustment>2500000&TaxQuarter>15


tab max_stat_min if SecondBogusDummy==1&TaxCreditBeforeAdjustment>2500000&TaxQuarter>15
tab max_stat_min if SecondBogusDummy==0&TaxCreditBeforeAdjustment>2500000&TaxQuarter>15



drop T312002 PeriodBegin PeriodEnd T312011 T312012 T312013 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 TDSCertificates ApprovalDate Status AcknowledgementNumber T312149 T312150 T312151


/* Analysis to look at what is going on with Firms which only interact with bogus firms*/
drop _merge
merge 1:1 DealerTIN TaxQuarter using "H:\BogusDealer_analysis\FishyBogusDealers"



bys SourceFile: sum ProportionTransactionWithBogus if TransactionCount==1&BogusDummy==0, detail
bys SourceFile: sum ProportionTransactionWithBogus if TransactionCount==1&BogusDummy==0&ProportionTransactionWithBogus>0, detail
bys SourceFile: sum ProportionTransactionWithBogus if TransactionCount==1&BogusDummy==0&ProportionTransactionWithBogus>.5, detail
