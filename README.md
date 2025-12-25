# 🚗 Vehicle Rental System – Database Design & SQL Queries

## 📌 Project Overview

This project implements a **Vehicle Rental System database** using SQL.
It demonstrates **database design, relationships, and SQL querying techniques** such as `JOIN`, `EXISTS`, `WHERE`, `GROUP BY`, and `HAVING`.

The system manages:

* Users (Admin & Customer)
* Vehicles (Cars, Bikes, Trucks)
* Bookings (Rental records)

---

## 🎯 Objectives

* Design relational tables with **Primary Keys and Foreign Keys**
* Implement **One-to-Many relationships**
* Insert realistic sample data
* Write SQL queries to retrieve meaningful business information

---

## 🗄️ Database Schema

### 1️⃣ Users Table

Stores system users.

**Fields:**

* `user_id` (Primary Key)
* `name`
* `email` (Unique)
* `password`
* `phone`
* `role` (Admin / Customer)

---

### 2️⃣ Vehicles Table

Stores vehicle information.

**Fields:**

* `vehicle_id` (Primary Key)
* `name`
* `type` (car / bike / truck)
* `model`
* `registration_number` (Unique)
* `rental_price`
* `status` (available / rented / maintenance)

---

### 3️⃣ Bookings Table

Stores rental bookings.

**Fields:**

* `booking_id` (Primary Key)
* `user_id` (Foreign Key → Users)
* `vehicle_id` (Foreign Key → Vehicles)
* `start_date`
* `end_date`
* `status` (pending / confirmed / completed / cancelled)
* `total_cost`

---

## 🔗 Relationships

* **One User → Many Bookings**
* **One Vehicle → Many Bookings**
* Each booking is linked to **exactly one user and one vehicle**

---

## 🧪 Sample Data

* 10 users
* 10 vehicles
* 10 bookings
  Inserted to simulate real-world usage scenarios.

---

## 🧾 SQL Queries & Explanations

All queries are included in **`queries.sql`**.

---

### 🔹 Query 1: INNER JOIN

**Requirement:**
Retrieve booking information along with customer name and vehicle name.

**Concept Used:** `INNER JOIN`

```sql
SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM users u
INNER JOIN bookings b ON u.user_id = b.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

📌 **Explanation:**
Joins `users`, `bookings`, and `vehicles` tables using foreign keys to show complete booking details.

---

### 🔹 Query 2: EXISTS

**Requirement:**
Find all vehicles that have **never been booked**.

**Concept Used:** `NOT EXISTS`

```sql
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE v.vehicle_id = b.vehicle_id
);
```

📌 **Explanation:**
Checks vehicles for which **no matching record exists** in the bookings table.

---

### 🔹 Query 3: WHERE

**Requirement:**
Retrieve all **available cars**.

**Concept Used:** `WHERE`

```sql
SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available';
```

📌 **Explanation:**
Filters vehicles based on type and availability.

---

### 🔹 Query 4: GROUP BY & HAVING

**Requirement:**
Find vehicles that have **more than 2 bookings**.

**Concepts Used:** `GROUP BY`, `HAVING`, `COUNT`

```sql
SELECT
  v.name AS vehicle_name,
  COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;
```

📌 **Explanation:**
Groups bookings by vehicle and filters groups having more than two bookings.

---

## ✅ Technologies Used

* SQL (PostgreSQL compatible)
* Relational Database Concepts

---

## 📂 Files Included

* `README.md` – Project documentation
* `queries.sql` – Database creation, data insertion, and SQL queries

---

## 🏁 Conclusion

This project successfully demonstrates:

* Proper database normalization
* Relationship handling using foreign keys
* Real-world SQL query use cases


