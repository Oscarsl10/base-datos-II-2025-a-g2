-- FUNCTION: public.auditoria_funcion()

-- DROP FUNCTION IF EXISTS public.auditoria_funcion();

CREATE OR REPLACE FUNCTION public.auditoria_funcion()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  INSERT INTO Auditoria(tabla_afectada, accion, detalle)
  VALUES (
    TG_TABLE_NAME,
    TG_OP,
    CASE 
      WHEN TG_OP = 'DELETE' THEN CONCAT('Registro eliminado ID: ', OLD.id)
      ELSE CONCAT('Registro afectado ID: ', NEW.id)
    END
  );
  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.auditoria_funcion()
    OWNER TO grupo2;



-- Cada que se inserta un acceso de socio activa al trigger de registrar_acceso_socio

CREATE TRIGGER trigger_registro_acceso
AFTER INSERT ON accesosocio
FOR EACH ROW
EXECUTE FUNCTION public.registrar_acceso_socio();



-- FUNCTION: public.registrar_acceso_socio()

-- DROP FUNCTION IF EXISTS public.registrar_acceso_socio();

CREATE OR REPLACE FUNCTION public.registrar_acceso_socio()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  INSERT INTO Auditoria(tabla_afectada, accion, detalle)
  VALUES ('AccesoSocio', 'ACCESO', CONCAT('Socio ID ', NEW.id, ' accedió al sistema'));
  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.registrar_acceso_socio()
    OWNER TO grupo2;

-- Ejemplo de uso:
-- INSERT INTO accesosocio(socio_id) VALUES (3);



-- Cada que se inserta una reserva de clase activa al trigger de verificar_cupo_reserva

CREATE TRIGGER trigger_verificar_cupo
BEFORE INSERT ON ReservasClase
FOR EACH ROW
EXECUTE FUNCTION public.verificar_cupo_reserva();



-- FUNCTION: public.verificar_cupo_reserva()

-- DROP FUNCTION IF EXISTS public.verificar_cupo_reserva();

CREATE OR REPLACE FUNCTION public.verificar_cupo_reserva()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
  capacidad INT;
  reservas_actuales INT;
BEGIN
  SELECT capacidad INTO capacidad FROM ClasesGrupales WHERE id_clase = NEW.id_clase;

  SELECT COUNT(*) INTO reservas_actuales
  FROM ReservasClase
  WHERE id_clase = NEW.id_clase AND status = true; -- solo cuenta reservas activas

  IF reservas_actuales >= capacidad THEN
    RAISE EXCEPTION 'No hay cupo disponible en esta clase';
  END IF;

  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.verificar_cupo_reserva()
    OWNER TO grupo2;