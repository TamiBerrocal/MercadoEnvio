USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetCalificacionesUsuario]    Script Date: 29/06/2016 11:04:16 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetCalificacionesUsuario] 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT CA.[IdCalificacion], CA.[IdCompra], CA.[CantEstrellas], CA.[Descripcion], P.[Descripcion] AS DescripcionPublicacion
	FROM [GD1C2016].[MASTERDBA].[Calificaciones] CA, [GD1C2016].[MASTERDBA].[Compras] CO, [GD1C2016].[MASTERDBA].[Publicaciones] P
	WHERE CA.[IdCompra] = CO.[IdCompra]
	AND CO.[IdPublicacion] = P.[IdPublicacion]
	AND P.IdUsuario = @IdUsuario
END

GO
