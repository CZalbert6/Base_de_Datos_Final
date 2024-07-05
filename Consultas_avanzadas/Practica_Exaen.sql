/*Examen 
Crear un tigger que permita gestionar una venta en la cual se debe analizar la existencia del producto
vendido, bajo las siguienetes condiciones 
1) Verificar si la existencia es suficiente, si la existencia no es suficiente 
cancelar la insercion
2) si es suficiente agregar la venta y disminuir el stock del producto
3) Utilizar la base de datos Norwhintn

1._ Insertar em Orders
2.-Insertar en OrdenDatils
3.-Verificar si el unitStock es suficiente
4.-Si es suficiente aceptar la inserccion y disminuir el unitStock lo vendido

*/

use Northwind

create or alter trigger Gestion_ventas
on [Order details]
after insert,update
as
begin
