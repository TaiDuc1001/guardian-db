USE QL_Guardian
GO
-- Delete all rows from all tables
DECLARE @SQL NVARCHAR(MAX) = '';
SELECT @SQL = @SQL + 'DELETE FROM [' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']; '
FROM [QL_Guardian].INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
EXEC sp_executesql @SQL;
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';

GO
INSERT INTO Category (CategoryID, CategoryName)
VALUES 
    ('C001', N'Chăm sóc da mặt'),
    ('C002', N'Chăm sóc da cơ thể'),
    ('C003', N'Chăm sóc tóc'),
    ('C004', N'Chăm sóc tay chân'),
    ('C005', N'Chống nắng'),
    ('C006', N'Dưỡng ẩm'),
    ('C007', N'Chống lão hóa'),
    ('C008', N'Chăm sóc mắt'),
    ('C009', N'Chăm sóc môi'),
    ('C010', N'Tẩy trang');


INSERT INTO Brand (BrandID, BrandName, isTopBrand)
VALUES 
    ('B001', N'P/S', 1),
    ('B002', N'Sensodyne', 0),
    ('B003', N'Listerine', 1),
    ('B004', N'Dove', 1),
    ('B005', N'Nivea', 1),
    ('B006', N'Pantene', 1),
    ('B007', N'Olay', 1),
    ('B008', N'Head & Shoulders', 1),
    ('B009', N'Colgate', 1),
    ('B010', N'Aveeno', 1);


INSERT INTO Rank (RankID, RankName)
VALUES 
    ('R001', N'Đồng'),
    ('R002', N'Bạc'),
    ('R003', N'Vàng'),
    ('R004', N'Platinum'),
    ('R005', N'Kim cương');

GO
INSERT INTO Product (
    ProductID, ProductName, RatingStars, BrandID, SKU, Price, CategoryID, 
    Ingredients, DescriptionProduct, Uses, Unit, InstructionManualDescription, 
    InstructionStoreDescription, SoldCount
)
VALUES 
    ('P001', N'Sữa rửa mặt', 4.5, 'B001', 'SKU001', 120000, 'C001', 
     N'Nước, Glycerin, Hương liệu', 
     N'Sữa rửa mặt nhẹ nhàng cho việc sử dụng hàng ngày.', 
     N'Làm sạch da hiệu quả.', 
     N'Tuýp', 
     N'Sử dụng trên mặt ướt, tạo bọt, rửa sạch.', 
     N'Bảo quản nơi khô ráo, thoáng mát.',
     1000),

    ('P002', N'Kem dưỡng thể', 4.2, 'B002', 'SKU002', 150000, 'C002', 
     N'Aloe Vera, Vitamin E, Bơ Shea', 
     N'Kem dưỡng thể cung cấp độ ẩm cho làn da khô.', 
     N'Cung cấp độ ẩm và nuôi dưỡng da.', 
     N'Chai', 
     N'Sử dụng hàng ngày cho cơ thể.', 
     N'Tránh xa ánh sáng trực tiếp.', 
     500),

    ('P003', N'Shampoo', 4.0, 'B003', 'SKU003', 180000, 'C003', 
     N'Chiết xuất thảo mộc, Dầu dừa', N'Shampoo thảo mộc cho mọi loại tóc.', 
     N'Làm sạch và nuôi dưỡng tóc.', 
     N'Chai', 
     N'Massage lên da đầu, rửa sạch.', 
     N'Bảo quản nơi khô ráo, thoáng mát.', 
     750),

    ('P004', N'Conditioner', 4.5, 'B002', 'SKU004', 190000, 'C002',
    N'Chiết xuất dầu argan, Vitamin E', N'Dầu xả dưỡng tóc cho tóc mượt mà.',
    N'Bảo vệ và phục hồi tóc.', 
    N'Chai', 
    N'Thoa đều lên tóc, giữ 3-5 phút, rửa sạch.', 
    N'Bảo quản nơi khô ráo, tránh ánh nắng trực tiếp.', 
    700),

    ('P005', N'Face Cleanser', 4.8, 'B004', 'SKU005', 250000, 'C004',
    N'Tinh chất trà xanh, Lô hội', N'Sữa rửa mặt dịu nhẹ cho da nhạy cảm.',
    N'Làm sạch và làm dịu da.', 
    N'Tuýp', 
    N'Lấy một lượng vừa đủ, mát-xa lên da mặt, rửa sạch.', 
    N'Bảo quản nơi thoáng mát, tránh xa ánh nắng.', 
    150),

    ('P006', N'Sunscreen SPF 50+', 4.7, 'B001', 'SKU006', 320000, 'C005',
    N'Kẽm oxit, Titanium dioxide', N'Kem chống nắng bảo vệ da tối đa.',
    N'Ngăn ngừa tác hại từ tia UV.', 
    N'Tuýp', 
    N'Thoa đều trước khi ra nắng 15 phút.', 
    N'Để nơi thoáng mát, tránh ánh nắng.', 
    100),

    ('P007', N'Body Lotion', 4.6, 'B003', 'SKU007', 210000, 'C006',
    N'Tinh dầu hạnh nhân, Vitamin C', N'Sữa dưỡng thể giúp da mềm mại và ẩm mượt.',
    N'Dưỡng ẩm da toàn thân.', 
    N'Chai', 
    N'Thoa đều lên da, sử dụng hàng ngày.', 
    N'Bảo quản nơi khô ráo, thoáng mát.', 
    300),

    ('P008', N'Anti-aging Serum', 4.9, 'B005', 'SKU008', 400000, 'C007',
    N'Retinol, Vitamin A', N'Serum chống lão hóa cho da căng mịn.',
    N'Giúp giảm nếp nhăn và trẻ hóa da.', 
    N'Chai', 
    N'Thoa một lượng nhỏ lên mặt trước khi ngủ.', 
    N'Bảo quản nơi mát mẻ, tránh ánh sáng.', 
    50);


INSERT INTO Image (
    ImageID, ImagePath, AltText, BigVersionPath, ProductID, OrdinalNumber
)
VALUES 
    ('I001', N'/images/product1_small.jpg', N'Hình ảnh sản phẩm sữa rửa mặt', N'/images/product1_large.jpg', 'P001', 1),
    ('I002', N'/images/product1_small_2.jpg', N'Hình ảnh sản phẩm sữa rửa mặt - góc nghiêng', N'/images/product1_large_2.jpg', 'P001', 2),
    ('I003', N'/images/product2_small.jpg', N'Hình ảnh sản phẩm kem dưỡng thể', N'/images/product2_large.jpg', 'P002', 1),
    ('I004', N'/images/product3_small.jpg', N'Hình ảnh sản phẩm shampoo', N'/images/product3_large.jpg', 'P003', 1),
    ('I005', N'/images/product3_small_2.jpg', N'Hình ảnh sản phẩm shampoo - góc nhìn khác', N'/images/product3_large_2.jpg', 'P003', 2),
    ('I006', N'/images/product2_small_2.jpg', N'Hình ảnh kem dưỡng thể - chi tiết', N'/images/product2_large_2.jpg', 'P002', 2);

INSERT INTO User_ (
    UserID, FirstName, MiddleName, LastName, PhoneNumber, Email, UserPassword, 
    Point, RankID, TotalOrder, Birthdate, Sex
)
VALUES 
    ('U001', N'An', N'Hà', N'Lê', '0123456789', 'an.le@heisenberg.com', 'ligma', 
     100, 'R001', 0, '1990-05-15', 'Nam'),
     
    ('U002', N'An', N'Ngọc', N'Tri', '0987654321', 'an.tri@example.com', 'password456', 
     200, 'R002', 1, '1985-08-20', 'Nữ'),
     
    ('U003', N'An', N'Quỳnh', N'Sơn', '0912345678', 'an.son@nigga.com', 'password789', 
     150, 'R003', 2, '1992-12-01', 'Nam'),
     
    ('U004', N'An', N'Mai', N'Tôn', '0934567890', 'an.mai@nword.com', 'password101', 
     300, 'R001', 3, '1995-03-10', 'Nữ'),
     
    ('U005', N'An', N'Văn', N'Đỗ', '0945678901', 'an.do@example.com', 'password202', 
     50, 'R002', 1, '1998-07-25', 'Nam');

INSERT INTO Event (
    EventID, EventName, StartDate, EndDate
)
VALUES 
    ('E001', N'Hội chợ mỹ phẩm', '2024-11-01', '2024-11-05'),
    ('E002', N'Triển lãm sản phẩm làm đẹp', '2024-11-10', '2024-11-15'),
    ('E003', N'Sự kiện ra mắt sản phẩm mới', '2024-11-20', '2024-11-20'),
    ('E004', N'Khóa học chăm sóc da', '2024-12-01', '2024-12-05'),
    ('E005', N'Chương trình khuyến mãi cuối năm', '2024-12-15', '2024-12-31');

INSERT INTO Address (
    AddressID, PhoneNumber, HouseNumber, Street, Ward, District, City, 
    Country, UserID, isDefault, Type
)
VALUES 
    ('A001', '0123456789', '123', N'Trần Hưng Đạo', N'Phường 1', N'Quận 1', N'Hồ Chí Minh', 
     N'Việt Nam', 'U001', 1, N'Nhà riêng'),
    ('A002', '0987654321', '456', N'Nguyễn Thái Học', N'Phường 2', N'Quận 3', N'Hồ Chí Minh', 
     N'Việt Nam', 'U002', 0, N'Cơ quan'),
    ('A003', '0912345678', '789', N'Tôn Đức Thắng', N'Phường 3', N'Quận 5', N'Hồ Chí Minh', 
     N'Việt Nam', 'U003', 0, N'Cơ quan'),
    ('A004', '0934567890', '321', N'Lê Duẩn', N'Phường 4', N'Quận 10', N'Hồ Chí Minh', 
     N'Việt Nam', 'U004', 0, N'Nhà riêng'),
    ('A005', '0945678901', '654', N'Phạm Ngọc Thạch', N'Phường 5', N'Quận 11', N'Hồ Chí Minh', 
     N'Việt Nam', 'U005', 0, N'Nhà riêng'),
    ('A006', '0956789012', '987', N'Hai Bà Trưng', N'Phường 6', N'Quận 12', N'Hồ Chí Minh', 
     N'Việt Nam', 'U001', 0, N'Nhà riêng'),
    ('A007', '0967890123', '159', N'Trần Não', N'Phường 7', N'Quận 2', N'Hồ Chí Minh', 
     N'Việt Nam', 'U003', 0, N'Nhà riêng');

INSERT INTO OrderStatus (
    StatusID, StatusName
)
VALUES 
    ('S001', N'Đã đặt hàng'),
    ('S002', N'Đã xác nhận'),
    ('S003', N'Đang giao hàng'),
    ('S004', N'Đã giao hàng'),
    ('S005', N'Đã hủy');

     
INSERT INTO Voucher (
    VoucherID, VoucherCode, Name, MinimumPrice, DiscountPrice, 
    DiscountPercentage, VoucherDescription, EventID
)
VALUES
    ('V000', 'NoDiscount', N'Default value', NULL, NULL, 
     0, N'LORUM LORUM', 'E001'),

    ('V001', 'KM10', N'Giảm giá 10%', 200000, 10000, 
     10, N'Mã giảm giá 10% cho đơn hàng từ 200.000đ.', 'E001'),
     
    ('V002', 'KM20', N'Giảm giá 20%', 300000, 50000, 
     20, N'Mã giảm giá 50.000đ cho đơn hàng từ 300.000đ.', 'E002'),
     
    ('V003', 'KM15', N'Giảm giá 15%', 150000, 20000, 
     15, N'Mã giảm giá 15% cho đơn hàng từ 150.000đ.', 'E003'),
     
    ('V004', 'KM5', N'Giảm giá 5%', 50000, 5000, 
     5, N'Mã giảm giá 5.000đ cho đơn hàng từ 50.000đ.', 'E004'),
     
    ('V005', 'KM30', N'Giảm giá 30%', 400000, 120000, 
     30, N'Mã giảm giá 120.000đ cho đơn hàng từ 400.000đ.', 'E005');

INSERT INTO Review (
    ReviewID, ReviewTime, ReviewMessage, Stars
)
VALUES 
    ('R001', '2024-10-01', N'Sản phẩm rất tốt, tôi rất hài lòng!', 4.5),
    ('R002', '2024-10-10', N'Thuốc này chơi ko phê! Đề kháng tôi chưa khoẻ lên được!', 3.0),
    ('R003', '2024-10-15', N'Tôi không hài lòng lắm với sản phẩm này.', 2.0);

INSERT INTO Shipper (
    ShipperID, Salary, FirstName, MiddleName, LastName, 
    PhoneNumber, Email, Password, TotalOrder
)
VALUES 
    ('SH001', 5000000, N'An', N'Hà', N'Lê', 
     '0123456789', 'an.ha.le@example.com', 'password1', 20),
    ('SH002', 5500000, N'Bình', N'Thành', N'Nguyễn', 
     '0987654321', 'binh.thanh.nguyen@example.com', 'password2', 15),
    ('SH003', 6000000, N'Cường', N'Văn', N'Trần', 
     '0912345678', 'cuong.van.tran@example.com', 'password3', 25);

INSERT INTO Order_ (OrderID, UserID, TotalPrice, DateOrdered, DeliveryAddressID) VALUES
    ('O001', 'U001', 150000, '2024-10-01', 'A001'),
    ('O002', 'U002', 300000, '2024-10-05', 'A002'),
    ('O003', 'U003', 250000, '2024-10-10', 'A003'),
    ('O004', 'U001', 500000, '2024-10-15', 'A004'),
    ('O005', 'U002', 450000, '2024-10-20', 'A005'),
    ('O006', 'U003', 320000, '2024-10-25', 'A006'),
    ('O007', 'U004', 220000, '2024-10-30', 'A007'),
    ('O008', 'U005', 600000, '2024-11-01', 'A007');


INSERT INTO CentralWarehouse (
    CentralWID, CentralWName, Region, AddressID
)
VALUES 
    ('CW001', N'Kho Tổng Miền Bắc', N'Miền Bắc', 'A001'),
    ('CW002', N'Kho Tổng Miền Trung', N'Miền Trung', 'A002'),
    ('CW003', N'Kho Tổng Miền Nam', N'Miền Nam', 'A003');

INSERT INTO BranchWarehouse (
    BranchWID, BranchWName, Region, AddressID, CentralWID
)
VALUES 
    ('BW001', N'Kho Chi Nhánh Hà Nội', N'Quận Bắc Từ Liêm', 'A001', 'CW001'),
    ('BW002', N'Kho Chi Nhánh Hải Phòng', N'Quận ABC', 'A002', 'CW001'),
    ('BW003', N'Kho Chi Nhánh Đà Nẵng', N'Quận 123', 'A003', 'CW002'),
    ('BW004', N'Kho Chi Nhánh Huế', N'Quận ảo', 'A004', 'CW002'),
    ('BW005', N'Kho Chi Nhánh TP.HCM', N'Quận 1', 'A005', 'CW003'),
    ('BW006', N'Kho Chi Nhánh Biên Hòa', N'Quận 2', 'A006', 'CW003'),
    ('BW007', N'Kho Chi Nhánh Cần Thơ', N'Quận 9', 'A007', 'CW003');

INSERT INTO CentralW_Product (
    ProductID, CentralWID, StockQuantity
)
VALUES 
    ('P001', 'CW001', 100),
    ('P002', 'CW001', 200),
    ('P003', 'CW002', 150),
    ('P001', 'CW003', 80),
    ('P003', 'CW003', 120);

INSERT INTO BranchW_Product (
    ProductID, BranchWID, StockQuantity
)
VALUES 
    ('P001', 'BW001', 50),
    ('P002', 'BW001', 30),
    ('P003', 'BW002', 70),
    ('P001', 'BW003', 90),
    ('P004', 'BW003', 20),
    ('P002', 'BW004', 60),
    ('P001', 'BW005', 40),
    ('P002', 'BW006', 100),
    ('P004', 'BW007', 80);

INSERT INTO Gift (
    MainProductID, GiftProductID, Quantity, StartDate, EndDate
)
VALUES 
    ('P001', 'P002', 1, '2024-10-01', '2024-10-15'),
    ('P003', 'P004', 1, '2024-10-05', '2024-10-20'),
    ('P002', 'P001', 1, '2024-10-10', '2024-10-30');

INSERT INTO Cart (
    ProductID, UserID, Quantity
)
VALUES 
    ('P001', 'U001', 2),
    ('P002', 'U002', 1),
    ('P003', 'U001', 3),
    ('P004', 'U003', 1),
    ('P002', 'U004', 5);

INSERT INTO LikedProducts (
    ProductID, UserID
)
VALUES 
    ('P001', 'U001'),
    ('P002', 'U002'),
    ('P003', 'U003');

INSERT INTO ReviewOf (
    ReviewID, OrderID, ProductID, UserID
)
VALUES 
    ('R001', 'O001', 'P001', 'U001'),
    ('R002', 'O002', 'P002', 'U002'),
    ('R003', 'O003', 'P003', 'U003');

INSERT INTO UserVoucher (
    VoucherID, UserID, isUsed
)
VALUES 
    ('V001', 'U001', 0),
    ('V002', 'U002', 1),
    ('V003', 'U003', 0),
    ('V001', 'U004', 1),
    ('V002', 'U001', 0),
    ('V003', 'U002', 1);

INSERT INTO ShipperOrder (
    OrderID, ShipperID, StatusID, Milestone
)
VALUES 
    ('O001', 'SH001', 'S001', '2024-10-01 08:30:00'),
    ('O002', 'SH002', 'S002', '2024-10-02 09:00:00'),
    ('O003', 'SH001', 'S003', '2024-10-03 10:15:00'),
    ('O001', 'SH003', 'S001', '2024-10-04 11:00:00'),
    ('O004', 'SH002', 'S004', '2024-10-05 12:30:00'),
    ('O005', 'SH003', 'S005', '2024-10-06 13:45:00');

INSERT INTO ProductOrder (
    OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice
)
VALUES 
    ('O001', 'P001', 'V001', 2, 5000, 95000),
    ('O001', 'P002', 'V002', 1, 2000, 48000),
    ('O002', 'P003', NULL, 3, 0, 120000),
    ('O003', 'P001', 'V003', 1, 3000, 45000),
    ('O004', 'P002', NULL, 5, 0, 240000),
    ('O005', 'P001', 'V002', 2, 10000, 85000),
    ('O006', 'P003', 'V001', 1, 0, 60000),
    ('O007', 'P001', NULL, 4, 5000, 180000),
    ('O008', 'P002', 'V003', 1, 2000, 23000);

INSERT INTO EventProducts (
    EventID, ProductID, DiscountPercent
)
VALUES 
    ('E001', 'P001', 10),
    ('E001', 'P002', 15),
    ('E002', 'P003', 5),
    ('E003', 'P001', 20),
    ('E002', 'P002', 25),
    ('E003', 'P003', 30);

INSERT INTO VoucherProducts (
    ProductID, VoucherID
)
VALUES 
    ('P001', 'V001'),
    ('P001', 'V002'),
    ('P002', 'V001'),
    ('P002', 'V003'),
    ('P003', 'V001'),
    ('P003', 'V002'),
    ('P004', 'V003'),
    ('P005', 'V002'),
    ('P006', 'V001');

INSERT INTO PaymentTerm (
    PaymentTermID, PaymentTermName
)
VALUES 
    ('PT001', N'Thanh toán khi nhận hàng'),
    ('PT002', N'Thanh toán qua thẻ ngân hàng'),
    ('PT003', N'Thanh toán qua ví điện tử');

INSERT INTO Invoice (
    InvoiceKey, Serial, InvoiceNumber, InvoiceDate, MCQT, BrandID, UserID, PaymentTermID, Note
)
VALUES 
    ('INV001', 'SER123456', 1001, GETDATE(), 'MCQT001', 'B001', 'U001', 'PT001', N'Ghi chú hóa đơn 001'),
    ('INV002', 'SER123457', 1002, GETDATE(), 'MCQT002', 'B002', 'U002', 'PT002', N'Ghi chú hóa đơn 002'),
    ('INV003', 'SER123458', 1003, GETDATE(), 'MCQT003', 'B001', 'U003', 'PT003', N'Ghi chú hóa đơn 003');

INSERT INTO Genre (ID, GenreName)
VALUES 
    ('GEN001', N'Chính trị'),
    ('GEN002', N'Kinh tế'),
    ('GEN003', N'Xã hội'),
    ('GEN004', N'Văn hóa'),
    ('GEN005', N'Giáo dục'),
    ('GEN006', N'Khoa học');

INSERT INTO News (ID, PublishedDate, GenreID, HTMLPath, ThumbnailID)
VALUES 
    ('NEWS001', '2024-01-10', 'GEN001', 'path/to/news1.html', 'I001'),
    ('NEWS002', '2024-01-11', 'GEN002', 'path/to/news2.html', 'I002'),
    ('NEWS003', '2024-01-12', 'GEN003', 'path/to/news3.html', 'I003'),
    ('NEWS004', '2024-01-13', 'GEN004', 'path/to/news4.html', 'I004'),
    ('NEWS005', '2024-01-14', 'GEN005', 'path/to/news5.html', 'I005'),
    ('NEWS006', '2024-01-15', 'GEN006', 'path/to/news6.html', 'I006'),
    ('NEWS007', '2024-01-16', 'GEN001', 'path/to/news7.html', 'I006');

INSERT INTO Rate (RateID, RateName, RateValue)
VALUES 
    ('TAX001', N'VAT', 0.10),
    ('TAX002', N'Nhập', 0.05),
    ('TAX003', N'Xuất', 0.10),
    ('TAX004', N'GUARDIAN', 0.15);