
declare @x INT
set @x=10

print 'El valor de x es: '+ cast(@x as VARCHAR)

if @x >=0
BEGIN
print 'El numero es positivo'
END
ELSE
BEGIN
PRINT 'El numero es negativo'
END

DECLARE @i as INT set @i=1
while (@i<=10)
BEGIN
print cast (@i as VARCHAR)
set @i=@i+1
end

--Crear un SP

create PROCEDURE Procedure_Ciclo
as

declare @x INT
set @x=10

print 'El valor de x es: '+ cast(@x as VARCHAR)

if @x >=0
BEGIN
print 'El numero es positivo'
END
ELSE
BEGIN
PRINT 'El numero es negativo'
END

DECLARE @i as INT set @i=1
while (@i<=10)
BEGIN
print cast (@i as VARCHAR)
set @i=@i+1
end