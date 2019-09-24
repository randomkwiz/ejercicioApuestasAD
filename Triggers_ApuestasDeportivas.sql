

/* Ejercicio Apuestas Deportivas */

/*Trigger para comprobar si se puede hacer la apuesta. 
	Si el período para apostar está cerrado, no permitirá hacer la apuesta*/

	USE ApuestasDeportivas
GO
insert into Usuarios(correo,contraseña,saldoActual)
values('nzhdeh@gmail.com','1234',50)
go
insert into Competiciones(id,nombre,año)
values(1,'La champion',2018)
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion)
values(NEWID(),0,0,1,50,100,150,'2018-05-10 00:00:00',1)
go
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion)
values(NEWID(),0,0,0,50,100,150,'2018-05-12 00:00:00',1)
go
--drop trigger comprobarSiPeriodoApuestasEstaAbierto
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
		on I.IDPARTIDO = P.id
		WHERE P.isAbierto = 0	--si existen inserciones que estén relacionadas con partidos con el cupo abierto
		)
	BEGIN
		RAISERROR('EL PERIODO DE APUESTAS ESTA CERRADO',16,1)
		ROLLBACK
	END
END
go
begin tran
insert into APUESTAS(ID,CUOTA,FECHAHORAAPUESTA,DINEROAPOSTADO,CORREOUSUARIO,IDPARTIDO,TIPO)--funciona
values(NEWID(),3.5,'2018-05-10 00:00:00',5,'nzhdeh@gmail.com','82274901-D2D2-4508-8AF8-2E6736BA6A40',1)
rollback
go
begin tran
insert into APUESTAS(ID,CUOTA,FECHAHORAAPUESTA,DINEROAPOSTADO,CORREOUSUARIO,IDPARTIDO,TIPO)--debe fallar
values(NEWID(),3.5,'2018-05-10 00:00:00',5,'nzhdeh@gmail.com','05D6A2C4-68FE-4FC2-BB17-309B3BF44529',1)
rollback
select * from Partidos

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
--ALTER
CREATE
TRIGGER noApuestesLoQueNoTienes
ON APUESTAS
AFTER INSERT, UPDATE AS
BEGIN
	IF EXISTS
		(SELECT id
		FROM inserted as I
		inner join Usuarios as U
		on I.correoUsuario = U.correo
		WHERE saldoActual < I.DINEROAPOSTADO
		)
	BEGIN
		RAISERROR('No puedes apostar más de lo que tienes',16,1)
		ROLLBACK
	END
END
go
begin tran
insert into APUESTAS(ID,CUOTA,FECHAHORAAPUESTA,DINEROAPOSTADO,CORREOUSUARIO,IDPARTIDO,TIPO)--debe fallar
values(NEWID(),3.5,'2018-05-10 00:00:00',55,'nzhdeh@gmail.com','82274901-D2D2-4508-8AF8-2E6736BA6A40',1)
rollback
go
begin tran
insert into APUESTAS(ID,CUOTA,FECHAHORAAPUESTA,DINEROAPOSTADO,CORREOUSUARIO,IDPARTIDO,TIPO)--funciona
values(NEWID(),3.5,'2018-05-10 00:00:00',50,'nzhdeh@gmail.com','82274901-D2D2-4508-8AF8-2E6736BA6A40',1)
rollback

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
	USE ApuestasDeportivas
	GO
ALTER
--CREATE 
FUNCTION 
cuantoDineroHayApostadoAUnPartido (@IDPartido UNIQUEIDENTIFIER, @tipoApuesta int)
	RETURNS INT AS
	BEGIN 

	DECLARE @RESULTADO INT
	SET @RESULTADO = 
		(SELECT SUM(A.CUOTA * A.DINEROAPOSTADO)
		FROM Partidos AS P
		INNER JOIN APUESTAS AS A
		ON P.id = A.IDPARTIDO
		WHERE @IDPARTIDO = P.ID
		AND @TIPOAPUESTA = A.TIPO)

	RETURN (SELECT @RESULTADO)
	END
	
go


--Trigger que, sabiendo cuántas apuestas hay ya para un partido, no deje añadir más si se ha llegado al maximo.

/*SOLO VALE SI HACES LAS INSERCIONES DE UNA EN UNA*/
GO
BEGIN TRAN
GO
ALTER
--CREATE
TRIGGER comprobarSiSeHaAlcanzadoElMaximo
ON APUESTAS
AFTER INSERT AS
BEGIN

	DECLARE @IDPARTIDO UNIQUEIDENTIFIER 
	SET @IDPARTIDO = (SELECT IDPARTIDO
					FROM inserted)

	DECLARE @TIPO TINYINT 
	SET @TIPO = (SELECT TIPO FROM inserted)

	DECLARE @MAXIMO INT

	IF (@TIPO = 1)
	BEGIN
	SET @MAXIMO = (SELECT P.maxApuesta1
					FROM inserted AS I
					INNER JOIN Partidos AS P
					ON I.IDPARTIDO = P.id
					)
	END
	
	IF (@TIPO = 2)
	BEGIN
	SET @MAXIMO = (SELECT P.maxApuesta2
					FROM inserted AS I
					INNER JOIN Partidos AS P
					ON I.IDPARTIDO = P.id
					)
	END

	IF (@TIPO = 3)
	BEGIN
	SET @MAXIMO = (SELECT P.maxApuesta3
					FROM inserted AS I
					INNER JOIN Partidos AS P
					ON I.IDPARTIDO = P.id
					)
	END

	if (dbo.cuantoDineroHayApostadoAUnPartido(@IDPARTIDO, @TIPO) > @MAXIMO )
	BEGIN
	RAISERROR('EL MAXIMO DE DINERO DE LAS APUESTAS YA SE HA LLENADO',16,1)
	ROLLBACK
	END
END

