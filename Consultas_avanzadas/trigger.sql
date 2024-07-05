/*create trigger Nombre_del_trigger on nombre_de_la_tabla after (insert,delete,update) 
as 
begin
-----codigo
end
*/

create trigger verificar_insert on tabla1 after insert,update,delete
as 
begin
print 'Se ejecuta el trigger en la tabla1'
end


/*
update tabla1
set nombre='NombreNuevo'
where id=1
*/

/*
Delete from tabala1
where id=1
*/


create database pruebatriggerg3
go
use pruebatriggerg3

create table tabla1
(
id int not null primary key,
nombre varchar(50) not null
);
go

--Trigger que verifica el evento que se ejecuta
create trigger tg_verifica_insercion on tabla1 after insert
as 
begin
print 'Se ejecuta el evento insert en la tabla1';
end;

insert into tabla1
values(1,'Nombre1')


create trigger tg_verifica_delete on tabla1 after delete
as 
begin
print 'Se ejecuta el evento delete en la tabla1';
end;


delete tabla1
where id=1

insert into tabla1
values(1,'Nombre1')

create trigger tg_verifica_update on tabla1 after update
as 
begin
print 'Se ejecuta el evento update en la tabla1';
end;

update tabla1
set nombre = 'Nombre Nuevo'
where id = 1;


--Para borrar
drop trigger tg_verifica_update
drop trigger tg_verifica_delete
drop trigger tg_verifica_insercion

create trigger verifico_contenido_inserted
on tabla1
after insert
as
begin
--verifica los datos de la tabla inserted
select * from inserted;
end

insert into tabla1
values(2,'Nombre2')

select * from tabla1

insert into tabla1
values(3,'Nombre3')

insert into tabla1
values(4,'Nombre4'),(5,'Nombre5')


use Northwind

create or alter trigger verificar_inserted_categories
on Categories
after insert
as
begin
select categoryid,categoryname,[description] from inserted
end

insert into categories (categoryname, description)
values ('CategoriaNueva','Pruba Triggers')

create or alter trigger verificar_update_categories
on Categories
after update
as
begin
select categoryid,categoryname,[description] from inserted;
select categoryid,categoryname,[description] from deleted;
end


begin transaction 

select * from categories
update categories
set categoryname = 'CategoriaOtra',
   [description] = 'Si esta bien'
   where categoryid = 9

   select * from categories

rollback

drop trigger verificar_update_categories
drop trigger verificar_inserted_categories

 
drop trigger verificar_insert_deleted

create or alter trigger verificar_insert_deleted
on categories
after insert,update,delete
as 
begin
if exists(select 1 from inserted) and not exists(select 1 from deleted)
begin
print ('Existen datos en la tabla inserted, se ejecuto un inserted')
end;
end;

if exists(select 1 from deleted ) and not exists (select 1 from inserted)
begin
print ('Existen datos en la tabla deleted. se realizo un deleted')
end
else if exists(select 1 from deleted) and exists (select 1 from inserted)
begin
 print 'Existen datos en las dos tablas, se realizo un update'
end

insert into categories(categoryname,[Description])
values('categoria10','Pinpon')

update categories
set categoryname = 'categoria',
[Description] = 'Si jala'
where categoryid = 9

--crear trigger en la base de ddatos pruebatriggers, para la tabala empleados


use pruebatriggerg3;

create table empleado(
id int not null primary key,
nombre varchar(50) not null,
salario money not null,
)

create or alter trigger verificar_salario
on empleado
after insert, update
as 
begin
if exists(select 1 from inserted) and not exists(select 1 from deleted)
begin
declare @salarioNuevo money
set @salarioNuevo = (select Salario from inserted)
if @salarioNuevo > 50000
begin
raiserror('El salario es mayor a  50000 y no esta permitido',16,1)
rollback transaction;
end;
end;
end;

