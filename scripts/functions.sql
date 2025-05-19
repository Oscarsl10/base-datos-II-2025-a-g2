-- FUNCTION: public.clase_tiene_cupo(integer)

-- DROP FUNCTION IF EXISTS public.clase_tiene_cupo(integer);

CREATE OR REPLACE FUNCTION public.cupo_disponible_clase(
    p_id_clase integer
)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
    capacidad INT;
    reservados INT;
BEGIN
    -- Obtener la capacidad de la clase
    SELECT c.capacidad INTO capacidad
    FROM ClasesGrupales c
    WHERE c.id = p_id_clase;

    -- Contar reservas asociadas a los horarios de esa clase
    SELECT COUNT(*) INTO reservados
    FROM ReservasClase r
    JOIN HorariosClase h ON r.id_horario = h.id
    WHERE h.id_clase = p_id_clase;

    -- Devolver cupos disponibles (puede ser 0 o negativo si hay sobrecupo)
    RETURN capacidad - reservados;
END;
$$;

ALTER FUNCTION public.cupo_disponible_clase(integer)
    OWNER TO grupo2;


    -- Ejemplo de uso:
-- SELECT public.cupo_disponible_clase(1); -- Reemplaza 1 con el ID de la clase que deseas consultar
-- SELECT id, nombre, cupo_disponible_clase(id) AS cupos_restantes FROM ClasesGrupales; -- Para ver todas las clases y sus cupos restantes



-- FUNCTION: public.contar_asistentes(integer)

-- DROP FUNCTION IF EXISTS public.contar_asistentes(integer);

CREATE OR REPLACE FUNCTION public.contar_asistentes(
    p_id_clase integer
)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
    total_asistentes integer;
BEGIN
    SELECT COUNT(*)
    INTO total_asistentes
    FROM ReservasClase r
    JOIN HorariosClase h ON r.id_horario = h.id
    WHERE h.id_clase = p_id_clase;

    RETURN total_asistentes;
END;
$$;

ALTER FUNCTION public.contar_asistentes(integer)
    OWNER TO grupo2;

    -- Ejemplo de uso:
-- SELECT public.contar_asistentes(1); -- Reemplaza 1 con el ID de la clase que deseas consultar
-- SELECT id, nombre, contar_asistentes(id) AS total_asistentes FROM ClasesGrupales; -- Para ver todas las clases y su total de asistentes



-- FUNCTION: public.info_socio(integer)

-- DROP FUNCTION IF EXISTS public.info_socio(integer);

CREATE OR REPLACE FUNCTION public.info_socio(
	id_socio integer)
RETURNS TABLE(
	nombre character varying(100),
	email character varying(100),
	telefono character varying(100)
) 
LANGUAGE plpgsql
AS $BODY$
BEGIN
  RETURN QUERY 
  SELECT s.nombre, s.email, s.telefono
  FROM Socios s
  WHERE s.id = id_socio AND s.status = true;
END;
$BODY$;

ALTER FUNCTION public.info_socio(integer)
    OWNER TO grupo2;

    -- Ejemplo de uso:
-- SELECT * FROM public.info_socio(1); -- Reemplaza 1 con el ID del socio que deseas consultar
-- SELECT nombre, email, telefono FROM public.info_socio(1); -- Reemplaza 1 con el ID del socio que deseas consultar




-- FUNCTION: public.proximos_pagos(integer)

-- DROP FUNCTION IF EXISTS public.proximos_pagos(integer);

CREATE OR REPLACE FUNCTION public.proximos_pagos(
    p_id_socio integer)
RETURNS TABLE(
    id_pago integer,
    fecha_pago date,
    monto numeric
) 
LANGUAGE plpgsql
AS $BODY$
BEGIN
  RETURN QUERY
  SELECT p.id, p.fecha_pago, p.monto
  FROM PagosCuota p
  WHERE p.id_socio = p_id_socio 
    AND p.estados_pago_id IN (SELECT e.id FROM EstadosPago e WHERE e.nombre = 'Pendiente')
  ORDER BY p.fecha_pago ASC;
END;
$BODY$;

ALTER FUNCTION public.proximos_pagos(integer)
    OWNER TO grupo2;

    -- Ejemplo de uso:  
-- SELECT * FROM public.proximos_pagos(1); -- Reemplaza 1 con el ID del socio que deseas consultar
-- SELECT id_pago, fecha_pago, monto FROM public.proximos_pagos(1); -- Reemplaza 1 con el ID del socio que deseas consultar


-- FUNCTION: public.total_pagos(integer)

-- DROP FUNCTION IF EXISTS public.total_pagos(integer);

CREATE OR REPLACE FUNCTION public.total_pagos(
    p_id_socio integer)
RETURNS numeric
LANGUAGE plpgsql
AS $BODY$
BEGIN
  RETURN (
    SELECT COALESCE(SUM(monto), 0)
    FROM PagosCuota
    WHERE id_socio = p_id_socio
      AND estados_pago_id IN (SELECT id FROM EstadosPago WHERE nombre = 'Pagado')
  );
END;
$BODY$;

ALTER FUNCTION public.total_pagos(integer)
    OWNER TO grupo2;

-- Ejemplo de uso:
-- SELECT public.total_pagos(1); -- Reemplaza 1 con el ID del socio que deseas consultar
-- SELECT id, nombre, total_pagos(id) AS total_pagado FROM Socios; -- Para ver todos los socios y su total pagado



-- FUNCTION: public.ultimo_pago(integer)

-- DROP FUNCTION IF EXISTS public.ultimo_pago(integer);

CREATE OR REPLACE FUNCTION public.ultimo_pago(
    p_id_socio integer)
RETURNS date
LANGUAGE plpgsql
AS $BODY$
BEGIN
  RETURN (
    SELECT MAX(fecha_pago)
    FROM PagosCuota
    WHERE id_socio = p_id_socio
      AND estados_pago_id IN (SELECT id FROM EstadosPago WHERE nombre = 'Pagado')
  );
END;
$BODY$;

ALTER FUNCTION public.ultimo_pago(integer)
OWNER TO grupo2;

-- Ejemplo de uso:
-- SELECT public.ultimo_pago(1); -- Reemplaza 1 con el ID del socio que deseas consultar
-- SELECT id, nombre, ultimo_pago(id) AS fecha_ultimo_pago FROM Socios; -- Para ver todos los socios y su fecha de último pago