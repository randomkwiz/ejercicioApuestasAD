

/* Ejercicio Apuestas Deportivas */

/*Trigger para comprobar si se puede hacer la apuesta. 
	Si el per�odo para apostar est� cerrado, no permitir� hacer la apuesta*/

	USE ApuestasDeportivas
GO
BEGIN TRAN
GO
ALTER
--CREATE
TRIGGER comprobarSiPeriodoApuestasTipo1EstaAbierto 
ON APUESTATIPO1
AFTER INSERT, UPDATE AS
BEGIN
	IF EXISTS
		(SELECT I.id
		FROM inserted as I
		inner join Partidos as P
		on I.idPartido = P.id
		WHERE P.isAbierto = 0	//si existen inserciones que est�n relacionadas con partidos con el cupo cerrado
		)
	BEGIN
		RAISERROR('EL PERIODO DE APUESTAS ESTA CERRADO',16,1)
		ROLLBACK
	END

END

go

/*De momento he hecho solo el de apuestas tipo 1 porque como son los tres iguales, primero quiero que comprobemos que
ese est� bien. Si lo est�, ya copipasteamos los dem�s, que ser�a simplemente cambiar la tabla sobre la que 
operar�a el trigger */


----------------------------

/*Funcion escalar para consultar lo que gana un usuario con una apuesta en caso de que acierte
Se calcula tal que as�:
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
/*Trigger para controlar el saldo negativo. Que no puedas apostar m�s de lo que tienes.*/
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
		RAISERROR('No puedes apostar m�s de lo que tienes',16,1)
		ROLLBACK
	END

END

go

/*De momento he hecho solo el de apuestas tipo 1 porque como son los tres iguales, 
primero quiero que comprobemos que ese est� bien. 
Si lo est�, ya copipasteamos los dem�s, que ser�a simplemente cambiar la tabla sobre la que 
operar�a el trigger */