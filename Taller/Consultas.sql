--consultas simples

USE vtaszfs;

-- 1. Seleccionar todos los productos con precio mayor a $50
SELECT id, nombre, precio, proveedor_id, tipo_id
FROM Productos 
WHERE precio > 50;



-- 2. Consultar clientes registrados en una ciudad específica
SELECT Clientes.nombre, Clientes.email, Direcciones.ciudad
FROM Clientes
INNER JOIN ClientesDireccion ON Clientes.id = ClientesDireccion.cliente_id
INNER JOIN Direcciones ON ClientesDireccion.direccion_id = Direcciones.id
WHERE Direcciones.ciudad = 'Bogotá' ;

-- 3. Mostrar empleados contratados en los últimos 2 años
SELECT nombre, salario, fecha_contratacion
FROM DatosEmpleado
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 4. Seleccionar proveedores que suministran más de 5 productos
SELECT Proveedores.id, Proveedores.nombre, COUNT(Productos.id) AS total_productos
FROM Proveedores 
INNER JOIN Productos ON Proveedores.id = Productos.proveedor_id
GROUP BY Proveedores.id, Proveedores.nombre
HAVING total_productos > 5;

-- 5. Listar clientes que no tienen dirección registrada en Ubicaciones
SELECT Clientes.id, Clientes.nombre, Clientes.email
FROM Clientes 
LEFT JOIN ClientesDireccion ON Clientes.id = ClientesDireccion.cliente_id
WHERE ClientesDireccion.id IS NULL;

-- 6. Calcular el total de ventas por cada cliente
SELECT Clientes.id, Clientes.nombre, SUM(Pedidos.total) AS total_ventas
FROM Clientes
JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id, Clientes.nombre;


-- 7. Mostrar el salario promedio de los empleados
SELECT AVG(salario) AS salario_promedio 
FROM DatosEmpleado;

-- 8. Consultar el tipo de productos disponibles en TiposProductos
SELECT tipo_nombre, descripcion 
FROM TiposProductos;

-- 9. Seleccionar los 3 productos más caros
SELECT id, nombre, precio proveedor_id, tipo_id
FROM Productos 
ORDER BY precio DESC 
LIMIT 3;