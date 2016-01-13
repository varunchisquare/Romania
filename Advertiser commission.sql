select advcode, advEmail,advChannel,advUsername,
count(CountablePlyrs) TotalPlayers,    
count(ftd) PlayersWithFTD,
sum(CountablePlyrs) ConvertedPlayers,
case when sum(CountablePlyrs) = 6 then 50
	 when sum(CountablePlyrs) < 6 then 0
     when sum(CountablePlyrs) > 6 then  (sum(CountablePlyrs)-6)*10 + 50 end totalCommission 
from 
(select p.PlayerID,p.GlobalFirstDepositDate ftd,p.username,adv.email advEmail,advUsername,
case when lower(adv.email) = 'agentii@efortuna.ro' then 'RETAIL'
when lower(adv.email) like 'iulian.dumitru@efortuna.ro' or lower(adv.email) like 'superpont1x2@gmail.com' then 'DIGITAL'
when lower(adv.email) like 'defaulte8' then 'Generic'
else 'AFFILIATE' end advChannel,advCode,  cas.TotalDepApproveAmt, b.TotalCashStake,
case when cas.TotalDepApproveAmt >= 50 and b.TotalCashStake >= 150 then 1 else 0 end CountablePlyrs
from romaniastg.stg_ims_player p
left outer join (select ns.username,coalesce(ad.email,affiliate) email, ad.code advCode, ad.username advUsername
from romaniastg.IMS_newSignup ns
left outer join romaniastg.advertisers ad on ns.affiliate = ad.username) adv on (adv.username = p.username)
left outer join (SELECT PlayerId,sum(TotalDepApproveAmt) TotalDepApproveAmt 
FROM romaniamain.sd_daily_cashier_summary
group by PlayerId) as cas on cas.PlayerId = p.playerid 
left outer join (select PlayerId,sum(SPCashStakeAmt) TotalCashStake
from romaniamain.sd_cv_daily_player_summary
group by PlayerId) as b on b.PlayerId = p.playerid
where p.signupdate >= '2015-11-26'
) ov
where lower(advEmail) = 'agentii@efortuna.ro'
group by advcode,advEmail,advChannel,advUsername
order by 5 desc;


