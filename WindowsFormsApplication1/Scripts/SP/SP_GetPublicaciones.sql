USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[GetPublicaciones]    Script Date: 4/6/2016 7:48:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPublicaciones] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT P.[IdPublicacion], P.[CodPublicacion] AS CodigoPublicacion, P.[Descripcion], P.[Stock], P.[FechaInicio], P.[FechaVencimiento], P.[Precio], P.[IdRubro], P.[IdUsuario], P.[IdEstado], P.[IdTipo]
	FROM [GD1C2016].[MASTERDBA].[PUBLICACIONES] P
END

