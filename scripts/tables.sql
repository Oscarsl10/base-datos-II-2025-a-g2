-- Table: public.tiposmembresia

-- DROP TABLE IF EXISTS public.tiposmembresia;

CREATE TABLE IF NOT EXISTS public.tiposmembresia
(
    id integer NOT NULL DEFAULT nextval('tiposmembresia_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    precio numeric(10,2) NOT NULL,
    duracion_dias integer NOT NULL,
    descripcion text COLLATE pg_catalog."default",
    status boolean DEFAULT true,
    CONSTRAINT tiposmembresia_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: public.socios

-- DROP TABLE IF EXISTS public.socios;

CREATE TABLE IF NOT EXISTS public.socios
(
    id integer NOT NULL DEFAULT nextval('socios_id_seq'::regclass),
    nombre character varying(100) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    telefono character varying(20) COLLATE pg_catalog."default",
    fecha_nacimiento date,
    fecha_inicio date NOT NULL,
    id_membresia integer,
    status boolean DEFAULT true,
    fecha_ultima_conexion timestamp without time zone,
    CONSTRAINT socios_pkey PRIMARY KEY (id),
    CONSTRAINT socios_email_key UNIQUE (email),
    CONSTRAINT socios_id_membresia_fkey FOREIGN KEY (id_membresia)
        REFERENCES public.tiposmembresia (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.accesosocio

-- DROP TABLE IF EXISTS public.accesosocio;

CREATE TABLE IF NOT EXISTS public.accesosocio
(
    id integer NOT NULL DEFAULT nextval('"accesoSocio_id_seq"'::regclass),
    socio_id integer NOT NULL,
    fecha_acceso timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status boolean DEFAULT true,
    CONSTRAINT socio_id_fk PRIMARY KEY (id),
    CONSTRAINT socio_id FOREIGN KEY (socio_id)
        REFERENCES public.socios (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

-- Table: public.instructores

-- DROP TABLE IF EXISTS public.instructores;

CREATE TABLE IF NOT EXISTS public.instructores
(
    id integer NOT NULL DEFAULT nextval('instructores_id_seq'::regclass),
    nombre character varying(100) COLLATE pg_catalog."default" NOT NULL,
    especialidad character varying(100) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    telefono character varying(20) COLLATE pg_catalog."default",
    status boolean DEFAULT true,
    CONSTRAINT instructores_pkey PRIMARY KEY (id),
    CONSTRAINT instructores_email_key UNIQUE (email)
)

TABLESPACE pg_default;

-- Table: public.clasesgrupales

-- DROP TABLE IF EXISTS public.clasesgrupales;

CREATE TABLE IF NOT EXISTS public.clasesgrupales
(
    id integer NOT NULL DEFAULT nextval('clasesgrupales_id_seq'::regclass),
    nombre character varying(100) COLLATE pg_catalog."default" NOT NULL,
    descripcion text COLLATE pg_catalog."default",
    capacidad integer NOT NULL,
    id_instructor integer,
    status boolean DEFAULT true,
    CONSTRAINT clasesgrupales_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: public.horariosclase

-- DROP TABLE IF EXISTS public.horariosclase;

CREATE TABLE IF NOT EXISTS public.horariosclase
(
    id integer NOT NULL DEFAULT nextval('horariosclase_id_seq'::regclass),
    id_clase integer,
    dia_semana character varying(15) COLLATE pg_catalog."default" NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    status boolean DEFAULT true,
    CONSTRAINT horariosclase_pkey PRIMARY KEY (id),
    CONSTRAINT horariosclase_id_clase_fkey FOREIGN KEY (id_clase)
        REFERENCES public.clasesgrupales (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.reservasclase

-- DROP TABLE IF EXISTS public.reservasclase;

CREATE TABLE IF NOT EXISTS public.reservasclase
(
    id integer NOT NULL DEFAULT nextval('reservasclase_id_seq'::regclass),
    id_socio integer,
    id_horario integer,
    fecha date NOT NULL,
    estado character varying(20) COLLATE pg_catalog."default" DEFAULT 'Reservado'::character varying,
    status boolean DEFAULT true,
    id_clase integer NOT NULL,
    CONSTRAINT reservasclase_pkey PRIMARY KEY (id),
    CONSTRAINT clase_id_clasesgrupales_fkey FOREIGN KEY (id_clase)
        REFERENCES public.clasesgrupales (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
        NOT VALID,
    CONSTRAINT reservasclase_id_horario_fkey FOREIGN KEY (id_horario)
        REFERENCES public.horariosclase (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT reservasclase_id_socio_fkey FOREIGN KEY (id_socio)
        REFERENCES public.socios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.equipamiento

-- DROP TABLE IF EXISTS public.equipamiento;

CREATE TABLE IF NOT EXISTS public.equipamiento
(
    id integer NOT NULL DEFAULT nextval('equipamiento_id_seq'::regclass),
    nombre character varying(100) COLLATE pg_catalog."default" NOT NULL,
    descripcion text COLLATE pg_catalog."default",
    cantidad integer NOT NULL,
    estado character varying(20) COLLATE pg_catalog."default" DEFAULT 'Disponible'::character varying,
    status boolean DEFAULT true,
    CONSTRAINT equipamiento_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: public.mantenimientoequipamiento

-- DROP TABLE IF EXISTS public.mantenimientoequipamiento;

CREATE TABLE IF NOT EXISTS public.mantenimientoequipamiento
(
    id integer NOT NULL DEFAULT nextval('mantenimientoequipamiento_id_seq'::regclass),
    id_equipamiento integer,
    fecha_mantenimiento date NOT NULL,
    descripcion text COLLATE pg_catalog."default",
    realizado_por character varying(100) COLLATE pg_catalog."default",
    status boolean DEFAULT true,
    CONSTRAINT mantenimientoequipamiento_pkey PRIMARY KEY (id),
    CONSTRAINT mantenimientoequipamiento_id_equipamiento_fkey FOREIGN KEY (id_equipamiento)
        REFERENCES public.equipamiento (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.controlacceso

-- DROP TABLE IF EXISTS public.controlacceso;

CREATE TABLE IF NOT EXISTS public.controlacceso
(
    id integer NOT NULL DEFAULT nextval('controlacceso_id_seq'::regclass),
    id_socio integer,
    fecha date NOT NULL,
    hora_entrada time without time zone,
    hora_salida time without time zone,
    status boolean DEFAULT true,
    CONSTRAINT controlacceso_pkey PRIMARY KEY (id),
    CONSTRAINT controlacceso_id_socio_fkey FOREIGN KEY (id_socio)
        REFERENCES public.socios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.pagoscuota

-- DROP TABLE IF EXISTS public.pagoscuota;

CREATE TABLE IF NOT EXISTS public.pagoscuota
(
    id integer NOT NULL DEFAULT nextval('pagoscuota_id_seq'::regclass),
    id_socio integer,
    fecha_pago date NOT NULL,
    monto numeric(10,2) NOT NULL,
    estados_pago_id integer NOT NULL,
    status boolean DEFAULT true,
    CONSTRAINT pagoscuota_pkey PRIMARY KEY (id),
    CONSTRAINT estados_pago_id FOREIGN KEY (estados_pago_id)
        REFERENCES public.estadospago (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
        NOT VALID,
    CONSTRAINT pagoscuota_id_socio_fkey FOREIGN KEY (id_socio)
        REFERENCES public.socios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.estadospago

-- DROP TABLE IF EXISTS public.estadospago;

CREATE TABLE IF NOT EXISTS public.estadospago
(
    id integer NOT NULL DEFAULT nextval('estadospago_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    status boolean DEFAULT true,
    CONSTRAINT estadospago_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: public.usuarios

-- DROP TABLE IF EXISTS public.usuarios;

CREATE TABLE IF NOT EXISTS public.usuarios
(
    id integer NOT NULL DEFAULT nextval('usuarios_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    rol character varying(20) COLLATE pg_catalog."default" NOT NULL,
    status boolean DEFAULT true,
    CONSTRAINT usuarios_pkey PRIMARY KEY (id),
    CONSTRAINT usuarios_username_key UNIQUE (username)
)

TABLESPACE pg_default;

-- Table: public.auditoria

-- DROP TABLE IF EXISTS public.auditoria;

CREATE TABLE IF NOT EXISTS public.auditoria
(
    id integer NOT NULL DEFAULT nextval('auditoria_id_seq'::regclass),
    tabla_afectada character varying(50) COLLATE pg_catalog."default",
    accion character varying(20) COLLATE pg_catalog."default",
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    detalle text COLLATE pg_catalog."default",
    CONSTRAINT auditoria_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: public.usoequipamiento

-- DROP TABLE IF EXISTS public.usoequipamiento;

CREATE TABLE IF NOT EXISTS public.usoequipamiento
(
    id integer NOT NULL DEFAULT nextval('usoequipamiento_id_seq'::regclass),
    id_socio integer,
    id_equipamiento integer,
    fecha date NOT NULL,
    hora_inicio time without time zone,
    hora_fin time without time zone,
    status boolean DEFAULT true,
    CONSTRAINT usoequipamiento_pkey PRIMARY KEY (id),
    CONSTRAINT usoequipamiento_id_equipamiento_fkey FOREIGN KEY (id_equipamiento)
        REFERENCES public.equipamiento (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT usoequipamiento_id_socio_fkey FOREIGN KEY (id_socio)
        REFERENCES public.socios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Table: public.historialmembresia

-- DROP TABLE IF EXISTS public.historialmembresia;

CREATE TABLE IF NOT EXISTS public.historialmembresia
(
    id integer NOT NULL DEFAULT nextval('historialmembresia_id_seq'::regclass),
    id_socio integer,
    id_membresia integer,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    status boolean DEFAULT true,
    CONSTRAINT historialmembresia_pkey PRIMARY KEY (id),
    CONSTRAINT historialmembresia_id_membresia_fkey FOREIGN KEY (id_membresia)
        REFERENCES public.tiposmembresia (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT historialmembresia_id_socio_fkey FOREIGN KEY (id_socio)
        REFERENCES public.socios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;