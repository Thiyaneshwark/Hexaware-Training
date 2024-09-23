-- TASKS 1: DATABASE DESIGN:

-- Task 1.1: Create the database named "TicketBookingSystem"
CREATE DATABASE TicketBookingSystem;
USE TicketBookingSystem;

-- Task 1.2: Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships
-- Venu Table
CREATE TABLE Venu (
venue_id INT PRIMARY KEY IDENTITY,
venue_name NVARCHAR(100) NOT NULL,
address NVARCHAR(255) NOT NULL
);

-- Event Table
CREATE TABLE Event (
event_id INT PRIMARY KEY IDENTITY,
event_name NVARCHAR(100) NOT NULL,
event_date DATE NOT NULL,
event_time TIME NOT NULL,
venue_id INT,
total_seats INT NOT NULL,
available_seats INT NOT NULL,
ticket_price DECIMAL(10, 2) NOT NULL,
event_type NVARCHAR(50) CHECK (event_type IN ('Movie', 'Sports', 'Concert')),
booking_id INT NULL, -- can be null initially as bookings may not be made yet
);

-- Customer Table
CREATE TABLE Customers (
customer_id INT PRIMARY KEY IDENTITY,
customer_name NVARCHAR(100) NOT NULL,
email NVARCHAR(255) NOT NULL,
phone_number NVARCHAR(15) NOT NULL,
booking_id INT NULL
);

-- Booking Table
CREATE TABLE Booking (
booking_id INT PRIMARY KEY IDENTITY,
customer_id INT,
event_id INT,
num_tickets INT NOT NULL,
total_cost DECIMAL(10, 2) NOT NULL,
booking_date DATE NOT NULL
);

-- Task 1.3: Create an ERD (Entity Relationship Diagram) for the database

-- Task 1.4: Create appropriate Primary Key and Foreign Key constraints for referential integrity 

-- Adding Venue Foreign Key in Event
ALTER TABLE Event 
ADD CONSTRAINT fk_venue FOREIGN KEY (venue_id) REFERENCES Venu(venue_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Adding Customer foreign key constraints in Booking table
ALTER TABLE Booking
ADD CONSTRAINT fk_customer_booking FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Adding Event foreign key constraints in Booking table
ALTER TABLE Booking
ADD CONSTRAINT fk_event_booking FOREIGN KEY (event_id) REFERENCES Event(event_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Adding Booking Foreign Key in Event and Customer
ALTER TABLE Event
ADD CONSTRAINT fk_booking_event FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Customers
ADD CONSTRAINT fk_booking_customers FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);


-- TASKS 2: SELECT, WHERE, BETWEEN, AND, LIKE:

-- Task 2.1: Insert at least 10 sample records into each table:
-- Inserting records into Venu Table
INSERT INTO Venu (venue_name, address)
VALUES('Chennai Stadium', '123 Marina Beach Road, Chennai, TN'),
('Mumbai Arena', '456 Gateway Road, Mumbai, MH'),
('Delhi Theatre', '789 Connaught Place, New Delhi, DL'),
('Bangalore Auditorium', '101 MG Road, Bangalore, KA'),
('Hyderabad Hall', '202 Charminar Lane, Hyderabad, TS'),
('Kolkata Open Ground', '303 Park Street, Kolkata, WB'),
('Pune Concert Hall', '404 Shivaji Nagar, Pune, MH'),
('Jaipur Palace Grounds', '505 Amber Road, Jaipur, RJ'),
('Goa Cultural Center', '606 Beach Road, Panaji, GA'),
('Ahmedabad Expo Center', '707 Gandhi Road, Ahmedabad, GJ'),
('Coimbatore Exhibition Center', '808 Race Course, Coimbatore, TN'),
('Chandigarh Event Plaza', '909 Sector 17, Chandigarh, CH'),
('Visakhapatnam Beach Arena', '111 Beach Road, Visakhapatnam, AP'),
('Nashik Cultural Hall', '222 Wine Capital Road, Nashik, MH'),
('Vadodara Community Center', '333 Sayaji Garden Road, Vadodara, GJ');

-- Inserting records into Event Table with corrected event types
INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type)
VALUES('IPL Final', '2024-10-01', '18:00', 1, 50000, 20000, 2000.00, 'Sports'),
('Rock Concert', '2024-11-15', '20:00', 2, 30000, 5000, 2500.00, 'Concert'),
('Bollywood Night', '2024-09-25', '19:00', 3, 20000, 10000, 1500.00, 'Concert'),
('Movie Premiere', '2024-09-20', '17:30', 4, 15000, 2000, 1200.00, 'Movie'),
('Comedy Show', '2024-12-05', '19:00', 5, 10000, 5000, 800.00, 'Concert'),
('World Cup Cricket', '2024-11-15', '19:00', 2, 30000, 15000, 1500.00, 'Sports'),
('Cup of Joy Festival', '2024-09-25', '16:00', 3, 4000, 3500, 1200.00, 'Concert'),
('Drama Play', '2024-09-30', '16:00', 4, 12000, 2000, 1000.00, 'Movie'),
('Stand-up Comedy', '2024-10-10', '20:00', 5, 8000, 1500, 750.00, 'Concert'),
('Football Match', '2024-11-01', '19:00', 1, 55000, 30000, 1750.00, 'Sports'),
('Music Festival', '2024-10-15', '18:00', 1, 40000, 25000, 3000.00, 'Concert'),
('Drama Competition', '2024-10-20', '16:00', 4, 5000, 5000, 500.00, 'Movie'),
('Cricket Match', '2024-11-10', '14:00', 2, 70000, 40000, 1200.00, 'Sports'),
('Classical Dance Show', '2024-11-20', '19:00', 5, 6000, 4000, 800.00, 'Concert'),
('Childrens Play', '2024-12-15', '10:00', 3, 2000, 2000, 300.00, 'Movie'),
('The Comedy Show', '2024-12-20', '19:00', 7, 5000, 5000, 600.00, 'Movie');

-- Inserting records into Customer Table
INSERT INTO Customers (customer_name, email, phone_number)
VALUES('Ravi Kumar', 'ravi.kumar@example.com', '9876543210'),
('Sita Sharma', 'sita.sharma@example.com', '7890123456'),
('Amit Patel', 'amit.patel@example.com', '9123456789'),
('Neha Gupta', 'neha.gupta@example.com', '8888000000'),
('Rahul Verma', 'rahul.verma@example.com', '9090909090'),
('Priya Singh', 'priya.singh@example.com', '9988776655'),
('Vikram Joshi', 'vikram.joshi@example.com', '8123456789'),
('Rina Desai', 'rina.desai@example.com', '9765432100'),
('Anil Kapoor', 'anil.kapoor@example.com', '8912345678'),
('Sanjay Mehta', 'sanjay.mehta@example.com', '8123678900'),
('Kiran Bhatia', 'kiran.bhatia@example.com', '9845123456'),
('Meera Joshi', 'meera.joshi@example.com', '9000123456'),
('Anjali Verma', 'anjali.verma@example.com', '9387654321'),
('Suresh Kumar', 'suresh.kumar@example.com', '9612345678'),
('Ramesh Singh', 'ramesh.singh@example.com', '9798765432'),
('John Doe', 'john.doe@example.com', '9876543211'),
('Alex Johnson', 'alex.johnson@example.com', '9876543213');

-- Inserting records into Booking Table with valid event_ids
INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost, booking_date)
VALUES(1, 1, 5, 10000.00, '2024-09-01'),
(2, 2, 2, 5000.00, '2024-09-02'),
(3, 3, 3, 4500.00, '2024-09-03'),
(4, 4, 4, 4800.00, '2024-09-04'),
(5, 5, 2, 1600.00, '2024-09-05'),
(6, 6, 6, 10800.00, '2024-09-06'),
(7, 7, 5, 6000.00, '2024-09-07'),
(8, 8, 7, 4200.00, '2024-09-08'),
(9, 9, 2, 1200.00, '2024-09-09'),
(10, 10, 1, 600.00, '2024-09-10'),
(11, 11, 8, 2400.00, '2024-09-11'),
(12, 12, 10, 5000.00, '2024-09-12'),
(13, 13, 4, 1200.00, '2024-09-13'),
(14, 14, 2, 1200.00, '2024-09-14'),
(15, 15, 6, 4800.00, '2024-09-15'),
(2, 4, 2, 2400.00, '2024-09-03'), 
(2, 5, 4, 3200.00, '2024-09-04'),
(1, 2, 3, 7500.00, '2024-09-15');

-- Task 2.2: List all Events
SELECT * FROM Event;

-- Task 2.3: Select events with available tickets
SELECT * FROM Event WHERE available_seats > 0;

-- Task 2.4: Select events name partial match with 'cup'
SELECT * FROM Event WHERE event_name LIKE '%cup%';

-- Task 2.5: Select events with ticket price between 1000 to 2500
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;

-- Task 2.6: Retrieve events with dates in specific range
SELECT * FROM Event WHERE event_date BETWEEN '2024-09-01' AND '2024-12-31';

-- Task 2.7: Retrieve events with available tickets and "concert" in their name
SELECT * FROM Event WHERE available_seats > 0 AND event_type = 'Concert';

-- Task 2.8: Retrieve users in batches of 5 starting from the 6th user
SELECT * FROM Customers ORDER BY customer_id OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- Task 2.9: Retrieve bookings with more than 4 tickets
SELECT * FROM Booking WHERE num_tickets > 4;

-- Task 2.10: Retrieve customer info with phone number ending in '000'
SELECT * FROM Customers WHERE phone_number LIKE '%000';

-- Task 2.11: Retrieve events with seat capacity more than 15000
SELECT * FROM Event WHERE total_seats > 15000 ORDER BY total_seats;

-- Task 2.12: Select events where name doesn't start with 'x', 'y', or 'z'
SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';


-- TASKS 3: AGGREGATE FUNCTIONS, HAVING, ORDER BY, GROUP BY, AND JOINS:

-- Task 3.1: List events and their average ticket prices
SELECT event_name AS [Event Name], AVG(ticket_price) AS [Avg Ticket Price]
FROM Event 
GROUP BY event_name;

-- Task 3.2: Calculate the total revenue generated by events
SELECT e.event_name AS [Event Name], SUM(b.total_cost) AS [Total Revenue]
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name;

-- Task 3.3: Find the event with the highest ticket sales
SELECT TOP 1 e.event_name AS [Event Name], SUM(b.num_tickets) AS [Total Tickets Sold]
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name
ORDER BY [Total Tickets Sold] DESC;

-- Task 3.4: Total number of tickets sold for each event
SELECT e.event_name AS [Event Name], SUM(b.num_tickets) AS [Total Tickets Sold]
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name;

-- Task 3.5: Find events with no ticket sales
SELECT e.event_name AS [Event Name]
FROM Event e 
LEFT JOIN Booking b ON e.event_id = b.event_id
WHERE b.event_id IS NULL;

-- Task 3.6: Find the user who has booked the most tickets
SELECT TOP 1 c.customer_name AS [Customer Name], SUM(b.num_tickets) AS [Total Tickets]
FROM Booking b 
JOIN Customers c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY [Total Tickets] DESC;

-- Task 3.7: List events and total tickets sold per month
SELECT e.event_name AS [Event Name], MONTH(b.booking_date) AS Month, SUM(b.num_tickets) AS [Total Tickets]
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name, MONTH(b.booking_date);

-- Task 3.8: Average ticket price for events in each venue
SELECT v.venue_name AS [Venue Name], AVG(e.ticket_price) AS [Avg Ticket Price]
FROM Event e 
JOIN Venu v ON e.venue_id = v.venue_id
GROUP BY v.venue_name;

-- Task 3.9: Total number of tickets sold for each event type
SELECT e.event_type AS [Event Type], SUM(b.num_tickets) AS [Total Tickets]
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_type;

-- Task 3.10: Total revenue generated by events in each year
SELECT YEAR(b.booking_date) AS Year, SUM(b.total_cost) AS [Total Revenue]
FROM Booking b
GROUP BY YEAR(b.booking_date);

-- Task 3.11: List users who have booked tickets for multiple events
SELECT c.customer_name AS [Customer Name], COUNT(DISTINCT b.event_id) AS [Events Booked]
FROM Booking b 
JOIN Customers c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT b.event_id) > 1;

-- Task 3.12: Total revenue generated by events for each user
SELECT c.customer_name AS [Customer Name], SUM(b.total_cost) AS [Total Revenue]
FROM Booking b 
JOIN Customers c ON b.customer_id = c.customer_id
GROUP BY c.customer_name;

-- Task 3.13: Average ticket price for events in each category and venue
SELECT e.event_type AS [Event Type], v.venue_name AS [Venue Name], AVG(e.ticket_price) AS [Avg Ticket Price]
FROM Event e 
JOIN Venu v ON e.venue_id = v.venue_id
GROUP BY e.event_type, v.venue_name;

-- Task 3.14: Users and total tickets purchased in the last 30 days
SELECT c.customer_name AS [Customer Name], SUM(b.num_tickets) AS [Total Tickets]
FROM Booking b 
JOIN Customers c ON b.customer_id = c.customer_id
WHERE DATEDIFF(day, b.booking_date, GETDATE()) <= 30
GROUP BY c.customer_name;


-- TASKS 4: SUBQUERIES AND THEIR TYPES:

-- Task 4.1: Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT Venu.venue_name AS [Venue Name],
(SELECT AVG(Event.ticket_price) FROM Event WHERE Event.venue_id = Venu.venue_id) AS [Avg Ticket Price]
FROM Venu;

-- Task 4.2: Find Events with More Than 50% of Tickets Sold using subquery
SELECT Event.event_name AS [Event Name]
FROM Event
WHERE Event.available_seats < 
(SELECT 0.5 * Event.total_seats FROM Event AS e WHERE e.event_id = Event.event_id);

-- Task 4.3: Calculate the Total Number of Tickets Sold for Each Event
SELECT Event.event_name AS [Event Name],
(SELECT SUM(Booking.num_tickets) FROM Booking WHERE Booking.event_id = Event.event_id) AS [Total Tickets Sold]
FROM Event;

-- Task 4.4: Find users who have not booked any tickets using a NOT EXISTS subquery
SELECT Customers.customer_name AS [Customer Name]
FROM Customers
WHERE NOT EXISTS (SELECT 1 FROM Booking WHERE Booking.customer_id = Customers.customer_id);

-- Task 4.5: List events with no ticket sales using a NOT IN subquery
SELECT Event.event_name AS [Event Name]
FROM Event
WHERE Event.event_id NOT IN (SELECT Booking.event_id FROM Booking);

-- Task 4.6: Calculate the total number of tickets sold for each event type using a subquery in the FROM clause
SELECT event_type AS [Event Type], 
(SELECT SUM(b.num_tickets) 
FROM Booking b 
WHERE b.event_id IN (SELECT e.event_id FROM Event e WHERE e.event_type = Event.event_type)) AS [Total Tickets]
FROM Event
GROUP BY event_type;

-- Task 4.7: Find events with ticket prices higher than the average ticket price using a subquery in the WHERE clause
SELECT Event.event_name AS [Event Name]
FROM Event
WHERE Event.ticket_price > (SELECT AVG(ticket_price) FROM Event);

-- Task 4.8: Calculate the total revenue generated by events for each user using a correlated subquery
SELECT Customers.customer_name AS [Customer Name],
(SELECT SUM(Booking.total_cost) FROM Booking WHERE Booking.customer_id = Customers.customer_id) AS [Total Revenue]
FROM Customers;

-- Task 4.9: List users who have booked tickets for events in a given venue using a subquery in the WHERE clause
SELECT DISTINCT customer_name AS [Customer Name]
FROM Customers
WHERE customer_id IN (SELECT Booking.customer_id
FROM Booking
WHERE Booking.event_id IN (SELECT Event.event_id 
FROM Event
WHERE Event.venue_id = 3));

-- Task 4.10: Calculate the total number of tickets sold for each event category using a subquery with GROUP BY
SELECT event_type AS [Event Type], 
(SELECT SUM(b.num_tickets) 
FROM Booking b 
WHERE b.event_id IN (SELECT e.event_id 
FROM Event e 
WHERE e.event_type = Event.event_type)) AS [Total Tickets Sold]
FROM Event
GROUP BY event_type;

-- Task 4.11: Find users who have booked tickets for events in each month using a subquery with DATE_FORMAT
SET DATEFORMAT ymd;  -- Set the date format to year-month-day
SELECT c.customer_name AS [Customer Name],
(SELECT DISTINCT DATENAME(month, b.booking_date)
FROM Booking b WHERE b.customer_id = c.customer_id AND b.booking_date IS NOT NULL) AS [Booking Month]
FROM Customers c
WHERE EXISTS (SELECT * FROM Booking b WHERE b.customer_id = c.customer_id AND b.booking_date IS NOT NULL);

-- Task 4.12: Calculate the average ticket price for events in each venue using a subquery
SELECT Venu.venue_name AS [Venue Name],
(SELECT AVG(Event.ticket_price)
FROM Event
WHERE Event.venue_id = Venu.venue_id) AS [Avg Ticket Price]
FROM Venu;

