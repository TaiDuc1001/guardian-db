﻿USE QL_Guardian

GO

CREATE TRIGGER UpdateProductInventory
ON [dbo].[ProductOrder]
AFTER INSERT
AS
BEGIN
	UPDATE [dbo].[Product]
	SET [StockQuantity]	= [StockQuantity] - (
      SELECT [Quantity] 
      FROM inserted 
      WHERE [dbo].[Product].ProductID = inserted.ProductID
    )
    WHERE [dbo].[Product].ProductID IN (
      SELECT[ProductID] FROM inserted
    )	
END

SELECT * FROM Product
SELECT * FROM ProductOrder
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O002', 'P001', 'V001', 4, 10000, 1490000)

GO
CREATE TRIGGER CalculateDiscountedAmount
ON [dbo].[ProductOrder]
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE [dbo].[ProductOrder]
	SET [DiscountedAmount] = (
      p.[Price] * po.[Quantity]) * (v.[DiscountPercentage]/100.0)
      FROM ProductOrder po 
      JOIN Voucher v ON po.[VoucherID] = v.[VoucherID]
      JOIN Product p ON po.[ProductID] = p.[ProductID]
      WHERE po.[OrderID] IN (SELECT[OrderID] FROM inserted
    )

	UPDATE[dbo].[ProductOrder]
	SET [FinalPrice] = (
      p.[Price] * po.[Quantity]) - po.[DiscountedAmount]
      FROM ProductOrder po
      JOIN Product p ON po.[ProductID] = p.[ProductID]
      WHERE po.[OrderID] IN (SELECT[OrderID] FROM inserted
    )
END

INSERT INTO ProductOrder(OrderID, ProductID, VoucherID, Quantity) VALUES ('O007','P004','V002', 4)
SELECT*FROM ProductOrder

SELECT*FROM Voucher

<<<<<<< HEAD
--Helloooooo

=======
>>>>>>> 01d274a1b00643044dceeae29699154e56a129a9
GO

CREATE TRIGGER UpdatePoints
ON [dbo].[Order_]
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @TotalPrice DECIMAL(18,2);
    DECLARE @UserID VARCHAR(20);

   
    SELECT @TotalPrice = o.[TotalPrice], @UserID = o.[UserID]
    FROM inserted o; 
	UPDATE [dbo].[User_]
    SET [Point] = ROUND([Point] + @TotalPrice / 10000, -1)
    WHERE [UserID] = @UserID;
    
END
SELECT*FROM User_
INSERT INTO Order_ VALUES ('O012', 'U002', 1500000, 'STATUS001', '2024-10-01', 'ADDR001')
SELECT*FROM Order_

--1Đ = 200VNĐ

--Hello

--helooooo