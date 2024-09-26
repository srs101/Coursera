
-- STORED PROCEDURE TO EXECUTE ACID TRANSACTION
DELIMITER $$
CREATE PROCEDURE TRANSACTION_JAMES ()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
        RESIGNAL;
	END;
    -- JAMES
    START TRANSACTION;
    -- UPDATINGING JAMES ACC
    UPDATE BankAccounts
    SET BankAccounts.Balance = BankAccounts.Balance - 4*(SELECT ShoeShop.Price FROM ShoeShop WHERE ShoeShop.Product = 'Trainers')
    WHERE BankAccounts.AccountName = 'James';
    -- UPDATING SHOE SHOP ACC
    UPDATE BankAccounts
    SET BankAccounts.Balance = BankAccounts.Balance + 4*(SELECT ShoeShop.Price FROM ShoeShop WHERE ShoeShop.Product = 'Trainers')
    WHERE BankAccounts.AccountName = 'ShoeShop';
    -- UPDATING SHOE SHOP TABLE
    UPDATE ShoeShop
    SET ShoeShop.Stock = ShoeShop.Stock - 4 
    WHERE ShoeShop.Product = 'Trainers';
    -- UPDATE JAMES ACC
    UPDATE BankAccounts
    SET BankAccounts.Balance = BankAccounts.Balance - (SELECT ShoeShop.Price FROM ShoeShop WHERE ShoeShop.Product = 'Brogues')
    WHERE BankAccounts.AccountName = 'James';
    -- UPDATE SHOE SHOP ACC
    UPDATE BankAccounts
    SET BankAccounts.Balance = BankAccounts.Balance  + (SELECT ShoeShop.Price FROM ShoeShop WHERE ShoeShop.Product = 'Brogues')
    WHERE BankAccounts.AccountName = 'ShoeShop';
    -- UPDATE SHOE SHOP TABLE
    UPDATE ShoeShop 
    SET ShoeShop.Stock = ShoeShop.Stock - 1
    WHERE ShoeShop.Product = 'Brogues'; 
	COMMIT;
END $$
DELIMITER ;

CALL TRANSACTION_JAMES()
SELECT * FROM BankAccounts;
SELECT * FROM ShoeShop;
-- NEW TRANSACTION
/*
-- STORED PROCEDURE TO EXECUTE ACID TRANSACTION
DELIMITER $$
CREATE PROCEDURE TRANSACTION_JAMES2 ()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
        RESIGNAL;
	END;
    -- JAMES
    START TRANSACTION;
    -- UPDATINGING JAMES ACC
    UPDATE BankAccounts
    SET BankAccounts.Balance = BankAccounts.Balance - 4*(SELECT ShoeShop.Price FROM ShoeShop WHERE ShoeShop.Product = 'Trainers')
    WHERE BankAccounts.AccountName = 'James';
    -- UPDATING SHOE SHOP ACC
    UPDATE BankAccounts
    SET BankAccounts.Balance = BankAccounts.Balance + 4*(SELECT ShoeShop.Price FROM ShoeShop WHERE ShoeShop.Product = 'Trainers')
    WHERE BankAccounts.AccountName = 'ShoeShop';
    -- UPDATING SHOE SHOP TABLE
    UPDATE ShoeShop
    SET ShoeShop.Stock = ShoeShop.Stock - 4 
    WHERE ShoeShop.Product = 'Trainers';
	COMMIT;
END $$
DELIMITER ;*/
-- CALL TRANSACTION_JAMES2()
SELECT * FROM BankAccounts;
SELECT * FROM ShoeShop;
