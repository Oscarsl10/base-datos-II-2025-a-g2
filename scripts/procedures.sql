-- PROCEDURE: public.actualizar_clase(integer, text, text, integer, integer)

-- DROP PROCEDURE IF EXISTS public.actualizar_clase(integer, text, text, integer, integer);

CREATE OR REPLACE PROCEDURE public.actualizar_clase(
	IN p_id integer,
	IN p_nombre text,
	IN p_descripcion text,
	IN p_capacidad integer,
	IN p_id_instructor integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE ClasesGrupales 
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        capacidad = p_capacidad,
        id_instructor = p_id_instructor
    WHERE id = p_id;
END;
$BODY$;
ALTER PROCEDURE public.actualizar_clase(integer, text, text, integer, integer)
    OWNER TO grupo2;

	-- Ejemplo de uso:
-- CALL public.actualizar_clase(1, 'Yoga Avanzado', 'Clase de yoga para niveles avanzados', 20, 2); -- Reemplaza los valores según sea necesario



-- PROCEDURE: public.actualizar_estado_pago(integer, text)

-- DROP PROCEDURE IF EXISTS public.actualizar_estado_pago(integer, text);

CREATE OR REPLACE PROCEDURE public.actualizar_estado_pago(
    IN p_id_pago integer,
    IN p_estado text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_estado_id integer;
BEGIN
    SELECT id INTO v_estado_id FROM EstadosPago WHERE nombre = p_estado LIMIT 1;

    IF v_estado_id IS NULL THEN
        RAISE EXCEPTION 'Estado de pago % no encontrado en tabla EstadosPago', p_estado;
    END IF;

    UPDATE PagosCuota
    SET estados_pago_id = v_estado_id
    WHERE id = p_id_pago;
END;
$BODY$;

ALTER PROCEDURE public.actualizar_estado_pago(integer, text)
OWNER TO grupo2;

-- Ejemplo de uso:
-- CALL public.actualizar_estado_pago(1, 'Pagado'); -- Reemplaza 1 con el ID del pago y 'Pagado' con el nuevo estado deseado



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

	-- Ejemplo de uso:
	-- CALL public.actualizar_socio(1, 'Juan Pérez', 'juan.perez@mail.com', '1234567890');



-- PARA ELIMINAR LOGICAMENTE
-- PROCEDURE: public.cancelar_reserva(integer)

-- DROP PROCEDURE IF EXISTS public.cancelar_reserva(integer);

CREATE OR REPLACE PROCEDURE public.cancelar_reserva(
    IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE ReservasClase SET status = false WHERE id = p_id;
END;
$BODY$;

ALTER PROCEDURE public.cancelar_reserva(integer)
    OWNER TO grupo2;

	-- Ejemplo de uso:
	-- CALL public.cancelar_reserva(1); -- Reemplaza 1 con el ID de la reserva que deseas cancelar


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

	-- Ejemplo de uso:
	-- CALL public.eliminar_clase_logicamente(1); -- Reemplaza 1 con el ID de la clase que deseas eliminar lógicamente



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

	-- Ejemplo de uso:
	-- CALL public.eliminar_socio_logicamente(1); -- Reemplaza 1 con el ID del socio que deseas eliminar lógicamente



-- PROCEDURE: public.insertar_clase(text, text, integer, integer)

-- DROP PROCEDURE IF EXISTS public.insertar_clase(text, text, integer, integer);

CREATE OR REPLACE PROCEDURE public.insertar_clase(
	IN p_nombre text,
	IN p_descripcion text,
	IN p_capacidad integer,
	IN p_id_instructor integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO ClasesGrupales(nombre, descripcion, capacidad, id_instructor, status)
    VALUES (p_nombre, p_descripcion, p_capacidad, p_id_instructor, TRUE);
END;
$BODY$;
ALTER PROCEDURE public.insertar_clase(text, text, integer, integer)
    OWNER TO grupo2;

	-- Ejemplo de uso:
	-- CALL public.insertar_clase('Yoga', 'Clase de yoga para principiantes', 15, 1); -- Reemplaza los valores según sea necesario



-- PROCEDURE: public.insertar_pago(integer, date, numeric)

-- DROP PROCEDURE IF EXISTS public.insertar_pago(integer, date, numeric);

CREATE OR REPLACE PROCEDURE public.insertar_pago(
	IN p_id_socio integer,
	IN p_fecha_pago date,
	IN p_monto numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO PagosCuota(id_socio, fecha_pago, monto, estados_pago_id)
    VALUES (
        p_id_socio,
        p_fecha_pago,
        p_monto,
        (SELECT id FROM EstadosPago WHERE nombre = 'Pendiente' LIMIT 1)
    );
END;
$BODY$;
ALTER PROCEDURE public.insertar_pago(integer, date, numeric)
    OWNER TO grupo2;


	-- Ejemplo de uso:
	-- CALL public.insertar_pago(1, '2023-10-01', 50.00); -- Reemplaza los valores según sea necesario



-- PROCEDURE: public.insertar_reserva(integer, integer, date, text, integer)

-- DROP PROCEDURE IF EXISTS public.insertar_reserva(integer, integer, date, text, integer);

CREATE OR REPLACE PROCEDURE public.insertar_reserva(
	IN p_id_socio integer,
	IN p_id_horario integer,
	IN p_fecha date,
	IN p_estado text,
	IN p_id_clase integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO ReservasClase(id_socio, id_horario, fecha, estado, id_clase)
    VALUES (p_id_socio, p_id_horario, p_fecha, p_estado, p_id_clase);
END;
$BODY$;
ALTER PROCEDURE public.insertar_reserva(integer, integer, date, text, integer)
    OWNER TO grupo2;

	-- Ejemplo de uso:
	-- CALL public.insertar_reserva(1, 1, '2023-10-01', 'Pendiente', 1); -- Reemplaza los valores según sea necesario



-- PROCEDURE: public.insertar_socio(text, text, text, date, date, integer, date)

-- DROP PROCEDURE IF EXISTS public.insertar_socio(text, text, text, date, date, integer, date);

CREATE OR REPLACE PROCEDURE public.insertar_socio(
	IN p_nombre text,
	IN p_email text,
	IN p_telefono text,
	IN p_fecha_nacimiento date,
	IN p_fecha_inicio date,
	IN p_id_membresia integer,
	IN p_fecha_ultima_conexion date)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO Socios(nombre, email, telefono, fecha_nacimiento, fecha_inicio, id_membresia, fecha_ultima_conexion, status)
    VALUES (p_nombre, p_email, p_telefono, p_fecha_nacimiento, p_fecha_inicio, p_id_membresia, p_fecha_ultima_conexion, TRUE);
END;
$BODY$;
ALTER PROCEDURE public.insertar_socio(text, text, text, date, date, integer, date)
    OWNER TO grupo2;

	-- Ejemplo de uso:
	-- CALL public.insertar_socio('Juan Pérez', 'juanperez@example.com', '3114567890', '1990-05-15', '2025-05-01', 2, '2025-05-19');
