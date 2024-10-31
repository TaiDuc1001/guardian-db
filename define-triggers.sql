﻿USE QL_Guardian
GO

DECLARE @SQL NVARCHAR(MAX) = '';

-- Generate the drop trigger statements
SELECT @SQL = @SQL + 'DROP TRIGGER [' + OBJECT_SCHEMA_NAME(t.parent_id) + '].[' + t.name + ']; '
FROM sys.triggers AS t
JOIN sys.tables AS tbl ON t.parent_id = tbl.object_id;

-- Execute the generated SQL to drop all triggers
EXEC sp_executesql @SQL;
GO

CREATE TRIGGER UpdateProductInventory
ON ProductOrder
AFTER INSERT
AS
BEGIN
	DECLARE @ProductID VARCHAR(20);
	DECLARE @OrderedQuantity INT; 
	DECLARE @CurrentStockQuantity INT;
	DECLARE @OrderID VARCHAR(20);
	DECLARE @AddressID VARCHAR(20);
	DECLARE @BranchWID VARCHAR(20);

	DECLARE product_cur CURSOR FOR
	SELECT ins.ProductID, ins.Quantity, ins.OrderID
	FROM inserted ins

	OPEN product_cur

	FETCH NEXT FROM product_cur INTO @ProductID, @OrderedQuantity, @OrderID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @AddressID = 
		(
			SELECT o.DeliveryAddressID
			FROM Order_ o
			WHERE o.OrderID = @OrderID
		)
		SET @BranchWID = 
		(
			SELECT bw.BranchWID
			FROM BranchWarehouse bw
			WHERE bw.AddressID = @AddressID
		)
		SET @CurrentStockQuantity = 
			(
				SELECT bwp.StockQuantity
				FROM BranchW_Product bwp
				WHERE bwp.ProductID = @ProductID AND bwp.BranchWID = @BranchWID
			)
		IF @CurrentStockQuantity >= @OrderedQuantity
		BEGIN
			UPDATE BranchW_Product
			SET StockQuantity = StockQuantity - @OrderedQuantity
			WHERE ProductID = @ProductID AND BranchWID = @BranchWID
		END
		ELSE
		BEGIN
			UPDATE BranchW_Product
			SET StockQuantity = 0
			WHERE ProductID = @ProductID AND BranchWID = @BranchWID
			PRINT N'Sản phẩm ' + @ProductID + N' không đủ so với số lượng tồn kho.';
			ROLLBACK 
		END
		FETCH NEXT FROM product_cur INTO @ProductID, @OrderedQuantity, @OrderID
	END
	CLOSE product_cur
	DEALLOCATE product_cur
END
GO

CREATE TRIGGER CalculateVATAmounts
ON ProductOrder
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @OrderID VARCHAR(20), @ProductID VARCHAR(20), @Quantity INT, @Price DECIMAL(10, 0)
    DECLARE @Amount DECIMAL(20, 0), @VATAmount DECIMAL(20, 0), @AmountIncludeVAT DECIMAL(20, 0)
    
    DECLARE cursor_order CURSOR FOR 
        SELECT OrderID, ProductID, Quantity
        FROM inserted

    OPEN cursor_order

    FETCH NEXT FROM cursor_order INTO @OrderID, @ProductID, @Quantity

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Giả sử lấy giá từ bảng Product, bạn cần sửa nếu cần
        SELECT @Price = Price FROM Product WHERE ProductID = @ProductID
        SET @Amount = @Quantity * @Price
        SET @VATAmount = @Amount * 0.1
        SET @AmountIncludeVAT = @Amount + @VATAmount

        UPDATE ProductOrder
        SET Amount = @Amount,
            VATAmount = @VATAmount
        WHERE OrderID = @OrderID AND ProductID = @ProductID

        FETCH NEXT FROM cursor_order INTO @OrderID, @ProductID, @Quantity
    END

    CLOSE cursor_order
    DEALLOCATE cursor_order
END

GO

CREATE TRIGGER UpdatePoints
ON Order_
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @TotalPrice DECIMAL(18,2);
    DECLARE @UserID VARCHAR(20);

   
    SELECT @TotalPrice = o.TotalPrice, @UserID = o.[UserID]
    FROM inserted o; 
	UPDATE User_
    SET [Point] = ROUND([Point] + @TotalPrice / 10000, -1)
    WHERE [UserID] = @UserID;
END
GO

CREATE TRIGGER UpdateProductSold
ON ProductOrder
FOR INSERT, UPDATE
AS
BEGIN
	UPDATE Product
	SET TongSoSanPhamDaBan = TongSoSanPhamDaBan + ins.Quantity
	FROM Product pro
	INNER JOIN inserted ins on ins.ProductID = pro.ProductID
END
SELECT*FROM Product
SELECT*FROM Order_
SELECT*FROM ProductOrder
GO

CREATE TRIGGER HandleVoucherMismatch
ON Order_
AFTER INSERT
AS
BEGIN
	DECLARE @OrderID VARCHAR(20);
	DECLARE @VoucherID VARCHAR(20);
	DECLARE @ProductID VARCHAR(20);
	DECLARE @VoucherProductID VARCHAR(20);

	DECLARE ins_cursor CURSOR FOR 
	SELECT ins.OrderID, ins.VoucherID
	FROM inserted ins

	OPEN ins_cursor 
	FETCH NEXT FROM ins_currsor INTO @OrderID, @VoucherID;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ProductID = 
		(
			SELECT po.ProductID
			FROM ProductOrder po
			WHERE po.OrderID = @OrderID
		)

		SET @VoucherProductID = 
		(
			SELECT vp.ProductID
			FROM VoucherProducts vp
			WHERE vp.VoucherID = @VoucherID
		)

		IF @ProductID != @VoucherProductID
		BEGIN
			PRINT N'VOUCHER NÀY KHÔNG HỢP LỆ'
			ROLLBACK
		END
	END
END
GO

CREATE TRIGGER SetProductAmounts
ON ProductOrder
AFTER INSERT
AS
BEGIN
	DECLARE @TotalAmount INT
	DECLARE @ProductID VARCHAR(20)
	DECLARE @OrderID VARCHAR(20)
	DECLARE @Quantity INT
	DECLARE @VATRate DECIMAL(20,2)
	DECLARE @TotalPrice INT


	DECLARE ins_cursor CURSOR FOR
	SELECT ins.ProductID, ins.Quantity, ins.OrderID
	FROM inserted ins

	OPEN ins_cursor
	FETCH NEXT FROM ins_cursor INTO @ProductID, @Quantity, @OrderID

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SET @TotalAmount =
		(
			SELECT p.Price
			FROM Product p
			WHERE @ProductID = p.ProductID
		) * @Quantity

		SET @VATRate = (
			SELECT RateValue
			FROM Rate r
			WHERE r.RateID LIKE '%TAX001%'
		) 

		UPDATE ProductOrder
		SET Amount = @TotalAmount, VATAmount = @VATRate * @TotalAmount
		WHERE ProductID = @ProductID AND OrderID = @OrderID

		SET @TotalPrice = 
		(
			SELECT SUM(po.Amount)
			FROM ProductOrder po 
			WHERE po.OrderID = @OrderID
		)

		UPDATE Order_
		SET TotalPrice = @TotalPrice
		WHERE OrderID = @OrderID

		FETCH NEXT FROM ins_cursor INTO @ProductID, @Quantity, @OrderID
	END
	CLOSE ins_cursor
	DEALLOCATE ins_cursor
END
GO