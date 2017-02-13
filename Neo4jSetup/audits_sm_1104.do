use "F:\data\form37_data_auditnotice.dta", clear

replace DealerTIN=trim(DealerTIN)
drop if DealerTIN==""
drop DateOfAssignment TeamAssignedBy NotInUse ReasonDirectEntry LastActionTakenBy LastActionStatus NoticeGeneratedBy LastActionDate Name ParentNoticeId Action DateReschedule T678DF5 T678DF6 Remarks T678DF9 T678DF8

/* On the returns file
list T312002 DealerTIN if (T312002=="7022007682"&Count==1)|(T312002=="7030391123"&Count==1)|(T312002=="7030399659"&Count==1)|(T312002=="7032003748"&Count==1)|(T312002=="7042002336"&Count==1)|(T312002=="7060328396"&Count==1)|(T312002=="7062001646"&Count==1)|(T312002=="7062002907"&Count==1)|(T312002=="7070210875"&Count==1)|(T312002=="7070266941"&Count==1)|(T312002=="7070315247"&Count==1)|(T312002=="7070382565"&Count==1)|(T312002=="7080124200"&Count==1)|(T312002=="7092000029"&Count==1)|(T312002=="7102001430"&Count==1)|(T312002=="7120277826"&Count==1)|(T312002=="7120357366"&Count==1)|(T312002=="7120412074"&Count==1)|(T312002=="7130249545"&Count==1)|(T312002=="7132002820"&Count==1)|(T312002=="7132006215"&Count==1)|(T312002=="7140322726"&Count==1)|(T312002=="7150302302"&Count==1)|(T312002=="7152001063"&Count==1)|(T312002=="7160032685"&Count==1)|(T312002=="7170250590"&Count==1)|(T312002=="7190247184"&Count==1)|(T312002=="7220259535"&Count==1)|(T312002=="7220338590"&Count==1)|(T312002=="7220379039"&Count==1)|(T312002=="7222008930"&Count==1)|(T312002=="7230237074"&Count==1)|(T312002=="7230264137"&Count==1)|(T312002=="7240206756"&Count==1)|(T312002=="7240213837"&Count==1)|(T312002=="7242002808"&Count==1)|(T312002=="7270360339"&Count==1)|(T312002=="7272000027"&Count==1)|(T312002=="7290364305"&Count==1)|(T312002=="7292009425"&Count==1)|(T312002=="7300282771"&Count==1)|(T312002=="7310112288"&Count==1)|(T312002=="7320295952"&Count==1)|(T312002=="7320370448"&Count==1)|(T312002=="7330116254"&Count==1)|(T312002=="7330173290"&Count==1)|(T312002=="7330267283"&Count==1)|(T312002=="7332000188"&Count==1)|(T312002=="7340330376"&Count==1)|(T312002=="7340333286"&Count==1)|(T312002=="7342000425"&Count==1)|(T312002=="7342001007"&Count==1)|(T312002=="7350231382"&Count==1)|(T312002=="7352011526"&Count==1)|(T312002=="7370118560"&Count==1)|(T312002=="7372001136"&Count==1)|(T312002=="7390317496"&Count==1)|(T312002=="7390377345"&Count==1)|(T312002=="7392005296"&Count==1)|(T312002=="7402008055"&Count==1)|(T312002=="7410256957"&Count==1)|(T312002=="7412002860"&Count==1)|(T312002=="7420116059"&Count==1)|(T312002=="7430265385"&Count==1)|(T312002=="7442003086"&Count==1)|(T312002=="7452011471"&Count==1)|(T312002=="7462003366"&Count==1)|(T312002=="7480349505"&Count==1)|(T312002=="7482000154"&Count==1)|(T312002=="7500276162"&Count==1)|(T312002=="7512008916"&Count==1)|(T312002=="7520015997"&Count==1)|(T312002=="7520209415"&Count==1)|(T312002=="7520369562"&Count==1)|(T312002=="7530230216"&Count==1)|(T312002=="7532001339"&Count==1)|(T312002=="7542002837"&Count==1)|(T312002=="7542007105"&Count==1)|(T312002=="7550344471"&Count==1)|(T312002=="7580356628"&Count==1)|(T312002=="7590081967"&Count==1)|(T312002=="7590302545"&Count==1)|(T312002=="7600301036"&Count==1)|(T312002=="7600315586"&Count==1)|(T312002=="7622012687"&Count==1)|(T312002=="7630300486"&Count==1)|(T312002=="7640343597"&Count==1)|(T312002=="7640408490"&Count==1)|(T312002=="7650335880"&Count==1)|(T312002=="7680339113"&Count==1)|(T312002=="7702004204"&Count==1)|(T312002=="7702010994"&Count==1)|(T312002=="7710375229"&Count==1)|(T312002=="7720363923"&Count==1)|(T312002=="7720383129"&Count==1)|(T312002=="7720394769"&Count==1)|(T312002=="7732013257"&Count==1)|(T312002=="7740276224"&Count==1)|(T312002=="7740294848"&Count==1)|(T312002=="7762001746"&Count==1)|(T312002=="7772004214"&Count==1)|(T312002=="7782001347"&Count==1)|(T312002=="7790074000"&Count==1)|(T312002=="7810246164"&Count==1)|(T312002=="7812000215"&Count==1)|(T312002=="7820198580"&Count==1)|(T312002=="7830253622"&Count==1)|(T312002=="7840313902"&Count==1)|(T312002=="7842010723"&Count==1)|(T312002=="7890333032"&Count==1)|(T312002=="7900173122"&Count==1)|(T312002=="7902000214"&Count==1)|(T312002=="7912005689"&Count==1)|(T312002=="7920267686"&Count==1)|(T312002=="7940317048"&Count==1)|(T312002=="7950018040"&Count==1)|(T312002=="7950344445"&Count==1)|(T312002=="7960339347"&Count==1)|(T312002=="7962003091"&Count==1)|(T312002=="7970394680"&Count==1)|(T312002=="7972004783"&Count==1)|(T312002=="7972009924"&Count==1)
*/

gen changeDealerTIN=0
replace changeDealerTIN=1 if DealerTIN=="7022007682"
replace changeDealerTIN=1 if DealerTIN=="7030391123"
replace changeDealerTIN=1 if DealerTIN=="7030399659"
replace changeDealerTIN=1 if DealerTIN=="7032003748"
replace changeDealerTIN=1 if DealerTIN=="7042002336"
replace changeDealerTIN=1 if DealerTIN=="7060328396"
replace changeDealerTIN=1 if DealerTIN=="7062001646"
replace changeDealerTIN=1 if DealerTIN=="7062002907"
replace changeDealerTIN=1 if DealerTIN=="7070210875"
replace changeDealerTIN=1 if DealerTIN=="7070266941"
replace changeDealerTIN=1 if DealerTIN=="7070315247"
replace changeDealerTIN=1 if DealerTIN=="7070382565"
replace changeDealerTIN=1 if DealerTIN=="7080124200"
replace changeDealerTIN=1 if DealerTIN=="7092000029"
replace changeDealerTIN=1 if DealerTIN=="7102001430"
replace changeDealerTIN=1 if DealerTIN=="7120277826"
replace changeDealerTIN=1 if DealerTIN=="7120357366"
replace changeDealerTIN=1 if DealerTIN=="7120412074"
replace changeDealerTIN=1 if DealerTIN=="7130249545"
replace changeDealerTIN=1 if DealerTIN=="7132002820"
replace changeDealerTIN=1 if DealerTIN=="7132006215"
replace changeDealerTIN=1 if DealerTIN=="7140322726"
replace changeDealerTIN=1 if DealerTIN=="7150302302"
replace changeDealerTIN=1 if DealerTIN=="7152001063"
replace changeDealerTIN=1 if DealerTIN=="7160032685"
replace changeDealerTIN=1 if DealerTIN=="7170250590"
replace changeDealerTIN=1 if DealerTIN=="7190247184"
replace changeDealerTIN=1 if DealerTIN=="7220259535"
replace changeDealerTIN=1 if DealerTIN=="7220338590"
replace changeDealerTIN=1 if DealerTIN=="7220379039"
replace changeDealerTIN=1 if DealerTIN=="7222008930"
replace changeDealerTIN=1 if DealerTIN=="7230237074"
replace changeDealerTIN=1 if DealerTIN=="7230264137"
replace changeDealerTIN=1 if DealerTIN=="7240206756"
replace changeDealerTIN=1 if DealerTIN=="7240213837"
replace changeDealerTIN=1 if DealerTIN=="7242002808"
replace changeDealerTIN=1 if DealerTIN=="7270360339"
replace changeDealerTIN=1 if DealerTIN=="7272000027"
replace changeDealerTIN=1 if DealerTIN=="7290364305"
replace changeDealerTIN=1 if DealerTIN=="7292009425"
replace changeDealerTIN=1 if DealerTIN=="7300282771"
replace changeDealerTIN=1 if DealerTIN=="7310112288"
replace changeDealerTIN=1 if DealerTIN=="7320295952"
replace changeDealerTIN=1 if DealerTIN=="7320370448"
replace changeDealerTIN=1 if DealerTIN=="7330116254"
replace changeDealerTIN=1 if DealerTIN=="7330173290"
replace changeDealerTIN=1 if DealerTIN=="7330267283"
replace changeDealerTIN=1 if DealerTIN=="7332000188"
replace changeDealerTIN=1 if DealerTIN=="7340330376"
replace changeDealerTIN=1 if DealerTIN=="7340333286"
replace changeDealerTIN=1 if DealerTIN=="7342000425"
replace changeDealerTIN=1 if DealerTIN=="7342001007"
replace changeDealerTIN=1 if DealerTIN=="7350231382"
replace changeDealerTIN=1 if DealerTIN=="7352011526"
replace changeDealerTIN=1 if DealerTIN=="7370118560"
replace changeDealerTIN=1 if DealerTIN=="7372001136"
replace changeDealerTIN=1 if DealerTIN=="7390317496"
replace changeDealerTIN=1 if DealerTIN=="7390377345"
replace changeDealerTIN=1 if DealerTIN=="7392005296"
replace changeDealerTIN=1 if DealerTIN=="7402008055"
replace changeDealerTIN=1 if DealerTIN=="7410256957"
replace changeDealerTIN=1 if DealerTIN=="7412002860"
replace changeDealerTIN=1 if DealerTIN=="7420116059"
replace changeDealerTIN=1 if DealerTIN=="7430265385"
replace changeDealerTIN=1 if DealerTIN=="7442003086"
replace changeDealerTIN=1 if DealerTIN=="7452011471"
replace changeDealerTIN=1 if DealerTIN=="7462003366"
replace changeDealerTIN=1 if DealerTIN=="7480349505"
replace changeDealerTIN=1 if DealerTIN=="7482000154"
replace changeDealerTIN=1 if DealerTIN=="7500276162"
replace changeDealerTIN=1 if DealerTIN=="7512008916"
replace changeDealerTIN=1 if DealerTIN=="7520015997"
replace changeDealerTIN=1 if DealerTIN=="7520209415"
replace changeDealerTIN=1 if DealerTIN=="7520369562"
replace changeDealerTIN=1 if DealerTIN=="7530230216"
replace changeDealerTIN=1 if DealerTIN=="7532001339"
replace changeDealerTIN=1 if DealerTIN=="7542002837"
replace changeDealerTIN=1 if DealerTIN=="7542007105"
replace changeDealerTIN=1 if DealerTIN=="7550344471"
replace changeDealerTIN=1 if DealerTIN=="7580356628"
replace changeDealerTIN=1 if DealerTIN=="7590081967"
replace changeDealerTIN=1 if DealerTIN=="7590302545"
replace changeDealerTIN=1 if DealerTIN=="7600301036"
replace changeDealerTIN=1 if DealerTIN=="7600315586"
replace changeDealerTIN=1 if DealerTIN=="7622012687"
replace changeDealerTIN=1 if DealerTIN=="7630300486"
replace changeDealerTIN=1 if DealerTIN=="7640343597"
replace changeDealerTIN=1 if DealerTIN=="7640408490"
replace changeDealerTIN=1 if DealerTIN=="7650335880"
replace changeDealerTIN=1 if DealerTIN=="7680339113"
replace changeDealerTIN=1 if DealerTIN=="7702004204"
replace changeDealerTIN=1 if DealerTIN=="7702010994"
replace changeDealerTIN=1 if DealerTIN=="7710375229"
replace changeDealerTIN=1 if DealerTIN=="7720363923"
replace changeDealerTIN=1 if DealerTIN=="7720383129"
replace changeDealerTIN=1 if DealerTIN=="7720394769"
replace changeDealerTIN=1 if DealerTIN=="7732013257"
replace changeDealerTIN=1 if DealerTIN=="7740276224"
replace changeDealerTIN=1 if DealerTIN=="7740294848"
replace changeDealerTIN=1 if DealerTIN=="7762001746"
replace changeDealerTIN=1 if DealerTIN=="7772004214"
replace changeDealerTIN=1 if DealerTIN=="7782001347"
replace changeDealerTIN=1 if DealerTIN=="7790074000"
replace changeDealerTIN=1 if DealerTIN=="7810246164"
replace changeDealerTIN=1 if DealerTIN=="7812000215"
replace changeDealerTIN=1 if DealerTIN=="7820198580"
replace changeDealerTIN=1 if DealerTIN=="7830253622"
replace changeDealerTIN=1 if DealerTIN=="7840313902"
replace changeDealerTIN=1 if DealerTIN=="7842010723"
replace changeDealerTIN=1 if DealerTIN=="7890333032"
replace changeDealerTIN=1 if DealerTIN=="7900173122"
replace changeDealerTIN=1 if DealerTIN=="7902000214"
replace changeDealerTIN=1 if DealerTIN=="7912005689"
replace changeDealerTIN=1 if DealerTIN=="7920267686"
replace changeDealerTIN=1 if DealerTIN=="7940317048"
replace changeDealerTIN=1 if DealerTIN=="7950018040"
replace changeDealerTIN=1 if DealerTIN=="7950344445"
replace changeDealerTIN=1 if DealerTIN=="7960339347"
replace changeDealerTIN=1 if DealerTIN=="7962003091"
replace changeDealerTIN=1 if DealerTIN=="7970394680"
replace changeDealerTIN=1 if DealerTIN=="7972004783"
replace changeDealerTIN=1 if DealerTIN=="7972009924"


replace DealerTIN="10259" if DealerTIN=="7030399659"
replace DealerTIN="11079" if DealerTIN=="7032003748"
replace DealerTIN="111232" if DealerTIN=="7220259535"
replace DealerTIN="111973" if DealerTIN=="7220338590"
replace DealerTIN="112372" if DealerTIN=="7220379039"
replace DealerTIN="113434" if DealerTIN=="7222008930"
replace DealerTIN="116394" if DealerTIN=="7230237074"
replace DealerTIN="116657" if DealerTIN=="7230264137"
replace DealerTIN="121446" if DealerTIN=="7240206756"
replace DealerTIN="121517" if DealerTIN=="7240213837"
replace DealerTIN="124135" if DealerTIN=="7242002808"
replace DealerTIN="139093" if DealerTIN=="7270360339"
replace DealerTIN="140281" if DealerTIN=="7272000027"
replace DealerTIN="149894" if DealerTIN=="7290364305"
replace DealerTIN="151100" if DealerTIN=="7292009425"
replace DealerTIN="154537" if DealerTIN=="7300282771"
replace DealerTIN="158248" if DealerTIN=="7310112288"
replace DealerTIN="16438" if DealerTIN=="7042002336"
replace DealerTIN="165438" if DealerTIN=="7320295952"
replace DealerTIN="166161" if DealerTIN=="7320370448"
replace DealerTIN="169079" if DealerTIN=="7330116254"
replace DealerTIN="169640" if DealerTIN=="7330173290"
replace DealerTIN="170587" if DealerTIN=="7330267283"
replace DealerTIN="172648" if DealerTIN=="7332000188"
replace DealerTIN="176523" if DealerTIN=="7340330376"
replace DealerTIN="176552" if DealerTIN=="7340333286"
replace DealerTIN="178015" if DealerTIN=="7342000425"
replace DealerTIN="178021" if DealerTIN=="7342001007"
replace DealerTIN="181015" if DealerTIN=="7350231382"
replace DealerTIN="183509" if DealerTIN=="7352011526"
replace DealerTIN="190717" if DealerTIN=="7370118560"
replace DealerTIN="194246" if DealerTIN=="7372001136"
replace DealerTIN="203397" if DealerTIN=="7390317496"
replace DealerTIN="203991" if DealerTIN=="7390377345"
replace DealerTIN="205044" if DealerTIN=="7392005296"
replace DealerTIN="210478" if DealerTIN=="7402008055"
replace DealerTIN="213646" if DealerTIN=="7410256957"
replace DealerTIN="215818" if DealerTIN=="7412002860"
replace DealerTIN="217613" if DealerTIN=="7420116059"
replace DealerTIN="231943" if DealerTIN=="7442003086"
replace DealerTIN="237421" if DealerTIN=="7452011471"
replace DealerTIN="242726" if DealerTIN=="7462003366"
replace DealerTIN="252192" if DealerTIN=="7480349505"
replace DealerTIN="253489" if DealerTIN=="7482000154"
replace DealerTIN="25641" if DealerTIN=="7060328396"
replace DealerTIN="262315" if DealerTIN=="7500276162"
replace DealerTIN="269725" if DealerTIN=="7512008916"
replace DealerTIN="270840" if DealerTIN=="7520015997"
replace DealerTIN="27150" if DealerTIN=="7062001646"
replace DealerTIN="27159" if DealerTIN=="7062002907"
replace DealerTIN="272449" if DealerTIN=="7520209415"
replace DealerTIN="273989" if DealerTIN=="7520369562"
replace DealerTIN="278058" if DealerTIN=="7530230216"
replace DealerTIN="280497" if DealerTIN=="7532001339"
replace DealerTIN="285921" if DealerTIN=="7542007105"
replace DealerTIN="289884" if DealerTIN=="7550344471"
replace DealerTIN="29895" if DealerTIN=="7070210875"
replace DealerTIN="30454" if DealerTIN=="7070266941"
replace DealerTIN="306140" if DealerTIN=="7580356628"
replace DealerTIN="309004" if DealerTIN=="7590081967"
replace DealerTIN="310983" if DealerTIN=="7590302545"
replace DealerTIN="31554" if DealerTIN=="7070382565"
replace DealerTIN="316364" if DealerTIN=="7600301036"
replace DealerTIN="316492" if DealerTIN=="7600315586"
replace DealerTIN="338322" if DealerTIN=="7640343597"
replace DealerTIN="338967" if DealerTIN=="7640408490"
replace DealerTIN="343630" if DealerTIN=="7650335880"
replace DealerTIN="34405" if DealerTIN=="7080124200"
replace DealerTIN="371993" if DealerTIN=="7702004204"
replace DealerTIN="372038" if DealerTIN=="7702010994"
replace DealerTIN="376280" if DealerTIN=="7710375229"
replace DealerTIN="381569" if DealerTIN=="7720363923"
replace DealerTIN="381761" if DealerTIN=="7720383129"
replace DealerTIN="381873" if DealerTIN=="7720394769"
replace DealerTIN="388192" if DealerTIN=="7732013257"
replace DealerTIN="391519" if DealerTIN=="7740276224"
replace DealerTIN="391666" if DealerTIN=="7740294848"
replace DealerTIN="404266" if DealerTIN=="7762001746"
replace DealerTIN="409671" if DealerTIN=="7772004214"
replace DealerTIN="415023" if DealerTIN=="7782001347"
replace DealerTIN="416646" if DealerTIN=="7790074000"
replace DealerTIN="428914" if DealerTIN=="7810246164"
replace DealerTIN="431173" if DealerTIN=="7812000215"
replace DealerTIN="433796" if DealerTIN=="7820198580"
replace DealerTIN="439752" if DealerTIN=="7830253622"
replace DealerTIN="445665" if DealerTIN=="7840313902"
replace DealerTIN="447372" if DealerTIN=="7842010723"
replace DealerTIN="472762" if DealerTIN=="7890333032"
replace DealerTIN="476601" if DealerTIN=="7900173122"
replace DealerTIN="479602" if DealerTIN=="7902000214"
replace DealerTIN="485027" if DealerTIN=="7912005689"
replace DealerTIN="48696" if DealerTIN=="7102001430"
replace DealerTIN="488340" if DealerTIN=="7920267686"
replace DealerTIN="499574" if DealerTIN=="7940317048"
replace DealerTIN="502349" if DealerTIN=="7950018040"
replace DealerTIN="505212" if DealerTIN=="7950344445"
replace DealerTIN="510585" if DealerTIN=="7960339347"
replace DealerTIN="511997" if DealerTIN=="7962003091"
replace DealerTIN="516512" if DealerTIN=="7970394680"
replace DealerTIN="517391" if DealerTIN=="7972004783"
replace DealerTIN="517427" if DealerTIN=="7972009924"
replace DealerTIN="523996" if DealerTIN=="7030391123"
replace DealerTIN="531483" if DealerTIN=="7542002837"
replace DealerTIN="532767" if DealerTIN=="7630300486"
replace DealerTIN="538371" if DealerTIN=="7070315247"
replace DealerTIN="538472" if DealerTIN=="7092000029"
replace DealerTIN="538603" if DealerTIN=="7130249545"
replace DealerTIN="5747" if DealerTIN=="7022007682"
replace DealerTIN="57537" if DealerTIN=="7120277826"
replace DealerTIN="58277" if DealerTIN=="7120357366"
replace DealerTIN="58820" if DealerTIN=="7120412074"
replace DealerTIN="64899" if DealerTIN=="7132002820"
replace DealerTIN="64924" if DealerTIN=="7132006215"
replace DealerTIN="68699" if DealerTIN=="7140322726"
replace DealerTIN="73939" if DealerTIN=="7150302302"
replace DealerTIN="75687" if DealerTIN=="7152001063"
replace DealerTIN="76957" if DealerTIN=="7160032685"
replace DealerTIN="84215" if DealerTIN=="7170250590"
replace DealerTIN="94963" if DealerTIN=="7190247184"

gen dummy=1
gsort DealerTIN -DateActualNotice
by DealerTIN:egen Count=sum(dummy)

gen NoticeDate=dofc(DateActualNotice)
format %td NoticeDate //change it into date format

replace NoticeDate=dofc(T678DF3) if DateActualNotice==.

*gen CancellationYear2=dofc(T678DF3)
*format %td CancellationYear2 //change it into date format

gen NoticeYear=yofd(NoticeDate)
gen NoticeMonth=mofd(NoticeDate)

format %tm NoticeMonth
format %ty NoticeYear //Changing the format to appropriate year form

replace NoticeMonth=NoticeMonth-599

gen NoticeQuarter=0
replace NoticeQuarter=1 if NoticeMonth>3&NoticeMonth<=6
replace NoticeQuarter=2 if NoticeMonth>6&NoticeMonth<=9
replace NoticeQuarter=3 if NoticeMonth>9&NoticeMonth<=12
replace NoticeQuarter=4 if NoticeMonth>12&NoticeMonth<=15
replace NoticeQuarter=5 if NoticeMonth>15&NoticeMonth<=18
replace NoticeQuarter=6 if NoticeMonth>18&NoticeMonth<=21
replace NoticeQuarter=7 if NoticeMonth>21&NoticeMonth<=24
replace NoticeQuarter=8 if NoticeMonth>24&NoticeMonth<=27
replace NoticeQuarter=9 if NoticeMonth>27&NoticeMonth<=30
replace NoticeQuarter=10 if NoticeMonth>30&NoticeMonth<=33
replace NoticeQuarter=11 if NoticeMonth>33&NoticeMonth<=36
replace NoticeQuarter=12 if NoticeMonth>36&NoticeMonth<=39
replace NoticeQuarter=13 if NoticeMonth>39&NoticeMonth<=42
replace NoticeQuarter=14 if NoticeMonth>42&NoticeMonth<=45
replace NoticeQuarter=15 if NoticeMonth>45&NoticeMonth<=48
replace NoticeQuarter=16 if NoticeMonth>48&NoticeMonth<=51
replace NoticeQuarter=17 if NoticeMonth>51&NoticeMonth<=54
replace NoticeQuarter=18 if NoticeMonth>54&NoticeMonth<=57
replace NoticeQuarter=19 if NoticeMonth>57&NoticeMonth<=60
replace NoticeQuarter=20 if NoticeMonth>60&NoticeMonth<=63
replace NoticeQuarter=21 if NoticeMonth>63&NoticeMonth<=66
replace NoticeQuarter=22 if NoticeMonth>66&NoticeMonth<=69


drop Count
gsort DealerTIN NoticeQuarter -DateActualNotice
by DealerTIN NoticeQuarter:gen Count=_n
keep if Count==1
drop Count
egen idAudit=group(DealerTIN NoticeQuarter)
rename variable idAudit "unique id created for Neo4j"
label variable idAudit "unique id created for Neo4j"

save "F:\data\audit\audit_cleaned_1104_neo4j.dta"
export delimited using "F:\csv\audit\audit_1104.csv", delimiter("|") replace


