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

--Da fallos
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 2, 1, 0, 30, 60, 100,'2018-20-06 12:30:00', 'D6F53318-675E-477D-B9CC-3DC52A420E39')
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 3, 4, 0, 60, 80, 90, '2019-14-07 11:00:00', 'CE9A6E1A-8895-4F1B-9CCB-C4A329F10878')
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 4, 5, 0, 70, 90, 100, '2019-14-07 11:00:00','6CF4FF8C-D9FD-4F21-ADF9-E08CE86CB8AA')
go


/*delete from Partidos*/
--select * from Partidos
--select * from Usuarios
--select * from Partidos
--select * from Apuestas
/*delete from Apuestas*/

--Da fallos
insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 3.5, '2019-19-06 12:00:00', 20, 'juanperez@gmail.com', 'EFA764E0-B4CC-43CF-BDC4-0EA3C0D7F95D',1, 1)
go

insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 3, '2019-19-06 10:45:00', 10, 'lauraortiz@gmail.com', '15995859-5574-4591-B992-36D3C8C7BC72', 2, 0)
go
insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 4, '2018-10-05 14:25:23', 50,'pedrohernandez@gmail.com', '74851451-E5A7-4870-B55F-BB1987ABA812', 3, 1)
go


--select * from ApuestaTipo1
--select * from Competiciones

--Da fallos
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('EFA764E0-B4CC-43CF-BDC4-0EA3C0D7F95D', 1, 5)
go
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('15995859-5574-4591-B992-36D3C8C7BC72', 2, 3)
go
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('74851451-E5A7-4870-B55F-BB1987ABA812', 1, 3)
go

--select * from ApuestaTipo2

--Da fallos
insert into ApuestaTipo2(id, equipo, goles) values('EFA764E0-B4CC-43CF-BDC4-0EA3C0D7F95D', 'visitante', 5)
go
insert into ApuestaTipo2(id, equipo, goles) values('15995859-5574-4591-B992-36D3C8C7BC72', 'local', 3)
go
insert into ApuestaTipo2(id, equipo, goles) values('74851451-E5A7-4870-B55F-BB1987ABA812', 'local', 1)
go

--select * from ApuestaTipo3
--select * from Apuestas

--Da fallos
insert into ApuestaTipo3(id, ganador) values('EFA764E0-B4CC-43CF-BDC4-0EA3C0D7F95D', 0)
go
insert into ApuestaTipo3(id, ganador) values('15995859-5574-4591-B992-36D3C8C7BC72',1)
go
insert into ApuestaTipo3(id, ganador) values('74851451-E5A7-4870-B55F-BB1987ABA812',1)
go

--delete from Cuentas
--select * from Apuestas
--select * from Usuarios
--select * from Cuentas

/*delete from Cuentas where saldo=300*/
insert into Cuentas/*(id, saldo, fechaYHora, correoUsuario)*/ values(200,'2019-07-19 13:00:00', 'juanperez@gmail.com')
go
insert into Cuentas/*(id, saldo, fechaYHora, correoUsuario)*/ values(300,'2018-05-10 14:25:00', 'lauraortiz@gmail.com')
go
insert into Cuentas/*(id, saldo, fechaYHora, correoUsuario)*/ values(50,'2019-06-19 12:00:00', 'pedrohernandez@gmail.com')
go
