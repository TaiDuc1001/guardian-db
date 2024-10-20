CREATE DATABASE QL_Guardian
USE QL_Guardian

CREATE TABLE Image_
(
	ImageID VARCHAR(20) NOT NULL PRIMARY KEY,
	ImagePath VARCHAR(100),
	AltText TEXT,
	BigVersionPath VARCHAR(100)
)

CREATE TABLE Brand
(
	BrandID VARCHAR(20) NOT NULL PRIMARY KEY,
	BrandName NVARCHAR(50),
	isTopBrand TINYINT
)	

CREATE TABLE Category
(
	CategoryID VARCHAR(20) NOT NULL PRIMARY KEY,
	CategoryName VARCHAR(50)
)

CREATE TABLE Rank_
(
	RankID varchar(20) NOT NULL PRIMARY KEY,
	RankName varchar(15)
)

CREATE TABLE Product
(
	ProductID VARCHAR(20) NOT NULL PRIMARY KEY,
	ProductName VARCHAR(50) NOT NULL,
	RatingStars DECIMAL(2,1),
	BrandID VARCHAR(20),
	SKU varchar(10) UNIQUE,
	Price DECIMAL(10,0),
	CategoryID VARCHAR(20),
	Ingredients NVARCHAR(100),
	DescriptionProduct TEXT,
	Uses TEXT,
	InstructionManualDescription TEXT, 
	InstructionStoreDescription TEXT,
	StockQuantity INT,
	CONSTRAINT FK_CategoryID FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
	CONSTRAINT FK_BrandID FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
)

CREATE TABLE Address_
(
	AddressID VARCHAR(20) NOT NULL PRIMARY KEY,
	PhoneNumber VARCHAR(11) NOT NULL UNIQUE,
	HouseNumber VARCHAR(10),
	Street NVARCHAR(50),
	Ward NVARCHAR(30),
	District NVARCHAR(20),
	City NVARCHAR (30),
	Country NVARCHAR(20)
)
ALTER TABLE Address_
ADD FullAddress AS CONCAT(HouseNumber, ' ', Street, ', ', Ward, ', ', District, ', ', City, ', ', Country)


CREATE TABLE User_
(
	UserID VARCHAR(20) NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10),
	PhoneNumber VARCHAR(11) NOT NULL UNIQUE,
	Email VARCHAR(50),
	UserPassword VARCHAR(30),
	Point INT,
	RankID varchar(20),
	TotalOrder INT,
	Birthdate DATE,	
	Sex CHAR(3),
	CONSTRAINT FK_RankID FOREIGN KEY (RankID) REFERENCES Rank_(RankID)
)
ALTER TABLE User_
ADD FullName AS CONCAT(FirstName, ' ', LastName);

CREATE TABLE UserBagProducts --giỏ hàng
(
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	Quantity SMALLINT,
	CONSTRAINT FK_ProductID_UserID PRIMARY KEY (ProductID, UserID),
	CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	Constraint FK_UserID FOREIGN KEY(UserID) REFERENCES User_(UserID)
)

CREATE TABLE LikedProducts -- sản phẩm đã thích
(
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	CONSTRAINT FK_ProductID1_UserID1 PRIMARY KEY (ProductID, UserID),
	CONSTRAINT FK_ProductID1 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	Constraint FK_UserID1 FOREIGN KEY(UserID) REFERENCES User_(UserID)
)

CREATE TABLE Voucher
(
	VoucherID VARCHAR(20) NOT NULL PRIMARY KEY,
	Code VARCHAR(20) NOT NULL UNIQUE,
	Name VARCHAR(50),
	MinimumPrice INT,
	DiscountPRice INT,
	DiscountPercentage DECIMAL(2,0),
	VoucherDescription TEXT
)

CREATE TABLE Order_
(
	OrderID VARCHAR(20) NOT NULL PRIMARY KEY,
	UserID VARCHAR(20),
	TotalPrice DECIMAL(20,0),
	OrderStatusID VARCHAR(20),
	DateOrdered DATE,
	DeliveryAddressID VARCHAR(20),
	CONSTRAINT FK_UserID3 FOREIGN KEY (UserID) REFERENCES User_(UserID),
	CONSTRAINT FK_AddressID FOREIGN KEY (DeliveryAddressID) REFERENCES Address_(AddressID)
)

CREATE TABLE Review
(
	ReviewID VARCHAR(20) NOT NULL PRIMARY KEY,
	OrderID VARCHAR(20),
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	ReviewTime DATE,
	ReviewContent TEXT,
	Stars DECIMAL(3,1)
	CONSTRAINT FK_OrderID3 FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_UserID5 FOREIGN KEY (UserID) REFERENCES User_(UserID),
	CONSTRAINT FK_ProductID7 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE UserVoucher
(
	VoucherID VARCHAR(20),
	UserID VARCHAR(20),
	isUsed TINYINT,
	CONSTRAINT FK_VoucherID_UserID2 PRIMARY KEY (VoucherID, UserID),
	CONSTRAINT FK_VoucherID FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID),
	Constraint FK_UserID2 FOREIGN KEY(UserID) REFERENCES User_(UserID)
)
CREATE TABLE OrderStatus
(
	StatusID VARCHAR(20),
	StatusName NVARCHAR(15)
)



CREATE TABLE ProductOrder
(
	OrderID VARCHAR(20),
	ProductID VARCHAR(20),
	VoucherID VARCHAR(20),
	Quantity SMALLINT,
	DiscountedAmount INT,
	FinalPrice INT,
	CONSTRAINT FK_OrderID_ProductID2_VoucherID1 PRIMARY KEY (OrderID, ProductID, VoucherID),
	CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_ProductID2 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_VoucherID1 FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
)

CREATE TABLE Event_
(
	EventID VARCHAR(20) NOT NULL PRIMARY KEY,
	EventName NVARCHAR(50),
	StartDate DATE,
	EndDaye DATE
)

CREATE TABLE EventProduct
(
	EventID VARCHAR(20),
	ProductID VARCHAR(20),
	DiscountPercent TINYINT,
	CONSTRAINT FK_EventID_ProductID3 PRIMARY KEY(EventID, ProductID),
	CONSTRAINT FK_EventID FOREIGN KEY (EventID) REFERENCES Event_(EventID),
	CONSTRAINT FK_ProductID3 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE VoucherProduct
(
	ProductID VARCHAR(20),
	VoucherID VARCHAR(20),
	CONSTRAINT FK_VoucherID2_ProductID4 PRIMARY KEY(VoucherID, ProductID),
	CONSTRAINT FK_VoucherID2 FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID),
	CONSTRAINT FK_ProductID4 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE PaymentTerm
(
	PaymentTermID VARCHAR(20) NOT NULL PRIMARY KEY,
	PaymentTermName NVARCHAR(20)
)
CREATE TABLE Invoice
(
	InvoiceKey VARCHAR(20) NOT NULL PRIMARY KEY,
	Serial NVARCHAR(50),
	InvoiceNumber INT,
	InvoiceDate DATE,
	MCQT VARCHAR(20) NOT NULL UNIQUE,
	BrandID VARCHAR(20),
	UserID VARCHAR(20),
	PaymentTermID VARCHAR(20),
	Note TEXT,
	CONSTRAINT FK_BrandID1 FOREIGN KEY (BrandID) REFERENCES Brand (BrandID),
	CONSTRAINT FK_UserID4 FOREIGN KEY (UserID) REFERENCES User_(UserID),
	CONSTRAINT FK_PaymentTermID FOREIGN KEY (PaymentTermID) REFERENCES PaymentTerm (PaymentTermID)
)

CREATE TABLE Cart
(
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	Quantity INT,
	CONSTRAINT FK_ProductID6_UserID6 PRIMARY KEY (ProductID, UserID),
	CONSTRAINT FK_ProductID6 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_UserID6 FOREIGN KEY (UserID) REFERENCES User_(UserID)
)
