USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertCompra]    Script Date: 2/7/2016 1:31:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [MASTERDBA].[SP_InsertCompra] 
	@IdPublicacion numeric(18,0), 
	@Fecha datetime, 
	@Cantidad numeric(18,0), 
	@Envio bit, 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [GD1C2016].[MASTERDBA].[Compras]
	VALUES (@IdPublicacion, @Fecha, @Cantidad, @Envio, @IdUsuario)

	UPDATE [GD1C2016].[MASTERDBA].[Publicaciones]
	SET [Stock] = [Stock] - @Cantidad
	WHERE [IdPublicacion] = @IdPublicacion

	SELECT C.[IdCompra] FROM [GD1C2016].[MASTERDBA].[Compras] C
	WHERE C.[IdPublicacion] = @IdPublicacion AND C.[Fecha] = @Fecha AND C.[Cantidad] = @Cantidad AND C.[Envio] = @Envio AND C.[IdUsuario] = @IdUsuario
END
