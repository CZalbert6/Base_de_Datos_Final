use Northwind

CREATE TABLE HistoricoDePrecios(
ID_historico int NOT NULL identity(1,1), 
ID_Product int,
PrecioAnterior money,
PrecioActual money,
FechaModificacion date
Constraint pk_historico
Primary Key (ID_historico),
Constraint fk_product_historico
Foreign key (ID_Product)
References Products(ProductID)
);


create or alter proc Problema_1
@ProductID
AS
begin
	begin transaction;
	begin try
		merge into HistoricoDePrecios as hdp
		using(
		select ProductID,UnitPrice,ProductName 
		FROM Products 
		) as ps
		ON hdp.ID_Product = ps.ProductID

		--Eliminar un producto
		WHEN MATCHED THEN
		DELETE Products 
		when ProductID = @ProductID

	commit transaction;
	end try
	begin catch
	rollback transaction
	declare @mensajeError nvarchar(max)
	set @mensajeError = ERROR_MESSAGE()
	print @mensajeError
	end catch
end;



select * from Products