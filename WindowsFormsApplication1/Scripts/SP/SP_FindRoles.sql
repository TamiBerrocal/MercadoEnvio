USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[SP_FindRoles]    Script Date: 29/5/2016 8:50:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_FindRoles] 
	@FiltroNombre nvarchar(100), 
	@FiltroFuncionalidad int,
	@FiltroEstado nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT R.IdRol, R.Descripcion, R.Estado FROM [GD1C2016].[MASTERDBA].[Roles] R, [GD1C2016].[MASTERDBA].[Roles_Funcionalidades] RF
	WHERE R.IdRol = RF.IdRol
	AND (@FiltroNombre = '' OR R.Descripcion LIKE '%' + @FiltroNombre + '%')
	AND (@FiltroEstado = '' OR R.Estado LIKE '%' + @FiltroEstado + '%')
	AND (@FiltroFuncionalidad = 0 OR RF.IdFuncionalidad = @FiltroFuncionalidad)
	GROUP BY R.IdRol, R.Descripcion, R.Estado
END