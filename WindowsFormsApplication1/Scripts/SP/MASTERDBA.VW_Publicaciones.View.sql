USE [GD1C2016]
GO
/****** Object:  View [MASTERDBA].[VW_Publicaciones]    Script Date: 27/06/2016 09:25:45 p.m. ******/
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
