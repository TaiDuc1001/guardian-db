USE QL_Guardian

GO

CREATE TRIGGER UpdateProductInventory
ON ProductOrder
AFTER INSERT
AS
BEGIN
	DECLARE @ProductID VARCHAR(20);
	DECLARE @OrderedQuantity INT; 
	DECLARE @CurrentStockQuantity INT;

	DECLARE product_cur CURSOR FOR
	SELECT ins.ProductID, ins.Quantity
	FROM inserted ins

	OPEN product_cur

	FETCH NEXT FROM product_cur INTO @ProductID, @OrderedQuantity;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @CurrentStockQuantity = 
			(
				SELECT pro.StockQuantity
				FROM Product pro
				WHERE ProductID = @ProductID
			)
		IF @CurrentStockQuantity >= @OrderedQuantity
		BEGIN
			UPDATE Product
			SET StockQuantity = StockQuantity - @OrderedQuantity
			WHERE ProductID = @ProductID
		END
		ELSE
		BEGIN
			UPDATE Product
			SET StockQuantity = 0
			WHERE ProductID = @ProductID
			PRINT N'Sản phẩm ' + @ProductID + N' không đủ so với số lượng tồn kho.';
			ROLLBACK 
		END
		FETCH NEXT FROM product_cur INTO @ProductID, @OrderedQuantity
	END
	CLOSE product_cur
	DEALLOCATE product_cur
END

SELECT * FROM Product
SELECT * FROM ProductOrder
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O007', 'P001', 'V001', 96, 10000, 1490000)

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




GO
ALTER TABLE Product ADD TongSoSanPhamDaBan INT DEFAULT 0
SELECT*FROM Product
DROP TRIGGER UpdateProductSold
GO
CREATE TRIGGER UpdateProductSold
ON ProductOrder
FOR INSERT, UPDATE
AS
BEGIN
	UPDATE Product SET TongSoSanPhamDaBan =  
	(
		SELECT SUM(po.Quantity)
		FROM ProductOrder po, Product pro, inserted ins
		WHERE po.ProductID = pro.ProductID
		AND ins.ProductID = po.ProductID
	)
	FROM inserted ins, Product pro, ProductOrder po
	WHERE pro.ProductID = ins.ProductID
	AND po.ProductID = ins.ProductID
END
SELECT*FROM Product
SELECT*FROM Order_
SELECT*FROM ProductOrder
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O010', 'P001', 'V001', 1, 10000, 1490000)
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O011', 'P002', 'V001', 10, 10000, 1490000)
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O012', 'P003', 'V001', 10, 10000, 1490000)
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O013', 'P004', 'V001', 10, 10000, 1490000)
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O014', 'P005', 'V001', 10, 10000, 1490000)
INSERT INTO ProductOrder (OrderID, ProductID, VoucherID, Quantity, DiscountedAmount, FinalPrice) VALUES 
('O015', 'P006', 'V001', 10, 10000, 1490000)



--1Đ = 200VNĐ

--Hello

--helooooo