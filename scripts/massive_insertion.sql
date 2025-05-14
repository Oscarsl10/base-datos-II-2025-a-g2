-- TIPO_MEMBRESIA
INSERT INTO TiposMembresia (nombre, precio, duracion_dias, descripcion)
SELECT 'Membresía ' || i, 50000 + (i * 1000), 30 * i, 'Descripción de membresía ' || i
FROM generate_series(1, 5) AS i;


-- SOCIOS
INSERT INTO Socios (nombre, email, telefono, fecha_nacimiento, fecha_inicio, id_membresia, estado)
SELECT
  'Socio' || i,
  'socio' || i || '@gmail.com',
  '30000000' || i,
  DATE '1990-01-01' + (i * INTERVAL '30 days'),
  CURRENT_DATE - (i * INTERVAL '15 days'),
  (i % 5) + 1,
  true
FROM generate_series(1, 50) AS i;


-- INSTRUCTORES
INSERT INTO Instructores (nombre, especialidad, email, telefono)
SELECT
  'Instructor' || i,
  'Especialidad ' || i,
  'instructor' || i || '@gym.com',
  '31000000' || i
FROM generate_series(1, 10) AS i;


-- CLASES_GRUPALES
INSERT INTO ClasesGrupales (nombre, descripcion, capacidad, id_instructor)
SELECT
  'Clase ' || i,
  'Descripción clase ' || i,
  10 + i,
  (i % 10) + 1
FROM generate_series(1, 20) AS i;


-- HORARIOS_CLASE
INSERT INTO HorariosClase (id_clase, dia_semana, hora_inicio, hora_fin)
SELECT
  (i % 20) + 1,
  CASE (i % 7)
    WHEN 0 THEN 'Lunes'
    WHEN 1 THEN 'Martes'
    WHEN 2 THEN 'Miércoles'
    WHEN 3 THEN 'Jueves'
    WHEN 4 THEN 'Viernes'
    WHEN 5 THEN 'Sábado'
    ELSE 'Domingo'
  END,
  TIME '08:00:00' + (i || ' minutes')::interval,
  TIME '09:00:00' + (i || ' minutes')::interval
FROM generate_series(1, 30) AS i;


-- RESERVAS_CLASE
INSERT INTO ReservasClase (id_socio, id_horario, fecha, estado)
SELECT
  (i % 50) + 1,
  (i % 30) + 1,
  CURRENT_DATE - (i || ' days')::interval,
  'Reservado'
FROM generate_series(1, 40) AS i;


-- EQUIPAMIENTO
INSERT INTO Equipamiento (nombre, descripcion, cantidad, estado)
SELECT
  'Máquina ' || i,
  'Descripción de máquina ' || i,
  5 + (i % 5),
  'Disponible'
FROM generate_series(1, 10) AS i;


-- MANTENIMEINTO_EQUIPAMIENTO
INSERT INTO MantenimientoEquipamiento (id_equipamiento, fecha_mantenimiento, descripcion, realizado_por)
SELECT
  (i % 10) + 1,
  CURRENT_DATE - (i || ' days')::interval,
  'Mantenimiento ' || i,
  'Técnico ' || i
FROM generate_series(1, 15) AS i;


-- CONTROL_ACCESO
INSERT INTO ControlAcceso (id_socio, fecha, hora_entrada, hora_salida)
SELECT
  (i % 50) + 1,
  CURRENT_DATE - (i || ' days')::interval,
  TIME '06:00:00' + (i || ' minutes')::interval,
  TIME '08:00:00' + (i || ' minutes')::interval
FROM generate_series(1, 40) AS i;


-- PAGOS_CUOTA
INSERT INTO PagosCuota (id_socio, fecha_pago, monto, estado_pago_id)
SELECT
  (i % 50) + 1,
  CURRENT_DATE - (i || ' days')::interval,
  70000 + (i * 1000),
  (i % 3) + 1
FROM generate_series(1, 30) AS i;


-- ESTADOS_PAGO
INSERT INTO EstadosPago (nombre)
VALUES ('Pagado'), ('Pendiente'), ('Vencido');


-- USUARIOS
INSERT INTO Usuarios (username, password, rol)
SELECT
  'usuario' || i,
  'pass' || i,
  CASE WHEN i % 2 = 0 THEN 'admin' ELSE 'usuario' END
FROM generate_series(1, 10) AS i;


-- AUDITORIA
INSERT INTO Auditoria (tabla_afectada, accion, detalle)
SELECT
  'Tabla' || (i % 5 + 1),
  'INSERT',
  'Inserción de prueba ' || i
FROM generate_series(1, 10) AS i;


-- USO_EQUIPAMIENTO
INSERT INTO UsoEquipamiento (id_socio, id_equipamiento, fecha, hora_inicio, hora_fin)
SELECT
  (i % 50) + 1,
  (i % 10) + 1,
  CURRENT_DATE - (i || ' days')::interval,
  TIME '07:00:00' + (i || ' minutes')::interval,
  TIME '08:00:00' + (i || ' minutes')::interval
FROM generate_series(1, 25) AS i;


-- HISTORIAL_MEMBRESIA
INSERT INTO HistorialMembresia (id_socio, id_membresia, fecha_inicio, fecha_fin)
SELECT
  (i % 50) + 1,
  (i % 5) + 1,
  CURRENT_DATE - (i * INTERVAL '30 days'),
  CURRENT_DATE - ((i - 1) * INTERVAL '30 days')
FROM generate_series(1, 30) AS i;