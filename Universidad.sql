CREATE DATABASE Universidad3;
CREATE TABLE Persona 
(
	CvePersona	INT IDENTITY(1,1) PRIMARY KEY,
	nombre		VARCHAR(100),
	apellidoM	VARCHAR(100),
	apellidoP	VARCHAR(100),
	ciudad		VARCHAR(100),
	direccion	VARCHAR(100),
	telefono	BIGINT,
	fechaNac	DATETIME,
	sexo		VARCHAR(10),
	tipoP		VARCHAR(10),
);


INSERT INTO Persona(nombre,apellidoP,apellidoM,ciudad,direccion,fechaNac,sexo,tipoP)
VALUES('Gustavo','Landavazo','Arreola','Hermosillo','Av. Navojoa 1471 Col.Fonhapo',GETDATE(),'M','A');

INSERT INTO Persona(nombre,apellidoP,apellidoM,ciudad,direccion,fechaNac,sexo,tipoP)
VALUES('Lalo','Jaime','Espinoza','Hermosillo','Av. Navojoa 1512 Col.Sahuaro Final',GETDATE(),'M','P');



GO
-- =============================================
-- Author:		<Gustavo Landavazo>
-- Create date: <05/04/2021>
-- Description:	<Lista de Personas>
-- =============================================
    CREATE PROCEDURE PA_PersonaGet
        @CvePersona	INT
    AS
    BEGIN
		DECLARE @ERROR NVARCHAR(300)
		SET NOCOUNT ON;
	BEGIN TRY
				SELECT p.*, 
				CASE WHEN p.sexo = 'M' THEN 'Masculino' ELSE 'Femenino' END AS Sexo,
				CASE WHEN p.tipoP = 'A'THEN 'Alumno' ELSE 'Profesor' END AS Estatus
				FROM Persona p
				WHERE (-1= @CvePersona OR p.CvePersona = @CvePersona)
				
    END TRY
    BEGIN CATCH
		SET @Error = 'Numero: ' + CONVERT(VARCHAR, ERROR_NUMBER()) + '; Procedimiento: ' + ERROR_PROCEDURE() + '; Linea: ' + CONVERT(VARCHAR, ERROR_LINE()) + '; Detalle: ' + ERROR_MESSAGE();
			 RAISERROR(@Error, 16, 1);
	END CATCH
	END
	GO
-- =============================================
-- Author:		<Gustavo Landavazo>
-- Create date: <05/04/2021>
-- Description:	<Agregar Persona>
-- =============================================
    CREATE PROCEDURE PA_PersonaAdd
        @nombre			VARCHAR(100),
		@apellidoP		VARCHAR(100),
		@apellidoM		VARCHAR(100),
		@ciudad			VARCHAR(100),
		@direccion		VARCHAR(100),
		@sexo			VARCHAR(10),
		@tipoP			VARCHAR(10)
    AS
    BEGIN
		DECLARE @ERROR NVARCHAR(300)
		SET NOCOUNT ON;
	BEGIN TRY
				INSERT INTO Persona
				(
					nombre,
					apellidoP,
					apellidoM,
					ciudad,
					direccion,
					fechaNac,
					sexo,
					tipoP
				)
				VALUES
				(
					@nombre,
					@apellidoP,
					@apellidoM,
					@ciudad,
					@direccion,
					GETDATE(),
					@sexo,
					@tipoP
				)
    END TRY
    BEGIN CATCH
		SET @Error = 'Numero: ' + CONVERT(VARCHAR, ERROR_NUMBER()) + '; Procedimiento: ' + ERROR_PROCEDURE() + '; Linea: ' + CONVERT(VARCHAR, ERROR_LINE()) + '; Detalle: ' + ERROR_MESSAGE();
			 RAISERROR(@Error, 16, 1);
	END CATCH
	SELECT * from Persona where CvePersona = SCOPE_IDENTITY()
	END
GO
-- =============================================
-- Author:		<Gustavo Landavazo>
-- Create date: <05/04/2021>
-- Description:	<Editar una Persona>
-- =============================================
    CREATE PROCEDURE PA_PersonaUpdate
		@CvePersona		INT,
        @nombre			VARCHAR(100),
		@apellidoP		VARCHAR(100),
		@apellidoM		VARCHAR(100),
		@ciudad			VARCHAR(100),
		@direccion		VARCHAR(100),
		@sexo			VARCHAR(10),
		@tipoP			VARCHAR(10)
    AS
    BEGIN
		DECLARE @ERROR NVARCHAR(300)
		SET NOCOUNT ON;
	BEGIN TRY
				UPDATE Persona
				SET
				nombre		= @nombre,
				apellidoP	= @apellidoP,
				apellidoM	= @apellidoM,
				ciudad		= @ciudad,
				direccion	= @direccion,
				sexo		= @sexo,
				tipoP		= @tipoP
				WHERE (CvePersona = @CvePersona);
    END TRY
    BEGIN CATCH
		SET @Error = 'Numero: ' + CONVERT(VARCHAR, ERROR_NUMBER()) + '; Procedimiento: ' + ERROR_PROCEDURE() + '; Linea: ' + CONVERT(VARCHAR, ERROR_LINE()) + '; Detalle: ' + ERROR_MESSAGE();
			 RAISERROR(@Error, 16, 1);
	END CATCH
	SELECT * FROM Persona WHERE CvePersona = @CvePersona
	END;
	GO
-- =============================================
-- Author:		<Gustavo Landavazo>
-- Create date: <05/04/2021>
-- Description:	<Elimina una Persona>
-- =============================================
    CREATE PROCEDURE PA_PersonaDelete
        @CvePersona		INT
    AS
    BEGIN
		DECLARE @ERROR NVARCHAR(300)
		SET NOCOUNT ON;
	BEGIN TRY
				DELETE FROM Persona
				Where CvePersona = @CvePersona
    END TRY
    BEGIN CATCH
		SET @Error = 'Numero: ' + CONVERT(VARCHAR, ERROR_NUMBER()) + '; Procedimiento: ' + ERROR_PROCEDURE() + '; Linea: ' + CONVERT(VARCHAR, ERROR_LINE()) + '; Detalle: ' + ERROR_MESSAGE();
			 RAISERROR(@Error, 16, 1);
	END CATCH
	PRINT N'Se elimino Correctamente';
	END
	
