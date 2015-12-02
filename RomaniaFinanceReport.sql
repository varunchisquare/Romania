--Report1: Customer Withdrawals:
select date(AcceptDate) 'Data of transaction', null as 'Transaction details',null 'BENEFICIAR_PLATITOR',
CASHIERTRANID as 'No / code of transaction', 
case METHOD when 'CASH' then 'CASH' else 'CARD' end as 'Type of transaction',
CurrencyCode as 'CreditCurrencyCode', sum(amount) 'CreditValue', 'n/a' as 'CreditExchangeRate', sum(bc_amount) as 'EquivalentPostingValue',
PlayerCode as 'Partner',null 'Partner_Code',
case clientType when 'casino' then 'online gaming' when 'sportsbook' then 'online bet' else clientType end as 'Cod center'
from romania.c_player_payment pp
left outer join romania.c_player pl on pl.code = pp.playercode
where status = 'approved' and type = 'withdraw'
group by date(AcceptDate),CASHIERTRANID,
case METHOD when 'CASH' then 'CASH' else 'CARD' end,
CurrencyCode,PlayerCode,
case clientType when 'casino' then 'online gaming' when 'sportsbook' then 'online bet' else clientType end;

--Report 2: Customer Deposits 
select date(AcceptDate) 'Data of transaction', null as 'Transaction details',null 'BENEFICIAR_PLATITOR',
CASHIERTRANID as 'No / code of transaction', 
case METHOD when 'CASH' then 'CASH' else 'CARD' end as 'Type of transaction',
CurrencyCode as 'CreditCurrencyCode', sum(amount) as 'CreditValue', 'n/a' as 'CreditExchangeRate', sum(bc_amount) as 'EquivalentPostingValue',
PlayerCode as 'Partner',null 'Partner_Code',
case clientType when 'casino' then 'online gaming' when 'sportsbook' then 'online bet' else clientType end as 'Cod center'
from romania.c_player_payment pp
left outer join romania.c_player pl on pl.code = pp.playercode
where status = 'approved' and type = 'deposit'
group by date(AcceptDate),CASHIERTRANID,
case METHOD when 'CASH' then 'CASH' else 'CARD' end,
CurrencyCode,PlayerCode,
case clientType when 'casino' then 'online gaming' when 'sportsbook' then 'online bet' else clientType end;


--Report 3: weekly monthly reports:

select ov.cust_username,ov.CurrencyCode,ba.C_st_bal OpeningBalance,ba.B_st_bal OpeningBonusBalance,
ov.DepositAmt+COALESCE(bo.bonus,0)+ov.totalWin TotalFeed,ov.DepositAmt NewCashDeposit,COALESCE(bo.bonus,0) bonus,ov.totalWin,
ov.Cashbet+ov.BonusBet+ov.WithdrawAmt TotalOfftake,ov.Cashbet,ov.BonusBet,ov.WithdrawAmt,ba.C_en_bal ClosingBalance,ba.B_en_bal ClosingBonusBalance
from 
(select d.DAT_WEEK_DESC_DINTVL_EN weekdesc, CurrencyCode,cust_username,sum(DepositAmt) DepositAmt,
sum(cashWin) cashWin,sum(TotalWin) TotalWin,sum(cashbet) cashbet,
sum(bonusbet) bonusbet,sum(WithdrawAmt) WithdrawAmt 
from romania.Merge_aggregates bo
join d_date d on d.dat_day_Date = bo.summarydate 
and DATE_ADD(current_date(),INTERVAL -1 Week) between d.DAT_WEEK_BEGIN_DATE_EN and d.DAT_WEEK_end_DATE_EN
group by d.DAT_WEEK_DESC_DINTVL_EN, CurrencyCode,cust_username) ov
left outer join (select sum(bonus) bonus,username,d.DAT_WEEK_DESC_DINTVL_EN weekdesc,CurrencyCode from 
(select bon.SummaryDate,sum(Amount) bonus,CurrencyCode,username from (
select date(AcceptDate) SummaryDate,Amount,pl.CurrencyCode,username from romania.c_pending_bonus bo 
join romania.c_player pl on bo.PlayerCode = pl.code 
where status in ('approved','issued')
union all
select date(Date_Awarded),Amount_Awarded_USD,'USD',Username from romania.s_search_bonuses) bon 
group by bon.SummaryDate,username,CurrencyCode) bo
join d_date d on d.dat_day_Date = bo.summarydate 
and DATE_ADD(current_date(),INTERVAL -1 Week) between d.DAT_WEEK_BEGIN_DATE_EN and d.DAT_WEEK_end_DATE_EN
group by username,d.DAT_WEEK_DESC_DINTVL_EN,CurrencyCode) bo on ov.weekdesc = bo.weekdesc 
and ov.cust_username = bo.username and ov.CurrencyCode = bo.CurrencyCode 
join (select mima.username,currencycode,mima.weekdesc, st.startbalance c_st_bal, en.endbalance c_en_bal,
st.startbonus_balance B_st_bal,en.endbonus_balance B_en_bal
from (
select username,playercode,currencycode,d.DAT_WEEK_DESC_DINTVL_EN weekdesc, min(SummaryDate) week_St, max(SummaryDate) week_en
from frm_f_DailyAccntBalSummary  bal
join romania.c_player pl on bal.PlayerCode = pl.code
join d_date d on d.dat_day_Date = bal.summarydate 
	and DATE_ADD(current_date(),INTERVAL -1 Week) between d.DAT_WEEK_BEGIN_DATE_EN and d.DAT_WEEK_end_DATE_EN
#where bal.playercode= 10273383
group by playercode,d.DAT_WEEK_DESC_DINTVL_EN
) mima
join frm_f_DailyAccntBalSummary st on st.playercode = mima.PlayerCode and mima.week_st = st.SummaryDate
join frm_f_DailyAccntBalSummary en on en.playercode = mima.PlayerCode and mima.week_en = en.SummaryDate) ba
on ov.weekdesc = ba.weekdesc and ov.cust_username = ba.username and ov.CurrencyCode = ba.CurrencyCode;



--Report 3.1:

select d.DAT_WEEK_DESC_DINTVL_EN weekdesc,username, bo.CurrencyCode,
min(be_bal),min(be_bo_bal),
sum(TotalFeed),sum(deposit),sum(Bonus),sum(win),sum(bonuswin),
sum(TotalOfftake),sum(bet),sum(bonusbet),sum(RemovedBonuses),sum(Withdrawal),max(closing_balance)
 from 
(select date(StatsDate) summarydate,username, p.CurrencyCode,sum(GameCount),
sum(BeginningBalance) be_bal,sum(BeginningBonusBalance) be_bo_bal,
sum(Bonuses+SportsbookBonuses+Wins+Bonuswin+DEPOSITS+SportsBookWins+AP_WIN) TotalFeed,sum(DEPOSITS) deposit,sum(Bonuses+SportsbookBonuses) Bonus,
sum(Wins+SportsBookWins+AP_WIN) win,sum(Bonuswin) bonuswin, 
sum(bets+SportsbookBets+BonusBet+WITHDRAWS+RemovedBonuses+AP_BET) TotalOfftake,sum(bets+SportsbookBets+AP_BET) bet,sum(BonusBet) bonusbet,
sum(RemovedBonuses) RemovedBonuses,sum(WITHDRAWS) Withdrawal, sum(ds.balance) closing_balance
from romania.c_daily_stats ds join romania.c_player p on ds.playercode = p.code
#where playercode=10273013
group by username,date(StatsDate), p.CurrencyCode) bo
join d_date d on d.dat_day_Date = bo.summarydate 
and DATE_ADD(current_date(),INTERVAL -1 Week) between d.DAT_WEEK_BEGIN_DATE_EN and d.DAT_WEEK_end_DATE_EN
group by d.DAT_WEEK_DESC_DINTVL_EN, CurrencyCode,username


--report 3.2
select bo.username, bo.CurrencyCode,st_en.st_dt,st_en.en_dt,st_en.bbal,st_en.bb_bal,
sum(TotalFeed)+deposit TotalFeed,deposit,sum(Bonus),sum(win),sum(bonuswin),
sum(TotalOfftake)+withdraw TotalOfftake,withdraw,sum(bet),sum(bonusbet),sum(RemovedBonuses),st_en.bal closing_balance
from 
(select date(StatsDate) summarydate,username,playercode, p.CurrencyCode,sum(GameCount),
sum(BeginningBalance) be_bal,sum(BeginningBonusBalance) be_bo_bal,
sum(Bonuses+SportsbookBonuses+Wins+Bonuswin+SportsBookWins+AP_WIN) TotalFeed,sum(Bonuses+SportsbookBonuses) Bonus,
sum(Wins+SportsBookWins+AP_WIN) win,sum(Bonuswin) bonuswin, 
sum(bets+SportsbookBets+BonusBet+RemovedBonuses+AP_BET) TotalOfftake,sum(bets+SportsbookBets+AP_BET) bet,sum(BonusBet) bonusbet,
sum(RemovedBonuses) RemovedBonuses, sum(ds.balance) closing_balance
from romania.c_daily_stats ds join romania.c_player p on ds.playercode = p.code
#where playercode=10273013
group by username,date(StatsDate),playercode, p.CurrencyCode) bo
join (select prf.username,prf.playercode,prf.st_dt,prf.en_dt,st_ds.bbal,st_ds.bb_bal,en_ds.bal from 
	(select username,playercode,min(StatsDate) st_dt,max(StatsDate) en_dt
	from romania.c_daily_stats ds join romania.c_player p on ds.playercode = p.code
	#where playercode= 10272873 
	group by username,playercode) prf 
	join (select playercode,StatsDate,sum(BeginningBalance) bbal,sum(BeginningBonusBalance) bb_bal from romania.c_daily_stats 
			group by playercode,StatsDate) st_ds on prf.playercode=st_ds.playercode and prf.st_dt = st_ds.StatsDate
	join (select playercode,StatsDate,sum(Balance) bal from romania.c_daily_stats 
			group by playercode,StatsDate) en_ds on prf.playercode=en_ds.playercode and prf.en_dt = en_ds.StatsDate) st_en
		on st_en.username = bo.username
join (select PlayerCode,
	sum(case when type = 'deposit' then amount else 0 end) deposit,
	sum(case when type = 'withdraw' then amount else 0 end) withdraw
	from romania.c_player_payment 
	where status = 'approved' 
	#and PlayerCode=10273988
	group by PlayerCode) de_wd on bo.playercode = de_wd.playercode        
group by bo.username, bo.CurrencyCode,st_en.st_dt,st_en.en_dt,st_en.bbal,st_en.bb_bal,st_en.bal,deposit,withdraw
;