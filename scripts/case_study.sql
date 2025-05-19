-- FUNCTION: public.analizar_popularidad_clases()

-- DROP FUNCTION IF EXISTS public.analizar_popularidad_clases();

CREATE OR REPLACE FUNCTION public.analizar_popularidad_clases(
	)
    RETURNS TABLE(clase_id integer, clase_nombre character varying, instructor_id integer, instructor_nombre character varying, total_reservas bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
      c.id,
      c.nombre,
      i.id,
      i.nombre,
      COUNT(r.id)
    FROM ClasesGrupales c
    JOIN Instructores i   ON c.id_instructor = i.id
    LEFT JOIN HorariosClase h ON h.id_clase     = c.id
    LEFT JOIN ReservasClase r ON r.id_horario   = h.id
    GROUP BY c.id, c.nombre, i.id, i.nombre
    ORDER BY COUNT(r.id) DESC;
END;
$BODY$;

ALTER FUNCTION public.analizar_popularidad_clases()
    OWNER TO grupo2;

    -- Ejemplo de uso:
    -- SELECT * FROM public.analizar_popularidad_clases();
    -- SELECT clase_id, clase_nombre, instructor_id, instructor_nombre, total_reservas FROM public.analizar_popularidad_clases();



-- FUNCTION: public.analizar_popularidad_instructores()

-- DROP FUNCTION IF EXISTS public.analizar_popularidad_instructores();

CREATE OR REPLACE FUNCTION public.analizar_popularidad_instructores(
	)
    RETURNS TABLE(instructor_id integer, instructor_nombre character varying, total_reservas bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
      i.id,
      i.nombre,
      COUNT(r.id)
    FROM Instructores i
    JOIN ClasesGrupales c     ON c.id_instructor = i.id
    LEFT JOIN HorariosClase h ON h.id_clase      = c.id
    LEFT JOIN ReservasClase r ON r.id_horario    = h.id
    GROUP BY i.id, i.nombre
    ORDER BY COUNT(r.id) DESC;
END;
$BODY$;

ALTER FUNCTION public.analizar_popularidad_instructores()
    OWNER TO grupo2;

    -- Ejemplo de uso:
    -- SELECT * FROM public.analizar_popularidad_instructores();
