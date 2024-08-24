/*========================================
	APLICACI�N EN LA BASE NORTHWIND
==========================================*/
use Northwind

--1.- Listado de clientes que tengan como primer caracter la letra A en el nombre
	SELECT*FROM Customers

	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE 'A%'

--2.-Listado de clientes que tengan como �ltimo caracter la letra A en el nombre
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE '%A'

--3.-Listado de clientes que tengan al menos la letra A en el nombre
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE '%A%'

--4.- Listado de clientes que tengan como primer y �ltimo caracter la letra A en el nombre
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE 'A%A'

--5.- Listado de clientes que tengan como tercer caracter la letra A
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE '__A%'

--6.- Listado de clientes que comiencen con las letras A,B,C,D,E,F
	--i) Primera forma
		SELECT C.CompanyName 'Nombre del cliente'
		FROM Customers as C
		WHERE C.CompanyName LIKE '[ABCDEF]%'

	--ii) Segunda forma
		SELECT C.CompanyName 'Nombre del cliente'
		FROM Customers as C
		WHERE C.CompanyName LIKE '[A-F]%'

--7.- Listado de clientes que comiencen con la letra H y terminen en una vocal
		SELECT CompanyName
		FROM Customers
		WHERE CompanyName LIKE 'H%[AEIOU]'

--8.- Listado de empleados : c�digo, nombre y apellido (en una sola columna), fecha de nac. y fecha de contrato
	SELECT*FROM Employees

	SELECT E.EmployeeID 'C�digo de empleado',
			E.FirstName + ' ' + E.LastName 'Nombre completo',
			E.BirthDate 'Fecha de nacimiento',
			E.HireDate 'Fecha de contrato'
	FROM Employees AS E

/*------------------------------------
		Funciones de fecha
---------------------------------------*/
--1.- Fecha actual
SELECT GETDATE() 'Fecha y hora'

--2.- Formato de fecha
	--i) 103---> DD/MM/YYYY
		SELECT CONVERT(VARCHAR(10), GETDATE(),103)

	--ii) 104---> DD.MM.YYYY
		SELECT CONVERT(VARCHAR(10), GETDATE(),104)

	--iii) 105---> DD-MM-YYYY
		SELECT CONVERT(VARCHAR(10), GETDATE(),105)

--3.- Diferencias de fechas
	--SELECT DATEDIFF (Periodo, Fecha inicial, Fecha final)
		/* Diario (entre d�as)---> DAY
		   Mensual (entre meses) ---> MONTH
		   Anual (entre a�os) ---> YEAR
		   Semanal (entre semanas) ---> WEEK
		   Trimestral (entre trimestres)---> QUARTER*/

	SELECT DATEDIFF (DAY, '07/18/2022','10/17/2022')
/*============================
	APLICACI�N EN NORTHWIND
==============================*/
USE Northwind

--1.- Listar �rdenes realizas en el a�o 1997
	SELECT*FROM Orders

	SELECT*FROM Orders
	WHERE DATEPART(YEAR,OrderDate)=1997

--2.- Listado de �rdenes realizadas en el mes de agosto del a�o 1997
	SELECT*FROM Orders
	WHERE DATEPART(YEAR,OrderDate) = 1997
		  AND DATEPART(MONTH,OrderDate) = 8

--3.- Listado de �rdenes realizados la primera quincena del mes de enero del a�o 1998
	SELECT*FROM Orders
	WHERE DATEPART(YEAR,OrderDate)=1998
		  AND DATEPART(MONTH,OrderDate) = 1
		  AND DATEPART(DAY,OrderDate)<=15

--4.- Listado de �rdenes emitidas un martes 13 o domingo 7
	SET LANGUAGE SPANISH --- Cambiar el idioma
	PRINT DATENAME(MONTH,GETDATE()) --- Imprimir el mes
	PRINT DATENAME(WEEKDAY,GETDATE()) ---Imprimir el d�a

	SELECT*FROM Orders
	WHERE (DATEPART(DAY,OrderDate)='13' AND DATENAME(WEEKDAY,OrderDate)='Martes')
		OR (DATEPART(DAY,OrderDate)='7' AND DATENAME(WEEKDAY,OrderDate)='Domingo')

--5.- Listado de �rdenes realizadas en el mes de Octubre de los a�os 1996 y 1998
	SELECT*FROM Orders
	WHERE DATEPART(MONTH,OrderDate) = 10
		  AND DATEPART(YEAR,OrderDate) IN (1996,1998)

/*----------------------
	Otras consultas
-------------------------*/
--1.- DISTINCT (Valores �nicos)
	SELECT*FROM Customers

	--Lista de valores �nicos en pa�ses
	 SELECT DISTINCT(Country) 'Pa�ses'
	 FROM Customers 

--2.- Hallar el precio con IGV(18%) en productos
	SELECT*FROM Products

	SELECT ProductName 'Nombre del producto',
		   UnitPrice 'Precio',
		   (UnitPrice*1.18) 'Precio con IGV'
	FROM Products

--3.- Hallar el subtotal (por fila) en la tabla Order Details
	SELECT*FROM [Order Details]

	SELECT ProductID 'C�digo de producto',
		   UnitPrice 'Precio unitario',
		   Quantity 'Cantidad',
		   (UnitPrice*Quantity) 'Subtotal'
	FROM [Order Details]

--4.- Hallar el monto del descuento
	SELECT ProductID 'C�digo de producto',
		   UnitPrice 'Precio unitario',
		   Quantity 'Cantidad',
		   (UnitPrice*Quantity) 'Subtotal',
		   (UnitPrice*Quantity*Discount) 'Descuento'
	FROM [Order Details]

--5.- Hallar el monto real pagado por el cliente
	SELECT ProductID 'C�digo de producto',
		   UnitPrice 'Precio unitario',
		   Quantity 'Cantidad',
		   (UnitPrice*Quantity) 'Subtotal',
		   (UnitPrice*Quantity*Discount) 'Descuento',
		   (UnitPrice*Quantity*(1-Discount)) 'Monto neto total'
	FROM [Order Details]

--6.- Obtener nombre de comp���a, direcci�n y ciudad de clientes en M�xico
	SELECT*FROM Customers

	SELECT C.CompanyName 'Compa��a', C.Address 'Direcci�n', C.City 'Ciudad'
	FROM Customers as C
	WHERE C.Country = 'Mexico'

--7.- Obtener nombre de comp���a, direcci�n, ciudad y tel�fono de clientes de M�xico o Argentina
	SELECT C.CompanyName 'Compa��a', C.Address 'Direcci�n', C.City 'Ciudad', C.Phone 'Tel�fono'
	FROM Customers AS C
	WHERE C.Country='Mexico' OR C.Country='Argentina'

--8.- Listar clientes que sean due�os del negocio para los pa�ses de Venezuela y Francia
	SELECT*FROM Customers AS C
	WHERE C.ContactTitle='Owner'
			AND C.Country IN ('Venezuela','Francia')

--9.- Seleccionar productos de la categor�a 1,2,3 y 4
	SELECT*FROM Products

	---Primera forma
		SELECT*FROM Products
			WHERE CategoryID='1'
					OR CategoryID='2'
						OR CategoryID='3'
							OR CategoryID='4'
		ORDER BY CategoryID

	--Segunda forma
		SELECT*FROM Products
		WHERE CategoryID IN (1,2,3,4)
		ORDER BY CategoryID

	--Tercera forma
		SELECT*FROM Products
		WHERE CategoryID BETWEEN 1 AND 4
		ORDER BY CategoryID