-- 1. Funcion que recibe una fecha y devuelve los dias transcurridos hasta hoy.
DELIMITER //
CREATE FUNCTION DiasTranscurridos(fecha DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(CURDATE(), fecha);
END//
DELIMITER ;

--------------------------------------------------

-- 2. Funcion para calcular el total con impuesto de un monto.
DELIMITER //
CREATE FUNCTION TotalConImpuesto(monto DECIMAL(10,2), tasa_impuesto DECIMAL(5,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monto + (monto * tasa_impuesto);
END//
DELIMITER ;

--------------------------------------------------

-- 3. Funcion que devuelve el total de pedidos de un cliente especifico.
DELIMITER //
CREATE FUNCTION TotalPedidosCliente(cliente INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Pedidos WHERE cliente_id = cliente;
    RETURN total;
END//
DELIMITER ;

--------------------------------------------------

-- 4. Funcion para aplicar un descuento a un producto.
CREATE FUNCTION PrecioConDescuento(precio DECIMAL(10,2), descuento DECIMAL(5,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN precio - (precio * descuento);
END//
DELIMITER ;

--------------------------------------------------

-- 5. Funcion que indica si un cliente tiene direccion registrada en la tabla Ubicaciones.
DELIMITER //
CREATE FUNCTION ClienteTieneDireccion(cliente INT) RETURNS TINYINT
DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe 
    FROM Ubicaciones 
    WHERE entidad_id = cliente AND tipo_entidad = 'Cliente';
    RETURN IF(existe > 0, 1, 0);
END//
DELIMITER ;

--------------------------------------------------

-- 6. Funcion que devuelve el salario anual de un empleado.
DELIMITER //
CREATE FUNCTION SalarioAnual(empleado INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE salario DECIMAL(10,2);
    SELECT salario INTO salario FROM DatosEmpleados WHERE id = empleado;
    RETURN salario * 12;
END//
DELIMITER ;

--------------------------------------------------

-- 7. Funcion para calcular el total de ventas de un tipo de producto.
DELIMITER //
CREATE FUNCTION VentasPorTipo(tipo INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(dp.cantidad * p.precio),0)
    INTO total
    FROM DetallesPedido dp
    JOIN Productos p ON dp.producto_id = p.id
    WHERE p.tipo_id = tipo;
    RETURN total;
END//
DELIMITER ;

--------------------------------------------------

-- 8. Funcion que devuelve el nombre de un cliente por su ID.
DELIMITER //
CREATE FUNCTION NombreClientePorID(cliente INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT c.nombre INTO nombre FROM Clientes c WHERE c.id = cliente;
    RETURN nombre;
END//
DELIMITER ;

--------------------------------------------------

-- 9. Funcion que recibe el ID de un pedido y devuelve su total.
DELIMITER //
CREATE FUNCTION TotalPedido(pedido INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT
