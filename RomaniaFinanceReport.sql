--Report1: Customer Withdrawals:
select date(AcceptDate) 'Data of transaction', null as 'Transaction details',null 'BENEFICIAR_PLATITOR',
CASHIERTRANID as 'No / code of transaction', 
case METHOD when 'CASH' then 'CASH' else 'CARD' end as 'Type of transaction',
CurrencyCode as 'CreditCurrencyCode', sum(amount) 'CreditValue', 'n/a' as 'CreditExchangeRate', sum(bc_amount) as 'EquivalentPostingValue',
PlayerCode as 'Partner',null 'Partner_Code',
case clientType when 'casino' then 'online gaming' when 'sportsbook' then 'online bet' else clientType end as 'Cod center'
from romania.stg_player_payment pp
left outer join romania.stg_player pl on pl.code = pp.playercode
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
from romania.stg_player_payment pp
left outer join romania.stg_player pl on pl.code = pp.playercode
where status = 'approved' and type = 'deposit'
group by date(AcceptDate),CASHIERTRANID,
case METHOD when 'CASH' then 'CASH' else 'CARD' end,
CurrencyCode,PlayerCode,
case clientType when 'casino' then 'online gaming' when 'sportsbook' then 'online bet' else clientType end;
