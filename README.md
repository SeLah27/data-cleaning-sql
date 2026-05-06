# 🧹 Data Cleaning in SQL — Nashville Housing Dataset

## 📌 Project Overview
This project focuses on cleaning and transforming the **Nashville Housing dataset** using SQL Server.
The goal is to prepare raw, messy real-estate data into a structured, analysis-ready format following industry best practices.

---

## 🛠️ Tools Used
- **SQL Server / SSMS** (SQL Server Management Studio)
- **Nashville Housing Dataset** (publicly available)

---

## 🔧 Data Cleaning Steps Performed

### 1. 📅 Standardize Date Formatting
- Converted `SaleDate` column to a consistent `DATE` format
- Removed unnecessary timestamp components

### 2. 🏠 Populate Property Address Column
- Identified rows with NULL `PropertyAddress` values
- Used self-JOIN to fill in missing addresses based on matching `ParcelID`

### 3. 📍 Break Out Address into Individual Columns
- Split the full address into separate columns:
  - `Address`
  - `City`
  - `State`
- Used `SUBSTRING` and `PARSENAME` functions for the split

### 4. ✅ Replace Y/N with YES/NO in "Sold As Vacant" Field
- Standardized inconsistent values in the `SoldAsVacant` column
- Replaced `'Y'` → `'YES'` and `'N'` → `'NO'` using `CASE` statement

### 5. 🗑️ Remove Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY` to identify and remove duplicate records

### 6. 🧽 Remove Unused Columns
- Dropped columns that were no longer needed after transformation
- Kept the dataset clean and optimized for analysis

---

## 💡 Key SQL Concepts Used
- `ALTER TABLE` / `UPDATE`
- `SELF JOIN`
- `SUBSTRING`, `CHARINDEX`, `PARSENAME`
- `CASE` statements
- `ROW_NUMBER()` with `PARTITION BY`
- `CTE` (Common Table Expressions)
- `DROP COLUMN`

---
