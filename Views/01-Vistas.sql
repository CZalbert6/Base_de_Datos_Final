create DATABASE vistaspractica

use vistaspractica

--craer una vista de la siguiente consulta

create or ALTER  VIEW VIEW_categoria_productos
as

select c.CategoryID as 'Nombre categoria',
p.ProductName as 'Nombre porducto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'existencia'
FROM
Northwind.dbo.Categories as c
INNER join Northwind.dbo.Products as p
on c.CategoryID = p.CategoryID

select *, (Precio*existencia) as [Precio inventario]
from VIEW_categoria_productos 
WHERE [Nombre categoria] in ('Beverages', 'Condiments')
order by [Nombre categoria] DESC

SELECt [Nombre categoria] as 'Categoria', sum(Precio * existencia) as 'Suma del precio del inventario'
 FROM VIEW_categoria_productos


