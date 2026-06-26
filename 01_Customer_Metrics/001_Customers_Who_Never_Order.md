# 001. Customers Who Never Order

**Difficulty:** Easy

**Category:** Customer Metrics

---

## 📖 Problem

Find the names of customers who have **never placed an order**.

Return the result in any order.

---

## 🏢 Business Scenario

An e-commerce company wants to identify customers who have never made a purchase. These customers can be targeted with promotional emails, discount coupons, or personalized marketing campaigns to encourage their first order.

---

## 🗄️ Schema

### Customers

| Column | Type | Description |
|---------|------|-------------|
| id | INT | Primary Key |
| name | VARCHAR | Customer name |

### Orders

| Column | Type | Description |
|---------|------|-------------|
| id | INT | Primary Key |
| customerId | INT | Foreign Key referencing `Customers.id` |

---

## 📊 Sample Data

### Customers

| id | name |
|---:|------|
|1|Joe|
|2|Henry|
|3|Sam|
|4|Max|

### Orders

| id | customerId |
|---:|-----------:|
|1|3|
|2|1|

---

## 🎯 Expected Output

| Customers |
|-----------|
|Henry|
|Max|

---

## 💡 Output Explanation

- **Joe** placed an order, so he is excluded.
- **Sam** placed an order, so he is excluded.
- **Henry** has no matching record in the `Orders` table, so he is included.
- **Max** has no matching record in the `Orders` table, so he is included.

---

## 💭 Approach

Use a **LEFT JOIN** to keep all customers. Customers who never placed an order will have `NULL` values for the columns from the `Orders` table. Filter those rows using `IS NULL`.

---

## ✅ Solution

```sql
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;
```

**Explanation**

- Start with all customers.
- LEFT JOIN keeps every customer even if no order exists.
- Customers without orders have `NULL` in `o.customerId`.
- Filter those rows using `IS NULL`.

---

## 🚀 Alternative Solution

```sql
SELECT name
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customerId = c.id
);
```

**Explanation**

For each customer, check whether an order exists. Return only customers for whom no matching order is found.

---

## ⚠️ Common Mistakes

- Using **INNER JOIN**, which excludes customers without orders.
- Using `= NULL` instead of `IS NULL`.
- Using `NOT IN` without considering `NULL` values in the subquery.

---

## 📝 Key Takeaways

- `LEFT JOIN` retains all rows from the left table.
- `IS NULL` is commonly used to find unmatched rows.
- `NOT EXISTS` is another common way to perform an anti-join.
- This pattern is frequently used to find missing or unmatched records.

---

## 💻 Practice Schema

```sql
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customerId INT,
    FOREIGN KEY (customerId) REFERENCES Customers(id)
);

INSERT INTO Customers VALUES
(1,'Joe'),
(2,'Henry'),
(3,'Sam'),
(4,'Max');

INSERT INTO Orders VALUES
(1,3),
(2,1);
```