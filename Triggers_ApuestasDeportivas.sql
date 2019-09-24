

/* Ejercicio Apuestas Deportivas */

/*Trigger para comprobar si se puede hacer la apuesta. 
	Si el período para apostar está cerrado, no permitirá hacer la apuesta*/

	USE ApuestasDeportivas
GO
BEGIN TRAN
GO
ALTER
--CREATE
TRIGGER comprobarSiPeriodoApuestasEstaAbierto 
ON APUESTAS
AFTER INSERT, UPDATE AS
BEGIN
	IF EXISTS
		(SELECT I.id
		FROM inserted as I
		inner join Partidos as P
		on I.idPartido = P.id
		WHERE P.isAbierto = 1	--si existen inserciones que estén relacionadas con partidos con el cupo cerrado
		)
	BEGIN
		RAISERROR('EL PERIODO DE APUESTAS ESTA CERRADO',16,1)
		ROLLBACK
	END

END

go

/*De momento he hecho solo el de apuestas tipo 1 porque como son los tres iguales, primero quiero que comprobemos que
ese está bien. Si lo está, ya copipasteamos los demás, que sería simplemente cambiar la tabla sobre la que 
operaría el trigger */


----------------------------

/*Funcion escalar para consultar lo que gana un usuario con una apuesta en caso de que acierte
Se calcula tal que así:
	ganancia = cantidadApostada x cuota
*/
go
ALTER
--CREATE 
FUNCTION 
GananciaDeUnUsuarioConUnaApuesta (@cuota int, @cantidadApostada int)
	RETURNS INT AS
	BEGIN 
	RETURN (@CUOTA * @CANTIDADAPOSTADA)
	END
	
go

SELECT dbo.GananciaDeUnUsuarioConUnaApuesta(4,3) as prueba


------------------------------
/*Trigger para controlar el saldo negativo. Que no puedas apostar más de lo que tienes.*/
GO
BEGIN TRAN
GO
ALTER
--CREATE
TRIGGER noApuestesLoQueNoTienesTipo1
ON APUESTATIPO1
AFTER INSERT, UPDATE AS
BEGIN
	IF EXISTS
		(SELECT id
		FROM inserted as I
		inner join Usuarios as U
		on I.correoUsuario = U.correo
		WHERE saldoActual < I.dinero
		)
	BEGIN
		RAISERROR('No puedes apostar más de lo que tienes',16,1)
		ROLLBACK
	END

END

go

/*De momento he hecho solo el de apuestas tipo 1 porque como son los tres iguales, 
primero quiero que comprobemos que ese está bien. 
Si lo está, ya copipasteamos los demás, que sería simplemente cambiar la tabla sobre la que 
operaría el trigger */

-----------------
/*Controlar que una apuesta no pueda cambiarse ni borrarse*/
GO
BEGIN TRAN
GO
ALTER
--CREATE
TRIGGER noSeAceptanModificaciones
ON APUESTATIPO1
AFTER UPDATE, DELETE AS
BEGIN
	if exists (
	select I.id
	from inserted as I
	inner join ApuestaTipo1 as A
	on A.id = I.id
	)
	BEGIN
	RAISERROR('No se pueden modificar ni eliminar apuestas',16,1)
	ROLLBACK
	END
END


------------------------
/*Controlar el maximo de apuestas */
	--Funcion para saber cuanto dinero en apuestas de un tipo hay ya para un partido, que sume las cantidades
	--Trigger que, sabiendo cuántas apuestas hay ya para un partido, no deje añadir más si se ha llegado al maximo.

	/*Funcion a la que le pases el ID del partido y el tipo de apuesta, y te devuelva la suma de las cantidades apostadas (cuota*dineroApostado)
	para ese partido
	*/

	go
ALTER
--CREATE 
FUNCTION 
cuantoDineroHayApostadoAUnPartido (@IDPartido int, @tipoApuesta int)
	RETURNS INT AS
	BEGIN 
	DECLARE @RESULTADO INT
	SELECT @RESULTADO = 
		SUM(A.CUOTA * A.DINEROAPOSTADO) AS CANTIDAD_A_PAGAR
		FROM Partidos AS P
		INNER JOIN APUESTAS AS A
		ON P.id = A.IDPARTIDO
		WHERE @IDPARTIDO = P.ID
		AND @TIPOAPUESTA = A.TIPO
	RETURN @RESULTADO
	END
	
go





