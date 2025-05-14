-- PROCEDURE: public.actualizar_clase(integer, text, text, date, time without time zone, integer)

-- DROP PROCEDURE IF EXISTS public.actualizar_clase(integer, text, text, date, time without time zone, integer);

CREATE OR REPLACE PROCEDURE public.actualizar_clase(
	IN p_id integer,
	IN p_nombre text,
	IN p_descripcion text,
	IN p_fecha date,
	IN p_hora time without time zone,
	IN p_capacidad integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE ClasesGrupales SET nombre = p_nombre, descripcion = p_descripcion,
        fecha = p_fecha, hora = p_hora, capacidad = p_capacidad WHERE id = p_id;
END;
$BODY$;
ALTER PROCEDURE public.actualizar_clase(integer, text, text, date, time without time zone, integer)
    OWNER TO grupo2;



-- PROCEDURE: public.actualizar_estado_pago(integer, text)

-- DROP PROCEDURE IF EXISTS public.actualizar_estado_pago(integer, text);

CREATE OR REPLACE PROCEDURE public.actualizar_estado_pago(
	IN p_id_pago integer,
	IN p_estado text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE PagosCuota SET estado_pago_id = (SELECT id FROM EstadosPago WHERE nombre = p_estado)
    WHERE id = p_id_pago;
END;
$BODY$;
ALTER PROCEDURE public.actualizar_estado_pago(integer, text)
    OWNER TO grupo2;



-- PROCEDURE: public.actualizar_socio(integer, text, text, text)

-- DROP PROCEDURE IF EXISTS public.actualizar_socio(integer, text, text, text);

CREATE OR REPLACE PROCEDURE public.actualizar_socio(
	IN p_id integer,
	IN p_nombre text,
	IN p_email text,
	IN p_telefono text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE Socios SET nombre = p_nombre, email = p_email, telefono = p_telefono WHERE id = p_id;
END;
$BODY$;
ALTER PROCEDURE public.actualizar_socio(integer, text, text, text)
    OWNER TO grupo2;



-- PROCEDURE: public.cancelar_reserva(integer)

-- DROP PROCEDURE IF EXISTS public.cancelar_reserva(integer);

CREATE OR REPLACE PROCEDURE public.cancelar_reserva(
	IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    DELETE FROM ReservasClase WHERE id = p_id;
END;
$BODY$;
ALTER PROCEDURE public.cancelar_reserva(integer)
    OWNER TO grupo2;



-- PROCEDURE: public.eliminar_clase_logicamente(integer)

-- DROP PROCEDURE IF EXISTS public.eliminar_clase_logicamente(integer);

CREATE OR REPLACE PROCEDURE public.eliminar_clase_logicamente(
	IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE ClasesGrupales SET status = FALSE WHERE id = p_id;
END;
$BODY$;
ALTER PROCEDURE public.eliminar_clase_logicamente(integer)
    OWNER TO grupo2;



-- PROCEDURE: public.eliminar_socio_logicamente(integer)

-- DROP PROCEDURE IF EXISTS public.eliminar_socio_logicamente(integer);

CREATE OR REPLACE PROCEDURE public.eliminar_socio_logicamente(
	IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE Socios SET status = FALSE WHERE id = p_id;
END;
$BODY$;
ALTER PROCEDURE public.eliminar_socio_logicamente(integer)
    OWNER TO grupo2;



-- PROCEDURE: public.insertar_clase(text, text, date, time without time zone, integer)

-- DROP PROCEDURE IF EXISTS public.insertar_clase(text, text, date, time without time zone, integer);

CREATE OR REPLACE PROCEDURE public.insertar_clase(
	IN p_nombre text,
	IN p_descripcion text,
	IN p_fecha date,
	IN p_hora time without time zone,
	IN p_capacidad integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO ClasesGrupales(nombre, descripcion, fecha, hora, capacidad, status)
    VALUES (p_nombre, p_descripcion, p_fecha, p_hora, p_capacidad, TRUE);
END;
$BODY$;
ALTER PROCEDURE public.insertar_clase(text, text, date, time without time zone, integer)
    OWNER TO grupo2;



-- PROCEDURE: public.insertar_pago(integer, numeric, date)

-- DROP PROCEDURE IF EXISTS public.insertar_pago(integer, numeric, date);

CREATE OR REPLACE PROCEDURE public.insertar_pago(
	IN p_id_socio integer,
	IN p_monto numeric,
	IN p_fecha date)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO PagosCuota(id_socio, monto, fecha_pago, estado_pago_id)
    VALUES (p_id_socio, p_monto, p_fecha, (SELECT id FROM EstadosPago WHERE nombre = 'Pendiente'));
END;
$BODY$;
ALTER PROCEDURE public.insertar_pago(integer, numeric, date)
    OWNER TO grupo2;



-- PROCEDURE: public.insertar_reserva(integer, integer)

-- DROP PROCEDURE IF EXISTS public.insertar_reserva(integer, integer);

CREATE OR REPLACE PROCEDURE public.insertar_reserva(
	IN p_id_socio integer,
	IN p_id_clase integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO ReservasClase(id_socio, id_clase, fecha_reserva)
    VALUES (p_id_socio, p_id_clase, CURRENT_DATE);
END;
$BODY$;
ALTER PROCEDURE public.insertar_reserva(integer, integer)
    OWNER TO grupo2;



-- PROCEDURE: public.insertar_socio(text, text, text)

-- DROP PROCEDURE IF EXISTS public.insertar_socio(text, text, text);

CREATE OR REPLACE PROCEDURE public.insertar_socio(
	IN p_nombre text,
	IN p_email text,
	IN p_telefono text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO Socios(nombre, email, telefono, status) VALUES (p_nombre, p_email, p_telefono, TRUE);
END;
$BODY$;
ALTER PROCEDURE public.insertar_socio(text, text, text)
    OWNER TO grupo2;
