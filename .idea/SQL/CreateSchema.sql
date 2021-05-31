CREATE TABLE IF NOT EXISTS clients(
    client_id INT GENERATED ALWAYS AS IDENTITY ,
    name VARCHAR(30) NOT NULL UNIQUE,
    address VARCHAR(30),
    age numeric,
    password VARCHAR(30) NOT NULL,
    nip numeric,
    pesel numeric,
    PRIMARY KEY (client_id),
    CONSTRAINT age_not_negative check ( age >=0 )
);

CREATE TABLE IF NOT EXISTS carriers(
    carrier_id INT GENERATED ALWAYS AS IDENTITY ,
    name VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL
);

CREATE TYPE type_of_account AS ENUM ('saving', 'current');
CREATE TABLE IF NOT EXISTS accounts(
    account_id INT GENERATED ALWAYS AS IDENTITY,
    client_id INT,
    amount_of_money numeric DEFAULT 0,
    account_type type_of_account,
    interest_rate numeric,
    CONSTRAINT interest_rate_not_negative check ( interest_rate >=0 ),
    CONSTRAINT interest_rate_can_be_used_for_current_account check ( (interest_rate >0 AND account_type='current')or account_type='saving'),
    CONSTRAINT not_negative_amount_for_saving_account check ( (amount_of_money>=0 AND account_type='saving')or account_type='current'),
    PRIMARY KEY (account_id),
    CONSTRAINT fk_client
        FOREIGN KEY(client_id)
            REFERENCES clients(client_id)
            ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS transactions(
    transaction_id INT GENERATED ALWAYS AS IDENTITY,
    withdrawal_id INT,
    deposit_id INT,
    amount numeric NOT NULL,
    t_time timestamp,
    PRIMARY KEY (transaction_id),
    CONSTRAINT fk_withdrawal
        FOREIGN KEY(withdrawal_id)
            REFERENCES accounts(account_id)
            ON DELETE SET NULL,
    CONSTRAINT fk_deposit
            FOREIGN KEY(deposit_id)
            REFERENCES accounts(account_id)
            ON DELETE SET NULL

);

CREATE FUNCTION trg_check_possibility_transaction()
    RETURNS trigger AS
$func$
BEGIN
    IF (SELECT a.amount_of_money FROM accounts a WHERE a.account_id = NEW.withdrawal_id)
        < NEW.amount THEN
        RAISE EXCEPTION 'There is not enough money in the account for the transaction';
    END IF;
    UPDATE accounts SET amount_of_money=(SELECT a.amount_of_money FROM accounts a WHERE a.account_id = NEW.withdrawal_id)-NEW.amount
        WHERE accounts.account_id = NEW.withdrawal_id;
    UPDATE accounts SET amount_of_money=(SELECT a.amount_of_money FROM accounts a WHERE a.account_id = NEW.deposit_id)+NEW.amount
    WHERE accounts.account_id = NEW.deposit_id;
    RETURN NEW;
END
$func$  LANGUAGE plpgsql;

CREATE TRIGGER insbef_check
BEFORE INSERT ON "transactions"
FOR EACH ROW EXECUTE PROCEDURE trg_check_possibility_transaction();