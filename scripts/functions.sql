-- FUNCTION: public.clase_tiene_cupo(integer)

-- DROP FUNCTION IF EXISTS public.clase_tiene_cupo(integer);

CREATE OR REPLACE FUNCTION public.clase_tiene_cupo(
	id_clase integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
  capacidad INT;
  reservados INT;
BEGIN
  SELECT capacidad INTO capacidad FROM ClasesGrupales WHERE id_clase = id_clase;
  SELECT COUNT(*) INTO reservados FROM ReservasClase WHERE id_clase = id_clase;
  RETURN reservados < capacidad;
END;
$BODY$;

ALTER FUNCTION public.clase_tiene_cupo(integer)
    OWNER TO grupo2;



-- FUNCTION: public.contar_asistentes(integer)

-- DROP FUNCTION IF EXISTS public.contar_asistentes(integer);

CREATE OR REPLACE FUNCTION public.contar_asistentes(
	id_clase integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
  RETURN (SELECT COUNT(*) FROM ReservasClase WHERE id_clase = id_clase);
END;
$BODY$;

ALTER FUNCTION public.contar_asistentes(integer)
    OWNER TO grupo2;



-- FUNCTION: public.info_socio(integer)

-- DROP FUNCTION IF EXISTS public.info_socio(integer);

CREATE OR REPLACE FUNCTION public.info_socio(
	id_socio integer)
    RETURNS TABLE(nombre text, email text, telefono text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
  RETURN QUERY SELECT nombre, email, telefono FROM Socios WHERE id = id_socio AND status = true;
END;
$BODY$;

ALTER FUNCTION public.info_socio(integer)
    OWNER TO grupo2;



-- FUNCTION: public.proximos_pagos(integer)

-- DROP FUNCTION IF EXISTS public.proximos_pagos(integer);

CREATE OR REPLACE FUNCTION public.proximos_pagos(
	id_socio integer)
    RETURNS TABLE(id_pago integer, fecha_pago date, monto numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
  RETURN QUERY
  SELECT id, fecha_pago, monto
  FROM PagosCuota
  WHERE id_socio = id_socio AND estado_pago_id = (SELECT id FROM EstadosPago WHERE nombre = 'Pendiente')
  ORDER BY fecha_pago ASC;
END;
$BODY$;

ALTER FUNCTION public.proximos_pagos(integer)
    OWNER TO grupo2;



-- FUNCTION: public.total_pagos(integer)

-- DROP FUNCTION IF EXISTS public.total_pagos(integer);

CREATE OR REPLACE FUNCTION public.total_pagos(
	id_socio integer)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
  RETURN (SELECT COALESCE(SUM(monto), 0) FROM PagosCuota WHERE id_socio = id_socio AND estado_pago_id = (SELECT id FROM EstadosPago WHERE nombre = 'Pagado'));
END;
$BODY$;

ALTER FUNCTION public.total_pagos(integer)
    OWNER TO grupo2;



-- FUNCTION: public.ultimo_pago(integer)

-- DROP FUNCTION IF EXISTS public.ultimo_pago(integer);

CREATE OR REPLACE FUNCTION public.ultimo_pago(
	id_socio integer)
    RETURNS date
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
  RETURN (SELECT MAX(fecha_pago) FROM PagosCuota WHERE id_socio = id_socio AND estado_pago_id = (SELECT id FROM EstadosPago WHERE nombre = 'Pagado'));
END;
$BODY$;

ALTER FUNCTION public.ultimo_pago(integer)
    OWNER TO grupo2;