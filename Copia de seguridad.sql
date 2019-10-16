use ApuestasDeportivas
go

--crear dispositivo
execute sp_addumpdevice 'disk', 'mydiskdump', 'c:\dump\dump1.bak' --cambiar ruta

alter database [MI_BD] set read_only--solo lectura

--execute sp_dropdevice NOMBRE L�GICO

backup database MiBaseDatos to disk--la copia de seguridad se hara en un disco

execute msdb.dbo.sp_add_job @job_name = 'BackupNocturno' --crear la tarea del agente

--A�adimos el primer paso a la tarea: Poner la Base de datos en modo solo lectura
execute msdb.dbo.sp_add_jobstep
    @job_name = 'BackupNocturno',
    @step_name = 'Set database to read only',
    @subsystem = 'SQL',
    @command = 'ALTER DATABASE Ejemplos SET READ_ONLY', 
    @retry_attempts = 5,  --(n� intentos)
    @retry_interval = 5    --(intervalo en min para realizar intentos)

exec msdb.dbo.sp_add_schedule
    @schedule_name = 'EjecutarBackUp',
    @freq_type = 4,       (se ejecuta cada 4 d�as)
    @freq_interval = 1, (El dia que se ejecuta el trabajo D=1,L=2.,.S=64)
    @active_start_time = 233000 ; -- A las 23:30


exec msdb.dbo.sp_attach_schedule
   @job_name = 'BackupNocturno',
   @schedule_name = 'EjecutarBackUp' 
go
---segunda forma
--exec add_job_Schedule
--	@job_name = 'BackupNocturno',
--	@name = 'EjecutarBackup',  --(nombre Schedule)
--	@freq_type = 4,		--(cada 4 d�as)
--	@freq_interval = 64,	--(S�bado)
--	@freq_recurrence_factor = 1, --(cada semana) (n� semanas o meses entre la ejecuci�n programada de un trabajo)	
--	@active_start_time = 20000 -- 2:00 AM