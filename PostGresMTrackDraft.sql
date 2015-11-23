drop table romania.frm_F_DailyXchangeRates;
Create table romania.frm_F_DailyXchangeRates(
ID  SERIAL PRIMARY KEY,
SummaryDate date,
CurrencyCode varchar(20),
XchangeRate double precision);

insert into romania.frm_F_DailyXchangeRates(SummaryDate,CurrencyCode,XchangeRate) (
select StatsDate,CurrencyCode,Avg(CurrencyRate) from romania.stg_daily_stats
group by StatsDate,CurrencyCode);

drop table romania.frm_F_Daily_Deposit_withdrawal_summary;
create table romania.frm_F_Daily_Deposit_withdrawal_summary (
ID  SERIAL PRIMARY KEY,
summarydate date,
PlayerCode integer,
Deposit numeric,
Withdrawal numeric);

insert into romania.frm_F_Daily_Deposit_withdrawal_summary(
select Summarydate,playercode, 
case trtype when 'deposit' then usd_amt else 0 end deposit,
case trtype when 'withdraw' then usd_amt else 0 end withdrawal from (
select date(AcceptDate) Summarydate,pp.type trtype,CASHIERTRANID TranCode, METHOD,CurrencyCode, sum(amount) amt, sum(bc_amount) usd_amt,PlayerCode 
from romania.stg_player_payment pp left outer join romania.stg_player pl on pl.code = pp.playercode
where pp.status = 'approved' and pp.type in ('withdraw','deposit')
group by date(AcceptDate),CASHIERTRANID,METHOD,CurrencyCode,PlayerCode,pp.type) ab);



create table romania.frm_F_Player_Deposit_Withdrawal_Attempt (
ID  SERIAL PRIMARY KEY,
PlayerCode integer,
requestdate timestamp without time zone,
type character varying,
method character varying,
status character varying,
Amount numeric,
bc_amount numeric,
MerchantAnswer character varying,
extraMerchantInfo character varying);

truncate table romania.frm_F_Player_Deposit_Withdrawal_Attempt;
insert into romania.frm_F_Player_Deposit_Withdrawal_Attempt(
PlayerCode,requestdate,type,method,status,Amount,bc_amount,MerchantAnswer,extraMerchantInfo) 
(select playercode,requestdate,type,method, status,amount,bc_amount, 
merchantanswer,extramerchantinfo
from romania.stg_player_payment ab
order by 1,3,2);

drop table romania.frm_F_Player_Deposit_Withdrawal_Status;
create table romania.frm_F_Player_Deposit_Withdrawal_Status (
ID  SERIAL PRIMARY KEY,
rnk integer,
PlayerCode integer,
requestdate timestamp without time zone,
type character varying,
method character varying,
status character varying,
Amount numeric,
bc_amount numeric,
MerchantAnswer character varying,
extraMerchantInfo character varying);

insert into romania.frm_F_Player_Deposit_Withdrawal_Status(
rnk,PlayerCode,requestdate,type,method,status,Amount,bc_amount,MerchantAnswer,extraMerchantInfo) (
select (ab.id-abc.id )+1 seq, ab.playercode,ab.requestdate,ab.type,ab.method,ab.status,ab.amount,ab.bc_amount,
ab.MerchantAnswer,ab.extraMerchantInfo
from romania.frm_F_Player_Deposit_Withdrawal_Attempt ab
join (select playerCode,type,min(id) id from romania.frm_F_Player_Deposit_Withdrawal_Attempt
group by playerCode,type) abc on ab.playercode = abc.playercode and ab.type = abc.type);


--------Deposit withdrawal details
select pl.code playerCode
,dep.Tran01 dTran01,dep.Tran02 dTran02,dep.Tran03 dTran03,dep.Tran04 dTran04,dep.Tran05 dTran05
,dep.Tran06 dTran06,dep.Tran07 dTran07,dep.Tran08 dTran08,dep.Tran09 dTran09,dep.Tran10 dTran10
,dep.Tran11 dTran01,dep.Tran12 dTran12,dep.Tran13 dTran13,dep.Tran14 dTran14,dep.Tran15 dTran15
,dep.Tran16 dTran16,dep.Tran17 dTran17,dep.Tran18 dTran18,dep.Tran19 dTran19,dep.Tran20 dTran20
,wdr.Tran01 wTran01,wdr.Tran02 wTran02,wdr.Tran03 wTran03,wdr.Tran04 wTran04,wdr.Tran05 wTran05
,wdr.Tran06 wTran06,wdr.Tran07 wTran07,wdr.Tran08 wTran08,wdr.Tran09 wTran09,wdr.Tran10 wTran10
,wdr.Tran11 wTran01,wdr.Tran12 wTran12,wdr.Tran13 wTran13,wdr.Tran14 wTran14,wdr.Tran15 wTran15
,wdr.Tran16 wTran16,wdr.Tran17 wTran17,wdr.Tran18 wTran18,wdr.Tran19 wTran19,wdr.Tran20 wTran20
from romania.stg_player pl 
left outer join (select playercode,
max(Tran01) Tran01, max(Tran02) Tran02, max(Tran03) Tran03, max(Tran04) Tran04, max(Tran05) Tran05, 
max(Tran06) Tran06, max(Tran07) Tran07, max(Tran08) Tran08, max(Tran09) Tran09, max(Tran10) Tran10, 
max(Tran11) Tran11, max(Tran12) Tran12, max(Tran13) Tran13, max(Tran14) Tran14, max(Tran15) Tran15,  
max(Tran16) Tran16, max(Tran17) Tran17, max(Tran18) Tran18, max(Tran19) Tran19, max(Tran20) Tran20
from (
select playercode
,case rnk when 1  then status||'-'||requestdate else null end Tran01
,case rnk when 2  then status||'-'||requestdate else null end Tran02
,case rnk when 3  then status||'-'||requestdate else null end Tran03
,case rnk when 4  then status||'-'||requestdate else null end Tran04
,case rnk when 5  then status||'-'||requestdate else null end Tran05
,case rnk when 6  then status||'-'||requestdate else null end Tran06
,case rnk when 7  then status||'-'||requestdate else null end Tran07
,case rnk when 8  then status||'-'||requestdate else null end Tran08
,case rnk when 9  then status||'-'||requestdate else null end Tran09
,case rnk when 10 then status||'-'||requestdate else null end Tran10
,case rnk when 11 then status||'-'||requestdate else null end Tran11
,case rnk when 12 then status||'-'||requestdate else null end Tran12
,case rnk when 13 then status||'-'||requestdate else null end Tran13
,case rnk when 14 then status||'-'||requestdate else null end Tran14
,case rnk when 15 then status||'-'||requestdate else null end Tran15
,case rnk when 16 then status||'-'||requestdate else null end Tran16
,case rnk when 17 then status||'-'||requestdate else null end Tran17
,case rnk when 18 then status||'-'||requestdate else null end Tran18
,case rnk when 19 then status||'-'||requestdate else null end Tran19
,case rnk when 20 then status||'-'||requestdate else null end Tran20
from (
select ab.rnk,playercode,requestdate,type,method,case status when 'approved' then 'A' else 'D' end status,amount,bc_Amount
 from romania.frm_F_Player_Deposit_Withdrawal_Status ab 
 where type= 'withdraw' --and playercode= 10272896
) pq) abc group by playercode ) wdr on wdr.playercode = pl.code
left outer join
(select playercode,
max(Tran01) Tran01, max(Tran02) Tran02, max(Tran03) Tran03, max(Tran04) Tran04, max(Tran05) Tran05, 
max(Tran06) Tran06, max(Tran07) Tran07, max(Tran08) Tran08, max(Tran09) Tran09, max(Tran10) Tran10, 
max(Tran11) Tran11, max(Tran12) Tran12, max(Tran13) Tran13, max(Tran14) Tran14, max(Tran15) Tran15,  
max(Tran16) Tran16, max(Tran17) Tran17, max(Tran18) Tran18, max(Tran19) Tran19, max(Tran20) Tran20
from (
select playercode
,case rnk when 1  then status||'-'||requestdate else null end Tran01
,case rnk when 2  then status||'-'||requestdate else null end Tran02
,case rnk when 3  then status||'-'||requestdate else null end Tran03
,case rnk when 4  then status||'-'||requestdate else null end Tran04
,case rnk when 5  then status||'-'||requestdate else null end Tran05
,case rnk when 6  then status||'-'||requestdate else null end Tran06
,case rnk when 7  then status||'-'||requestdate else null end Tran07
,case rnk when 8  then status||'-'||requestdate else null end Tran08
,case rnk when 9  then status||'-'||requestdate else null end Tran09
,case rnk when 10 then status||'-'||requestdate else null end Tran10
,case rnk when 11 then status||'-'||requestdate else null end Tran11
,case rnk when 12 then status||'-'||requestdate else null end Tran12
,case rnk when 13 then status||'-'||requestdate else null end Tran13
,case rnk when 14 then status||'-'||requestdate else null end Tran14
,case rnk when 15 then status||'-'||requestdate else null end Tran15
,case rnk when 16 then status||'-'||requestdate else null end Tran16
,case rnk when 17 then status||'-'||requestdate else null end Tran17
,case rnk when 18 then status||'-'||requestdate else null end Tran18
,case rnk when 19 then status||'-'||requestdate else null end Tran19
,case rnk when 20 then status||'-'||requestdate else null end Tran20
from (
select ab.rnk,playercode,requestdate,type,method,case status when 'approved' then 'A' else 'D' end status,amount,bc_Amount
 from romania.frm_F_Player_Deposit_Withdrawal_Status ab 
 where type= 'withdraw' --and playercode= 10272896
) pq) abc group by playercode ) dep on dep.playercode = pl.code;

---select * from romania.sp_customer pl
select dat_day_date,gm.cust_id,gm.num_bets
from romania.d_DAte d left outer join romania.sp_customer_pnl gm on date_trunc('day',settled_Date) = d.dat_day_date 
where dat_day_date <= current_Date and dat_day_date >= '2015-08-01'
order by 1,2;

