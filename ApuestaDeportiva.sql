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
	id INT not null,
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

CREATE TABLE ApuestaTipo1
(
	id INT not null,
	fechaApuesta SMALLDATETIME NOT NULL,
	dinero MONEY NOT NULL,
	fechaHoraApuesta SMALLDATETIME NOT NULL, 
	NumGolesLocal TINYINT NOT NULL,
	numGolesVisitante TINYINT NOT NULL,
	cuota MONEY NOT NULL,
	correoUsuario CHAR(15),
	idPartido INT IDENTITY,

	---------------pk------------------------------------
	constraint PK_ApuestaTipo1 PRIMARY KEY (id),

	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_Usuarios_ApuestaTipo1 FOREIGN KEY (correoUsuario) REFERENCES usuarios (correo) on update cascade on delete cascade,
	CONSTRAINT FK_Partidos_ApuestaTipo1 FOREIGN KEY (idPartido) REFERENCES partidos (id)
	
);
go

CREATE TABLE ApuestaTipo2
(	
	id INT not null,
	cuota MONEY,
	fechaHoraApuesta SMALLDATETIME,
	dineroApostado MONEY NOT NULL,
	equipo VARCHAR(10) NOT NULL,
	goles TINYINT NOT NULL,
	correoUsuario CHAR(15),
	idPartido INT IDENTITY,

	---------------pk------------------------------------
	constraint PK_ApuestaTipo2 PRIMARY KEY (id),

	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_usuarios_ApuestaTipo2 FOREIGN KEY (correoUsuario) REFERENCES usuarios (correo) on update cascade on delete cascade,
	CONSTRAINT FK_Partidos_ApuestaTipo2 FOREIGN KEY (idPartido) REFERENCES partidos (id)
);
go

CREATE TABLE ApuestaTipo3
(
	id INT not null,
	cuota INT NOT NULL,
	fechaYHoraApuesta DATETIME NOT NULL,
	dineroApostado MONEY NOT NULL,	
	ganador VARCHAR(15) NOT NULL,
	correoUsuario CHAR(15),
	idPartido INT IDENTITY,

	---------------pk------------------------------------
	constraint PK_ApuestaTipo3 PRIMARY KEY (id),

	----------------------------fk-----------------------------------------------
	CONSTRAINT FK_Usuarios_ApuestaTipo3 FOREIGN KEY (correoUsuario) REFERENCES usuarios (correo) on update cascade on delete cascade,
	CONSTRAINT FK_Partidos_ApuestaTipo3 FOREIGN KEY (idPartido) REFERENCES partidos (id)
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

