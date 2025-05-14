-- CUPOS DISPONIBLES.

-- Esta consulta devuelve la cantidad de cupos disponibles para cada clase grupal.

WITH CuposDisponibles AS (
  SELECT c.id AS id_clase, c.capacidad, COUNT(r.id) AS reservados
  FROM ClasesGrupales c
  JOIN HorariosClase h ON c.id = h.id_clase
  LEFT JOIN ReservasClase r ON h.id = r.id_horario
  GROUP BY c.id
)
SELECT id_clase, capacidad - reservados AS cupos_disponibles
FROM CuposDisponibles;


-- SOCIOS ACTIVOS.

-- Esta consulta devuelve la cantidad de socios activos en el sistema.

WITH SociosActivos AS (
  SELECT id FROM Socios WHERE status = TRUE
)
SELECT COUNT(*) FROM SociosActivos;