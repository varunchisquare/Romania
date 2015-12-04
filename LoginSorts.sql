use romania;
drop table romania.frm_f_DailyAccntBalSummary;
create table romania.frm_f_DailyAccntBalSummary (
SummaryDate date,
PlayerCode int(10),
PlayerType varchar(50),
StartBalance decimal(18,6),
StartBonusBalance decimal(18,6),
EndBalance decimal(18,6),
EndBonusBalance decimal(18,6) 
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table romania.stg_login_across;
CREATE TABLE romania.stg_login_across (
   SummaryDate date default null,
   PlayerCode int(10) DEFAULT NULL,
   PlayerType varchar(50) DEFAULT NULL,
   LoginDate datetime DEFAULT NULL,
   LogoutDate datetime DEFAULT NULL,
   StartBalance decimal(18,6) DEFAULT NULL,
   StartBonusBalance decimal(18,6) DEFAULT NULL,
   EndBalance decimal(18,6) DEFAULT NULL,
   EndBonusBalance decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

/* filling the gaps (for those session that did not end the same day 
for e.g. login date 01-11-2015 23:54:00 and logout: 02-11-2015 00:15:00, populating:
for 01-11-2015 : 
	login date {01-11-2015 23:54:00}, 
	logout date {01-11-2015 23:59:58}, 
	startbalance: session startbalance, 
	endbalance: session endbalance,
	Bonus Start Balance: session BonusStartBalance,
	Bonus End Balance: session BonusEndBalance
	
for 02-11-2015 : 
	login date {02-11-2015 00:00:01}, 
	logout date {02-11-2015 00:15:00}, 
	startbalance: session endbalance, 
	endbalance: session endbalance,
	Bonus Start Balance: session BonusEndBalance,
	Bonus End Balance: session BonusEndBalance
)
*/
select d.DAT_DAY_DATE,playercode,playertype,
case when d.DAT_DAY_DATE = date(logindate)  then logindate  else str_to_date(concat(DATE_FORMAT(d.DAT_DAY_DATE,'%Y-%m-%d'),' 00:00:01'),'%Y-%m-%d %H:%i:%s')  end as logindate,
case when d.DAT_DAY_DATE = date(logoutdate) then logoutdate else str_to_date(CONCAT(DATE_FORMAT(d.DAT_DAY_DATE,'%Y-%m-%d'),' 23:59:58'),'%Y-%m-%d %H:%i:%s')  end as logoutdate,
case when d.DAT_DAY_DATE = date(logindate) then startbalance else endbalance end as startbalance,
case when d.DAT_DAY_DATE = date(logindate) then startBonusbalance else endBonusbalance end as startBonusbalance,
endBalance,
endBonusBalance 
from 
(select sessionId,lo1.playercode,lo1.logindate,lo1.logoutdate,lo1.startbalance,lo1.endbalance,lo1.startbonusbalance,lo1.endbonusbalance,playertype
from romania.c_logins lo1 where date(lo1.LoginDate) != date(lo1.logoutdate) 
#and playercode=10275515
) sa 
join romania.d_date d on d.dat_Day_Date between date(sa.logindate) and date(sa.logoutdate)
where d.dat_day_date >= '2015-08-01' and d.dat_day_Date < current_date
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\loginMultiplesegregated.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';  

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\loginMultiplesegregated.csv' 
INTO TABLE romania.stg_login_across
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

/*recording day's start and end balance for the day for a player when login and logout belongs to the same calendar date*/
select distinct date(st1.LoginDate) summdate,st1.PlayerCode,st1.PlayerType,st1.LoginDate,en1.LogoutDate,st1.Startbalance,
st1.StartbonusBalance,en1.EndBalance,en1.EndBonusBalance
from 
(select lo.LoginDate,lo.PlayerCode,lo.PlayerType,lo.Startbalance,lo.Startbonusbalance
from romania.c_logins lo
join (select playercode,date(logindate) date,min(logindate) logindate
from romania.c_logins lo where date(lo.LoginDate) = date(lo.logoutdate) 
group by playercode,date(logindate)) st on lo.playercode = st.playercode and lo.logindate = st.logindate) st1
join
(select lo.LoginDate,lo.LogoutDate,lo.PlayerCode,lo.PlayerType, lo.EndBalance,lo.EndBonusBalance 
from romania.c_logins lo
join (select playercode,date(logindate) date, max(logoutdate) logoutdate 
from romania.c_logins lo where date(lo.LoginDate) = date(lo.logoutdate) 
group by playercode,date(logindate)) en on lo.playercode = en.playercode and lo.logoutdate = en.logoutdate)en1
on date(st1.LoginDate) = date(en1.LoginDate) and st1.PlayerCode = en1.PlayerCode
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\loginSingle.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\loginSingle.csv' 
INTO TABLE romania.stg_login_across
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

#loaded

select distinct date(st1.LoginDate), st1.PlayerCode,st1.PlayerType,st1.Startbalance,st1.Startbonusbalance,en1.EndBalance,en1.EndBonusBalance
from 
(select lo.LoginDate,lo.PlayerCode,lo.PlayerType,lo.Startbalance,lo.Startbonusbalance
from romania.stg_login_across lo
join (select lo1.playercode,date(lo1.logindate) date,min(lo1.logindate) logindate
from romania.stg_login_across lo1 where date(lo1.LoginDate) = date(lo1.logoutdate) 
group by playercode,date(logindate)) st on lo.playercode = st.playercode and lo.logindate = st.logindate) st1
join
(select lo.LoginDate,lo.LogoutDate,lo.PlayerCode,lo.PlayerType, lo.EndBalance,lo.EndBonusBalance 
from romania.stg_login_across lo
join (select lo1.playercode,date(lo1.logindate) date, max(lo1.logoutdate) logoutdate 
from romania.stg_login_across lo1 where date(lo1.LoginDate) = date(lo1.logoutdate) 
group by playercode,date(logindate)) en on lo.playercode = en.playercode and lo.logoutdate = en.logoutdate)en1
on date(st1.LoginDate) = date(en1.LoginDate) and st1.PlayerCode = en1.PlayerCode
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\romania\\frm_f_DailyAccntBalSummary.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\romania\\frm_f_DailyAccntBalSummary.csv' 
INTO TABLE romania.frm_f_DailyAccntBalSummary
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';


select * from romania.frm_f_DailyAccntBalSummary where playercode=10275515