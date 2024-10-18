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
('BRD007', 'Brand G', 1);


INSERT INTO Category (CategoryID, CategoryName) VALUES 
('CAT001', 'Electronics'),
('CAT002', 'Clothing'),
('CAT003', 'Furniture'),
('CAT004', 'Books'),
('CAT005', 'Toys'),
('CAT006', 'Food'),
('CAT007', 'Beauty');


INSERT INTO Rank_ (RankID, RankName) VALUES 
('R001', 'Bronze'),
('R002', 'Silver'),
('R003', 'Gold'),
('R004', 'Platinum'),
('R005', 'Diamond'),
('R006', 'Master'),
('R007', 'Grandmaster');

INSERT INTO Product (ProductID, ProductName, RatingStars, BrandID, SKU, Price, CategoryID, Ingredients, DescriptionProduct, Uses, InstructionManualDescription, InstructionStoreDescription, StockQuantity) VALUES 
('P001', 'Laptop A', 4.5, 'BRD001', 'SKU001', 1500000, 'CAT001', 'Metal, Plastic', 'High-performance laptop', 'Office, Gaming', 'Read manual', 'Keep in cool place', 100),
('P002', 'T-Shirt B', 4.0, 'BRD002', 'SKU002', 200000, 'CAT002', 'Cotton', 'Comfortable T-shirt', 'Casual wear', 'Wash separately', 'Dry in shade', 200),
('P003', 'Sofa C', 3.8, 'BRD003', 'SKU003', 3000000, 'CAT003', 'Wood, Fabric', 'Luxury sofa', 'Living room', 'Assemble carefully', 'Keep away from sunlight', 50),
('P004', 'Book D', 4.9, 'BRD004', 'SKU004', 150000, 'CAT004', 'Paper', 'Inspirational book', 'Reading', 'Handle with care', 'Store in dry place', 300),
('P005', 'Toy E', 4.7, 'BRD005', 'SKU005', 500000, 'CAT005', 'Plastic', 'Fun toy', 'Kids play', 'Supervise while playing', 'Store in cool place', 150),
('P006', 'Snack F', 4.3, 'BRD006', 'SKU006', 50000, 'CAT006', 'Wheat, Sugar', 'Delicious snack', 'Eating', 'Keep sealed', 'Store in cool place', 500),
('P007', 'Lipstick G', 4.8, 'BRD007', 'SKU007', 300000, 'CAT007', 'Wax, Colorant', 'Long-lasting lipstick', 'Beauty', 'Apply gently', 'Store in cool place', 100);


INSERT INTO Address_ (AddressID, PhoneNumber, HouseNumber, Street, Ward, District, City, Country) VALUES 
('ADDR001', '01234567890', '12', 'Main Street', 'Ward 1', 'District A', 'City X', 'Country Y'),
('ADDR002', '09876543210', '34', 'Second Street', 'Ward 2', 'District B', 'City Y', 'Country Y'),
('ADDR003', '01112223344', '56', 'Third Street', 'Ward 3', 'District C', 'City Z', 'Country Y'),
('ADDR004', '02233445566', '78', 'Fourth Street', 'Ward 4', 'District D', 'City X', 'Country Z'),
('ADDR005', '03344556677', '90', 'Fifth Street', 'Ward 5', 'District E', 'City Y', 'Country X'),
('ADDR006', '04455667788', '21', 'Sixth Street', 'Ward 6', 'District F', 'City Z', 'Country Z'),
('ADDR007', '05566778899', '43', 'Seventh Street', 'Ward 7', 'District G', 'City X', 'Country Y');
SELECT*FROM Address_


INSERT INTO User_ (UserID, FirstName, LastName, PhoneNumber, Email, UserPassword, Point, RankID, TotalOrder, Birthdate, Sex) VALUES 
('U001', 'John', 'Doe', '01234567890', 'john.doe@example.com', 'pass123', 100, 'R001', 5, '1990-01-01', 'M'),
('U002', 'Jane', 'Smith', '09876543210', 'jane.smith@example.com', 'pass456', 200, 'R002', 10, '1992-02-02', 'F'),
('U003', 'Alice', 'Johnson', '01112223344', 'alice.j@example.com', 'pass789', 150, 'R003', 7, '1988-03-03', 'F'),
('U004', 'Bob', 'Brown', '02233445566', 'bob.brown@example.com', 'passabc', 300, 'R004', 12, '1985-04-04', 'M'),
('U005', 'Charlie', 'Davis', '03344556677', 'charlie.d@example.com', 'passdef', 80, 'R005', 4, '1991-05-05', 'M'),
('U006', 'David', 'Wilson', '04455667788', 'david.w@example.com', 'passghi', 90, 'R006', 6, '1987-06-06', 'M'),
('U007', 'Emily', 'Martinez', '05566778899', 'emily.m@example.com', 'passjkl', 250, 'R007', 11, '1993-07-07', 'F');
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

INSERT INTO Order_ (OrderID, UserID, TotalPrice, OrderStatusID, DateOrdered, DeliveryAddressID) VALUES 
('O001', 'U001', 1500000, 'STATUS001', '2024-10-01', 'ADDR001'),
('O002', 'U002', 200000, 'STATUS002', '2024-10-02', 'ADDR002'),
('O003', 'U003', 3000000, 'STATUS001', '2024-10-03', 'ADDR003'),
('O004', 'U004', 150000, 'STATUS003', '2024-10-04', 'ADDR004'),
('O005', 'U005', 500000, 'STATUS002', '2024-10-05', 'ADDR005'),
('O006', 'U006', 90000, 'STATUS001', '2024-10-06', 'ADDR006'),
('O007', 'U007', 250000, 'STATUS003', '2024-10-07', 'ADDR007');


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

INSERT INTO OrderStatus (StatusID, StatusName) VALUES 
('STATUS001', 'Pending'),
('STATUS002', 'Completed'),
('STATUS003', 'Cancelled'),
('STATUS004', 'Processing'),
('STATUS005', 'Returned'),
('STATUS006', 'On Hold'),
('STATUS007', 'Shipped');

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
