-- Drop tables if they already exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Loans';
  EXECUTE IMMEDIATE 'DROP TABLE Customers';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

-- Create Customers table
CREATE TABLE Customers (
  customer_id   NUMBER PRIMARY KEY,
  name          VARCHAR2(100),
  age           NUMBER,
  balance       NUMBER,
  isVIP         VARCHAR2(5)
);

-- Create Loans table
CREATE TABLE Loans (
  loan_id        NUMBER PRIMARY KEY,
  customer_id    NUMBER,
  due_date       DATE,
  interest_rate  NUMBER,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert sample customers
INSERT INTO Customers VALUES (1, 'John Doe', 65, 12000, 'FALSE');
INSERT INTO Customers VALUES (2, 'Jane Smith', 45, 8000, 'FALSE');
INSERT INTO Customers VALUES (3, 'Michael Roy', 70, 15000, 'FALSE');

-- Insert sample loans
INSERT INTO Loans VALUES (101, 1, SYSDATE + 10, 7.5);
INSERT INTO Loans VALUES (102, 2, SYSDATE + 40, 6.0);
INSERT INTO Loans VALUES (103, 3, SYSDATE + 25, 8.0);

COMMIT;
SET SERVEROUTPUT ON;
-- ========================================
-- Scenario 1: Apply 1% discount to loan interest for customers over 60
-- ========================================
BEGIN
  FOR rec IN (SELECT customer_id FROM Customers WHERE age > 60) LOOP
    UPDATE Loans
    SET interest_rate = interest_rate - 1
    WHERE customer_id = rec.customer_id;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Discount applied to customers over 60.');
END;
/

-- ========================================
-- Scenario 2: Mark customers with balance > 10000 as VIP
-- ========================================
BEGIN
  FOR rec IN (SELECT customer_id FROM Customers WHERE balance > 10000) LOOP
    UPDATE Customers
    SET isVIP = 'TRUE'
    WHERE customer_id = rec.customer_id;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('VIP status updated for eligible customers.');
END;
/

-- ========================================
-- Scenario 3: Send reminders for loans due in the next 30 days
-- ========================================
BEGIN
  FOR rec IN (
    SELECT l.loan_id, c.name, l.due_date
    FROM Loans l
    JOIN Customers c ON l.customer_id = c.customer_id
    WHERE l.due_date BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || rec.loan_id || ' for ' || rec.name || 
    ' is due on ' || TO_CHAR(rec.due_date, 'DD-Mon-YYYY'));
  END LOOP;
END;
/




