DROP TABLE IF EXISTS account;

CREATE TABLE account (id SERIAL PRIMARY KEY, pseudo TEXT, mail TEXT);

CREATE OR REPLACE FUNCTION ADD_ACCOUNT(PSEUDO TEXT, MAIL TEXT) RETURNS boolean AS
$$
BEGIN
    IF NOT EXISTS (SELECT * FROM account WHERE account.pseudo = ADD_ACCOUNT.PSEUDO) THEN
        INSERT INTO account (pseudo, mail) VALUES (ADD_ACCOUNT.PSEUDO, ADD_ACCOUNT.MAIL);
        RETURN FOUND;
    END IF;
    RETURN false;
END;
$$ LANGUAGE plpgsql;
