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
go
ALTER
--CREATE 
TRIGGER TR_esGanador 
	ON Apuestas 
	after insert, update
	AS 
	begin
	IF  ((
	select isGanador 
	from inserted as I
	inner join Usuarios as U
	on I.CorreoUsuario = U.correo
	where I.CorreoUsuario = U.correo) = 1)
	BEGIN
		UPDATE usuarios 
		set saldoActual = (	SELECT dbo.GananciaDeUnUsuarioConUnaApuesta( (select cuota 
	from inserted as I
	inner join Usuarios as U
	on I.CorreoUsuario = U.correo
	where I.CorreoUsuario = U.correo)  ,(select dineroApostado 
	from inserted as I
	inner join Usuarios as U
	on I.CorreoUsuario = U.correo
	where I.CorreoUsuario = U.correo)) as prueba	)
	END

	end
go
	---------------

	/*Procedimiento que recibe correo del usuario y una nueva cantidad para que el usuario pueda añadir más dinero*/

	CREATE PROCEDURE anadirMasDinero (@correoUsuario char, @cantidadNueva int)
	AS
	BEGIN
		UPDATE usuarios --No tengo claro si tengo que añadirlo en usuarios o en cuentas, o da igual
		SET saldoActual = @cantidadNueva 
		WHERE correo = @correoUsuario
	END


