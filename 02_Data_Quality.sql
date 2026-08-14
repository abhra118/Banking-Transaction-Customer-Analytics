-- ============================================
-- Banking Transaction & Customer Analytics
-- Data Quality Checks
-- ============================================

USE banking_analytics;


-- ============================================
-- 1. Check Duplicate Customers
-- ============================================

SELECT
    CustomerID,
    COUNT(*) AS DuplicateCount
FROM customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;


-- ============================================
-- 2. Check Duplicate Accounts
-- ============================================

SELECT
    AccountID,
    COUNT(*) AS DuplicateCount
FROM accounts
GROUP BY AccountID
HAVING COUNT(*) > 1;


-- ============================================
-- 3. Check Duplicate Transactions
-- ============================================

SELECT
    TransactionID,
    COUNT(*) AS DuplicateCount
FROM transactions
GROUP BY TransactionID
HAVING COUNT(*) > 1;


-- ============================================
-- 4. Check NULL Transaction Amounts
-- ============================================

SELECT
    COUNT(*) AS NullAmountCount
FROM transactions
WHERE Amount IS NULL;


-- ============================================
-- 5. Check Invalid Transaction Amounts
-- ============================================

SELECT
    COUNT(*) AS InvalidAmountCount
FROM transactions
WHERE Amount <= 0;


-- ============================================
-- 6. Check Invalid Customer References
-- ============================================

SELECT COUNT(*) AS InvalidCustomerIDs
FROM accounts a
LEFT JOIN customers c
    ON a.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


-- ============================================
-- 7. Check Invalid Account References
-- ============================================

SELECT COUNT(*) AS InvalidAccountIDs
FROM loans l
LEFT JOIN accounts a
    ON l.AccountID = a.AccountID
WHERE a.AccountID IS NULL;


-- ============================================
-- 8. Check Invalid Transaction Type References
-- ============================================

SELECT COUNT(*) AS InvalidTransactionTypes
FROM transactions t
LEFT JOIN transaction_types tt
    ON t.TransactionTypeID = tt.TransactionTypeID
WHERE tt.TransactionTypeID IS NULL;


-- ============================================
-- 9. Check Invalid Branch References
-- ============================================

SELECT COUNT(*) AS InvalidBranchIDs
FROM transactions t
LEFT JOIN branches b
    ON t.BranchID = b.BranchID
WHERE b.BranchID IS NULL;