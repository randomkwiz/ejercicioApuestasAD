use ApuestasDeportivas
go

select * from Apuestas
select * from ApuestaTipo2
insert into ApuestaTipo2(id, equipo, goles)
values('9A04FEB6-05B3-463A-90A8-0955AB39496A', 'visitante',1)

/*Trigger para que cuando insertes una apuesta, automaticamente detecte de
qué tipo de apuesta se trata y la cree en la tabla correspondiente (Tipo 1, tipo 2, tipo 3)
Lo "malo" es que solo se pondria el id, porque claro no se podria poner los datos
concretos de la apuesta
*/

	create or alter
	trigger
	on Apuestas
	after insert
	begin

	select Tipo
	from Apuestas

	end