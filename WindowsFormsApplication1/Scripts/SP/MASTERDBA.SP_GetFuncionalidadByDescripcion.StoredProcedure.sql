USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_GetFuncionalidadByDescripcion]    Script Date: 27/06/2016 09:25:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_GetFuncionalidadByDescripcion] 
	@Descripcion nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.[IdFuncionalidad], F.[Descripcion]
	FROM [GD1C2016].[MASTERDBA].[Funcionalidades] F
	WHERE UPPER(F.[Descripcion]) = UPPER(@Descripcion)
END

GO
