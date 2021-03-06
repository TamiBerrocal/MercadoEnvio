USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_ConfigurarFechas]    Script Date: 3/7/2016 7:01:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_ConfigurarFechas] 
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE [GD1C2016].[MASTERDBA].[Clientes]
	SET [FechaCreacion] = @Fecha
	WHERE (SELECT CONVERT(date, [FechaCreacion])) = (SELECT CONVERT(date, GETDATE()))

	UPDATE [GD1C2016].[MASTERDBA].[Empresas]
	SET [FechaCreacion] = @Fecha
	WHERE (SELECT CONVERT(date, [FechaCreacion])) = (SELECT CONVERT(date, GETDATE()))

	UPDATE [GD1C2016].[MASTERDBA].[Publicaciones]
	SET [IdEstado] = (SELECT E.[IdEstado] FROM [GD1C2016].[MASTERDBA].[Estado_Publicacion] E WHERE E.[Descripcion] = 'Activa')
	WHERE ((SELECT CONVERT(date, [FechaVencimiento])) > (SELECT CONVERT(date, @Fecha)))
	AND [Stock] > 0
END

GO
