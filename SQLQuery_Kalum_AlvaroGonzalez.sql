drop database kalum_tarea
create database kalum_tarea
use kalum_tarea

create table ExamenAdmision(
	ExamenId varchar(128) primary key not null,
	FechaExamen datetime not null
)

create table CarreraTecnica(
	CarreraId varchar(128) primary key not null,
	Nombre varchar(128) not null
)

create table Jornada(
	JornadaId varchar(128) primary key not null,
	Siglas varchar(2) not null,
	Descripcion varchar(128) not null
)

create table Aspirante(
	NoExpediente varchar(128) primary key not null,
	Apellidos varchar(128) not null,
	Nombres varchar(128) not null,
	Direccion varchar(128) not null,
	Telefono varchar(64) not null,
	Email varchar(128) not null unique,
	Estatus varchar(32) default 'NO ASIGNADO',
	ExamenId varchar(128) not null,
	CarreraId varchar(128) not null,
	JornadaId varchar(128) not null

	constraint FK_ASPIRANTE_CARRERA_TECNICA	foreign key (CarreraId) references CarreraTecnica(CarreraId),
	constraint FK_ASPIRANTE_EXAMEN_ADMISION foreign key (ExamenId) references ExamenAdmision(ExamenId),
	constraint FK_ASPIRANTE_JORNADA foreign key (JornadaId) references Jornada(JornadaId)
)

create table Alumno(
	Carne varchar(8) primary key not null,
	Apellidos varchar(128) not null,
	Nombres varchar(128) not null,
	Direccion varchar(128) not null,
	Telefono varchar(64) not null,
	Email varchar(64) not null
)

create table Cargo(
	CargoId varchar(128) primary key not null,
	Descripcion varchar(128) not null,
	Prefijo varchar(64) not null,
	Monto decimal(10,2) not null,
	GeneraMora bit not null,
	PorcentajeMora int not null
)

create table CuentaPorCobrar(
	Correlativo varchar(128) primary key not null,
	Carne varchar(8) not null,
	Anio varchar(4) not null,
	Descripcion varchar(128) not null,
	FechaCargo datetime not null,
	FechaAplica datetime not null,
	Monto decimal(10,2) not null,
	Mora decimal(10,2) not null,
	Descuento decimal(10,2) not null,
	CargoId varchar(128) not null

	constraint FK_CUENTAXCOBRAR_ALUMNO foreign key (Carne) references Alumno(Carne),
	constraint FK_CUENTAXCOBRAR_CARGO foreign key (CargoId) references Cargo(CargoId)
)

create table Inscripcion(
	InscripcionId varchar(128) primary key not null,
	ciclo varchar(4) not null,
	FechaInscripcion datetime not null,
	Carne varchar(8) not null,
	CarreraId varchar(128) not null,
	JornadaId varchar(128) not null

	constraint FK_INSCRIPCION_ALUMNO foreign key (Carne) references Alumno(Carne),
	constraint FK_INSCRIPCION_CARRERA_TECNICA foreign key (CarreraId) references CarreraTecnica(CarreraId),
	constraint FK_INSCRIPCION_JORNADA foreign key (JornadaId) references Jornada(JornadaId)
)

create table InversionCarreraTecnica(
	InversionId varchar(128) primary key not null,
	MontoInscripcion decimal(10,2) not null,
	NumeroPagos decimal(10,2) not null,
	MontoPago decimal(10,2) not null,
	CarreraId varchar(128) not null,

	constraint FK_INVERSION_CARRERA_TECNICA foreign key (CarreraId) references CarreraTecnica(CarreraId)
)

create table ResultadoExamenAdmision(
	NoExpediente varchar(128) not null,
	Anio varchar(4) not null,
	Descripcion varchar(128) not null,
	Nota int default 0,
	primary key (NoExpediente,Anio),
	constraint FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE foreign key (NoExpediente) references Aspirante(NoExpediente)
)

create table InscripcionPago(
	BoletaPago varchar(128) not null,
	NoExpediente varchar(128) not null,
	Anio varchar(4) not null,
	FechaPago datetime not null,
	Monto decimal(10,2) not null

	Primary key(BoletaPago, NoExpediente, Anio),
	constraint FK_INSCRIPCION_PAGO_ASPIRANTE foreign key (NoExpediente) references Aspirante(NoExpediente)
)


--Creación de Carreras Técnicas
insert into CarreraTecnica (CarreraId, Nombre) values(NEWID(), 'Desarrollo de aplicaciones móviles');
insert into CarreraTecnica (CarreraId, Nombre) values(NEWID(), 'Desarrollo de servicios web con .NET Core');
insert into CarreraTecnica (CarreraId, Nombre) values(NEWID(), 'Desarrollo de aplicaciones empresariales con Java EE');
insert into CarreraTecnica (CarreraId, Nombre) values(NEWID(), 'Desarrollo de paginas web');

--Creación de Exámenes de admisión
insert into ExamenAdmision (ExamenId, FechaExamen) values(NEWID(),'2022-04-30');
insert into ExamenAdmision (ExamenId, FechaExamen) values(NEWID(),'2022-05-30');
insert into ExamenAdmision (ExamenId, FechaExamen) values(NEWID(),'2022-06-30');

--Creación de InversionCarreraTecnica
insert into InversionCarreraTecnica values(NEWID(), 1200, 5, 750, '318CFC15-9C78-4715-B718-73F734EEB412')
insert into InversionCarreraTecnica values(NEWID(), 1200, 5, 750, '8D4509A3-E5B2-4F45-B9F8-137AF744CC92')
insert into InversionCarreraTecnica values(NEWID(), 1200, 5, 750, '7AE603FA-6AD0-4639-AD20-91BF60809D16')
insert into InversionCarreraTecnica values(NEWID(), 1000, 5, 650, 'A587F916-3D6C-4EBF-8B60-154E05D96CB1')

--Creación de Cargo
insert into Cargo values(NEWID(), 'Pago de inscripción de carrera técnica Plan fin de semana', 'INSCT', '1200', '0', '0');
insert into Cargo values(NEWID(), 'Pago mensual carrera técnica', 'PGMCT', '850', '0', '0');
insert into Cargo values(NEWID(), 'Carné', 'CARNE', '30', '0', '0');

--Creación de Jornadas
insert into Jornada (JornadaId, Siglas, Descripcion) values(NEWID(), 'JM', 'Jornada Matutina');
insert into Jornada (JornadaId, Siglas, Descripcion) values(NEWID(), 'JV', 'Jornada Vespertina');

--Creación de Aspirantes
insert into Aspirante (NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId)
values('EXP-2022001', 'Gutierrez Morales', 'Ernesto Felipe',
'Guatemala, Guatemala', 
'45784512', 
'gernesto@kalum.edu.gt', 
'318CFC15-9C78-4715-B718-73F734EEB412',
'557C2D28-4E06-4186-AED9-2A0926F08A06',
'0AA84BE2-B439-43A5-B50A-14EF8E77433D'
)

insert into Aspirante (NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId)
values('EXP-2022002', 'Fernández Pérez', 'Alvin jorge',
'Guatemala, Guatemala', 
'12452125', 
'falvin@kalum.edu.gt', 
'8D4509A3-E5B2-4F45-B9F8-137AF744CC92',
'D2CFE4D1-9E96-45EA-8C7D-7E3E2913F470',
'0AA84BE2-B439-43A5-B50A-14EF8E77433D'
)

insert into Aspirante (NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId)
values('EXP-2022004', 'González Hic', 'Alvaro Miguel',
'Guatemala, Guatemala', 
'78126530', 
'agonzalez@kalum.edu.gt', 
'8D4509A3-E5B2-4F45-B9F8-137AF744CC92',
'D2CFE4D1-9E96-45EA-8C7D-7E3E2913F470',
'0AA84BE2-B439-43A5-B50A-14EF8E77433D'
)

insert into Aspirante (NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId)
values('EXP-2022005', 'Gutierrez López', 'Ernesto',
'Guatemala, Guatemala', 
'10254458', 
'gernesto1@kalum.edu.gt', 
'062FCC54-8863-48F1-BA50-A316B98C2BDE',
'EE500E12-78B1-4275-A75C-A3E5516947F9',
'BA1468F4-7D11-4DF5-8086-B628E0561EBA'
)

insert into Aspirante (NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId)
values('EXP-2022006', 'Ana Luisa', 'Rafael González',
'Guatemala, Guatemala', 
'30256330', 
'luisaraa@kalum.edu.gt', 
'7AE603FA-6AD0-4639-AD20-91BF60809D16',
'557C2D28-4E06-4186-AED9-2A0926F08A06',
'780A20DB-0E8F-4B72-89A7-506940FE61D2'
)


--Consultas
-- 01 Mostrar los aspirantes que se van a examinar el día 30 de abril, se debe de mostrar el Expediente, Apellidos, Nombres, Fecha Examen y Estatus,
select 
	NoExpediente, 
	Apellidos,
	Nombres,
	Estatus,
	FechaExamen
from Aspirante a 
inner join ExamenAdmision ea on a.ExamenId = ea.ExamenId 
inner join CarreraTecnica ct on a.CarreraId = ct.CarreraId
where ea.FechaExamen = '2022-05-30' order by a.Apellidos;

create view VW_ListarAspirantesPorFechaExamen
as
	select 
		NoExpediente, 
		Apellidos,
		Nombres,
		Estatus,
		FechaExamen
	from Aspirante a 
	inner join ExamenAdmision ea on a.ExamenId = ea.ExamenId 
	inner join CarreraTecnica ct on a.CarreraId = ct.CarreraId
go	
select Apellidos, Nombres, Estatus from VW_ListarAspirantesPorFechaExamen where FechaExamen = '2022-05-30' order by Apellidos;

select * from ResultadoExamenAdmision rea

--Trigger (Disparador)
create trigger tg_ActualizarEstadoAspirante on ResultadoExamenAdmision after insert
as
begin
	declare @Nota int = 0
	declare @Expediente varchar(128)
	declare @Estatus varchar(64) = 'NO ASIGNADO'

	set @Nota = (select Nota from inserted)
	set @Expediente = (select NoExpediente from inserted)
	if @Nota >= 70
		begin
		set @Estatus = 'SIGUE PROCESO DE ADMISIÓN'
		end
	else
		begin
		set @Estatus = 'NO SIGUE PROCESO DE ADMISIÓN'
		end		
	update Aspirante set Estatus = @Estatus where NoExpediente = @Expediente
end

insert into ResultadoExamenAdmision (NoExpediente, Anio, Descripcion, Nota) values('EXP-2022001', '2022', 'Resultado Examen', 70);

select * from Aspirante where NoExpediente = 'EXP-2022001'
select * from Cargo
select * from ResultadoExamenAdmision

create function LPAD
(
	@string varchar(MAX),
	@length int,
	@pad char
)
returns varchar(MAX)
as
begin 
	return REPLICATE(@pad, @length - LEN(@string)) + @string 
end

select dbo.LPAD('2002','8','4');

alter procedure sp_EnrollmentProcess @NoExpediente varchar(12), @Ciclo varchar(4), @MesInicioPago int, @CarreraId varchar(128)
as
begin
	-- Variables para información de aspirantes
	declare @Apellidos varchar(128)
	declare @Nombres varchar(128)
	declare @Direccion varchar(128)
	declare @Telefono varchar(64)
	declare @Email varchar(128)
	declare @JornadaId varchar(128)
	-- Variables para generar número de carné
	declare @Exists int
	declare @Carne varchar(12)
	-- Variables para el proceso de pago
	declare @MontoInscripcion numeric(10,2)
	declare @NumeroPagos int
	declare @MontoPago numeric(10,2)
	declare @Prefijo varchar(6)
	declare @CargoId varchar(128)
	declare @Monto numeric(10,2)
	declare @CorrelativoPagos int
	declare @Descripcion varchar(128)

	--Inicio de transacción
	begin transaction
	begin try
		select @Apellidos = Apellidos, @Nombres = Nombres, @Direccion = Direccion, @Telefono = Telefono, @Email = Email, @JornadaId = JornadaId
			from Aspirante where NoExpediente = @NoExpediente
		set @Exists = (select top 1 a.Carne from Alumno a where SUBSTRING(a.Carne,1,4) = @Ciclo order by a.Carne desc)
		if @Exists is NULL
		begin
			set @Carne = (@Ciclo * 10000) + 1
		end
		else
		begin 
			set @Carne = (select top 1 a.Carne from Alumno a where SUBSTRING(a.Carne,1,4) = @Ciclo order by a.Carne desc) + 1
		end
		-- Proceso de inscripción
		insert into Alumno(Carne, Apellidos, Nombres, Direccion, Telefono, Email) values
		(@Carne, @Apellidos, @Nombres, @Direccion, @Telefono, CONCAT(@Carne,@Email))
		insert into Inscripcion (InscripcionId, ciclo, FechaInscripcion, Carne, CarreraId, JornadaId) values
		(NEWID(), @Ciclo, GETDATE(), @Carne, @CarreraId, @JornadaId)
		update Aspirante set Estatus = 'INSCRITO CICLO ' + @Ciclo where NoExpediente = @NoExpediente 
		--Proceso de cargos
		--Cargo de inscripción
		select @MontoInscripcion = MontoInscripcion, @NumeroPagos = NumeroPagos, @MontoPago = MontoPago from InversionCarreraTecnica ict 
			where ict.CarreraId = @CarreraId
		select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo
			from Cargo c2 where c2.CargoId = '381CB5EF-F730-4136-872C-9D2084D70031'
		insert into CuentaPorCobrar (Correlativo, Anio, Descripcion, FechaCargo, FechaAplica, Monto, Mora, Descuento, Carne, CargoId) values
		(CONCAT(@Prefijo, SUBSTRING(@Ciclo, 3,2), dbo.LPAD('1',2,'0')), @Ciclo, @Descripcion, GETDATE(), GETDATE(), @MontoInscripcion, 0, 0, @Carne, @CargoId)
		--Cargo de Carne
		select @MontoInscripcion = MontoInscripcion, @NumeroPagos = NumeroPagos, @MontoPago = MontoPago from InversionCarreraTecnica ict 
			where ict.CarreraId = @CarreraId
		select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo, @Monto = Monto
			from Cargo c2 where c2.CargoId = '239C905F-858B-418D-B7BF-CC47E155A17E'
		insert into CuentaPorCobrar (Correlativo, Anio, Descripcion, FechaCargo, FechaAplica, Monto, Mora, Descuento, Carne, CargoId) values
		(CONCAT(@Prefijo, SUBSTRING(@Ciclo, 3,2), dbo.LPAD('1',2,'0')), @Ciclo, @Descripcion, GETDATE(), GETDATE(), @Monto, 0, 0, @Carne, @CargoId)
		-- Cargos mensuales
		set @CorrelativoPagos = 1
		select @Descripcion = Descripcion, @Prefijo = Prefijo from Cargo c2 where c2.CargoId = '9781E614-0AE3-4476-99C7-FF7292C94C4E'
		while(@CorrelativoPagos <= @NumeroPagos)
		begin
			insert into CuentaPorCobrar(Correlativo, Anio, Descripcion, FechaCargo, FechaAplica, Monto, Mora, Descuento, Carne, CargoId) values
				(CONCAT(@Prefijo,SUBSTRING(@Ciclo,3,2), dbo.LPAD(@CorrelativoPagos,2,'0')), @Ciclo, @Descripcion, GETDATE(), CONCAT(@Ciclo, '-', dbo.LPAD(@MesInicioPago, 2, '0'), '-', '05'), @Monto, 0, 0, @Carne, @CargoId)
			set @CorrelativoPagos = @CorrelativoPagos + 1
			set @MesInicioPago = @MesInicioPago + 1
		end
	
		commit transaction
		select 'TRANSACTION SUCCESS' as status, @Carne as carne
	end try
	begin catch
		rollback transaction
		select 'TRANSACTION ERROR' as status, 0 as carne
	end catch
end


execute sp_EnrollmentProcess 'EXP-2022006', '2022', 2, '8D4509A3-E5B2-4F45-B9F8-137AF744CC92'

select name from sys.key_constraints where type = 'PK' and OBJECT_NAME(parent_object_id) = N'CuentaPorCobrar'
alter table CuentaPorCobrar drop constraint PK__CuentaPo__25BD776B4E5848DC
alter table CuentaPorCobrar add primary key (Correlativo, Anio, Carne)

update Aspirante set Estatus = 'SIGUE PROCESO DE ADMISIÓN' where NoExpediente = 'EXP-2022006'

select * from Alumno
