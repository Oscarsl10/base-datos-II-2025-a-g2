-- ADMINISTRADOR GIMNASIO

CREATE USER admin WITH PASSWORD 'admin123';
CREATE ROLE admin_gimnasio;

-- Asignación de rol
GRANT admin_gimnasio TO admin;

-- Permisos
GRANT CONNECT ON DATABASE gimnasio TO admin_gimnasio;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_gimnasio;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_gimnasio;


-- RECEPCIONISTA

CREATE USER recepcionista WITH PASSWORD 'recep123';
CREATE ROLE recepcionista_role;
GRANT recepcionista_role TO recepcionista;

GRANT CONNECT ON DATABASE gimnasio TO recepcionista_role;

GRANT SELECT, INSERT, UPDATE ON
    Socios,
    PagosCuota,
    ControlAcceso,
    ReservasClase,
    HistorialMembresia
TO recepcionista_role;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE
    socios_id_seq,
    pagoscuota_id_seq,
    controlacceso_id_seq,
    reservasclase_id_seq,
    historialmembresia_id_seq
TO recepcionista_role;


-- SOCIO

CREATE USER socio WITH PASSWORD 'socio123';
CREATE ROLE socio_role;
GRANT socio_role TO socio;

GRANT CONNECT ON DATABASE gimnasio TO socio_role;

-- Sólo puede ver su información y reservar clases
GRANT SELECT, INSERT ON
    ReservasClase,
    ControlAcceso
TO socio_role;

GRANT SELECT ON
    TiposMembresia,
    PagosCuota
TO socio_role;

GRANT USAGE, SELECT ON SEQUENCE
    reservasclase_id_seq,
    controlacceso_id_seq
TO socio_role;


-- INSTRUCTOR

CREATE USER instructor WITH PASSWORD 'instructor123';
CREATE ROLE instructor_role;
GRANT instructor_role TO instructor;

GRANT CONNECT ON DATABASE gimnasio TO instructor_role;

-- Puede consultar clases asignadas, horarios y control de asistencia
GRANT SELECT ON
    ClasesGrupales,
    HorariosClase,
    Socios,
    ReservasClase,
    UsoEquipamiento
TO instructor_role;

GRANT USAGE, SELECT ON SEQUENCE
    clasesgrupales_id_seq,
    horariosclase_id_seq,
    reservasclase_id_seq,
    usoequipamiento_id_seq
TO instructor_role;


-- AUDITORÍA

CREATE USER auditor WITH PASSWORD 'auditor123';
CREATE ROLE auditor_role;
GRANT auditor_role TO auditor;

-- Permitir conexión a la base de datos
GRANT CONNECT ON DATABASE gimnasio TO auditor_role;

-- Dar acceso de solo lectura a todas las tablas
GRANT SELECT ON ALL TABLES IN SCHEMA public TO auditor_role;

-- Dar permiso de lectura en las secuencias (por si consulta IDs)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO auditor_role;
$$$
