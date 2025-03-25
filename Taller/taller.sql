-- Creación de la base de datos
CREATE DATABASE vtaszfs;
USE vtaszfs;

-- Tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30),
    email VARCHAR(30) UNIQUE
);

CREATE TABLE IF NOT EXISTS telefonos (
    id INT PRIMARY KEY AUTO_INCREMENT,     
    cliente_id INT, 
    telefono VARCHAR(50),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

-- Tabla Ubicaciones (corregido el error de coma)
CREATE TABLE IF NOT EXISTS Ubicaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    entidad_id INT NOT NULL,
    tipo_entidad VARCHAR(50),
    direccion VARCHAR(30),
    ciudad VARCHAR(30),
    estado VARCHAR(20),
    codigo_postal VARCHAR(10),
    pais VARCHAR(30)
);

-- Normalizacion de tabla Empleados
CREATE TABLE IF NOT EXISTS DatosEmpleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);

CREATE TABLE IF NOT EXISTS Puestos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    datosEmpleados_id INT,
    FOREIGN KEY (datosEmpleados_id) REFERENCES DatosEmpleados(id),
    puesto VARCHAR(30)
);

-- Tabla Proveedores (sin información de contacto)
CREATE TABLE IF NOT EXISTS Proveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) UNIQUE,
    fecha_contratacion DATE
);

-- Nueva tabla ContactosProveedores (relacionada con Proveedores)
CREATE TABLE IF NOT EXISTS ContactoProveedores (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,      
    proveedor_id INT,                      
    nombre_contacto VARCHAR(40),           
    contacto VARCHAR(20),
    tipo_contacto VARCHAR(50),                   
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);

-- Tabla Categoría (debe estar antes de TiposProductos)
CREATE TABLE IF NOT EXISTS categoria(
    id INT PRIMARY KEY AUTO_INCREMENT,
    posicion INT
);

-- Tabla TiposProductos
CREATE TABLE IF NOT EXISTS TiposProductos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria_id INT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

-- Tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    proveedor_id INT,
    tipo_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id),
    FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id)
);

-- Tabla Precios (para el historial de precios de productos)
CREATE TABLE IF NOT EXISTS Precios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    precio DECIMAL(10, 2),
    FOREIGN KEY (producto_id) REFERENCES Productos(id) ON DELETE CASCADE
);

-- Tabla Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    fecha DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

-- Tabla DetallesPedido (corregida referencia a `Precios`)
CREATE TABLE IF NOT EXISTS DetallesPedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    historial_precio_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES Productos(id) ON DELETE CASCADE,
    FOREIGN KEY (historial_precio_id) REFERENCES Precios(id)
);

-- Tabla HistorialPedidos
CREATE TABLE IF NOT EXISTS HistorialPedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    estado_actual VARCHAR(10)
);

-- Tabla HistorialDetalles (relación muchos a muchos)
CREATE TABLE IF NOT EXISTS HistorialDetalles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    detallesPedido_id INT,
    FOREIGN KEY (detallesPedido_id) REFERENCES DetallesPedido(id),
    historialPedidos_id INT,
    FOREIGN KEY (historialPedidos_id) REFERENCES HistorialPedidos(id),
    fecha_ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Relación muchos a muchos entre empleados y proveedores (corregida referencia)
CREATE TABLE Empleados_Proveedores (
    empleado_id INT,
    proveedor_id INT,
    PRIMARY KEY (empleado_id, proveedor_id),
    FOREIGN KEY (empleado_id) REFERENCES DatosEmpleados(id) ON DELETE CASCADE,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE
);