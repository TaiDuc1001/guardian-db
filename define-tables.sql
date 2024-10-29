﻿CREATE DATABASE QL_Guardian
USE QL_Guardian

CREATE TABLE Category
(
	CategoryID VARCHAR(20) NOT NULL PRIMARY KEY,
	CategoryName VARCHAR(50)
)

CREATE TABLE Brand
(
	BrandID VARCHAR(20) NOT NULL PRIMARY KEY,
	BrandName NVARCHAR(50),
	isTopBrand TINYINT
)	

CREATE TABLE Rank
(
	RankID varchar(20) NOT NULL PRIMARY KEY,
	RankName varchar(15)
)

CREATE TABLE Product
(
	ProductID VARCHAR(20) NOT NULL PRIMARY KEY,
	ProductName VARCHAR(50) NOT NULL,
	RatingStars DECIMAL(2,1) DEFAULT 0,
	BrandID VARCHAR(20),
	SKU varchar(10) UNIQUE,
	Price DECIMAL(10,0),
	CategoryID VARCHAR(20),
	Ingredients NVARCHAR(100),
	DescriptionProduct TEXT,
	Uses TEXT,
	Ingredients TEXT,
	Unit VARCHAR(10),
	InstructionManualDescription TEXT, 
	InstructionStoreDescription TEXT,
	SoldCount INT,
	CONSTRAINT FK_CategoryID FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
	CONSTRAINT FK_BrandID FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
)

CREATE TABLE Image
(
	ImageID VARCHAR(20) NOT NULL PRIMARY KEY,
	ImagePath VARCHAR(100),
	AltText TEXT,
	BigVersionPath VARCHAR(100),
	ProductID VARCHAR(20),
	OrdinalNumber INT,
	CONSTRAINT FK_ProductID2 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE User_
(
	UserID VARCHAR(20) NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(10) NOT NULL,
	MiddleName NVARCHAR(10) NOT NULL,
	LastName NVARCHAR(10) NOT NULL,
	PhoneNumber VARCHAR(11) NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL UNIQUE,
	UserPassword VARCHAR(30) NOT NULL,
	Point INT,
	RankID VARCHAR(20),
	TotalOrder INT DEFAULT 0,
	Birthdate DATE,	
	Sex CHAR(3),
	CONSTRAINT FK_RankID FOREIGN KEY (RankID) REFERENCES Rank(RankID)
)
ALTER TABLE User_
ADD FullName AS CONCAT(
	COALESCE(LastName, ''),
	' ',
	COALESCE(MiddleName, ''),
	' ',
	COALESCE(FirstName, '')
)

CREATE TABLE Event
(
	EventID VARCHAR(20) NOT NULL PRIMARY KEY,
	EventName NVARCHAR(50) NOT NULL,
	StartDate DATE DEFAULT GETDATE(),
	EndDate DATE
)

CREATE TABLE Address
(
	AddressID VARCHAR(20) NOT NULL PRIMARY KEY,
	PhoneNumber VARCHAR(11) NOT NULL UNIQUE,
	HouseNumber VARCHAR(10) NOT NULL,
	Street NVARCHAR(50) NOT NULL,
	Ward NVARCHAR(30) NOT NULL,
	District NVARCHAR(20) NOT NULL,
	City NVARCHAR (30) NOT NULL,
	Country NVARCHAR(20) NOT NULL,
	UserID VARCHAR(20),
	isDefault TINYINT DEFAULT 0,
	Type NVARCHAR(20) DEFAULT N'Nhà riêng',
	CONSTRAINT FK_UserID2 FOREIGN KEY (UserID) REFERENCES User_(UserID)
)

ALTER TABLE Address
ADD FullAddress AS CONCAT(HouseNumber, ' ', Street, ', ', Ward, ', ', District, ', ', City, ', ', Country)


CREATE TABLE OrderStatus
(
	StatusID VARCHAR(20) NOT NULL PRIMARY KEY,
	StatusName NVARCHAR(50) 
	CHECK (StatusName IN (N'Đã đặt hàng', N'Đã xác nhận', N'Đang giao hàng', N'Đã giao hàng', N'Đã hủy'))
)


CREATE TABLE Voucher
(
	VoucherID VARCHAR(20) NOT NULL PRIMARY KEY,
	VoucherCode VARCHAR(20) NOT NULL,
	Name VARCHAR(50),
	MinimumPrice INT DEFAULT 0,
	DiscountPrice INT,
	DiscountPercentage DECIMAL(2,0),
	VoucherDescription TEXT,
	EventID VARCHAR(20),
	CONSTRAINT FK_EventID1 FOREIGN KEY (EventID) REFERENCES Event(EventID)
)

CREATE TABLE Review
(
	ReviewID VARCHAR(20) NOT NULL PRIMARY KEY,
	ReviewTime DATE,
	ReviewMessage TEXT,
	Stars DECIMAL(3,1)
)


CREATE TABLE Shipper
(
	ShipperID VARCHAR(20) NOT NULL PRIMARY KEY,
	Salary MONEY,
	FirstName NVARCHAR(10),
	MiddleName NVARCHAR(10),
	LastName NVARCHAR(10),
	PhoneNumber VARCHAR(11) NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL UNIQUE,
	Password VARCHAR(30) NOT NULL,
	TotalOrder INT
)
ALTER TABLE Shipper
ADD FullName AS CONCAT(
	COALESCE(LastName, ''),
	' ',
	COALESCE(MiddleName, ''),
	' ',
	COALESCE(FirstName, '')
)


CREATE TABLE Order_
(
	OrderID VARCHAR(20) NOT NULL PRIMARY KEY,
	UserID VARCHAR(20),
	TotalPrice DECIMAL(20,0),
	DateOrdered DATE,
	DeliveryAddressID VARCHAR(20),
	CONSTRAINT FK_UserID3 FOREIGN KEY (UserID) REFERENCES User_(UserID),
	CONSTRAINT FK_AddressID FOREIGN KEY (DeliveryAddressID) REFERENCES Address(AddressID)
)


CREATE TABLE CentralWarehouse
(
	CentralWID VARCHAR(20) NOT NULL PRIMARY KEY,
	CentralWName NVARCHAR(50),
	Region NVARCHAR(50),
	AddressID VARCHAR(20),
	CONSTRAINT FK_AddressID1 FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
)

CREATE TABLE BranchWarehouse
(
	BranchWID VARCHAR(20) NOT NULL PRIMARY KEY,
	BranchWName NVARCHAR(50),
	Region NVARCHAR(50),
	AddressID VARCHAR(20),
	CentralWID VARCHAR(20),
	CONSTRAINT FK_AddressID2 FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
	CONSTRAINT FK_CentralWID FOREIGN KEY (CentralWID) REFERENCES CentralWarehouse(CentralWID)
)

CREATE TABLE CentralW_Product
(
	ProductID VARCHAR(20),
	CentralWID VARCHAR(20),
	StockQuantity INT DEFAULT 0,
	CONSTRAINT FK_ProductID_CentralWID PRIMARY KEY (ProductID, CentralWID),
	CONSTRAINT FK_ProductID1 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_CentralWID1 FOREIGN KEY (CentralWID) REFERENCES CentralWarehouse(CentralWID)
)

CREATE TABLE BranchW_Product
(
	ProductID VARCHAR(20),
	BranchWID VARCHAR(20),
	StockQuantity INT DEFAULT 0,
	CONSTRAINT FK_ProductID_BranchWID PRIMARY KEY (ProductID, BranchWID),
	CONSTRAINT FK_ProductID3 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_BranchWID FOREIGN KEY (BranchWID) REFERENCES BranchWarehouse(BranchWID)
)

CREATE TABLE Gift
(
	MainProductID VARCHAR(20),
	GiftProductID VARCHAR(20),
	Quantity INT DEFAULT 1,
	StartDate DATE,
	EndDate DATE,
	CONSTRAINT FK_MainProductID_GiftProductID PRIMARY KEY (MainProductID, GiftProductID),
	CONSTRAINT FK_MainProductID FOREIGN KEY (MainProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_GiftProductID FOREIGN KEY (GiftProductID) REFERENCES Product(ProductID)
)

CREATE TABLE Cart --giỏ hàng
(
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	Quantity SMALLINT DEFAULT 1,
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


CREATE TABLE ReviewOf
(
	ReviewID VARCHAR(20),
	OrderID VARCHAR(20),
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	CONSTRAINT FK_ReviewID_OrderID_ProductID_UserID PRIMARY KEY (ReviewID, OrderID, ProductID, UserID),
	CONSTRAINT FK_ReviewID FOREIGN KEY (ReviewID) REFERENCES Review(ReviewID),
	CONSTRAINT FK_OrderID1 FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_ProductID1 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_UserID3 FOREIGN KEY (UserID) REFERENCES User_(UserID)
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



CREATE TABLE ShipperOrder
(
	OrderID VARCHAR(20),
	ShipperID VARCHAR(20),
	StatusID VARCHAR(20),
	Milestone DATETIME,
	CONSTRAINT FK_OrderID2_ShipperID PRIMARY KEY (OrderID, ShipperID, StatusID, Milestone),
	CONSTRAINT FK_OrderID2 FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_ShipperID FOREIGN KEY (ShipperID) REFERENCES Shipper(ID),
	CONSTRAINT FK_StatusID FOREIGN KEY (StatusID) REFERENCES OrderStatus(StatusID)
)

CREATE TABLE ProductOrder
(
	OrderID VARCHAR(20),
	ProductID VARCHAR(20),
	VoucherID VARCHAR(20),
	Quantity SMALLINT DEFAULT 1,
	DiscountedAmount INT DEFAULT 0,
	FinalPrice INT,
	CONSTRAINT FK_OrderID_ProductID2_VoucherID1 PRIMARY KEY (OrderID, ProductID, VoucherID),
	CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_ProductID2 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_VoucherID1 FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
)

CREATE TABLE EventProducts
(
	EventID VARCHAR(20),
	ProductID VARCHAR(20),
	DiscountPercent DECIMAL(2,0),
	CONSTRAINT FK_EventID_ProductID3 PRIMARY KEY(EventID, ProductID),
	CONSTRAINT FK_EventID FOREIGN KEY (EventID) REFERENCES Event(EventID),
	CONSTRAINT FK_ProductID3 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE VoucherProducts
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
	CHECK (PaymentTermName IN (
		N'Thanh toán khi nhận hàng', 
		N'Thanh toán qua thẻ ngân hàng', 
		N'Thanh toán qua ví điện tử'
		)
	),
)
CREATE TABLE Invoice
(
	InvoiceKey VARCHAR(20) NOT NULL PRIMARY KEY,
	Serial VARCHAR(50) NOT NULL,
	InvoiceNumber INT,
	InvoiceDate DATE DEFAULT GETDATE(),
	MCQT VARCHAR(20) NOT NULL,
	BrandID VARCHAR(20),
	UserID VARCHAR(20),
	PaymentTermID VARCHAR(20),
	Note TEXT,
	CONSTRAINT FK_BrandID1 FOREIGN KEY (BrandID) REFERENCES Brand (BrandID),
	CONSTRAINT FK_UserID4 FOREIGN KEY (UserID) REFERENCES User_(UserID),
	CONSTRAINT FK_PaymentTermID FOREIGN KEY (PaymentTermID) REFERENCES PaymentTerm (PaymentTermID)
)


CREATE TABLE Genre
(
	ID VARCHAR(20) NOT NULL PRIMARY KEY,
	GenreName NVARCHAR(50) NOT NULL CHECK (
		GenreName IN (
			N'Chính trị',
			N'Kinh tế',
			N'Xã hội',
			N'Văn hóa',
			N'Giáo dục',
			N'Khoa học'
		)
	)
)

CREATE TABLE News
(
	ID VARCHAR(20) NOT NULL PRIMARY KEY,
	PublishedDate DATE,
	GenreID VARCHAR(20) NOT NULL,
	HTMLPath VARCHAR(100),
	ThumbnailID VARCHAR(20),
	CONSTRAINT FK_GenreID FOREIGN KEY (GenreID) REFERENCES Genre(ID),
	CONSTRAINT FK_ThumbnailID FOREIGN KEY (ThumbnailID) REFERENCES Image(ImageID)
)