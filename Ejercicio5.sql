-- 1. Crea una tabla llamada "Clientes" con las columnas id (entero) y nombre
-- (cadena de texto).
CREATE TABLE IF NOT EXISTS Clientes (
	id INT,
	nombre VARCHAR(255)
);

-- 2. Inserta un cliente con id=1 y nombre='John' en la tabla "Clientes".
INSERT INTO Clientes (id, nombre)
VALUES (1, 'John');

-- 3. Actualiza el nombre del cliente con id=1 a 'John Doe' en la tabla "Clientes".
UPDATE Clientes
SET nombre = 'John Doe'
WHERE id = 1;

-- 4. Elimina el cliente con id=1 de la tabla "Clientes".
DELETE FROM Clientes
WHERE id = 1;

-- 5. Lee todos los clientes de la tabla "Clientes".
SELECT * FROM Clientes;

-- 6. Crea una tabla llamada "Pedidos" con las columnas id (entero) y cliente_id
-- (entero).
CREATE TABLE IF NOT EXISTS Pedidos (
	id INT,
	cliente_id INT
);

-- 7. Inserta un pedido con id=1 y cliente_id=1 en la tabla "Pedidos".
INSERT INTO Pedidos (id, cliente_id)
VALUES (1, 1);

-- 8. Actualiza el cliente_id del pedido con id=1 a 2 en la tabla "Pedidos".
UPDATE Pedidos
SET cliente_id = 2
WHERE id = 1;

-- 9. Elimina el pedido con id=1 de la tabla "Pedidos".
DELETE FROM Pedidos
WHERE id = 1;

-- 10. Lee todos los pedidos de la tabla "Pedidos".
SELECT * FROM Pedidos;

-- 11. Crea una tabla llamada "Productos" con las columnas id (entero) y nombre
-- (cadena de texto).
CREATE TABLE IF NOT EXISTS Productos (
	id INT,
	nombre VARCHAR(255)
);

-- 12. Inserta un producto con id=1 y nombre='Camisa' en la tabla "Productos".
INSERT INTO Productos (id, nombre)
VALUES (1, 'Camisa');

-- 13. Actualiza el nombre del producto con id=1 a 'Pantalón' en la tabla "Productos".
UPDATE Productos
SET nombre = 'Pantalón'
WHERE id = 1;

-- 14. Elimina el producto con id=1 de la tabla "Productos".
DELETE FROM Productos
WHERE id = 1;

-- 15. Lee todos los productos de la tabla "Productos".
SELECT * FROM Productos;

-- 16. Crea una tabla llamada "DetallesPedido" con las columnas pedido_id (entero) y
-- producto_id (entero).
CREATE TABLE IF NOT EXISTS DetallesPedido (
	pedido_id INT,
	producto_id INT
);

-- 17. Inserta un detalle de pedido con pedido_id=1 y producto_id=1 en la tabla
-- "DetallesPedido".
INSERT INTO DetallesPedido (pedido_id, producto_id)
VALUES (1, 1);

-- 18. Actualiza el producto_id del detalle de pedido con pedido_id=1 a 2 en la tabla
-- "DetallesPedido".
UPDATE DetallesPedido
SET producto_id = 2
WHERE pedido_id = 1;

-- 19. Elimina el detalle de pedido con pedido_id=1 de la tabla "DetallesPedido".
DELETE FROM DetallesPedido
WHERE pedido_id = 1;

-- 20. Lee todos los detalles de pedido de la tabla "DetallesPedido".
SELECT * FROM DetallesPedido;

-- 21. Realiza una consulta para obtener todos los clientes y sus pedidos
-- correspondientes utilizando un inner join.
-- PRIMERO: Vamos a añadir unos datos mínimos a las tablas Clientes y Pedidos, dado que ambas están vacías.
INSERT INTO Clientes (id, nombre)
VALUES	(1, 'Ana'),
		(2, 'Fran'),
		(3, 'Manuel'),
		(4, 'Carlos'),
		(5, 'María'),
		(6, 'Fernando'),
		(7, 'Emi'),
		(8, 'Emilia'),
		(9, 'Fernando'),
		(10, 'Amparo'),
		(11, 'Paco');

INSERT INTO Pedidos (id, cliente_id)
VALUES	(1 , 1),
		(2, 3),
		(3 , 5),
		(4 , 7),
		(5 , 9),
		(6 , 11);

-- SEGUNDO: Añadimos la restricción de cláve foránea para clientes.id y pedidos.cliente_id. Para ello hay que
-- convertir la columna clientes.id a valor único, por ejemplo con PRIMARY KEY o UNIQUE. Tiene que ser con UNIQUE, cuando
-- una columna se define cómo "id" ya que parece adquirir una seudo condición de clave primaria y nos aparecerá un mensaje
-- de que hay una especie de restricción existente.
ALTER TABLE Clientes
ADD CONSTRAINT id_unique UNIQUE (id);
-- Añadimos la clave foránea a la tabla secundaria "Pedidos".
ALTER TABLE Pedidos
ADD CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id);
-- POR ÚLTIMO: Realizamos la consulta.
SELECT Clientes.nombre, Pedidos.id AS id_pedido FROM Clientes
INNER JOIN Pedidos
ON Clientes.id = Pedidos.cliente_id;

-- 22. Realiza una consulta para obtener todos los clientes y sus pedidos
-- correspondientes utilizando un left join.
SELECT Clientes.nombre, Pedidos.id AS id_pedido FROM Clientes
LEFT JOIN Pedidos
ON Clientes.id = Pedidos.cliente_id
ORDER BY Pedidos.id;

-- 23. Realiza una consulta para obtener todos los productos y los detalles de pedido
-- correspondientes utilizando un inner join.
-- PRIMERO: Vamos a añadir unos datos mínimos a las tablas Productos y DetallesPedido, dado que ambas están vacías.
INSERT INTO Productos (id, nombre)
VALUES	(1, 'Chocolate negro'),
		(2, 'Sidra'),
		(3, 'Agua mineral'),
		(4, 'Cereales bebé'),
		(5, 'Pan integral'),
		(6, 'Aguacates'),
		(7, 'Papel higiénico'),
		(8, 'Crema de cacahuete'),
		(9, 'Yogures de cabra'),
		(10, 'Leche de soja'),
		(11, 'Maíz dulce'),
		(12, 'Aquarius'),
		(13, 'Brócoli'),
		(14, 'Calabacín');

INSERT INTO DetallesPedido (pedido_id, producto_id)
VALUES 	(1 , 14),
		(2, 14),
		(3 , 14),
		(4 , 8),
		(5 , 6),
		(6 , 4);

-- SEGUNDO: Añadimos dos restricciones de cláve foránea para DetallesPedido.pedido_id y DetallesPedido.producto_id. Para ello
-- hay que convertir la columna Pedidos.id y Productos.id a valor único, por ejemplo con PRIMARY KEY o UNIQUE. Tiene que ser
-- con UNIQUE, cuando una columna se define cómo "id" ya que parece adquirir una seudo condición de clave primaria y nos
-- aparecerá un mensaje de que hay una especie de restricción existente.
ALTER TABLE Pedidos
ADD CONSTRAINT pedido_id_unique UNIQUE (id);
ALTER TABLE Productos
ADD CONSTRAINT producto_id_unique UNIQUE (id);
-- Añadimos las 2 claves foráneas a la tabla secundaria "DetallesPedido".
ALTER TABLE DetallesPedido
ADD CONSTRAINT fk_pedido_id FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
ADD CONSTRAINT fk_producto_id FOREIGN KEY (producto_id) REFERENCES Productos(id);
-- POR ÚLTIMO: Realizamos la consulta.
SELECT Productos.nombre, DetallesPedido.pedido_id FROM Productos
INNER JOIN DetallesPedido
ON DetallesPedido.producto_id = Productos.id;

-- 24. Realiza una consulta para obtener todos los productos y los detalles de pedido
-- correspondientes utilizando un left join.
SELECT Productos.nombre, DetallesPedido.* FROM Productos
LEFT JOIN DetallesPedido
ON DetallesPedido.producto_id = Productos.id;

-- 25. Crea una nueva columna llamada "telefono" de tipo cadena de texto en la tabla
-- "Clientes".
ALTER TABLE Clientes
ADD COLUMN telefono VARCHAR(255);

-- 26. Modifica la columna "telefono" en la tabla "Clientes" para cambiar su tipo de
-- datos a entero.
ALTER TABLE Clientes
ALTER COLUMN telefono TYPE INT
USING telefono::integer;

-- 27. Elimina la columna "telefono" de la tabla "Clientes".
ALTER TABLE Clientes
DROP telefono;

-- 28. Cambia el nombre de la tabla "Clientes" a "Usuarios".
ALTER TABLE Clientes RENAME TO Usuarios;

-- 29. Cambia el nombre de la columna "nombre" en la tabla "Usuarios" a
-- "nombre_completo".
ALTER TABLE Usuarios
RENAME COLUMN nombre TO nombre_completo;

-- 30. Agrega una restricción de clave primaria a la columna "id" en la tabla "Usuarios.
ALTER TABLE Usuarios
ADD CONSTRAINT id_to_primary_key PRIMARY KEY (id);