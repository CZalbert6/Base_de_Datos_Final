-- Las transacciones son fundamentales para asegurar la consistencia 
--Y la integridad de los datos

--Transaccion: Es unna unidad de trabajo que se ejecuta de manera 
--Complementamente exitosa o no se ejecuta en absoluta

-- Begin transaction: Inicia una nueva transaccion
--commit tranasccion: Confira todos los cambios realizados
--rollback transaction: Revierte todos los cambios realizados
--durante la transaccion 

use Northwind

select * from Categories

begin transaction

insert into Categories (CategoryName, Description)
values ('Categoria11', 'Los Remediales')

rollback transaction

commit transaction
