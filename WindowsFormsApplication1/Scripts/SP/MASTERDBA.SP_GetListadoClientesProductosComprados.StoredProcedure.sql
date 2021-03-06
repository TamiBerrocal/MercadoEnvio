USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetListadoClientesProductosComprados]    Script Date: 27/06/2016 09:25:45 p.m. ******/
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
