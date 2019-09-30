
USE ApuestasDeportivas
GO
--drop database ApuestasDeportivas

--select * from Partidos

--select * from APUESTAS
--where IDPARTIDO = 'BA63955A-E6D6-440D-8994-2EC60A089BD9'

--select * from ApuestaTipo1

use ApuestasDeportivas
/*trigger para restar automáticamente el coste de la apuesta del saldo del usuario*/
ALTER
--CREATE 
TRIGGER restarDineroApuestaInmediatamente
ON APUESTAS
AFTER INSERT AS 
BEGIN
	/*HAY QUE HACER DOS COSAS: MODIFICAR EL SALDO ACTUAL DEL USUARIO Y REGISTRAR EL MOVIMIENTO EN CUENTAS*/
	UPDATE Usuarios
	SET saldoActual = saldoActual - (SELECT DINEROAPOSTADO FROM inserted )
	WHERE correo = (SELECT CORREOUSUARIO FROM inserted)


	/*Nota: como voy a hacer un trigger que tras cada actualización de Usuarios, graba el movimiento del saldo en 
	Cuentas, esta parte aquí sobraría*/
	--INSERT INTO Cuentas ( saldo, fechaYHora, correoUsuario)
	--values( (SELECT saldoActual 
	--							FROM Usuarios as u
	--							inner join inserted as i
	--							on u.correo = i.CORREOUSUARIO  ), CURRENT_TIMESTAMP,(SELECT CORREOUSUARIO 
	
	--							FROM Usuarios as u
	--							inner join inserted as i
	--							on u.correo = i.CORREOUSUARIO  )  )
END
select * from APUESTAS

select * from ApuestaTipo1

select * from Usuarios
select * from Cuentas
where correoUsuario = 'lolo@gmail.com'


insert into Usuarios (correo, contraseña, saldoActual)
values('lolo@gmail.com', '123', 100)

insert into Usuarios (correo, contraseña, saldoActual)
values('angelavazquez@gmail.com', '123', 100)

insert into Usuarios (correo, contraseña, saldoActual)
values('pepe@gmail.com', '123', 100)

insert into APUESTAS(ID, CUOTA, FECHAHORAAPUESTA, DINEROAPOSTADO, CORREOUSUARIO, IDPARTIDO, TIPO)
values(NEWID(), 1, CURRENT_TIMESTAMP, 15, 'lolo@gmail.com', '7DDD9447-9C2B-4762-A482-4D5BC3F7CD73', 1)

insert into Partidos(id, resultadoLocal, resultadoVisitante, isAbierto, maxApuesta1, maxApuesta2, maxApuesta3, idCompeticion)
values(NEWID(), 5,3,1,5000,2500,1600,'F93DB868-F41F-42D4-8C80-78D0DB24846A')

insert into Competiciones(id, nombre, año)
values(NEWID(), 'Copa', 2010)

select * from Competiciones

select * from Partidos



/*PROCEDIMIENTOS */

--Funcion al que pasaremos el id de una apuesta y el correo de un usuario y nos devolvera el tipo de esa apuesta

create function FN_TipoApuesta(@IDApuesta uniqueidentifier)
returns tinyint as
begin
	declare @Tipo as tinyint

	set @Tipo=(select Tipo from Apuestas
				where @IDApuesta=ID)

	return @Tipo
end
go
declare @ret tinyint
set @ret = dbo.FN_TipoApuesta('71207D26-3402-4845-B69B-75560A8F8917','nzhdeh@gmail.com')
print @ret

/*HAY QUE ACTUALIZAR EL SALDO DE LAS CUENTAS DE LOS USUARIOS Y LOS MOVIMIENTOS DE SUS CUENTAS en caso
de que ganen una apuesta*/


ALTER
--CREATE
PROCEDURE actualizarSaldosEntidadUsuarios (@IDPARTIDO UNIQUEIDENTIFIER)
AS
BEGIN
	

END


/*Despues se hace un trigger para que cada vez que se actualice la tabla usuario con el saldo, ese movimiento quede grabado en la entidad
cuenta*/

ALTER
--CREATE 
--drop
TRIGGER grabarMovimientoEnCuenta
ON USUARIOS
AFTER UPDATE AS 
BEGIN
	
	/*comprobamos si la columna del saldo ha sido modificada*/

	if exists (select saldoActual from inserted)
	begin
	INSERT INTO Cuentas ( saldo, fechaYHora, correoUsuario)
	values( (SELECT u.saldoActual 
								FROM Usuarios as u
								inner join inserted as i
								on u.correo = i.correo  ), CURRENT_TIMESTAMP,
								(SELECT i.correo
								FROM Usuarios as c
								inner join inserted as i
								on c.correo = i.correo  )  )
	end

	
END

/*crear un trigger para que en cuanto insertes un usuario
se registre en la cuenta su saldo de partida*/
ALTER
--CREATE 
--drop
TRIGGER grabarMovimientoEnCuenta
ON USUARIOS
AFTER insert AS 
BEGIN
	
	/*comprobamos si la columna del saldo ha sido modificada*/

	if exists (select saldoActual from inserted)
	begin
	INSERT INTO Cuentas ( saldo, fechaYHora, correoUsuario)
	values( (SELECT u.saldoActual 
								FROM Usuarios as u
								inner join inserted as i
								on u.correo = i.correo  ), CURRENT_TIMESTAMP,
								(SELECT i.correo
								FROM Usuarios as c
								inner join inserted as i
								on c.correo = i.correo  )  )
	end

	
END
