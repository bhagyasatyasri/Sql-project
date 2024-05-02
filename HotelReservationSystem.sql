CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Room (
    RoomID INT PRIMARY KEY,
    RoomNumber VARCHAR(10),
    RoomType VARCHAR(50),
    PricePerNight DECIMAL(10, 2)
);

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE RoomType (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(50),
    Description TEXT
);
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES
    (1, 'John', 'Doe', 'john.doe@gmail.com', '1234567890'),
    (2, 'Jane', 'Smith', 'jane.smith@gmail.com', '9876543210'),
    (3, 'Alice', 'Johnson', 'alice.johnson@gmail.com', '5551234567');
    
INSERT INTO Room (RoomID, RoomNumber, RoomType, PricePerNight)
VALUES
    (101, '101', 'Single', 100.00),
    (102, '102', 'Single', 100.00),
    (201, '201', 'Double', 150.00),
    (202, '202', 'Double', 150.00),
    (301, '301', 'Suite', 250.00);
INSERT INTO Booking (BookingID, CustomerID, RoomID, CheckInDate, CheckOutDate)
VALUES
    (1, 1, 101, '2024-05-01', '2024-05-03'),
    (2, 2, 201, '2024-05-10', '2024-05-15'),
    (3, 3, 301, '2024-06-01', '2024-06-05');
INSERT INTO Payment (PaymentID, BookingID, Amount, PaymentDate)
VALUES
    (1, 1, 200.00, '2024-05-01'),
    (2, 2, 750.00, '2024-05-10'),
    (3, 3, 1250.00, '2024-06-01');
INSERT INTO RoomType (TypeID, TypeName, Description)
VALUES
    (1, 'Single', 'A single occupancy room'),
    (2, 'Double', 'A room with two beds'),
    (3, 'Suite', 'A luxurious suite with additional amenities');
     SELECT * FROM Customers;
     SELECT * FROM Room;
     SELECT * FROM Booking;
     SELECT * FROM Payment;
     SELECT * FROM RoomType;
     SELECT * FROM Customers WHERE Email = 'john.doe@gmail.com ';
     SELECT * FROM Room WHERE RoomType = 'Suite';
    SELECT * FROM Booking WHERE CheckInDate >= '2024-06-01' AND CheckOutDate <= '2024-06-05';
    SELECT Booking.*, Customers.FirstName, Customers.LastName 
     FROM Booking 
     INNER JOIN Customers ON Booking.CustomerID = Customers.CustomerID;
     SELECT Payment.*, Booking.BookingID, Customers.FirstName, Customers.LastName 
     FROM Payment 
     INNER JOIN Booking ON Payment.BookingID = Booking.BookingID 
     INNER JOIN Customers ON Booking.CustomerID = Customers.CustomerID;
SELECT COUNT(*) AS TotalBookings FROM Booking;
     SELECT AVG(PricePerNight) AS AveragePrice FROM Room;
          SELECT SUM(Amount) AS TotalAmountPaid FROM Payment;
     SELECT * FROM Booking WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE Email = 'alice.johnson@gmail.com');
SELECT * FROM Customers ORDER BY LastName;
     SELECT * FROM Room ORDER BY PricePerNight DESC;
CREATE VIEW CustomerBookingsView AS
   SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, 
          b.BookingID, b.CheckInDate, b.CheckOutDate, r.RoomNumber, r.RoomType, r.PricePerNight
   FROM Customers c
   JOIN Booking b ON c.CustomerID = b.CustomerID
   JOIN Room r ON b.RoomID = r.RoomID;
   SELECT * FROM CustomerBookingsView;

   CREATE VIEW AvailableRoomsView AS
   SELECT r.RoomID, r.RoomNumber, r.RoomType, r.PricePerNight
   FROM Room r
   WHERE r.RoomID NOT IN (
       SELECT b.RoomID
       FROM Booking b
       WHERE '2024-05-01' BETWEEN b.CheckInDate AND b.CheckOutDate
   );
   SELECT * FROM AvailableRoomsView;

CREATE VIEW RevenueByMonthView AS
   SELECT DATE_FORMAT(b.CheckInDate, '%Y-%m') AS Month, SUM(p.Amount) AS Revenue
   FROM Booking b
   JOIN Payment p ON b.BookingID = p.BookingID
   GROUP BY Month;
SELECT * FROM RevenueByMonthView;
CREATE VIEW PaymentDetailsView AS
   SELECT p.PaymentID, p.Amount, p.PaymentDate, 
          b.BookingID, b.CheckInDate, b.CheckOutDate,
          c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone
   FROM Payment p
   JOIN Booking b ON p.BookingID = b.BookingID
   JOIN Customers c ON b.CustomerID = c.CustomerID;
SELECT * FROM PaymentDetailsView;
  CREATE VIEW RoomTypeDetailsView AS
SELECT rt.TypeID, rt.TypeName, rt.Description, COUNT(r.RoomID) AS TotalRooms
FROM RoomType rt
LEFT JOIN Room r ON rt.TypeID = r.RoomType
GROUP BY rt.TypeID;

SELECT * FROM RoomTypeDetailsView;
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES
    (5, 'John', 'ames', 'john.doe@gmail.com ', '1234567890');
    SELECT * FROM Customers;