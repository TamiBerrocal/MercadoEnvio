USE [GD1C2016]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFuncionalidades]    Script Date: 28/5/2016 9:56:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetFuncionalidades] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [GD1C2016].[MASTERDBA].[Funcionalidades]
END

