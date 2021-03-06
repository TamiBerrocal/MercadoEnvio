USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetComprasPendientesCalificacion]    Script Date: 27/06/2016 09:25:45 p.m. ******/
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
