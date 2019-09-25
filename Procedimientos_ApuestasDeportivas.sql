
USE ApuestasDeportivas
GO


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

	INSERT INTO Cuentas ( saldo, fechaYHora, correoUsuario)
	values( (SELECT saldoActual 
								FROM Usuarios as u
								inner join inserted as i
								on u.correo = i.CORREOUSUARIO  ), CURRENT_TIMESTAMP,(SELECT CORREOUSUARIO 
	
								FROM Usuarios as u
								inner join inserted as i
								on u.correo = i.CORREOUSUARIO  )  )
END
select * from APUESTAS

select * from ApuestaTipo1

select * from Usuarios
select * from Cuentas


insert into Usuarios (correo, contraseña, saldoActual)
values('angelavazquez@gmail.com', '123', 100)

insert into Usuarios (correo, contraseña, saldoActual)
values('pepe@gmail.com', '123', 100)

insert into APUESTAS(ID, CUOTA, FECHAHORAAPUESTA, DINEROAPOSTADO, CORREOUSUARIO, IDPARTIDO, TIPO)
values(NEWID(), 1, CURRENT_TIMESTAMP, 15, 'angelavazquez@gmail.com', '6841E438-A1AA-4564-976F-D732287FA250', 1)

insert into Partidos(id, resultadoLocal, resultadoVisitante, isAbierto, maxApuesta1, maxApuesta2, maxApuesta3, idCompeticion)
values(NEWID(), 5,3,1,5000,2500,1600,'4E6875BE-F77C-4226-9245-3FAB67F37400')

insert into Competiciones(id, nombre, año)
values(NEWID(), 'Copa', 2010)

select * from Competiciones

select * from Partidos



/*PROCEDIMIENTOS */

/*HAY QUE ACTUALIZAR EL SALDO DE LAS CUENTAS DE LOS USUARIOS Y LOS MOVIMIENTOS DE SUS CUENTAS*/

ALTER
--CREATE
PROCEDURE actualizarSaldosEntidadUsuarios (@IDPARTIDO UNIQUEIDENTIFIER)
AS
BEGIN
	

END


/*Despues se hace un trigger para que cada vez que se actualice la tabla usuario con el saldo, ese movimiento quede grabado en la entidad
cuenta*/