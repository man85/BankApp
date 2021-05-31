/*================USERS==============================*/
/*-----Normal INSERT --------------------------------*/
INSERT INTO clients(name,address,age,password,nip) VALUES
    ('Victor','Lyuzikova str Voronezh',28,'qwerty1',344343),
    ('Nicola','Lyuzikova str Voronezh',28,'qwerty1',344344),
    ('Alexander','Lyuzikova str Voronezh',28,'qwerty1',344345);
/*-----Try toinsert with negative age----------------*/
--INSERT INTO clients(name,address,age,password,nip) VALUES
--('Slava1','Lyuzikova str Voronezh',-10,'qwerty1',344343);

/*-----Try INSERT without password-------------------*/

/*-----Try insert with non-unique name---------------*/

/*-----Try INSERT with explicit primary key----------*/

/*=================ACCOUNTS==========================*/
INSERT INTO accounts(client_id,amount_of_money,account_type) VALUES
     ((SELECT client_id FROM clients WHERE name='Nicola'),90,'saving'),
     ((SELECT client_id FROM clients WHERE name='Alexander'),100,'saving');
/*----Insert with default balance--------------------*/
INSERT INTO accounts(client_id,account_type) VALUES
((SELECT client_id FROM clients WHERE name='Victor'),'saving'),
((SELECT client_id FROM clients WHERE name='Julia'),'saving');

/*----Insert with non-existent user--------------------*/

/*================Operations==========================*/
/*------100 Alexander->Victor-----------*/
INSERT INTO transactions(withdrawal_id,deposit_id,amount,t_time) VALUES (
     (SELECT account_id  FROM accounts JOIN clients cl on accounts.client_id = cl.client_id WHERE cl.name='Alexander' LIMIT 1),
     (SELECT account_id  FROM accounts JOIN clients cl on accounts.client_id = cl.client_id WHERE cl.name='Victor' LIMIT 1),
     100,
     now()
);
/*------100 Nicola->Alexander-------------------*/
INSERT INTO transactions(withdrawal_id,deposit_id,amount,t_time) VALUES (
     (SELECT account_id  FROM accounts JOIN clients cl on accounts.client_id = cl.client_id WHERE cl.name='Nicola' LIMIT 1),
     (SELECT account_id  FROM accounts JOIN clients cl on accounts.client_id = cl.client_id WHERE cl.name='Alexander' LIMIT 1),
     100,
     now()
);
