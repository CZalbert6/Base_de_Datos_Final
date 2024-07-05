select GETDATE()

--Funcion que devulve alguna parte de una fecha

select datepart(year, OrderDate) as 'año',
DATEPART(MONTH,  OrderDate) as 'mes',
DATEPART(quarter, OrderDate) as 'trimestre',
DATEPART(week,   OrderDate) as 'semana',
datepart(day,OrderDate) as 'Dia',
DATEPART(weekday,  OrderDate) as 'Dia de la semana',
datepart(yy,  OrderDate) as 'Año 2'
FROM orders;

--Funcion que regresa el nombre de un mes o dia etc
SELECT datename(month, getdate()) as mes

set language spanish

SELECT datename(month, getdate()) as mes

SELECT datename(month, getdate()) as mes, DATENAME(WEEKDAY, getdate()) as dia

set LANGUAGE english


-- select OrderDate(year, OrderDate) as 'año',
-- Datename(MONTH,  OrderDate) as 'mes',
-- Datename(quarter, OrderDate) as 'trimestre',
-- Datename(week,   OrderDate) as 'semana',
-- Datename(day,OrderDate) as 'Dia',
-- Datename(weekday,  OrderDate) as 'Dia de la semana',
-- Datename(yy,  OrderDate) as 'Año 2'
-- FROM Orders

-- funcion para obtener la diferencia entre, mes, dias

SELECT DATEDIFF(year, '2004-07-13', GETDATE()) as 'Tiempo de viejez'

SELECT*from Orders

--selecionar el numero de dias transcuridos entre la fecha de pedido y la fecha de entrega
SELECt OrderID, DATEDIFF(day, OrderDate, ShippedDate) as 'Dias transcurridos' from Orders 

--

select*from Categories as c 
LEFT JOIN Products as p 
on c.CategoryID = p.CategoryID