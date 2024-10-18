USE QL_Guardian

CREATE TRIGGER UpdateProductInventory
ON [dbo].[ProductOrder]
AFTER INSERT
AS
BEGIN
	UPDATE [dbo].[Product]
	SET [StockQuantity]	= [StockQuantity] - (SELECT [Quantity] FROM inserted WHERE[dbo].[Product].ProductID = inserted.ProductID)
	WHERE [dbo].[Product].ProductID IN (SELECT[ProductID] FROM inserted)
		
END
