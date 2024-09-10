CREATE DATABASE CAR_REPAIR;

USE CAR_REPAIR;

CREATE TABLE IF NOT EXISTS DIM_CUSTOMER (
    C_ID INT PRIMARY KEY AUTO_INCREMENT,
    C_NAME VARCHAR(255),
    C_EMAIL VARCHAR(255),
    PHONE_NUMBER VARCHAR (20),
    ADDRESS VARCHAR (255)
);

CREATE TABLE IF NOT EXISTS DIM_VEHICLE (
    V_ID INT PRIMARY KEY AUTO_INCREMENT,
    MAKE VARCHAR (100),
    MODEL VARCHAR (100),
    YEAR INT,
    COLOR VARCHAR (50),
    VIN VARCHAR (50),
    REGNUMBER VARCHAR (50)
);

CREATE TABLE IF NOT EXISTS DIM_SERVICE(
    S_ID INT PRIMARY KEY AUTO_INCREMENT,
    S_TYPE VARCHAR (255),
    DESCRIPTION TEXT
);

CREATE TABLE IF NOT EXISTS DIM_PART(
    P_ID INT PRIMARY KEY,
    P_NAME VARCHAR (255),
    P_NUMBER VARCHAR (255),
    UNIT_PRICE DECIMAL (10,2)
);

CREATE TABLE IF NOT EXISTS DIM_LOCATION(
    L_ID INT PRIMARY KEY AUTO_INCREMENT,
    L_NAME VARCHAR (255),
    ADDRESS VARCHAR (255),
    CITY VARCHAR (100),
    PROVINCE VARCHAR (100)
);

CREATE TABLE IF NOT EXISTS DIM_DATE(
    D_ID INT PRIMARY KEY AUTO_INCREMENT,
    DATE DATE,
    DAY INT,
    MONTH INT,
    YEAR INT,
    QUARTER INT
);

CREATE TABLE FactSales (
    SalesID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique identifier for each sale
    C_ID INT,                           -- Foreign key to DimCustomer
    V_ID INT,                            -- Foreign key to DimVehicle
    S_ID INT,                            -- Foreign key to DimService
    P_ID INT,                               -- Foreign key to DimPart
    L_ID INT,                           -- Foreign key to DimLocation
    D_ID INT,                               -- Foreign key to DimDate
    Service_Charge DECIMAL(10,2),              -- Charge for the service performed
    Parts_Charge DECIMAL(10,2),                -- Charge for parts used
    Total_Sales DECIMAL(10,2),                 -- Total sales amount (ServiceCharge + PartsCharge)
    Sales_Tax DECIMAL(10,2),                   -- Sales tax applied
    FOREIGN KEY (C_ID) REFERENCES Dim_Customer(C_ID),
    FOREIGN KEY (V_ID) REFERENCES Dim_Vehicle(V_ID),
    FOREIGN KEY (S_ID) REFERENCES Dim_Service(S_ID),
    FOREIGN KEY (P_ID) REFERENCES Dim_Part(P_ID),
    FOREIGN KEY (L_ID) REFERENCES Dim_Location(L_ID),
    FOREIGN KEY (D_ID) REFERENCES Dim_Date(D_ID)
);


UPDATE FactSales
SET 
    Total_Sales = Service_Charge + Parts_Charge,
    Sales_Tax = (Service_Charge + Parts_Charge) * 0.05;  -- Assuming a 5% sales tax rate


INSERT INTO DIM_CUSTOMER (C_ID, C_NAME, C_EMAIL, PHONE_NUMBER, ADDRESS) VALUES
(1, 'John Doe', 'john.doe@example.com', '555-1234', '123 Maple St');

INSERT INTO DIM_CUSTOMER (C_NAME, C_EMAIL, PHONE_NUMBER, ADDRESS) VALUES
('Jane Smith', 'jane.smith@example.com', '555-5678', '456 Oak St'),
('Michael Brown', 'michael.brown@example.com', '555-8765', '789 Pine St'),
('Emily Davis', 'emily.davis@example.com', '555-4321', '321 Birch St'),
('David Wilson', 'david.wilson@example.com', '555-9876', '654 Cedar St'),
('Olivia Martinez', 'olivia.martinez@example.com', '555-2345', '789 Cedar St'),
('James Rodriguez', 'james.rodriguez@example.com', '555-6789', '321 Spruce St'),
('Sophia Lee', 'sophia.lee@example.com', '555-8765', '654 Spruce St'),
('Mason Gonzalez', 'mason.gonzalez@example.com', '555-4321', '123 Maple St'),
('Mia Hernandez', 'mia.hernandez@example.com', '555-9876', '456 Oak St');

INSERT INTO DIM_VEHICLE (V_ID, MAKE, MODEL, YEAR, COLOR, VIN, REGNUMBER) VALUES
(11, 'Toyota', 'Camry', 2018, 'Blue', '1HGBH41JXMN109186', 'ABC123');
INSERT INTO DIM_VEHICLE (MAKE, MODEL, YEAR, COLOR, VIN, REGNUMBER) VALUES
('Honda', 'Civic', 2017, 'Red', '2HGES16385H500821', 'DEF456'),
('Ford', 'F-150', 2019, 'Black', '3FTSW21P06MA42543', 'GHI789'),
('Chevrolet', 'Malibu', 2020, 'White', '1G1ZD5ST6LF029202', 'JKL012'),
('Nissan', 'Altima', 2016, 'Gray', '1N4AL3AP3DC155970', 'MNO345'),
('Volkswagen', 'Passat', 2015, 'Green', 'WVWFV7A98K1048376', 'PQR678'),
('Hyundai', 'Elantra', 2021, 'Yellow', 'KMHDH4AE5FU124356', 'STU901'),
('Kia', 'Optima', 2017, 'Silver', 'KNAGM4A70C5401254', 'VWX234'),
('Subaru', 'Forester', 2018, 'Blue', 'JF2SJADC0JH558594', 'YZA567'),
('Mazda', 'CX-5', 2022, 'Red', 'JM3KFBDL5J0367016', 'BCD890');

SELECT * FROM DIM_VEHICLE;

INSERT INTO DIM_SERVICE (S_ID, S_TYPE, DESCRIPTION) VALUES
(111,'Oil Change', 'Replace engine oil and oil filter');
INSERT INTO DIM_SERVICE (S_TYPE, DESCRIPTION) VALUES
('Tire Rotation', 'Rotate tires and inspect for wear'),
('Brake Service', 'Inspect and replace brake pads'),
('Battery Replacement', 'Replace vehicle battery'),
('Alignment', 'Adjust wheel alignment to manufacturer specs'),
('Transmission Service', 'Flush and replace transmission fluid'),
('AC Service', 'Inspect and recharge air conditioning system'),
('Engine Tune-Up', 'Inspect and replace spark plugs and air filter'),
('Cooling System Service', 'Flush and replace coolant'),
('Fuel System Cleaning', 'Clean fuel injectors and throttle body');

INSERT INTO DIM_PART (P_ID, P_NAME, P_NUMBER, UNIT_PRICE) VALUES
(1111, 'Oil Filter', 'OF-123', 15.00);
INSERT INTO DIM_PART (P_ID, P_NAME, P_NUMBER, UNIT_PRICE) VALUES
(1112, 'Brake Pads', 'BP-456', 50.00),
(1113,'Battery', 'B-789', 120.00),
(1114,'Air Filter', 'AF-101', 25.00),
(1115,'Coolant', 'C-202', 30.00),
(1116,'Spark Plugs', 'SP-303', 10.00),
(1117,'Transmission Fluid', 'TF-404', 60.00),
(1118,'AC Refrigerant', 'ACR-505', 70.00),
(1119,'Fuel Injector Cleaner', 'FIC-606', 40.00),
(1120, 'Wheel Alignment Kit', 'WAK-707', 150.00);

INSERT INTO DIM_LOCATION (L_ID, L_NAME, ADDRESS, CITY, PROVINCE) VALUES
(222,'Downtown Repair Center', '123 Main St', 'Vancouver', 'BC');

INSERT INTO DIM_LOCATION (L_NAME, ADDRESS, CITY, PROVINCE) VALUES
('Northside Repair Center', '456 North St', 'Vancouver', 'BC'),
('Eastside Repair Center', '789 East St', 'Burnaby', 'BC'),
('Westside Repair Center', '321 West St', 'Richmond', 'BC'),
('Southside Repair Center', '654 South St', 'Surrey', 'BC'),
('Central Repair Center', '789 Central St', 'Langley', 'BC'),
('Uptown Repair Center', '123 Uptown St', 'Coquitlam', 'BC'),
('Lakeside Repair Center', '456 Lakeside St', 'Delta', 'BC'),
('Mountain View Repair Center', '789 Mountain St', 'Abbotsford', 'BC'),
('Riverside Repair Center', '321 Riverside St', 'Maple Ridge', 'BC');

INSERT INTO DIM_DATE (D_ID, DATE, DAY, MONTH, YEAR, QUARTER) VALUES
(333, '2023-01-15', 15, 1, 2023, 1);
INSERT INTO DIM_DATE (DATE, DAY, MONTH, YEAR, QUARTER) VALUES
('2023-02-18', 18, 2, 2023, 1),
('2023-03-22', 22, 3, 2023, 1),
('2023-04-10', 10, 4, 2023, 2),
('2023-05-14', 14, 5, 2023, 2),
('2023-06-20', 20, 6, 2023, 2),
('2023-07-25', 25, 7, 2023, 3),
('2023-08-30', 30, 8, 2023, 3),
('2023-09-12', 12, 9, 2023, 3),
('2023-10-18', 18, 10, 2023, 4);

SELECT * FROM DIM_DATE;

INSERT INTO FactSales (C_ID, V_ID, S_ID, P_ID, L_ID, D_ID, Service_Charge, Parts_Charge, Total_Sales, Sales_Tax) VALUES
(1, 11, 111, 1111, 222, 333, 100.00, 15.00, 115.00, 5.75),
(2, 12, 112, 1112, 223, 334, 80.00, 50.00, 130.00, 6.50),
(3, 13, 113, 1113, 224, 335, 150.00, 120.00, 270.00, 13.50),
(4, 14, 114, 1114, 225, 336, 60.00, 25.00, 85.00, 4.25),
(5, 15, 115, 1115, 226, 337, 90.00, 30.00, 120.00, 6.00),
(6, 16, 116, 1116, 227, 338, 75.00, 60.00, 135.00, 6.75),
(7, 17, 117, 1117, 228, 339, 110.00, 70.00, 180.00, 9.00),
(8, 18, 118, 1118, 229, 340, 85.00, 40.00, 125.00, 6.25),
(9, 19, 119, 1119, 230, 341, 95.00, 150.00, 245.00, 12.25),
(10, 20, 120, 1120, 231, 342, 120.00, 150.00, 270.00, 13.50);
SELECT * FROM factsales
SHOW DATABASES;

SHOW TABLES;
-- John Doe (C_ID = 1) requires multiple services and parts
INSERT INTO FactSales (C_ID, V_ID, S_ID, P_ID, L_ID, D_ID, Service_Charge, Parts_Charge, Total_Sales, Sales_Tax) VALUES
(1, 11, 111, 1111, 222, 333, 100.00, 15.00, 115.00, 5.75),  -- Oil Change and Oil Filter
(1, 11, 112, 1112, 222, 334, 50.00, 50.00, 100.00, 5.00),   -- Tire Rotation and Brake Pads
(1, 11, 114, 1114, 222, 335, 60.00, 25.00, 85.00, 4.25);    -- Air Filter Replacement

-- Jane Smith (C_ID = 2) requires multiple services and parts
INSERT INTO FactSales (C_ID, V_ID, S_ID, P_ID, L_ID, D_ID, Service_Charge, Parts_Charge, Total_Sales, Sales_Tax) VALUES
(2, 12, 113, 1113, 223, 333, 120.00, 120.00, 240.00, 12.00), -- Brake Service and Battery Replacement
(2, 12, 115, 1115, 223, 334, 80.00, 30.00, 110.00, 5.50),   -- Coolant Replacement
(2, 12, 118, 1118, 223, 335, 70.00, 70.00, 140.00, 7.00);   -- AC Service and Refrigerant

-- Michael Brown (C_ID = 3) requires multiple services and parts
INSERT INTO FactSales (C_ID, V_ID, S_ID, P_ID, L_ID, D_ID, Service_Charge, Parts_Charge, Total_Sales, Sales_Tax) VALUES
(3, 13, 116, 1116, 224, 333, 90.00, 10.00, 100.00, 5.00),   -- Spark Plug Replacement
(3, 13, 117, 1117, 224, 334, 100.00, 60.00, 160.00, 8.00),  -- Transmission Fluid Replacement
(3, 13, 119, 1120, 224, 335, 150.00, 150.00, 300.00, 15.00); -- Wheel Alignment

-- Emily Davis (C_ID = 4) requires multiple services and parts
INSERT INTO FactSales (C_ID, V_ID, S_ID, P_ID, L_ID, D_ID, Service_Charge, Parts_Charge, Total_Sales, Sales_Tax) VALUES
(4, 14, 111, 1111, 225, 333, 100.00, 15.00, 115.00, 5.75),  -- Oil Change and Oil Filter
(4, 14, 118, 1118, 225, 334, 70.00, 70.00, 140.00, 7.00),   -- AC Service and Refrigerant
(4, 14, 114, 1114, 225, 335, 60.00, 25.00, 85.00, 4.25);    -- Air Filter Replacement

-- Olivia Martinez (C_ID = 5) requires multiple services and parts
INSERT INTO FactSales (C_ID, V_ID, S_ID, P_ID, L_ID, D_ID, Service_Charge, Parts_Charge, Total_Sales, Sales_Tax) VALUES
(5, 15, 116, 1116, 226, 333, 90.00, 10.00, 100.00, 5.00),   -- Spark Plug Replacement
(5, 15, 119, 1120, 226, 334, 150.00, 150.00, 300.00, 15.00), -- Wheel Alignment
(5, 15, 117, 1117, 226, 335, 100.00, 60.00, 160.00, 8.00);  -- Transmission Fluid Replacement

SELECT * FROM FACTSALES;

-- Customer Analysis: Identify top spenders, average spending, visit frequency patterns.
SELECT DIM_CUSTOMER.C_NAME AS 'CUSTOMER NAME', FACTSALES.TOTAL_SALES
FROM FACTSALES
LEFT JOIN DIM_CUSTOMER.C_ID = FACTSALES.SALESID
GROUP BY TOTAL_SALES
ORDER BY TOTAL_SALES
DESC;

SELECT DC.C_ID, DC.C_NAME, DC.C_EMAIL, SUM(FS.Total_Sales) AS Total_Spent
FROM FactSales FS
JOIN DIM_CUSTOMER DC ON FS.C_ID = DC.C_ID
GROUP BY DC.C_ID, DC.C_NAME, DC.C_EMAIL
ORDER BY Total_Spent DESC
LIMIT 5;

-- CUSTOMER NAMES, ITEM PURCHASED AND SERVICE CHARGED
SELECT DISTINCT DC.C_NAME, DS.S_TYPE AS Service_Purchased, DP.P_NAME AS Part_Purchased, FS.Service_Charge, FS.Parts_Charge, FS.Total_Sales
FROM FactSales FS
JOIN DIM_CUSTOMER DC ON FS.C_ID = DC.C_ID
JOIN DIM_SERVICE DS ON FS.S_ID = DS.S_ID
JOIN DIM_PART DP ON FS.P_ID = DP.P_ID
ORDER BY DC.C_NAME, FS.Total_Sales DESC;








