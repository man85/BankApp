/*================USERS==============================*/
/*-----Normal INSERT --------------------------------*/
INSERT INTO users(name,password,is_admin) VALUES ('Alexander','qwerty',FALSE);
INSERT INTO users(name,password,is_admin) VALUES ('Victor','qwerty1',FALSE);
INSERT INTO users(name,password,is_admin) VALUES ('Nicola','qwerty1',FALSE);
/*-----Try INSERT without password-------------------*/
--INSERT INTO users(name,is_admin) VALUES ('Alexander',FALSE);
/*-----Try insert with non-unique name---------------*/
--INSERT INTO users(name,password,is_admin) VALUES ('Alexander','qwerty',FALSE);
/*-----Try INSERT with explicit primary key----------*/
--INSERT INTO users(user_id,name,is_admin) VALUES (1,'Juliana',FALSE);
/*=================ACCOUNTS==========================*/
INSERT INTO accounts(user_id,balance) VALUES (
     (SELECT user_id FROM users WHERE name='Nicola'),
     90
);
INSERT INTO accounts(user_id,balance) VALUES (
     (SELECT user_id FROM users WHERE name='Alexander'),
     100
);
/*----Insert with default balance--------------------*/
INSERT INTO accounts(user_id) VALUES (
      (SELECT user_id FROM users WHERE name='Alexander')
);
INSERT INTO accounts(user_id) VALUES (
      (SELECT user_id FROM users WHERE name='Victor')
);
INSERT INTO accounts(user_id) VALUES (
      (SELECT user_id FROM users WHERE name='Juliana')
);
/*----Insert with non-existent user--------------------*/
--INSERT INTO accounts(user_id,balance) VALUES (0,0);
/*================Operations==========================*/
/*------100 Alexander->Victor-----------*/
INSERT INTO operations(withdrawal_id, withdrawal_is_external,deposit_id, deposit_is_external,amount) VALUES (
     (SELECT account_id  FROM accounts JOIN users u on accounts.user_id = u.user_id WHERE u.name='Alexander' LIMIT 1),
     FALSE,
     (SELECT account_id  FROM accounts JOIN users u on accounts.user_id = u.user_id WHERE u.name='Victor' LIMIT 1),
     FALSE,
     100
)

