-- ============================================================
-- Banking Transaction & Customer Analytics
-- Business Analysis
-- ============================================================

USE banking_analytics;


-- ============================================================
-- SECTION 1: BANK OVERVIEW
-- ============================================================

-- Q1. Total Customers

SELECT
    COUNT(*) AS TotalCustomers
FROM customers;


-- Q2. Total Accounts

SELECT
    COUNT(*) AS TotalAccounts
FROM accounts;


-- Q3. Total Bank Balance

SELECT
    SUM(Balance) AS TotalBankBalance
FROM accounts;


-- ============================================================
-- SECTION 2: ACCOUNT ANALYSIS
-- ============================================================

-- Q4. Accounts and Balance by Account Type

SELECT
    at.TypeName AS AccountType,
    COUNT(a.AccountID) AS TotalAccounts,
    SUM(a.Balance) AS TotalBalance
FROM accounts a
INNER JOIN account_types at
    ON a.AccountTypeID = at.AccountTypeID
GROUP BY at.TypeName
ORDER BY TotalBalance DESC;


-- Q5. Balance Contribution by Account Type

SELECT
    at.TypeName AS AccountType,
    COUNT(a.AccountID) AS TotalAccounts,
    SUM(a.Balance) AS TotalBalance,
    ROUND(
        SUM(a.Balance) /
        (SELECT SUM(Balance) FROM accounts) * 100,
        2
    ) AS BalancePercentage
FROM accounts a
INNER JOIN account_types at
    ON a.AccountTypeID = at.AccountTypeID
GROUP BY at.TypeName
ORDER BY BalancePercentage DESC;


-- Q6. Active vs Inactive Accounts

SELECT
    ast.StatusName AS AccountStatus,
    COUNT(a.AccountID) AS TotalAccounts,
    ROUND(
        COUNT(a.AccountID) * 100.0 /
        (SELECT COUNT(*) FROM accounts),
        2
    ) AS AccountPercentage
FROM accounts a
INNER JOIN account_statuses ast
    ON a.AccountStatusID = ast.AccountStatusID
GROUP BY ast.StatusName
ORDER BY TotalAccounts DESC;


-- ============================================================
-- SECTION 3: CUSTOMER ANALYSIS
-- ============================================================

-- Q7. Top 10 Customers by Total Balance

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(a.AccountID) AS NumberOfAccounts,
    SUM(a.Balance) AS TotalBalance
FROM customers c
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalBalance DESC
LIMIT 10;


-- Q8. Customers by City

SELECT
    a.City,
    a.Country,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers
FROM customers c
INNER JOIN addresses a
    ON c.AddressID = a.AddressID
GROUP BY
    a.City,
    a.Country
ORDER BY TotalCustomers DESC;


-- Q20. Customers with Multiple Accounts

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(a.AccountID) AS NumberOfAccounts,
    SUM(a.Balance) AS TotalBalance
FROM customers c
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING COUNT(a.AccountID) > 1
ORDER BY NumberOfAccounts DESC, TotalBalance DESC;


-- Q22. High-Value Customers

WITH customer_balance AS (
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(a.Balance) AS TotalBalance
    FROM customers c
    INNER JOIN accounts a
        ON c.CustomerID = a.CustomerID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)

SELECT
    CustomerID,
    CustomerName,
    TotalBalance
FROM customer_balance
WHERE TotalBalance > (
    SELECT AVG(TotalBalance)
    FROM customer_balance
)
ORDER BY TotalBalance DESC;


-- ============================================================
-- SECTION 4: TRANSACTION ANALYSIS
-- ============================================================

-- Q9. Transaction Type Analysis

SELECT
    tt.TypeName AS TransactionType,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(t.Amount) AS TotalTransactionValue,
    ROUND(AVG(t.Amount), 2) AS AverageTransactionAmount
FROM transactions t
INNER JOIN transaction_types tt
    ON t.TransactionTypeID = tt.TransactionTypeID
GROUP BY tt.TypeName
ORDER BY TotalTransactionValue DESC;


-- Q10. Branch Performance

SELECT
    b.BranchID,
    b.BranchName,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(t.Amount) AS TotalTransactionValue,
    ROUND(AVG(t.Amount), 2) AS AverageTransactionAmount
FROM transactions t
INNER JOIN branches b
    ON t.BranchID = b.BranchID
GROUP BY
    b.BranchID,
    b.BranchName
ORDER BY TotalTransactionValue DESC;


-- Q11. Top 10 Branches by Transaction Value

SELECT
    b.BranchID,
    b.BranchName,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(t.Amount) AS TotalTransactionValue
FROM transactions t
INNER JOIN branches b
    ON t.BranchID = b.BranchID
GROUP BY
    b.BranchID,
    b.BranchName
ORDER BY TotalTransactionValue DESC
LIMIT 10;


-- Q15. Monthly Transaction Analysis

SELECT
    YEAR(TransactionDate) AS TransactionYear,
    MONTH(TransactionDate) AS TransactionMonth,
    COUNT(TransactionID) AS TotalTransactions,
    SUM(Amount) AS TotalTransactionValue,
    ROUND(AVG(Amount), 2) AS AverageTransactionAmount
FROM transactions
GROUP BY
    YEAR(TransactionDate),
    MONTH(TransactionDate)
ORDER BY
    TransactionYear,
    TransactionMonth;


-- Q24. Top 10 Customers by Transaction Activity

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT t.TransactionID) AS TotalTransactions,
    SUM(t.Amount) AS TotalTransactionValue,
    ROUND(AVG(t.Amount), 2) AS AverageTransactionAmount
FROM customers c
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN transactions t
    ON a.AccountID = t.AccountOriginID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalTransactionValue DESC
LIMIT 10;


-- ============================================================
-- SECTION 5: LOAN ANALYSIS
-- ============================================================

-- Q12. Loan Portfolio by Status

SELECT
    ls.StatusName AS LoanStatus,
    COUNT(l.LoanID) AS TotalLoans,
    SUM(l.PrincipalAmount) AS TotalPrincipal,
    ROUND(AVG(l.PrincipalAmount), 2) AS AverageLoanAmount
FROM loans l
INNER JOIN loan_statuses ls
    ON l.LoanStatusID = ls.LoanStatusID
GROUP BY ls.StatusName
ORDER BY TotalPrincipal DESC;


-- Q13. Top 10 Customers by Loan Exposure

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(l.LoanID) AS TotalLoans,
    SUM(l.PrincipalAmount) AS TotalLoanExposure
FROM customers c
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN loans l
    ON a.AccountID = l.AccountID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalLoanExposure DESC
LIMIT 10;


-- Q14. Loan Exposure by Customer Type

SELECT
    ct.TypeName AS CustomerType,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(l.LoanID) AS TotalLoans,
    SUM(l.PrincipalAmount) AS TotalLoanExposure,
    ROUND(AVG(l.PrincipalAmount), 2) AS AverageLoanAmount
FROM customers c
INNER JOIN customer_types ct
    ON c.CustomerTypeID = ct.CustomerTypeID
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN loans l
    ON a.AccountID = l.AccountID
GROUP BY ct.TypeName
ORDER BY TotalLoanExposure DESC;


-- ============================================================
-- SECTION 6: CUSTOMER 360 ANALYSIS
-- ============================================================

-- Q21. Customers with Both Loans and Transactions

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT l.LoanID) AS TotalLoans,
    COUNT(DISTINCT t.TransactionID) AS TotalTransactions,
    SUM(DISTINCT l.PrincipalAmount) AS LoanExposure
FROM customers c
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN loans l
    ON a.AccountID = l.AccountID
INNER JOIN transactions t
    ON a.AccountID = t.AccountOriginID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY LoanExposure DESC;


-- Q25. Customer 360 Banking Analysis

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT a.AccountID) AS TotalAccounts,
    COALESCE(SUM(DISTINCT a.Balance), 0) AS TotalBalance,
    COUNT(DISTINCT t.TransactionID) AS TotalTransactions,
    COALESCE(SUM(DISTINCT l.PrincipalAmount), 0) AS TotalLoanExposure
FROM customers c
LEFT JOIN accounts a
    ON c.CustomerID = a.CustomerID
LEFT JOIN transactions t
    ON a.AccountID = t.AccountOriginID
LEFT JOIN loans l
    ON a.AccountID = l.AccountID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalBalance DESC;