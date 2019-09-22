

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
		(SELECT id
		FROM ApuestaTipo1
		WHERE (SELECT ID
			FROM Partidos
			WHERE isAbierto = 1) = idPartido
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
