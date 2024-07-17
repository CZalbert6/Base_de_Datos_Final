--Store procedure que vizualise lso resultados de cualquier tabla
--y que pida solo el nombre de la tabla

create or alter proc SP_VER
@Tabla as varchar (50)
as 
begin
    declare @query nvarchar(50)
    set @query = ' select * from ' + QUOTENAME(@Tabla);

  exec sp_executesql @query;
















exec SP_VER 'Categories'