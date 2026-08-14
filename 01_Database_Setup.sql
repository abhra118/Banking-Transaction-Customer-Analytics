-- ============================================
-- Banking Transaction & Customer Analytics
-- Database Setup
-- ============================================

CREATE DATABASE IF NOT EXISTS banking_analytics;

USE banking_analytics;


-- ============================================
-- 1. Account Statuses
-- ============================================

CREATE TABLE account_statuses (
    AccountStatusID INT PRIMARY KEY,
    StatusName VARCHAR(50)
);


-- ============================================
-- 2. Account Types
-- ============================================

CREATE TABLE account_types (
    AccountTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
);


-- ============================================
-- 3. Customer Types
-- ============================================

CREATE TABLE customer_types (
    CustomerTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
);


-- ============================================
-- 4. Addresses
-- ============================================

CREATE TABLE addresses (
    AddressID INT PRIMARY KEY,
    Street VARCHAR(255),
    City VARCHAR(100),
    Country VARCHAR(100)
);


-- ============================================
-- 5. Branches
-- ============================================

CREATE TABLE branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    AddressID INT
);


-- ============================================
-- 6. Customers
-- ============================================

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    AddressID INT,
    CustomerTypeID INT
);


-- ============================================
-- 7. Loan Statuses
-- ============================================

CREATE TABLE loan_statuses (
    LoanStatusID INT PRIMARY KEY,
    StatusName VARCHAR(50)
);


-- ============================================
-- 8. Transaction Types
-- ============================================

CREATE TABLE transaction_types (
    TransactionTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
);


-- ============================================
-- 9. Accounts
-- ============================================

CREATE TABLE accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountTypeID INT,
    AccountStatusID INT,
    Balance DECIMAL(15,2),
    OpeningDate DATE
);


-- ============================================
-- 10. Loans
-- ============================================

CREATE TABLE loans (
    LoanID INT PRIMARY KEY,
    AccountID INT,
    LoanStatusID INT,
    PrincipalAmount DECIMAL(15,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EstimatedEndDate DATE
);


-- ============================================
-- 11. Transactions
-- ============================================

CREATE TABLE transactions (
    TransactionID INT PRIMARY KEY,
    AccountOriginID INT,
    AccountDestinationID INT,
    TransactionTypeID INT,
    Amount DECIMAL(15,2),
    TransactionDate DATE,
    BranchID INT,
    Description VARCHAR(255)
);