CREATE DATABASE carmanagement;
use carmanagement;

CREATE TABLE vehicletype (
   ID int NOT NULL AUTO_INCREMENT,
   Type varchar(255) DEFAULT NULL,
   DailyCost float DEFAULT NULL,
   PRIMARY KEY (ID)
);

CREATE TABLE vehicleinventory (
    typeid INT,
    Count INT,
    FOREIGN KEY (typeid) REFERENCES VehicleType(ID)
);

CREATE TABLE `booking` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TypeID` int DEFAULT NULL,
  `CustomerName` varchar(255) DEFAULT NULL,
  `InquireDate` date DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `ReturnDate` date DEFAULT NULL,
  `Cost` float DEFAULT NULL,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (typeid) REFERENCES VehicleType(ID)
) ;

CREATE TABLE IF NOT EXISTS customer(
    name VARCHAR(250) NOT NULL,
    email VARCHAR(250) NOT NULL,
    PRIMARY KEY (name, email)
);