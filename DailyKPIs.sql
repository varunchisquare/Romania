##Date changes: 2016-Feb-02
##rename files 
##Full Run
use romania;
drop table `romania`.`c_player`;
CREATE TABLE `romania`.`c_player` (
   `ACCUMULATEDBETREFUND` int(10) DEFAULT NULL,
   `ACTIVATIONCODE` varchar(20) DEFAULT NULL,
   `ACTIVATIONCODERETRYCOUNT` varchar(20) DEFAULT NULL,
   `ACTIVATIONCODEVERIFIED` varchar(20) DEFAULT NULL,
   `ACTIVEBONUSCODE` varchar(20) DEFAULT NULL,
   `ACTIVEPENDINGBONUSCODE` varchar(20) DEFAULT NULL,
   `ADDRESS` varchar(200) DEFAULT NULL,
   `ADDRESSTRANSLATE` varchar(200) DEFAULT NULL,
   `ADDRESSUPPER` varchar(200) DEFAULT NULL,
   `ADVERTISER` varchar(20) DEFAULT NULL,
   `ADVERTISERCODE` varchar(20) DEFAULT NULL,
   `AGEVERIFICATION` varchar(20) DEFAULT NULL,
   `AGEVERIFICATIONDATE` varchar(20) DEFAULT NULL,
   `ALLBETSINCLUDED` varchar(20) DEFAULT NULL,
   `AUTHENTICATIONPHONE` varchar(20) DEFAULT NULL,
   `AUTHENTICATIONPHONEPIN` varchar(20) DEFAULT NULL,
   `BALANCE` decimal(18,6) DEFAULT NULL,
   `BALANCEVERSION` varchar(20) DEFAULT NULL,
   `BANNERID` varchar(20) DEFAULT NULL,
   `BC_BALANCE` varchar(20) DEFAULT NULL,
   `BC_BONUSBALANCE` varchar(20) DEFAULT NULL,
   `BC_CURRENTBET` varchar(20) DEFAULT NULL,
   `BC_PENDINGBONUSBALANCE` varchar(20) DEFAULT NULL,
   `BELLACONNECTACCOUNT` varchar(20) DEFAULT NULL,
   `BETFAIRCOMPPOINTS` varchar(20) DEFAULT NULL,
   `BILLINGSETTINGGROUPCODE` varchar(20) DEFAULT NULL,
   `BINGOCUSTOM1` varchar(20) DEFAULT NULL,
   `BINGOCUSTOM2` varchar(20) DEFAULT NULL,
   `BINGOFROZEN` varchar(20) DEFAULT NULL,
   `BINGONICKNAME` varchar(20) DEFAULT NULL,
   `BIRTHCITY` varchar(100) DEFAULT NULL,
   `BIRTHCOUNTRYCODE` varchar(20) DEFAULT NULL,
   `BIRTHDATE` varchar(20) DEFAULT NULL,
   `BIRTHDEPARTMENT` varchar(20) DEFAULT NULL,
   `BIRTHPROVINCE` varchar(20) DEFAULT NULL,
   `BIRTHPROVINCECODE` varchar(20) DEFAULT NULL,
   `BLACKLISTCHECKDATE` varchar(20) DEFAULT NULL,
   `BLACKLISTED` varchar(20) DEFAULT NULL,
   `BONUSBALANCE` varchar(20) DEFAULT NULL,
   `BONUSBALANCEVERSION` varchar(20) DEFAULT NULL,
   `BONUSEXCLUDEDGAMEWIN` varchar(20) DEFAULT NULL,
   `BONUSEXCLUDEDGAMEWINRESETDATE` varchar(20) DEFAULT NULL,
   `BONUSGROUP` varchar(20) DEFAULT NULL,
   `BONUSSEEKER` varchar(20) DEFAULT NULL,
   `CANTDEPOSIT` varchar(20) DEFAULT NULL,
   `CANTDEPOSITALL` varchar(20) DEFAULT NULL,
   `CASINOCODE` varchar(20) DEFAULT NULL,
   `CELLPHONE` varchar(20) DEFAULT NULL,
   `CHANGEPOKERPLAYERCODE` varchar(20) DEFAULT NULL,
   `CHATADMINCODE` varchar(20) DEFAULT NULL,
   `CHATKICKPERIOD` varchar(20) DEFAULT NULL,
   `CHATKICKTIME` varchar(20) DEFAULT NULL,
   `CHATMUTEPERIOD` varchar(20) DEFAULT NULL,
   `CHATMUTETIME` varchar(20) DEFAULT NULL,
   `CITIZENSHIP` varchar(20) DEFAULT NULL,
   `CITY` varchar(100) DEFAULT NULL,
   `CLIENTPARAMETERCODE` varchar(20) DEFAULT NULL,
   `CLIENTVERSION` varchar(20) DEFAULT NULL,
   `CODE` bigint(20) DEFAULT NULL,
   `COMMENTS` varchar(500) DEFAULT NULL,
   `COMPPOINTS` varchar(200) DEFAULT NULL,
   `COUNTRYCODE` varchar(20) DEFAULT NULL,
   `COUPONNAME` varchar(20) DEFAULT NULL,
   `CURRENCYCODE` varchar(20) DEFAULT NULL,
   `CURRENCYCONVERSIONREMAINDER` varchar(20) DEFAULT NULL,
   `CURRENTBET` varchar(20) DEFAULT NULL,
   `CURRENTBONUSBET` varchar(20) DEFAULT NULL,
   `CUSTOM01` varchar(20) DEFAULT NULL,
   `CUSTOM02` varchar(20) DEFAULT NULL,
   `CUSTOM03` varchar(20) DEFAULT NULL,
   `CUSTOM04` varchar(20) DEFAULT NULL,
   `CUSTOM05` varchar(20) DEFAULT NULL,
   `CUSTOM06` varchar(20) DEFAULT NULL,
   `CUSTOM07` varchar(20) DEFAULT NULL,
   `CUSTOM08` varchar(20) DEFAULT NULL,
   `CUSTOMCLIENT01` varchar(20) DEFAULT NULL,
   `CUSTOMCLIENT02` varchar(20) DEFAULT NULL,
   `DEPOSITGROUPCODE` varchar(20) DEFAULT NULL,
   `DEPOSITLIMITAMOUNT` varchar(20) DEFAULT NULL,
   `DEPOSITLIMITSETDATE` varchar(20) DEFAULT NULL,
   `DEPOSITLIMITTIMEPERIOD` varchar(20) DEFAULT NULL,
   `DEPOSITRESTRICTIONS` varchar(20) DEFAULT NULL,
   `DISABLEALLDEPOSITS` varchar(20) DEFAULT NULL,
   `DISABLEGAMING` varchar(20) DEFAULT NULL,
   `DISABLEHELDFUNDS` varchar(20) DEFAULT NULL,
   `DONOTCALL` varchar(20) DEFAULT NULL,
   `DONOTPROCESSWITHDRAWALS` varchar(20) DEFAULT NULL,
   `DRIVERLICENSENO` varchar(20) DEFAULT NULL,
   `DUPSEARCHEXCLUDE` varchar(20) DEFAULT NULL,
   `EMAIL` varchar(50) DEFAULT NULL,
   `EMAILVERIFIED` varchar(20) DEFAULT NULL,
   `ENCRYPTIONKEYVERSION` varchar(20) DEFAULT NULL,
   `EXTERNALCREATETYPE` varchar(20) DEFAULT NULL,
   `EXTERNALID` varchar(20) DEFAULT NULL,
   `FAX` varchar(20) DEFAULT NULL,
   `FIRSTDEPOSITCLIENTPARAMETER` varchar(20) DEFAULT NULL,
   `FIRSTLOGINDATE` varchar(20) DEFAULT NULL,
   `FIRSTNAME` varchar(100) DEFAULT NULL,
   `FIRSTNAMESOUNDEX` varchar(20) DEFAULT NULL,
   `FRAUDADMINCODE` varchar(20) DEFAULT NULL,
   `FRAUDCHECKDATE` varchar(20) DEFAULT NULL,
   `FREEZECHAT` varchar(20) DEFAULT NULL,
   `FROZEN` varchar(20) DEFAULT NULL,
   `GENDER` varchar(20) DEFAULT NULL,
   `GLOBALFIRSTDEPOSITDATE` varchar(20) DEFAULT NULL,
   `GROUPPARENTCODE` varchar(20) DEFAULT NULL,
   `HAVEIDCOPYFAX` varchar(20) DEFAULT NULL,
   `HEARDFROM` varchar(20) DEFAULT NULL,
   `IBAN` varchar(20) DEFAULT NULL,
   `IDCARDNO` varchar(100) DEFAULT NULL,
   `INCLUDEFIRSTDEPOSIT` varchar(20) DEFAULT NULL,
   `INCLUDESIGNUP` varchar(20) DEFAULT NULL,
   `INTERNALACCOUNT` varchar(20) DEFAULT NULL,
   `IPPROXYALLOWED` varchar(20) DEFAULT NULL,
   `KICKOUT` varchar(20) DEFAULT NULL,
   `KIOSKADMINCODE` varchar(20) DEFAULT NULL,
   `KIOSKCODE` varchar(20) DEFAULT NULL,
   `LANGUAGECODE` varchar(20) DEFAULT NULL,
   `LASTFAILEDLOGIN` varchar(20) DEFAULT NULL,
   `LASTLOGINCLIENTTYPE` varchar(20) DEFAULT NULL,
   `LASTLOGINDATE` varchar(20) DEFAULT NULL,
   `LASTLOGINKIOSKCODE` varchar(20) DEFAULT NULL,
   `LASTNAME` varchar(100) DEFAULT NULL,
   `LASTNAMESOUNDEX` varchar(20) DEFAULT NULL,
   `LASTNAMEUPPER` varchar(100) DEFAULT NULL,
   `LASTSUPPORTCHATSESSIONTIME` varchar(20) DEFAULT NULL,
   `LOGINCOUNT` varchar(20) DEFAULT NULL,
   `LOGMESSAGES` varchar(20) DEFAULT NULL,
   `MAXBALANCE` varchar(20) DEFAULT NULL,
   `MAXTOTALBALANCE` varchar(20) DEFAULT NULL,
   `MOBILEGAMEREQUESTEMAIL` varchar(20) DEFAULT NULL,
   `MONEYRECEIVING` varchar(20) DEFAULT NULL,
   `MONEYSENDING` varchar(20) DEFAULT NULL,
   `MONEYTORISK` varchar(20) DEFAULT NULL,
   `NOBONUS` varchar(20) DEFAULT NULL,
   `NTRIES` varchar(20) DEFAULT NULL,
   `OCCUPATION` varchar(20) DEFAULT NULL,
   `ORIGADVERTISERCODE` varchar(20) DEFAULT NULL,
   `ORIGBANNERID` varchar(20) DEFAULT NULL,
   `ORIGPROFILEID` varchar(20) DEFAULT NULL,
   `ORIGREFERERURL` varchar(200) DEFAULT NULL,
   `PASSPORTID` varchar(200) DEFAULT NULL,
   `PASSWORDCHANGE` varchar(20) DEFAULT NULL,
   `PASSWORDCHANGEDATE` varchar(20) DEFAULT NULL,
   `PENDINGBONUSBALANCE` varchar(20) DEFAULT NULL,
   `PERSONALID` varchar(200) DEFAULT NULL,
   `PHONE` varchar(20) DEFAULT NULL,
   `PHONETRANSLATE` varchar(20) DEFAULT NULL,
   `PHONEUPPER` varchar(20) DEFAULT NULL,
   `PINDISABLED` varchar(20) DEFAULT NULL,
   `PINNUMBER` varchar(20) DEFAULT NULL,
   `PINRETRYCOUNT` varchar(20) DEFAULT NULL,
   `PLAYERRISKPROFILECHANGEDATE` varchar(20) DEFAULT NULL,
   `PLAYERRISKPROFILECODE` varchar(20) DEFAULT NULL,
   `PLAYERS_TS` varchar(20) DEFAULT NULL,
   `PLAYERTYPE` varchar(20) DEFAULT NULL,
   `POKERBLOCKED` varchar(20) DEFAULT NULL,
   `POKERCUSTOM1` varchar(20) DEFAULT NULL,
   `POKERCUSTOM2` varchar(20) DEFAULT NULL,
   `POKERFROZEN` varchar(20) DEFAULT NULL,
   `POKERNICKNAME` varchar(20) DEFAULT NULL,
   `POKERVIPLEVEL` varchar(20) DEFAULT NULL,
   `POSTOFFICEBOX` varchar(20) DEFAULT NULL,
   `PROFILEID` varchar(20) DEFAULT NULL,
   `PROVINCE` varchar(20) DEFAULT NULL,
   `PROVINCECODE` varchar(20) DEFAULT NULL,
   `REFERERURL` varchar(20) DEFAULT NULL,
   `REGIONCODE` varchar(20) DEFAULT NULL,
   `REGISTRATIONCHECKDATE` varchar(20) DEFAULT NULL,
   `REGULATORAPPROVAL` varchar(20) DEFAULT NULL,
   `REMAININGBONUSES` varchar(20) DEFAULT NULL,
   `REMINDAFTERTIMEPERIOD` varchar(20) DEFAULT NULL,
   `REMINDONFIRSTBET` varchar(20) DEFAULT NULL,
   `REMOTECHANGETIMESTAMP` varchar(50) DEFAULT NULL,
   `REMOTESYNC` varchar(20) DEFAULT NULL,
   `RESERVEDBALANCE` varchar(20) DEFAULT NULL,
   `SERIAL` varchar(20) DEFAULT NULL,
   `SIGNUP_CLIENTTYPE` varchar(20) DEFAULT NULL,
   `SIGNUPADVERTISERCODE` varchar(20) DEFAULT NULL,
   `SIGNUPCHANNELCODE` varchar(20) DEFAULT NULL,
   `SIGNUPCLIENTPARAMETERCODE` varchar(20) DEFAULT NULL,
   `SIGNUPCLIENTSKINCODE` varchar(20) DEFAULT NULL,
   `SIGNUPDATE` varchar(20) DEFAULT NULL,
   `SIGNUPREMOTEIP` varchar(20) DEFAULT NULL,
   `SIGNUPVERSION` varchar(20) DEFAULT NULL,
   `STATE` varchar(20) DEFAULT NULL,
   `SYNCBETFAIRCOMPPOINTS` varchar(20) DEFAULT NULL,
   `TEMPAPPROVEDEPOSIT` varchar(20) DEFAULT NULL,
   `TITLE` varchar(20) DEFAULT NULL,
   `TOKENSTATUS` varchar(20) DEFAULT NULL,
   `TOTALCOMPPOINTS` varchar(200) DEFAULT NULL,
   `TRACKINGID1` varchar(20) DEFAULT NULL,
   `TRACKINGID2` varchar(20) DEFAULT NULL,
   `TRACKINGID3` varchar(20) DEFAULT NULL,
   `TRACKINGID4` varchar(50) DEFAULT NULL,
   `TRACKINGID5` varchar(20) DEFAULT NULL,
   `TRACKINGID6` varchar(20) DEFAULT NULL,
   `TRACKINGID7` varchar(20) DEFAULT NULL,
   `TRACKINGID8` varchar(20) DEFAULT NULL,
   `UNSUBSCRIBEDATE` varchar(20) DEFAULT NULL,
   `USERNAME` varchar(100) DEFAULT NULL,
   `VERIFICATIONANSWER` varchar(20) DEFAULT NULL,
   `VERIFICATIONQUESTION` varchar(20) DEFAULT NULL,
   `VIDEOBET` varchar(20) DEFAULT NULL,
   `VIPLEVEL` varchar(20) DEFAULT NULL,
   `VIPLEVELUPDATEDATE` varchar(20) DEFAULT NULL,
   `WAGERING` varchar(20) DEFAULT NULL,
   `WAGERINGREALLOSS` varchar(20) DEFAULT NULL,
   `WANTMAIL` varchar(20) DEFAULT NULL,
   `WANTSMS` varchar(20) DEFAULT NULL,
   `WITHDRAWVERIFYCODE` varchar(20) DEFAULT NULL,
   `WORKPHONE` varchar(20) DEFAULT NULL,
   `ZIP` varchar(20) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-02\\CURL_Players_2016-Feb-02.csv' 
INTO TABLE romania.c_player
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

drop table romania.c_games;
CREATE TABLE `romania`.`c_games` (
   `AccumulatedBetRefund` decimal(18,4) DEFAULT NULL,
   `Autoplay` decimal(18,4) DEFAULT NULL,
   `Balance` decimal(18,4) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `BetExcludingTie` decimal(18,4) DEFAULT NULL,
   `BetRefund` decimal(18,4) DEFAULT NULL,
   `BGType` varchar(200) DEFAULT NULL,
   `BonusBalance` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `BonusCode` int(11) DEFAULT NULL,
   `BonusFG` varchar(200) DEFAULT NULL,
   `BonusJackpotWin` decimal(18,4) DEFAULT NULL,
   `BonusType` varchar(200) DEFAULT NULL,
   `BonusWageringAmount` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `ChannelCode` int(11) DEFAULT NULL,
   `ClientParameterCode` int(11) DEFAULT NULL,
   `Code` int(11) DEFAULT NULL,
   `CoinSize` varchar(200) DEFAULT NULL,
   `CompPointsBalance` decimal(18,4) DEFAULT NULL,
   `CompsAmount` decimal(18,4) DEFAULT NULL,
   `CurrentBet` decimal(18,4) DEFAULT NULL,
   `CurrentBonusBet` decimal(18,4) DEFAULT NULL,
   `DealerCode` int(11) DEFAULT NULL,
   `DEVICEContextCode` int(11) DEFAULT NULL,
   `FGWinAmount` decimal(18,4) DEFAULT NULL,
   `GameDate` varchar(200) DEFAULT NULL,
   `GameID` varchar(200) DEFAULT NULL,
   `Info` varchar(2000) DEFAULT NULL,
   `InitialBet` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `LiveGameTableCode` int(11) DEFAULT NULL,
   `LiveNetworkCode` int(11) DEFAULT NULL,
   `LPWin` decimal(18,4) DEFAULT NULL,
   `MPGameCode` int(11) DEFAULT NULL,
   `ParentGameCode` int(11) DEFAULT NULL,
   `ParentGameDate` varchar(200) DEFAULT NULL,
   `PendingBonusCode` int(11) DEFAULT NULL,
   `PlayerCode` int(11) DEFAULT NULL,
   `RecordID` varchar(200) DEFAULT NULL,
   `RemoteIP` varchar(200) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `SlotLines` varchar(200) DEFAULT NULL,
   `SPWin` varchar(200) DEFAULT NULL,
   `TurnoverCommissionAllocation` decimal(18,4) DEFAULT NULL,
   `TurnoverCommissionType` varchar(200) DEFAULT NULL,
   `Type` varchar(200) DEFAULT NULL,
   `WageringBonusCode` int(11) DEFAULT NULL,
   `WageringPendingBonusCode` int(11) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `WindowCode` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-02\\CURL_Games_2016-Feb-02.csv' 
INTO TABLE romania.c_games
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

drop table romania.s_customer_pnl;
CREATE TABLE `romania`.`s_customer_pnl` (
   `settled_date` varchar(200) DEFAULT NULL,
   `cust_id` varchar(200) DEFAULT NULL,
   `cr_date` varchar(200) DEFAULT NULL,
   `cust_limit_mult` varchar(200) DEFAULT NULL,
   `cust_segment_name` varchar(200) DEFAULT NULL,
   `channel_name` varchar(200) DEFAULT NULL,
   `cust_username` varchar(200) DEFAULT NULL,
   `casino_identifier` varchar(200) DEFAULT NULL,
   `cust_ccy_code` varchar(200) DEFAULT NULL,
   `sport_name` varchar(200) DEFAULT NULL,
   `class_name` varchar(200) DEFAULT NULL,
   `type_name` varchar(200) DEFAULT NULL,
   `sgl_mult_bet_types_name` varchar(200) DEFAULT NULL,
   `is_inplay` varchar(20) DEFAULT NULL,
   `mkt_sort_name` varchar(200) DEFAULT NULL,
   `total_stake` decimal(18,6) DEFAULT NULL,
   `cash_stake` decimal(18,6) DEFAULT NULL,
   `cash_out_stake` decimal(18,6) DEFAULT NULL,
   `bonus_stake` decimal(18,6) DEFAULT NULL,
   `bonus_bal_stake` decimal(18,6) DEFAULT NULL,
   `num_bets` decimal(18,6) DEFAULT NULL,
   `num_lines` decimal(18,6) DEFAULT NULL,
   `returns` decimal(18,6) DEFAULT NULL,
   `cash_winnings` decimal(18,6) DEFAULT NULL,
   `cash_out_win` decimal(18,6) DEFAULT NULL,
   `bonus_winnings` decimal(18,6) DEFAULT NULL,
   `bonus_bal_winnings` decimal(18,6) DEFAULT NULL,
   `stake_refunded` decimal(18,6) DEFAULT NULL,
   `bonus_stake_refunded` decimal(18,6) DEFAULT NULL,
   `bonus_bal_refund` decimal(18,6) DEFAULT NULL,
   `num_void_lines` decimal(18,6) DEFAULT NULL,
   `cash_profit` decimal(18,6) DEFAULT NULL,
   `profit_pc` decimal(18,6) DEFAULT NULL,
   `combined_profit` decimal(18,6) DEFAULT NULL,
   `max_stake` decimal(18,6) DEFAULT NULL,
   `avg_stake` decimal(18,6) DEFAULT NULL,
   `in_play_prop` decimal(18,6) DEFAULT NULL,
   `num_void_bets` decimal(18,6) DEFAULT NULL,
   `num_void_bet_lines` decimal(18,6) DEFAULT NULL,
   `void_stakes` decimal(18,6) DEFAULT NULL,
   `is_void` varchar(200) DEFAULT NULL,
   `void_in_play_prop` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-02\\Customer_P_L_Viewer.csv' 
INTO TABLE romania.s_customer_pnl
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

drop table romania.stg_transaction_info;
Create table romania.stg_transaction_info(
Code int(10),
Username varchar(100),
Casino varchar(50),
Merchant varchar(50),
Clienttype varchar(50),
Ppcode int(10),
Type varchar(50),
Status varchar(50),
Requestdate datetime,
Currencycode varchar(10),
Amount decimal(18,6),
Bc_amount decimal(18,6),
Balance decimal(18,6),
Bc_balance decimal(18,6),
Method varchar(100),
Paypaltranid varchar(500),
Submethod varchar(50),
Reason varchar(4000)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-02\\Transactions_information.csv' 
INTO TABLE stg_transaction_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select Code,Username,Casino,Merchant,Clienttype,Ppcode,Type,Status ,Requestdate,
date(Requestdate),month(Requestdate),year(Requestdate),Currencycode ,Amount,
Bc_amount ,Balance ,Bc_balance ,Method ,Paypaltranid ,Submethod ,
case when Status = 'approved' then 'NotDeclined'
	 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%card%' then 'InvalidCardDetails'
 when Status = 'declined' and lower(Reason) like '%ndeclined%' and lower(Reason) like '%prctime%' then 'NDeclinedPrcTime'
 when Status = 'declined' and lower(Reason) like '%pick-up%' and lower(Reason) like '%card%' then 'PickUpCardError'
 when Status = 'declined' and lower(Reason) like '%restricted%' and lower(Reason) like '%card%' then 'RestrictedCard'
 when Status = 'declined' and lower(Reason) like '%approve%' and lower(Reason) like '%referral%' then 'ApproveRegerralError'
 when Status = 'declined' and lower(Reason) like '%timeout/retry%' then 'TimeoutRetry'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%cvv2%' then 'InvalidCVV2'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%token%' then 'InvalidToken'
 when Status = 'declined' and lower(Reason) like '%no%' and lower(Reason) like '%issuer%' then 'NoSuchIssuer'
 when Status = 'declined' and lower(Reason) like '%restricted%' and lower(Reason) like '%card%' then 'RestrictedCard'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%transaction%' and lower(Reason) like '%exceeded%' then 'InvalidTransaction'
 when Status = 'declined' and lower(Reason) like '%pin%' and lower(Reason) like '%tries%' and lower(Reason) like '%exceeded%' then 'MaximumPinTriesExceeded'
 when Status = 'declined' and lower(Reason) like '%sc_fs_declined_trans%' then 'SC_FS_Declined'
 when Status = 'declined' and lower(Reason) like '%maximum%retry%clear%reach%' then 'MaximumClearanceRetryReached'
 when Status = 'declined' and lower(Reason) like '%issuer%' and lower(Reason) like '%switch%' and lower(Reason) like '%inoperative%' then 'IssuerORSwitchInoperative'
 when Status = 'declined' and lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' then 'TxnNotPermittedToCardHolder'
 when Status = 'declined' and lower(Reason) like '%acquirer%' and lower(Reason) like '%validation%' then 'AcquirerValidationError'
 when Status = 'declined' and lower(Reason) like '%do%' and lower(Reason) like '%not%' and lower(Reason) like '%honor%' then 'DoNotHonor'
 when Status = 'declined' and lower(Reason) like '%exceed%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%frequency%' then 'ExceedsWithdrawalFrequency'
 when Status = 'declined' and lower(Reason) like '%exceed%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%limit%' then 'ExceedsWithdrawalLimit'
 when Status = 'declined' and lower(Reason) like '%expired%' and lower(Reason) like '%card%' and lower(Reason) like '%unavail%' then 'ExpiredCardORUserUnavailable'
 when Status = 'declined' and lower(Reason) like '%insufficient%' and lower(Reason) like '%funds%' then 'InsufficientFunds'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%to%' and lower(Reason) like '%account%' then 'InvalidToAccount'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%to%' and lower(Reason) like '%account%' then 'InvalidToAccount'
 when Status = 'declined' and lower(Reason) like '%generic_error%' and lower(Reason) like '%user%' and lower(Reason) like '%cancelation%' then 'UserCancelled'
 when Status = 'declined' and lower(Reason) like '%567%' then 'SC_FS_Declined'
 else 'NA' end as DeclinedReason
INTO OUTFILE 'D:\\2016\\Feb-2016\\2016-Feb-02\\daily_player_transactions.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY 'NULL' LINES TERMINATED BY '\n'
from stg_transaction_info as txn;

drop table romania.daily_player_transactions;
Create table romania.daily_player_transactions(
Code int(10),
Username varchar(50),
Casino varchar(50),
Merchant varchar(50),
Clienttype varchar(50),
Ppcode int(10),
Type varchar(50),
Status varchar(50),
Requestdate datetime,
TxnDate date,
TxnMonth int,
TxnYear int,
Currencycode varchar(10),
Amount decimal(18,6),
Bc_amount decimal(18,6),
Balance decimal(18,6),
Bc_balance decimal(18,6),
Method varchar(100),
Paypaltranid varchar(500),
Submethod varchar(50),
DeclinedReason varchar(500)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-02\\daily_player_transactions.csv' 
INTO TABLE romania.daily_player_transactions
FIELDS TERMINATED BY ',' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';

select sgn.da, sgn.Signups, ftd.ftds,oa.oa OverallUAP,bal.bal,cas.UAP,cas.bet, 
cas.win,cas.bonusbet,cas.bonuswin,cas.jackpotbet,cas.jackpotwin, ' ' bonusRedeemed,
sp.UAP,spo.CashStake, spo.cash_winnings,spo.bonus_Stake,spo.Bonus_winnings,
spo.cash_out_stake,spo.Cash_out_win,spo.num_bets,spo.stake_refunded,
SPO.CashStakePre,SPO.cash_winningsPRe,SPO.bonus_StakePre,SPO.Bonus_winningsPre,SPO.cash_out_stakePre,SPO.Cash_out_winPre,SPO.num_betsPre,
SPO.CashStakeLive,SPO.cash_winningsLive,SPO.bonus_StakeLive,SPO.Bonus_winningsLive,SPO.cash_out_stakeLive,SPO.Cash_out_winLive,SPO.num_betsLive,
cas.cy egcurr,spo.cy spcurr,bal.cy balcurr
from 
(select date(p.signupdate) da, count(distinct username) Signups
from romania.c_player p where date(p.signupdate) >= '2015-11-26'
and date(p.signupdate) = date_add(current_date, INTERVAL -1 Day)
group by date(p.signupdate))sgn,
(select date(p.globalfirstdepositdate) da, count(distinct username) ftds
from romania.c_player p where date(p.signupdate) >= '2015-11-26'
and date(p.globalfirstdepositdate) = date_add(current_date, INTERVAL -1 Day)
group by date(p.globalfirstdepositdate)) ftd,
(select currencycode cy, sum(balance) bal
from romania.c_player p where date(p.signupdate) >= '2015-11-26' 
and balance > 0.0
group by currencycode) bal,
(select date(g.gamedate) summdate,p.currencycode cy, count(distinct p.username) uap, 
sum(bet) bet,sum(win) win, sum(bonusbet) bonusbet, sum(bonuswin) bonuswin,sum(jackpotbet) jackpotbet, sum(jackpotwin) jackpotwin
from romania.c_games g, romania.c_player p where date(p.signupdate) >= '2015-11-26' and p.code = g.playercode
and date(g.gamedate) = date_add(current_date, INTERVAL -1 Day)
group by date(g.gamedate),p.currencycode) cas,
(select sum(cash_Stake) CashStake,sum(cash_winnings) cash_winnings,
sum(bonus_Stake) bonus_Stake,sum(Bonus_winnings) Bonus_winnings,
sum(cash_out_stake) cash_out_stake,sum(Cash_out_win) Cash_out_win,
sum(num_bets) num_bets,sum(stake_refunded) stake_refunded,  
sum(case is_inplay when 'N' then cash_Stake else 0 end) 	CashStakePre,
sum(case is_inplay when 'N' then cash_winnings else 0 end) 	cash_winningsPRe,
sum(case is_inplay when 'N' then bonus_Stake else 0 end) 	bonus_StakePre,
sum(case is_inplay when 'N' then Bonus_winnings else 0 end) Bonus_winningsPre,
sum(case is_inplay when 'N' then cash_out_stake else 0 end) cash_out_stakePre,
sum(case is_inplay when 'N' then Cash_out_win else 0 end) 	Cash_out_winPre,
sum(case is_inplay when 'N' then num_bets else 0 end) 		num_betsPre,
sum(case is_inplay when 'Y' then cash_Stake else 0 end) 	CashStakeLive,
sum(case is_inplay when 'Y' then cash_winnings else 0 end) 	cash_winningsLive,
sum(case is_inplay when 'Y' then bonus_Stake else 0 end) 	bonus_StakeLive,
sum(case is_inplay when 'Y' then Bonus_winnings else 0 end) Bonus_winningsLive,
sum(case is_inplay when 'Y' then cash_out_stake else 0 end) cash_out_stakeLive,
sum(case is_inplay when 'Y' then Cash_out_win else 0 end) 	Cash_out_winLive,
sum(case is_inplay when 'Y' then num_bets else 0 end) 		num_betsLive,
currencycode cy from (
select date(date_add(settled_date, INTERVAL -2 Hour)) summdate,p.currencycode,is_inplay,
sum(cash_Stake) cash_Stake,sum(cash_winnings) cash_winnings, sum(bonus_Stake) bonus_Stake, sum(Bonus_winnings) Bonus_winnings,
sum(cash_out_stake) cash_out_stake,  sum(Cash_out_win) Cash_out_win, sum(num_bets) num_bets,sum(stake_refunded) stake_refunded
from romania.s_customer_pnl sp,romania.c_player p
where date(p.signupdate) >= '2015-11-26'
and date(date_add(settled_date, INTERVAL -2 Hour)) = date(date_add(current_date, INTERVAL -1 Day))
and sp.cust_username = p.username 
group by p.currencycode,is_inplay,date(date_add(settled_date, INTERVAL -2 Hour))) sp
group by currencycode) spo,
(select 1 a, count(distinct username) oa from (
select distinct username from romania.c_games g, romania.c_player p where p.code = g.playercode and date(p.signupdate) >= '2015-11-26'
union
select distinct cust_username from romania.s_customer_pnl sp ,romania.c_player p where date(p.signupdate) >= '2015-11-26') ab) oa,
(select 1 a, count(distinct username) UAP from 
(select distinct cust_username username from romania.s_customer_pnl sp ,romania.c_player p where date(p.signupdate) >= '2015-11-26') ab) sp
;

select *
from romania.daily_player_transactions;

/*
select date(g.gamedate) summdate,p.currencycode cy, count(distinct p.username) uap, 
sum(bet) bet,sum(win) win, sum(bonusbet) bonusbet, sum(bonuswin) bonuswin,sum(jackpotbet) jackpotbet, sum(jackpotwin) jackpotwin
from romania.c_games g, romania.c_player p 
where #date(p.signupdate) >= '2015-11-26' and 
p.code = g.playercode
and date(g.gamedate) = date(date_add(current_date, INTERVAL -1 Day));

select code,currencycode cy, balance bal
from romania.c_player p where date(p.signupdate) >= '2015-11-26' 
and balance > 0
#group by currencycode
*/


/*select code, balance , BONUSBALANCE
from romania.c_player p where date(p.signupdate) >= '2015-11-26' 
and balance < BONUSBALANCE */
#group by currencycode

/*select date(g.gamedate) summdate,p.currencycode cy, count(distinct p.username) uap, 
sum(bet) bet,sum(win) win, sum(bonusbet) bonusbet, sum(bonuswin) bonuswin,sum(jackpotbet) jackpotbet, sum(jackpotwin) jackpotwin
from romania.c_games g, romania.c_player p where date(p.signupdate) >= '2015-11-26' and p.code = g.playercode
and date(g.gamedate) = date_add(current_date, INTERVAL -1 Day)
group by date(g.gamedate),p.currencycode*/


/*
#kpi from rep-layer
select SummaryDate, count(distinct eg.playerID) uap,sum(cashbet+BonusBet),sum(CashWin+BonusWin),sum(BonusBet),sum(BonusWin),sum(JackpotBet),sum(JackpotWin)
from romaniamain.fd_csc_eg_player_product_info_summ eg
join romaniamain.dim_player p on eg.PlayerId = p.PlayerId and p.SignupDate>='2015-11-26'
#where SummaryDate='2016-01-06'
group by 1
order by 1;


select summdate,sum(cash_Stake) CashStake,sum(cash_winnings) cash_winnings,
sum(bonus_Stake) bonus_Stake,sum(Bonus_winnings) Bonus_winnings,
sum(cash_out_stake) cash_out_stake,sum(Cash_out_win) Cash_out_win,
sum(num_bets) num_bets,sum(stake_refunded) stake_refunded,  
sum(case is_inplay when 'N' then cash_Stake else 0 end) 	CashStakePre,
sum(case is_inplay when 'N' then cash_winnings else 0 end) 	cash_winningsPRe,
sum(case is_inplay when 'N' then bonus_Stake else 0 end) 	bonus_StakePre,
sum(case is_inplay when 'N' then Bonus_winnings else 0 end) Bonus_winningsPre,
sum(case is_inplay when 'N' then cash_out_stake else 0 end) cash_out_stakePre,
sum(case is_inplay when 'N' then Cash_out_win else 0 end) 	Cash_out_winPre,
sum(case is_inplay when 'N' then num_bets else 0 end) 		num_betsPre,
sum(case is_inplay when 'Y' then cash_Stake else 0 end) 	CashStakeLive,
sum(case is_inplay when 'Y' then cash_winnings else 0 end) 	cash_winningsLive,
sum(case is_inplay when 'Y' then bonus_Stake else 0 end) 	bonus_StakeLive,
sum(case is_inplay when 'Y' then Bonus_winnings else 0 end) Bonus_winningsLive,
sum(case is_inplay when 'Y' then cash_out_stake else 0 end) cash_out_stakeLive,
sum(case is_inplay when 'Y' then Cash_out_win else 0 end) 	Cash_out_winLive,
sum(case is_inplay when 'Y' then num_bets else 0 end) 		num_betsLive,
currencycode cy from (
select date(date_add(SettledDate, INTERVAL -2 Hour)) summdate,p.currencycode,LiveYN is_inplay,
sum(CashStake) cash_Stake,sum(CashWinnings) cash_winnings, sum(BonusStake) bonus_Stake, sum(BonusWinnings) Bonus_winnings,
sum(CashOutStake) cash_out_stake,  sum(CashOutWin) Cash_out_win, sum(NumBets) num_bets,sum(StakeRefunded) stake_refunded
from romaniamain.customer_pnl sp join romaniamain.dim_player p on p.username = sp.Username
where date(p.signupdate) >= '2015-11-26'
#and date(date_add(SettledDate, INTERVAL -2 Hour)) = date(date_add(current_date, INTERVAL -1 Day))
and sp.Username = p.username 
group by p.currencycode,LiveYN,date(date_add(SettledDate, INTERVAL -2 Hour))) sp
group by summdate,currencycode
order by 1 ;


select distinct SummaryDate from romaniamain.fd_csc_eg_player_product_info_summ order by 1;
*/

