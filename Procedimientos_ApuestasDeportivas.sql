
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

insert into Apuestas(ID, CUOTA, FECHAHORAAPUESTA, DINEROAPOSTADO, CORREOUSUARIO, IDPARTIDO, TIPO)
values(NEWID(), 1, CURRENT_TIMESTAMP, 15, 'lolo@gmail.com', '2B0981F4-EE1C-4EB0-861F-4EE5C2D06B6C', 1)

insert into Partidos(id, resultadoLocal, resultadoVisitante, isAbierto, maxApuesta1, maxApuesta2, maxApuesta3, idCompeticion)
values(NEWID(), 5,3,1,5000,2500,1600,'5FAAF209-1955-4620-A6CC-C2DA69052279')

insert into Partidos(id, resultadoLocal, resultadoVisitante, isAbierto, maxApuesta1, maxApuesta2, maxApuesta3, idCompeticion)
values(NEWID(), 5,3,1,5000,2500,1600,'5FAAF209-1955-4620-A6CC-C2DA69052279')

insert into Partidos(id, resultadoLocal, resultadoVisitante, isAbierto, maxApuesta1, maxApuesta2, maxApuesta3, idCompeticion)
values(NEWID(), 5,3,1,5000,2500,1600,'5FAAF209-1955-4620-A6CC-C2DA69052279')

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


--go
--declare @VarTipoTabla table(
--    IDApuesta uniqueidentifier,
--	TipoApuesta tinyint
--)

--insert into @VarTipoTabla (IDApuesta,TipoApuesta)
--select ID,Tipo from Apuestas
--where IDPartido='47B61C3C-AC7B-48AA-AF01-4FD05FD43506'  and IsGanador!=1

--select * from @VarTipoTabla
select * from Partidos
go


create or alter 
trigger T_ActualizarGanador on Partidos
after update as
begin
	declare @IDPartido uniqueidentifier,
			@Tipo tinyint,
			@ResLocal tinyint,
			@ResVisitante tinyint,
			@ApostadoResLocal tinyint,
			@ApostadoResVisitante tinyint,
			@NombreEquipo varchar(10),
			@ApostadoResLocalTipo2 tinyint,
			@ApostadoResVisitanteTipo2 tinyint,
			@EquipoGanador varchar(10)

	select @IDPartido=id from inserted

	select @Tipo=Tipo from Apuestas	--mirar esto
	where @IDPartido=IDPartido

	select @ResLocal=resultadoLocal,@ResVisitante=resultadoVisitante from Partidos
	where @IDPartido=id

	select @ApostadoResLocal=AT1.NumGolesLocal,@ApostadoResVisitante=AT1.numGolesVisitante 
	from Apuestas as A
	inner join ApuestaTipo1 as AT1 
	on A.ID=AT1.id
	where @IDPartido=A.IDPartido

	select @NombreEquipo from Apuestas as A
	inner join ApuestaTipo2 as AT2 on A.ID=AT2.id
	where @IDPartido=A.IDPartido

	select @NombreEquipo from Apuestas as A	
	inner join ApuestaTipo2 as AT2 on A.ID=AT2.id
	where @IDPartido=A.IDPartido

	select @EquipoGanador from Apuestas as A
	inner join ApuestaTipo3 as AT3 on A.ID=AT3.id
	where @IDPartido=A.IDPartido

	if update(resultadoLocal) or update(resultadoVisitante)
	begin
		if @Tipo=1
		begin
			if @ResLocal=@ApostadoResLocal and @ResVisitante=@ApostadoResVisitante
			begin
				update Apuestas
				set IsGanador=1
				where IDPartido=@IDPartido
			end
		end
/*
		if @Tipo=2
		begin
			if @NombreEquipo='Local'
			begin
				if @ApostadoResLocalTipo2=@ResLocal
				begin
					update Apuestas
					set IsGanador=1
					where IDPartido=@IDPartido
				end
			end
			else if @NombreEquipo='Visitante'
			begin
				if @ApostadoResVisitanteTipo2=@ResVisitante
				begin
					update Apuestas
					set IsGanador=1
					where IDPartido=@IDPartido
				end
			end
		end

		if @Tipo=3
		begin
			if @EquipoGanador='Local' and @ResVisitante<@ResLocal
			begin
				update Apuestas
				set IsGanador=1
				where IDPartido=@IDPartido
			end
			else if @NombreEquipo='Visitante' and @ResVisitante>@ResLocal
			begin
				update Apuestas
				set IsGanador=1
				where IDPartido=@IDPartido
			end
			else if @NombreEquipo='Empate' and @ResVisitante=@ResLocal
			begin
				update Apuestas
				set IsGanador=1
				where IDPartido=@IDPartido
			end
		end
		*/
	end	--cierra el if update
end --cierra el trigger
go

begin tran
update Partidos
set resultadoLocal=2,
	resultadoVisitante=1
where id='2B0981F4-EE1C-4EB0-861F-4EE5C2D06B6C'

rollback

select * from Partidos
select * from Apuestas
select * from ApuestaTipo1


insert into ApuestaTipo1(id,NumGolesLocal,numGolesVisitante)
values('38A49533-1085-4EA7-8201-146AE90F78E1',2,1)


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
