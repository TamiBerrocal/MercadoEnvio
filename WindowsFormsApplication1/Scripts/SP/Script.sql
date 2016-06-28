USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_BloqUser]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_BloqUser] 
	@UserName nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios]
	SET	[Activo] = 0
	WHERE UPPER([UserName]) = UPPER(@UserName)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteRol]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteRol] 
	@IdRol int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Roles]
	SET	[Activo] = 0
	WHERE [IdRol] = @IdRol
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteRolFuncionalidad]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteRolFuncionalidad] 
	@IdRol int, 
	@IdFuncionalidad int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Roles_Funcionalidades]
	SET	Activa = 0
	WHERE [IdRol] = @IdRol
	AND [IdFuncionalidad] = @IdFuncionalidad
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteUsuario]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteUsuario] 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios]
	SET	[Activo] = 0
	WHERE [IdUsuario] = @IdUsuario
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteUsuarioRol]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteUsuarioRol] 
	@IdUsuario int, 
	@IdRol int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios_Roles]
	SET	Activa = 0
	WHERE [IdUsuario] = @IdUsuario
	AND [IdRol] = @IdRol
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteUsuariosRol]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteUsuariosRol] 
	@IdRol int
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS	(
				SELECT 1 FROM [GD1C2016].[MASTERDBA].[Usuarios_Roles] UR1, [GD1C2016].[MASTERDBA].[Usuarios_Roles] UR2
				WHERE UR1.[IdRol] = @IdRol AND UR1.[Activa] = 1 AND UR2.[IdUsuario] = UR1.[IdUsuario] AND UR2.[Activa] = 1
				GROUP BY UR2.[IdUsuario] HAVING COUNT(UR2.[IdRol]) = 1
				)
	BEGIN
		SELECT
			UR2.[IdUsuario],
			(SELECT U.[UserName] FROM [GD1C2016].[MASTERDBA].[Usuarios] U WHERE U.[IdUsuario] = UR2.[IdUsuario]) UserName
		FROM [GD1C2016].[MASTERDBA].[Usuarios_Roles] UR1, [GD1C2016].[MASTERDBA].[Usuarios_Roles] UR2
		WHERE UR1.[IdRol] = @IdRol
		AND UR1.[Activa] = 1
		AND UR2.[IdUsuario] = UR1.[IdUsuario]
		AND UR2.[Activa] = 1
		GROUP BY UR2.[IdUsuario]
		HAVING COUNT(UR2.[IdRol]) = 1
	END
	ELSE
	BEGIN
		UPDATE [GD1C2016].[MASTERDBA].[Usuarios_Roles]
		SET	[Activa] = 0
		WHERE [IdRol] = @IdRol
	END
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteVisibilidad]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteVisibilidad] 
	@IdVisibilidad int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion]
	SET	[Activa] = 0
	WHERE [IdVisibilidad] = @IdVisibilidad
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindClientes]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindClientes] 
	@FiltroNombre nvarchar(255) = '', 
	@FiltroApellido nvarchar(255) = '', 
	@FiltroEmail nvarchar(255) = '', 
	@FiltroDni numeric(18,0)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT C.[IdUsuario] AS IdUsuario, C.[Nombre] AS Nombre, C.[Apellido] AS Apellido, C.[Calle] AS Calle, C.[Nro] AS NroCalle, C.[CP] AS CodigoPostal, C.[Departamento] AS Departamento, C.[Mail] AS Email, C.[FechaNacimiento] AS FechaNacimiento, C.[Localidad] AS Localidad, C.[NroDoc] AS NroDoc, C.[Piso] AS Piso, C.[Telefono] AS Telefono, C.[TipoDoc] AS TipoDoc, U.[Activo] AS Activo, U.[UserName] AS UserName, U.[PassEncr] AS PasswordEnc
	FROM [GD1C2016].[MASTERDBA].[Clientes] C, [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE C.[IdUsuario] = U.[IdUsuario] 
	AND (@FiltroNombre = '' OR UPPER(C.[Nombre]) LIKE UPPER(@FiltroNombre) + '%')
	AND (@FiltroApellido = '' OR UPPER(C.[Apellido]) LIKE UPPER(@FiltroApellido) + '%')
	AND (@FiltroEmail = '' OR UPPER(C.[Mail]) LIKE UPPER(@FiltroEmail) + '%')
	AND (@FiltroDni = 0 OR C.[NroDoc] = @FiltroDni)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindEmpresas]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindEmpresas] 
	@FiltroRazonSocial nvarchar(255) = '', 
	@FiltroCuit nvarchar(50) = '', 
	@FiltroEmail nvarchar(255) = ''
AS
BEGIN
	SET NOCOUNT ON;

	SELECT E.[IdUsuario] AS IdUsuario, E.[RazonSocial] AS RazonSocial, E.[Ciudad] AS Ciudad, E.[Calle] AS Calle, E.[Nro] AS NroCalle, E.[CP] AS CodigoPostal, E.[Departamento] AS Departamento, E.[Mail] AS Email, E.[Rubro] AS Rubro, E.[Localidad] AS Localidad, E.[CUIT] AS Cuit, E.[Piso] AS Piso, E.[Telefono] AS Telefono, E.[Contacto] AS Contacto, U.[Activo] AS Activo, U.[UserName] AS UserName, U.[PassEncr] AS PasswordEnc
	FROM [GD1C2016].[MASTERDBA].[Empresas] E, [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE E.[IdUsuario] = U.[IdUsuario]
	AND (@FiltroRazonSocial = '' OR UPPER(E.[RazonSocial]) LIKE UPPER(@FiltroRazonSocial) + '%')
	AND (@FiltroCuit = '' OR UPPER(E.[CUIT]) LIKE UPPER(@FiltroCuit) + '%')
	AND (@FiltroEmail = '' OR UPPER(E.[Mail]) LIKE UPPER(@FiltroEmail) + '%')
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindFacturas]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindFacturas] 
	@FiltroFechaDesde datetime = NULL, 
	@FiltroFechaHasta  datetime = NULL, 
	@FiltroImporteDesde numeric(18,2) = NULL, 
	@FiltroImporteHasta numeric(18,2) = NULL, 
	@FiltroDetallesFactura nvarchar(255) = '', 
	@FiltroDirigidaA nvarchar(255) = ''
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.[IdFactura], F.[IdPublicacion], F.[Fecha], F.[Total], F.[IdFormaPago]
	FROM [GD1C2016].[MASTERDBA].[VW_Facturas] F, [GD1C2016].[MASTERDBA].[Facturas_Items] I
	WHERE F.[IdFactura] = I.[IdFactura]
	AND (@FiltroFechaDesde IS NULL OR F.[Fecha] >= @FiltroFechaDesde)
	AND (@FiltroFechaHasta IS NULL OR F.[Fecha] <= @FiltroFechaHasta)
	AND (@FiltroImporteDesde IS NULL OR F.[Total] >= @FiltroImporteDesde)
	AND (@FiltroImporteHasta IS NULL OR F.[Total] <= @FiltroImporteHasta)
	AND (@FiltroDetallesFactura = '' OR UPPER(I.[Concepto]) LIKE UPPER(@FiltroDetallesFactura) + '%')
	AND (@FiltroDirigidaA = '' OR UPPER(F.[NombreUsuario]) LIKE '%' + UPPER(@FiltroDirigidaA) + '%')
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindPublicaciones]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindPublicaciones] 
	@FiltroDescripcion nvarchar(255) = '',
	@FiltroIdRubro int = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		P.[IdPublicacion], P.[Descripcion], P.[Stock], P.[FechaInicio], P.[FechaVencimiento], P.[Precio], P.[PrecioReserva], P.[IdRubro], P.[IdUsuario], P.[IdEstado], P.[Envio],
		T.[IdTipo], T.[Descripcion] AS DescripcionTipoPublicacion, T.[Envio],
		V.[IdVisibilidad], V.[Descripcion] AS DescripcionVisibilidad, V.[Precio], V.[Porcentaje], V.[EnvioPorcentaje]
	FROM
		[GD1C2016].[MASTERDBA].[Publicaciones] P,
		[GD1C2016].[MASTERDBA].[Estado_Publicacion] E,
		[GD1C2016].[MASTERDBA].[Tipo_Publicacion] T,
		[GD1C2016].[MASTERDBA].[Publicaciones_Visibilidad] PV,
		[GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
	WHERE P.[IdEstado] = E.[IdEstado]
--	AND E.[Descripcion] = 'Activa'
	AND P.[IdTipo] = T.[IdTipo]
	AND P.[IdPublicacion] = PV.[IdPublicacion]
	AND PV.[Activa] = 1
	AND PV.[IdVisibilidad] = V.[IdVisibilidad]
	AND (@FiltroDescripcion = '' OR P.[Descripcion] LIKE @FiltroDescripcion + '%')
	AND (@FiltroIdRubro = 0 OR P.[IdRubro] = @FiltroIdRubro)
	AND P.[Stock] > 0
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindRoles]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindRoles] 
	@FiltroNombre nvarchar(100) = '', 
	@FiltroFuncionalidad int = 0, 
	@FiltroEstado bit = NULL
AS
BEGIN
	SET NOCOUNT ON;

	SELECT R.[IdRol], R.[Descripcion], R.[Activo]
	FROM [GD1C2016].[MASTERDBA].[Roles] R, [GD1C2016].[MASTERDBA].[Roles_Funcionalidades] RF
	WHERE R.[IdRol] = RF.[IdRol]
	AND RF.[Activa] = 1
	AND (@FiltroNombre = '' OR UPPER(R.[Descripcion]) LIKE UPPER(@FiltroNombre) + '%')
	AND (@FiltroFuncionalidad = 0 OR RF.[IdFuncionalidad] = @FiltroFuncionalidad)
	AND (@FiltroEstado IS NULL OR R.[Activo] = @FiltroEstado)
	GROUP BY R.[IdRol], R.[Descripcion], R.[Activo]
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindRubros]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindRubros] 
	@FiltroDescripcionCorta nvarchar(25) = '', 
	@FiltroDescripcionLarga nvarchar(100) = ''
AS
BEGIN
	SET NOCOUNT ON;

	SELECT R.[IdRubro] as IdRubro, R.[DescripcionCorta] as DescripcionCorta, R.[DescripcionLarga] as DescripcionLarga
	FROM [GD1C2016].[MASTERDBA].[Rubros] R
	WHERE (@FiltroDescripcionCorta = '' OR R.[DescripcionCorta] LIKE @FiltroDescripcionCorta + '%')
	AND (@FiltroDescripcionLarga = '' OR R.[DescripcionLarga] LIKE @FiltroDescripcionLarga + '%')
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindVisibilidades]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_FindVisibilidades] 
	@FiltroDescripcion nvarchar(255) = ''
AS
BEGIN
	SET NOCOUNT ON;

	SELECT V.[IdVisibilidad] AS IdVisibilidad, V.[Descripcion] AS Descripcion, V.[EnvioPorcentaje] AS EnvioPorcentaje, V.[Porcentaje] AS Porcentaje, V.[Precio] AS Precio, V.[Activa]
	FROM [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
	WHERE (@FiltroDescripcion = '' OR  V.[Descripcion] LIKE @FiltroDescripcion + '%')
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetCantidadCalificacionesDadas]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetCantidadCalificacionesDadas] 
	@CantEstrellas int, 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT COUNT(C.[IdCalificacion])
	FROM [GD1C2016].[MASTERDBA].[VW_Calificaciones] C
	WHERE C.[IdUsuario] = @IdUsuario
	AND C.[CantEstrellas] = @CantEstrellas
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetClienteByTipoDocNroDoc]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetClienteByTipoDocNroDoc] 
	@TipoDoc nvarchar(50), 
	@NroDoc numeric(18,0)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT C.[IdUsuario] AS IdUsuario, C.[Nombre] AS Nombre, C.[Apellido] AS Apellido, C.[Calle] AS Calle, C.[Nro] AS NroCalle, C.[CP] AS CodigoPostal, C.[Departamento] AS Departamento, C.[Mail] AS Email, C.[FechaNacimiento] AS FechaNacimiento, C.[Localidad] AS Localidad, C.[NroDoc] AS NroDoc, C.[Piso] AS Piso, C.[Telefono] AS Telefono, C.[TipoDoc] AS TipoDoc, U.[Activo] AS Activo, U.[UserName] AS UserName, U.[PassEncr] AS PasswordEnc
	FROM [GD1C2016].[MASTERDBA].[Clientes] C, [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE C.[IdUsuario] = U.[IdUsuario]
	AND UPPER(C.[TipoDoc]) = UPPER(@TipoDoc)
	AND C.[NroDoc] = @NroDoc
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetComprasPendientesCalificacion]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetComprasPendientesCalificacion] 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT CO.[IdCompra], CO.[IdPublicacion], CO.[Fecha], CO.[Cantidad], CO.[IdUsuario], P.[TipoDescripcion] AS TipoPublicacion, P.[Descripcion] AS DescripcionPublicacion, P.[NombreUsuario] AS Vendedor
	FROM [GD1C2016].[MASTERDBA].[Compras] CO, [GD1C2016].[MASTERDBA].[VW_Publicaciones] P
	WHERE CO.[IdPublicacion] = P.[IdPublicacion]
	AND P.[VisibilidadActual] = 1
	AND CO.[IdCompra] NOT IN (SELECT CA.[IdCompra] FROM [GD1C2016].[MASTERDBA].[Calificaciones] CA)
	AND CO.[IdUsuario] = @IdUsuario
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetDetallesFactura]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetDetallesFactura] 
AS
BEGIN
	SET NOCOUNT ON;
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetEmpresaByCUIT]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetEmpresaByCUIT] 
	@CUIT nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT E.[IdUsuario] AS IdUsuario, E.[RazonSocial] AS RazonSocial, E.[Ciudad] AS Ciudad, E.[Calle] AS Calle, E.[Nro] AS NroCalle, E.[CP] AS CodigoPostal, E.[Departamento] AS Departamento, E.[Mail] AS Email, E.[Rubro] AS Rubro, E.[Localidad] AS Localidad, E.[CUIT] AS Cuit, E.[Piso] AS Piso, E.[Telefono] AS Telefono, E.[Contacto] AS Contacto, U.[Activo] AS Activo, U.[UserName] AS UserName, U.[PassEncr] AS PasswordEnc
	FROM [GD1C2016].[MASTERDBA].[Empresas] E, [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE E.[IdUsuario] = U.[IdUsuario]
	AND UPPER(E.[CUIT]) = UPPER(@CUIT)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetFacturas]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetFacturas] 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.[IdFactura], F.[IdPublicacion], F.[Fecha], F.[Total], F.[IdFormaPago]
	FROM [GD1C2016].[MASTERDBA].[VW_Facturas] F
	WHERE F.[IdUsuario] = @IdUsuario
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetFuncionalidadByDescripcion]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetFuncionalidadByDescripcion] 
	@Descripcion nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.[IdFuncionalidad], F.[Descripcion]
	FROM [GD1C2016].[MASTERDBA].[Funcionalidades] F
	WHERE UPPER(F.[Descripcion]) = UPPER(@Descripcion)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetFuncionalidades]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetFuncionalidades] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.[IdFuncionalidad], F.[Descripcion]
	FROM [GD1C2016].[MASTERDBA].[Funcionalidades] F
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetListadoClientesProductosComprados]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetListadoClientesProductosComprados] 
	@NroTrimestre int, 
	@Año int, 
	@IdRubro int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(5) C1.[IdUsuario], C1.[NombreUsuario], SUM(C1.[CantProductosComprados]) AS CantProductosComprados, C1.[RubroDescripcion]
	FROM
	(
	SELECT C.[IdUsuario], C.[NombreUsuario], SUM(C.[Cantidad]) AS CantProductosComprados, C.[IdRubro], C.[RubroDescripcion]
	FROM [GD1C2016].[MASTERDBA].[VW_Compras] C
	WHERE MONTH(C.[Fecha]) BETWEEN
		(CASE @NroTrimestre WHEN 1 THEN 1 WHEN 2 THEN 4 WHEN 3 THEN 7 WHEN 4 THEN 10 END) AND
		(CASE @NroTrimestre WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 9 WHEN 4 THEN 12 END)
	AND YEAR(C.[Fecha]) = @Año
	AND (@IdRubro = 0 OR C.[IdRubro] = @IdRubro)
	GROUP BY C.[IdUsuario], C.[NombreUsuario], C.[IdRubro], C.[RubroDescripcion]
	) C1
	GROUP BY C1.[IdUsuario], C1.[NombreUsuario], C1.[IdRubro], C1.[RubroDescripcion]
	ORDER BY SUM(C1.[CantProductosComprados]) DESC
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetListadoVendedoresFacturas]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetListadoVendedoresFacturas] 
	@NroTrimestre int, 
	@Año int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(5) F1.[IdUsuario], F1.[NombreUsuario], F1.[CantFacturas]
	FROM
	(
	SELECT F.[IdUsuario], F.[NombreUsuario], COUNT(F.[IdFactura]) AS CantFacturas
	FROM [GD1C2016].[MASTERDBA].[VW_Facturas] F
	WHERE MONTH(F.[Fecha]) BETWEEN
		(CASE @NroTrimestre WHEN 1 THEN 1 WHEN 2 THEN 4 WHEN 3 THEN 7 WHEN 4 THEN 10 END) AND
		(CASE @NroTrimestre WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 9 WHEN 4 THEN 12 END)
	AND YEAR(F.[Fecha]) = @Año
	GROUP BY F.[IdUsuario], F.[NombreUsuario]
	) F1
	ORDER BY F1.[CantFacturas] DESC
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetListadoVendedoresMontos]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetListadoVendedoresMontos] 
	@NroTrimestre int, 
	@Año int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(5) F1.[IdUsuario], F1.[NombreUsuario], F2.[IdFactura], F1.[Total]
	FROM
	(
	SELECT F.[IdUsuario], F.[NombreUsuario], MAX(F.[Total]) AS Total
	FROM [GD1C2016].[MASTERDBA].[VW_Facturas] F
	WHERE MONTH(F.[Fecha]) BETWEEN
		(CASE @NroTrimestre WHEN 1 THEN 1 WHEN 2 THEN 4 WHEN 3 THEN 7 WHEN 4 THEN 10 END) AND
		(CASE @NroTrimestre WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 9 WHEN 4 THEN 12 END)
	AND YEAR(F.[Fecha]) = @Año
	GROUP BY F.[IdUsuario], F.[NombreUsuario]
	) F1,
	[GD1C2016].[MASTERDBA].[VW_Facturas] F2
	WHERE F1.[IdUsuario] = F2.[IdUsuario]
	AND F1.[NombreUsuario] = F2.[NombreUsuario]
	AND F1.[Total] = F2.[Total]
	ORDER BY F1.[Total] DESC
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetListadoVendedoresProductosNoVendidos]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetListadoVendedoresProductosNoVendidos] 
	@NroTrimestre int, 
	@Año int, 
	@IdVisibilidad int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(5) V.[IdUsuario], V.[NombreUsuario], SUM(V.[CantProductosNoVendidos]) AS CantProductosNoVendidos, V.[VisibilidadDescripcion]
	FROM
	(
	SELECT F.[IdUsuario], F.[NombreUsuario], SUM(P.[Stock]) - SUM(I.[Cantidad]) AS CantProductosNoVendidos, P.[IdVisibilidad], P.[VisibilidadDescripcion]
	FROM [GD1C2016].[MASTERDBA].[VW_Facturas] F, [GD1C2016].[MASTERDBA].[Facturas_Items] I, [GD1C2016].[MASTERDBA].[VW_Publicaciones] P
	WHERE F.[IdFactura] = I.[IdFactura]
	AND F.[IdPublicacion] = P.[IdPublicacion]
	AND I.[Concepto] = 'Comisión por Venta'
	AND P.[VisibilidadActual] = 1
	--WHERE MONTH(F.[Fecha]) BETWEEN
	--	(CASE @NroTrimestre WHEN 1 THEN 1 WHEN 2 THEN 4 WHEN 3 THEN 7 WHEN 4 THEN 10 END) AND
	--	(CASE @NroTrimestre WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 9 WHEN 4 THEN 12 END)
	--AND YEAR(F.[Fecha]) = @Año
	--AND (@IdVisibilidad = 0 OR P.[IdVisibilidad] = @IdVisibilidad)
	GROUP BY F.[IdUsuario], F.[NombreUsuario], P.[IdVisibilidad], P.[VisibilidadDescripcion]
	) V
	GROUP BY V.[IdUsuario], V.[NombreUsuario], V.[IdVisibilidad], V.[VisibilidadDescripcion]
	ORDER BY SUM(V.[CantProductosNoVendidos]) DESC
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetPublicaciones]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetPublicaciones] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		P.[IdPublicacion], P.[Descripcion], P.[Stock], P.[FechaInicio], P.[FechaVencimiento], P.[Precio], P.[PrecioReserva], P.[IdRubro], P.[IdUsuario], P.[IdEstado], P.[Envio],
		T.[IdTipo], T.[Descripcion] AS DescripcionTipoPublicacion, T.[Envio],
		V.[IdVisibilidad], V.[Descripcion] AS DescripcionVisibilidad, V.[Precio], V.[Porcentaje], V.[EnvioPorcentaje]
	FROM
		[GD1C2016].[MASTERDBA].[Publicaciones] P,
		[GD1C2016].[MASTERDBA].[Estado_Publicacion] E,
		[GD1C2016].[MASTERDBA].[Tipo_Publicacion] T,
		[GD1C2016].[MASTERDBA].[Publicaciones_Visibilidad] PV,
		[GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
	WHERE P.[IdEstado] = E.[IdEstado]
--	AND E.[Descripcion] = 'Activa'
	AND P.[IdTipo] = T.[IdTipo]
	AND P.[IdPublicacion] = PV.[IdPublicacion]
	AND PV.[Activa] = 1
	AND PV.[IdVisibilidad] = V.[IdVisibilidad]
	AND P.[Stock] > 0
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetPublicacionesVisibilidad]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetPublicacionesVisibilidad] 
	@IdVisibilidad int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT PV.[IdPublicacion], P.[Descripcion]
	FROM [GD1C2016].[MASTERDBA].[Publicaciones_Visibilidad] PV, [GD1C2016].[MASTERDBA].[Publicaciones] P
	WHERE PV.IdPublicacion = P.[IdPublicacion]
	AND PV.[idVisibilidad] = @IdVisibilidad
	AND PV.[Activa] = 1
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetRolByDescripcion]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetRolByDescripcion] 
	@Descripcion nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT R.[IdRol], R.[Descripcion], R.[Activo]
	FROM [GD1C2016].[MASTERDBA].[Roles] R
	WHERE UPPER(R.[Descripcion]) = UPPER(@Descripcion)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetRoles]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetRoles] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT R.[IdRol], R.[Descripcion], R.[Activo]
	FROM [GD1C2016].[MASTERDBA].[Roles] R
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetRolesUsuario]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetRolesUsuario] 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT UR.[IdRol]
	FROM [GD1C2016].[MASTERDBA].[Usuarios_Roles] UR
	WHERE UR.[IdUsuario] = @IdUsuario
	AND UR.[Activa] = 1
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetRolFuncionalidades]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetRolFuncionalidades] 
	@IdRol int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RF.[IdFuncionalidad]
	FROM [GD1C2016].[MASTERDBA].[Roles_Funcionalidades] RF
	WHERE RF.[IdRol] = @IdRol
	AND RF.[Activa] = 1
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetRubros]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetRubros] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT R.[IdRubro] as IdRubro, R.[DescripcionCorta] as DescripcionCorta, R.[DescripcionLarga] as DescripcionLarga
	FROM [GD1C2016].[MASTERDBA].[Rubros] R
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetUltimasCalificaciones]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetUltimasCalificaciones] 
	@IdUsuario int, 
	@Cantidad int = 5
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP (@Cantidad) CA.[IdCalificacion], CA.[IdCompra], CA.[CantEstrellas], CA.[Descripcion], P.[Descripcion]
	FROM [GD1C2016].[MASTERDBA].[Calificaciones] CA, [GD1C2016].[MASTERDBA].[Compras] CO, [GD1C2016].[MASTERDBA].[Publicaciones] P
	WHERE CA.[IdCompra] = CO.[IdCompra]
	AND CO.[IdPublicacion] = P.[IdPublicacion]
	AND CO.IdUsuario = @IdUsuario
	ORDER BY CA.IdCalificacion DESC
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetUsuarioByUserName]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetUsuarioByUserName] 
	@UserName nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT U.[IdUsuario], U.[UserName], U.[PassEncr], U.[CantIntFallidos], U.[Activo]
	FROM [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE UPPER(U.[UserName]) = UPPER(@UserName)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetVisibilidadByDescripcion]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetVisibilidadByDescripcion] 
	@Descripcion nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT V.[IdVisibilidad] AS IdVisibilidad, V.[Descripcion] AS Descripcion, V.[EnvioPorcentaje] AS EnvioPorcentaje, V.[Porcentaje] AS Porcentaje, V.[Precio] AS Precio, V.[Activa]
	FROM [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
	WHERE UPPER(V.[Descripcion]) = UPPER(@Descripcion)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetVisibilidades]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetVisibilidades] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT V.[IdVisibilidad] AS IdVisibilidad, V.[Descripcion] AS Descripcion, V.[EnvioPorcentaje] AS EnvioPorcentaje, V.[Porcentaje] AS Porcentaje, V.[Precio] AS Precio, V.[Activa]
	FROM [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_IncrementCountLogin]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_IncrementCountLogin] 
	@UserName nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios]
	SET	[CantIntFallidos] = [CantIntFallidos] + 1
	WHERE UPPER([UserName]) = UPPER(@UserName)

	SELECT U.[CantIntFallidos]
	FROM [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE UPPER(U.[UserName]) = UPPER(@UserName)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertCliente]    Script Date: 27/06/2016 09:29:23 p.m. ******/
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
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertCompra]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertCompra] 
	@IdPublicacion int, 
	@Fecha datetime, 
	@Cantidad numeric(18,0), 
	@Envio bit, 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Compras]
	VALUES (@IdPublicacion, @Fecha, @Cantidad, @Envio, @IdUsuario)

	SELECT C.[IdCompra], C.[IdPublicacion], C.[Fecha], C.[Cantidad], C.[Envio], C.[IdUsuario]
	FROM [GD1C2016].[MASTERDBA].[Compras] C
	WHERE C.[IdCompra] = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertEmpresa]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertEmpresa] 
	@IdUsuario int, 
	@RazonSocial nvarchar(255), 
	@Mail nvarchar(255), 
	@Telefono nvarchar(50), 
	@Calle nvarchar(255), 
    @Nro numeric(18,0), 
	@Piso numeric(18,0), 
	@Departamento nvarchar(50), 
	@Localidad nvarchar(100), 
	@CodigoPostal nvarchar(50), 
	@Ciudad nvarchar(100), 
	@CUIT nvarchar(50), 
	@Contacto nvarchar(255), 
	@Rubro nvarchar(255), 
	@FechaCreacion datetime
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Empresas]
	VALUES	(
			@IdUsuario,
			@RazonSocial,
			@Mail,
			@Telefono,
			@Calle,
		    @Nro,
			@Piso,
			@Departamento,
			@Localidad,
			@CodigoPostal,
			@Ciudad,
			@CUIT,
			@Contacto,
			@Rubro,
			@FechaCreacion
			)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertNewCalificacion]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertNewCalificacion] 
	@IdCompra int, 
	@CantEstrellas int, 
	@Descripcion nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Calificaciones]
	VALUES	(@IdCompra, @CantEstrellas, @Descripcion)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertOferta]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertOferta] 
	@IdPublicacion int, 
	@Fecha datetime, 
	@Monto numeric(18,2), 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Ofertas]
	VALUES (@IdPublicacion, @Fecha, @Monto, 0, @IdUsuario, NULL)

	SELECT O.[IdOferta], O.[IdPublicacion], O.[Fecha], O.[Monto], O.[Envio], O.[IdUsuario]
	FROM [GD1C2016].[MASTERDBA].[Ofertas] O
	WHERE O.[IdOferta] = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertRol]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertRol] 
	@Descripcion nvarchar(100), 
	@Activo bit
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Roles]
	VALUES (@Descripcion, @Activo)

	SELECT R.[IdRol], R.[Descripcion], R.[Activo]
	FROM [GD1C2016].[MASTERDBA].[Roles] R
	WHERE R.[IdRol] = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertRolFuncionalidad]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertRolFuncionalidad] 
	@IdRol int, 
	@IdFuncionalidad int, 
	@Activa bit
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS	(
				SELECT 1 FROM [GD1C2016].[MASTERDBA].[Roles_Funcionalidades] RF
				WHERE RF.[IdRol] = @IdRol AND RF.[IdFuncionalidad] = @IdFuncionalidad
				)
	BEGIN
		UPDATE [GD1C2016].[MASTERDBA].[Roles_Funcionalidades]
		SET	[Activa] = 1
		WHERE [IdRol] = @IdRol
		AND [IdFuncionalidad] = @IdFuncionalidad
	END
	ELSE
	BEGIN
		INSERT INTO [GD1C2016].[MASTERDBA].[Roles_Funcionalidades]
		VALUES (@IdRol, @IdFuncionalidad, @Activa)
	END
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertRubro]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertRubro] 
	@DescripcionCorta nvarchar(25), 
	@DescripcionLarga nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Rubros]
	VALUES (@DescripcionCorta, @DescripcionLarga)

	SELECT R.[IdRubro], R.[DescripcionCorta], R.[DescripcionLarga]
	FROM [GD1C2016].[MASTERDBA].[Rubros] R
	WHERE R.[IdRubro] = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertUsuario]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertUsuario] 
	@UserName nvarchar(50), 
	@PassEncr nvarchar(255), 
	@CantIntFallidos int, 
	@Activo bit
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Usuarios]
	VALUES (@UserName, @PassEncr, @CantIntFallidos, @Activo)

	SELECT U.[IdUsuario], U.[UserName], U.[PassEncr], U.[CantIntFallidos], U.[Activo]
	FROM [GD1C2016].[MASTERDBA].[Usuarios] U
	WHERE U.[IdUsuario] = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertUsuarioRol]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertUsuarioRol] 
	@IdUsuario int, 
	@IdRol int, 
	@Activa bit
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS	(
				SELECT 1 FROM [GD1C2016].[MASTERDBA].[Usuarios_Roles] UR
				WHERE UR.[IdUsuario] = @IdUsuario AND UR.[IdRol] = @IdRol
				)
	BEGIN
		UPDATE [GD1C2016].[MASTERDBA].[Usuarios_Roles]
		SET	[Activa] = 1
		WHERE [IdUsuario] = @IdUsuario
		AND [IdRol] = @IdRol
	END
	ELSE
	BEGIN
		INSERT INTO [GD1C2016].[MASTERDBA].[Usuarios_Roles]
		VALUES (@IdUsuario, @IdRol, @Activa)
	END
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertVisibilidad]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertVisibilidad] 
	@Descripcion nvarchar(255), 
	@Activa bit,
	@Porcentaje numeric(18,2),
	@EnvioPorcentaje numeric(18,2),
	@Precio numeric(18,2)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion]
	VALUES (@Descripcion, @Precio, @Porcentaje, @EnvioPorcentaje, @Activa)

	SELECT V.[IdVisibilidad]
	FROM [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
	WHERE V.[IdVisibilidad] = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_ResetCountLogin]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_ResetCountLogin] 
	@UserName nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios]
	SET	[CantIntFallidos] = 0
	WHERE UPPER([UserName]) = UPPER(@UserName)
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_UpdateCliente]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_UpdateCliente] 
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
	@PassEncr nvarchar(255), 
	@Activo bit
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Clientes]
	SET
	[Apellido] = @Apellido,
	[Nombre] = @Nombre,
	[TipoDoc] = @TipoDoc,
	[NroDoc] = @NroDoc,
	[Mail] = @Mail,
	[Telefono] = @Telefono,
	[Calle] = @Calle,
	[Nro] = @Nro,
	[Piso] = @Piso,
	[Departamento] = @Departamento,
	[Localidad] = @Localidad,
	[CP] = @CodigoPostal,
	[FechaNacimiento] = @FechaNacimiento
	WHERE [IdUsuario] = @IdUsuario

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios]
	SET
	[PassEncr] = @PassEncr,
	[Activo] = @Activo
	WHERE [IdUsuario] = @IdUsuario
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_UpdateEmpresa]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_UpdateEmpresa] 
	@IdUsuario int,
	@RazonSocial nvarchar(255), 
	@Mail nvarchar(255), 
	@Telefono nvarchar(50), 
	@Calle nvarchar(255), 
    @Nro numeric(18,0), 
	@Piso numeric(18,0), 
	@Departamento nvarchar(50), 
	@Localidad nvarchar(100), 
	@CodigoPostal nvarchar(50), 
	@Ciudad nvarchar(100), 
	@CUIT nvarchar(50), 
	@Contacto nvarchar(255), 
	@Rubro nvarchar(255), 
	@PassEncr nvarchar(255), 
	@Activo bit
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Empresas]
	SET
	[RazonSocial] = @RazonSocial,
	[Mail] = @Mail,
	[Telefono] = @Telefono,
	[Calle] = @Calle,
	[Nro] = @Nro,
	[Piso] = @Piso,
	[Departamento] = @Departamento,
	[Localidad] = @Localidad,
	[CP] = @CodigoPostal,
	[Ciudad] = @Ciudad,
	[CUIT] = @CUIT,
	[Contacto] = @Contacto,
	[Rubro] = @Rubro
	WHERE [IdUsuario] = @IdUsuario

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios]
	SET
	[PassEncr] = @PassEncr,
	[Activo] = @Activo
	WHERE [IdUsuario] = @IdUsuario
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_UpdateRol]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_UpdateRol] 
	@IdRol int, 
	@Descripcion nvarchar(100), 
	@Activo bit
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Roles]
	SET
	Descripcion = @Descripcion,
	Activo = @Activo
	WHERE [IdRol] = @IdRol
END

GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_UpdateVisibilidad]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_UpdateVisibilidad] 
	@Descripcion nvarchar(255), 
	@Activa bit,
	@Porcentaje numeric(18,2),
	@EnvioPorcentaje numeric(18,2),
	@Precio numeric(18,2),
	@IdVisibilidad int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion]
	SET [Descripcion] = @Descripcion, Activa = @Activa, Porcentaje = @Porcentaje, EnvioPorcentaje = @EnvioPorcentaje, Precio = @Precio
	WHERE
	[IdVisibilidad] = @IdVisibilidad
END

GO
/****** Object:  View [MASTERDBA].[VW_Usuarios]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE VIEW [MASTERDBA].[VW_Usuarios] 
AS
SELECT
	U.[IdUsuario],
	U.[UserName],
	U.[PassEncr],
	U.[CantIntFallidos],
	U.[Activo],
	C.[Apellido],
	C.[Nombre],
	E.[RazonSocial],
	C.[TipoDoc],
	C.[NroDoc],
	COALESCE (C.[Mail], E.[Mail]) AS Mail,
	COALESCE (C.[Telefono], E.[Telefono]) AS Telefono,
	COALESCE (C.[Calle], E.[Calle]) AS Calle,
	COALESCE (C.[Nro], E.[Nro]) AS Nro,
	COALESCE (C.[Piso], E.[Piso]) AS Piso,
	COALESCE (C.[Departamento], E.[Departamento]) AS Departamento,
	COALESCE (C.[Localidad], E.[Localidad]) AS Localidad,
	COALESCE (C.[CP], E.[CP]) AS CP,
	E.[Ciudad],
	E.[CUIT],
	E.[Contacto],
	E.[Rubro],
	C.[FechaNacimiento],
	COALESCE (C.[FechaCreacion], E.[FechaCreacion]) FechaCreacion
FROM [GD1C2016].[MASTERDBA].[Usuarios] U
LEFT OUTER JOIN [GD1C2016].[MASTERDBA].[Clientes] C
ON U.[IdUsuario] = C.[IdUsuario]
LEFT OUTER JOIN [GD1C2016].[MASTERDBA].[Empresas] E
ON U.[IdUsuario] = E.[IdUsuario]
GO
/****** Object:  View [MASTERDBA].[VW_Publicaciones]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE VIEW [MASTERDBA].[VW_Publicaciones] 
AS
SELECT
	P.[IdPublicacion],
	P.[Descripcion],
	P.[Stock],
	P.[FechaInicio],
	P.[FechaVencimiento],
	P.[Precio],
	P.[PrecioReserva],
	P.[IdRubro],
	R.[DescripcionCorta],
	R.[DescripcionLarga],
	P.[IdUsuario],
	COALESCE(U.[Nombre] + ' ' + U.[Apellido], U.[RazonSocial]) AS NombreUsuario,
	P.[IdEstado],
	E.[Descripcion] AS EstadoDescripcion,
	P.[IdTipo],
	T.[Descripcion] AS TipoDescripcion,
	T.[Envio] AS TipoEnvio,
	V.[IdVisibilidad],
	V.[Descripcion] AS VisibilidadDescripcion,
	PV.[Activa] AS VisibilidadActual,
	P.[Envio]
FROM
	[GD1C2016].[MASTERDBA].[Publicaciones] P,
	[GD1C2016].[MASTERDBA].[Rubros] R,
	[GD1C2016].[MASTERDBA].[VW_Usuarios] U,
	[GD1C2016].[MASTERDBA].[Estado_Publicacion] E,
	[GD1C2016].[MASTERDBA].[Tipo_Publicacion] T,
	[GD1C2016].[MASTERDBA].[Publicaciones_Visibilidad] PV,
	[GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
WHERE P.[IdRubro] = R.[IdRubro]
AND P.[IdUsuario] = U.[IdUsuario]
AND P.[IdEstado] = E.[IdEstado]
AND P.[IdTipo] = T.[IdTipo]
AND P.[IdPublicacion] = PV.[IdPublicacion]
AND PV.[IdVisibilidad] = V.[IdVisibilidad]
GO
/****** Object:  View [MASTERDBA].[VW_Calificaciones]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE VIEW [MASTERDBA].[VW_Calificaciones] 
AS
SELECT
	CA.[IdCalificacion],
	CA.[IdCompra],
	CO.[IdUsuario],
	COALESCE(U.[Nombre] + ' ' + U.[Apellido], U.[RazonSocial]) AS NombreUsuario,
	CA.[CantEstrellas],
	CA.[Descripcion]
FROM [GD1C2016].[MASTERDBA].[Calificaciones] CA, [GD1C2016].[MASTERDBA].[Compras] CO, [GD1C2016].[MASTERDBA].[VW_Usuarios] U
WHERE CA.[IdCompra] = CO.[IdCompra]
AND CO.[IdUsuario] = U.[IdUsuario]
GO
/****** Object:  View [MASTERDBA].[VW_Facturas]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE VIEW [MASTERDBA].[VW_Facturas] 
AS
SELECT
	F.[IdFactura],
	F.[IdPublicacion],
	P.[IdUsuario],
	COALESCE(U.[Nombre] + ' ' + U.[Apellido], U.[RazonSocial]) AS NombreUsuario,
	F.[Fecha],
	F.[Total],
	F.[IdFormaPago],
	FP.[Descripcion] AS FormaPago
FROM
	[GD1C2016].[MASTERDBA].[Facturas] F,
	[GD1C2016].[MASTERDBA].[Publicaciones] P,
	[GD1C2016].[MASTERDBA].[VW_Usuarios] U,
	[GD1C2016].[MASTERDBA].[Formas_Pago] FP
WHERE F.[IdPublicacion] = P.[IdPublicacion]
AND F.[IdFormaPago] = FP.[IdFormaPago]
AND P.[IdUsuario] = U.[IdUsuario]
GO
/****** Object:  View [MASTERDBA].[VW_Compras]    Script Date: 27/06/2016 09:29:23 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE VIEW [MASTERDBA].[VW_Compras] 
AS
SELECT
	C.[IdCompra],
	C.[IdPublicacion],
	P.[Descripcion],
	P.[IdRubro],
	R.[DescripcionLarga] AS RubroDescripcion,
	C.[Fecha],
	C.[Cantidad],
	C.[Envio],
	C.[IdUsuario],
	COALESCE(U.[Nombre] + ' ' + U.[Apellido], U.[RazonSocial]) AS NombreUsuario
FROM
	[GD1C2016].[MASTERDBA].[Compras] C,
	[GD1C2016].[MASTERDBA].[Publicaciones] P,
	[GD1C2016].[MASTERDBA].[VW_Usuarios] U,
	[GD1C2016].[MASTERDBA].[Rubros] R
WHERE C.[IdPublicacion] = P.[IdPublicacion]
AND C.[IdUsuario] = U.[IdUsuario]
AND P.[IdRubro] = R.[IdRubro]
GO
