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
	ON Partidos 
	after update
	/*Hay que hacerlo sobre Partidos, porque Apuestas no se puede actualizar y al crearla no se sabe si ha ganado o no*/
	AS 
	begin
	if exists  (select resultadoLocal from inserted)  
	begin
			if exists (select resultadoVisitante from inserted)
			begin
			IF  ((
				select isGanador 
				from Apuestas as I
				inner join Usuarios as U
				on I.CorreoUsuario = U.correo
				inner join inserted as x
				on x.id = i.IDPartido
				where I.CorreoUsuario = U.correo
				and x.ID = I.IDPartido
				) = 1)

				BEGIN

				--variable tipo tabla que recoge cuota, dinero apostado y usuario de las apuestas ganadoras
				DECLARE @cuota TABLE (usuario char(30),cuota tinyint, dineroApostado smallmoney );
				INSERT INTO @cuota
				SELECT A.CorreoUsuario, SUM(A.cuota * A.dineroApostado) AS CANTIDAD_A_ANADIR
				from inserted as I
				inner join Apuestas as A
				on I.id = A.IDPartido 
				where I.id = A.IDPartido AND A.IsGanador = 1
				GROUP BY A.CorreoUsuario


				/*nota: puedo hacer una consulta que agrupe los datos de la tabla @cuota 
				por usuario y sume todas las cantidades a añadir
				y quede algo asi:
				Usuario		CantidadAAñadir
				pepe		156 euros

				y asi hago el update mas facilmente

				*/
				
				
				--revisar esto
				--ahora hay que actualizar el saldo de los usuarios
				UPDATE usuarios 
					set saldoActual = saldoActual + (Select CANTIDAD_A_ANADIR
													from @cuota ) 
					where Usuarios.correo = (select usuario from @cuota)
	END



			end
	end
	end
go
	---------------

	/*Procedimiento que recibe correo del usuario y una nueva cantidad para que el usuario pueda añadir más dinero*/
	ALTER
	--CREATE 
	PROCEDURE anadirMasDinero (@correoUsuario char(30), @cantidadNueva int)
	AS
	BEGIN
		UPDATE usuarios 
		SET saldoActual = saldoActual + @cantidadNueva 
		WHERE correo = @correoUsuario
	END

	exec dbo.anadirMasDinero @correoUsuario = 'angelavazquez@gmail.com', @cantidadNueva = 50

	select * from Usuarios
	select * from Cuentas


	go

	---------------------
	/*Procedimiento para sacar dinero*/

		ALTER
	--CREATE 
	PROCEDURE sacarDinero (@correoUsuario char(30), @cantidadASacar int)
	AS
	BEGIN
		UPDATE usuarios 
		SET saldoActual = saldoActual - @cantidadASacar
		WHERE correo = @correoUsuario
	END