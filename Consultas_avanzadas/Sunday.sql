companyname, (unitprice * quantity)



create or alter proc sp_ventas_productor1
@year int, @month int, @day int
as
select s.CompanyName, sum(od.UnitPrice*od.Quantity) as total,
count(o.OrderDate) as 'Total_Env',

from
Suppliers as s
inner join 
Products as p
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
where datepart (year,o.OrderDate) = @year
and datepart(MONTH,o.OrderDate) = @month
and datepart(day,o.OrderDate) =@day
group by s.CompanyName
order by s.CompanyName



execute sp_ventas_productor 1996,07,04
exec sp_ventas_productor1 1996,07,04

exec sp_ventas_productorssss @day=07,@year=1996, @month = 'Febrari'

select count(*) from Orders


CREATE OR ALTER PROCEDURE sp_ventas_productor2
    @year INT, 
    @month INT, 
    @day INT,
    @country NVARCHAR(50)
AS
BEGIN
    SELECT 
        s.CompanyName, 
        SUM(od.UnitPrice * od.Quantity) AS total,
        COUNT(o.OrderID) AS Total_Env
    FROM
        Suppliers AS s
    INNER JOIN 
        Products AS p ON s.SupplierID = p.SupplierID
    INNER JOIN 
        [Order Details] AS od ON p.ProductID = od.ProductID
    INNER JOIN 
        Orders AS o ON o.OrderID = od.OrderID
    INNER JOIN
        Customers AS c ON o.CustomerID = c.CustomerID
    WHERE 
        DATEPART(YEAR, o.OrderDate) = @year
        AND DATEPART(MONTH, o.OrderDate) = @month
        AND DATEPART(DAY, o.OrderDate) = @day
        AND c.Country = @country
    GROUP BY 
        s.CompanyName
    ORDER BY 
        s.CompanyName;
END;

exec sp_ventas_productor2 @day=07,@year=1996, @month = 07, @country='Germany'
