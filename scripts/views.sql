-- View: public.clasesconcupo

-- DROP VIEW public.clasesconcupo;

CREATE OR REPLACE VIEW public.clasesconcupo
 AS
 SELECT c.id,
    c.nombre,
    c.capacidad,
    count(r.id) AS reservados
   FROM clasesgrupales c
     JOIN horariosclase h ON c.id = h.id_clase
     LEFT JOIN reservasclase r ON r.id_horario = h.id
  GROUP BY c.id
 HAVING count(r.id) < c.capacidad;

ALTER TABLE public.clasesconcupo
    OWNER TO grupo2;



-- View: public.equipospendientesmantenimiento

-- DROP VIEW public.equipospendientesmantenimiento;

CREATE OR REPLACE VIEW public.equipospendientesmantenimiento
 AS
 SELECT e.id,
    e.nombre,
    max(m.fecha_mantenimiento) AS ultimo_mantenimiento
   FROM equipamiento e
     LEFT JOIN mantenimientoequipamiento m ON e.id = m.id_equipamiento
  GROUP BY e.id
 HAVING (CURRENT_DATE - max(m.fecha_mantenimiento)) > 30;

ALTER TABLE public.equipospendientesmantenimiento
    OWNER TO grupo2;



-- View: public.historialacceso

-- DROP VIEW public.historialacceso;

CREATE OR REPLACE VIEW public.historialacceso
 AS
 SELECT s.id AS id_socio,
    s.nombre,
    c.fecha,
    c.hora_entrada,
    c.hora_salida
   FROM socios s
     JOIN controlacceso c ON s.id = c.id_socio;

ALTER TABLE public.historialacceso
    OWNER TO grupo2;



-- View: public.sociospendientes

-- DROP VIEW public.sociospendientes;

CREATE OR REPLACE VIEW public.sociospendientes
 AS
 SELECT s.id,
    s.nombre,
    p.fecha_pago,
    e.nombre AS estado
   FROM socios s
     JOIN pagoscuota p ON s.id = p.id_socio
     JOIN estadospago e ON p.estados_pago_id = e.id
  WHERE e.nombre::text = 'Pendiente'::text;

ALTER TABLE public.sociospendientes
    OWNER TO grupo2;



-- View: public.usorecienteequipamiento

-- DROP VIEW public.usorecienteequipamiento;

CREATE OR REPLACE VIEW public.usorecienteequipamiento
 AS
 SELECT u.id_equipamiento,
    e.nombre,
    u.fecha,
    u.hora_inicio,
    u.hora_fin
   FROM usoequipamiento u
     JOIN equipamiento e ON u.id_equipamiento = e.id
  WHERE u.fecha >= (CURRENT_DATE - '7 days'::interval);

ALTER TABLE public.usorecienteequipamiento
    OWNER TO grupo2;