use var;

CREATE TABLE IF NOT EXISTS security(
  ID int AUTO_INCREMENT,
  symbol varchar(255) DEFAULT NULL,
  industry varchar(255) DEFAULT NULL,
  currency varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID)
);
  
CREATE TABLE IF NOT EXISTS portfolio(
  ID int NOT NULL AUTO_INCREMENT,
  name varchar(255) UNIQUE DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS data (
  securityID int NOT NULL,
  date date NOT NULL,
  open decimal(10,2) DEFAULT NULL,
  high decimal(10,2) DEFAULT NULL,
  low decimal(10,2) DEFAULT NULL,
  close decimal(10,2) DEFAULT NULL,
  volume decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (securityID, date),
  FOREIGN KEY (securityID) REFERENCES security(ID)
);

CREATE TABLE IF NOT EXISTS portfoliodata (
  portfolioID int NOT NULL,
  securityID int NOT NULL,
  quantity decimal(10,2) DEFAULT NULL,
  FOREIGN KEY (portfolioID) REFERENCES portfolio(ID),
  FOREIGN KEY (securityID) REFERENCES security(ID)
);

CREATE TABLE IF NOT EXISTS returndata (
  securityID int NOT NULL,
  date date DEFAULT NULL,
  Daily_return decimal(10,2) DEFAULT NULL,
  FOREIGN KEY (securityID) REFERENCES security(ID)
);



