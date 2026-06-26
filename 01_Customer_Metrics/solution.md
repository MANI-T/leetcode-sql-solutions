# 001. Customers Who Never Order

**LeetCode:** 
**Difficulty:** Easy  
**Category:** Customer Metrics

---

# 📖 Problem Statement

Find all customers who have **never placed an order**.

Return the result in **any order**.

---

# 🏢 Business Scenario

An e-commerce company wants to identify customers who have never purchased anything so they can send promotional coupons.

---

# 🗄️ Database Schema

## Customers

| Column | Type | Description |
|---------|------|-------------|
| id | INT | Primary Key |
| name | VARCHAR | Customer Name |

## Orders

| Column | Type | Description |
|---------|------|-------------|
| id | INT | Primary Key |
| customerId | INT | Foreign Key → Customers.id |

---

# 📊 Sample Data

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

# 🎯 Expected Output

| Customers |
|-----------|
|Henry|
|Max|

---

# 💡 Why?

Let's understand the data.

| Customer | Ordered? | Result |
|----------|----------|--------|
|Joe|✅ Yes|❌ Excluded|
|Henry|❌ No|✅ Included|
|Sam|✅ Yes|❌ Excluded|
|Max|❌ No|✅ Included|

Therefore, the answer is:

- Henry
- Max

---

# 🧠 Think Before Coding

Ask yourself:

- Which JOIN keeps all customers?
- How can I identify customers with no matching order?
- Can this be solved without using JOIN?

---

# ✅ Solution 1 (LEFT JOIN)

```sql
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;
```

### Explanation

1. Start with **Customers**.
2. LEFT JOIN keeps every customer.
3. Customers without orders get **NULL** values.
4. Filter those NULL rows.

---

# ✅ Solution 2 (NOT EXISTS)

```sql
SELECT name
FROM Customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE o.customerId = c.id
);
```

### Explanation

For every customer,

- check whether an order exists.
- if no order exists, return that customer.

# ⚠️ Common Mistakes

❌ Using INNER JOIN

```sql
SELECT *
FROM Customers c
INNER JOIN Orders o
ON c.id=o.customerId;
```

This removes customers who never ordered.

---

❌ Using NOT IN when NULL values are present

```sql
WHERE id NOT IN (...)
```

This can produce incorrect results if the subquery returns NULLs.

---

# 💼 Interview Discussion

The interviewer may ask:

- Why LEFT JOIN instead of INNER JOIN?
- LEFT JOIN vs NOT EXISTS?
- What happens if Orders.customerId contains NULL?
- Which solution performs better on large tables?

---

# 📝 Key Takeaways

- LEFT JOIN preserves unmatched rows.
- NULL indicates no matching record.
- Anti-joins are commonly solved using:
    - LEFT JOIN + IS NULL
    - NOT EXISTS

---

# 💻 Practice Schema

```sql
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Customers(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Orders(
    id INT PRIMARY KEY,
    customerId INT
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