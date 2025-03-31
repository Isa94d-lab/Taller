USE vtaszfs;

--1. Actualizar el precio de todos los productos de un proveedor

DELIMITER $$
CREATE PROCEDURE ActualizarPrecioProveedor(
    IN proveedorID INT,
    IN porcentaje DECIMAL(5,2)
)
BEGIN
    UPDATE Productos
    SET precio = precio * (1 + porcentaje / 100)
    WHERE proveedor_id = proveedorID;
END $$
DELIMITER ;

--Prueba
CALL ActualizarPrecioProveedor(1, 10);
SELECT * FROM Productos WHERE proveedor_id = 1;

--2. Obtener la dirección de un cliente por ID

DELIMITER $$
CREATE PROCEDURE ObtenerDireccionCliente(
    IN clienteID INT
)
BEGIN
    SELECT d.direccion, d.ciudad, d.estado, d.codigo_postal, d.pais
    FROM Direcciones d
    INNER JOIN ClientesDireccion cd ON d.id = cd.direccion_id
    WHERE cd.cliente_id = clienteID;
END $$
DELIMITER ;

--Prueba
CALL ObtenerDireccionCliente(5);

--3. Registrar un pedido nuevo y sus detalles

DELIMITER $$
CREATE PROCEDURE RegistrarPedido(
    IN clienteID INT,
    IN empleadoID INT,
    IN fechaPedido DATE,
    IN totalPedido DECIMAL(10,2)
)
BEGIN
    INSERT INTO Pedidos (cliente_id, empleado_id, fecha, total)
    VALUES (clienteID, empleadoID, fechaPedido, totalPedido);
    
    SELECT LAST_INSERT_ID() AS nuevo_pedido_id;
END $$
DELIMITER ;

--Prueba
CALL RegistrarPedido(3, 2, '2025-03-30', 500.00);

--4. Calcular el total de ventas de un cliente

DELIMITER $$
CREATE PROCEDURE TotalVentasCliente(
    IN clienteID INT
)
BEGIN
    SELECT cliente_id, SUM(total) AS total_ventas
    FROM Pedidos
    WHERE cliente_id = clienteID
    GROUP BY cliente_id;
END $$
DELIMITER ;

--Prueba
CALL TotalVentasCliente(3);

--5. Obtener empleados por puesto

DELIMITER $$
CREATE PROCEDURE ObtenerEmpleadosPorPuesto(
    IN puestoID INT
)
BEGIN
    SELECT e.id, e.nombre, e.salario, e.fecha_contratacion
    FROM Empleados e
    INNER JOIN DatosEmpleado de ON e.id = de.id
    WHERE de.puesto_id = puestoID;
END $$
DELIMITER ;

--Prueba
CALL ObtenerEmpleadosPorPuesto(2);

--6. Actualizar el salario de empleados por puesto

DELIMITER $$
CREATE PROCEDURE ActualizarSalarioPorPuesto(
    IN puestoID INT,
    IN porcentaje DECIMAL(5,2)
)
BEGIN
    UPDATE Empleados e
    INNER JOIN DatosEmpleado de ON e.id = de.id
    SET e.salario = e.salario * (1 + porcentaje / 100)
    WHERE de.puesto_id = puestoID;
END $$
DELIMITER ;

--Prueba
CALL ActualizarSalarioPorPuesto(2, 5);
SELECT * FROM Empleados;


--7. Listar pedidos entre dos fechas

DELIMITER $$
CREATE PROCEDURE ListarPedidosEntreFechas(
    IN fechaInicio DATE,
    IN fechaFin DATE
)
BEGIN
    SELECT * FROM Pedidos
    WHERE fecha BETWEEN fechaInicio AND fechaFin;
END $$
DELIMITER ;

--Prueba
CALL ListarPedidosEntreFechas('2025-03-01', '2025-03-30');

--8. Aplicar un descuento a productos de una categoría

DELIMITER $$
CREATE PROCEDURE AplicarDescuentoCategoria(
    IN categoriaID INT,
    IN porcentaje DECIMAL(5,2)
)
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - porcentaje / 100)
    WHERE tipo_id = categoriaID;
END $$
DELIMITER ;

--Prueba
CALL AplicarDescuentoCategoria(1, 15);
SELECT * FROM Productos WHERE tipo_id = 1;

--9. Listar todos los proveedores de un tipo de producto

DELIMITER $$
CREATE PROCEDURE ListarProveedoresPorTipoProducto(
    IN tipoProductoID INT
)
BEGIN
    SELECT DISTINCT p.id, p.nombre
    FROM Proveedores p
    INNER JOIN Productos pr ON p.id = pr.proveedor_id
    WHERE pr.tipo_id = tipoProductoID;
END $$
DELIMITER ;

--Prueba
CALL ListarProveedoresPorTipoProducto(3);

--10. Obtener el pedido de mayor valor

DELIMITER $$
CREATE PROCEDURE PedidoMayorValor()
BEGIN
    SELECT * FROM Pedidos
    ORDER BY total DESC
    LIMIT 1;
END $$
DELIMITER ;

--Prueba
CALL PedidoMayorValor();