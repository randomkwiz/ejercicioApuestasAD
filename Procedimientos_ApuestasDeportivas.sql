
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
AFTER INSERT AS 

select * from APUESTAS

select * from ApuestaTipo1



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