USE [master]
GO
/****** Object:  Database [GIANTRONIC]    Script Date: 10/08/2014 11:55:30 a.m. ******/
CREATE DATABASE [GIANTRONIC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GIANTRONIC', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GIANTRONIC.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GIANTRONIC_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GIANTRONIC_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GIANTRONIC] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GIANTRONIC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GIANTRONIC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GIANTRONIC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GIANTRONIC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GIANTRONIC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GIANTRONIC] SET ARITHABORT OFF 
GO
ALTER DATABASE [GIANTRONIC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GIANTRONIC] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [GIANTRONIC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GIANTRONIC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GIANTRONIC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GIANTRONIC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GIANTRONIC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GIANTRONIC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GIANTRONIC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GIANTRONIC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GIANTRONIC] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GIANTRONIC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GIANTRONIC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GIANTRONIC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GIANTRONIC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GIANTRONIC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GIANTRONIC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GIANTRONIC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GIANTRONIC] SET RECOVERY FULL 
GO
ALTER DATABASE [GIANTRONIC] SET  MULTI_USER 
GO
ALTER DATABASE [GIANTRONIC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GIANTRONIC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GIANTRONIC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GIANTRONIC] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GIANTRONIC', N'ON'
GO
USE [GIANTRONIC]
GO
/****** Object:  StoredProcedure [dbo].[sp_listacategoria]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listacategoria]
as
select * from TB_CATEGORIA_TELEVISION

GO
/****** Object:  StoredProcedure [dbo].[sp_listaestados]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listaestados]
as
select * from TB_ESTADOS

GO
/****** Object:  StoredProcedure [dbo].[sp_listapedido]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listapedido]
as
select [pedcod]
      ,[dni]
      ,[monto]
      ,[fecha]
      ,e.[estdesc] as codest
	   from TB_PEDIDOS p inner join TB_ESTADOS e on p.codest=e.codest

GO
/****** Object:  StoredProcedure [dbo].[sp_listapedidos]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------
create proc [dbo].[sp_listapedidos]
as
select pedcod,u.nombre + ' ' + u.apellidop+ ' ' + u.apellidom as cliente,monto,fecha,e.estdesc from TB_PEDIDOS p, TB_USUARIOS u, TB_ESTADOS E
WHERE P.dni=U.dni AND P.codest=e.codest

GO
/****** Object:  StoredProcedure [dbo].[sp_listapedidoscliente]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listapedidoscliente]
@dni varchar(25),
@idped int,
@estado char(1)
as
select pedcod,u.nombre + ' ' + u.apellidop +' ' + u.apellidom as cliente,monto,fecha,e.estdesc from TB_PEDIDOS p, TB_USUARIOS u, TB_ESTADOS E
WHERE P.dni=U.dni AND P.codest=e.codest and p.dni=@dni and (pedcod=@idped or ISNULL(@idped,'')='') and
(e.codest = rtrim(ltrim(@estado)) or isnull(rtrim(ltrim(@estado)),'')='')

GO
/****** Object:  StoredProcedure [dbo].[sp_listapedidosdet]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------
create proc [dbo].[sp_listapedidosdet]
@idped int
as
select pedcod,item,p.nomprov,m.modelo,pd.precio,cantidad,subtotal,convert(varchar(10),fecha,103) fecha,estdesc,m.img 
from TB_PEDIDOS_DETALLE pd, TB_PROVEEDOR p, TB_TELEVISION m, TB_ESTADOS e 
where pd.ruc=p.ruc and pd.modelo=m.modelo and pd.codest=e.codest and
pedcod=@idped

GO
/****** Object:  StoredProcedure [dbo].[sp_listapedidosxestado]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------
create proc [dbo].[sp_listapedidosxestado]
@idped int,
@estado varchar(15)
as
select pedcod,u.nombre + ' ' + u.apellidop+ ' ' + u.apellidom as cliente,monto,fecha,e.estdesc from TB_PEDIDOS p, TB_USUARIOS u, TB_ESTADOS E
WHERE P.dni=U.dni AND P.codest=e.codest and (pedcod=@idped or ISNULL(@idped,'')='') and
(e.codest = rtrim(ltrim(@estado)) or isnull(rtrim(ltrim(@estado)),'')='')

GO
/****** Object:  StoredProcedure [dbo].[sp_listaperfiles]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listaperfiles]
as
select * from TB_PERFIL

GO
/****** Object:  StoredProcedure [dbo].[sp_listaproveedores]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listaproveedores]
as
select * from TB_PROVEEDOR

GO
/****** Object:  StoredProcedure [dbo].[sp_listatecnologia]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listatecnologia]
as
select * from TB_TIPO_TELEVISION

GO
/****** Object:  StoredProcedure [dbo].[sp_listatelevision]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


---------------------------------
create proc [dbo].[sp_listatelevision]
as
select modelo Codigo,nomprov Proveedor,destip Tecnologia,descat Categoria,resolucion Resolucion,tamaño Pulgadas,caracteristica Caracteristicas,precio Precio,stock Stock,img Img
from TB_TELEVISION a inner join TB_PROVEEDOR b on a.idprov = b.ruc 
	inner join TB_CATEGORIA_TELEVISION ct on ct.codcat=a.codcat
	inner join TB_TIPO_TELEVISION t on t.codtip=a.codtip

GO
/****** Object:  StoredProcedure [dbo].[sp_listaTelevisionxcategoria]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listaTelevisionxcategoria]
@modelo varchar(15),
@codcat varchar(3)
as
select modelo as Codigo,idprov as Proveedor,
      codtip as Tecnologia
      ,codcat as Categoria
      ,resolucion as Resolucion
      ,tamaño as Pulgadas
      ,caracteristica as Caracteristicas
      ,precio as Precio
      ,stock as Stock
      ,img as img from TB_TELEVISION 
WHERE (modelo=@modelo or ISNULL(@modelo,'')='') and
(codcat  = rtrim(ltrim(@codcat)) or isnull(rtrim(ltrim(@codcat)),'')='')

GO
/****** Object:  StoredProcedure [dbo].[sp_listatelevisionxmarca]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listatelevisionxmarca]
@modelo varchar(15),
@idprov varchar(11)
as
select modelo as Codigo,idprov as Proveedor,
      codtip as Tecnologia
      ,codcat as Categoria
      ,resolucion as Resolucion
      ,tamaño as Pulgadas
      ,caracteristica as Caracteristicas
      ,precio as Precio
      ,stock as Stock
      ,img as img from TB_TELEVISION 
WHERE (modelo=@modelo or ISNULL(@modelo,'')='') and
(idprov = rtrim(ltrim(@idprov)) or isnull(rtrim(ltrim(@idprov)),'')='')

GO
/****** Object:  StoredProcedure [dbo].[sp_listaTelevisionxTipopantalla]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listaTelevisionxTipopantalla]
@modelo varchar(15),
@codtip varchar(6)
as
select modelo as Codigo,idprov as Proveedor,
      codtip as Tecnologia
      ,codcat as Categoria
      ,resolucion as Resolucion
      ,tamaño as Pulgadas
      ,caracteristica as Caracteristicas
      ,precio as Precio
      ,stock as Stock
      ,img as img from TB_TELEVISION 
WHERE (modelo=@modelo or ISNULL(@modelo,'')='') and
(codtip  = rtrim(ltrim(@codtip)) or isnull(rtrim(ltrim(@codtip)),'')='')

GO
/****** Object:  StoredProcedure [dbo].[sp_listausuarios]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_listausuarios]
as
select dni,nombre,apellidop,apellidom,correo,telefono,direccion,nick,contraseña,descperf perfil
from TB_USUARIOS u, TB_PERFIL p where u.perfil=p.codperf

GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimientocategoria]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_mantenimientocategoria]
@codcat varchar(3),
@descat varchar(100),
@detalle varchar(200),
@accion char(1)
as
if @accion = 'R' -- registrar
	begin
		insert into TB_CATEGORIA_TELEVISION values (@codcat,@descat,@detalle)
	end

if @accion = 'A' -- actualizar
	begin
		update TB_CATEGORIA_TELEVISION
		set descat=@descat,detalle=@detalle
		where codcat=@codcat
	end

if @accion = 'E' -- eliminar
	begin
		delete from TB_CATEGORIA_TELEVISION where codcat=@codcat
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimientopedido]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------------------
-----------------procedimiento consulta--------------------------------
-----------------------------------------------------------------------



create proc [dbo].[sp_mantenimientopedido]
@pedcod  int,
@dni  varchar(25),
@monto  numeric(15,2),
@fecha  datetime,
@codest char(2),
@accion char(1)
as

if @accion = 'A' -- actualizar
	begin
		update TB_PEDIDOS
		set  dni=@dni,monto=@monto,fecha=@fecha,codest=@codest 
		where pedcod=@pedcod
	end

if @accion = 'E' -- eliminar
	begin
		delete from TB_PEDIDOS where pedcod=@pedcod
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimientoproveedor]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------------------
create proc [dbo].[sp_mantenimientoproveedor]
@ruc varchar(20),
@nom varchar(50),
@dir varchar(100),
@tel varchar(15),
@con varchar(100),
@cor varchar(100),
@pro varchar(100),
@accion char(1)
as
if @accion = 'R' -- registrar
	begin
		insert into TB_PROVEEDOR values (@ruc,@nom,@dir,@tel,@con,@cor,@pro)
	end

if @accion = 'A' -- actualizar
	begin
		update TB_PROVEEDOR
		set nomprov=@nom,direccion=@dir,telefono=@tel,contacto=@con,correo=@cor,productos=@pro
		where ruc=@ruc
	end

if @accion = 'E' -- eliminar
	begin
		delete from TB_PROVEEDOR where ruc=@ruc
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimientotecnologia]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_mantenimientotecnologia]
@codtip varchar(6),
@destip varchar(100),
@dur varchar(10),
@accion char(1)
as
if @accion = 'R' -- registrar
	begin
		insert into TB_TIPO_TELEVISION values (@codtip,@destip,@dur)
	end

if @accion = 'A' -- actualizar
	begin
		update TB_TIPO_TELEVISION
		set destip=@destip,durabilidad=@dur
		where codtip=@codtip
	end

if @accion = 'E' -- eliminar
	begin
		delete from TB_TIPO_TELEVISION where codtip=@codtip
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimientotelevision]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_mantenimientotelevision]
@modelo varchar(15),
@idprov char(11),
@codtip varchar(6),
@codcat varchar(3),
@resolucion varchar(10),
@tamaño char(3),
@caracteristica varchar(200),
@precio numeric(15,2),
@stock int,
@img varchar(200),
@accion char(1)
as
if @accion = 'R' -- registrar
	begin
		insert into TB_TELEVISION values (@modelo,@idprov,@codtip,@codcat,@resolucion,@tamaño,@caracteristica,@precio,@stock,@img)
	end

if @accion = 'A' -- actualizar
	begin
		update TB_TELEVISION
		set  idprov=@idprov,codtip=@codtip,codcat=@codcat,resolucion=@resolucion,tamaño=@tamaño,caracteristica=@caracteristica,precio=@precio,stock=@stock,img=@img
		where modelo=@modelo
	end

if @accion = 'E' -- eliminar
	begin
		delete from TB_TELEVISION where modelo=@modelo
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimientousuario]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------
create proc [dbo].[sp_mantenimientousuario]
@dni varchar(25),
@nom varchar(25),
@apep varchar(25),
@apem varchar(25),
@corr varchar(100),
@tel varchar(10),
@dir varchar(100),
@nic varchar(25),
@con varchar(25),
@perfil char(3),
@accion char(1)
as

if not exists (Select * from TB_USUARIOS where dni = @dni)
	raiserror ('El Usuario No Existe!',16,217)

if @accion = 'R' -- registrar
	begin
		if (isnull(@perfil,'') = '')
			begin
				insert into TB_USUARIOS values (@dni,@nom,@apep,@apem,@corr,@tel,@dir,@nic,@con,'USU')
			end
		else
			begin
				insert into TB_USUARIOS values (@dni,@nom,@apep,@apem,@corr,@tel,@dir,@nic,@con,@perfil)
			end
	end

if @accion = 'A' -- actualizar
	begin
		update TB_USUARIOS
		set nombre=@nom,apellidop=@apep,apellidom=@apem,correo=@corr,telefono=@tel,direccion=@dir,nick=@nic,contraseña=@con,perfil=@perfil
		where dni=@dni
	end

if @accion = 'E' -- eliminar
	begin
		delete from TB_USUARIOS where dni=@dni
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerusuario]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_obtenerusuario]
@usu varchar(25),
@pass varchar(25)
as
select * from TB_USUARIOS where nick =rtrim(ltrim(@usu)) and contraseña=rtrim(ltrim(@pass))

GO
/****** Object:  StoredProcedure [dbo].[sp_obtienedatosusuario]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


---------------------------------
create proc [dbo].[sp_obtienedatosusuario]
@dni varchar(25)
as
select * from TB_USUARIOS where dni=@dni

GO
/****** Object:  StoredProcedure [dbo].[sp_registrarpedidocab]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------

create proc [dbo].[sp_registrarpedidocab]
@pedcod int,
@dni varchar(9),
@monto numeric
as

-- variable....
declare @fecha datetime
set @fecha = GETDATE()

insert into TB_PEDIDOS values(@pedcod,@dni,@monto,@fecha,'P')


GO
/****** Object:  StoredProcedure [dbo].[sp_registrarpedidodet]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


---------------------------------

create proc [dbo].[sp_registrarpedidodet]    
@pedcod int,    
@nomprov varchar(50),    
@modelo varchar(15),    
@precio numeric,    
@cantidad int,    
@subtotal numeric    
as    
    
-- Variables    
declare @fecha datetime 
declare @item int
declare @ruc char(11) 
  
-- Asignacion de valores    
set @fecha = GETDATE()    
select @item=isnull(max(item),0) from TB_PEDIDOS_DETALLE where pedcod=@pedcod    
select @modelo=modelo from TB_TELEVISION where modelo=rtrim(ltrim(@modelo))   
select @ruc = ruc from TB_PROVEEDOR where nomprov=rtrim(ltrim(@nomprov))   

update TB_TELEVISION 
set stock = stock - @cantidad    
where modelo=rtrim(ltrim(@modelo))  
 
-- Correlativo para el item del pedido    
if @item = 0    
	begin
		set @item = 1    
	end
else
	begin    
		set @item = @item+1    
    end

insert into TB_PEDIDOS_DETALLE values (@pedcod,@item,@ruc,@modelo,@precio,@cantidad,@subtotal,@fecha,'P')      

GO
/****** Object:  Table [dbo].[TB_CATEGORIA_TELEVISION]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CATEGORIA_TELEVISION](
	[codcat] [varchar](3) NOT NULL,
	[descat] [varchar](100) NULL,
	[detalle] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[codcat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_ESTADOS]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ESTADOS](
	[codest] [char](2) NOT NULL,
	[estdesc] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[codest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_PEDIDOS]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_PEDIDOS](
	[pedcod] [int] NOT NULL,
	[dni] [varchar](25) NULL,
	[monto] [numeric](15, 2) NULL,
	[fecha] [datetime] NULL,
	[codest] [char](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[pedcod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_PEDIDOS_DETALLE]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_PEDIDOS_DETALLE](
	[pedcod] [int] NOT NULL,
	[item] [int] NOT NULL,
	[ruc] [char](11) NULL,
	[modelo] [varchar](15) NULL,
	[precio] [numeric](18, 0) NULL,
	[cantidad] [int] NULL,
	[subtotal] [numeric](15, 2) NULL,
	[fecha] [datetime] NULL,
	[codest] [char](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[pedcod] ASC,
	[item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_PERFIL]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_PERFIL](
	[codperf] [char](3) NOT NULL,
	[descperf] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[codperf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_PROVEEDOR]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_PROVEEDOR](
	[ruc] [char](11) NOT NULL,
	[nomprov] [varchar](50) NULL,
	[direccion] [varchar](100) NULL,
	[telefono] [varchar](15) NULL,
	[contacto] [varchar](100) NULL,
	[correo] [varchar](100) NULL,
	[productos] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ruc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_TELEVISION]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_TELEVISION](
	[modelo] [varchar](15) NOT NULL,
	[idprov] [char](11) NULL,
	[codtip] [varchar](6) NULL,
	[codcat] [varchar](3) NULL,
	[resolucion] [varchar](10) NULL,
	[tamaño] [char](3) NULL,
	[caracteristica] [varchar](200) NULL,
	[precio] [numeric](15, 2) NULL,
	[stock] [int] NULL,
	[img] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_TIPO_TELEVISION]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_TIPO_TELEVISION](
	[codtip] [varchar](6) NOT NULL,
	[destip] [varchar](100) NULL,
	[durabilidad] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[codtip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_USUARIOS]    Script Date: 10/08/2014 11:55:30 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_USUARIOS](
	[dni] [varchar](25) NOT NULL,
	[nombre] [varchar](25) NOT NULL,
	[apellidop] [varchar](25) NULL,
	[apellidom] [varchar](25) NULL,
	[correo] [varchar](100) NULL,
	[telefono] [varchar](10) NULL,
	[direccion] [varchar](100) NOT NULL,
	[nick] [varchar](25) NOT NULL,
	[contraseña] [varchar](25) NOT NULL,
	[perfil] [char](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nick] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TB_PEDIDOS]  WITH CHECK ADD FOREIGN KEY([codest])
REFERENCES [dbo].[TB_ESTADOS] ([codest])
GO
ALTER TABLE [dbo].[TB_PEDIDOS]  WITH CHECK ADD FOREIGN KEY([dni])
REFERENCES [dbo].[TB_USUARIOS] ([dni])
GO
ALTER TABLE [dbo].[TB_PEDIDOS_DETALLE]  WITH CHECK ADD FOREIGN KEY([codest])
REFERENCES [dbo].[TB_ESTADOS] ([codest])
GO
ALTER TABLE [dbo].[TB_PEDIDOS_DETALLE]  WITH CHECK ADD FOREIGN KEY([modelo])
REFERENCES [dbo].[TB_TELEVISION] ([modelo])
GO
ALTER TABLE [dbo].[TB_PEDIDOS_DETALLE]  WITH CHECK ADD FOREIGN KEY([ruc])
REFERENCES [dbo].[TB_PROVEEDOR] ([ruc])
GO
ALTER TABLE [dbo].[TB_TELEVISION]  WITH CHECK ADD FOREIGN KEY([codcat])
REFERENCES [dbo].[TB_CATEGORIA_TELEVISION] ([codcat])
GO
ALTER TABLE [dbo].[TB_TELEVISION]  WITH CHECK ADD FOREIGN KEY([codtip])
REFERENCES [dbo].[TB_TIPO_TELEVISION] ([codtip])
GO
ALTER TABLE [dbo].[TB_TELEVISION]  WITH CHECK ADD FOREIGN KEY([idprov])
REFERENCES [dbo].[TB_PROVEEDOR] ([ruc])
GO
ALTER TABLE [dbo].[TB_USUARIOS]  WITH CHECK ADD FOREIGN KEY([perfil])
REFERENCES [dbo].[TB_PERFIL] ([codperf])
GO
USE [master]
GO
ALTER DATABASE [GIANTRONIC] SET  READ_WRITE 
GO
