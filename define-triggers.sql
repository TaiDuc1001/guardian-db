﻿

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
    UPDATE bwp
    SET bwp.StockQuantity = bwp.StockQuantity - ins.Quantity
    FROM BranchW_Product bwp
    INNER JOIN inserted ins ON bwp.ProductID = ins.ProductID
    INNER JOIN Order_ o ON ins.OrderID = o.OrderID
    INNER JOIN BranchWarehouse bw ON o.DeliveryAddressID = bw.AddressID AND bwp.BranchWID = bw.BranchWID
    WHERE bwp.StockQuantity >= ins.Quantity

    IF EXISTS (
        SELECT 1
        FROM BranchW_Product bwp
        INNER JOIN inserted ins ON bwp.ProductID = ins.ProductID
        INNER JOIN Order_ o ON ins.OrderID = o.OrderID
        INNER JOIN BranchWarehouse bw ON o.DeliveryAddressID = bw.AddressID AND bwp.BranchWID = bw.BranchWID
        WHERE bwp.StockQuantity < ins.Quantity
    )
    BEGIN
        DECLARE @OutOfStockProducts TABLE (ProductID VARCHAR(20))

        INSERT INTO @OutOfStockProducts (ProductID)
        SELECT bwp.ProductID
        FROM BranchW_Product bwp
        INNER JOIN inserted ins ON bwp.ProductID = ins.ProductID
        INNER JOIN Order_ o ON ins.OrderID = o.OrderID
        INNER JOIN BranchWarehouse bw ON o.DeliveryAddressID = bw.AddressID AND bwp.BranchWID = bw.BranchWID
        WHERE bwp.StockQuantity < ins.Quantity

        UPDATE bwp
        SET bwp.StockQuantity = 0
        FROM BranchW_Product bwp
        INNER JOIN @OutOfStockProducts oos ON bwp.ProductID = oos.ProductID

        DECLARE @ErrorMessage VARCHAR(MAX) = 'Sản phẩm không đủ so với số lượng tồn kho: '
        SELECT @ErrorMessage += oos.ProductID + ', '
        FROM @OutOfStockProducts oos

        RAISERROR (@ErrorMessage, 16, 1)
        ROLLBACK
    END
END
GO

CREATE TRIGGER HandleVoucherMismatch
ON Order_
AFTER INSERT
AS
BEGIN
	IF EXISTS
	(
		SELECT 1
		FROM inserted ins
		JOIN ProductOrder po ON po.OrderID = ins.OrderID
		JOIN VoucherProducts vps ON vps.VoucherID = ins.VoucherID
		WHERE po.ProductID != vps.ProductID
	)

	BEGIN
		PRINT N'Voucher này không hợp lệ'
		ROLLBACK
	END
END
GO

CREATE TRIGGER OrderTrigger
ON Order_
AFTER INSERT, UPDATE
AS 
BEGIN
    UPDATE User_
    SET Point = ROUND(Point + ins.TotalPrice/10000, -1)
    FROM User_ u
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
        )
	FROM Order_ o
	INNER JOIN
		inserted ins ON o.OrderID = ins.OrderID

	UPDATE pro
		SET pro.SoldCount = pro.SoldCount + ins.Quantity
		FROM Product pro
		INNER JOIN inserted ins on ins.ProductID = pro.ProductID

	-- Include logic from CreateDeltaProduct trigger here
	UPDATE po
	SET 
		po.Quantity = 1,
		po.Amount = (r.RateValue * o.TotalPrice) - o.PointUsed * 12 - 
			CASE
				WHEN v.DiscountPrice IS NULL THEN v.DiscountPercentage * o.TotalPrice
				WHEN v.DiscountPrice > v.MaximumDiscountAmount THEN v.MaximumDiscountAmount
				ELSE v.DiscountPrice
			END,
		po.VATAmount = po.VATAmount
	FROM 
		ProductOrder po
	INNER JOIN 
		Order_ o ON po.OrderID = o.OrderID
	INNER JOIN 
		Voucher v ON o.VoucherID = v.VoucherID
	INNER JOIN 
		Rate r ON r.RateID = 'TAX001'
	WHERE 
		po.ProductID = 'P000'
		AND NOT EXISTS (SELECT 1 FROM inserted ins WHERE po.OrderID = ins.OrderID AND po.ProductID = 'P000');

	INSERT INTO ProductOrder (OrderID, ProductID, Quantity, Amount, VATAmount)
	SELECT
		o.OrderID,
		N'P000',
		1,
		(r.RateValue * o.TotalPrice) - 
			CASE
				WHEN v.DiscountPrice IS NULL THEN v.DiscountPercentage * o.TotalPrice
				WHEN v.DiscountPrice > v.MaximumDiscountAmount THEN v.MaximumDiscountAmount
				ELSE v.DiscountPrice
			END,
		0
	FROM
		Order_ o
	INNER JOIN
		Voucher v ON o.VoucherID = v.VoucherID
	INNER JOIN 
		Rate r ON r.RateID = 'TAX001'
	WHERE 
		o.OrderID IN (SELECT OrderID FROM inserted)
		AND NOT EXISTS (SELECT 1 FROM ProductOrder po WHERE po.OrderID = o.OrderID AND po.ProductID = 'P000')

	UPDATE o
	SET o.FinalAmount = o.TotalPrice + (SELECT po.Amount
            FROM ProductOrder po
            WHERE po.OrderID = o.OrderID AND po.ProductID = 'P000')
	FROM Order_ o
	INNER JOIN
		inserted ins ON o.OrderID = ins.OrderID

	UPDATE o
	SET o.FinalVATAmount = o.FinalAmount * @VATRate
	FROM Order_ o
	INNER JOIN
		inserted ins ON o.OrderID = ins.OrderID
END
GO
CREATE TRIGGER ReturnItemToStock
ON ShipperOrder
AFTER UPDATE
AS
BEGIN
	DECLARE @Quantity INT;
	DECLARE @DecresedPoint INT

	UPDATE BWP
	SET BWP.StockQuantity = BWP.StockQuantity + po.Quantity
	FROM BranchW_Product BWP
	JOIN ProductOrder po ON BWP.ProductID = po.ProductID
	JOIN inserted ins ON po.OrderID = ins.OrderID AND ins.StatusID = 'S005'
 
	
	UPDATE u
	SET u.Point =
	CASE 
	WHEN (u.Point - o.PointUsed) < 0 THEN 0
	ELSE (u.Point - o.PointUsed)
	END
	FROM User_ u 
	JOIN Order_ o ON o.UserID = u.UserID
	JOIN inserted ins ON ins.OrderID = o.OrderID AND ins.StatusID = 'S005'
	
END
go