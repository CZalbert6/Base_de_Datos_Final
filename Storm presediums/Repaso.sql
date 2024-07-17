--Store procedure que vizualise lso resultados de cualquier tabla
--y que pida solo el nombre de la tabla

/*
create or alter proc SP_VER
@Tabla as varchar(50)
AS 
begin
    Declare @query nvarchar(50)
    set @query = 'select * from' + (@Tabla)

  exec sp_executesql @query
*/

CREATE OR ALTER PROCEDURE SP_VER
    @Tabla AS VARCHAR(50)
AS
BEGIN
    DECLARE @query NVARCHAR(MAX);  -- Aumentar la longitud de la variable para manejar consultas más largas

    -- Construir la consulta SQL dinámica
    SET @query = N'SELECT * FROM ' + QUOTENAME(@Tabla);

    -- Ejecutar la consulta SQL dinámica
    EXEC sp_executesql @query;
END



--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE


create database Nuevo
use Nuevo

CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

iNSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)

CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)



select * from 
StudentsC1 as c1
left join
StudentsC2 as c2
on c1.StudentID = c2.StudentID

--Crear un store procedure que inserte y actualice la talbla 
--student2 mediante los datos de student1 utilizando consultas left join
--e inner

create or alter procedure spu_incrementa
As
begin
 begin transaction;

 begin try

 -- se insertan estudiantes nuevos

	insert into StudentsC2 (StudentID,StudentName, StudentStatus)
	 select c1.StudentID,c1.StudentName, c1.StudentStatus
	from StudentsC1 as c1
	inner join
	StudentsC2 as c2
	on c1.StudentID = c2.StudentID

 -- Se actualizan los datos que hayan cambiado en Student 1
  update c2
  set c2.StudentName = c1.StudentName,
  c2.StudentStatus = c1.StudentStatus
  from
  StudentsC1 as c1
 left join
 StudentsC2 as c2
 on c1.StudentID = c2.StudentID

 commit transaction;

 end try
 begin catch
 Rollback Transaction
 declare @mensajeError nvarchar(max)
 set @mensajeError = ERROR_MESSAGE()
 print @mensajeError
 end catch
end;

exec spu_incrementa 

truncate table Studentsc1
truncate table Studentsc2

--Crear un store procedure que inserte y actualice con merch

create or alter procedure spu_incrementa_merch
As
begin
 begin transaction;

 begin try

 merge into Studentsc2 as tgt
 using (
  select c1.StudentID,c1.StudentName, c1.StudentStatus
	from StudentsC1 as c1
 ) AS src
 on(
  tgt.studentid = src.studentid
 )
 -- for update
 when matched then
 update
 set tgt.studentName = src.studentName,
     tgt.StudentStatus = src.StudentStatus;
	 --for inserts

	 when not matched  then
	 insert (studentid, studentname, studentstatus)
	 values (src.studentid, src.studentname,src.studentstatus)


 commit transaction;

 end try
 begin catch
 Rollback Transaction
 declare @mensajeError nvarchar(max)
 set @mensajeError = ERROR_MESSAGE()
 print @mensajeError
 end catch
end;

