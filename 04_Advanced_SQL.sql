-- ============================================================
-- Banking Transaction & Customer Analytics
-- Advanced SQL Analysis
-- ============================================================

USE banking_analytics;


-- ============================================================
-- Q16. Month-over-Month Transaction Growth
-- CTE + LAG()
-- ============================================================

WITH monthly_transactions AS (
    SELECT
        YEAR(TransactionDate) AS TransactionYear,
        MONTH(TransactionDate) AS TransactionMonth,
        SUM(Amount) AS TotalTransactionValue
    FROM transactions
    GROUP BY
        YEAR(TransactionDate),
        MONTH(TransactionDate)
)

SELECT
    TransactionYear,
    TransactionMonth,
    TotalTransactionValue,

    LAG(TotalTransactionValue) OVER (
        ORDER BY TransactionYear, TransactionMonth
    ) AS PreviousMonthValue,

    ROUND(
        (
            TotalTransactionValue -
            LAG(TotalTransactionValue) OVER (
                ORDER BY TransactionYear, TransactionMonth
            )
        )
        /
        LAG(TotalTransactionValue) OVER (
            ORDER BY TransactionYear, TransactionMonth
        ) * 100,
        2
    ) AS MoM_Growth_Percentage

FROM monthly_transactions

ORDER BY
    TransactionYear,
    TransactionMonth;


-- ============================================================
-- Q17. Rank Customers by Balance
-- RANK()
-- ============================================================

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
    TotalBalance,

    RANK() OVER (
        ORDER BY TotalBalance DESC
    ) AS CustomerRank

FROM customer_balance

ORDER BY CustomerRank;


-- ============================================================
-- Q18. Unique Customer Ranking
-- ROW_NUMBER()
-- ============================================================

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
    TotalBalance,

    ROW_NUMBER() OVER (
        ORDER BY TotalBalance DESC
    ) AS CustomerRowNumber

FROM customer_balance

ORDER BY CustomerRowNumber;


-- ============================================================
-- Q19. Dense Customer Ranking
-- DENSE_RANK()
-- ============================================================

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
    TotalBalance,

    DENSE_RANK() OVER (
        ORDER BY TotalBalance DESC
    ) AS CustomerRank

FROM customer_balance

ORDER BY CustomerRank;


-- ============================================================
-- Q23. Running Transaction Total
-- SUM() Window Function
-- ============================================================

SELECT
    TransactionDate,
    TransactionID,
    Amount,

    SUM(Amount) OVER (
        ORDER BY TransactionDate, TransactionID
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS RunningTransactionTotal

FROM transactions

ORDER BY
    TransactionDate,
    TransactionID;