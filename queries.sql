 -- Create Database------
create database vehicles;

--- Create Users table ------
drop table users;
create table users (
  user_id serial primary key,
  name varchar(100) not null,
  email varchar(100) unique not null,
  password varchar(100) not null,
  phone varchar(15),
  role varchar(20) check (role in ('Admin','Customer'))
);

--- Inserting data in Users table -------
INSERT INTO users (name, email, password, phone, role) VALUES
('David Miller', 'david@example.com', 'david123', '1111111111', 'Customer'),
('Emma Watson', 'emma@example.com', 'emma123', '2222222222', 'Customer'),
('Frank Thomas', 'frank@example.com', 'frank123', '3333333333', 'Admin'),
('Grace Lee', 'grace@example.com', 'grace123', '4444444444', 'Customer'),
('Henry Clark', 'henry@example.com', 'henry123', '5555555555', 'Customer'),
('Ivy Brown', 'ivy@example.com', 'ivy123', '6666666666', 'Customer'),
('Jack Wilson', 'jack@example.com', 'jack123', '7777777777', 'Admin'),
('Kathy Adams', 'kathy@example.com', 'kathy123', '8888888888', 'Customer'),
('Leo Martin', 'leo@example.com', 'leo123', '9999999999', 'Customer'),
('Nina Scott', 'nina@example.com', 'nina123', '1010101010', 'Customer');

select * from users;

---- Creating veichile table --------
CREATE TABLE vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(20) CHECK (type IN ('car','bike','truck')),
  model INT NOT NULL,
  registration_number VARCHAR(50) UNIQUE NOT NULL,
  rental_price INT NOT NULL,
  status VARCHAR(20) CHECK (status IN ('available','rented','maintenance'))
);

-- Inserting data with vehicles table 

INSERT INTO vehicles (name, type, model, registration_number, rental_price, status) VALUES
('Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
('Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
('Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance'),
('Suzuki Swift', 'car', 2022, 'MNO-345', 55, 'available'),
('Hyundai i20', 'car', 2021, 'PQR-678', 52, 'available'),
('Kawasaki Ninja', 'bike', 2022, 'STU-901', 35, 'rented'),
('Royal Enfield Classic', 'bike', 2020, 'VWX-234', 28, 'available'),
('Tata Ace', 'truck', 2019, 'YZA-567', 90, 'available'),
('Isuzu D-Max', 'truck', 2021, 'BCD-890', 110, 'rented');

select * from vehicles;

---- bookings table ------
CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  vehicle_id INT NOT NULL REFERENCES vehicles(vehicle_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) CHECK (status IN ('pending','confirmed','completed','cancelled')),
  total_cost INT NOT NULL

);

INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100),
(4, 3, '2023-09-05', '2023-09-07', 'completed', 90),
(5, 5, '2023-10-15', '2023-10-18', 'completed', 165),
(6, 7, '2023-11-20', '2023-11-22', 'cancelled', 70),
(7, 4, '2023-12-01', '2023-12-04', 'completed', 300),
(8, 2, '2023-12-05', '2023-12-08', 'confirmed', 180),
(9, 1, '2023-12-15', '2023-12-17', 'pending', 100);


select * from bookings;




 
 
 -- Query 1: JOIN
select
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from
  users as u
  inner join bookings as b on u.user_id = b.user_id
  inner join vehicles as v on b.vehicle_id = v.vehicle_id;

--- Query 2: EXISTS-----
select
  *
from
  vehicles as v
where
  not exists (
    select
      1
    from
      bookings as b
    where
      v.vehicle_id = b.vehicle_id
  )
  -- Query 3: WHERE
  -- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).
select
  *
from
  vehicles
where
type
  = 'car'
  and status = 'available';

-- Query 4: GROUP BY and HAVING
-- Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

select
  v.name as vehicle_name,
  count(b.booking_id) as total_bookings
from
  vehicles as v
  join bookings as b on v.vehicle_id = b.vehicle_id
group by
  v.name
having
  count(b.booking_id) > 2;


ERD diagram link
https://drawsql.app/teams/team-5562/diagrams/a-3