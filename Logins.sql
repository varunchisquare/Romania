use test;

Drop Table test.rw_logins;
CREATE TABLE test.rw_logins (
ClientType varchar(200) DEFAULT NULL,
Code varchar(200) DEFAULT NULL,
EndBalance varchar(200) DEFAULT NULL,
EndBonusBalance varchar(200) DEFAULT NULL,
FunPlayerCode varchar(200) DEFAULT NULL,
HwSerial varchar(200) DEFAULT NULL,
IP varchar(200) DEFAULT NULL,
KioskCode varchar(200) DEFAULT NULL,
LoginDate varchar(200) DEFAULT NULL,
LogoutDate varchar(200) DEFAULT NULL,
PlayerCode varchar(200) DEFAULT NULL,
PlayerType varchar(200) DEFAULT NULL,
Serial_ varchar(200) DEFAULT NULL,
ServerCode varchar(200) DEFAULT NULL,
SessionID varchar(200) DEFAULT NULL,
Startbalance varchar(200) DEFAULT NULL,
Startbonusbalance varchar(200) DEFAULT NULL,
Version varchar(200) DEFAULT NULL,
ClientPlatform varchar(200) DEFAULT NULL,
LoginDeviceTypeCode varchar(200) DEFAULT NULL,
LoginVenueCode varchar(200) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\CURL_-_Logins_04-01-2016.csv'
INTO TABLE  test.rw_logins
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

SELECT 
ClientType,
Code,
EndBalance,
EndBonusBalance,
FunPlayerCode,
HwSerial,
IP,
KioskCode,
CASE WHEN LoginDate <> '' THEN str_to_date(substring(LoginDate, 1,16),'%Y-%m-%d %H:%i') ELSE NULL END LoginDate,
CASE WHEN LogoutDate <> '' THEN str_to_date(substring(LogoutDate, 1,16),'%Y-%m-%d %H:%i') ELSE NULL END LogoutDate,
PlayerCode,
PlayerType,
Serial_,
ServerCode,
SessionID,
Startbalance,
Startbonusbalance,
Version,
ClientPlatform,
LoginDeviceTypeCode,
LoginVenueCode
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\LoginsNew.csv'
FIELDS TERMINATED BY '|' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
FROM test.rw_logins
where ClientType!='CLIENTTYPE';

Drop table `test`.`c_logins`;
CREATE TABLE `test`.`c_logins` (
   `ClientType` varchar(200) DEFAULT NULL,
   `Code` int(9) DEFAULT NULL,
   `EndBalance` decimal(18,6) DEFAULT NULL,
   `EndBonusBalance` decimal(18,6) DEFAULT NULL,
   `FunPlayerCode` int(9) DEFAULT NULL,
   `HwSerial` int(9) DEFAULT NULL,
   `IP` varchar(200) DEFAULT NULL,
   `KioskCode` int(9) DEFAULT NULL,
   `LoginDate` datetime DEFAULT NULL,
   `LogoutDate` datetime DEFAULT NULL,
   `PlayerCode` int(9) DEFAULT NULL,
   `PlayerType` varchar(200) DEFAULT NULL,
   `Serial` int(9) DEFAULT NULL,
   `ServerCode` int(9) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `Startbalance` decimal(18,6) DEFAULT NULL,
   `Startbonusbalance` decimal(18,6) DEFAULT NULL,
   `Version` varchar(200) DEFAULT NULL,
   `ClientPlatform` varchar(200) DEFAULT NULL,
   `LoginDeviceTypeCode` int(9) DEFAULT NULL,
   `LoginVenueCode` int(9) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\LoginsNew.csv' 
INTO TABLE  test.c_logins
FIELDS TERMINATED BY '|' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

use romaniastg;
drop table stg_daily_player_logins;
CREATE TABLE stg_daily_player_logins (
   SummaryDate date,
   PlayerCode int(10),
   PlayerType varchar(50) DEFAULT NULL,
   LoginDate datetime DEFAULT NULL,
   LogoutDate datetime DEFAULT NULL,
   StartBalance decimal(18,6) DEFAULT NULL,
   StartBonusBalance decimal(18,6) DEFAULT NULL,
   EndBalance decimal(18,6) DEFAULT NULL,
   EndBonusBalance decimal(18,6) DEFAULT NULL,
   ClientType varchar(200) DEFAULT NULL,
   Code int(9) DEFAULT NULL,
   FunPlayerCode int(9) DEFAULT NULL,
   HwSerial int(9) DEFAULT NULL,
   IP varchar(200) DEFAULT NULL,
   KioskCode int(9) DEFAULT NULL,
   Serial int(9) DEFAULT NULL,
   ServerCode int(9) DEFAULT NULL,
   SessionID varchar(200) DEFAULT NULL,
   Version varchar(200) DEFAULT NULL,
   ClientPlatform varchar(200) DEFAULT NULL,
   LoginDeviceTypeCode int(9) DEFAULT NULL,
   LoginVenueCode int(9) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

select d.DAT_DAY_DATE,playercode,playertype,
case when d.DAT_DAY_DATE = date(logindate)  then logindate  else str_to_date(concat(DATE_FORMAT(d.DAT_DAY_DATE,'%Y-%m-%d'),' 00:00:00'),'%Y-%m-%d %H:%i:%s')  end as logindate,
case when d.DAT_DAY_DATE = date(logoutdate) then logoutdate else str_to_date(CONCAT(DATE_FORMAT(d.DAT_DAY_DATE,'%Y-%m-%d'),' 23:59:59'),'%Y-%m-%d %H:%i:%s')  end as logoutdate,
coalesce(case when d.DAT_DAY_DATE = date(logindate) then startbalance else endbalance end,0) as startbalance,
coalesce(case when d.DAT_DAY_DATE = date(logindate) then startBonusbalance else endBonusbalance end,0) as startBonusbalance,
coalesce(endBalance,0),
coalesce(endBonusBalance,0),
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from 
(select sessionId,lo1.playercode,lo1.logindate,lo1.logoutdate,lo1.startbalance,lo1.endbalance,lo1.startbonusbalance,lo1.endbonusbalance,playertype,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from test.c_logins lo1 where date(lo1.LoginDate) != date(lo1.logoutdate) 
#and playercode=10275515
) sa 
join romania.d_date d on d.dat_Day_Date between date(sa.logindate) and date(sa.logoutdate)
where d.dat_day_date >= '2015-11-26' and d.dat_day_Date < current_date
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\LoginSplitsAcrossDates.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';


select date(lo1.logindate),lo1.playercode,playertype,
lo1.logindate,
lo1.logoutdate,
lo1.startbalance,
lo1.startbonusbalance,
coalesce(lo1.endbalance,lo1.startbalance) endbalance,
coalesce(lo1.endbonusbalance,lo1.startbonusbalance) endbonusbalance,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from romania.c_logins lo1 where lo1.logoutdate is null and date(lo1.LoginDate) >='2015-11-26'
#and code = 25542
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\LoginNullLogOutDates.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

select date(lo1.logindate),lo1.playercode,playertype,
lo1.logindate,
lo1.logoutdate,
lo1.startbalance,
lo1.startbonusbalance,
coalesce(lo1.endbalance,lo1.startbalance) endbalance,
coalesce(lo1.endbonusbalance,lo1.startbonusbalance) endbonusbalance,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from romania.c_logins lo1 where date(lo1.LoginDate) = date(lo1.logoutdate) 
and date(lo1.LoginDate) >='2015-11-26'
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\RegularLogins.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\LoginSplitsAcrossDates.csv' 
INTO TABLE stg_daily_player_logins
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\LoginNullLogOutDates.csv' 
INTO TABLE stg_daily_player_logins
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\RegularLogins.csv' 
INTO TABLE stg_daily_player_logins
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

select   
ClientType
, code LoginId
,EndBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerCode
,PlayerType
,Serial SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,ClientPlatform
,LoginDeviceTypeCode
,LoginVenueCode
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_stg_daily_player_logins.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniastg.stg_daily_player_logins;




