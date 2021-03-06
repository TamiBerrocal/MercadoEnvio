USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertCliente]    Script Date: 27/06/2016 09:25:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertCliente] 
	@IdUsuario int, 
	@Apellido nvarchar(255), 
	@Nombre nvarchar(255), 
	@TipoDoc nvarchar(50), 
	@NroDoc numeric(18,0), 
	@Mail nvarchar(255), 
	@Telefono nvarchar(50), 
	@Calle nvarchar(255), 
    @Nro numeric(18,0), 
	@Piso numeric(18,0), 
	@Departamento nvarchar(50), 
	@Localidad nvarchar(100), 
	@CodigoPostal nvarchar(50),  
	@FechaNacimiento datetime, 
	@FechaCreacion datetime
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Clientes]
	VALUES	(
			@IdUsuario,
			@Apellido,
			@Nombre,
			@TipoDoc,
			@NroDoc,
			@Mail,
			@Telefono,
			@Calle,
			@Nro,
			@Piso,
			@Departamento,
			@Localidad,
			@CodigoPostal,
			@FechaNacimiento,
			@FechaCreacion
			)
END

GO
