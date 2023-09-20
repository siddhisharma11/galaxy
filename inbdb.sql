CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(100) -- You should hash and salt the password for security
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT, -- Foreign key referencing Customers table
    AccountType VARCHAR(20), -- 'Savings' or 'Current'
    Balance DECIMAL(10, 2),
    InterestRate DECIMAL(5, 2), -- Applicable only for Savings accounts
    OverdraftEnabled BIT, -- 1 for enabled, 0 for disabled
    OverdraftInterestRate DECIMAL(5, 2), -- Applicable only for Current accounts with overdraft
    ConfiguredWithdrawalLimit DECIMAL(10, 2), -- Maximum daily withdrawal limit
    MinimumBalance DECIMAL(10, 2), -- Minimum balance requirement
    foreign key(CustomerID) references Customers(CustomerID)
);


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT, -- Foreign key referencing Accounts table
    TransactionDate DATE,
    Description VARCHAR(255),
    Amount DECIMAL(10, 2),
    foreign key(AccountID) references Accounts(AccountID)
);

CREATE TABLE Cheques (
    ChequeID INT PRIMARY KEY,
    CustomerID INT, -- Foreign key referencing Customers table
    Status VARCHAR(20), -- 'Not received,' 'Sent for Clearance,' 'Cleared,' or 'Bounced'
    Amount DECIMAL(10, 2),
    BounceFine DECIMAL(10, 2), -- Fine amount for bounced cheques
    foreign key(CustomerID) references Customers(CustomerID)
);

CREATE TABLE BillPayments (
    BillPaymentID INT PRIMARY KEY,
    CustomerID INT, -- Foreign key referencing Customers table
    PayeeName VARCHAR(100),
    BillAmount DECIMAL(10, 2),
    PaymentDate DATE,
    IsScheduled BIT, -- 1 for scheduled payments, 0 for immediate payments
    foreign key(CustomerID) references Customers(CustomerID)
);

CREATE TABLE MoneyTransfers (
    TransferID INT PRIMARY KEY,
    SenderAccountID INT, -- Foreign key referencing Accounts table
    ReceiverAccountID INT, -- Foreign key referencing Accounts table
    TransferAmount DECIMAL(10, 2),
    TransferDate DATE,
    foreign key(SenderAccountID) references Accounts(AccountID),
    foreign key(ReceiverAccountID) references Accounts(AccountID)
);


