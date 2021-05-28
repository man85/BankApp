CREATE TABLE IF NOT EXISTS users(
    user_id INT GENERATED ALWAYS AS IDENTITY ,
    name VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    is_admin boolean DEFAULT false,
    PRIMARY KEY (user_id)
);
CREATE TABLE IF NOT EXISTS accounts(
    account_id INT GENERATED ALWAYS AS IDENTITY,
    user_id INT,
    balance numeric DEFAULT 0,
    PRIMARY KEY (account_id),
    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
            REFERENCES users(user_id)
            ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS operations(
    operation_id INT GENERATED ALWAYS AS IDENTITY,
    withdrawal_id INT,
    withdrawal_is_external boolean DEFAULT FALSE,
    deposit_id INT,
    deposit_is_external boolean DEFAULT FALSE,
    amount numeric NOT NULL,
    o_time timestamp,
    PRIMARY KEY (operation_id),
    CONSTRAINT fk_withdrawal
        FOREIGN KEY(withdrawal_id)
            REFERENCES accounts(account_id)
            ON DELETE SET NULL,
    CONSTRAINT fk_deposit
            FOREIGN KEY(deposit_id)
            REFERENCES accounts(account_id)
            ON DELETE SET NULL

);
