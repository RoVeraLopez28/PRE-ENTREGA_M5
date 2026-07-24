SELECT * FROM ventas;

--CONSULTA 1 - RESUMEN EJECUTIVO MENSUAL
SELECT
	EXTRACT(MONTH FROM fecha_venta) AS mes,
	SUM(precio_unitario * cantidad) AS total_facturado,
	COUNT(id_venta) AS cantidad_pedidos,
	ROUND(AVG(precio_unitario * cantidad)) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta);

--Consulta 2 — Ranking de productos
SELECT
	 id_producto,
	 SUM(cantidad) AS unidades_vendidas,
	 SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

--Consulta 3 — Clientes recurrentes
SELECT
	 id_cliente,
	 COUNT(*) AS cantidad_pedidos,
	 SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--Consulta 4 — Meses por encima/por debajo del promedio
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT EXTRACT(MONTH FROM fecha_venta)) FROM ventas) 
        THEN 'Por encima'
        WHEN SUM(cantidad * precio_unitario) < (SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT EXTRACT(MONTH FROM fecha_venta)) FROM ventas) THEN 'Por debajo'
		ELSE 'Igual'
    END AS rendimiento_mensual
FROM ventas
GROUP BY 
	 EXTRACT(YEAR FROM fecha_venta),
	 EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

/*
Conclusiones encontradas:

- El producto 1 es el que mayor facturación generó, con un total de 3600 y 3 unidades vendidas.

- Todos los clientes registrados son recurrentes, ya que cada uno realizó 2 pedidos.

- Marzo registró una facturación total de 6444 y aparece igual al promedio mensual, debido a que todos los registros disponibles corresponden a ese mismo mes.
*/
