--report 1: Ron is reporting currency
select pla.summdate, cre.deposit,pla.win,pla.bet,cre.withdraw from 
(select summdate,
sum(case CurrencyCode when 'EUR' then xch.rate*bet else bet end) bet, 
sum(case CurrencyCode when 'EUR' then xch.rate*win else win end) win from
(select summdate,CurrencyCode,sum(bet) bet, sum (win) win from (
select 'sp' typ,date (settled_date - interval '2 hour') summdate, cust_ccy_code CurrencyCode,sum(cash_stake) bet, sum(cash_winnings) win
from romania.s_customer_pnl g join romania.c_player p on g.cust_username = p.Username and date(p.SignupDate) >= '2015-11-26'
where settled_date >= date '2015-11-26' + interval '2 hour'
group by date (settled_date - interval '2 hour'), cust_ccy_code
union
select 'cas' typ,date (GameDate) da, p.CurrencyCode,sum(bet) bet,sum(win) win 
from romania.c_games g join romania.c_player p on g.PlayerCode = p.code and date(p.SignupDate) >= '2015-11-26'
group by date (GameDate),p.CurrencyCode) a
group by summdate,CurrencyCode) sp, (
select eur.da , eur.rate/ron.rate rate from 
(select date(Effectivedate) da,Conversionrate rate from romania.c_currency_conversion_rates where Currencycode='EUR') eur
join
(select date(Effectivedate) da,Conversionrate rate from romania.c_currency_conversion_rates where Currencycode='RON') ron
on eur.da = ron.da) xch
where xch.da = sp.summdate
group by summdate) pla,
(select summdate,
sum(case type when 'deposit' then amt else 0 end) deposit,
sum(case type when 'withdraw' then amt else 0 end) withdraw from (
select summdate,type,
sum(case currencycode when 'EUR' then xch.rate*amt else amt end) amt from 
(select date (acceptdate) summdate, p.currencycode,type , sum(amount) amt
from romania.c_player_payment py, romania.c_player p 
where p.code = py.playercode
and date(p.SignupDate) >= '2015-11-26'
and status = 'approved'
and date (acceptdate) >= '2015-11-26'
group by date (acceptdate), p.currencycode,type) tr,
(select eur.da , eur.rate/ron.rate rate from 
(select date(Effectivedate) da,Conversionrate rate from romania.c_currency_conversion_rates where Currencycode='EUR') eur
join
(select date(Effectivedate) da,Conversionrate rate from romania.c_currency_conversion_rates where Currencycode='RON') ron
on eur.da = ron.da) xch
where tr.summdate = xch.da
group by summdate,type) ov
group by summdate) cre
where cre.summdate = pla.summdate;


--Report for Bonus (Currency conversion pending)
select da, currencycode,sum(offered) offered, 
sum(case prd when 'CAS' then  Redeemed else 0 end) CasinoRedeemed,
sum(case prd when 'SPO' then  Redeemed else 0 end) SportsRedeemed from (
select 'SPO' prd,date(date_started_triggers) da,cust_ccy_code currencycode, sum(amount_awarded) offered,
sum(case status when 'Redeemed' then amount_awarded else 0 end) Redeemed
from romania.s_search_bonuses sb, romania.c_player p 
where p.username  = sb.username
and sb.Status = 'Redeemed'
and date (p.signupdate) >= '2015-11-26'
group by date(date_started_triggers),cust_ccy_code
union
select 'CAS' prd, date(requestdate) summdate,p.currencycode,
sum(case when  RequestDate is not null then Amount else 0 end) offered,
sum(case when  RequestDate is not null and AcceptDate is not null and RedeemDate is not null then Amount else 0 end) redeemed
from romania.c_pending_bonus b, romania.c_player p
where b.playercode = p.code::character varying
and date(p.signupdate) >='2015-11-26'
group by date(requestdate),p.currencycode) bon
group by da, currencycode
order by 1;
