
-- CONSULTAS DE MEMEBRESIA
-- 1. Obtener todos los tipos de membresía con sus socios
SELECT tm.nombre, s.nombre AS socio
FROM TiposMembresia tm
INNER JOIN Socios s ON tm.id = s.id_membresia;

-- 2. Listar tipos de membresía aunque no tengan socios asignados
SELECT tm.*, s.nombre AS socio
FROM TiposMembresia tm
LEFT JOIN Socios s ON tm.id =s.id_membresia;

-- SUBCONSULTAS DE MEMEBRESIA
-- 1. Tipos de membresía que tienen más de 3 socios
SELECT *
FROM TiposMembresia
WHERE id IN (
    SELECT id_membresia
    FROM Socios
    GROUP BY id_membresia
    HAVING COUNT(*) > 3
);

-- 2. Precio promedio de los tipos de membresía
SELECT nombre, precio
FROM TiposMembresia
WHERE precio > (
    SELECT AVG(precio) FROM TiposMembresia
);



-- CONSULTAS DE SOCIOS
-- 1. Socios con su tipo de membresía
SELECT s.nombre, tm.nombre AS membresia
FROM Socios s
INNER JOIN TiposMembresia tm ON s.id_membresia = tm.id;

-- 2. Todos los socios y los tipos de membresía (incluso sin membresía asignada)
SELECT s.*, tm.nombre AS membresia
FROM Socios s
LEFT JOIN TiposMembresia tm ON s.id_membresia = tm.id;

-- SUBCONSULTAS DE SOCIOS
-- 1. Socios cuya membresía cuesta más de $100
SELECT *
FROM Socios
WHERE id_membresia IN (
    SELECT id FROM TiposMembresia WHERE precio > 100
);

-- 2. Socios que realizaron reservas
SELECT *
FROM Socios
WHERE id IN (
    SELECT DISTINCT id_socio FROM ReservasClase
);



-- CONSULTAS DE INSTRUCTORES
-- 1. Instructores con las clases que dictan
SELECT i.nombre AS instructor, c.nombre AS clase
FROM Instructores i
INNER JOIN ClasesGrupales c ON i.id = c.id_instructor;

-- 2. Todos los instructores y clases (aunque no tengan clases asignadas)
SELECT i.nombre AS instructor, c.nombre AS clase
FROM Instructores i
LEFT JOIN ClasesGrupales c ON i.id = c.id_instructor;

-- SUBCONSULTAS DE INSTRUCTORES
-- 1. Instructores que dictan más de una clase
SELECT *
FROM Instructores
WHERE id IN (
    SELECT id_instructor
    FROM ClasesGrupales
    GROUP BY id_instructor
    HAVING COUNT(*) > 1
);

-- 2. Instructores cuyo email ya está registrado
SELECT *
FROM Instructores
WHERE email IN (
    SELECT email FROM Instructores WHERE email IS NOT NULL
);



-- CONSUTAS DE CLASES GRUPALES
-- 1. Clases con nombre del instructor
SELECT c.nombre AS clase, i.nombre AS instructor
FROM ClasesGrupales c
INNER JOIN Instructores i ON c.id_instructor = i.id;

-- 2. Todas las clases y sus horarios (puede que algunas no tengan horarios aún)
SELECT c.nombre AS clase, h.dia_semana, h.hora_inicio
FROM ClasesGrupales c
LEFT JOIN HorariosClase h ON c.id = h.id_clase;

-- SUBCONSULTAS DE CLASES GRUPALES
-- 1. Clases con más de 10 de capacidad
SELECT *
FROM ClasesGrupales
WHERE capacidad > (
    SELECT AVG(capacidad) FROM ClasesGrupales
);

-- 2. Clases con instructores especializados en "Yoga"
SELECT *
FROM ClasesGrupales
WHERE id_instructor IN (
    SELECT id FROM Instructores WHERE especialidad = 'Yoga'
);



-- CONSULTAS DE HORARIOS DE CLASES
-- 1. Horarios con nombre de clase
SELECT h.*, c.nombre AS clase
FROM HorariosClase h
INNER JOIN ClasesGrupales c ON h.id_clase = c.id;

-- 2. Todos los horarios y sus reservas (puede que no haya reservas)
SELECT h.id, h.dia_semana, r.estado
FROM HorariosClase h
LEFT JOIN ReservasClase r ON h.id = r.id_horario;

-- SUBCONSULTAS DE HORARIOS DE CLASES
-- 1. Horarios para clases llamadas "Pilates Básico"
SELECT *
FROM HorariosClase
WHERE id_clase IN (
    SELECT id FROM ClasesGrupales WHERE nombre = 'Pilates Básico'
);

-- 2. Horarios con duración mayor a 1 hora
SELECT *
FROM HorariosClase
WHERE EXTRACT(EPOCH FROM hora_fin - hora_inicio) / 60 > 60;



-- CONSULTAS DE RESERVAS DE CLASES
-- 1. Reservas con nombre del socio y horario
SELECT r.id, s.nombre AS socio, h.dia_semana
FROM ReservasClase r
INNER JOIN Socios s ON r.id_socio = s.id
INNER JOIN HorariosClase h ON r.id_horario = h.id;

-- 2. Todas las reservas y el socio (aunque algunos socios pueden estar dados de baja)
SELECT r.*, s.nombre AS socio
FROM ReservasClase r
LEFT JOIN Socios s ON r.id_socio = s.id;

-- SUBCONSULTAS DE RESERVAS DE CLASES
-- 1. Reservas hechas por socios con membresía activa
SELECT *
FROM ReservasClase
WHERE id_socio IN (
    SELECT id FROM Socios WHERE status = TRUE
);

-- 2. Reservas hechas para clases dictadas por un instructor específico
SELECT *
FROM ReservasClase
WHERE id_horario IN (
    SELECT h.id
    FROM HorariosClase h
    JOIN ClasesGrupales c ON h.id_clase = c.id
    WHERE c.id_instructor = 1
);



-- CONSULTAS DE EQUIPAMIENTO
-- 1. Equipos con sus mantenimientos realizados
SELECT e.nombre AS equipo, m.fecha_mantenimiento
FROM Equipamiento e
INNER JOIN MantenimientoEquipamiento m ON e.id = m.id_equipamiento;

-- 2. Todos los equipos y su estado de mantenimiento (pueden no tener mantenimiento)
SELECT e.nombre AS equipo, m.fecha_mantenimiento
FROM Equipamiento e
LEFT JOIN MantenimientoEquipamiento m ON e.id = m.id_equipamiento;

-- SUBCONSULTAS DE EQUIPAMIENTO
-- 1. Equipos que han sido usados por algún socio
SELECT *
FROM Equipamiento
WHERE id IN (
    SELECT id_equipamiento FROM UsoEquipamiento
);

-- 2. Equipos que requieren mantenimiento (cantidad < 5)
SELECT *
FROM Equipamiento
WHERE cantidad < (
    SELECT AVG(cantidad) FROM Equipamiento
);



-- CONSULTAS DE MANTENIMIENTO DE EQUIPAMIENTO
-- 1. Mantenimientos con nombre del equipo
SELECT m.*, e.nombre AS equipo
FROM MantenimientoEquipamiento m
INNER JOIN Equipamiento e ON m.id_equipamiento = e.id;

-- 2. Todos los mantenimientos y su equipo (aunque haya equipos sin nombre definido)
SELECT m.*, e.nombre
FROM MantenimientoEquipamiento m
LEFT JOIN Equipamiento e ON m.id_equipamiento = e.id;

-- SUBCONSULTAS DE MANTENIMIENTO DE EQUIPAMIENTO
-- 1. Mantenimientos realizados en el último mes
SELECT *
FROM MantenimientoEquipamiento
WHERE fecha_mantenimiento > (
    SELECT CURRENT_DATE - INTERVAL '30 days'
);

-- 2. Mantenimientos realizados a equipos con nombre que contiene 'Bicicleta'
SELECT *
FROM MantenimientoEquipamiento
WHERE id_equipamiento IN (
    SELECT id FROM Equipamiento WHERE nombre ILIKE '%bicicleta%'
);



-- CONSULTAS DE CONTROL DE ACCESO
-- 1. Registro de accesos con nombre del socio
SELECT c.*, s.nombre
FROM ControlAcceso c
INNER JOIN Socios s ON c.id_socio = s.id;

-- 2. Todos los accesos incluso si el socio fue eliminado
SELECT c.*, s.nombre
FROM ControlAcceso c
LEFT JOIN Socios s ON c.id_socio = s.id;

-- SUBCONSULTAS DE CONTROL DE ACCESO
-- 1. Accesos de hoy
SELECT *
FROM ControlAcceso
WHERE fecha = (
    SELECT CURRENT_DATE
);

-- 2. Socios que han ingresado más de 10 veces
SELECT *
FROM ControlAcceso
WHERE id_socio IN (
    SELECT id_socio
    FROM ControlAcceso
    GROUP BY id_socio
    HAVING COUNT(*)>10
);



-- CONSULTAS DE PAGOS DE CUOTAS
-- 1. Pagos con nombre del socio
SELECT p.*, s.nombre
FROM PagosCuota p
INNER JOIN Socios s ON p.id_socio = s.id;

-- 2. Todos los pagos con estado de pago
SELECT p.*, s.nombre, e.nombre AS estado_pago
FROM PagosCuota p
LEFT JOIN Socios s ON p.id_socio = s.id
LEFT JOIN EstadosPago e ON p.estados_pago_id = e.id;

-- SUBCONSULTAS DE PAGOS DE CUOTAS
-- 1. Pagos realizados este mes
SELECT *
FROM PagosCuota
WHERE fecha_pago >= date_trunc('month', CURRENT_DATE);

-- 2. Socios con pagos pendientes
SELECT *
FROM EstadosPago
WHERE id = (
    SELECT estados_pago_id
    FROM PagosCuota
    GROUP BY estados_pago_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);



-- CONSULTAS DE ESTADOS DE PAGO
-- 1. Estados de pago y cantidad de pagos asociados
SELECT e.nombre, COUNT(p.id) AS cantidad_pagos
FROM EstadosPago e
LEFT JOIN PagosCuota p ON p.estados_pago_id = e.id 
GROUP BY e.nombre;

-- 2. Pagos con estado ‘Pagado’
SELECT p.*
FROM PagosCuota p
INNER JOIN EstadosPago e ON p.estado_pago_id = e.id
WHERE e.nombre = 'Pagado';

-- SUBCONSULTAS DE ESTADOS DE PAGO
-- 1. Estados con más de 5 pagos asociados
-- 1. Estados con más de 5 pagos asociados
SELECT *
FROM EstadosPago
WHERE id IN (
    SELECT estados_pago_id
    FROM PagosCuota
    GROUP BY estados_pago_id
    HAVING COUNT(*) > 5
);

-- 2. Estado de pago más usado
SELECT *
FROM EstadosPago
WHERE id = (
    SELECT estados_pago_id
    FROM PagosCuota
    GROUP BY estados_pago_id
    ORDER BY COUNT(*) DESC 
	LIMIT 1
);



-- CONSULTAS DE USUARIOS
-- 1. Lista de usuarios y su rol
SELECT username, rol
FROM Usuarios;

-- 2. Usuarios con roles que no se repiten (JOIN ficticio con subconsulta)
SELECT u.*
FROM Usuarios u
LEFT JOIN (
    SELECT rol FROM Usuarios GROUP BY rol HAVING COUNT(*) = 1
) unicos ON u.rol = unicos.rol
WHERE unicos.rol IS NOT NULL;

-- SUBCONSULTAS DE USUARIOS
-- 1. Usuarios administradores
SELECT *
FROM Usuarios
WHERE rol = (
    SELECT rol FROM Usuarios WHERE username = 'admin' LIMIT 1
);

-- 2. Usuario con contraseña más larga
SELECT *
FROM Usuarios
WHERE LENGTH(password) = (
    SELECT MAX(LENGTH(password)) FROM Usuarios
);



-- CONSULTAS DE AUDITORIA
-- 1. Registros de auditoría por tabla
SELECT tabla_afectada, COUNT(*) AS total
FROM Auditoria
GROUP BY tabla_afectada;

-- 2. Acciones recientes de modificación
SELECT *
FROM Auditoria
WHERE accion = 'UPDATE'
ORDER BY fecha DESC;

-- SUBCONSULTAS DE AUDITORIA
-- 1. Última acción registrada
SELECT *
FROM Auditoria
WHERE fecha = (
    SELECT MAX(fecha) FROM Auditoria
);

-- 2. Auditoría de tabla "socios"
SELECT *
FROM Auditoria
WHERE tabla_afectada IN (
    SELECT 'socios'
);



-- CONSULTAS DE USO DE EQUIPAMIENTO
-- 1. Uso de equipos con nombre del socio y nombre del equipo
SELECT u.*, s.nombre AS socio, e.nombre AS equipo
FROM UsoEquipamiento u
INNER JOIN Socios s ON u.id_socio = s.id
INNER JOIN Equipamiento e ON u.id_equipamiento = e.id;

-- 2. Todos los usos, aunque el socio o equipo haya sido eliminado
SELECT u.*, s.nombre AS socio, e.nombre AS equipo
FROM UsoEquipamiento u
LEFT JOIN Socios s ON u.id_socio = s.id
LEFT JOIN Equipamiento e ON u.id_equipamiento = e.id;

-- SUBCONSULTAS DE USO DE EQUIPAMIENTO
-- 1. Usos realizados hoy
SELECT *
FROM UsoEquipamiento
WHERE fecha = CURRENT_DATE;

-- 2. Equipos más usados
SELECT *
FROM Equipamiento
WHERE id IN (
    SELECT id_equipamiento
    FROM UsoEquipamiento
    GROUP BY id_equipamiento
    ORDER BY COUNT(*) DESC
    LIMIT 3
);



-- CONSULTAS DE HISTORIAL DE MEMBRESIA
-- 1. Historial de membresía con nombre del socio y nombre del tipo
SELECT h.*, s.nombre AS socio, t.nombre AS membresia
FROM HistorialMembresia h
INNER JOIN Socios s ON h.id_socio = s.id
INNER JOIN TiposMembresia t ON h.id_membresia = t.id;

-- 2. Historial, incluso si el socio fue eliminado
SELECT h.*, s.nombre, t.nombre
FROM HistorialMembresia h
LEFT JOIN Socios s ON h.id_socio = s.id
LEFT JOIN TiposMembresia t ON h.id_membresia = t.id;

-- SUBCONSULTAS DE HISTORIAL DE MEMBRESIA
-- 1. Última membresía de un socio específico
SELECT *
FROM HistorialMembresia
WHERE fecha_fin = (
    SELECT MAX(fecha_fin)
    FROM HistorialMembresia
    WHERE id_socio = 1
);

-- 2. Socios con más de una membresía registrada
SELECT *
FROM Socios
WHERE id IN (
    SELECT id_socio
    FROM HistorialMembresia
    GROUP BY id_socio
    HAVING COUNT(*) > 1
);