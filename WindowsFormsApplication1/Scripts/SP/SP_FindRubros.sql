USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[SP_FindRubros]    Script Date: 7/6/2016 12:52:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FindRubros] 
	@FiltroDescripcionCorta nvarchar(25) = '', 
	@FiltroDescripcionLarga nvarchar(100) = ''
AS
BEGIN
	SET NOCOUNT ON;

	SELECT R.[IdRubro] as IdRubro, R.[DescripcionCorta] as DescripcionCorta, R.[DescripcionLarga] as DescripcionLarga
	FROM [GD1C2016].[MASTERDBA].[Rubros] R
	WHERE (@FiltroDescripcionCorta = '' OR R.[DescripcionCorta] LIKE @FiltroDescripcionCorta + '%')
	AND (@FiltroDescripcionLarga = '' OR R.[DescripcionLarga] LIKE @FiltroDescripcionLarga + '%')
END

GO
