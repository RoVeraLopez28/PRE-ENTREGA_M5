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

--Consulta 3 — Productos sin ventas (LEFT JOIN) 
SELECT	
	 p.nombre_producto,
	 c.nombre_categoria,
	 p.precio
FROM productos AS p
LEFT JOIN ventas AS v
ON p.id_producto = v.id_producto

INNER JOIN categorias AS c
ON p.id_categoria  = c.id_categoria
WHERE v.id_venta IS NULL;

-- =========================================================================
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- NOTA: Dado que la BD Ventas_Tech_DB no posee tablas separadas 
-- ni una columna 'canal', se simula la división de canales (Online/Presencial) 
-- utilizando el id_venta para poder demostrar el uso correcto de UNION ALL y GROUP BY.
-- =========================================================================

SELECT 
    canal, 
    SUM(total_venta) AS total_por_canal
FROM (
    -- Simulamos las ventas ONLINE (IDs del 1 al 5)
    SELECT 
        id_venta, 
        (cantidad * precio_unitario) AS total_venta, 
        'Online' AS canal
    FROM ventas
    WHERE id_venta <= 5

    UNION ALL

    -- Simulamos las ventas PRESENCIALES (IDs mayores a 5)
    SELECT 
        id_venta, 
        (cantidad * precio_unitario) AS total_venta, 
        'Presencial' AS canal
    FROM ventas
    WHERE id_venta > 5
) AS consolidado_ventas
GROUP BY canal;