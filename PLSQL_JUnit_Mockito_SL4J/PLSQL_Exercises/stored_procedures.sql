-- Drop old tables if they exist (optional cleanup)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Accounts';
  EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- ============================================
-- Table Setup
-- ============================================

-- Create Accounts Table
CREATE TABLE Accounts (
    account_id     NUMBER PRIMARY KEY,
    customer_name  VARCHAR2(100),
    account_type   VARCHAR2(20),
    balance        NUMBER
);

-- Create Employees Table
CREATE TABLE Employees (
    emp_id     NUMBER PRIMARY KEY,
    name       VARCHAR2(100),
    dept_id    NUMBER,
    salary     NUMBER
);

-- Insert Sample Data
INSERT INTO Accounts VALUES (1, 'John Doe', 'savings', 1000);
INSERT INTO Accounts VALUES (2, 'Jane Smith', 'current', 5000);
INSERT INTO Accounts VALUES (3, 'Michael Roy', 'savings', 2000);
INSERT INTO Accounts VALUES (4, 'Emily Clark', 'current', 3000);

INSERT INTO Employees VALUES (101, 'Alice', 10, 40000);
INSERT INTO Employees VALUES (102, 'Bob', 10, 45000);
INSERT INTO Employees VALUES (103, 'Charlie', 20, 42000);

COMMIT;

-- ================================
-- PROCEDURE 1: ProcessMonthlyInterest
-- ================================
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    FOR rec IN (SELECT account_id, balance FROM Accounts WHERE account_type = 'savings') LOOP
        UPDATE Accounts
        SET balance = balance + (balance * 0.01)
        WHERE account_id = rec.account_id;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Monthly interest applied to savings accounts.');
END;
/

-- ================================
-- PROCEDURE 2: UpdateEmployeeBonus
-- ================================
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_dept_id IN NUMBER,
    p_bonus_pct IN NUMBER
) IS
BEGIN
    UPDATE Employees
    SET salary = salary + (salary * p_bonus_pct / 100)
    WHERE dept_id = p_dept_id;

    DBMS_OUTPUT.PUT_LINE('Bonus updated for department ' || p_dept_id);
END;
/

-- ================================
-- PROCEDURE 3: TransferFunds
-- ================================
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) IS
    v_balance NUMBER;
BEGIN
    SELECT balance INTO v_balance FROM Accounts WHERE account_id = p_from_account;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance for transfer');
    ELSE
        UPDATE Accounts
        SET balance = balance - p_amount
        WHERE account_id = p_from_account;

        UPDATE Accounts
        SET balance = balance + p_amount
        WHERE account_id = p_to_account;

        DBMS_OUTPUT.PUT_LINE('Transferred ' || p_amount || ' from Account ' || p_from_account || ' to Account ' || p_to_account);
    END IF;
END;
/

-- ================================
-- TEST EXECUTIONS
-- ================================
SET SERVEROUTPUT ON;

-- 1. Apply monthly interest to all savings accounts
EXEC ProcessMonthlyInterest;

-- 2. Add 10% bonus to employees in department 10
EXEC UpdateEmployeeBonus(10, 10);

-- 3. Transfer 500 from account 2 to account 4
EXEC TransferFunds(2, 4, 500);
