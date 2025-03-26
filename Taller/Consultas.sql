--consultas simples

USE vtaszfs

-- 1. Seleccionar todos los productos con precio mayor a $50
SELECT * 
FROM Productos 
WHERE precio > 50;


-- 2. Consultar clientes registrados en una ciudad específica
SELECT c.* 
FROM Clientes c
JOIN Ubicaciones u ON c.id = u.entidad_id
WHERE u.tipo_entidad = 'Cliente' 
AND u.ciudad = 'Ciudad_Especifica';

-- 3. Mostrar empleados contratados en los últimos 2 años
SELECT * 
FROM DatosEmpleados 
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 4. Seleccionar proveedores que suministran más de 5 productos
SELECT p.id, p.nombre, COUNT(prod.id) AS total_productos
FROM Proveedores p
JOIN Productos prod ON p.id = prod.proveedor_id
GROUP BY p.id
HAVING total_productos > 5;

-- 5. Listar clientes que no tienen dirección registrada en Ubicaciones
SELECT c.*
FROM Clientes c
LEFT JOIN Ubicaciones u ON c.id = u.entidad_id AND u.tipo_entidad = 'Cliente'
WHERE u.id IS NULL;

-- 6. Calcular el total de ventas por cada cliente
SELECT c.id, c.nombre, SUM(p.total) AS total_ventas
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre;

-- 7. Mostrar el salario promedio de los empleados
SELECT AVG(salario) AS salario_promedio 
FROM DatosEmpleados;

-- 8. Consultar el tipo de productos disponibles en TiposProductos
SELECT tipo_nombre, descripcion 
FROM TiposProductos;

-- 9. Seleccionar los 3 productos más caros
SELECT * 
FROM Productos 
ORDER BY precio DESC 
LIMIT 3;