USE QL_Guardian

INSERT INTO Image_ (ImageID, ImagePath, AltText, BigVersionPath) VALUES 
('IMG001', '/images/img1.jpg', 'Sample Image 1', '/images/big_img1.jpg'),
('IMG002', '/images/img2.jpg', 'Sample Image 2', '/images/big_img2.jpg'),
('IMG003', '/images/img3.jpg', 'Sample Image 3', '/images/big_img3.jpg'),
('IMG004', '/images/img4.jpg', 'Sample Image 4', '/images/big_img4.jpg'),
('IMG005', '/images/img5.jpg', 'Sample Image 5', '/images/big_img5.jpg'),
('IMG006', '/images/img6.jpg', 'Sample Image 6', '/images/big_img6.jpg'),
('IMG007', '/images/img7.jpg', 'Sample Image 7', '/images/big_img7.jpg');

SELECT*FROM Image_

INSERT INTO Brand (BrandID, BrandName, isTopBrand) VALUES 
('BRD001', 'Brand A', 1),
('BRD002', 'Brand B', 0),
('BRD003', 'Brand C', 1),
('BRD004', 'Brand D', 0),
('BRD005', 'Brand E', 1),
('BRD006', 'Brand F', 0),


INSERT INTO Category (CategoryID, CategoryName) VALUES 
('CAT001', 'Điện tử'),
('CAT002', 'Quần áo'),
('CAT003', 'Nội thất'),
('CAT004', 'Sách'),
('CAT005', 'Đồ chơi'),
('CAT006', 'Thực phẩm'),
('CAT007', 'Việt Nam');

INSERT INTO Rank_ (RankID, RankName) VALUES 
('R001', 'Bronze'),
('R002', 'Silver'),
('R003', 'Gold'),
('R004', 'Platinum'),
('R005', 'Diamond'),
('R006', 'Master'),
('R007', 'Grandmaster');

INSERT INTO Product (ProductID, ProductName, RatingStars, BrandID, SKU, Price, CategoryID, Ingredients, DescriptionProduct, Uses, InstructionManualDescription, InstructionStoreDescription, StockQuantity) VALUES 
('P001', 'Laptop A', 0, 'BRD001', 'SKU001', 1500000, 'CAT001', 'Kim loại, Nhựa', 'Laptop hiệu năng cao', 'Văn phòng, Chơi game', 'Đọc hướng dẫn sử dụng', 'Bảo quản nơi thoáng mát', 100),
('P002', 'Áo Thun B', 0, 'BRD002', 'SKU002', 200000, 'CAT002', 'Cotton', 'Áo thun thoải mái', 'Trang phục thường ngày', 'Giặt riêng', 'Phơi nơi râm mát', 200),
('P003', 'Sofa C', 0, 'BRD003', 'SKU003', 3000000, 'CAT003', 'Gỗ, Vải', 'Sofa sang trọng', 'Phòng khách', 'Lắp ráp cẩn thận', 'Tránh ánh nắng trực tiếp', 50),
('P004', 'Sách D', 0, 'BRD004', 'SKU004', 150000, 'CAT004', 'Giấy', 'Sách truyền cảm hứng', 'Đọc', 'Cẩn thận khi sử dụng', 'Bảo quản nơi khô ráo', 300),
('P005', 'Đồ Chơi E', 0, 'BRD005', 'SKU005', 500000, 'CAT005', 'Nhựa', 'Đồ chơi vui nhộn', 'Trò chơi cho trẻ em', 'Giám sát khi chơi', 'Bảo quản nơi thoáng mát', 150),
('P006', 'Snack F', 0, 'BRD006', 'SKU006', 50000, 'CAT006', 'Lúa mì, Đường', 'Snack ngon miệng', 'Ăn', 'Giữ kín', 'Bảo quản nơi thoáng mát', 500),
('P007', 'Son G', 0, 'BRD007', 'SKU007', 300000, 'CAT007', 'Sáp, Chất tạo màu', 'Son lâu trôi', 'Làm đẹp', 'Thoa nhẹ nhàng', 'Bảo quản nơi thoáng mát', 100);


INSERT INTO Address_ (AddressID, PhoneNumber, HouseNumber, Street, Ward, District, City, Country) VALUES 
('ADDR001', '01234567890', '15', 'Nguyễn Huệ', 'Phường Bến Nghé', 'Quận 1', 'Thành phố Hồ Chí Minh', 'Việt Nam'),
('ADDR002', '09876543210', '101', 'Lê Lợi', 'Phường Bến Thành', 'Quận 1', 'Thành phố Hồ Chí Minh', 'Việt Nam'),
('ADDR003', '01112223344', '273', 'An Dương Vương', 'Phường 3', 'Quận 5', 'Thành phố Hồ Chí Minh', 'Việt Nam'),
('ADDR004', '02233445566', '50', 'Nguyễn Thái Bình', 'Phường Nguyễn Thái Bình', 'Quận 1', 'Thành phố Hồ Chí Minh', 'Việt Nam'),
('ADDR005', '03344556677', '1', 'Hàm Nghi', 'Phường Nguyễn Thái Bình', 'Quận 1', 'Thành phố Hồ Chí Minh', 'Việt Nam'),
('ADDR006', '04455667788', '180', 'Cách Mạng Tháng 8', 'Phường 10', 'Quận 3', 'Thành phố Hồ Chí Minh', 'Việt Nam'),
('ADDR007', '05566778899', '200', 'Lý Tự Trọng', 'Phường Bến Thành', 'Quận 1', 'Thành phố Hồ Chí Minh', 'Việt Nam');
SELECT*FROM Address_


INSERT INTO User_ (UserID, FirstName, MiddleName, LastName, PhoneNumber, Email, UserPassword, Point, RankID, TotalOrder, Birthdate, Sex) VALUES 
('U001', 'An', 'Văn', 'Nguyễn', '0912345678', 'an.nguyen@example.com', 'password123', 500, 'RANK01', 10, '1995-01-01', 'Nam'),
('U002', 'Bích', 'Thị', 'Trần', '0923456789', 'bich.tran@example.com', 'password456', 600, 'RANK02', 15, '1992-02-14', 'Nữ'),
('U003', 'Duy', 'Hoàng', 'Lê', '0934567890', 'duy.le@example.com', 'password789', 700, 'RANK03', 20, '1990-03-20', 'Nam'),
('U004', 'Khánh', 'Quốc', 'Phạm', '0945678901', 'khanh.pham@example.com', 'password101', 450, 'RANK02', 12, '1988-04-10', 'Nam'),
('U005', 'Lan', 'Ngọc', 'Vũ', '0956789012', 'lan.vu@example.com', 'password202', 550, 'RANK01', 8, '1993-05-05', 'Nữ'),
('U006', 'Minh', 'Thu', 'Đặng', '0967890123', 'thu.dang@example.com', 'password303', 620, 'RANK02', 14, '1996-06-18', 'Nữ'),
('U007', 'Phúc', 'Đình', 'Lý', '0978901234', 'phuc.ly@example.com', 'password404', 480, 'RANK01', 9, '1985-07-30', 'Nam'),
('U008', 'Thảo', 'Ngọc', 'Trương', '0989012345', 'thao.truong@example.com', 'password505', 530, 'RANK02', 11, '1991-08-25', 'Nữ'),
('U009', 'Long', 'Minh', 'Bùi', '0990123456', 'long.bui@example.com', 'password606', 450, 'RANK01', 6, '1994-09-12', 'Nam'),
('U010', 'Duyên', 'Thanh', 'Phạm', '0912345679', 'duyen.pham@example.com', 'password707', 710, 'RANK03', 18, '1989-10-10', 'Nữ');
SELECT*FROM User_

INSERT INTO UserBagProducts (ProductID, UserID, Quantity) VALUES 
('P001', 'U001', 1),
('P002', 'U002', 2),
('P003', 'U003', 1),
('P004', 'U004', 3),
('P005', 'U005', 1),
('P006', 'U006', 2),
('P007', 'U007', 1);


INSERT INTO LikedProducts (ProductID, UserID) VALUES 
('P001', 'U001'),
('P002', 'U002'),
('P003', 'U003'),
('P004', 'U004'),
('P005', 'U005'),
('P006', 'U006'),
('P007', 'U007');


INSERT INTO Voucher (VoucherID, Code, Name, MinimumPrice, DiscountPRice, DiscountPercentage, VoucherDescription) VALUES 
('V001', 'CODE001', 'Discount 10%', 100000, 10000, 10.0, '10% off on purchase above 100000'),
('V002', 'CODE002', 'Discount 20%', 200000, 40000, 20.0, '20% off on purchase above 200000'),
('V003', 'CODE003', 'Discount 30%', 300000, 90000, 30.0, '30% off on purchase above 300000'),
('V004', 'CODE004', 'Discount 40%', 400000, 160000, 40.0, '40% off on purchase above 400000'),
('V005', 'CODE005', 'Discount 50%', 500000, 250000, 50.0, '50% off on purchase above 500000'),
('V006', 'CODE006', 'Discount 15%', 150000, 22500, 15.0, '15% off on purchase above 150000'),
('V007', 'CODE007', 'Discount 25%', 250000, 62500, 25.0, '25% off on purchase above 250000');

INSERT INTO Shipper (ID, Salary, FirstName, MiddleName, LastName, PhoneNumber, Email, Password, TotalOrder) VALUES 
('SHP001', 10000000, 'An', 'Văn', 'Nguyễn', '0911223344', 'an.nguyen@shipper.com', 'shipper123', 50),
('SHP002', 12000000, 'Bình', 'Trọng', 'Trần', '0912233445', 'binh.tran@shipper.com', 'shipper456', 60),
('SHP003', 11000000, 'Cường', 'Ngọc', 'Lê', '0913344556', 'cuong.le@shipper.com', 'shipper789', 45),
('SHP004', 9000000, 'Dũng', 'Quốc', 'Phạm', '0914455667', 'dung.pham@shipper.com', 'shipper101', 40),
('SHP005', 9500000, 'E', 'Hoàng', 'Vũ', '0915566778', 'hoang.vu@shipper.com', 'shipper202', 55),
('SHP006', 13000000, 'Phát', 'Minh', 'Đặng', '0916677889', 'phat.dang@shipper.com', 'shipper303', 70),
('SHP007', 10500000, 'Giang', 'Huy', 'Lý', '0917788990', 'giang.ly@shipper.com', 'shipper404', 65),
('SHP008', 9800000, 'Thắng', 'Quốc', 'Nguyễn', '0918899001', 'thang.nguyen@shipper.com', 'shipper505', 30),
('SHP009', 11500000, 'Hà', 'Thanh', 'Võ', '0919900112', 'ha.vo@shipper.com', 'shipper606', 80),
('SHP010', 10800000, 'Kim', 'Lan', 'Bùi', '0920112233', 'kim.bui@shipper.com', 'shipper707', 55);


INSERT INTO Order_ (OrderID, UserID, TotalPrice, DateOrdered, DeliveryAddressID) VALUES 
('O001', 'U001', 1500000, '2024-10-01', 'ADDR001'),
('O002', 'U002', 200000, '2024-10-02', 'ADDR002'),
('O003', 'U003', 3000000, '2024-10-03', 'ADDR003'),
('O004', 'U004', 150000, '2024-10-04', 'ADDR004'),
('O005', 'U005', 500000, '2024-10-05', 'ADDR005'),
('O006', 'U006', 90000, '2024-10-06', 'ADDR006'),
('O007', 'U007', 250000, '2024-10-07', 'ADDR007');

INSERT INTO OrderStatus (StatusID, StatusName) VALUES 
('ST01', 'Đang giao'),       -- In Transit
('ST02', 'Đã giao'),         -- Delivered
('ST03', 'Đã hủy'),          -- Canceled
('ST04', 'Chờ xử lý'),       -- Pending
('ST05', 'Lỗi giao hàng');    -- Delivery Error

INSERT INTO ShipperOrder (OrderID, ShipperID, StatusID, Time) VALUES 
('O001', 'SHP001', 'ST01', '2024-10-01 08:30:00'),
('O002', 'SHP002', 'ST02', '2024-10-02 09:00:00'),
('O003', 'SHP003', 'ST01', '2024-10-03 10:15:00'),
('O004', 'SHP004', 'ST03', '2024-10-04 11:45:00'),
('O005', 'SHP005', 'ST02', '2024-10-05 12:30:00'),
('O006', 'SHP006', 'ST01', '2024-10-06 14:00:00'),
('O007', 'SHP007', 'ST03', '2024-10-07 16:30:00');

INSERT INTO Review (ReviewID, OrderID, ProductID, UserID, ReviewTime, ReviewContent, Stars) VALUES 
('R001', 'O001', 'P001', 'U001', '2024-10-01', 'Great product!', 4.5),
('R002', 'O002', 'P002', 'U002', '2024-10-02', 'Good value for money.', 4.0),
('R003', 'O003', 'P003', 'U003', '2024-10-03', 'Could be better.', 3.5),
('R004', 'O004', 'P004', 'U004', '2024-10-04', 'Excellent quality.', 4.9),
('R005', 'O005', 'P005', 'U005', '2024-10-05', 'Kids love it.', 4.7),
('R006', 'O006', 'P006', 'U006', '2024-10-06', 'Tasty snack.', 4.3),
('R007', 'O007', 'P007', 'U007', '2024-10-07', 'Perfect color.', 4.8);

INSERT INTO UserVoucher (VoucherID, UserID, isUsed) VALUES 
('V001', 'U001', 0),
('V002', 'U002', 1),
('V003', 'U003', 0),
('V004', 'U004', 1),
('V005', 'U005', 0),
('V006', 'U006', 1),
('V007', 'U007', 0);

INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O001', 'P001', 'V001', 1, 10000, 1490000),
('O002', 'P002', 'V002', 2, 20000, 180000),
('O003', 'P003', 'V003', 1, 50000, 2950000),
('O004', 'P004', 'V004', 3, 3000, 147000),
('O005', 'P005', 'V005', 1, 10000, 490000),
('O006', 'P006', 'V006', 2, 5000, 85000),
('O007', 'P007', 'V007', 1, 10000, 240000);

INSERT INTO Event_ (EventID, EventName, StartDate, EndDaye) VALUES 
('EVT001', 'Black Friday', '2024-11-24', '2024-11-30'),
('EVT002', 'Christmas Sale', '2024-12-15', '2024-12-25'),
('EVT003', 'New Year Sale', '2024-12-26', '2025-01-01'),
('EVT004', 'Summer Clearance', '2025-06-01', '2025-06-15'),
('EVT005', 'Spring Discounts', '2025-03-15', '2025-03-31'),
('EVT006', 'Back to School', '2025-08-01', '2025-08-15'),
('EVT007', 'Valentine Day', '2025-02-01', '2025-02-14');

INSERT INTO EventProduct (EventID, ProductID, DiscountPercent) VALUES 
('EVT001', 'P001', 20),
('EVT002', 'P002', 15),
('EVT003', 'P003', 25),
('EVT004', 'P004', 10),
('EVT005', 'P005', 30),
('EVT006', 'P006', 5),
('EVT007', 'P007', 20);


INSERT INTO VoucherProduct (ProductID, VoucherID) VALUES 
('P001', 'V001'),
('P002', 'V002'),
('P003', 'V003'),
('P004', 'V004'),
('P005', 'V005'),
('P006', 'V006'),
('P007', 'V007');

INSERT INTO PaymentTerm (PaymentTermID, PaymentTermName) VALUES 
('PT001', 'Credit Card'),
('PT002', 'PayPal'),
('PT003', 'Bank Transfer'),
('PT004', 'Cash on Delivery'),
('PT005', 'Gift Card'),
('PT006', 'Debit Card'),
('PT007', 'Installments');

INSERT INTO Invoice (InvoiceKey, Serial, InvoiceNumber, InvoiceDate, MCQT, BrandID, UserID, PaymentTermID, Note) VALUES 
('INV001', 'SER001', 1001, '2024-10-01', 'MCQT001', 'BRD001', 'U001', 'PT001', 'First invoice'),
('INV002', 'SER002', 1002, '2024-10-02', 'MCQT002', 'BRD002', 'U002', 'PT002', 'Second invoice'),
('INV003', 'SER003', 1003, '2024-10-03', 'MCQT003', 'BRD003', 'U003', 'PT003', 'Third invoice'),
('INV004', 'SER004', 1004, '2024-10-04', 'MCQT004', 'BRD004', 'U004', 'PT004', 'Fourth invoice'),
('INV005', 'SER005', 1005, '2024-10-05', 'MCQT005', 'BRD005', 'U005', 'PT005', 'Fifth invoice'),
('INV006', 'SER006', 1006, '2024-10-06', 'MCQT006', 'BRD006', 'U006', 'PT006', 'Sixth invoice'),
('INV007', 'SER007', 1007, '2024-10-07', 'MCQT007', 'BRD007', 'U007', 'PT007', 'Seventh invoice');

INSERT INTO Cart (ProductID, UserID, Quantity) VALUES 
('P001', 'U001', 1),
('P002', 'U002', 2),
('P003', 'U003', 1),
('P004', 'U004', 3),
('P005', 'U005', 1),
('P006', 'U006', 2),
('P007', 'U007', 1);

INSERT INTO Genre (ID, GenreName) VALUES 
('GEN001', 'Thể thao'),        -- Sports
('GEN002', 'Giải trí'),       -- Entertainment
('GEN003', 'Chính trị'),      -- Politics
('GEN004', 'Kinh tế'),        -- Economy
('GEN005', 'Công nghệ'),      -- Technology
('GEN006', 'Sức khỏe');        -- Health

INSERT INTO News (ID, PublishedDate, GenreID, HTMLPath, ThumbnailID) VALUES 
('NEWS001', '2024-10-01', 'GEN001', '/news/sports1.html', 'IMG001'),
('NEWS002', '2024-10-02', 'GEN002', '/news/entertainment1.html', 'IMG002'),
('NEWS003', '2024-10-03', 'GEN003', '/news/politics1.html', 'IMG003'),
('NEWS004', '2024-10-04', 'GEN004', '/news/economy1.html', 'IMG004'),
('NEWS005', '2024-10-05', 'GEN005', '/news/technology1.html', 'IMG005'),
('NEWS006', '2024-10-06', 'GEN006', '/news/health1.html', 'IMG006');
