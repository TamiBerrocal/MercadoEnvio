USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateRol]    Script Date: 12/06/2016 07:27:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateRol] 
	@IdRol int, 
	@Descripcion nvarchar(100), 
	@Activo bit
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [GD1C2016].[MASTERDBA].[Roles]
	SET
	Descripcion = @Descripcion,
	Activo = @Activo
	WHERE [IdRol] = @IdRol
END

GO
