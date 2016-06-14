USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTipoPublicacion]    Script Date: 13/06/2016 09:38:44 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetTipoPublicacion] 
	@IdPublicacion int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT T.[IdTipo], T.[Descripcion], T.[Envio]
	FROM [GD1C2016].[MASTERDBA].[Publicaciones] P, [GD1C2016].[MASTERDBA].[Tipo_Publicacion] T
	WHERE P.[IdTipo] = T.[IdTipo]
	AND P.[IdPublicacion] = @IdPublicacion
END


GO
