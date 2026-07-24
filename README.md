## DECISIÓN SOBRE LA BASE DE DATOS UTILIZADA

En los módulos 1 y 2 se planteó un modelo de datos más completo para el proyecto RetailPro, que incluía información relacionada con territorios, segmentos de clientes, canales de venta y detalle de las operaciones.

Sin embargo, en el módulo 3 se proporcionó la base de datos Ventas_Tech_DB con una estructura simplificada, compuesta por las tablas ventas, clientes, productos y categorias. Esta misma base fue utilizada posteriormente para resolver las consultas del módulo 4.

Debido a que la consigna del presente módulo indica que el archivo debe incorporarse en la misma carpeta que los trabajos de M3 y M4, decidí mantener la continuidad con la base de datos proporcionada, en lugar de modificar su estructura o incorporar nuevas tablas pertenecientes al modelo diseñado en M2.

Esta decisión permite conservar la trazabilidad entre las entregas y evitar la creación de datos que no fueron proporcionados. Por este motivo, las consultas fueron desarrolladas utilizando la información realmente disponible y, cuando fue necesario, se documentaron las adaptaciones realizadas para responder a los requerimientos técnicos de la actividad.

Así queda claro que:

-CONSULTA 1 
La base de datos Ventas_Tech_DB proporcionada en el módulo 3 no contiene una tabla de territorios ni las columnas segmento, región o canal. 
Por este motivo, la consulta se adapta utilizando únicamente los campos disponibles. Se incluye la ciudad del cliente como información geográfica, 
aunque no representa una región o territorio, y se omiten los campos segmento y canal para evitar inventar información que no existe en la base. 
Esto se realiza a fin de seguir el hilo con m3 y m4. 

-CONSULTA 4
Al analizar la estructura de la base de datos Ventas_Tech_DB provista para el proyecto, noté que no existen tablas separadas para distintos canales de venta, 
ni tampoco una columna "canal" (Online/Presencial) en la tabla de hechos ventas que permitiera hacer la agrupación solicitada.
Para cumplir con los requerimientos técnicos de la rúbrica (el uso de UNION ALL y GROUP BY), tomé la decisión analítica de simular esta dimensión. 
El enfoque fue el siguiente:
-Dividí artificialmente la tabla ventas utilizando el id_venta para generar dos conjuntos de datos distintos.
-Creé una columna constante calculada ('Online' AS canal y 'Presencial' AS canal) en cada conjunto.
-Utilicé UNION ALL para apilar ambos conjuntos sin perder registros (evitando la eliminación de duplicados que haría un UNION normal).
-Envolví esta unión en una subconsulta temporal para poder aplicar correctamente el GROUP BY canal y sumar los totales.
De esta forma, demuestro el dominio técnico de los comandos solicitados aplicando una solución proactiva ante la falta de datos de origen.
