IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QL_Guardian')
BEGIN
	ALTER DATABASE QL_Guardian SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE QL_Guardian SET ONLINE;
	DROP DATABASE QL_Guardian;
END

CREATE DATABASE QL_Guardian
GO
USE QL_Guardian
GO

CREATE TABLE Category
(
	CategoryID VARCHAR(20) NOT NULL PRIMARY KEY,
	CategoryName NVARCHAR(50) NOT NULL
)

CREATE TABLE Brand
(
	BrandID VARCHAR(20) NOT NULL PRIMARY KEY,
	BrandName NVARCHAR(50) NOT NULL,
	isTopBrand TINYINT
)	

CREATE TABLE Rank
(
	RankID varchar(20) NOT NULL PRIMARY KEY,
	RankName nvarchar(15) NOT NULL CHECK (
		RankName IN (
			N'Đồng',
			N'Bạc',
			N'Vàng',
			N'Platinum',
			N'Kim cương'
		)
	),
)

CREATE TABLE Product
(
	ProductID VARCHAR(20) NOT NULL PRIMARY KEY,
	ProductName NVARCHAR(50) NOT NULL,
	RatingStars DECIMAL(2,1) DEFAULT 0,
	BrandID VARCHAR(20),
	SKU varchar(10) UNIQUE,
	Price DECIMAL(10,0),
	CategoryID VARCHAR(20),
	Ingredients NVARCHAR(100),
	DescriptionProduct NVARCHAR(500),
	Uses NVARCHAR(500),
	Unit NVARCHAR(10),
	InstructionManualDescription NVARCHAR(500), 
	InstructionStoreDescription NVARCHAR(500),
	SoldCount INT DEFAULT 0,
	CONSTRAINT FK_CategoryID FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
	CONSTRAINT FK_BrandID FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
)

CREATE TABLE Image
(
	ImageID VARCHAR(20) NOT NULL PRIMARY KEY,
	ImagePath VARCHAR(100),
	AltText NVARCHAR(500),
	BigVersionPath VARCHAR(100),
	ProductID VARCHAR(20),
	OrdinalNumber INT,
	CONSTRAINT FK_ProductID1 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE User_
(
	UserID VARCHAR(20) NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(10) NOT NULL,
	MiddleName NVARCHAR(10) NOT NULL,
	LastName NVARCHAR(10) NOT NULL,
	FullName AS CONCAT(LastName, ' ', MiddleName, ' ', FirstName),
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
	FullAddress AS CONCAT(HouseNumber, ' ', Street, ', ', Ward, ', ', District, ', ', City, ', ', Country),
	UserID VARCHAR(20),
	isDefault TINYINT DEFAULT 0,
	Type NVARCHAR(20) DEFAULT N'Nhà riêng',
	CONSTRAINT FK_UserID1 FOREIGN KEY (UserID) REFERENCES User_(UserID)
)


CREATE TABLE OrderStatus
(
	StatusID VARCHAR(20) NOT NULL PRIMARY KEY,
	StatusName NVARCHAR(50) 
	CHECK (StatusName IN (
		N'Đã đặt hàng', 
		N'Đã xác nhận', 
		N'Đang giao hàng', 
		N'Đã giao hàng', 
		N'Đã hủy'
		)
	)
)

CREATE TABLE Voucher
(
	VoucherID VARCHAR(20) NOT NULL PRIMARY KEY,
	VoucherCode VARCHAR(20) NOT NULL,
	Name NVARCHAR(50),
	MinimumDiscount INT DEFAULT 0,
	MaximumDiscountAmount INT DEFAULT 0,
	DiscountPrice INT DEFAULT NULL,
	DiscountPercentage DECIMAL(2,0) DEFAULT NULL,
	VoucherDescription NVARCHAR(500),
	EventID VARCHAR(20),
	CONSTRAINT FK_EventID1 FOREIGN KEY (EventID) REFERENCES Event(EventID),
	CONSTRAINT CK_Discount CHECK (
        (DiscountPrice IS NOT NULL OR DiscountPercentage IS NOT NULL) 
        AND (DiscountPrice IS NULL OR DiscountPercentage IS NULL)
		AND (DiscountPrice IS NULL OR DiscountPrice >= 0)
		AND (DiscountPercentage IS NULL OR (DiscountPercentage >= 0 AND DiscountPercentage <= 100))
    )
)

CREATE TABLE Review
(
	ReviewID VARCHAR(20) NOT NULL PRIMARY KEY,
	ReviewTime DATE,
	ReviewMessage NVARCHAR(500),
	Stars DECIMAL(3,1)
)


CREATE TABLE Shipper
(
	ShipperID VARCHAR(20) NOT NULL PRIMARY KEY,
	Salary MONEY,
	FirstName NVARCHAR(10),
	MiddleName NVARCHAR(10),
	LastName NVARCHAR(10),
	FullName AS CONCAT(
		COALESCE(LastName, ''),
		' ',
		COALESCE(MiddleName, ''),
		' ',
		COALESCE(FirstName, '')
	),
	PhoneNumber VARCHAR(11) NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL UNIQUE,
	Password VARCHAR(30) NOT NULL,
	TotalOrder INT
)

CREATE TABLE Order_
(
	OrderID VARCHAR(20) NOT NULL PRIMARY KEY,
	UserID VARCHAR(20) NOT NULL,
	TotalPrice DECIMAL(20,2) DEFAULT 0,
	DateOrdered DATE,
	DeliveryAddressID VARCHAR(20),
	VoucherID VARCHAR(20) DEFAULT 'V000',
	ShippingFee DECIMAL(20,2) DEFAULT 20000,
	ShippingVATAmount DECIMAL(20,2) DEFAULT 2000,
	ShippingFeeIncludeVAT AS (ShippingFee + ShippingVATAmount),
	FinalAmount DECIMAL(20,2) DEFAULT 0,
	FinalVATAmount DECIMAL(20,2) DEFAULT 0,
	FinalAmountIncludeVAT DECIMAL(20,2) DEFAULT 0,
	CONSTRAINT FK_UserID2 FOREIGN KEY (UserID) REFERENCES User_(UserID),
	CONSTRAINT FK_AddressID FOREIGN KEY (DeliveryAddressID) REFERENCES Address(AddressID),
	CONSTRAINT FK_VoucherID1 FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
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
	CONSTRAINT FK_ProductID2 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
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
	CONSTRAINT FK_ProductID4 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	Constraint FK_UserID3 FOREIGN KEY(UserID) REFERENCES User_(UserID)
)

CREATE TABLE LikedProducts -- sản phẩm đã thích
(
	ProductID VARCHAR(20),
	UserID VARCHAR(20),
	CONSTRAINT FK_ProductID1_UserID1 PRIMARY KEY (ProductID, UserID),
	CONSTRAINT FK_ProductID5 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	Constraint FK_UserID4 FOREIGN KEY(UserID) REFERENCES User_(UserID)
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
	CONSTRAINT FK_ProductID6 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_UserID5 FOREIGN KEY (UserID) REFERENCES User_(UserID)
)

CREATE TABLE UserVoucher
(
	VoucherID VARCHAR(20),
	UserID VARCHAR(20),
	isUsed TINYINT,
	CONSTRAINT FK_VoucherID_UserID2 PRIMARY KEY (VoucherID, UserID),
	CONSTRAINT FK_VoucherID FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID),
	Constraint FK_UserID6 FOREIGN KEY(UserID) REFERENCES User_(UserID)
)


CREATE TABLE ShipperOrder
(
	OrderID VARCHAR(20),
	ShipperID VARCHAR(20),
	StatusID VARCHAR(20),
	Milestone DATETIME,
	CONSTRAINT FK_OrderID2_ShipperID PRIMARY KEY (OrderID, ShipperID, StatusID, Milestone),
	CONSTRAINT FK_OrderID2 FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_ShipperID FOREIGN KEY (ShipperID) REFERENCES Shipper(ShipperID),
	CONSTRAINT FK_StatusID FOREIGN KEY (StatusID) REFERENCES OrderStatus(StatusID)
)

CREATE TABLE ProductOrder
(
	OrderID VARCHAR(20),
	ProductID VARCHAR(20),
	Quantity SMALLINT DEFAULT 1,
	Amount DECIMAL(20,2) DEFAULT 0,
	VATAmount DECIMAL(20,2) DEFAULT 0,
	AmountIncludeVAT AS (Amount + VATAmount),
	CONSTRAINT FK_OrderID_ProductID2_VoucherID1 PRIMARY KEY (OrderID, ProductID),
	CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
	CONSTRAINT FK_ProductID8 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE EventProducts
(
	EventID VARCHAR(20),
	ProductID VARCHAR(20),
	DiscountPercent DECIMAL(2,0),
	CONSTRAINT FK_EventID_ProductID3 PRIMARY KEY(EventID, ProductID),
	CONSTRAINT FK_EventID FOREIGN KEY (EventID) REFERENCES Event(EventID),
	CONSTRAINT FK_ProductID7 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE VoucherProducts
(
	ProductID VARCHAR(20),
	VoucherID VARCHAR(20),
	CONSTRAINT FK_VoucherID2_ProductID4 PRIMARY KEY(VoucherID, ProductID),
	CONSTRAINT FK_VoucherID2 FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID),
	CONSTRAINT FK_ProductID9 FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE PaymentTerm
(
	PaymentTermID VARCHAR(20) NOT NULL PRIMARY KEY,
	PaymentTermName NVARCHAR(100)
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
	UserID VARCHAR(20),
	PaymentTermID VARCHAR(20),
	Note NVARCHAR(500),
	CONSTRAINT FK_UserID7 FOREIGN KEY (UserID) REFERENCES User_(UserID),
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

CREATE TABLE Rate
(
	RateID VARCHAR(20) NOT NULL PRIMARY KEY,
	RateName NVARCHAR(50) NOT NULL CHECK (
		RateName IN (
			N'VAT',
			N'Nhập',
			N'Xuất',
			N'GUARDIAN'
		)
	),
	RateValue DECIMAL(20,2)
)