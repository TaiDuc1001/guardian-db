USE QL_Guardian
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

CREATE TRIGGER TriggerOrder
ON Order_
AFTER INSERT, UPDATE
AS 
BEGIN
    UPDATE User
    SET Point = ROUND(Point + ins.TotalPrice/10000, -1)
    FROM User u
    INNER JOIN inserted ins ON u.UserID = ins.UserID

    DELETE Cart
    FROM Cart c
    INNER JOIN inserted ins ON c.UserID = ins.UserID
END
GO

CREATE TRIGGER ProductOrderTrigger
ON ProductOrder
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @VATRate DECIMAL(20,2)
	SET @VATRate = 
		(
			SELECT RateValue
			FROM Rate r
			WHERE r.RateID LIKE '%TAX001%'
		) 

	UPDATE po
	SET po.Amount = ins.Quantity * p.Price, po.VATAmount = po.Amount * @VATRate
	FROM ProductOrder po
	INNER JOIN inserted ins ON po.ProductID = ins.ProductID AND po.OrderID = ins.OrderID
	INNER JOIN Product p ON ins.ProductID = p.ProductID

	UPDATE o
	SET o.TotalPrice = (
            SELECT SUM(po.Amount)
            FROM ProductOrder po
            WHERE po.OrderID = o.OrderID AND po.OrderID != 'P000'
        ),
		o.FinalAmount = o.TotalPrice + (SELECT po.Amount
            FROM ProductOrder po
            WHERE po.OrderID = o.OrderID AND po.OrderID = 'P000')

	FROM Order_ o
	INNER JOIN
		inserted ins ON o.OrderID = ins.OrderID

	UPDATE pro
		SET pro.SoldCount = pro.SoldCount + ins.Quantity
		FROM Product pro
		INNER JOIN inserted ins on ins.ProductID = pro.ProductID

END
GO