USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_InsertOferta]    Script Date: 3/7/2016 7:45:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_InsertOferta] 
	@IdPublicacion numeric(18,0), 
	@Fecha datetime, 
	@Monto numeric(18,2), 
	@IdUsuario int
AS
BEGIN
	SET NOCOUNT ON;
	--DECLARE @IdOferta int

	INSERT INTO [GD1C2016].[MASTERDBA].[Ofertas]
	VALUES (@IdPublicacion, @Fecha, @Monto, 0, @IdUsuario, NULL)

	--SET @IdOferta = @@IDENTITY

	UPDATE [GD1C2016].[MASTERDBA].[Publicaciones]
	SET [Precio] = [Precio] + @Monto
	WHERE [IdPublicacion] = @IdPublicacion

	SELECT O.[IdOferta] FROM [GD1C2016].[MASTERDBA].[Ofertas] O
	WHERE O.[IdPublicacion] = @IdPublicacion AND O.[Fecha] = @Fecha AND O.[Monto] = @Monto AND O.[IdUsuario] = @IdUsuario
END
