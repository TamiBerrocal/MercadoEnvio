USE [GD1C2016]
GO
/****** Object:  View [MASTERDBA].[VW_Calificaciones]    Script Date: 27/06/2016 09:25:45 p.m. ******/
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
