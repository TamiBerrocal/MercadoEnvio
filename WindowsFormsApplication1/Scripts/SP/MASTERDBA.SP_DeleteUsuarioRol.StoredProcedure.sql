USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_DeleteUsuarioRol]    Script Date: 27/06/2016 09:25:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_DeleteUsuarioRol] 
	@IdUsuario int, 
	@IdRol int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Usuarios_Roles]
	SET	Activa = 0
	WHERE [IdUsuario] = @IdUsuario
	AND [IdRol] = @IdRol
END

GO
