USE vtaszfs ;

-- 1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN
SELECT Pedidos.id, Clientes.nombre AS cliente, Pedidos.fecha, Pedidos.total
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id;

-- 2. Listar los productos y proveedores que los suministran con INNER JOIN
SELECT Productos.nombre AS producto, Proveedores.nombre AS proveedor
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id;

-- 3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN
SELECT p.id AS pedido_id, p.fecha, p.total, c.nombre AS cliente_nombre, u.direccion, u.ciudad, u.estado, u.codigo_postal, u.pais
FROM Pedidos p
LEFT JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN Ubicaciones u ON c.id = u.entidad_id AND u.tipo_entidad = 'Cliente';


-- 4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos (LEFT JOIN)
SELECT e.id AS empleado_id, e.nombre AS empleado_nombre, e.salario, e.fecha_contratacion, p.id AS pedido_id, p.fecha AS fecha_pedido, p.total AS total_pedido
FROM DatosEmpleados e
LEFT JOIN Pedidos p ON e.id = p.cliente_id;
 

-- 5. Obtener el tipo de producto y los productos asociados con INNER JOIN
SELECT TiposProductos.tipo_nombre, Productos.nombre AS producto
FROM TiposProductos
INNER JOIN Productos ON Productos.tipo_id = TiposProductos.id;

-- 6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id, Clientes.nombre;

-- 7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos
SELECT Empleados_Pedidos.empleado_id, DatosEmpleados.nombre , Empleados_Pedidos.pedido_id 
FROM DatosEmpleados
INNER JOIN Empleados_Pedidos ON DatosEmpleados.id = Empleados_Pedidos.empleado_id;


-- 8. Mostrar productos que no han sido pedidos (RIGHT JOIN)
SELECT Productos.id, Productos.nombre
FROM Productos
LEFT JOIN DetallesPedido ON Productos.id = DetallesPedido.producto_id
WHERE DetallesPedido.producto_id IS NULL;

-- 9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN

SELECT Clientes.id, Clientes.nombre, COUNT(Pedidos.id), Ubicaciones.direccion, Ubicaciones.ciudad, Ubicaciones.estado
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
    AND Ubicaciones.tipo_entidad = 'Cliente'
GROUP BY Clientes.id, Clientes.nombre, Ubicaciones.direccion, Ubicaciones.ciudad, Ubicaciones.estado;



-- 10. Unir Proveedores, Productos y TiposProductos para un listado completo de inventario
SELECT Productos.nombre AS producto, TiposProductos.tipo_nombre, Proveedores.nombre AS proveedor
FROM Productos
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id;
 