-- 1. Crea una tabla llamada "Productos" con las columnas: "id" (entero, clave
-- primaria), "nombre" (texto) y "precio" (numérico).
CREATE TABLE IF NOT EXISTS Productos(
	id INT PRIMARY KEY,
	nombre VARCHAR(255),
	precio NUMERIC
);

-- 2. Inserta al menos cinco registros en la tabla "Productos".
INSERT INTO Productos (id, nombre, precio)
VALUES 	(1, 'Neopreno de triatlón', 359.85),
		(2, 'Tritraje larga distancia', 123.34),
		(3, 'Bicicleta aero', 2994.37),
		(4, 'Casco aero', 247.57),
		(5, 'Pack12 barritas energéticas', 18.27);
		
-- 3. Actualiza el precio de un producto en la tabla "Productos".
UPDATE Productos
SET precio = 21.42
WHERE id = 5;

-- 4. Elimina un producto de la tabla "Productos".
DELETE FROM Productos
WHERE nombre = 'Bicicleta aero';

-- 5. Realiza una consulta que muestre los nombres de los usuarios junto con los
-- nombres de los productos que han comprado (utiliza un INNER JOIN con la
-- tabla "Productos").
-- PRIMERO: Creamos una tabla de usuarios y añadimos algunos.
CREATE TABLE IF NOT EXISTS usuarios (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255));
	
INSERT INTO usuarios (nombre)
VALUES ('Ana'), ('Fran'), ('Manuel');

-- SEGUNDO: Creamos la tabla de "pedidos", la relacionamos con "usuarios" y "Productos" y añadimos algunos pedidos.
-- Como Productos.nombre no está definida como PRIMARY KEY ni UNIQUE, hay que definir dicha columna como valores únicos
-- antes de definir la cláve foránea entre Pedidos.producto y Productos.nombre o tendremos un error de ejecución de
-- código.
ALTER TABLE Productos
ADD CONSTRAINT nombre_producto_unico UNIQUE (nombre);

CREATE TABLE IF NOT EXISTS pedidos(
	id SERIAL PRIMARY KEY,
	nombre_cliente VARCHAR(255),
	producto VARCHAR(255),
	cantidad INT,
	id_cliente INT,
	CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES usuarios(id),
	nombre_producto VARCHAR(255),
	CONSTRAINT fk_nombre_producto FOREIGN KEY (nombre_producto) REFERENCES Productos(nombre)
);

INSERT INTO pedidos (nombre_cliente, id_cliente, nombre_producto, cantidad)
VALUES ('Ana', 1, 'Casco aero', 2),
		('Ana', 1, 'Pack12 barritas energéticas', 1),
		('Manuel', 3, 'Tritraje larga distancia', 2),
		('Fran', 2, 'Neopreno de triatlón', 3);
	
-- Por último realizamos la consulta:
SELECT Pedidos.nombre_cliente, productos.nombre FROM pedidos
INNER JOIN productos
ON pedidos.nombre_producto = Productos.nombre;