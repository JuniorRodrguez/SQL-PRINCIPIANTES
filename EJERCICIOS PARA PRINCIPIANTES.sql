/*============================================
	III.- Consultas en SQL (primera parte)
==============================================*/
use Northwind
--1.- Consulta sobre las tablas
	SELECT*FROM Products
	SELECT*FROM [Order Details]

--2.- Ordenar de forma descendente
	SELECT*FROM Orders
	SELECT*FROM Orders ORDER BY OrderID DESC

--3.-Aplicaci�n de filtros en consultas
	--Usar la tabla Productos
	  SELECT*FROM Products
	--A) Productos que cuestan 10 d�lares
		SELECT*FROM Products WHERE UnitPrice=10

	--B) Productos que cuestan m�s de 15 d�lares
		SELECT*FROM Products WHERE UnitPrice > 15

	--C) Productos que cuestan menos de 40
		SELECT*FROM Products WHERE UnitPrice < 40

	--D) Productos cuyo precio es mayor o igual a 25 d�lares
		SELECT*FROM Products WHERE UnitPrice >=25

	--E) Productos que cuest�n m�s de 10 d�lares y menos de 50 d�lares
		--Primera forma
		SELECT*FROM Products WHERE UnitPrice > 10 AND UnitPrice<50

		--Segundo forma
		SELECT*FROM Products WHERE UnitPrice BETWEEN 10 AND 50

	--F) Productos que cuest�n m�s de 10 d�lares y menos de 50 d�lares ordenados de forma descendente
			SELECT*FROM Products --Definir la selecci�n
			WHERE UnitPrice>10 AND UnitPrice<50 --Defino la condici�n
			ORDER BY UnitPrice DESC --Define el orden de la informaci�n

	--G) Consultas por columnas (una columna en espec�fico)
		--i) Nombre del producto y precio
			SELECT P.ProductName 'Nombre de producto', P.UnitPrice 'Precio'
			FROM Products as P  ---Alias (pseud�nimo de productos es P)

		--ii) Nombre de producto y precio si es mayor a $15 (descendente)
			SELECT P.ProductName 'Nombre de producto', P.UnitPrice 'Precio'
			FROM Products as P
			WHERE P.UnitPrice>15
			ORDER BY P.UnitPrice DESC

	--H) El precio m�ximo de un producto
		SELECT MAX(UnitPrice) 'Precio m�ximo'
		FROM Products

	--I) El precio m�nimo de un producto
		SELECT MIN(UnitPrice)  'Precio m�nimo'
		FROM Products

	--J) Total de productos en stock
		SELECT SUM(UnitsInStock) 'Stock total'
		FROM Products

	--K) Inventario valorizado de cada producto
		SELECT ProductName 'Nombre del producto', (UnitPrice*UnitsInStock) 'Inventario valorizado'
		FROM Products

	--L) Inventario valorizado de todo el almac�n
		SELECT SUM(UnitPrice*UnitsInStock) 'Total de inventario valorizado'
		FROM Products

	--M) M�ximo inventario valorizado de todo el almac�n
		SELECT MAX(UnitPrice*UnitsInStock) 'M�ximo inventario valorizado'
		FROM Products

	--N) Precio promedio de productos
		SELECT AVG(UnitPrice) 'Precio promedio'
		FROM Products

	--O) Ra�z cuadrada de suma total de precios
		SELECT SQRT(SUM(UnitPrice)) 
		FROM Products

		/*========================================
	IV.- Funciones matem�ticas en SQL
=========================================*/
--1.- Valor absoluto
SELECT ABS(7-60) 'Valor absoluto'

--2.- Ra�z cuadrada
SELECT SQRT(12) 'Ra�z cuadrada'

--3.- Potencia [base,exponente]
SELECT POWER(5,3)
SELECT POWER(2.123456,4)

--4.- Redondeo
SELECT ROUND(150.25412,1) ---Redondeo a la d�cima
SELECT ROUND(150.25412,2) ---Redondeo a la cent�sima
SELECT ROUND(150.25412,0) ---Redondeo a la unidad

--5.- Ceiling (aproxima al entero mayor m�s pr�ximo)
SELECT CEILING (191.2)
SELECT CEILING (5478.000000000000000000000000000001)

--6.- floor (aproxima al entero menor m�s pr�ximo)
SELECT FLOOR(157.999999999)
SELECT FLOOR(55478.123456789)

--7.- logaritmos
SELECT LOG(100) --Logaritmo natural (Ln)
SELECT LOG10(100) ---Logaritmo de base 10

/*===============================
	V.- Funciones de texto
=================================*/
--1.- Charindex : Devuelve un valor entero correspondiente a la posici�n de una subcadena
SELECT CHARINDEX ('abc', 'modificacion estructura abc del libro')

--Ejercicios sobre funciones de texto
use master --Llamar a la base

--Creando la tabla ABCD
CREATE TABLE ABCD
(
  NOMBRE VARCHAR(50),
  APELLIDO VARCHAR(50),
  FECHA DATE
);

INSERT INTO ABCD(NOMBRE, APELLIDO, FECHA)
VALUES ('JOS�', 'ACEVEDO', '05/05/2005');

INSERT INTO ABCD(NOMBRE, APELLIDO, FECHA)
VALUES ('JORGE', 'GONZALES', '09/14/1999');

INSERT INTO ABCD(NOMBRE, APELLIDO, FECHA)
VALUES ('JAVIER', 'ESPINOZA', '10/11/2018');

INSERT INTO ABCD
VALUES
('JUAN','LOPEZ','08/08/2008'),
('MARIA','SOSA','09/09/1999'),
('JESUS','MONTES','07/07/2007'),
('KARLA','ROSAS','04/04/2004');

--Visualizar la tabla
SELECT*FROM ABCD

--1.- Cantidad de caracteres del nombre (LEN)
	SELECT M.NOMBRE 'Nombre', LEN(M.NOMBRE) 'Cantidad'
	FROM ABCD AS M

--2.- Cantidad de caracteres del nombre y el apellido
	SELECT NOMBRE, LEN(NOMBRE) 'Ext. nombre', APELLIDO, LEN(APELLIDO) 'Ext.apellido'
	FROM ABCD

--3.- Seleccionar las personas cuyos apellidos tienen m�s de 5 caracteres
	SELECT NOMBRE 
	FROM ABCD
	WHERE LEN(APELLIDO)>5

--4.- Extraer la inicial del nombre y apellido (LEFT)
	SELECT LEFT(NOMBRE,1) + '.' + APELLIDO 'Nombre completo'
	FROM ABCD

--5.- Inicial del nombre + apellido pero solo aquellas personas que comiencen con J
	SELECT LEFT(NOMBRE,1) + '.' + APELLIDO 
	FROM ABCD
	WHERE LEFT(NOMBRE,1)='J'

/*===============================
	VI.- CREACION DE TABLAS
=================================*/
CREATE TABLE Libros (
    id INT PRIMARY KEY,
    titulo VARCHAR(100),
    autor VARCHAR(100),
    precio DECIMAL(10, 2),
    stock INT
);

CREATE TABLE Ventas (
    id INT PRIMARY KEY,
    id_libro INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_libro) REFERENCES Libros(id)
);

-- Inserci�n de datos en la tabla Libros
INSERT INTO Libros (id, titulo, autor, precio, stock) VALUES
(1, 'El Quijote', 'Miguel de Cervantes', 15.99, 10),
(2, 'Cien A�os de Soledad', 'Gabriel Garc�a M�rquez', 12.99, 5),
(3, 'Don Juan Tenorio', 'Jos� Zorrilla', 9.99, 8);

-- Inserci�n de datos en la tabla Ventas
INSERT INTO Ventas (id, id_libro, cantidad, fecha) VALUES
(1, 1, 2, '2024-08-01'),
(2, 2, 1, '2024-08-02'),
(3, 3, 3, '2024-08-03');

 ---Calcula el total de ingresos generados por cada libro.
SELECT L.titulo, SUM(V.cantidad * L.precio) AS ingresos_totales
FROM Ventas V
JOIN Libros L ON V.id_libro = L.id
GROUP BY L.titulo;

---Crea una consulta que muestre el t�tulo del libro en may�sculas y el nombre del autor en min�sculas.
 SELECT UPPER(titulo) AS titulo_mayusculas,
		LOWER(autor) AS autor_minusculas
FROM Libros;

---Calcula cu�ntos d�as han pasado desde la �ltima venta de cada libro.
SELECT L.titulo, DATEDIFF(DAY, MAX(V.fecha), GETDATE()) AS dias_desde_ultima_venta
FROM Ventas V
JOIN Libros L ON V.id_libro = L.id
GROUP BY L.titulo;
