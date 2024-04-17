-- Curso Optimización SQL SERVER
-- Roy Rojas
-- twitter.com/royrojasdev | linkedin.com/in/royrojas
------------------------------------------------------
-- Clase 06 - Indices
------------------------------------------------------

USE WideWorldImporters

GO

SELECT TOP 10000 * 
  FROM Application.People p INNER JOIN 
       Sales.InvoiceLines i ON p.PersonID = i.LastEditedBy INNER JOIN 
       Warehouse.StockItemTransactions s ON p.PersonID = s.LastEditedBy
 ORDER BY i.StockItemID

 GO

-- Ejecute el siguiente comando para habilitar las estadísticas para el IO.
-- Activando las estadísticas nos va a mostrar el detalle de la carga de escritura y tamaño de paginación
SET STATISTICS IO ON

SELECT [OrderID],[ContactPersonID],
        [PickingCompletedWhen]
FROM [WideWorldImporters].[Sales].[Orders]
WHERE ContactPersonID = 3176;

-- Corregir el índice
FK_Sales_Orders_ContactPersonID agregar [PickingCompletedWhen]

-- Aqui podemos ver la respuesta de las estadísticas.
-- Table 'Orders'. Scan count 1, logical reads 416,
-- En el plan de ejecucion podemos ver el Key Lookup y las columnas que estan fuera del índice.
-- Corregir el índice

-------------------------

SET STATISTICS IO ON
SELECT [InvoiceID]     
      ,[ContactPersonID]
      ,[AccountsPersonID]
  FROM [WideWorldImporters].[Sales].[Invoices]
  WHERE [ContactPersonID] >= 3032 AND
        [ContactPersonID] <= 3035;

-- Corregir el índice
FK_Sales_Invoices_ContactPersonID agregar [AccountsPersonID]
