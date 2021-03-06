USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_FindFacturas]    Script Date: 01/07/2016 11:15:10 p.m. ******/
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
	@FiltroFechaDesde datetime, 
	@FiltroFechaHasta  datetime, 
	@FiltroImporteDesde numeric(18,2) = 0, 
	@FiltroImporteHasta numeric(18,2) = 0, 
	@FiltroDetallesFactura nvarchar(255) = '', 
	@FiltroDirigidaA nvarchar(255) = '',
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.[IdFactura], F.[IdPublicacion], F.[Fecha], F.[Total], F.[IdFormaPago]
	FROM [GD1C2016].[MASTERDBA].[VW_Facturas] F, [GD1C2016].[MASTERDBA].[Facturas_Items] I
	WHERE F.[IdFactura] = I.[IdFactura]
	AND F.[IdUsuario] = @IdUsuario
	AND F.[Fecha] BETWEEN @FiltroFechaDesde AND @FiltroFechaHasta
	AND (@FiltroImporteDesde = 0 OR F.[Total] >= @FiltroImporteDesde)
	AND (@FiltroImporteHasta = 0 OR F.[Total] <= @FiltroImporteHasta)
	AND (@FiltroDetallesFactura = '' OR UPPER(I.[Concepto]) LIKE '%' + UPPER(@FiltroDetallesFactura) + '%')
	AND (@FiltroDirigidaA = '' OR UPPER(F.[NombreUsuario]) LIKE '%' + UPPER(@FiltroDirigidaA) + '%')
END

GO
