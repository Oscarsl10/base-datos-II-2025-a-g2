# Manual de Usuario 

## Definición de Tablas SQL

Este documento describe la estructura y propósito de cada tabla definida en el archivo `tables.sql` para el sistema de gestión de gimnasio.

---

## Índice

1. [tiposmembresia](#tiposmembresia)
2. [socios](#socios)
3. [instructores](#instructores)
4. [clasesgrupales](#clasesgrupales)
5. [horariosclase](#horariosclase)
6. [reservasclase](#reservasclase)
7. [equipamiento](#equipamiento)
8. [mantenimientoequipamiento](#mantenimientoequipamiento)
9. [controlacceso](#controlacceso)
10. [pagoscuota](#pagoscuota)
11. [estadospago](#estadospago)
12. [usuarios](#usuarios)
13. [auditoria](#auditoria)
14. [usoequipamiento](#usoequipamiento)
15. [historialmembresia](#historialmembresia)

---

## tiposmembresia

Define los tipos de membresía disponibles.

- **id**: Identificador único (PK)
- **nombre**: Nombre de la membresía
- **precio**: Costo
- **duracion_dias**: Duración en días
- **descripcion**: Descripción opcional
- **status**: Activo/Inactivo

---

## socios

Registra los socios del gimnasio.

- **id**: Identificador único (PK)
- **nombre**: Nombre completo
- **email**: Correo electrónico (único)
- **telefono**: Teléfono
- **fecha_nacimiento**: Fecha de nacimiento
- **fecha_inicio**: Inicio de membresía
- **id_membresia**: FK a `tiposmembresia`
- **status**: Activo/Inactivo
- **fecha_ultima_conexion**: Última conexión

---

## instructores

Información de los instructores.

- **id**: Identificador único (PK)
- **nombre**: Nombre completo
- **especialidad**: Especialidad
- **email**: Correo electrónico (único)
- **telefono**: Teléfono
- **status**: Activo/Inactivo

---

## clasesgrupales

Clases grupales ofrecidas.

- **id**: Identificador único (PK)
- **nombre**: Nombre de la clase
- **descripcion**: Descripción
- **capacidad**: Máximo de participantes
- **id_instructor**: FK a `instructores`
- **status**: Activo/Inactivo

---

## horariosclase

Horarios de las clases grupales.

- **id**: Identificador único (PK)
- **id_clase**: FK a `clasesgrupales`
- **dia_semana**: Día de la semana
- **hora_inicio**: Hora de inicio
- **hora_fin**: Hora de fin
- **status**: Activo/Inactivo

---

## reservasclase

Reservas de clases por los socios.

- **id**: Identificador único (PK)
- **id_socio**: FK a `socios`
- **id_horario**: FK a `horariosclase`
- **fecha**: Fecha de la reserva
- **estado**: Estado de la reserva
- **status**: Activo/Inactivo
- **id_clase**: FK a `clasesgrupales`

---

## equipamiento

Equipos del gimnasio.

- **id**: Identificador único (PK)
- **nombre**: Nombre del equipo
- **descripcion**: Descripción
- **cantidad**: Cantidad disponible
- **estado**: Estado del equipo
- **status**: Activo/Inactivo

---

## mantenimientoequipamiento

Registros de mantenimiento de equipos.

- **id**: Identificador único (PK)
- **id_equipamiento**: FK a `equipamiento`
- **fecha_mantenimiento**: Fecha del mantenimiento
- **descripcion**: Descripción
- **realizado_por**: Responsable
- **status**: Activo/Inactivo

---

## controlacceso

Registros de acceso de los socios.

- **id**: Identificador único (PK)
- **id_socio**: FK a `socios`
- **fecha**: Fecha de acceso
- **hora_entrada**: Hora de entrada
- **hora_salida**: Hora de salida
- **status**: Activo/Inactivo

---

## pagoscuota

Pagos realizados por los socios.

- **id**: Identificador único (PK)
- **id_socio**: FK a `socios`
- **fecha_pago**: Fecha del pago
- **monto**: Monto pagado
- **estados_pago_id**: FK a `estadospago`
- **status**: Activo/Inactivo

---

## estadospago

Estados posibles de los pagos.

- **id**: Identificador único (PK)
- **nombre**: Nombre del estado
- **status**: Activo/Inactivo

---

## usuarios

Usuarios del sistema.

- **id**: Identificador único (PK)
- **username**: Nombre de usuario (único)
- **password**: Contraseña
- **rol**: Rol del usuario
- **status**: Activo/Inactivo

---

## auditoria

Registro de acciones en el sistema.

- **id**: Identificador único (PK)
- **tabla_afectada**: Tabla afectada
- **accion**: Tipo de acción (INSERT, UPDATE, DELETE)
- **fecha**: Fecha y hora
- **detalle**: Detalles adicionales

---

## usoequipamiento

Registro de uso de equipos por los socios.

- **id**: Identificador único (PK)
- **id_socio**: FK a `socios`
- **id_equipamiento**: FK a `equipamiento`
- **fecha**: Fecha de uso
- **hora_inicio**: Hora de inicio
- **hora_fin**: Hora de fin
- **status**: Activo/Inactivo

---

## historialmembresia

Historial de membresías de los socios.

- **id**: Identificador único (PK)
- **id_socio**: FK a `socios`
- **id_membresia**: FK a `tiposmembresia`
- **fecha_inicio**: Inicio de la membresía
- **fecha_fin**: Fin de la membresía
- **status**: Activo/Inactivo

---

> **Nota:**  
> Las claves primarias (PK) garantizan la unicidad de cada registro.  
> Las claves foráneas (FK) aseguran la integridad referencial entre tablas.  
> El campo `status` permite activar/desactivar registros sin eliminarlos físicamente.


---

# Documentación de `indexing.sql`

Este archivo contiene instrucciones SQL para la creación de índices en varias tablas del sistema de gestión de gimnasio. Los índices son estructuras que mejoran la velocidad de las consultas sobre columnas específicas, especialmente cuando se realizan búsquedas frecuentes o se utilizan en condiciones de filtrado (`WHERE`), ordenamiento (`ORDER BY`) o relaciones (`JOIN`).

---

## Índices creados

1. **idx_socio_email**
   - **Tabla:** Socios
   - **Columna:** email
   - **Propósito:** Acelera las búsquedas y validaciones por correo electrónico de los socios, útil para autenticación y verificación de unicidad.

2. **idx_clase_instructor**
   - **Tabla:** ClasesGrupales
   - **Columna:** id_instructor
   - **Propósito:** Optimiza las consultas que buscan todas las clases asignadas a un instructor específico.

3. **idx_reservas_socio**
   - **Tabla:** ReservasClase
   - **Columna:** id_socio
   - **Propósito:** Mejora el rendimiento al consultar todas las reservas realizadas por un socio en particular.

---

## ¿Para qué sirve este archivo?

El archivo `indexing.sql` debe ejecutarse después de crear las tablas principales. Su función es mejorar el rendimiento de la base de datos en operaciones de consulta frecuentes, haciendo que el acceso a los datos sea más rápido y eficiente, especialmente en tablas con muchos registros.

**Recomendación:**  
Utiliza este archivo para mantener la base de datos optimizada, especialmente si esperas un crecimiento considerable en la cantidad de datos o consultas frecuentes sobre las columnas indexadas.


---

# Explicación de las Vistas en `views.sql`

Este archivo define varias vistas (views) en la base de datos del gimnasio. Una vista es una consulta guardada que permite acceder a información relevante de manera sencilla, como si fuera una tabla, pero sin duplicar datos.

A continuación se explica cada vista, su configuración y funcionamiento:

---

## 1. `clasesconcupo`

**Definición:**
```sql
CREATE OR REPLACE VIEW public.clasesconcupo AS
SELECT c.id, c.nombre, c.capacidad, count(r.id) AS reservados
FROM clasesgrupales c
  JOIN horariosclase h ON c.id = h.id_clase
  LEFT JOIN reservasclase r ON r.id_horario = h.id
GROUP BY c.id
HAVING count(r.id) < c.capacidad;
```

**¿Cómo funciona?**
- Muestra las clases grupales (`clasesgrupales`) que tienen cupos disponibles.
- Cuenta cuántas reservas (`reservasclase`) hay por clase.
- Solo muestra las clases donde la cantidad de reservas es menor que la capacidad.

**¿Cómo se configura?**
- Se crea con `CREATE OR REPLACE VIEW`.
- El propietario se asigna con:  
  `ALTER TABLE public.clasesconcupo OWNER TO grupo2;`

---

## 2. `equipospendientesmantenimiento`

**Definición:**
```sql
CREATE OR REPLACE VIEW public.equipospendientesmantenimiento AS
SELECT e.id, e.nombre, max(m.fecha_mantenimiento) AS ultimo_mantenimiento
FROM equipamiento e
  LEFT JOIN mantenimientoequipamiento m ON e.id = m.id_equipamiento
GROUP BY e.id
HAVING (CURRENT_DATE - max(m.fecha_mantenimiento)) > 30;
```

**¿Cómo funciona?**
- Lista los equipos (`equipamiento`) cuyo último mantenimiento fue hace más de 30 días.
- Usa `LEFT JOIN` para incluir todos los equipos, aunque no tengan mantenimiento.
- El campo `ultimo_mantenimiento` muestra la fecha más reciente de mantenimiento.

**¿Cómo se configura?**
- Se crea con `CREATE OR REPLACE VIEW`.
- El propietario se asigna con:  
  `ALTER TABLE public.equipospendientesmantenimiento OWNER TO grupo2;`

---

## 3. `historialacceso`

**Definición:**
```sql
CREATE OR REPLACE VIEW public.historialacceso AS
SELECT s.id AS id_socio, s.nombre, c.fecha, c.hora_entrada, c.hora_salida
FROM socios s
  JOIN controlacceso c ON s.id = c.id_socio;
```

**¿Cómo funciona?**
- Muestra el historial de accesos de los socios.
- Une la tabla de socios con la de control de acceso.
- Permite ver cuándo y a qué hora entró y salió cada socio.

**¿Cómo se configura?**
- Se crea con `CREATE OR REPLACE VIEW`.
- El propietario se asigna con:  
  `ALTER TABLE public.historialacceso OWNER TO grupo2;`

---

## 4. `sociospendientes`

**Definición:**
```sql
CREATE OR REPLACE VIEW public.sociospendientes AS
SELECT s.id, s.nombre, p.fecha_pago, e.nombre AS estado
FROM socios s
  JOIN pagoscuota p ON s.id = p.id_socio
  JOIN estadospago e ON p.estados_pago_id = e.id
WHERE e.nombre::text = 'Pendiente'::text;
```

**¿Cómo funciona?**
- Muestra los socios que tienen pagos pendientes.
- Une socios, pagos y estados de pago.
- Solo muestra los pagos cuyo estado es 'Pendiente'.

**¿Cómo se configura?**
- Se crea con `CREATE OR REPLACE VIEW`.
- El propietario se asigna con:  
  `ALTER TABLE public.sociospendientes OWNER TO grupo2;`

---

## 5. `usorecienteequipamiento`

**Definición:**
```sql
CREATE OR REPLACE VIEW public.usorecienteequipamiento AS
SELECT u.id_equipamiento, e.nombre, u.fecha, u.hora_inicio, u.hora_fin
FROM usoequipamiento u
  JOIN equipamiento e ON u.id_equipamiento = e.id
WHERE u.fecha >= (CURRENT_DATE - '7 days'::interval);
```

**¿Cómo funciona?**
- Muestra el uso de equipamiento en los últimos 7 días.
- Une los registros de uso con los datos del equipo.
- Permite ver qué equipos han sido usados recientemente y por cuánto tiempo.

**¿Cómo se configura?**
- Se crea con `CREATE OR REPLACE VIEW`.
- El propietario se asigna con:  
  `ALTER TABLE public.usorecienteequipamiento OWNER TO grupo2;`

---

## Resumen de configuración

- Cada vista se crea con `CREATE OR REPLACE VIEW`.
- Se asigna el propietario con `ALTER TABLE ... OWNER TO grupo2;` para controlar permisos.
- Las vistas permiten consultar información relevante de manera sencilla y eficiente, facilitando reportes y análisis para la gestión del gimnasio.



---

# Documentación y Explicación de Procedures en `procedures.sql`

Este archivo contiene procedimientos almacenados (procedures) en PostgreSQL para automatizar operaciones comunes en la base de datos del gimnasio. Los procedures permiten ejecutar lógica compleja en el servidor, facilitando la gestión y actualización de datos.

A continuación se explica cada procedure, su configuración y funcionamiento:

---

## 1. `actualizar_clase`

**Definición:**
```sql
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
```
**Función:**  
Actualiza los datos de una clase grupal según el ID recibido.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.actualizar_clase(1, 'Yoga Avanzado', 'Clase de yoga para niveles avanzados', 20, 2);
```

---

## 2. `actualizar_estado_pago`

**Definición:**
```sql
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
```
**Función:**  
Actualiza el estado de un pago, validando que el estado exista.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.actualizar_estado_pago(1, 'Pagado');
```

---

## 3. `actualizar_socio`

**Definición:**
```sql
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
```
**Función:**  
Actualiza los datos básicos de un socio.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.actualizar_socio(1, 'Juan Pérez', 'juan.perez@mail.com', '1234567890');
```

---

## 4. `cancelar_reserva` (eliminación lógica)

**Definición:**
```sql
CREATE OR REPLACE PROCEDURE public.cancelar_reserva(
    IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE ReservasClase SET status = false WHERE id = p_id;
END;
$BODY$;
```
**Función:**  
Cancela una reserva cambiando su estado a inactivo (eliminación lógica).

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.cancelar_reserva(1);
```

---

## 5. `cancelar_reserva` (eliminación física)

**Definición:**
```sql
CREATE OR REPLACE PROCEDURE public.cancelar_reserva(
    IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    DELETE FROM ReservasClase WHERE id = p_id;
END;
$BODY$;
```
**Función:**  
Elimina físicamente una reserva de la base de datos.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.cancelar_reserva(1);
```
> **Nota:** Hay dos versiones de `cancelar_reserva`. Usar la que corresponda según la política de la base de datos.

---

## 6. `eliminar_clase_logicamente`

**Definición:**
```sql
CREATE OR REPLACE PROCEDURE public.eliminar_clase_logicamente(
    IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE ClasesGrupales SET status = FALSE WHERE id = p_id;
END;
$BODY$;
```
**Función:**  
Elimina lógicamente una clase, marcándola como inactiva.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.eliminar_clase_logicamente(1);
```

---

## 7. `eliminar_socio_logicamente`

**Definición:**
```sql
CREATE OR REPLACE PROCEDURE public.eliminar_socio_logicamente(
    IN p_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    UPDATE Socios SET status = FALSE WHERE id = p_id;
END;
$BODY$;
```
**Función:**  
Elimina lógicamente un socio, marcándolo como inactivo.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.eliminar_socio_logicamente(1);
```

---

## 8. `insertar_clase`

**Definición:**
```sql
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
```
**Función:**  
Inserta una nueva clase grupal como activa.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.insertar_clase('Yoga', 'Clase de yoga para principiantes', 15, 1);
```

---

## 9. `insertar_pago`

**Definición:**
```sql
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
```
**Función:**  
Registra un nuevo pago con estado inicial 'Pendiente'.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.insertar_pago(1, '2023-10-01', 50.00);
```

---

## 10. `insertar_reserva`

**Definición:**
```sql
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
```
**Función:**  
Registra una nueva reserva de clase para un socio.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.insertar_reserva(1, 1, '2023-10-01', 'Pendiente', 1);
```

---

## 11. `insertar_socio`

**Definición:**
```sql
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
```
**Función:**  
Registra un nuevo socio como activo.

**Configuración:**  
- Se define con `CREATE OR REPLACE PROCEDURE`.
- El propietario se asigna con `ALTER PROCEDURE ... OWNER TO grupo2;`.

**Uso:**  
```sql
CALL public.insertar_socio('Juan Pérez', 'juanperez@example.com', '3114567890', '1990-05-15', '2025-05-01', 2, '2025-05-19');
```

---

## Notas Generales

- Todos los procedures usan el lenguaje `plpgsql`.
- El propietario de cada procedure es `grupo2`, lo que controla los permisos de ejecución.
- Los procedures automatizan tareas comunes de inserción, actualización y eliminación, mejorando la seguridad y consistencia de la base de datos.



# Documentación y Explicación de Triggers en `triggers.sql`

Este archivo define funciones y triggers en PostgreSQL para automatizar acciones y controles en la base de datos del gimnasio. Los triggers permiten ejecutar código automáticamente cuando ocurren ciertos eventos (INSERT, UPDATE, DELETE) en las tablas.

A continuación se documentan y explican línea por línea las funciones de trigger incluidas:

---

## 1. `auditoria_funcion`

**Propósito:**  
Registrar en la tabla `Auditoria` cualquier cambio (INSERT, UPDATE, DELETE) realizado sobre las tablas donde se asocie este trigger.

**Definición y explicación:**
```sql
CREATE OR REPLACE FUNCTION public.auditoria_funcion()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  INSERT INTO Auditoria(tabla_afectada, accion, detalle)
  VALUES (
    TG_TABLE_NAME, -- Nombre de la tabla afectada por el trigger
    TG_OP,         -- Operación realizada: INSERT, UPDATE o DELETE
    CASE 
      WHEN TG_OP = 'DELETE' THEN CONCAT('Registro eliminado ID: ', OLD.id)
      ELSE CONCAT('Registro afectado ID: ', NEW.id)
    END
  );
  RETURN NEW;
END;
$BODY$;
```
**Línea por línea:**
- `CREATE OR REPLACE FUNCTION public.auditoria_funcion()`: Define la función de trigger.
- `RETURNS trigger`: Indica que la función será usada como trigger.
- `LANGUAGE 'plpgsql'`: Usa el lenguaje procedural de PostgreSQL.
- `BEGIN ... END;`: Bloque principal de la función.
- `INSERT INTO Auditoria(...) VALUES (...)`: Inserta un registro en la tabla de auditoría.
    - `TG_TABLE_NAME`: Variable especial, nombre de la tabla donde ocurre el trigger.
    - `TG_OP`: Variable especial, tipo de operación (INSERT, UPDATE, DELETE).
    - `CASE ... END`: Si la operación es DELETE, concatena el ID del registro eliminado (`OLD.id`). Para INSERT o UPDATE, concatena el ID del registro afectado (`NEW.id`).
- `RETURN NEW;`: Devuelve el nuevo registro (necesario para triggers AFTER INSERT/UPDATE).

**Configuración de propietario:**
```sql
ALTER FUNCTION public.auditoria_funcion() OWNER TO grupo2;
```

---

## 2. `registrar_acceso_socio`

**Propósito:**  
Registrar en la tabla `Auditoria` cada vez que un socio accede al sistema.

**Definición y explicación:**
```sql
CREATE OR REPLACE FUNCTION public.registrar_acceso_socio()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  INSERT INTO Auditoria(tabla_afectada, accion, detalle)
  VALUES (
    'AccesoSocio', -- Nombre lógico para identificar el evento
    'ACCESO',      -- Acción registrada
    CONCAT('Socio ID ', NEW.id, ' accedió al sistema') -- Detalle del acceso
  );
  RETURN NEW;
END;
$BODY$;
```
**Línea por línea:**
- `CREATE OR REPLACE FUNCTION public.registrar_acceso_socio()`: Define la función de trigger.
- `RETURNS trigger`: Será usada como trigger.
- `BEGIN ... END;`: Bloque principal.
- `INSERT INTO Auditoria(...) VALUES (...)`: Inserta un registro de acceso.
    - `'AccesoSocio'`: Nombre de la tabla lógica para identificar el evento.
    - `'ACCESO'`: Acción registrada.
    - `CONCAT('Socio ID ', NEW.id, ' accedió al sistema')`: Mensaje detallando el socio que accedió.
- `RETURN NEW;`: Devuelve el nuevo registro.

**Configuración de propietario:**
```sql
ALTER FUNCTION public.registrar_acceso_socio() OWNER TO grupo2;
```

---

## 3. `verificar_cupo_reserva`

**Propósito:**  
Evitar que se creen reservas en clases que ya alcanzaron su capacidad máxima.

**Definición y explicación:**
```sql
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
```
**Línea por línea:**
- `CREATE OR REPLACE FUNCTION public.verificar_cupo_reserva()`: Define la función de trigger.
- `RETURNS trigger`: Será usada como trigger.
- `DECLARE ...`: Declara variables locales.
    - `capacidad INT;`: Capacidad máxima de la clase.
    - `reservas_actuales INT;`: Número de reservas activas actuales.
- `SELECT capacidad INTO capacidad ...`: Obtiene la capacidad de la clase a partir del ID de la clase en la nueva reserva.
- `SELECT COUNT(*) INTO reservas_actuales ...`: Cuenta cuántas reservas activas existen para esa clase.
- `IF reservas_actuales >= capacidad THEN ...`: Si ya no hay cupos, lanza una excepción y evita la inserción.
- `RETURN NEW;`: Permite la inserción si hay cupo.

**Configuración de propietario:**
```sql
ALTER FUNCTION public.verificar_cupo_reserva() OWNER TO grupo2;
```

---

## ¿Cómo se usan estas funciones?

Estas funciones deben asociarse a triggers en las tablas correspondientes, por ejemplo:
```sql
CREATE TRIGGER trg_auditoria
AFTER INSERT OR UPDATE OR DELETE ON Socios
FOR EACH ROW EXECUTE FUNCTION public.auditoria_funcion();
```
Esto hará que cada vez que se inserte, actualice o elimine un socio, se registre en la auditoría.

---

## Resumen

- **auditoria_funcion:** Registra cualquier cambio en tablas monitoreadas.
- **registrar_acceso_socio:** Registra cada acceso de socio al sistema.
- **verificar_cupo_reserva:** Impide reservas si la clase está llena.

Estas funciones ayudan a mantener la integridad, trazabilidad y control de la base de datos de manera automática.



# Documentación y Explicación Línea por Línea de las Funciones en `functions.sql`

Este archivo contiene funciones en PostgreSQL para consultar y calcular información relevante sobre clases, socios y pagos en el sistema del gimnasio. A continuación se documentan y explican línea por línea las funciones principales:

---

## 1. `cupo_disponible_clase(p_id_clase integer)`

**Propósito:**  
Devuelve el número de cupos disponibles en una clase grupal.

**Código y explicación:**
```sql
CREATE OR REPLACE FUNCTION public.cupo_disponible_clase(
    p_id_clase integer
)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
    capacidad INT;         -- Variable para guardar la capacidad máxima de la clase
    reservados INT;        -- Variable para guardar el número de reservas actuales
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
```
- Se declara la función con un parámetro de entrada: el ID de la clase.
- Se obtienen la capacidad y el número de reservas actuales.
- Se retorna la diferencia, que representa los cupos disponibles.

---

## 2. `contar_asistentes(p_id_clase integer)`

**Propósito:**  
Cuenta cuántos asistentes (reservas) tiene una clase grupal.

**Código y explicación:**
```sql
CREATE OR REPLACE FUNCTION public.contar_asistentes(
    p_id_clase integer
)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
    total_asistentes integer;  -- Variable para el total de asistentes
BEGIN
    SELECT COUNT(*)
    INTO total_asistentes
    FROM ReservasClase r
    JOIN HorariosClase h ON r.id_horario = h.id
    WHERE h.id_clase = p_id_clase;

    RETURN total_asistentes;
END;
$$;
```
- Se cuenta el total de reservas asociadas a los horarios de la clase indicada.
- Se retorna ese total.

---

## 3. `info_socio(id_socio integer)`

**Propósito:**  
Devuelve la información básica de un socio activo.

**Código y explicación:**
```sql
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
```
- Devuelve una tabla con nombre, email y teléfono del socio cuyo ID se pasa como parámetro, solo si está activo.

---

## 4. `proximos_pagos(p_id_socio integer)`

**Propósito:**  
Devuelve los pagos pendientes de un socio ordenados por fecha.

**Código y explicación:**
```sql
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
```
- Selecciona los pagos de un socio cuyo estado es 'Pendiente', ordenados por fecha.

---

## 5. `total_pagos(p_id_socio integer)`

**Propósito:**  
Devuelve el total pagado por un socio (solo pagos con estado 'Pagado').

**Código y explicación:**
```sql
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
```
- Suma los montos de los pagos con estado 'Pagado' para el socio indicado.
- Usa `COALESCE` para devolver 0 si no hay pagos.

---

## 6. `ultimo_pago(p_id_socio integer)`

**Propósito:**  
Devuelve la fecha del último pago realizado por un socio (solo pagos con estado 'Pagado').

**Código y explicación:**
```sql
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
```
- Busca la fecha máxima (`MAX(fecha_pago)`) de los pagos con estado 'Pagado' para el socio indicado.
- Retorna esa fecha o `NULL` si no hay pagos.

---

## Ejemplo de uso de funciones

```sql
-- Consultar cupos disponibles en una clase
SELECT public.cupo_disponible_clase(1);

-- Ver todos los socios y la fecha de su último pago
SELECT id, nombre, ultimo_pago(id) AS fecha_ultimo_pago FROM Socios;
```

---

**Notas:**
- Todas las funciones usan el lenguaje procedural `plpgsql`.
- El propietario de cada función es `grupo2`.
- Estas funciones permiten obtener información clave para la gestión del gimnasio de forma sencilla y eficiente.


# Documentación y Explicación de las Consultas en `consultations.sql`

Este archivo contiene ejemplos de consultas SQL (SELECT) para obtener información relevante del sistema de gestión de gimnasio. Las consultas están organizadas por entidad (membresías, socios, instructores, clases, etc.) y cubren tanto consultas directas como subconsultas.

A continuación se documentan y explican las consultas más importantes y representativas:

---

## CONSULTAS DE MEMBRESÍA

### 1. Obtener todos los tipos de membresía con sus socios
```sql
SELECT tm.nombre, s.nombre AS socio
FROM TiposMembresia tm
INNER JOIN Socios s ON tm.id = s.id_membresia;
```
**Explicación:**  
Muestra el nombre de cada tipo de membresía junto con el nombre de los socios que la tienen asignada. Solo aparecen los tipos de membresía que tienen al menos un socio.

---

### 2. Listar tipos de membresía aunque no tengan socios asignados
```sql
SELECT tm.*, s.nombre AS socio
FROM TiposMembresia tm
LEFT JOIN Socios s ON tm.id = s.id_membresia;
```
**Explicación:**  
Muestra todos los tipos de membresía, incluyendo aquellos que no tienen socios asignados (en ese caso, el campo socio será NULL).

---

### 3. Tipos de membresía que tienen más de 3 socios
```sql
SELECT *
FROM TiposMembresia
WHERE id IN (
    SELECT id_membresia
    FROM Socios
    GROUP BY id_membresia
    HAVING COUNT(*) > 3
);
```
**Explicación:**  
Devuelve los tipos de membresía que han sido asignados a más de 3 socios.

---

### 4. Precio promedio de los tipos de membresía
```sql
SELECT nombre, precio
FROM TiposMembresia
WHERE precio > (
    SELECT AVG(precio) FROM TiposMembresia
);
```
**Explicación:**  
Lista los tipos de membresía cuyo precio es superior al promedio de todos los precios de membresía.

---

## CONSULTAS DE SOCIOS

### 5. Socios con su tipo de membresía
```sql
SELECT s.nombre, tm.nombre AS membresia
FROM Socios s
INNER JOIN TiposMembresia tm ON s.id_membresia = tm.id;
```
**Explicación:**  
Muestra el nombre de cada socio junto con el nombre de su tipo de membresía.

---

### 6. Socios cuya membresía cuesta más de $100
```sql
SELECT *
FROM Socios
WHERE id_membresia IN (
    SELECT id FROM TiposMembresia WHERE precio > 100
);
```
**Explicación:**  
Devuelve los socios que tienen asignada una membresía cuyo precio es mayor a $100.

---

## CONSULTAS DE INSTRUCTORES

### 7. Instructores con las clases que dictan
```sql
SELECT i.nombre AS instructor, c.nombre AS clase
FROM Instructores i
INNER JOIN ClasesGrupales c ON i.id = c.id_instructor;
```
**Explicación:**  
Muestra el nombre de cada instructor junto con el nombre de las clases grupales que dicta.

---

### 8. Instructores que dictan más de una clase
```sql
SELECT *
FROM Instructores
WHERE id IN (
    SELECT id_instructor
    FROM ClasesGrupales
    GROUP BY id_instructor
    HAVING COUNT(*) > 1
);
```
**Explicación:**  
Devuelve los instructores que están asignados a más de una clase grupal.

---

## CONSULTAS DE CLASES GRUPALES

### 9. Clases con nombre del instructor
```sql
SELECT c.nombre AS clase, i.nombre AS instructor
FROM ClasesGrupales c
INNER JOIN Instructores i ON c.id_instructor = i.id;
```
**Explicación:**  
Muestra el nombre de cada clase grupal junto con el nombre del instructor responsable.

---

### 10. Clases con instructores especializados en "Yoga"
```sql
SELECT *
FROM ClasesGrupales
WHERE id_instructor IN (
    SELECT id FROM Instructores WHERE especialidad = 'Yoga'
);
```
**Explicación:**  
Devuelve las clases grupales que son dictadas por instructores cuya especialidad es "Yoga".

---

## CONSULTAS DE RESERVAS DE CLASES

### 11. Reservas con nombre del socio y horario
```sql
SELECT r.id, s.nombre AS socio, h.dia_semana
FROM ReservasClase r
INNER JOIN Socios s ON r.id_socio = s.id
INNER JOIN HorariosClase h ON r.id_horario = h.id;
```
**Explicación:**  
Muestra el ID de la reserva, el nombre del socio y el día de la semana del horario reservado.

---

### 12. Reservas hechas por socios con membresía activa
```sql
SELECT *
FROM ReservasClase
WHERE id_socio IN (
    SELECT id FROM Socios WHERE status = TRUE
);
```
**Explicación:**  
Devuelve todas las reservas realizadas por socios que actualmente están activos.

---

## CONSULTAS DE EQUIPAMIENTO

### 13. Equipos con sus mantenimientos realizados
```sql
SELECT e.nombre AS equipo, m.fecha_mantenimiento
FROM Equipamiento e
INNER JOIN MantenimientoEquipamiento m ON e.id = m.id_equipamiento;
```
**Explicación:**  
Muestra el nombre de cada equipo junto con la fecha de cada mantenimiento realizado.

---

### 14. Equipos que han sido usados por algún socio
```sql
SELECT *
FROM Equipamiento
WHERE id IN (
    SELECT id_equipamiento FROM UsoEquipamiento
);
```
**Explicación:**  
Devuelve los equipos que han sido registrados como usados al menos una vez.

---

## CONSULTAS DE PAGOS DE CUOTAS

### 15. Pagos con nombre del socio
```sql
SELECT p.*, s.nombre
FROM PagosCuota p
INNER JOIN Socios s ON p.id_socio = s.id;
```
**Explicación:**  
Muestra todos los pagos realizados, incluyendo el nombre del socio que los realizó.

---

### 16. Pagos realizados este mes
```sql
SELECT *
FROM PagosCuota
WHERE fecha_pago >= date_trunc('month', CURRENT_DATE);
```
**Explicación:**  
Devuelve todos los pagos realizados desde el inicio del mes actual.

---

## CONSULTAS DE AUDITORÍA

### 17. Registros de auditoría por tabla
```sql
SELECT tabla_afectada, COUNT(*) AS total
FROM Auditoria
GROUP BY tabla_afectada;
```
**Explicación:**  
Muestra cuántos registros de auditoría existen para cada tabla afectada.

---

### 18. Última acción registrada
```sql
SELECT *
FROM Auditoria
WHERE fecha = (
    SELECT MAX(fecha) FROM Auditoria
);
```
**Explicación:**  
Devuelve el registro de auditoría más reciente.

---

## CONSULTAS DE USO DE EQUIPAMIENTO

### 19. Uso de equipos con nombre del socio y nombre del equipo
```sql
SELECT u.*, s.nombre AS socio, e.nombre AS equipo
FROM UsoEquipamiento u
INNER JOIN Socios s ON u.id_socio = s.id
INNER JOIN Equipamiento e ON u.id_equipamiento = e.id;
```
**Explicación:**  
Muestra cada uso de equipamiento, indicando qué socio lo usó y qué equipo fue.

---

## CONSULTAS DE HISTORIAL DE MEMBRESÍA

### 20. Historial de membresía con nombre del socio y nombre del tipo
```sql
SELECT h.*, s.nombre AS socio, t.nombre AS membresia
FROM HistorialMembresia h
INNER JOIN Socios s ON h.id_socio = s.id
INNER JOIN TiposMembresia t ON h.id_membresia = t.id;
```
**Explicación:**  
Muestra el historial de membresías de los socios, incluyendo el nombre del socio y el tipo de membresía.

---

## Resumen

- Las consultas permiten obtener información clave para la gestión y análisis del gimnasio.
- Se utilizan distintos tipos de JOIN y subconsultas para cubrir diferentes necesidades de reporte.
- Puedes adaptar estas consultas según los requerimientos específicos de tu sistema.



# Documentación y Explicación Línea por Línea de los CTEs en `CTEs.sql`

Este archivo contiene ejemplos de consultas SQL que utilizan CTEs (Common Table Expressions, o Expresiones de Tabla Común) para estructurar y simplificar consultas complejas. Los CTEs permiten definir resultados intermedios reutilizables dentro de una misma consulta.

A continuación se explica línea por línea cada CTE y cómo se configura:

---

## 1. CTE: Cupos Disponibles por Clase Grupal

**Propósito:**  
Calcular la cantidad de cupos disponibles para cada clase grupal.

**Código y explicación:**
```sql
-- CUPOS DISPONIBLES.

-- Esta consulta devuelve la cantidad de cupos disponibles para cada clase grupal.

WITH CuposDisponibles AS (                    -- Define el CTE llamado CuposDisponibles
  SELECT c.id AS id_clase,                    -- Selecciona el ID de la clase grupal
         c.capacidad,                         -- Selecciona la capacidad máxima de la clase
         COUNT(r.id) AS reservados            -- Cuenta cuántas reservas existen para la clase
  FROM ClasesGrupales c
  JOIN HorariosClase h ON c.id = h.id_clase   -- Une con los horarios de la clase
  LEFT JOIN ReservasClase r ON h.id = r.id_horario -- Une (incluso si no hay reservas) con las reservas de ese horario
  GROUP BY c.id                               -- Agrupa por clase para contar reservas por clase
)
SELECT id_clase, capacidad - reservados AS cupos_disponibles -- Calcula los cupos disponibles restando reservas a la capacidad
FROM CuposDisponibles;
```

**Funcionamiento:**
- El CTE `CuposDisponibles` calcula, para cada clase, cuántos cupos están ocupados (`reservados`).
- La consulta final resta el número de reservas a la capacidad para obtener los cupos disponibles por clase.

**Configuración:**
- El CTE se define con la cláusula `WITH`.
- Se puede usar el resultado del CTE en la consulta principal como si fuera una tabla temporal.

---

## 2. CTE: Socios Activos

**Propósito:**  
Obtener la cantidad de socios activos en el sistema.

**Código y explicación:**
```sql
-- SOCIOS ACTIVOS.

-- Esta consulta devuelve la cantidad de socios activos en el sistema.

WITH SociosActivos AS (                   -- Define el CTE llamado SociosActivos
  SELECT id FROM Socios WHERE status = TRUE -- Selecciona los IDs de los socios cuyo estado es activo
)
SELECT COUNT(*) FROM SociosActivos;       -- Cuenta cuántos socios activos hay
```

**Funcionamiento:**
- El CTE `SociosActivos` selecciona todos los socios que están activos (`status = TRUE`).
- La consulta principal cuenta cuántos socios activos existen.

**Configuración:**
- El CTE se define con la cláusula `WITH`.
- El resultado del CTE se utiliza en la consulta principal para realizar el conteo.

---

## ¿Cómo se configuran y usan los CTEs?

- Se definen al inicio de la consulta con la palabra clave `WITH`.
- Pueden definirse varios CTEs separados por comas.
- El resultado del CTE se usa en la consulta principal como si fuera una tabla.
- Son útiles para dividir consultas complejas en pasos lógicos y reutilizables.

---

**Resumen:**  
Los CTEs permiten estructurar consultas complejas de manera clara y reutilizable, facilitando el mantenimiento y la comprensión del código SQL.



# Documentación y Explicación de Roles y Permisos en `roles.sql`

Este archivo define la creación de usuarios, roles y la asignación de permisos en la base de datos del gimnasio. El objetivo es controlar el acceso y las acciones que cada tipo de usuario puede realizar, garantizando la seguridad y la correcta administración de los datos.

---

## 1. ADMINISTRADOR GIMNASIO

```sql
CREATE USER admin WITH PASSWORD 'admin123';
CREATE ROLE admin_gimnasio;
GRANT admin_gimnasio TO admin;
GRANT CONNECT ON DATABASE gimnasio TO admin_gimnasio;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_gimnasio;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_gimnasio;
```

**¿Cómo funciona?**
- Se crea el usuario `admin` con contraseña.
- Se crea el rol `admin_gimnasio`.
- Se asigna el rol al usuario.
- Se otorga permiso para conectarse a la base de datos.
- Se otorgan todos los privilegios sobre todas las tablas y secuencias del esquema `public`.
- **El administrador puede hacer cualquier operación en la base de datos.**

---

## 2. RECEPCIONISTA

```sql
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
```

**¿Cómo funciona?**
- Se crea el usuario y el rol para el recepcionista.
- Se otorga conexión a la base de datos.
- Puede consultar, insertar y actualizar datos de socios, pagos, control de acceso, reservas y el historial de membresía.
- Puede usar y actualizar los contadores automáticos (secuencias) relacionados.
- **El recepcionista puede gestionar la operación diaria, pero no eliminar registros ni modificar otras tablas.**

---

## 3. SOCIO

```sql
CREATE USER socio WITH PASSWORD 'socio123';
CREATE ROLE socio_role;
GRANT socio_role TO socio;
GRANT CONNECT ON DATABASE gimnasio TO socio_role;

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
```

**¿Cómo funciona?**
- Se crea el usuario y el rol para el socio.
- Puede conectarse a la base de datos.
- Puede ver e insertar sus propias reservas y registros de acceso.
- Puede consultar los tipos de membresía y sus propios pagos.
- Puede usar las secuencias necesarias para crear reservas y registros de acceso.
- **El socio solo puede ver y registrar su propia información, no puede modificar datos de otros ni acceder a información sensible.**

---

## 4. INSTRUCTOR

```sql
CREATE USER instructor WITH PASSWORD 'instructor123';
CREATE ROLE instructor_role;
GRANT instructor_role TO instructor;
GRANT CONNECT ON DATABASE gimnasio TO instructor_role;

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
```

**¿Cómo funciona?**
- Se crea el usuario y el rol para el instructor.
- Puede conectarse a la base de datos.
- Puede consultar información sobre clases, horarios, socios, reservas y uso de equipamiento.
- Puede consultar las secuencias relacionadas.
- **El instructor solo tiene permisos de lectura, útil para consultar listas de clases, horarios y asistencia.**

---

## 5. AUDITOR

```sql
CREATE USER auditor WITH PASSWORD 'auditor123';
CREATE ROLE auditor_role;
GRANT auditor_role TO auditor;
GRANT CONNECT ON DATABASE gimnasio TO auditor_role;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO auditor_role;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO auditor_role;
```

**¿Cómo funciona?**
- Se crea el usuario y el rol para el auditor.
- Puede conectarse a la base de datos.
- Tiene permisos de solo lectura sobre todas las tablas y secuencias del esquema `public`.
- **El auditor puede revisar toda la información, pero no puede modificar nada.**

---

## Resumen de funcionamiento

- **Usuarios y roles**: Se crean usuarios y roles separados para cada tipo de perfil.
- **Asignación de roles**: Cada usuario recibe su rol correspondiente.
- **Permisos**: Se otorgan permisos específicos a cada rol, limitando el acceso según las funciones del usuario.
- **Secuencias**: Los roles que insertan datos reciben permisos sobre las secuencias necesarias para generar nuevos IDs.
- **Seguridad**: Esta configuración asegura que cada usuario solo pueda realizar las acciones necesarias para su función, protegiendo la integridad y confidencialidad de la base de datos.

---

**Nota:**  
Las contraseñas y nombres de usuario aquí son de ejemplo. En producción, usa contraseñas seguras y personaliza los nombres según tu política de seguridad.


# Documentación y Explicación Línea por Línea del Caso de Estudio: Popularidad de Clases e Instructores

Este caso de estudio implementa funciones para analizar la popularidad de las clases grupales y de los instructores en el gimnasio, basándose en la cantidad de reservas realizadas. A continuación se explica cada función y cada línea de código.

---

## 1. Función: `analizar_popularidad_clases`

### Propósito
Devuelve una tabla con todas las clases grupales, el instructor responsable y el total de reservas de cada clase, ordenadas de la más popular a la menos popular.

### Código y Explicación

```sql
-- FUNCTION: public.analizar_popularidad_clases()

-- DROP FUNCTION IF EXISTS public.analizar_popularidad_clases();

CREATE OR REPLACE FUNCTION public.analizar_popularidad_clases()
    RETURNS TABLE(
        clase_id integer,
        clase_nombre character varying,
        instructor_id integer,
        instructor_nombre character varying,
        total_reservas bigint
    ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
      c.id,                -- ID de la clase grupal
      c.nombre,            -- Nombre de la clase grupal
      i.id,                -- ID del instructor
      i.nombre,            -- Nombre del instructor
      COUNT(r.id)          -- Total de reservas asociadas a la clase
    FROM ClasesGrupales c
    JOIN Instructores i   ON c.id_instructor = i.id
    LEFT JOIN HorariosClase h ON h.id_clase     = c.id
    LEFT JOIN ReservasClase r ON r.id_horario   = h.id
    GROUP BY c.id, c.nombre, i.id, i.nombre
    ORDER BY COUNT(r.id) DESC; -- Ordena de mayor a menor popularidad
END;
$BODY$;

ALTER FUNCTION public.analizar_popularidad_clases()
    OWNER TO grupo2;
```

#### Línea por línea

- `CREATE OR REPLACE FUNCTION ...`: Define o reemplaza la función.
- `RETURNS TABLE(...)`: Especifica las columnas que devolverá la función.
- `LANGUAGE 'plpgsql'`: Usa el lenguaje procedural de PostgreSQL.
- `COST 100`, `VOLATILE PARALLEL UNSAFE`, `ROWS 1000`: Opciones de optimización y paralelismo.
- `BEGIN ... END;`: Bloque principal de la función.
- `RETURN QUERY`: Indica que la función devolverá el resultado de la consulta siguiente.
- `SELECT ...`: Consulta que obtiene:
  - `c.id`, `c.nombre`: ID y nombre de la clase.
  - `i.id`, `i.nombre`: ID y nombre del instructor.
  - `COUNT(r.id)`: Cuenta cuántas reservas tiene la clase.
- `FROM ClasesGrupales c`: Tabla principal de clases grupales.
- `JOIN Instructores i ON c.id_instructor = i.id`: Une cada clase con su instructor.
- `LEFT JOIN HorariosClase h ON h.id_clase = c.id`: Une con los horarios de la clase (puede no haber horarios).
- `LEFT JOIN ReservasClase r ON r.id_horario = h.id`: Une con las reservas de cada horario (puede no haber reservas).
- `GROUP BY c.id, c.nombre, i.id, i.nombre`: Agrupa por clase e instructor para contar reservas.
- `ORDER BY COUNT(r.id) DESC`: Ordena de mayor a menor número de reservas.
- `ALTER FUNCTION ... OWNER TO grupo2;`: Asigna el propietario de la función.

**Ejemplo de uso:**
```sql
SELECT * FROM public.analizar_popularidad_clases();
```

---

## 2. Función: `analizar_popularidad_instructores`

### Propósito
Devuelve una tabla con todos los instructores y el total de reservas de todas las clases que dictan, ordenados del más popular al menos popular.

### Código y Explicación

```sql
-- FUNCTION: public.analizar_popularidad_instructores()

-- DROP FUNCTION IF EXISTS public.analizar_popularidad_instructores();

CREATE OR REPLACE FUNCTION public.analizar_popularidad_instructores()
    RETURNS TABLE(
        instructor_id integer,
        instructor_nombre character varying,
        total_reservas bigint
    ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
      i.id,                -- ID del instructor
      i.nombre,            -- Nombre del instructor
      COUNT(r.id)          -- Total de reservas en todas sus clases
    FROM Instructores i
    JOIN ClasesGrupales c     ON c.id_instructor = i.id
    LEFT JOIN HorariosClase h ON h.id_clase      = c.id
    LEFT JOIN ReservasClase r ON r.id_horario    = h.id
    GROUP BY i.id, i.nombre
    ORDER BY COUNT(r.id) DESC; -- Ordena de mayor a menor popularidad
END;
$BODY$;

ALTER FUNCTION public.analizar_popularidad_instructores()
    OWNER TO grupo2;
```

#### Línea por línea

- `CREATE OR REPLACE FUNCTION ...`: Define o reemplaza la función.
- `RETURNS TABLE(...)`: Especifica las columnas que devolverá la función.
- `LANGUAGE 'plpgsql'`: Usa el lenguaje procedural de PostgreSQL.
- `COST 100`, `VOLATILE PARALLEL UNSAFE`, `ROWS 1000`: Opciones de optimización y paralelismo.
- `BEGIN ... END;`: Bloque principal de la función.
- `RETURN QUERY`: Indica que la función devolverá el resultado de la consulta siguiente.
- `SELECT ...`: Consulta que obtiene:
  - `i.id`, `i.nombre`: ID y nombre del instructor.
  - `COUNT(r.id)`: Cuenta cuántas reservas tienen todas las clases dictadas por el instructor.
- `FROM Instructores i`: Tabla principal de instructores.
- `JOIN ClasesGrupales c ON c.id_instructor = i.id`: Une cada instructor con sus clases.
- `LEFT JOIN HorariosClase h ON h.id_clase = c.id`: Une con los horarios de cada clase.
- `LEFT JOIN ReservasClase r ON r.id_horario = h.id`: Une con las reservas de cada horario.
- `GROUP BY i.id, i.nombre`: Agrupa por instructor para contar reservas.
- `ORDER BY COUNT(r.id) DESC`: Ordena de mayor a menor número de reservas.
- `ALTER FUNCTION ... OWNER TO grupo2;`: Asigna el propietario de la función.

**Ejemplo de uso:**
```sql
SELECT * FROM public.analizar_popularidad_instructores();
```

---

## Resumen

- Ambas funciones permiten analizar la popularidad de clases e instructores según la cantidad de reservas.
- Utilizan `LEFT JOIN` para contar correctamente incluso si hay clases o instructores sin reservas.
- El resultado es útil para reportes de gestión, toma de decisiones y estrategias de programación de clases.

---