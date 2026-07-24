SELECT * FROM clientes;
SELECT * FROM ventas;
SELECT * FROM categorias;
SELECT * FROM productos;

 --Consulta 1 — Vista base del proyecto (INNER JOIN) 
SELECT
	 v.fecha_venta,
	 c.nombre AS nombre_cliente,
	 c.ciudad,
	 p.nombre_producto,
	 cat.nombre_categoria,
	 v.cantidad,
	 v.precio_unitario,
	 (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN productos AS p
ON v.id_producto = p.id_producto

INNER JOIN clientes AS c
ON v.id_cliente = c.id_cliente

INNER JOIN categorias AS cat
ON p.id_categoria = cat.id_categoria;

--Consulta 2 — Clientes sin ventas (LEFT JOIN) 
SELECT
	 c.nombre AS nombre_cliente,
	 c.email,
	 c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;