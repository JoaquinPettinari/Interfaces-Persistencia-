CREATE DATABASE Clase2;
USE Clase2;

CREATE TABLE IF NOT EXISTS Fabricantes(
	CodigoFabricante INT NOT NULL,
    NombreFabricante VARCHAR(100),
    PRIMARY KEY(CodigoFabricante)
);

CREATE TABLE IF NOT EXISTS Articulos(
	CodigoArticulo INT NOT NULL,
    CodigoFabricante INT NOT NULL,
    Nombre VARCHAR(100),
    Precio INT,
    PRIMARY KEY(CodigoArticulo),
    FOREIGN KEY (CodigoFabricante) REFERENCES Fabricantes(CodigoFabricante)
);


INSERT INTO Fabricantes (CodigoFabricante, NombreFabricante) VALUES 
(2411, 'Joaquin'), (2811, 'Silvina');

INSERT INTO Articulos (CodigoArticulo ,CodigoFabricante, Nombre, Precio) VALUES 
(1, 2411 , 'Manzana' , 40), (2, 2411, 'Pera', 80), (3, 2411, 'Naranja', 100), (4, 2811, 'Celular', 200), (5,2811, 'Heladera', 500);

/* Consulta 1 */
SELECT Nombre FROM Articulos;

/* Consulta 2 */
SELECT Nombre, Precio FROM Articulos;

/* Consulta 3 */
SELECT Nombre, Precio FROM Articulos WHERE Precio <= 200;

/* Consulta 4 */
SELECT Nombre, Precio FROM Articulos WHERE Precio BETWEEN 60 AND 120;

/* Consulta 5 */
SELECT Nombre, Precio * 85 AS Precio FROM Articulos;

/* Consulta 6 */
SELECT ROUND(AVG(Precio), 1) FROM Articulos;

/* Consulta 7 */
SELECT Articulos.Nombre, Articulos.Precio, Fabricantes.NombreFabricante
FROM Articulos, Fabricantes
WHERE Fabricantes.CodigoFabricante = Articulos.CodigoFabricante;


CREATE TABLE IF NOT EXISTS Departamentos(
	CodigoDepartamento INT NOT NULL,
    Nombre VARCHAR(100),
    Presupuesto INT,
    PRIMARY KEY (CodigoDepartamento)
);

CREATE TABLE IF NOT EXISTS Empleados(
	DNI VARCHAR(8) NOT NULL,
    CodigoDepartamento INT NOT NULL,
    Nombre VARCHAR(100),
    Apellidos VARCHAR(255),
    FOREIGN KEY (CodigoDepartamento) REFERENCES Departamentos(CodigoDepartamento)
);


INSERT INTO Departamentos(CodigoDepartamento, Nombre, Presupuesto) VALUES
(37, 'Casa Loca', 100000), (77, 'Casa Flanders', 50000), (10, 'Casa Simpson', 200000);

INSERT INTO Empleados(DNI, CodigoDepartamento, Nombre, Apellidos) VALUES
(41666728, 37, 'Joaquin', 'Don Juan'), (18351335, 10, 'Silvina', 'Perez'), (40534612, 77,'Pablo', 'Sanchez'), (42486384, 37,'Micaela', 'Lopez');

/* Consulta 8 */
SELECT * FROM Empleados
WHERE Apellidos IN ('Lopez' , 'Perez');

/* Consulta 9 */
SELECT * FROM Empleados
WHERE CodigoDepartamento = 37 OR CodigoDepartamento = 77;

/* Consulta 10 */
SELECT Empleados.Nombre, Empleados.Apellidos, Departamentos.Nombre, Departamentos.Presupuesto
FROM Empleados, Departamentos
WHERE Empleados.CodigoDepartamento = Departamentos.CodigoDepartamento
ORDER BY Departamentos.Nombre;

/* Consulta 11 */
SELECT Departamentos.Nombre FROM Departamentos, Empleados
GROUP BY Departamentos.Nombre
HAVING (SUM(CASE WHEN Empleados.CodigoDepartamento = Departamentos.CodigoDepartamento THEN 1 ELSE 0 END)) >= 2;

/* Consulta 12 */
INSERT INTO Departamentos(CodigoDepartamento, Nombre, Presupuesto) VALUES
(11, 'Calidad', 40000);

INSERT INTO Empleados(DNI, CodigoDepartamento, Nombre, Apellidos) VALUES
(89267109, 11, 'Esther', 'Vazquez');

/* Consulta 13 */
UPDATE Departamentos 
	SET Presupuesto = (Presupuesto * 0.9);
    
/* Para probar que anda */
SELECT Presupuesto FROM Departamentos;


CREATE TABLE IF NOT EXISTS Almacenes(
	CodigoAlmacen INT NOT NULL,
    Lugar VARCHAR(100),
    Capacidad INT,
    PRIMARY KEY(CodigoAlmacen)
);

CREATE TABLE IF NOT EXISTS Cajas(
	NumReferencia CHAR(5) NOT NULL,
    CodigoAlmacen INT,
    Contenido VARCHAR(100),
    VALOR INT,
	FOREIGN KEY (CodigoAlmacen) REFERENCES Almacenes(CodigoAlmacen)
);


INSERT INTO Almacenes(CodigoAlmacen, Lugar, Capacidad) VALUES
(1, 'La Ferrere', 2), (2, 'Caste',5);

INSERT INTO Cajas(NumReferencia, CodigoAlmacen, Contenido, Valor) VALUES
(20201, 1, 'Cigarrillos', 200), (20202, 1, 'Pañales', 500), (20203, 1, 'Mate', 100), (20204, 2, 'RX 570', 1000);  

/* Consulta 14 */
/* Opcion no tan buena */
SELECT Almacenes.Lugar, (SELECT COUNT(Cajas.NumReferencia) FROM Cajas WHERE Cajas.CodigoAlmacen = Almacenes.CodigoAlmacen) AS 'Cantidad de Cajas'
FROM Almacenes, Cajas
GROUP BY Almacenes.Lugar;

/* Opcion mas optima */
SELECT Almacenes.Lugar, COUNT(Cajas.NumReferencia) AS 'Cantidad de Cajas'
FROM Almacenes, Cajas
WHERE Cajas.CodigoAlmacen = Almacenes.CodigoAlmacen
GROUP BY Almacenes.Lugar;

/* Consulta 15 */
UPDATE Cajas,Almacenes
	SET Cajas.CodigoAlmacen = NULL
	WHERE Cajas.CodigoAlmacen IN ((SELECT COUNT(Cajas.NumReferencia) FROM Cajas, Almacenes WHERE Cajas.CodigoAlmacen = Almacenes.CodigoAlmacen) > Almacenes.Capacidad);




