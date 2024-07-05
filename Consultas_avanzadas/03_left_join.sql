
--Crear base de datos para demostrar el uso del left join

create DATABASE pruebajoins;

--Ahora utilisamos la base de datos

use pruebajoins;

--crea la tabla categorias

create table categoria(
    categoriaid int not null identity (1 , 1),
    nombre varchar(50) not null DEFAULT 'No Categoria',
    constraint pk_categoria
    PRIMARY key (categoriaid)
);

--crea tabla de producto

create table producto(
    productoid int not null identity(1,1),
    nombre varchar(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    constraint pk_producto
    PRIMARY key (productoid),
    constraint unico_nombre
    UNIQUE(nombre),
    constraint fk_producto_categoria
    FOREIGN key (categoriaid)
    REFERENCES categoria(categoriaid)
);

--Agregar registros a la tabla categoria
DBCC CHECKident (categoria, RESEED, 1)
INSERT INTO categoria(nombre)
VALUEs ('LB'),
  ('LACTEOS'),
  ('ROPA'),
  ('BEBIDAS'),
  ('CARNES FRIA');

 --Agregar registros a la tabla productos 

DELETE FROM categoria
 SELECT*from categoria;
 SELECT*from producto

 INSERT INTO producto(nombre,existencia,precio,categoriaid)
 VALUES('REFRIGERADOR', 3, 10000.0,10),
       ('ESTUFA', 3, 9000.04,10),
       ('CREMA', 2, 10.05, 11),
       ('YOGURT', 3, 13.45, 11);


SELECT *
from producto as p 
left JOIN categoria as c 
on p.categoriaid = c.categoriaid

--Consulta utilizando un left joind

SELECT *
from categoria as c 
left JOIN producto as p
on p.categoriaid = c.categoriaid

--seleciona todas las categorias que no tienen asignado productos

SELECT c.categoriaid, c.nombre
from categoria as c 
left JOIN producto as p
on p.categoriaid = c.categoriaid
where p.productoid is null;


SELECT *
from producto as p
right JOIN categoria as c
on p.categoriaid = c.categoriaid;


SELECT *
from producto as p
LEFT JOIN categoria as c
on p.categoriaid = c.categoriaid;

SELECT *
from producto as p
full JOIN categoria as c
on p.categoriaid = c.categoriaid;

--ejercicio 
-- 1.crear una base de datos llamada ejerciciojoind
CREATE DATABASE ejerciciojoinds;
use ejecicojoinds;
--2.-crear unna tabla llamada empleados tomando como base la tabla employees de nortwhind (no tomar todos los datos)
select * from northwind .dbo.employees;

select top 0 employeeid as 'empleadoid',
       CONCAT(firstname,' ',lastname) as 'nombrecompleto',
       title as 'titulo',
       hiredate as 'fechacontratacion'
into ejerciciojoinds.dbo.empleados
from northwind.dbo.employees;

-- 3.llenar la tabla con una consulta a la tabla Employees
insert into ejerciciojoinds.dbo.empleados(nombreCompleto,titulo,fechacontratacion)
select
     CONCAT(firstname,' ',lastname) as 'NombreCompleto',
     title as 'titulo',
     hiredate as 'Fechacontratacion'
from Northwind.dbo.employees

select top 0 *
into ejerciciojoinds.dbo.dimempleados
from ejerciciojoinds.dbo.empleados

select * from dimempleados
select*from empleados
-- 4. agregar nuevos datos a la tabla empledo por lo menos 2

-- 5. actualizar la tabla empleados con los nuevos registros la cual se lleneara en una nueva tabla int producto
--dim_producto