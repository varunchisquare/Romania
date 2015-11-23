use romania;

drop table romania.frm_F_DailyXchangeRates;
Create table romania.frm_F_DailyXchangeRates(
SummaryDate date,
CurrencyCode varchar(20),
XchangeRate double(24,18)
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

select StatsDate,CurrencyCode,Avg(CurrencyRate) from romania.c_daily_stats
group by StatsDate,CurrencyCode
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\frm_F_DailyXchangeRates.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\frm_F_DailyXchangeRates.csv'
INTO TABLE romania.frm_F_DailyXchangeRates
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

drop table romania.Merge_aggregates;
Create table romania.Merge_aggregates (	
SummaryDate	datetime,
categry	varchar(200),
cust_id	int(10),
cust_username	varchar(50),
CurrencyCode varchar(20),
channel_name	varchar(200),
sport_name	varchar(200),
class_name	varchar(200),
type_name	varchar(200),
bet_type	varchar(50),
is_inplay	varchar(50),
Totalbet	decimal(18,6),
cashBet	decimal(18,6),
cashoutBet	decimal(18,6),
bonusBet	decimal(18,6),
betCount	int(10),
num_lines	int(10),
totalWin	decimal(18,6),
CashWin	decimal(18,6),
CashOutWin	decimal(18,6),
BonusWin	decimal(18,6),
Profit	decimal(18,6),
DepositCnt	int(5),
DepositAmt	decimal(18,6),
WithdrawCnt	int(5),
WithdrawAmt	decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

select 
settled_date SummaryDate,
'Sports' categry, 
cust_id,
cust_username, 
'USD',
channel_name, 
sport_name, 
class_name, 
type_name, 
sgl_mult_bet_types_name, 
is_inplay, 
cast(sum(total_stake_bccy) as decimal(18,6)) Totalbet, 
cast(sum(cash_stake_bccy) as decimal(18,6)) cashBet, 
cast(sum(cash_out_stake_bccy) as decimal(18,6)) cashoutBet,
cast(sum(bonus_stake_bccy+bonus_bal_stake_bccy) as decimal(18,6)) bonusBet, 
cast(sum(num_bets) as decimal(18,6)) betCount, 
cast(sum(num_lines) as decimal(18,6)) num_lines, 
cast(sum(cash_winnings_bccy+cash_out_win_bccy+bonus_winnings_bccy) as decimal(18,6)) totalWin, 
cast(sum(cash_winnings_bccy) as decimal(18,6)) CashWin, 
cast(sum(cash_out_win_bccy) as decimal(18,6)) CashOutWin, 
cast(sum(bonus_winnings_bccy) as decimal(18,6)) BonusWin,
cast(sum(combined_profit_bccy) as decimal(18,6)) profit,
cast(0.0 as decimal(18,6)) DepositCnt,
cast(0.0 as decimal(18,6)) DepositAmt,
cast(0.0 as decimal(18,6)) WithdrawCnt,
cast(0.0 as decimal(18,6)) WithdrawAmt
from romania.s_customer_pnl
#where cust_username='entonimobposron2'
where (total_stake_bccy !=0 or cash_stake_bccy!=0 or cash_out_stake_bccy!=0 or bonus_stake_bccy!=0 or bonus_bal_stake_bccy!=0
or num_bets!=0 or num_lines!=0 or cash_winnings_bccy!=0 or cash_out_win_bccy!=0 or bonus_winnings_bccy!=0 or cash_winnings_bccy!=0 
or cash_out_win_bccy!=0 or bonus_winnings_bccy!=0 or combined_profit_bccy)
group by date(settled_date), cust_id, channel_name,cust_username, 
sport_name, class_name, type_name, sgl_mult_bet_types_name,is_inplay
union all
select 
StatsDate, 
'Casino' categry,
PlayerCode,
sp.username, 
sp.CurrencyCode,
concat(p.ClientType,' ',p.ClientPlatform) channel_name, 
'N/A' sport_name,
'N/A' class_name,
'N/A' type_name, 
'slots' sgl_mult_bet_types_name,
'Y' is_inplay,
cast(sum(BETS) as decimal(18,6)) TotalBet,
cast(sum(BETS-BONUSBET) as decimal(18,6)) cashBet, 
cast(0.0 as decimal(18,6)) CashoutBet,
cast(sum(BONUSBET) as decimal(18,6)) BonusBet,
cast(sum(GAMECOUNT) as decimal(18,6)) betCount, 
cast(0.0 as decimal(18,6)) num_lines,
cast(Sum(WINS) as decimal(18,6)) TotalWin,
cast(Sum(WINS-BONUSWIN) as decimal(18,6)) cashWin, 
cast(0.0 as decimal(18,6)) CashoutWin,
cast(sum(BONUSWIN) as decimal(18,6)) BonusWin,
cast(sum(Bets-WINS) as decimal(18,6)) profit ,
cast(sum(DEPOSITCOUNT) as decimal(18,6)) DepositCnt,
cast(sum(DEPOSITS) as decimal(18,6)) DepositAmt,
cast(sum(WITHDRAWCOUNT) as decimal(18,6)) WithdrawCnt,
cast(sum(WITHDRAWS) as decimal(18,6)) WithdrawAmt
from romania.c_daily_stats ds
join romania.c_player sp on ds.playercode = sp.code
join romania.c_client_parameter p on p.code = ds.ClientparameterCode
where ds.CasinoCode is not null
#and sp.username='entonimobposron2'
and (BETS !=0 or BONUSBET!=0 or GAMECOUNT !=0 or WINS !=0 and BONUSWIN != 0 or DEPOSITCOUNT !=0 or DEPOSITS!=0 or WITHDRAWCOUNT!=0 or WITHDRAWS!=0)
group by date(StatsDate),PlayerCode,sp.username,concat(p.ClientType,' ',p.ClientPlatform),sp.CurrencyCode
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\merge.csv'
FIELDS TERMINATED BY '|' 
ENCLOSED BY 'NULL'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\merge.csv' 
INTO TABLE romania.Merge_aggregates
FIELDS TERMINATED BY '|' 
ENCLOSED BY 'NULL'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select magg.summarydate, magg.cust_username,pl.CurrencyCode,
date(pl.GlobalFirstDepositDate) ftd,magg.categry,magg.channel_name,
magg.bet_type,magg.is_inplay,
sum(magg.Totalbet)*dx.XchangeRate Totalbet,
sum(magg.cashBet)*dx.XchangeRate CashBet,
sum(magg.cashoutBet)*dx.XchangeRate CashoutBet,
sum(magg.BonusBet)*dx.XchangeRate BonusBet,
sum(magg.betCount)*dx.XchangeRate betCount,
sum(magg.num_lines)*dx.XchangeRate num_lines,
sum(magg.totalWin)*dx.XchangeRate totalWin,
sum(magg.CashWin)*dx.XchangeRate CashWin,
sum(magg.CashOutWin)*dx.XchangeRate CashOutWin,
sum(magg.BonusWin)*dx.XchangeRate BonusWin,
sum(magg.profit)*dx.XchangeRate GGR,
#sum(magg.Bonus)*dx.XchangeRate Bonus,
sum(magg.profit-(magg.BonusBet+magg.BonusWin))*dx.XchangeRate NGR,
sum(magg.profit-(magg.BonusBet-magg.BonusWin)-((0.2)*magg.profit))*dx.XchangeRate GrossProfit,
sum(magg.DepositCnt) DepositCnt,
sum(magg.DepositAmt)*dx.XchangeRate DepositAmt,
sum(magg.WithdrawCnt) WithdrawCnt,
sum(magg.WithdrawAmt)*dx.XchangeRate WithdrawAmt,
dx.summarydate
from romania.merge_aggregates magg 
left outer join romania.c_player pl on magg.cust_username = pl.username
left outer join romania.frm_F_DailyXchangeRates dx on date(magg.summarydate) = dx.summarydate and pl.CurrencyCode = dx.CurrencyCode
group by magg.summarydate, date(pl.GlobalFirstDepositDate),magg.cust_username,
magg.categry,magg.channel_name,magg.bet_type,magg.is_inplay,dx.summarydate
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\SPdailyTxn.csv'
FIELDS TERMINATED BY '|' 
ENCLOSED BY 'NULL'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

Drop table romania.frm_ft_Sports_txn;
create table romania.frm_ft_Sports_txn(
SummaryDate datetime,
CustName varchar(200),
CurrencyCode varchar(200),
FTD date,
category varchar(200),
channel varchar(200),
betType varchar(200),
is_inplay varchar(20),
TotalBet decimal(18,6),
CashBet decimal(18,6),
CashoutBet decimal(18,6),
BonusBet decimal(18,6),
BetCount decimal(18,6),
Num_lines int(5),
TotalWin decimal(18,6),
CashWin decimal(18,6),
CashoutWin decimal(18,6),
BonusWin decimal(18,6),
GGR decimal(18,6),
#Bonus decimal(18,6),
NGR decimal(18,6),
GrossProfit decimal(18,6),
DepositCnt int(5),
DepositAmt decimal(18,6),
WithdrawCnt int(5),
WithdrawAmt decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\SPdailyTxn.csv' 
INTO TABLE romania.frm_ft_Sports_txn
FIELDS TERMINATED BY '|' 
ENCLOSED BY 'NULL'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select date(SummaryDate),Custname,category,channel,date(p.GlobalFirstDepositDate) ftd, sum(Totalbet) Totalbet,sum(totalWin) totalWin,sum(Totalbet-totalWin) GGR,sum((Totalbet-totalWin)*0.2) TAX,
sum(Totalbet-totalWin-(BonusBet-BonusWin)-(Totalbet-totalWin)*0.2) NGW,
sum(Totalbet-totalWin-(BonusBet-BonusWin)) NGR,sum(DepositAmt) DepositAmt,sum(WithdrawAmt) WithdrawAmt
from romania.frm_ft_Sports_txn tx join romania.c_player p on tx.Custname = p.username
group by date(SummaryDate),category,Custname,date(p.GlobalFirstDepositDate),channel
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\DailyKPI.csv'
FIELDS TERMINATED BY '|' 
ENCLOSED BY 'NULL'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

Drop table romania.frm_ft_DailyKPI;
create table romania.frm_ft_DailyKPI(
SummaryDate date,
CustName varchar(200),
GameType varchar(200),
channel varchar(200),
FTD Date,
TotalBet decimal(18,6),
TotalWin decimal(18,6),
GGR decimal(18,6),
TAX decimal(18,6),
NGW decimal(18,6),
NGR decimal(18,6),
DepositAmt decimal(18,6),
WithdrawAmt decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\DailyKPI.csv' 
INTO TABLE romania.frm_ft_DailyKPI
FIELDS TERMINATED BY '|' 
ENCLOSED BY 'NULL'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
