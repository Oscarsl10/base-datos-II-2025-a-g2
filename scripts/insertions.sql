-- TIPO_MEMBRESIA
INSERT INTO TiposMembresia (nombre, precio, duracion_dias, descripcion) VALUES
('Mensual', 50000, 30, 'Acceso durante 1 mes'),
('Trimestral', 135000, 90, 'Acceso durante 3 meses'),
('Semestral', 250000, 180, 'Acceso durante 6 meses'),
('Anual', 480000, 365, 'Acceso durante 1 año'),
('Semanal', 20000, 7, 'Acceso por 1 semana');


-- SOCIOS
INSERT INTO Socios (nombre, email, telefono, fecha_nacimiento, fecha_inicio, id_membresia) VALUES
('Ana Martínez', 'ana@example.com', '3001230001', '1992-03-10', CURRENT_DATE, 1),
('Luis Pérez', 'luis@example.com', '3001230002', '1988-07-22', CURRENT_DATE, 2),
('María López', 'maria@example.com', '3001230003', '1995-11-30', CURRENT_DATE, 3),
('Carlos García', 'carlos@example.com', '3001230004', '1990-01-15', CURRENT_DATE, 4),
('Elena Torres', 'elena@example.com', '3001230005', '1985-09-18', CURRENT_DATE, 5);


-- INSTRUCTORES
INSERT INTO Instructores (nombre, especialidad, email, telefono) VALUES
('Pedro Ruiz', 'Spinning', 'pedro@gym.com', '3010000001'),
('Laura Jiménez', 'Yoga', 'laura@gym.com', '3010000002'),
('Mario Díaz', 'Crossfit', 'mario@gym.com', '3010000003'),
('Carolina Méndez', 'Pilates', 'carolina@gym.com', '3010000004'),
('Santiago Vargas', 'Funcional', 'santiago@gym.com', '3010000005');


-- CLASES_GRUPALES
INSERT INTO ClasesGrupales (nombre, descripcion, capacidad, id_instructor) VALUES
('Spinning Avanzado', 'Clase de ciclismo indoor', 15, 1),
('Yoga Relax', 'Relajación y respiración', 12, 2),
('Crossfit Intenso', 'Entrenamiento de alta intensidad', 20, 3),
('Pilates Básico', 'Fortalecimiento y estiramiento', 10, 4),
('Entrenamiento Funcional', 'Trabajo integral del cuerpo', 18, 5);


-- HORARIOS_CLASE
INSERT INTO HorariosClase (id_clase, dia_semana, hora_inicio, hora_fin) VALUES
(1, 'Lunes', '08:00', '09:00'),
(2, 'Martes', '10:00', '11:00'),
(3, 'Miércoles', '18:00', '19:00'),
(4, 'Jueves', '07:00', '08:00'),
(5, 'Viernes', '17:00', '18:00');


-- RESERVAS_CLASE
INSERT INTO ReservasClase (id_socio, id_horario, fecha, estado) VALUES
(1, 1, CURRENT_DATE, 'Reservado'),
(2, 2, CURRENT_DATE, 'Reservado'),
(3, 3, CURRENT_DATE, 'Reservado'),
(4, 4, CURRENT_DATE, 'Cancelado'),
(5, 5, CURRENT_DATE, 'Asistido');


-- EQUIPAMIENTO
INSERT INTO Equipamiento (nombre, descripcion, cantidad, estado) VALUES
('Bicicleta Spinning', 'Bicicleta fija de alta resistencia', 10, 'Disponible'),
('Colchoneta Yoga', 'Colchoneta antideslizante', 20, 'Disponible'),
('Pesas 10kg', 'Pesas de goma', 15, 'Disponible'),
('Máquina de remo', 'Remo hidráulico', 5, 'Disponible'),
('Cinta caminadora', 'Caminadora eléctrica', 8, 'Disponible');


-- MANTENIMEINTO_EQUIPAMIENTO
INSERT INTO MantenimientoEquipamiento (id_equipamiento, fecha_mantenimiento, descripcion, realizado_por) VALUES
(1, '2024-05-01', 'Revisión de frenos', 'Técnico 1'),
(2, '2024-04-15', 'Limpieza profunda', 'Técnico 2'),
(3, '2024-03-22', 'Cambio de agarres', 'Técnico 3'),
(4, '2024-03-10', 'Lubricación', 'Técnico 4'),
(5, '2024-02-28', 'Cambio de motor', 'Técnico 5');


-- CONTROL_ACCESO
INSERT INTO ControlAcceso (id_socio, fecha, hora_entrada, hora_salida) VALUES
(1, CURRENT_DATE, '08:00', '09:30'),
(2, CURRENT_DATE, '10:00', '11:00'),
(3, CURRENT_DATE, '17:00', '18:00'),
(4, CURRENT_DATE, '07:30', '09:00'),
(5, CURRENT_DATE, '18:00', '19:15');


-- PAGOS_CUOTA
INSERT INTO PagosCuota (id_socio, fecha_pago, monto, estado_pago_id) VALUES
(1, '2024-05-01', 50000, 1),
(2, '2024-05-01', 135000, 1),
(3, '2024-05-01', 250000, 2),
(4, '2024-05-01', 480000, 3),
(5, '2024-05-01', 20000, 1);


-- ESTADOS_PAGO
INSERT INTO EstadosPago (nombre) VALUES
('Pagado'),
('Pendiente'),
('Vencido'),
('Rechazado'),
('En Proceso');


-- USUARIOS
INSERT INTO Usuarios (username, password, rol) VALUES
('admin', 'admin123', 'administrador'),
('user1', 'user123', 'socio'),
('user2', 'user123', 'socio'),
('instructor1', 'instr123', 'instructor'),
('auditor', 'audit123', 'auditor');


-- AUDITORIA
INSERT INTO Auditoria (tabla_afectada, accion, detalle) VALUES
('Socios', 'INSERT', 'Se agregó nuevo socio'),
('ClasesGrupales', 'UPDATE', 'Se modificó la capacidad'),
('PagosCuota', 'DELETE', 'Se eliminó un pago'),
('Equipamiento', 'INSERT', 'Nuevo equipo añadido'),
('Usuarios', 'UPDATE', 'Cambio de contraseña');


-- USO_EQUIPAMIENTO
INSERT INTO UsoEquipamiento (id_socio, id_equipamiento, fecha, hora_inicio, hora_fin) VALUES
(1, 1, CURRENT_DATE, '08:00', '08:30'),
(2, 2, CURRENT_DATE, '10:15', '10:45'),
(3, 3, CURRENT_DATE, '17:00', '17:30'),
(4, 4, CURRENT_DATE, '07:45', '08:15'),
(5, 5, CURRENT_DATE, '18:00', '18:45');


-- HISTORIAL_MEMBRESIA
INSERT INTO HistorialMembresia (id_socio, id_membresia, fecha_inicio, fecha_fin) VALUES
(1, 1, '2024-04-01', '2024-05-01'),
(2, 2, '2024-01-01', '2024-04-01'),
(3, 3, '2023-12-01', '2024-06-01'),
(4, 4, '2023-05-01', '2024-05-01'),
(5, 5, '2024-04-20', '2024-04-27');
