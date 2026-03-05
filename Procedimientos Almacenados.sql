CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_avisos_activos`()
BEGIN
    SELECT * FROM avisos 
    WHERE activo = 1 
    ORDER BY nivel DESC, fecha_creacion DESC; 
   
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_estaciones`()
BEGIN
    SELECT id_estacion, nombre_estacion
    FROM estaciones;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_horarios_rango`(
    IN p_id_estacion INT,
    IN p_id_dia INT,
    IN p_id_sentido INT,
    IN p_hora_inicio TIME,
    IN p_hora_fin TIME
)
BEGIN
    SELECT *
    FROM horarios
    WHERE ID_Estacion = p_id_estacion 
      AND ID_Dia = p_id_dia 
      AND ID_Sentido = p_id_sentido
      AND horario BETWEEN p_hora_inicio AND p_hora_fin
    ORDER BY horario ASC;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_sentidos`()
BEGIN
    SELECT id_sentido, Descripcion_Sentido
    FROM sentido
    ORDER BY id_sentido ASC;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_tablero_estacion`(
    IN p_id_estacion INT,
    IN p_id_dia INT,
    IN p_hora_actual TIME
)
BEGIN
   
    (SELECT 
        h.ID_Tren, 
        h.Horario, 
        h.ID_Sentido,
        e.nombre_estacion,
        'En hora' AS Estado 
    FROM horarios h
    JOIN estaciones e ON h.ID_Estacion = e.id_estacion
    WHERE h.ID_Estacion = p_id_estacion 
      AND h.ID_Dia = p_id_dia 
      AND h.Horario >= p_hora_actual
      AND h.ID_Sentido = 1
    ORDER BY h.Horario ASC
    LIMIT 3)
    
    UNION ALL
    
 
    (SELECT 
        h.ID_Tren, 
        h.Horario, 
        h.ID_Sentido,
        e.nombre_estacion,
        'En hora' AS Estado
    FROM horarios h
    JOIN estaciones e ON h.ID_Estacion = e.id_estacion
    WHERE h.ID_Estacion = p_id_estacion 
      AND h.ID_Dia = p_id_dia 
      AND h.Horario >= p_hora_actual
      AND h.ID_Sentido = 2
    ORDER BY h.Horario ASC
    LIMIT 3);
END


