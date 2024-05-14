-- 1. Crea una tabla llamada "Pedidos" con las columnas: "id" (entero, clave
-- primaria), "id_usuario" (entero, clave foránea de la tabla "Usuarios") y
-- "id_producto" (entero, clave foránea de la tabla "Productos").

-- Vamos a traernos el código del ejercicio 3 dónde definíamos las tablas "Usuarios" y "Productos".
CREATE TABLE IF NOT EXISTS usuarios (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255));
	
INSERT INTO usuarios (nombre)
VALUES ('Ana'), ('Fran'), ('Manuel');

CREATE TABLE IF NOT EXISTS Productos(
	id INT PRIMARY KEY,
	nombre VARCHAR(255),
	precio NUMERIC
);
INSERT INTO Productos (id, nombre, precio)
VALUES 	(1, 'Neopreno de triatlón', 359.85),
		(2, 'Tritraje larga distancia', 123.34),
		(3, 'Bicicleta aero', 2994.37),
		(4, 'Casco aero', 247.57),
		(5, 'Pack12 barritas energéticas', 18.27);

--Creamos la tabla "Pedidos".
CREATE TABLE IF NOT EXISTS Pedidos(
	id INT PRIMARY KEY,
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
	id_producto INT,
	FOREIGN KEY (id_producto) REFERENCES Productos(id)
);

-- 2. Inserta al menos tres registros en la tabla "Pedidos" que relacionen usuarios con
-- productos.
INSERT INTO Pedidos
VALUES	(1, 3, 4),
		(2, 1, 5),
		(3, 3, 3);

-- 3. Realiza una consulta que muestre los nombres de los usuarios y los nombres de
-- los productos que han comprado, incluidos aquellos que no han realizado
-- ningún pedido (utiliza LEFT JOIN y COALESCE).
SELECT usuarios.nombre, COALESCE(productos.nombre, '0') AS nombre_producto FROM usuarios
LEFT JOIN pedidos
ON usuarios.id = pedidos.id_usuario
LEFT JOIN productos
ON pedidos.id_producto = productos.id
ORDER BY usuarios.nombre DESC;

-- 4. Realiza una consulta que muestre los nombres de los usuarios que han
-- realizado un pedido, pero también los que no han realizado ningún pedido
-- (utiliza LEFT JOIN).
SELECT usuarios.nombre, COALESCE(CAST(pedidos.id AS VARCHAR(255)), 'Sin pedido') AS id_pedido FROM usuarios
LEFT JOIN pedidos
ON usuarios.id = pedidos.id_usuario
ORDER BY usuarios.nombre ASC;

-- 5. Agrega una nueva columna llamada "cantidad" a la tabla "Pedidos" y actualiza
-- los registros existentes con un valor (utiliza ALTER TABLE y UPDATE)
ALTER TABLE Pedidos
ADD COLUMN cantidad INT;

UPDATE Pedidos
SET cantidad = 
	CASE
		WHEN id = 1 THEN 2
		WHEN id = 2 THEN 3
		WHEN id = 3 THEN 4
	END
WHERE id IN (1, 2, 3);