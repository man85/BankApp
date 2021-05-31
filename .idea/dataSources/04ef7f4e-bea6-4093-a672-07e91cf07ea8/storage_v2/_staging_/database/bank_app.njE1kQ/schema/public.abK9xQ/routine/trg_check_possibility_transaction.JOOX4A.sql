create function trg_check_possibility_transaction() returns trigger
    language plpgsql
as
$$
BEGIN
    IF (SELECT a.amount_of_money FROM accounts a WHERE a.account_id = NEW.withdrawal_id)
        < NEW.amount THEN
        RAISE EXCEPTION 'There is not enough money in the account for the transaction';
    END IF;
    UPDATE accounts SET amount_of_money=(SELECT a.amount_of_money FROM accounts a WHERE a.account_id = NEW.withdrawal_id)-NEW.amount
        WHERE account_id.account_id = NEW.withdrawal_id;
    UPDATE accounts SET amount_of_money=(SELECT a.amount_of_money FROM accounts a WHERE a.account_id = NEW.deposit_id)+NEW.amount
    WHERE accounts.account_id = NEW.deposit_id;
    RETURN NEW;
END
$$;

alter function trg_check_possibility_transaction() owner to appuser;

