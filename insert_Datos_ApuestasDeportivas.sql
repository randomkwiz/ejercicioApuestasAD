go 
use ApuestasDeportivas
go

--delete from Usuarios
select * from Usuarios
insert into Usuarios(correo,contraseña,saldoActual) 
values ('juanperez@gmail.com', 230, 200 )
go
insert into Usuarios(correo,contraseña,saldoActual) 
values ('lauraortiz@gmail.com', 245, 300 )
go
insert into Usuarios(correo,contraseña,saldoActual) 
values ('pedrohernandez@gmail.com', 562, 50 )
go

--select * from Usuarios
select * from Competiciones
go
insert into Competiciones(id,nombre,año) values(NEWID(), 'Copa Mundial', 2018)
go
insert into Competiciones(id,nombre,año) values(NEWID(), 'Copa del Rey', 2019)
go
insert into Competiciones(id,nombre,año) values(NEWID(), 'Champions League', 2019)
go


select * from competiciones
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 2, 1, 0, 30, 60, 100,'2018-20-06 12:30:00', 'DC1D216A-6042-4529-BADF-00E9081448D3')
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 3, 4, 0, 60, 80, 90, '2019-14-07 11:00:00', '6D6E44A1-15A2-4ADF-AE17-C88574724BAF')
go
insert into Partidos(id,resultadoLocal,resultadoVisitante,isAbierto,maxApuesta1,maxApuesta2,maxApuesta3,fechaPartido,idCompeticion) 
values(NEWID(), 4, 5, 0, 70, 90, 100, '2019-14-07 11:00:00','A91BC9D1-004C-49AB-A156-E572C355B085')
go


--delete from Partidos
--select * from Partidos
--select * from Usuarios
--select * from Partidos
--delete from Apuestas

insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 3.5, '2019-19-06 12:00:00', 20, 'juanperez@gmail.com', '1B5CFD78-76BF-4C42-883E-377D613D8CB6',1, 1)
go

insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 3, '2019-19-06 10:45:00', 10, 'lauraortiz@gmail.com', '94865483-6B3B-4662-8068-3C2E71CEBC98', 2, 0)
go
insert into Apuestas(ID, cuota, FechaHoraApuesta, DineroApostado, CorreoUsuario, IDPartido, Tipo, IsGanador) 
values(NEWID(), 4, '2018-10-05 14:25:23', 50,'pedrohernandez@gmail.com', '34791E53-13A6-4DC1-9664-9CDE91A3A2E0', 3, 1)
go


--select * from Apuestas
--select * from Competiciones
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('94865483-6B3B-4662-8068-3C2E71CEBC98', 1, 5)
go
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('34791E53-13A6-4DC1-9664-9CDE91A3A2E0', 2, 3)
go
insert into ApuestaTipo1(id, NumGolesLocal, numGolesVisitante) values('1B5CFD78-76BF-4C42-883E-377D613D8CB6', 1, 3)
go

--select * from ApuestaTipo2
insert into ApuestaTipo2(id, equipo, goles) values('30373C81-591F-4338-8ED4-24EECA0FAA01', 'Barcelona', 5)
go
insert into ApuestaTipo2(id, equipo, goles) values('4263DDA6-FBEA-4A82-82A0-9B8C50BA140B', 'Real Madrid', 3)
go
insert into ApuestaTipo2(id, equipo, goles) values('744CEDE7-9A31-434D-8256-FE6BD15916C4', 'Atlético de Madrid', 1)
go

--select * from ApuestaTipo3
--select * from Apuestas
insert into ApuestaTipo3(id, ganador) values('30373C81-591F-4338-8ED4-24EECA0FAA01', 0)
go
insert into ApuestaTipo3(id, ganador) values('4263DDA6-FBEA-4A82-82A0-9B8C50BA140B',1)
go
insert into ApuestaTipo3(id, ganador) values('744CEDE7-9A31-434D-8256-FE6BD15916C4',1)
go

--delete from Cuentas
--select * from Apuestas
--select * from Usuarios
--select * from Cuentas
insert into Cuentas(id, saldo, fechaYHora, correoUsuario) values(200,'2019-06-19 10:45:00', 'juanperez@gmail.com')
go
insert into Cuentas(id, saldo, fechaYHora, correoUsuario) values(300,'2018-05-10 14:25:00', 'lauraortiz@gmail.com')
go
insert into Cuentas(id, saldo, fechaYHora, correoUsuario) values(50,'2019-06-19 12:00:00', 'pedrohernandez@gmail.com')
go
