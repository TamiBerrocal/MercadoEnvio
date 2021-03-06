USE [GD1C2016]
GO
/****** Object:  StoredProcedure [MASTERDBA].[SP_UpdatePublicacion]    Script Date: 01/07/2016 09:15:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [MASTERDBA].[SP_UpdatePublicacion] 
	@IdPublicacion numeric(18,0), 
	@Descripcion nvarchar(255), 
	@Stock numeric(18,0), 
	@FechaInicio datetime, 
	@FechaVencimiento datetime, 
	@Precio numeric(18,2), 
	@PrecioReserva numeric(18,2), 
	@IdRubro int, 
	@IdEstado int, 
	@IdTipo int, 
	@Envio bit, 
	@IdVisibilidad numeric(18,0), 
	@FechaActual datetime
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Total numeric(18,2),
			@IdFactura numeric(18,0),
			@IdVisibilidadAnterior numeric(18,0)

	SET @IdVisibilidadAnterior = (SELECT PV.[IdVisibilidad] FROM [GD1C2016].[MASTERDBA].[Publicaciones_Visibilidad] PV WHERE PV.[IdPublicacion] = @IdPublicacion AND PV.[Activa] = 1)

	UPDATE [GD1C2016].[MASTERDBA].[Publicaciones_Visibilidad]
	SET [Activa] = 0
	WHERE [IdPublicacion] = @IdPublicacion
	AND [IdVisibilidad] = @IdVisibilidadAnterior

	UPDATE [GD1C2016].[MASTERDBA].[Publicaciones]
	SET
	[Descripcion] = @Descripcion,
	[Stock] = @Stock,
	[FechaInicio] = @FechaInicio,
	[FechaVencimiento] = @FechaVencimiento,
	[Precio] = @Precio,
	[PrecioReserva] = @PrecioReserva,
	[IdRubro] = @IdRubro,
	[IdEstado] = @IdEstado,
	[IdTipo] = @IdTipo,
	[Envio] = @Envio
	WHERE [IdPublicacion] = @IdPublicacion

	EXEC [GD1C2016].[MASTERDBA].[SP_InsertPublicacionVisibilidad] @IdPublicacion, @IdVisibilidad

	IF (SELECT E.[Descripcion] FROM [GD1C2016].[MASTERDBA].[Estado_Publicacion] E WHERE E.[IdEstado] = @IdEstado) = 'Activa' AND
	NOT EXISTS	(
				SELECT 1 FROM [GD1C2016].[MASTERDBA].[Facturas] F, [GD1C2016].[MASTERDBA].[Facturas_Items] I
				WHERE F.[IdFactura] = I.[IdFactura] AND F.[IdPublicacion] = @IdPublicacion AND I.[Concepto] = 'Comisión por Publicación'
				)
	BEGIN
		SELECT @Total = V.[Precio] FROM [GD1C2016].[MASTERDBA].[Visibilidad_Publicacion] V WHERE V.[IdVisibilidad] = @IdVisibilidad

		EXEC @IdFactura = [GD1C2016].[MASTERDBA].[SP_InsertFactura] @IdPublicacion, @FechaActual, @Total
		EXEC [GD1C2016].[MASTERDBA].[SP_InsertFacturaItem] @IdFactura, 'Comisión por Publicación', @Total, 1
	END
END

GO
