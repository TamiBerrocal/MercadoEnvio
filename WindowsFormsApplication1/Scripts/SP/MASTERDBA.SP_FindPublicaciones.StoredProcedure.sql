USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindPublicaciones]    Script Date: 3/7/2016 7:34:46 p. m. ******/
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
		P.[IdPublicacion], P.[Descripcion], P.[Stock], P.[FechaInicio], P.[FechaVencimiento], P.[Precio], P.[PrecioReserva], P.[IdRubro], P.[DescripcionCorta] AS RubroDescripcionCorta, P.[DescripcionLarga] AS RubroDescripcionLarga, P.[IdUsuario], P.[NombreUsuario], P.[IdEstado], P.[EstadoDescripcion], P.[Envio], P.[IdTipo], P.[TipoDescripcion], P.[TipoEnvio], P.[IdVisibilidad], P.[VisibilidadDescripcion], V.[Precio] As VisibilidadPrecio, V.[Porcentaje], V.[EnvioPorcentaje]
	FROM
		[GD1C2016].[MASTERDBA].[VW_Publicaciones] P,
		[GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V
	WHERE P.[IdVisibilidad] = V.[IdVisibilidad]
	--AND P.[EstadoDescripcion] IN ('Activa', 'Pausada')
	AND P.[VisibilidadActual] = 1
	AND (P.[Stock] > 0 OR P.[PrecioReserva] > 0)
	AND (@FiltroDescripcion = '' OR P.[Descripcion] LIKE '%' + @FiltroDescripcion + '%')
	AND (@FiltroIdRubro = 0 OR P.[IdRubro] = @FiltroIdRubro)
	ORDER BY V.[Precio] DESC, P.[IdPublicacion] ASC
END

GO
