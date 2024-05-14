-- Ejercicio 1
-- 1. Crear una tabla llamada "Clientes" con las columnas: id (entero, clave primaria), nombre (texto) y email (texto).
CREATE TABLE IF NOT EXISTS public.Clientes (
	id INT PRIMARY KEY,
	nombre VARCHAR(255),
	email VARCHAR(255)
);

-- 2. Insertar un nuevo cliente en la tabla "Clientes" con id=1, nombre="Juan" y email="juan@example.com".
INSERT INTO public.Clientes (id, nombre, email)
VALUES (1, 'Juan', 'juan@example.com');

-- 3. Actualizar el email del cliente con id=1 a "juan@gmail.com".
UPDATE public.Clientes
SET email = 'juan@gmail.com'
WHERE id = 1;

-- 4. Eliminar el cliente con id=1 de la tabla "Clientes".
DELETE FROM public.Clientes
WHERE id = 1;

-- 5. Crear una tabla llamada "Pedidos" con las columnas: id (entero, clave primaria),
-- cliente_id (entero, clave externa referenciando a la tabla "Clientes"), producto
-- (texto) y cantidad (entero).

CREATE TABLE IF NOT EXISTS public.Pedidos (
	id INT PRIMARY KEY,
	cliente_id INT,
	FOREIGN KEY (cliente_id) REFERENCES public.Clientes(id),
	producto VARCHAR(255),
	cantidad INT
);

-- 6. Insertar un nuevo pedido en la tabla "Pedidos" con id=1, cliente_id=1,
-- producto="Camiseta" y cantidad=2.

-- Para poder insertar un pedido con cliente_id = 1 tiene que existir necesariamente un registro en "Clientes" con id = 1,
-- dado que ambos campos están relacionados con la clave foránea.

-- Volviendo a insertar el cliente con id = 1:
INSERT INTO public.Clientes (id, nombre, email)
VALUES (1, 'Juan', 'juan@gmail.com');

-- Insertando ahora el nuevo pedido:
INSERT INTO public.Pedidos (id, cliente_id, producto, cantidad)
VALUES (1, 1, 'Camiseta', 2);

-- 7. Actualizar la cantidad del pedido con id=1 a 3.
UPDATE public.Pedidos
SET cantidad = 3
WHERE id = 1;

-- 8. Eliminar el pedido con id=1 de la tabla "Pedidos".
DELETE FROM public.Pedidos
WHERE id = 1;

-- 9. Crear una tabla llamada "Productos" con las columnas: id (entero, clave
-- primaria), nombre (texto) y precio (decimal).
CREATE TABLE IF NOT EXISTS public.Productos (
	id INT PRIMARY KEY,
	nombre VARCHAR(255) UNIQUE, -- Aunque no es necesario para el apartado 9, será necesario que este dato sea de tipo
								-- único para que no haya mensaje de error cuando en el apartado 19 nos pidan utilizar
								-- la columna nombre como clave foránea.
	precio DECIMAL
);

-- 10. Insertar varios productos en la tabla "Productos" con diferentes valores.
INSERT INTO public.Productos (id, nombre, precio)
VALUES (1, 'Tritraje de triatlón, corta distancia', 88),
	   (2, 'Neopreno de triatlón Orca Equip', 100),
	   (3, 'Gorra triatlón', 20),
	   (4, 'Crema facial', 6.55),
	   (5, 'Dentrífico bucal', 4.82),
	   (6, 'Set de bolígrafos', 4.45),
	   (7, 'Store 3x4m', 89.99),
	   (8, 'Camiseta', 12);

-- 11. Consultar todos los clientes de la tabla "Clientes".
SELECT * FROM public.Clientes;

-- 12. Consultar todos los pedidos de la tabla "Pedidos" junto con los nombres de los
-- clientes correspondientes.

-- Primero volvemos a añadir un pedido en "Pedidos", dado que lo eliminamos previamente.
INSERT INTO public.Pedidos (id, cliente_id, producto, cantidad)
VALUES (1, 1, 'Camiseta', 3);

-- Ahora leemos los datos:
SELECT pds.id, pds.cliente_id, pds.producto, pds.cantidad, clt.nombre FROM public.Pedidos pds
LEFT JOIN public.Clientes clt
ON pds.cliente_id = clt.id;

-- 13. Consultar los productos de la tabla "Productos" cuyo precio sea mayor a $50.
SELECT * FROM public.Productos
WHERE precio > 50;

-- 14. Consultar los pedidos de la tabla "Pedidos" que tengan una cantidad mayor o
-- igual a 5.

-- El último pedido realizado era sólo de una cantidad de 3, por lo que no aparecería ningún pedido en la consulta.
-- Primero añadidos varios pedidos, uno inferior a  5 uds, igual a 5 y otro superior a 5 para comprobar que la consulta
-- funciona correctamente.
INSERT INTO public.Pedidos (id, cliente_id, producto, cantidad)
VALUES (2, 1, 'Neopreno de triatlón Orca Equip', 1),
		(3, 1, 'Gorra triatlón', 6),
		(4, 1, 'Tritraje de triatlón, corta distancia', 5);
-- Ahora realizamos la consulta:
SELECT * FROM public.Pedidos
WHERE cantidad >= 5;

-- 15. Consultar los clientes de la tabla "Clientes" cuyo nombre empiece con la letra "A".
-- Sólo tenemos un cliente llamado 'Juan'. Vamos a introducir más clientes para que la consulta lea al menos un cliente
-- que comience por la letra "A".
INSERT INTO public.Clientes (id, nombre, email)
VALUES (2, 'Ana', 'email_de_ana@gmail.com'),
		(3, 'Helena', 'email_de_helena.com'),
		(4, 'azucena', 'email_de_azucena');

-- La consulta:
SELECT clt.nombre FROM public.Clientes clt
WHERE nombre LIKE 'A%';

-- 16. Realizar una consulta que muestre el nombre del cliente y el total de pedidos
-- realizados por cada cliente.
-- Vamos a añadir primero unos cuantos pedidos más.
INSERT INTO public.Pedidos (id, cliente_id, producto, cantidad)
VALUES (5, 2, 'Crema facial', 1),
		(6, 2, 'Dentrífico bucal', 2),
		(7, 3, 'Set de bolígrafos', 1),
		(8, 4, 'Store 3x4m', 2),
		(9, 4, 'Camiseta', 3),
		(10, 4, 'Crema facial', 1);

-- Realizamos la consulta:
SELECT clt.nombre, COUNT(pds.cliente_id) AS total_pedidos_cliente FROM public.Clientes clt
LEFT JOIN public.Pedidos pds
ON pds.cliente_id = clt.id
GROUP BY nombre;

-- 17. Realizar una consulta que muestre el nombre del producto y la cantidad total de
-- pedidos de ese producto.
SELECT pdr.nombre, SUM(pds.cantidad) AS total_uds_producto FROM public.Productos pdr
LEFT JOIN public.Pedidos pds
ON pdr.nombre = pds.producto
GROUP BY nombre
ORDER BY total_uds_producto DESC;

-- 18. Agregar una columna llamada "fecha" a la tabla "Pedidos" de tipo fecha.
ALTER TABLE public.Pedidos
ADD COLUMN fecha DATE;

-- 19. Agregar una clave externa a la tabla "Pedidos" que haga referencia a la tabla
-- "Productos" en la columna "producto".
ALTER TABLE public.Pedidos
ADD CONSTRAINT fk_producto FOREIGN KEY (producto) REFERENCES public.Productos(nombre);

-- 20. Realizar una consulta que muestre los nombres de los clientes, los nombres de
-- los productos y las cantidades de los pedidos donde coincida la clave externa.
SELECT clt.nombre, pds.producto, pds.cantidad FROM public.Clientes clt
LEFT JOIN public.Pedidos pds
ON clt.id = pds.cliente_id;