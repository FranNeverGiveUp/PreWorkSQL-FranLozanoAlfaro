-- PRIMERA PARTE EJERCICIO 2
-- 1. Crea una base de datos llamada "MiBaseDeDatos".
-- 2. Crea una tabla llamada "Usuarios" con las columnas: "id" (entero, clave
-- primaria), "nombre" (texto) y "edad" (entero).
CREATE TABLE IF NOT EXISTS Usuarios(
	id INT PRIMARY KEY,
	nombre VARCHAR(255),
	edad INT
);

-- 3. Inserta dos registros en la tabla "Usuarios".
INSERT INTO Usuarios (id, nombre, edad)
VALUES (1, 'Fran', 35), (2, 'Ana', 34);

-- 4. Actualiza la edad de un usuario en la tabla "Usuarios".
UPDATE Usuarios
SET edad = 36
WHERE id = 1;

-- 5. Elimina un usuario de la tabla "Usuarios".
DELETE FROM Usuarios
WHERE id = 1;

-- SEGUNDA PARTE EJERCICIO 2
-- 1. Crea una tabla llamada "Ciudades" con las columnas: "id" (entero, clave
-- primaria), "nombre" (texto) y "pais" (texto).
CREATE TABLE IF NOT EXISTS Ciudades(
	id INT PRIMARY KEY,
	nombre VARCHAR(255),
	pais VARCHAR(255)
);

-- 2. Inserta al menos tres registros en la tabla "Ciudades".
INSERT INTO Ciudades (id, nombre, pais)
VALUES (1, 'Anantapur', 'India'), (2, 'Jeddah', 'Arabia Saudí'), (3, 'Valencia', 'España');

-- 3. Crea una foreign key en la tabla "Usuarios" que se relacione con la columna "id"
-- de la tabla "Ciudades".
ALTER TABLE Usuarios
ADD COLUMN ciudad_id INT,
ADD CONSTRAINT fk_ciudad_id FOREIGN KEY (ciudad_id) REFERENCES ciudades(id);

-- 4. Realiza una consulta que muestre los nombres de los usuarios junto con el
-- nombre de su ciudad y país (utiliza un LEFT JOIN).
-- 		1. Vamos a asignar el valor de ciudad al usuario que nos queda en la tabla "Usuarios":
UPDATE Usuarios
SET ciudad_id = 3
WHERE Usuarios.id = 2;

-- 		2. Realizamos la consulta:
SELECT Usuarios.nombre, Ciudades.nombre, Ciudades.pais FROM Usuarios
LEFT JOIN Ciudades
ON Usuarios.ciudad_id = Ciudades.id;

-- 5. Realiza una consulta que muestre solo los usuarios que tienen una ciudad
-- asociada (utiliza un INNER JOIN).
-- Para hacer el ejercicio más representativo, primero vamos a añadir a más usuarios en "Usuarios":
INSERT INTO Usuarios (id, nombre, edad, ciudad_id)
VALUES (1, 'Fran', 35, 3),
		(3, 'Christian', 35, 3),
		(4, 'Manuel', 30, Null),
		(5, 'Jose Antonio', 34, Null);
		
-- Ahora realizamos la consulta:
SELECT Usuarios.nombre, Ciudades.nombre, Ciudades.pais FROM Usuarios
INNER JOIN Ciudades
ON Usuarios.ciudad_id = Ciudades.id;