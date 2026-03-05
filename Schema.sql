-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS belgrano_norte;
USE belgrano_norte;

-- Tabla: Estaciones
CREATE TABLE estaciones (
    ID_Estacion INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Estacion VARCHAR(100) NOT NULL,
    lat DECIMAL(10,8),
    lng DECIMAL(10,8)
);

-- Tabla: Sentido
CREATE TABLE sentido (
    ID_Sentido INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion_Sentido VARCHAR(45) NOT NULL
);

-- Tabla: Día (Tipo de horario: Lunes a Viernes, Sábado, Domingo)
CREATE TABLE dia (
    ID_Dia INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion_Dia VARCHAR(45) NOT NULL
);

-- Tabla: Trenes
CREATE TABLE trenes (
    ID_Tren INT PRIMARY KEY AUTO_INCREMENT,
    activo TINYINT DEFAULT 1
);

-- Tabla: Horarios (Relaciona todo)
CREATE TABLE horarios (
    ID_Horario INT PRIMARY KEY AUTO_INCREMENT,
    ID_Sentido INT,
    ID_Dia INT,
    ID_Tren INT,
    ID_Estacion INT,
    Horario TIME NOT NULL,
    FOREIGN KEY (ID_Sentido) REFERENCES sentido(ID_Sentido),
    FOREIGN KEY (ID_Dia) REFERENCES dia(ID_Dia),
    FOREIGN KEY (ID_Tren) REFERENCES trenes(ID_Tren),
    FOREIGN KEY (ID_Estacion) REFERENCES estaciones(ID_Estacion)
);

-- Tabla: Avisos
CREATE TABLE avisos (
    id_aviso INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    descripcion TEXT,
    nivel INT,
    activo TINYINT DEFAULT 1,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);