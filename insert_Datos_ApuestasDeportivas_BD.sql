go 
use ApuestasDeportivas
go

/*delete from Usuarios*/
--select * from Usuarios

insert into Usuarios(correo,contraseña,saldoActual) 
values ('juanperez@gmail.com', 230, 200 )
go
insert into Usuarios(correo,contraseña,saldoActual) 
values ('lauraortiz@gmail.com', 245, 300 )
go
insert into Usuarios(correo,contraseña,saldoActual) 
values ('pedrohernandez@gmail.com', 562, 50 )
go

/*delete from Competiciones*/
--select * from Usuarios
--select * from Competiciones

insert into Competiciones(id,nombre,año) values(NEWID(), 'Copa Mundial', 2018)
go
insert into Competiciones(id,nombre,año) values(NEWID(), 'Copa del Rey', 2019)
go
insert into Competiciones(id,nombre,año) values(NEWID(), 'Champions League', 2019)
go

--select * from Partidos
--select * from competiciones
/*delete from Partidos where id ='027A0DD4-09C3-40CB-BA70-C343C288FE3C'*/

--Da fallos
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 2, 1, 0, 30, 60, 100,'2018-20-06 12:30:00', '500BCBA5-44AB-41EB-8EF6-4B999233AC5C')
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 3, 4, 0, 60, 80, 90, '2019-14-07 11:00:00', '500BCBA5-44AB-41EB-8EF6-4B999233AC5C')
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 4, 5, 0, 70, 90, 100, '2019-14-07 11:00:00','500BCBA5-44AB-41EB-8EF6-4B999233AC5C')
go


/*delete from Partidos*/
--select * from Partidos
--select * from Usuarios
--select * from Partidos
--select * from Apuestas
/*delete from Apuestas*/

--Da fallos
insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 3.5, '2019-08-10 12:00:00', 20, 'juanperez@gmail.com', 'C11875D3-CB0F-49AA-AF9C-27895AAE5455',2, 0)
go

insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 3, '2019-05-06 10:45:00', 10, 'lauraortiz@gmail.com', 'C11875D3-CB0F-49AA-AF9C-27895AAE5455', 2, 0)
go
insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 4, '2018-10-05 14:25:23', 10,'pedrohernandez@gmail.com', 'C11875D3-CB0F-49AA-AF9C-27895AAE5455', 2, 0)
go

--select * from Apuestas
--select * from ApuestaTipo1
--select * from Competiciones

insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('79013944-F42E-47E8-B450-19C2D503D2C3', 1, 5)
go
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('AE0F0A72-7672-4CC7-9238-EB2A13BC3EA7', 2, 3)
go
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('26C1D8E9-1975-460E-ABA2-F7A4FB7ACAA5', 1, 3)
go

--select * from ApuestaTipo2


insert into ApuestaTipo2(id, equipo, goles) values('16A0874A-3148-4B40-8B6C-43A134972E9B', 'visitante', 5)
go
insert into ApuestaTipo2(id, equipo, goles) values('8BB2095F-8835-4351-8392-5739E358FB1F', 'local', 3)
go
insert into ApuestaTipo2(id, equipo, goles) values('B4351B61-AC61-4998-AE14-DB49CCF1C8E3', 'local', 1)
go

--select * from ApuestaTipo3
--select * from Apuestas


insert into ApuestaTipo3(id, ganador) values('16A0874A-3148-4B40-8B6C-43A134972E9B', 0)
go
insert into ApuestaTipo3(id, ganador) values('8BB2095F-8835-4351-8392-5739E358FB1F',1)
go
insert into ApuestaTipo3(id, ganador) values('B4351B61-AC61-4998-AE14-DB49CCF1C8E3',1)
go

--delete from Cuentas
--select * from Apuestas
--select * from Usuarios
--select * from Cuentas

/*delete from Cuentas where saldo=300*/
set dateformat 'ymd' --Para establecer formato correcto de fecha
/*insert into Cuentas(saldo, fechaYHora, correoUsuario) values(200, GETDATE(), 'juanperez@gmail.com')
go*/
insert into Cuentas(saldo, fechaYHora, correoUsuario) values(200, '2019-08-07 11:00:00', 'juanperez@gmail.com')
go
insert into Cuentas/*(saldo, fechaYHora, correoUsuario)*/ values(300,'2019-08-07 11:00:00', 'lauraortiz@gmail.com')
go
insert into Cuentas/*(saldo, fechaYHora, correoUsuario)*/ values(50,'2018-08-20 11:30:00', 'pedrohernandez@gmail.com')
go

