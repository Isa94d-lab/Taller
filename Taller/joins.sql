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
SELECT Pedidos.id AS id_pedido, Pedidos.fecha, Pedidos.total, Clientes.nombre AS nombre_cliente,
       Ubicaciones.direccion, Ubicaciones.ciudad, Ubicaciones.estado, Ubicaciones.codigo_postal, Ubicaciones.pais
FROM Pedidos
LEFT JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.tipo_entidad = 'Cliente';


-- 4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos (LEFT JOIN)
SELECT DatosEmpleados.id AS id_empleado, DatosEmpleados.nombre AS nombre_empleado, DatosEmpleados.salario,
       DatosEmpleados.fecha_contratacion, Pedidos.id AS id_pedido, Pedidos.fecha AS fecha_pedido, Pedidos.total AS total_pedido
FROM DatosEmpleados
LEFT JOIN Pedidos ON DatosEmpleados.id = Pedidos.empleado_id;


-- 5. Obtener el tipo de producto y los productos asociados con INNER JOIN
SELECT TiposProductos.tipo_nombre, Productos.nombre AS nombre_producto
FROM TiposProductos
INNER JOIN Productos ON Productos.tipo_id = TiposProductos.id;

-- 6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id, Clientes.nombre;


-- 7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos
SELECT DatosEmpleado.id AS id_empleado, DatosEmpleado.nombre AS nombre_empleado, Pedidos.id AS id_pedido
FROM DatosEmpleado
INNER JOIN Pedidos ON DatosEmpleado.id = Pedidos.empleado_id;


-- 8. Mostrar productos que no han sido pedidos (RIGHT JOIN)
SELECT Productos.id, Productos.nombre
FROM Productos
LEFT JOIN DetallesPedido ON Productos.id = DetallesPedido.producto_id
WHERE DetallesPedido.producto_id IS NULL;

-- 9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN

SELECT Clientes.id, Clientes.nombre, COUNT(Pedidos.id), Direcciones.direccion, Direcciones.ciudad, Direcciones.estado
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN ClientesDireccion ON Clientes.id = ClientesDireccion.cliente_id
LEFT JOIN Direcciones ON ClientesDireccion.direccion_id = Direcciones.id
GROUP BY Clientes.id, Clientes.nombre, Direcciones.direccion, Direcciones.ciudad, Direcciones.estado;



-- 10. Unir Proveedores, Productos y TiposProductos para un listado completo de inventario
SELECT Productos.nombre AS producto, TiposProductos.tipo_nombre, Proveedores.nombre AS proveedor
FROM Productos
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id;
 