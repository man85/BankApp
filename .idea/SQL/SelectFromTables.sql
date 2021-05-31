/*-------------------------ACCOUNTS-------------------------*/
SELECT cl.name, a.amount_of_money FROM clients as cl JOIN accounts as a on cl.client_id = a.client_id;
/*-------------------------operations-------------------------*/
SELECT cl1.name as FROM, cl2.name AS TO, tr.amount FROM accounts as a1 JOIN clients as cl1 on a1.client_id = cl1.client_id JOIN transactions tr on a1.account_id = tr.withdrawal_id JOIN accounts as a2  on a2.account_id=tr.deposit_id join clients as cl2 on cl2.client_id=a2.client_id;