select date(gamedate) summdate,p.Currencycode,
sum(bet) CasinoBet,
sum(win) CasinoWins, 
sum(BonusBet) CasinoBonusBet,
sum(BonusWin) CasinoBonusWin,
count(distinct PlayerCode) CasinoUAP,
count(playercode) betcnt
from romania.c_games ds left outer join romania.c_player p on ds.playercode = p.code
where date(gamedate) >= '2015-11-26' 
group by date(gamedate),p.Currencycode;


select date(DATE_SUB(settled_date, INTERVAL 2 HOUR)) summdate,
count(distinct cust_username) sportsUAP,
sum(cash_stake) SpCashBet, 
sum(cash_winnings) SpCashWin, 
Sum(bonus_stake) SpBonusBet, 
Sum(bonus_winnings) SpBonusWin,
sum(cash_out_stake) SpCashOutBet, 
sum(cash_out_win) SpCashOutWin,
sum(num_bets) betCnt, 
sum(case is_inplay when 'N' then cash_stake else 0 end ) PrematchStake,
sum(case is_inplay when 'N' then cash_winnings else 0 end ) PrematchWin, 
sum(case is_inplay when 'N' then bonus_stake else 0 end ) Prematchbonus_stake,
sum(case is_inplay when 'N' then bonus_winnings else 0 end ) PrematchBonusWin, 
sum(case is_inplay when 'N' then cash_out_stake else 0 end ) Prematchbonus_stake,
sum(case is_inplay when 'N' then cash_out_win else 0 end ) PrematchBonusWin, 
sum(case is_inplay when 'N' then num_bets else 0 end ) PrematchBetCnt,
sum(case is_inplay when 'Y' then cash_stake else 0 end ) LiveStake,
sum(case is_inplay when 'Y' then cash_winnings else 0 end ) LiveWin, 
sum(case is_inplay when 'Y' then bonus_stake else 0 end ) LiveBonusStake,
sum(case is_inplay when 'Y' then bonus_winnings else 0 end ) LiveBonusWin, 
sum(case is_inplay when 'Y' then cash_out_stake else 0 end ) LiveBonusStake,
sum(case is_inplay when 'Y' then cash_out_win else 0 end ) LiveBonusWin, 
sum(case is_inplay when 'Y' then num_bets else 0 end ) LiveBetCnt
from romania.s_customer_pnl
where date(DATE_SUB(settled_date, INTERVAL 2 HOUR)) >= '2015-11-26' 
group by date(DATE_SUB(settled_date, INTERVAL 2 HOUR));


select round(sum(bal)) balance, sum(ftd) ftd, sum(signup) signup from 
(select sum(balance) bal,
sum(case when date(GlobalFirstDepositDate)=DATE_SUB(current_date, INTERVAL 1 DAY) then 1 else 0 end) ftd,
sum(case when date(SignupDate) =DATE_SUB(current_date, INTERVAL 1 DAY) then 1 else 0 end) signup
from romania.c_player
where #date(SignupDate) >= '2015-11-26' and 
Currencycode='RON'
union
select bal*ra.rat, ftd,Signup from (
select sum(balance) bal,DATE_SUB(current_date, INTERVAL 1 DAY) da,
sum(case when date(GlobalFirstDepositDate)=DATE_SUB(current_date, INTERVAL 1 DAY) then 1 else 0 end) ftd,
sum(case when date(SignupDate) =DATE_SUB(current_date, INTERVAL 1 DAY) then 1 else 0 end) signup
from romania.c_player
where #date(SignupDate) >= '2015-11-26' and 
Currencycode='EUR'
group by DATE_SUB(current_date, INTERVAL 1 DAY)) ba join 
(select e.da, e.cr/r.cr rat from 
(select Conversionrate cr,date(Effectivedaten) da from romania.C_Currency_Conversion_Rates a
where CurrencyCode = 'EUR'
and date(Effectivedaten)=DATE_SUB(current_date, INTERVAL 1 DAY)) e join
(select Conversionrate cr,date(Effectivedaten) da from romania.C_Currency_Conversion_Rates a
where CurrencyCode = 'RON'
and date(Effectivedaten)=DATE_SUB(current_date, INTERVAL 1 DAY)) r on r.da= e.da) ra on ra.da = ba.da) ove;

select da,count(distinct username) overalluap from (
select date(gamedate) da,username from romania.c_games g join romania.c_player p on g.playercode = p.code
union
select date(DATE_SUB(settled_date, INTERVAL 2 HOUR)) da, cust_username from romania.s_customer_pnl) OAUAP
where da > '2015-11-25'
group by da;