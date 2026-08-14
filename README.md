# 🏦 Banking Transaction & Customer Analytics

## 📊 Project Overview

This is an end-to-end **Banking Analytics** project built using **SQL and Microsoft Power BI**.

The project analyzes customers, accounts, transactions, branches, and loans to identify business trends, customer behavior, transaction patterns, and loan portfolio characteristics.

The objective is to transform banking data into meaningful business insights through SQL analysis and interactive Power BI dashboards.

---

## 🎯 Business Objective

The project focuses on answering key banking business questions:

* How many customers and accounts does the bank have?
* Which account types hold the highest balances?
* What is the monthly transaction trend?
* Which transaction types generate the highest transaction value?
* Which branches generate the highest transaction value?
* Which customers have the highest account balances?
* How are transactions distributed across account types?
* How is the loan portfolio distributed across different statuses?
* Which customer and account segments contribute most to the loan portfolio?

---

## 🛠️ Tools & Technologies

* **SQL**
* **Microsoft Power BI**
* **DAX**
* **Data Modeling**
* **Data Visualization**
* **Common Table Expressions (CTEs)**
* **Window Functions**

---

# 📈 Power BI Dashboard

The Power BI dashboard contains four analytical pages covering the bank's customers, accounts, transactions, and loans.

## 🖼️ Dashboard Preview

### 1. Executive Overview

![Executive Overview](Insights/Executive_Overview.jpg)

Provides a high-level overview of:

* Customers
* Accounts
* Bank balance
* Transactions
* Loans
* Account status
* Account types
* Top customers

---

### 2. Customer Analytics

![Customer Analytics](Insights/Customer_Analytics.jpg)

Analyzes:

* Customer distribution by city
* Customer balance by city
* Customer type distribution
* Top customers by balance
* Top customers by transactions
* Customers with multiple accounts

---

### 3. Transaction Analytics

![Transaction Analytics](Insights/Transaction_Analytics.jpg)

Analyzes:

* Monthly transaction value
* Transaction value by type
* Transaction value by branch
* Account-type transaction flow
* Top transactions

---

### 4. Loan Analytics

![Loan Analytics](Insights/Loan_Analytics.jpg)

Analyzes:

* Loan value by status
* Loans by status
* Loan value by account type
* Loan interest-rate distribution
* Loan portfolio characteristics

---

# 🔍 SQL Analysis

SQL was used for data extraction, transformation, aggregation, ranking, and trend analysis.

### SQL techniques used

* Joins
* Filtering and sorting
* Aggregations
* `GROUP BY`
* `HAVING`
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* `LAG()`
* `RANK()`
* `DENSE_RANK()`
* `ROW_NUMBER()`
* Running Totals
* Month-over-Month Growth Analysis

---

# 📌 Key Business Insights

## Bank Overview

* The database contains **1,072 customers**.
* There are **1,618 accounts**.
* Total account balance is **79,210,637.78**.

## Account Analysis

* Business accounts have the highest total balance.
* Checking accounts have the lowest total balance among the five account types.
* **80.16%** of accounts are Active.
* **15.39%** are Inactive.
* **4.45%** are Closed.

## Customer Analysis

* High-value customers were identified based on total account balance.
* Customers with multiple accounts indicate higher engagement with the bank.
* Customer concentration varies across different cities.

## Transaction Analysis

* Deposit transactions have the highest total transaction value.
* Transfer transactions have the highest average transaction amount.
* Branch-level analysis identifies branches generating the highest transaction value.
* Monthly transaction analysis can be used to identify changes in transaction activity over time.

## Loan Analysis

* The loan portfolio was analyzed across different loan statuses.
* Customers can be ranked based on their total loan exposure.
* Customer type and account behavior can be used to identify important loan portfolio segments.

---

# 💡 Business Recommendations

### Customer Retention

Focus on customers with multiple accounts and high balances because they represent highly engaged customers.

### Transaction Growth

Monitor monthly transaction trends to identify periods of unusually high or low activity.

### Branch Performance

High-performing branches can be studied to identify practices that could be replicated across lower-performing branches.

### Loan Management

Customers with high loan exposure should be monitored carefully to understand portfolio concentration and risk.

### Customer Segmentation

Customer type and account behavior can be combined to create more targeted banking products and services.

---

# 📂 Project Structure

```text
Banking-Transaction-Customer-Analytics
│
├── README.md
│
├── Banking_Analytics.pbix
│
├── Dataset
│   └── Banking Dataset
│
├── SQL
│   └── SQL Analysis
│
└── Insights
    ├── Business Insights
    ├── Executive_Overview.jpg
    ├── Customer_Analytics.jpg
    ├── Transaction_Analytics.jpg
    └── Loan_Analytics.jpg
```

---

# 📁 Project Files

### Power BI Dashboard

**`Banking_Analytics.pbix`**

Contains the interactive Power BI dashboard, data model, visualizations, KPIs, and analytical pages.

### SQL Analysis

**`SQL/`**

Contains the SQL analysis used to query and analyze the banking data.

### Dataset

**`Dataset/`**

Contains the dataset used for the analysis.

### Business Insights

**`Insights/`**

Contains the documented business insights and dashboard screenshots.

---

# 🎯 Skills Demonstrated

**SQL • Power BI • DAX • Data Modeling • Data Analysis • Business Intelligence • Data Visualization • Window Functions • CTEs • Business Insights**

---

## 👤 Project Type

**Data Analytics / Business Intelligence Portfolio Project**

**Domain:** Banking & Financial Services

**Primary Tools:** SQL + Power BI
