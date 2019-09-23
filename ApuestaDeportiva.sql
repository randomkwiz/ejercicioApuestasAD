create database ApuestasDeportivas
go
use ApuestasDeportivas
go

CREATE TABLE Usuarios
(
	correo CHAR(15) not null,
	contraseña VARCHAR(10) NOT NULL,
	saldoActual INT NOT NULL,	

	----------------PK-------------------------
	constraint PK_Usuarios PRIMARY KEY (correo)
);
go

CREATE TABLE Competiciones
(
	id INT not null,
	nombre VARCHAR(20) NOT NULL,
	año INT,

	---------------pk------------------------------------
	constraint PK_Competiciones PRIMARY KEY (id),
);
go

CREATE TABLE Partidos
(
	id UNIQUEIDENTIFIER not null,
	resultadoLocal TINYINT null,
	resultadoVisitante TINYINT null,
	isAbierto BIT null,
	maxApuesta1 INT NOT NULL,
	maxApuesta2 INT NOT NULL,
	maxApuesta3 INT NOT NULL,
	fechaPartido SMALLDATETIME null,
	idCompeticion INT IDENTITY,

	---------------pk------------------------------------
	constraint PK_Partidos PRIMARY KEY (id),

	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_Competiciones_Partidos FOREIGN KEY (idCompeticion) REFERENCES competiciones (id)
);
go


CREATE TABLE APUESTAS (
	ID UNIQUEIDENTIFIER NOT NULL,
	CUOTA TINYINT NOT NULL,
	FECHAHORAAPUESTA SMALLDATETIME NOT NULL,
	DINEROAPOSTADO SMALLMONEY NOT NULL,
	CORREOUSUARIO CHAR(15) NOT NULL,
	IDPARTIDO UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT PK_APUESTA PRIMARY KEY (ID),
	CONSTRAINT FK_APUESTA_USUARIO FOREIGN KEY (CORREOUSUARIO) REFERENCES USUARIOS(CORREO) 
	ON DELETE NO ACTION ON UPDATE NO ACTION,	--NO SE PUEDEN NI ACTUALIZAR NI BORRAR

	CONSTRAINT FK_APUESTA_PARTIDO FOREIGN KEY(IDPARTIDO) REFERENCES PARTIDOS(ID)
	ON DELETE NO ACTION ON UPDATE NO ACTION
)




CREATE TABLE ApuestaTipo1
(
	id UNIQUEIDENTIFIER not null,
	NumGolesLocal TINYINT NOT NULL,
	numGolesVisitante TINYINT NOT NULL,

	---------------pk------------------------------------
	constraint PK_ApuestaTipo1 PRIMARY KEY (id),

	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_APUESTA_APUESTATIPO1 FOREIGN KEY (ID) REFERENCES APUESTAS(ID)
	on update cascade on delete cascade
	
);
go

CREATE TABLE ApuestaTipo2
(	
	id UNIQUEIDENTIFIER not null,
	equipo VARCHAR(10) NOT NULL,
	goles TINYINT NOT NULL,

	---------------pk------------------------------------
	constraint PK_ApuestaTipo2 PRIMARY KEY (id),

	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_APUESTA_APUESTATIPO2 FOREIGN KEY (ID) REFERENCES APUESTAS(ID)
	on update cascade on delete cascade
);
go

CREATE TABLE ApuestaTipo3
(
	id UNIQUEIDENTIFIER not null,
	ganador VARCHAR(15) NOT NULL,

	---------------pk------------------------------------
	constraint PK_ApuestaTipo3 PRIMARY KEY (id),
	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_APUESTA_APUESTATIPO3 FOREIGN KEY (ID) REFERENCES APUESTAS(ID)
	on update cascade on delete cascade
);
go

CREATE TABLE Cuentas
(
	id INT IDENTITY not null,
	saldo INT NOT NULL,
	fechaYHora SMALLDATETIME NOT NULL,
	correoUsuario CHAR(15),

	-----------------------PK-------------------------------
	constraint PK_Cuentas PRIMARY KEY (id),
	-----------------------FK--------------------------------------------
	CONSTRAINT FK_Usuarios_Cuentas FOREIGN KEY (correoUsuario) REFERENCES usuarios (correo) on update cascade on delete cascade
);

