/*-------------------------ACCOUNTS-------------------------*/
SELECT u1.name, a.balance FROM users as u1 JOIN accounts as a on u1.user_id = a.user_id;
/*-------------------------operations-------------------------*/
SELECT u1.name as FROM, u2.name AS TO, o.amount FROM accounts as a1 JOIN users as u1 on a1.user_id = u1.user_id JOIN operations o on a1.account_id = o.withdrawal_id JOIN accounts as a2  on a2.account_id=o.deposit_id join users as u2 on u2.user_id=a2.user_id;