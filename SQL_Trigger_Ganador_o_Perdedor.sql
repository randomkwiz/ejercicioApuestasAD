use ApuestasDeportivas

/*Funcion escalar para consultar lo que gana un usuario con una apuesta en caso de que acierte
Se calcula tal que así:
	ganancia = cantidadApostada x cuota
*/

/*go
--ALTER
CREATE 
FUNCTION 
GananciaDeUnUsuarioConUnaApuesta (@cuota int, @cantidadApostada int)
	RETURNS INT AS
	BEGIN 
	RETURN (@CUOTA * @CANTIDADAPOSTADA)
	END
	
go

SELECT dbo.GananciaDeUnUsuarioConUnaApuesta(4,3) as prueba
*/
-----------------

/*Trigger  que comprueba si el usuario es ganador o perdedor y actualiza su saldo*/

CREATE TRIGGER TR_esGanador 
	ON usuarios --Porque modificará el valor del atributo isGanador en la tabla Apuestas
	FOR INSERT --entiendo que deberá hacer la comprobación antes del insert
	AS 
	IF  (select isGanador from Apuestas) = 1
	BEGIN
		UPDATE usuarios set saldoActual = 
		RAISERROR ('El usuario no ha ganado la apuesta', 16, 1)
	END


	---------------

	/*Procedimiento que recibe correo del usuario y una nueva cantidad para que el usuario pueda añadir más dinero*/

	CREATE PROCEDURE anadirMasDinero (@correoUsuario char, @cantidadNueva int)
	AS
	BEGIN
		UPDATE usuarios --No tengo claro si tengo que añadirlo en usuarios o en cuentas, o da igual
		SET saldoActual = @cantidadNueva 
		WHERE correo = @correoUsuario
	END


